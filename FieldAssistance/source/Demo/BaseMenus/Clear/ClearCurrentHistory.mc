import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class ClearCurrentHistory {

    private var _HistoryKey = "_FA_HistoryEXPData";

    public function clearHistoryData(){
        var options = [
            ["Yes","Permanent"],
            ["No",""]
        ];
        CreateMenu.developNewMenu(options, "Clear History", new ClearCurrentHistoryDelegate());
    }

}

class ClearCurrentHistoryDelegate extends WatchUi.Menu2InputDelegate {
    private var _HistoryKey = "_FA_HistoryEXPData";

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("Yes")){
            Storage.deleteValue(_HistoryKey);
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return;
    }

}