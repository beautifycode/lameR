package com.beautifycode.lamer.controller.events {
	import flash.events.Event;
	/**
	 * @author marvin
	 */
	public class ConversionEvent extends Event {
		public static const FILEPATH_SET : String = "filePathSet";
		public static const START : String = "start";
		public static const PROGRESS : String = "progress";
		public static const FINISHED : String = "finished";
		public static const STREAM_CLOSED : String = "streamClosed";
		public var payload : Object;

		public function ConversionEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var clonedEvent : ConversionEvent = new ConversionEvent(type, bubbles, cancelable);
			if(this.payload) clonedEvent.payload = this.payload;
			return clonedEvent;
		}
	}
}
