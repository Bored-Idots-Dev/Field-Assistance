import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class SettingsViewer {

    public function ViewSettings(){
        var options = [
            ["REF Config","Modify REF values"],
            ["K Config","Modify K Factors"],
            ["Default Weights", "Modify Default Weights"],
            ["Reset Settings","Permanent"]
        ];
        CreateMenu.developNewMenu(options, "Settings", new SettingsDelagate());
    }

}

class SettingsDelagate extends WatchUi.Menu2InputDelegate {

    private function modifyRefs(){
        var savedREFS = Storage.getValue("_FA_CustomSavedREFS");
        if (savedREFS == null){ savedREFS = Globals._DEFAULT_REFS; }
        var Categories = [
            [
                "C4", Globals.FormatNumbers(savedREFS["C4"]["REF"], true).toString()
            ],
            [
                "M1 Dynomite", Globals.FormatNumbers(savedREFS["M1 Dynomite"]["REF"], true).toString() 
            ],
            [
                "TNT", Globals.FormatNumbers(savedREFS["TNT"]["REF"], true).toString()
            ],
            [
                "RDX (Blasting Cap)", Globals.FormatNumbers(savedREFS["RDX (Blasting Cap)"]["REF"], true).toString()
            ],
            [
                "PETN (Det Cord)", Globals.FormatNumbers(savedREFS["PETN (Det Cord)"]["REF"], true).toString()
            ]
        ];
        CreateMenu.developNewMenu(Categories, "Modify Refs", new ModifySettingsDel(true, savedREFS));
    }

    private function modifyStandOffs(){
        var savedStandOffs = Storage.getValue("_FA_CustomSavedStandOffs");
        if (savedStandOffs == null){ savedStandOffs = Globals._DEFAULT_STANDOFFS;  }
        var Categories = [
           [ "SS",Globals.FormatNumbers(savedStandOffs["SS"], true).toString()],
            ["US",Globals.FormatNumbers(savedStandOffs["US"], true).toString()],
            ["SF",Globals.FormatNumbers(savedStandOffs["SF"], true).toString()],
        ];
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        CreateMenu.developNewMenu(Categories, "Modify Stand Offs", new ModifySettingsDel(false, savedStandOffs));
    }

    private function modifyWeights(){
        var savedWeights = Storage.getValue("_FA_CustomExplosive_Weights");
        if (savedWeights == null){ savedWeights = Globals._DEFAULT_WEIGHTS; }
        var Categories = [
            [
                "C4", Globals.FormatNumbers(savedWeights["C4"], true).toString()
            ],
            [
                "M1 Dynomite", Globals.FormatNumbers(savedWeights["M1 Dynomite"], true).toString() 
            ],
            [
                "TNT", Globals.FormatNumbers(savedWeights["TNT"], true).toString()
            ],
            [
                "RDX (Blasting Cap)", Globals.FormatNumbers(savedWeights["RDX (Blasting Cap)"], true).toString()
            ],
            [
                "PETN (Det Cord)", Globals.FormatNumbers(savedWeights["PETN (Det Cord)"], true).toString()
            ]
        ];
        CreateMenu.developNewMenu(Categories, "Modify Weights", new ModifySettingsDel(false, savedWeights));
    }

    private function resetSettings(){
        Storage.setValue("_FA_CustomSavedREFS", null);
        Storage.setValue("_FA_CustomSavedStandOffs", null);
        Storage.setValue("_FA_CustomExplosive_Weights", null);
        return;
    }

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("REF Config")){
            modifyRefs();
        }else if (chosenOption.equals("K Config")){
            modifyStandOffs();
        }else if (chosenOption.equals("Reset Settings")){
            resetSettings();
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }else if (chosenOption.equals("Default Weights")){
            modifyWeights();
        }
        return;
    }

}