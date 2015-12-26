package com.beautifycode.helpers {
	import com.demonsters.debugger.MonsterDebugger;

	import flash.net.URLRequest;
	import flash.net.navigateToURL;
	import flash.utils.getTimer;

	/**
	 * @author beautifycode
	 */
	public class Debug {
		public static function Dtrace(param : *) : void {
			var pattern : RegExp = /at.*[^)](\/.*())/gim;
			try {
				throw new Error();
			} catch (e : Error) {
				var result : String = e.getStackTrace().match(pattern)[1];
				trace(param + " (was called from: " + result.replace(pattern, "$1") + ")");
			}
		}

		public static function alert(content : *) : void {
			var _req : URLRequest = new URLRequest();
			_req.url = "javascript:alert('" + content + "')";
			navigateToURL(_req, "_self");
		}

		public static function dump(element : *, src2 : String = "") : void {
			trace(_dump(element));
			MonsterDebugger.log(_dump(element));
			trace("----------------");
		}

		public static function log(str : *, str2 : * = "") : void {
			MonsterDebugger.log(str);
			var t : Number = Math.round((getTimer() / 1000) * 10) / 10;
			if (str2) {
				trace(t + "s: " + str2 + " | " + str);
				MonsterDebugger.log(t + "s: " + str2 + " | " + str);
			} else {
				trace(t + "s: " + str);
			}
		}

		private static function _dump(element : *, depth : int = 1) : String {
			var alert : String = "";
			for (var key:String in element) {
				if (element.numChildren > 0) {
					depth++;
					alert += _dump(element, depth) + "\n";
					depth--;
				} else if (typeof element[key] == "object") {
					alert += _space(depth) + key + "\n";
					depth++;
					alert += _dump(element[key], depth) + "\n";
					depth--;
				} else {
					alert += _space(depth) + key + ": " + element[key] + "\n";
				}
			}
			return alert;
		}

		// private static function _childs(element : *, depth : int = 1) : String {
		// var alert : String = "";
		// for (var i : int = 0;i < element.numChildren;i++) {
		// alert += _dump(element.getChildAt(i), depth) + "\n";
		// }
		// return alert;
		// }
		private static function _space(depth : int = 1) : String {
			var space : String = '';
			for (var i : int = 1;i < depth;i++) {
				space += '  ';
			}
			return space;
		}
	}
}