import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;

class SetExplosiveValueDelegate extends WatchUi.Menu2InputDelegate {

    private var ME;
    private var _key;
    private var explosiveData = {
        "Quantity"=>"0",
        "Weight"=> "0",
    };

    function initialize(Key as String, ME as ManageExplosives, Weight as String) {
        self.ME = ME;
        self._key = Key;
        explosiveData["Weight"] = Weight;
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem) as Void {
        var chosenOption = item.getLabel();
        if (chosenOption.equals("Done")){
            ME.addToCurrentExplosives([_key,"Q: "+explosiveData.get("Quantity")+" | W: "+explosiveData.get("Weight")], explosiveData);
            WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
            ME.createExplosiveList();
            return;
        }
        WatchUi.pushView(new $.NumberPicker(chosenOption, chosenOption.equals("Weight") ? true : false, _key, 1), new $.ModifySettingsValuesDelegate(chosenOption, self, item, '.'), WatchUi.SLIDE_IMMEDIATE);
    }

    public function setValues(Key as String, Value as String){
        explosiveData[Key] = Value;
    }
    public function onBack() as Void {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
    }
}