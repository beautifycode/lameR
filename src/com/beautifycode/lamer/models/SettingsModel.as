package com.beautifycode.lamer.models {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class SettingsModel {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		
		private var _inputFilePath : String;
		private var _quality : uint = 192;
		private var _outputFilePath : String;
		private var _eqActive : Boolean;
		private var _compressorActive : Boolean;
		private var _autoUpload : Boolean;
		private var _uploadAPIPath : String;
		private var _sameDirConversion : Boolean;
		private var _conversionEvent : ConversionEvent;

		public function get quality() : uint {
			return _quality;
		}

		public function set quality(quality : uint) : void {
			_quality = quality;
		}

		public function get userFilePath() : String {
			return _inputFilePath;
		}

		public function set userFilePath(path : String) : void {
			_inputFilePath = path;
			Debug.log("ConversionModel.userFilePath: " + path);

			_conversionEvent = new ConversionEvent(ConversionEvent.FILEPATH_SET, true, false);
			eventDispatcher.dispatchEvent(_conversionEvent);
		}
	}
}
