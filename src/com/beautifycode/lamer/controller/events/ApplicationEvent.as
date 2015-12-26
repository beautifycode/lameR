package com.beautifycode.lamer.controller.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class ApplicationEvent extends Event {
		public static const BOOT : String = "boot";
		public static const PREFERENCES_SET : String = "preferencesSet";
		public static const CLOSE : String = "close";
		public static const PREFERENCES_SAVED_BEFORE_CLOSE : String = "preferencesSavedBeforeClose";

		public var payload : Object;

		public function ApplicationEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var clonedEvent:ApplicationEvent = new ApplicationEvent(type, bubbles, cancelable);
			if(this.payload) clonedEvent.payload = this.payload;

			return clonedEvent;
		}
	}
}
