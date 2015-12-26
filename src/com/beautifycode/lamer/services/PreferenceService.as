package com.beautifycode.lamer.services {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.ConversionLookupMap;
	import com.beautifycode.lamer.controller.events.ApplicationEvent;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class PreferenceService {
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var settingsModel : SettingsModel;

		private var _req : URLRequest;
		private var _urlLoader : URLLoader;
		private var _decodedObject : Object;
		private var _fileStream : FileStream;
		private var _preferenceFile : File;

		public function loadPreferences(ip : String = "") : void {
			_req = new URLRequest();
			_req.url = File.applicationDirectory.resolvePath(SettingsModel.CONFIG_NAME).nativePath;
			_req.url = SettingsModel.CONFIG_NAME;

			_req.requestHeaders = [new URLRequestHeader("Content-Type", "application/json")];
			_req.method = URLRequestMethod.GET;

			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, _onPreferencesLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _ioError);
			_urlLoader.load(_req);

			if (ip) settingsModel.inputFilePath = ip;
		}

		private function _ioError(event : IOErrorEvent) : void {
			Debug.log(event);
		}

		private function _onPreferencesLoaded(event : Event) : void {
			_decodedObject = JSON.parse(event.target.data);

			// @TODO: Load from cfg
			settingsModel.availableQualities = [{"label":"Easy", "val":ConversionLookupMap.LOW_QUALITY_KBPS}, {"label":"Med", "val":ConversionLookupMap.MED_QUALITY_KBPS}, {"label":"High", "val":ConversionLookupMap.HIGH_QUALITY_KBPS}];
			settingsModel.quality = _decodedObject.client.quality;

			// Artificial loading screen delay
			setTimeout(function() {
				eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.PREFERENCES_SET, true, false));
			}, 3000);
		}

		public function savePreferences() : void {
			_preferenceFile = new File(File.applicationDirectory.resolvePath(SettingsModel.CONFIG_NAME).nativePath);
			_fileStream = new FileStream();
			_fileStream.open(_preferenceFile, FileMode.WRITE);
			
			// @TODO: Actually, do some work
			_decodedObject.client.quality = settingsModel.quality;
			var _updatedSettingsObjAsString:String = _createStringFromSettings();
			
			_fileStream.writeUTFBytes(_updatedSettingsObjAsString);
			_fileStream.close();
			
			eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.PREFERENCES_SAVED_BEFORE_CLOSE, true, false));
		}

		private function _createStringFromSettings() : String {
			var s:String = JSON.stringify(_decodedObject);
			return s;
		}
	}
}
