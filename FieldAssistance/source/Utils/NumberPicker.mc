import Toybox.Application.Storage;
import Toybox.Graphics;
import Toybox.Lang;
using Toybox.WatchUi;

class NumberPicker extends WatchUi.Picker {

    function ExplosiveCalculation(title as WatchUi.Text, isExplosive as Boolean, ExplosiveName as String){
        var UsedWeights;
        var SelectedWeight = [0,0,0,0,0,0];
        if (isExplosive){
            UsedWeights = Storage.getValue("_FA_CustomExplosive_Weights") != null ? Storage.getValue("_FA_CustomExplosive_Weights") : Globals._DEFAULT_WEIGHTS;
            SelectedWeight = Globals.FormatNumbers(UsedWeights[ExplosiveName], false);
        }
        var Separator = new WatchUi.Text(
            {
                :text=>$.Rez.Strings.Separator, 
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, 
                :color=>Graphics.COLOR_WHITE
            }
        );
        Picker.initialize(
            {
                :title=>title, 
                :pattern=>[
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                    Separator,
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                ],        
                :defaults =>[
                    SelectedWeight[0].toString().toNumber(),
                    SelectedWeight[1].toString().toNumber(),
                    SelectedWeight[2].toString().toNumber(),
                    0,
                    SelectedWeight[4].toString().toNumber(),
                    SelectedWeight[5].toString().toNumber(),
                ],        
            }
        );
    }

    function WholeNumberCalculator(title as WatchUi.Text){
        Picker.initialize(
            {
                :title=>title, 
                :pattern=>[
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                ],             
            }
        );
    }

    function TimeCalculator(title as WatchUi.Text){
        var Separator = new WatchUi.Text(
            {
                :text=>$.Rez.Strings.timeSearator, 
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, 
                :color=>Graphics.COLOR_WHITE
            }
        );
        Picker.initialize(
            {
                :title=>title, 
                :pattern=>[
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                    Separator,
                    new $.NumberFactory(0,9,1,{}),
                    new $.NumberFactory(0,9,1,{}),
                ],             
            }
        );
    }

     public function initialize(titleText as String, isExplosive as Boolean, ExplosiveName as String, Category as Number){
        var title = new WatchUi.Text(
            {
                :text=>titleText, 
                :locX=>WatchUi.LAYOUT_HALIGN_CENTER,
                :locY=>WatchUi.LAYOUT_VALIGN_BOTTOM, 
                :color=>Graphics.COLOR_WHITE
            }
        );
        switch(Category){
            case 1: ExplosiveCalculation(title,  isExplosive, ExplosiveName); break;
            case 2: TimeCalculator(title); break;
            case 3: WholeNumberCalculator(title); break;
        }
    }
}

class ModifySettingsValuesDelegate extends WatchUi.PickerDelegate{
        private var PreDelegate;
        private var _key;
        private var item;
        private var Separator;
    //! Constructor
    public function initialize( key as String, PreDelegate, item, Separator) {
        self.PreDelegate = PreDelegate;
        self._key = key;
        self.item = item;
        self.Separator = Separator;
        PickerDelegate.initialize();
    }

    //! Handle a cancel event from the picker
    //! @return true if handled, false otherwise
    public function onCancel() as Boolean {
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
    
    //! Handle a confirm event from the picker
    //! @param values The values chosen in the picker
    //! @return true if handled, false otherwise
    public function onAccept(values as Array) as Boolean {
        
        var calWeight = "";
        for(var i =0; i < values.size(); i ++){
            if (values[i] == null){
                calWeight += Separator;
                continue;
            }
            calWeight += values[i] as String + "";
        }
        PreDelegate.setValues(_key, calWeight);
        item.setSubLabel(calWeight);
        WatchUi.popView(WatchUi.SLIDE_IMMEDIATE);
        return true;
    }
}