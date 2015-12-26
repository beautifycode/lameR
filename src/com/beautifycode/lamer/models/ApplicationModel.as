package com.beautifycode.lamer.models {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ApplicationEvent;

	import flash.display.NativeWindow;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.FileFilter;

	/**
	 * @author marvin
	 */
	public class ApplicationModel {
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		public static const LAMELIB_PATH : String = "";
		public static const SETTINGS_PATH : String = "";
		public static const APP_WIDTH : int;
		public static const APP_HEIGHT : int;
		public static const LICENSE : uint;

		private var _debugMode : String = "native";
		private var _fileFilter : FileFilter = new FileFilter("Audiofile", "*.wav;*.mp3");
		private var _validFileTypes : Object = {wav:true, mp3:true};
		private var _stageSizeObject : Object = {x:0, y:0, w:640, h:400};

		private var _window : NativeWindow;

		public function setupNativeWindow(w : NativeWindow) : void {
			_window = w;
			_stageSizeObject.x = _window.bounds.x;
			_stageSizeObject.y = _window.bounds.y;
			_stageSizeObject.h = _window.bounds.height;
			_stageSizeObject.w = _window.bounds.width;
			_window.addEventListener(Event.CLOSING, _onWindowClose);
		}

		private function _onWindowClose(event : Event) : void {
			Debug.log("SettingsModel - _onWindowClose");
			event.preventDefault();
			eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.CLOSE, true, false));
		}

		public function get debugMode() : String {
			return _debugMode;
		}

		public function get fileFilter() : FileFilter {
			return _fileFilter;
		}

		public function get validFileTypes() : Object {
			return _validFileTypes;
		}

		public function get stageSizeObject() : Object {
			return _stageSizeObject;
		}

		public function set stageSizeObject(stageSizeObject : Object) : void {
			_stageSizeObject = stageSizeObject;
		}

		public function closeApplication() : void {
			Debug.log("Saved & Close");
			_window.close();
		}
	}
}
