import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class FuzeMainMenuDelegate extends WatchUi.Menu2InputDelegate{

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("New")){
            new NewFuzeMenu().ViewMenu();
        }else if (chosenOption.equals("History")){
            new FuzeHistoryViewer().viewHistory();
        }else if (chosenOption.equals("Clear")){
             Storage.setValue("_FA_HistoryFuzeData", [{},{},{},{},{},{},{},{},{},{}]);
        }
    }

}