package com.beautifycode.lamer.models {
	import flash.events.IEventDispatcher;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;

	/**
	 * @author marvin
	 */
	public class ConversionModel {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		public static const START : String = "start";
		public static const PROGRESS : String = "progress";
		public static const FINISHED : String = "finished";
		private var _state : String;
		private var _progress : int;
		private var _conversionEvent : ConversionEvent;

		public function get progress() : int {
			return _progress;
		}

		public function set progress(p : int) : void {
			Debug.log("Conversion progress: " + p);

			if (_progress != p) {
				_progress = p;
				_conversionEvent.payload = {"conversionProgress":p};
			}

			Debug.log(_progress);
			if (_progress == 100) {
				Debug.log("Conversion finished.");
//				state = FINISHED;
//				eventDispatcher.dispatchEvent(_conversionEvent);
			}
		}

		public function get state() : String {
			return _state;
		}

		public function set state(state : String) : void {
			_state = state;
			if (_state != state) _conversionEvent = new ConversionEvent(state, true, false);
		}
	}
}
