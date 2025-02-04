import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;

class NewFuzeMenu {
    public function ViewMenu(){
        var options = [
           ["Fuze Length","00:00"],
           ["Burn Rate", "00"],
           ["Calculate",""],
           ["Discard",""]
        ];
        CreateMenu.developNewMenu(options, "Fuze Menu", new NewFuzeMenuDelegate());
    }
}

class NewFuzeMenuDelegate extends WatchUi.Menu2InputDelegate{
    var options = [
        ["Fuze Length","00:00"],
        ["Burn Rate", "00"],
        ["Calculate",""],
        ["Discard",""]
    ];
    private var calcs = {
       "Fuze_length"=>"00:00",
        "Fuze_Burn_Rate"=>"1",
    };

    function MinutesToSeconds() as Number{
        var StringSplit = calcs["Fuze_length"].toCharArray();
        var Minutes  = (StringSplit[0] +""+StringSplit[1]).toNumber();
        var Seconds = (StringSplit[3] +""+StringSplit[4]).toNumber();
        return (Minutes * 60) + Seconds;
    }

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals(options[0][0])){
            WatchUi.pushView(new $.NumberPicker(chosenOption, false, "", 2), new $.ModifySettingsValuesDelegate("Fuze_length", self, item, ':'), WatchUi.SLIDE_IMMEDIATE);
        }else if (chosenOption.equals(options[1][0])){
            WatchUi.pushView(new $.NumberPicker(chosenOption, false, "", 3), new $.ModifySettingsValuesDelegate("Fuze_Burn_Rate", self, item, ""), WatchUi.SLIDE_IMMEDIATE);
        }else if (chosenOption.equals(options[2][0])){
            var FeetResult = MinutesToSeconds().toFloat()/(calcs["Fuze_Burn_Rate"].toFloat());
            var InchesResult = Globals.SplitStringAtSeparator(FeetResult.toString(), '.')[1].substring(0,2).toFloat()/12;
            var PartialInchesResult = Globals.SplitStringAtSeparator(InchesResult.toString(), '.')[1].substring(0,2).toFloat()/16;
            var options = [
                ["Fuze Time", calcs["Fuze_length"]],
                ["Fuze Length Feet",Lang.format("$1$", [FeetResult.toNumber()])],
                ["Fuze Length Inches", Lang.format("$1$ and $2$/16", [InchesResult.toNumber(), PartialInchesResult.toNumber()])],
                ["Save", "Save to history"],
                ["Discard", ""],
                // ["Settings", "Modify Settings"]
            ];
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            CreateMenu.developNewMenu(options, "Time Fuze", new AddToFuzeHistory(calcs["Fuze_length"], Lang.format("$1$' $2$ $3$/16\"", [FeetResult.toNumber(), InchesResult.toNumber(), PartialInchesResult.toNumber()])));
        }else{
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        }
    }

    function setValues(_key, InputNumber){
        calcs[_key] = InputNumber;
    }
}