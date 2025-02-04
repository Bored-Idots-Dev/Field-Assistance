import Toybox.Lang;
import Toybox.WatchUi;

class FieldAssistanceDelegate extends WatchUi.BehaviorDelegate {

    private var MenuHiarchey = [
        ["Demo", "Create Explosives"],
        ["Fuze", "Time Fuze Magic"]
    ];

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        return pushDemoList();
    }

    public function onKey(evt as KeyEvent) as Boolean{
        var key = evt.getKey();
        if((WatchUi.KEY_START == key) || (WatchUi.KEY_ENTER == key)){
            return pushDemoList();
        }
        return false;
    }

    public function pushDemoList() as Boolean{
        CreateMenu.developNewMenu(MenuHiarchey, "Main Menu", new MainMenuDelegate());
        return true;
    }
}

class MainMenuDelegate extends WatchUi.Menu2InputDelegate {
    
    function initialize() {
        Menu2InputDelegate.initialize();
    }
    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("Demo")){// Demo
            var options = [
                ["New","Create Explsovie"],
                ["History", "View history"],
                ["Clear", "Clear history"],
                ["Settings", "Modify Settings"]
            ];
            CreateMenu.developNewMenu(options, "Demo", new CreateMenuDelegate());
        }else
        if (chosenOption.equals("Fuze")){
            var options = [
                ["New","Calculate Time Fuze"],
                ["History", "View history"],
                ["Clear", "Clear history"],
                // ["Settings", "Modify Settings"]
            ];
            CreateMenu.developNewMenu(options, "Time Fuze", new FuzeMainMenuDelegate());
        }
        return;
    }
}