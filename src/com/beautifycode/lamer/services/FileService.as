package com.beautifycode.lamer.services {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.models.ConversionModel;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;

	/**
	 * @author marvin
	 */
	public class FileService {
		[Inject]
		public var eventDispatcher : IEventDispatcher;
		[Inject]
		public var conversionModel : ConversionModel;
		private static var cleanPercentPattern : RegExp = /[(].*[)]/;
		private var _selectedUserFile : File;
		private var _selectedUserFilePath : String;
		private var _lameFile : File;
		private var _nativeProcess : NativeProcess;
		private var _processArgs : Vector.<String>;
		private var _nativeProcessStartupInfo : NativeProcessStartupInfo;
		private var _metaString : String;
		private var _byteIndex : uint;
		private var _cleanPercentInt : int;
		private var _convertEvent : ConversionEvent;

		// @TODO: Release from Service, add drag&drop via Command
		public function selectFile() : void {
			_selectedUserFile = new File();
			_selectedUserFile.addEventListener(Event.SELECT, _onFileSelect);
			_selectedUserFile.browse();

			Debug.log("User is selecting file...");
		}

		private function _onFileSelect(event : Event) : void {
			_selectedUserFilePath = _selectedUserFile.nativePath;
			Debug.log("User has selected file: " + _selectedUserFilePath);

			// @TODO: show options
			_createStream();
		}

		private function _createStream() : void {
			_nativeProcess = new NativeProcess();
			_setupNativeProgressEvents(_nativeProcess);

			// @TODO: libpath
			_lameFile = File.desktopDirectory.resolvePath("lame");
			_nativeProcessStartupInfo = new NativeProcessStartupInfo();
			_nativeProcessStartupInfo.executable = _lameFile;

			// @TODO: ui settings
			_processArgs = new Vector.<String>();
			_processArgs.push("--preset", "192", _selectedUserFilePath);

			// @TODO: Release from FileService, add to ConversionService
			_nativeProcessStartupInfo.arguments = _processArgs;
			_nativeProcess.start(_nativeProcessStartupInfo);

			conversionModel.state = ConversionModel.START;
		}

		private function _setupNativeProgressEvents(p : NativeProcess) : void {
			p.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, _errorHandler);
			p.addEventListener(IOErrorEvent.STANDARD_INPUT_IO_ERROR, _errorHandler);
			p.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, _errorHandler);
			p.addEventListener(Event.STANDARD_ERROR_CLOSE, _errorHandler);

			p.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, _progressHandler);
			p.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, _progressHandler);
		}

		private function _errorHandler(event : Event) : void {
			Debug.log(event);
		}

		private function _progressHandler(event : ProgressEvent) : void {
			conversionModel.state = ConversionModel.PROGRESS;
			_byteIndex = _nativeProcess.standardError.bytesAvailable;
			_metaString = _nativeProcess.standardError.readUTFBytes(_byteIndex);
			conversionModel.progress = _generateCleanPercentages(_metaString);
		}

		private function _generateCleanPercentages(ms : String) : int {
			var po : Object = cleanPercentPattern.exec(ms);
			var cpi : int;
			var cps : String;
			var ps : String = po[0];

			if (ps.search("%") > 0) {
				cps = ps.replace("(", "").replace(")", "").replace("%", "");
				cpi = parseInt(cps);
			}

			return cpi;
		}
	}
}
