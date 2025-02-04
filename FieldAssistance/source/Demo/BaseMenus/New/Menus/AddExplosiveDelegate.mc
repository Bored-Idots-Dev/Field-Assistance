import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;

class AddExplosiveDelegate extends WatchUi.Menu2InputDelegate {

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
        if (chosenOption.equals("Add")){
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ME.createExplsovieOptions();
        }else if (chosenOption.equals("Done")){
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ME.Calculate();
        }else if(chosenOption.equals("Discard")){
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ME.resetCurrentExplosiveCharge();
        }else{

        }
    }
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        ME.resetCurrentExplosiveCharge();
    }
}