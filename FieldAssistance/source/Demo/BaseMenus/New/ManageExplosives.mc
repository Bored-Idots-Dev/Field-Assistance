import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.StringUtil;
import Toybox.Graphics;
import Toybox.Application.Storage;

class ManageExplosives {


    private const MenuHiarchey = [
        ["C4","lbs"],
        ["TNT", "lbs"],
        ["M1 Dynomite", "lbs"],
        ["PETN (Det Cord)", "ft/Grains"],
        ["RDX (Blasting Cap)","Grains"]
    ];

    private var currentExplosives = [
        ["Add",""],
        ["Done",""],
        ["Discard",""]
    ];

    private var currentSetExplosiveValues = [];

    private var explsoiveSettings = [
        ["Quantity",""],
        ["Weight",""],
        ["Done",""]
    ];

    public function createExplosiveList(){
        CreateMenu.developNewMenu(currentExplosives, "Current Explosives", new AddExplosiveDelegate(self));
    }

    public function createExplsovieOptions(){
        CreateMenu.developNewMenu(MenuHiarchey, "Chose Explosive", new CreateExplosivesDelegate(self));
    }

    public function setExplosiveValues(ExplosiveType as String){
        var savedWeights = Storage.getValue("_FA_CustomExplosive_Weights");
        if (savedWeights == null){ savedWeights = Globals._DEFAULT_WEIGHTS; }
        var usedExplsoiveSettings = explsoiveSettings;
        var FormatedString = Globals.FormatNumbers(savedWeights[ExplosiveType], true);
        usedExplsoiveSettings[1][1] = FormatedString;
        CreateMenu.developNewMenu(usedExplsoiveSettings, ExplosiveType, new SetExplosiveValueDelegate(ExplosiveType, self, FormatedString));
    }

    public function addToCurrentExplosives(newExplsoiveToAdd as Array<String>, explosiveData as Dictionary){
        var newExplosivesList = [currentExplosives.size() + 1];
        newExplosivesList[0] = [ newExplsoiveToAdd[0], newExplsoiveToAdd[1]];
        for(var i = 0; i < currentExplosives.size(); i ++){
            newExplosivesList.add(currentExplosives[i]);
        }
        currentExplosives = newExplosivesList;

        var newCurrentExplosiveData = [currentSetExplosiveValues.size() + 1];
        newCurrentExplosiveData[0] = [ newExplsoiveToAdd[0], explosiveData.get("Quantity"),explosiveData.get("Weight") ];
        for(var i = 0; i < currentSetExplosiveValues.size(); i ++){
            newCurrentExplosiveData.add(currentSetExplosiveValues[i]);
        }
        currentSetExplosiveValues = newCurrentExplosiveData;
    }

    public function resetCurrentExplosiveCharge(){
        currentExplosives = [
        ["Add",""],
        ["Done",""],
        ["Discard",""]
        ];
        currentSetExplosiveValues=[];
    }

    public function Calculate(){
        var savedREFS = Storage.getValue("_FA_CustomSavedREFS");
        var savedStandOffs = Storage.getValue("_FA_CustomSavedStandOffs");
        if (savedREFS != null){
            Globals._DEFAULT_REFS = savedREFS;
        }
        if (savedStandOffs != null){
            Globals._DEFAULT_STANDOFFS = savedStandOffs;
        }
        var explosiveData = [
            ["NEW",""],
            ["Shielded Standoff",""],
            ["Unshielded Standoff",""],
            ["Safe Frag",""],
            ["Done","Saved to History"]
        ];
        var grain = 0;
        var calNew = 0;
        for (var i=0; i < currentSetExplosiveValues.size(); i ++){
            var selEXP  = currentSetExplosiveValues[i];
            selEXP[1] = Globals.tdp(selEXP[1].toDouble()).format("%.2f").toDouble();
            selEXP[2] = Globals.tdp(selEXP[2].toDouble()).format("%.2f").toDouble();
            if (Globals._DEFAULT_REFS.get(selEXP[0]) == null){
                continue;
            }
            if (Globals._DEFAULT_REFS.get(selEXP[0]).get("Grain") == 1){
                grain += Globals.tdp(selEXP[1].toDouble() * selEXP[2].toDouble() * (Globals._DEFAULT_REFS.get(selEXP[0]).get("REF") )).format("%.2f").toDouble();
                continue;
            }
            calNew += Globals.tdp(selEXP[1].toDouble() * selEXP[2].toDouble() * (Globals._DEFAULT_REFS.get(selEXP[0]).get("REF") )).format("%.2f").toDouble();
        }
        grain = grain/7000;
        calNew += grain;

        if (calNew <=0){
            resetCurrentExplosiveCharge();
            return;
        }

        calNew = Globals.tdp(calNew.toFloat()).format("%.2f");
        var cbrtNEW = Globals.tdp(cbrt(calNew.toFloat() as Float)).format("%.2f").toFloat();
        explosiveData[0][1] = calNew+" lbs";
        explosiveData[1][1] = Math.ceil(cbrtNEW * Globals._DEFAULT_STANDOFFS.get("SS")).toNumber() +" ft";
        explosiveData[2][1] = Math.ceil(cbrtNEW * Globals._DEFAULT_STANDOFFS.get("US")).toNumber() +" ft";
        explosiveData[3][1] = Math.ceil(cbrtNEW * Globals._DEFAULT_STANDOFFS.get("SF")).toNumber() +" ft";
        CreateMenu.developNewMenu(explosiveData, "Results", new ExplosiveResultsDelegate(explosiveData));
        resetCurrentExplosiveCharge();
    }

    public function cbrt(Find as Float) as Float? {
        var precision = 0.0001; // Default precision
        var isNegative = (Find < 0);
        Find = isNegative ? -Find : Find;

        // Initialize guess for the cube root
        var guess = Find / 2.0;

        while (true) {
        // Use the Newton-Raphson method to approximate the cube root
        var nextGuess = (2 * guess + Find / (guess * guess)) / 3.0;
        // Check if the approximation is within the desired precision
            if (((nextGuess - guess) < 0 ? -(nextGuess - guess) : (nextGuess - guess)) < precision) {  break; }
            guess = nextGuess;
        }   
        return isNegative ? -guess.toFloat() : guess.toFloat();
    }



}