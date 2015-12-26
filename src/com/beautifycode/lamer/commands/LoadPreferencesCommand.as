package com.beautifycode.lamer.commands {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.ConversionLookupMap;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.filesystem.File;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class LoadPreferencesCommand extends AsyncCommand {
		[Inject]
		public var settingsModel : SettingsModel;

		[Inject]
		public var p : Object;

		protected var _artificalDelay:int = 1000;

		private var _req : URLRequest;
		private var _urlLoader : URLLoader;
		private var _decodedObject : Object;

		override public function execute() : void {
			Debug.log("LoadPreferencesCommand - init.");
			_req = new URLRequest();
			_req.url = File.applicationDirectory.resolvePath(SettingsModel.CONFIG_NAME).nativePath;
			_req.url = SettingsModel.CONFIG_NAME;

			_req.requestHeaders = [new URLRequestHeader("Content-Type", "application/json")];
			_req.method = URLRequestMethod.GET;

			_urlLoader = new URLLoader();
			_urlLoader.addEventListener(Event.COMPLETE, _onPreferencesLoaded);
			_urlLoader.addEventListener(IOErrorEvent.IO_ERROR, _ioError);
			_urlLoader.load(_req);
			
			if (p.bootWithPath) settingsModel.inputFilePath = p.bootWithPath;
		}

		private function _ioError(event : IOErrorEvent) : void {
			Debug.log(event);
			dispatchComplete(false);
		}

		private function _onPreferencesLoaded(event : Event) : void {
			_decodedObject = JSON.parse(event.target.data);
			settingsModel.configVO = _decodedObject;

			// @TODO: Load from cfg
			settingsModel.availableQualities = [{"label":"Easy", "val":ConversionLookupMap.LOW_QUALITY_KBPS}, {"label":"Med", "val":ConversionLookupMap.MED_QUALITY_KBPS}, {"label":"High", "val":ConversionLookupMap.HIGH_QUALITY_KBPS}];
			settingsModel.quality = _decodedObject.client.quality;

			// Artificial loading screen delay
			setTimeout(function() : void {
				Debug.log("LoadPreferencesCommand - done.");
				dispatchComplete(true);
			}, _artificalDelay);
		}
	}
}
