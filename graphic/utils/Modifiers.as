package graphic.utils {

	/**
	 * ...
	 * @author Locke
	 */
	public class Modifiers {
		public static const CHANGHE:String = "change"; //
		public static const CUSTOM:String = "custom";

		public function Modifiers(){

		}

		public static function Launch(def:*):* {
			switch (def.Modifiers.mod){
				case CHANGHE:
					if (def.Modifiers.variable is String && def[def.Modifiers.variable] != undefined)
						def[def.Modifiers.variable] = MOD_CHANGE(def[def.Modifiers.variable], def.Modifiers.data);
					else if (def.Modifiers.parsent[def.Modifiers.variable] != undefined)
						def.Modifiers.parsent[def.Modifiers.variable] = MOD_CHANGE(def.Modifiers.parsent[def.Modifiers.variable], def.Modifiers.data);
					break;
				case CUSTOM:
					if(def.Modifiers.data.length==0)
						def.Modifiers.data();
					else if(def.Modifiers.data.length==1){def.Modifiers.data(def.Modifiers.parsent);}
					break;
			}
			return def;
		}

		private static function MOD_CHANGE(def_value:*, data:Array):* {
			return (Chack(def_value, data[0])) ? data[1] : data[0];
		}

		private static function Chack(value:*, data:*):Boolean {
			var ins:String;
			for (ins in data){
				if (value[ins] != data[ins])
					return false;
			}
			return true;
		}

	}

}

