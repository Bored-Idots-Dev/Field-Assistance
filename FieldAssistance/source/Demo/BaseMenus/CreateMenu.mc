import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class CreateMenu {

    public static function developNewMenu(Options as Array<Array<String>>, MenuTitle as String, delegate as Menu2InputDelegate) as Boolean{
        var newMenu2 = new WatchUi.Menu2({:title => MenuTitle});
        for (var i =0; i < Options.size(); i ++){
            newMenu2.addItem(
                new MenuItem(
                Options[i][0],
                Options[i][1],
                MenuTitle+"_"+i+"_"+Options[i],
                {}
                )
            );
        }        
        WatchUi.pushView(newMenu2, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;
    }

}

class CreateMenuDelegate extends WatchUi.Menu2InputDelegate {

    private var ME = new ManageExplosives();

    function initialize() {
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("New")) {
            ME.createExplosiveList();
        }else if (chosenOption.equals("History")){
            var historyHandler = new HistoryViewer();
            historyHandler.viewHistory();
        }else if (chosenOption.equals("Clear")){
            var cHH = new ClearCurrentHistory();
            cHH.clearHistoryData();
        }else if (chosenOption.equals("Settings")){
            var stt = new SettingsViewer();
            stt.ViewSettings();
        }
    }

    
}