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

		public static const ERROR_CODE : int = -1;
		private var _state : String;
		private var _progress : int;
		private var _conversionEvent : ConversionEvent;

		public function set state(s : String) : void {
			if (s && _state != s) {
				Debug.log("ConversionModel.state: " + s);
				_conversionEvent = new ConversionEvent(s, true, false);
				eventDispatcher.dispatchEvent(_conversionEvent);
				_state = s;
			}
		}

		public function get state() : String {
			return _state;
		}

		public function set progress(p : int) : void {

			if (p && _progress != p && p >= 0) {
				_progress = p;
				Debug.log("ConversionModel.progress: " + p);
				eventDispatcher.dispatchEvent(_conversionEvent);
			}

			// @TODO: Check if real error or just missing meta
			if (_progress == ConversionModel.ERROR_CODE) {
				// state = ConversionEvent.ERROR;
				Debug.log("No progress parsed");
				return;
			}

			if (_progress == 100) {
				state = ConversionEvent.FINISHED;
			}
		}

		public function get progress() : int {
			return _progress;
		}
	}
}
