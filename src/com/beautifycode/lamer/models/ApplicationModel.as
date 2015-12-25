package com.beautifycode.lamer.models {
	/**
	 * @author marvin
	 */
	public class ApplicationModel {
		public static const LAMELIB_PATH : String = "";
		public static const SETTINGS_PATH : String = "";
		public static const APP_WIDTH : int;
		public static const APP_HEIGHT : int;
		public static const LICENSE : uint;
		private var _debugMode : String = "native";

		public function get debugMode() : String {
			return _debugMode;
		}
	}
}
