package com.beautifycode.lamer.controller.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class UserEvent extends Event {
		public static const SELECT_FILE : String = "selectFile";
		public var payload : Object;

		public function UserEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var clonedEvent = new UserEvent(type, bubbles, cancelable);
			if(this.payload) clonedEvent.payload = this.payload;

			return clonedEvent;
		}
	}
}
