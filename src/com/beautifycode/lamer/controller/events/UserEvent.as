package com.beautifycode.lamer.controller.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class UserEvent extends Event {
		public static const SELECT_FILE : String = "selectFile";

		public function UserEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			return new UserEvent(type, bubbles, cancelable);
		}
	}
}
