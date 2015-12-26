package com.beautifycode.lamer.commands {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.utils.setTimeout;

	/**
	 * @author marvin
	 */
	public class SavePreferencesCommand extends AsyncCommand {
		[Inject]
		public var settingsModel : SettingsModel;

		protected var _artificalDelay : int = 1000;

		private var _decodedObject : Object;
		private var _fileStream : FileStream;
		private var _preferenceFile : File;

		override public function execute() : void {
			Debug.log("SavePreferencesCommand - init.");
			_preferenceFile = new File(File.applicationDirectory.resolvePath(SettingsModel.CONFIG_NAME).nativePath);
			_fileStream = new FileStream();
			_fileStream.open(_preferenceFile, FileMode.WRITE);

			// @TODO: Actually, do some work
			_decodedObject = settingsModel.configVO;
			_decodedObject.client.quality = settingsModel.quality;
			var _updatedSettingsObjAsString : String = _createStringFromSettings();

			_fileStream.writeUTFBytes(_updatedSettingsObjAsString);
			_fileStream.close();

			setTimeout(function() : void {
				Debug.log("SavePreferencesCommand - done.");
				dispatchComplete(true);
			}, _artificalDelay);
		}

		private function _createStringFromSettings() : String {
			var s : String = JSON.stringify(_decodedObject);
			return s;
		}
	}
}
