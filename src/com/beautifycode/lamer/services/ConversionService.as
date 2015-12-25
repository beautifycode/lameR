package com.beautifycode.lamer.services {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.desktop.NativeProcess;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.system.Capabilities;

	/**
	 * @author marvin
	 */
	public class ConversionService {
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var conversionModel : ConversionModel;
		
		[Inject]
		public var settingsModel : SettingsModel;

		[Inject]
		public var preferencesModel : SettingsModel;
		private static var cleanPercentPattern : RegExp = /[(].*[)]/;
		private var _selectedUserFilePath : String;
		private var _selectedOutputFilePath : String = "";
		private var _lameFile : File;
		private var _nativeProcess : NativeProcess;
		private var _processArgs : Vector.<String>;
		private var _nativeProcessStartupInfo : NativeProcessStartupInfo;
		private var _metaString : String;
		private var _byteIndex : uint;
		private var _chmodSet : Boolean;

		public function startConversion(fp : String) : void {
			_selectedUserFilePath = fp;
			_nativeProcess = new NativeProcess();
			_setupNativeProgressEvents(_nativeProcess);

			_lameFile = File.applicationDirectory.resolvePath("lame");
			_nativeProcessStartupInfo = new NativeProcessStartupInfo();
			_nativeProcessStartupInfo.executable = _lameFile;

			if (Capabilities.os.indexOf('Mac OS') > -1 && !_chmodSet) {
				_changeCHMOD();
			} else {
				_chmodChanged(null);
			}
		}

		private function _changeCHMOD() : void {
			var _chmod : File = new File('/bin/bash');
			var nativeProcess : NativeProcess = new NativeProcess();
			var chmodStartupInfo : NativeProcessStartupInfo = new NativeProcessStartupInfo();
			chmodStartupInfo.executable = _chmod;

			var args : Vector.<String> = new Vector.<String>();
			args.push('-c');
			args.push('chmod ugo+x ' + _lameFile.nativePath);
			chmodStartupInfo.arguments = args;

			nativeProcess.addEventListener(Event.STANDARD_OUTPUT_CLOSE, _chmodChanged);
			nativeProcess.start(chmodStartupInfo);
		}

		private function _chmodChanged(event : Event) : void {
			_chmodSet = true;

			// @TODO: Fill via ui settings
			_processArgs = new Vector.<String>();
			_processArgs.push("--preset", preferencesModel.quality.toString(), settingsModel.userFilePath, _selectedOutputFilePath);

			_nativeProcessStartupInfo.arguments = _processArgs;
			_nativeProcess.start(_nativeProcessStartupInfo);

			conversionModel.state = ConversionEvent.START;
		}

		private function _setupNativeProgressEvents(p : NativeProcess) : void {
			p.addEventListener(IOErrorEvent.STANDARD_ERROR_IO_ERROR, _errorHandler);
			p.addEventListener(IOErrorEvent.STANDARD_INPUT_IO_ERROR, _errorHandler);
			p.addEventListener(IOErrorEvent.STANDARD_OUTPUT_IO_ERROR, _errorHandler);

			p.addEventListener(ProgressEvent.STANDARD_OUTPUT_DATA, _progressHandler);
			p.addEventListener(ProgressEvent.STANDARD_ERROR_DATA, _progressHandler);
			p.addEventListener(Event.STANDARD_ERROR_CLOSE, _streamClosedHandled);
		}

		private function _streamClosedHandled(event : Event) : void {
			conversionModel.state = ConversionEvent.STREAM_CLOSED;
		}

		private function _errorHandler(event : Event) : void {
			Debug.log(event);
		}

		private function _progressHandler(event : ProgressEvent) : void {
			conversionModel.state = ConversionEvent.PROGRESS;
			_byteIndex = _nativeProcess.standardError.bytesAvailable;
			_metaString = _nativeProcess.standardError.readUTFBytes(_byteIndex);
			conversionModel.progress = _generateCleanPercentages(_metaString);
		}

		private function _generateCleanPercentages(ms : String) : int {
			var po : Object = cleanPercentPattern.exec(ms);
			if (!po) return ConversionModel.ERROR_CODE;

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
