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

		// Essential
		private var _inputFilePath : String = "";
		private var _quality : uint = 192;
		private var _outputFilePath : String = "";
		private var _sameDirConversion : Boolean = true;

		private var _eqActive : Boolean;
		private var _compressorActive : Boolean;
		private var _autoUpload : Boolean;
		private var _uploadAPIPath : String;
		private var _conversionEvent : ConversionEvent;
		private var _availableQualities : Array;

		public function get inputFilePath() : String {
			return _inputFilePath;
		}

		public function set inputFilePath(p : String) : void {
			Debug.log("SettingsModel.inputFilePath: " + p);
			_inputFilePath = p;
		}

		public function get outputFilePath() : String {
			return _outputFilePath;
		}

		public function set outputFilePath(p : String) : void {
			_sameDirConversion = false;
			Debug.log("SettingsModel.outputFilePath - orig: " + p);
			
			var cp:String = p.split('.')[0] + ".mp3";
			Debug.log("SettingsModel.outputFilePath - clean: " + cp);
			_outputFilePath = cp;
		}

		public function get sameDirConversion() : Boolean {
			return _sameDirConversion;
		}

		public function get availableQualities() : Array {
			return _availableQualities;
		}

		public function set availableQualities(availableQualities : Array) : void {
			_availableQualities = availableQualities;
		}

		public function get quality() : uint {
			return _quality;
		}

		public function set quality(q : uint) : void {
			Debug.log("SettingsModel.quality: " + q);
			_quality = q;
		}
	}
}
