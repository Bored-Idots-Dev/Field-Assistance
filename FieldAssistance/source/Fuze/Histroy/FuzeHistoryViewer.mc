import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;
using Toybox.Time.Gregorian as Calendar;
import Toybox.System;

class FuzeHistoryViewer {

    private var _HistoryKey = "_FA_HistoryFuzeData";

    public function viewHistory(){
        var historyOfFuzeData = [{},{},{},{},{},{},{},{},{},{}];
        if (Storage.getValue(_HistoryKey) != null){
            historyOfFuzeData = Storage.getValue(_HistoryKey);
        }

        var loadedData = [];
        var viewAbleData = {};

        for (var i=0; i < historyOfFuzeData.size(); i ++){
            var selHis = historyOfFuzeData[i] as Dictionary;
            if (selHis.isEmpty() or selHis == null){
                continue;
            }
            loadedData.add([selHis.get("Key"), "Length: "+selHis.get("Length")]);
            viewAbleData[selHis.get("Key")] = [
                ["Length", selHis.get("Length")],
                ["Time", selHis.get("Time")],
            ];
        }
        CreateMenu.developNewMenu(loadedData, "History", new HistoryDelegate(viewAbleData));
    }
}

class AddToFuzeHistory extends WatchUi.Menu2InputDelegate{

    private var _HistoryKey = "_FA_HistoryFuzeData";
    private var FTime, Length;

    function initialize(FTime, Length) {
        self.FTime = FTime;
        self.Length = Length;
        Menu2InputDelegate.initialize();
    }
    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("Save")){
            var historyOfFuzeData = [{},{},{},{},{},{},{},{},{},{}];
            if (Storage.getValue(_HistoryKey) != null){ historyOfFuzeData = Storage.getValue(_HistoryKey); }
            for(var i = historyOfFuzeData.size() - 1; i > 0 ; i --){ historyOfFuzeData[i] = historyOfFuzeData[i - 1];}
            var date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
            var key =  Lang.format("$1$-$2$-$3$ $4$:$5$", [date.day, date.month,date.year, date.hour, date.min]);
            historyOfFuzeData[0] = {
                "Key"=>key,
                "Length"=>Length,
                "Time"=>FTime,
            };
            Storage.setValue(_HistoryKey, historyOfFuzeData);
        } else if (chosenOption.equals("Clear")) {
             Storage.setValue(_HistoryKey, [{},{},{},{},{},{},{},{},{},{}]);
        }
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}