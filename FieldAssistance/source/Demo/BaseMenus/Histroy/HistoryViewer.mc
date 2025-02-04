import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class HistoryViewer {

    private var _HistoryKey = "_FA_HistoryEXPData";

    public function viewHistory(){
        var historyOfEXPData = [{},{},{},{},{},{},{},{},{},{}];
        if (Storage.getValue(_HistoryKey) != null){
            historyOfEXPData = Storage.getValue(_HistoryKey);
        }

        var loadedData = [];
        var viewAbleData = {};

        for (var i=0; i < historyOfEXPData.size(); i ++){
            var selHis = historyOfEXPData[i] as Dictionary;
            if (selHis.isEmpty() or selHis == null){
                continue;
            }
            loadedData.add([selHis.get("Key"), "NEW: "+selHis.get("NEW")]);
            viewAbleData[selHis.get("Key")] = [
                ["NEW", selHis.get("NEW")],
                ["Shielded Standoff", selHis.get("Shielded Standoff")],
                ["Unshielded Standoff", selHis.get("Unshielded Standoff")],
                ["Safe Frag", selHis.get("Safe Frag")],
            ];
        }
        CreateMenu.developNewMenu(loadedData, "History", new HistoryDelegate(viewAbleData));
    }

}

class HistoryDelegate extends WatchUi.Menu2InputDelegate {

    private var HistoryItems;

    function initialize(HistoryItems) {
        self.HistoryItems = HistoryItems;
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        var data = HistoryItems.get(chosenOption);
        CreateMenu.developNewMenu(data, chosenOption, new Menu2InputDelegate());
    }

}