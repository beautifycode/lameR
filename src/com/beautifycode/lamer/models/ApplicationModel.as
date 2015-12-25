package com.beautifycode.lamer.models {
	import flash.net.FileFilter;
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
		private var _fileFilter : FileFilter = new FileFilter("Audiofile", "*.wav;*.mp3");
		private var _validFileTypes : Object = {wav:true, mp3:true};
		


		public function get debugMode() : String {
			return _debugMode;
		}

		public function get fileFilter() : FileFilter {
			return _fileFilter;
		}

		public function get validFileTypes() : Object {
			return _validFileTypes;
		}
	}
}
