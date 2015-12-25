package com.beautifycode.lamer.models {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class ConversionModel {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		private var _userFilePath : String;
		private var _state : String;
		private var _progress : int;
		private var _conversionEvent : ConversionEvent;

		public function get userFilePath() : String {
			return _userFilePath;
		}

		public function set userFilePath(path : String) : void {
			_userFilePath = path;
			Debug.log("ConversionModel.userFilePath: " + path);

			_conversionEvent = new ConversionEvent(ConversionEvent.FILEPATH_SET, true, false);
			eventDispatcher.dispatchEvent(_conversionEvent);
		}

		public function get state() : String {
			return _state;
		}

		public function set state(s : String) : void {
			if (s && _state != s) {
				Debug.log("ConversionModel.state: " + s);
				_conversionEvent = new ConversionEvent(s, true, false);
				_state = s;
			}
		}

		public function get progress() : int {
			return _progress;
		}

		public function set progress(p : int) : void {
			Debug.log("ConversionModel.progress: " + p);

			if (_progress != p) {
				_progress = p;
				_conversionEvent.payload = {"conversionProgress":p};
			}

			if (_progress == 100) {
				state = ConversionEvent.FINISHED;
				eventDispatcher.dispatchEvent(_conversionEvent);
			}
		}
	}
}
