import Toybox.Lang;
import Toybox.StringUtil;
import Toybox.Math;

class Globals{

    public static function tdp(value as Float) as Float {
        return Math.floor(value * 100)/100;
    }    
    
    public static function FormatNumbers(number, returnAsString){
        var stringFormat = self.tdp(number.toFloat()).format("%.2f").toString();
        while (stringFormat.length() < 6){
            stringFormat = "0"+stringFormat;
        }
        return returnAsString ? StringUtil.charArrayToString(stringFormat.toCharArray()) : stringFormat.toCharArray();
    }

    public static function SplitStringAtSeparator(valueToSplit, Separator){
        var SplitString = valueToSplit.toString().toCharArray();
        var LeftHalf = "";
        var RightHalf = "";
        var Swapped = false;
        for (var i =0; i < SplitString.size(); i ++){
            if(SplitString[i].equals(Separator)){
                Swapped = true;
                continue;
            }
            if(Swapped){ RightHalf += SplitString[i] + "";} else {LeftHalf += SplitString[i] + "";}
        } 
        return[LeftHalf, RightHalf];
    }

    public static var _DEFAULT_REFS = {
        "C4"=>{
            "REF"=>1.37,
            "Grain"=> 0,
        },
        "M1 Dynomite"=>{//Dynomite
            "REF"=>0.92,
            "Grain"=> 0, 
        },
        "TNT"=>{
            "REF"=>1,
            "Grain"=> 0, 
        },
        "RDX (Blasting Cap)"=>{
            "REF"=>1.46,
            "Grain"=> 1, 
        },
        "PETN (Det Cord)"=>{
            "REF"=>1.27,
            "Grain"=> 1, 
        },
    };

    public static var _DEFAULT_STANDOFFS = {
        "SS"=>24,
        "US"=>40,
        "SF"=>328
    };

    public static var _DEFAULT_WEIGHTS = {
        "C4"=>1.25,
        "M1 Dynomite"=>0.5,
        "TNT"=>1,
        "RDX (Blasting Cap)"=>13.50,
        "PETN (Det Cord)"=>50,
    };
}
    
