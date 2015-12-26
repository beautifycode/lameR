package com.beautifycode.lamer.controller.events {
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class UserEvent extends Event {
		public static const SET_INPUTFILE : String = "selectFile";

		public static const CHANGE_INPUTFILE : String = "inputfilepathChanged";
		public static const CHANGE_OUTPUTFILE : String = "outfilepathChanged";
		public static const CHANGE_QUALITY : String = "setQuality";
		public static const START_CONVERSION : String = "startConversion";		
		
		public var payload : Object;

		public function UserEvent(type : String, bubbles : Boolean = false, cancelable : Boolean = false) {
			super(type, bubbles, cancelable);
		}

		override public function clone() : Event {
			var clonedEvent:UserEvent = new UserEvent(type, bubbles, cancelable);
			if(this.payload) clonedEvent.payload = this.payload;

			return clonedEvent;
		}
	}
}
