import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;

class CreateExplosivesDelegate extends WatchUi.Menu2InputDelegate {

    private var ME;

    function initialize(ME as ManageExplosives) {
        self.ME = ME;
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        ME.setExplosiveValues(chosenOption);
    }

    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        ME.createExplosiveList();
    }
}