import Toybox.WatchUi;
import Toybox.Lang;
import Toybox.Graphics;
import Toybox.Application.Storage;

class ModifySettingsDel extends WatchUi.Menu2InputDelegate{
    private var isRef;
    private var SettingsData;
    public var ButtonID;
    function initialize(isRef as Boolean, SettingsData as Dictionary) {
        self.isRef = isRef;
        self.SettingsData = SettingsData;
        Menu2InputDelegate.initialize();
    }

    function onMenu() as Boolean {
        return true;
    }

    public function onSelect(item as MenuItem){
        var chosenOption = item.getLabel();
        self.ButtonID = chosenOption;
        WatchUi.pushView(new $.NumberPicker(chosenOption, false, "", 1), new $.ModifySettingsValuesDelegate(isRef ? "_FA_CustomSavedREFS" : "_FA_CustomSavedStandOffs", self, item, '.'), WatchUi.SLIDE_IMMEDIATE);
    }
    public function setValues(Key as String, Value as String){
        if(self.isRef){
            self.SettingsData[self.ButtonID]["REF"] = Value.toNumber();
        }else{
            self.SettingsData[self.ButtonID] = Value.toNumber();
        }
        Storage.setValue(Key, SettingsData);
        return;
    }
}