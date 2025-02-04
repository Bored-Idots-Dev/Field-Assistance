import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;
using Toybox.Time.Gregorian as Calendar;
import Toybox.System;

class ExplosiveResultsDelegate extends WatchUi.Menu2InputDelegate {

    private var MRED;

    private var _HistoryKey = "_FA_HistoryEXPData";

    function initialize(MRED) {
        self.MRED = MRED;
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("Done")){
            var historyOfEXPData = [{},{},{},{},{},{},{},{},{},{}];
            if (Storage.getValue(_HistoryKey) != null){
                historyOfEXPData = Storage.getValue(_HistoryKey);
            }
            for(var i = historyOfEXPData.size() - 1; i > 0 ; i --){
                historyOfEXPData[i] = historyOfEXPData[i - 1];
            }
            var date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
            var key =  Lang.format("$1$-$2$-$3$ $4$:$5$", [date.day, date.month,date.year, date.hour, date.min]);
            historyOfEXPData[0] = {
                "Key"=>key,
                "NEW"=>MRED[0][1],
                "Shielded Standoff" => MRED[1][1],
                "Unshielded Standoff" => MRED[2][1],
                "Safe Frag" => MRED[3][1]
            };
            Storage.setValue(_HistoryKey, historyOfEXPData);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            return;
        }
    }
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}