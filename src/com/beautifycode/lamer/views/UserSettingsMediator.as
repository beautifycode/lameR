package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.events.Event;
	import flash.filesystem.File;

	/**
	 * @author marvin
	 */
	public class UserSettingsMediator extends Mediator {
		[Inject]
		public var view : UserSettingsView;

		[Inject]
		public var settingsModel : SettingsModel;

		[Inject]
		public var conversionModel : ConversionModel;

		[Inject]
		public var applicationModel : ApplicationModel;

		private var _inputFile : File;
		private var _outputFile : File;

		override public function initialize() : void {
			view.build(settingsModel.inputFilePath, settingsModel.availableQualities, settingsModel.qualityIndex);

			addViewListener(UserEvent.START_CONVERSION, dispatch, UserEvent);
			addViewListener(UserEvent.SET_QUALITY, _setQuality);
			addViewListener(UserEvent.CHANGE_INPUTFILE, _changeInputPath);
			addViewListener(UserEvent.CHANGE_OUTPUTFILE, _changeOutputPath);
		}
		
		private function _changeInputPath(event : UserEvent) : void {
			_inputFile = new File();
			_inputFile.addEventListener(Event.SELECT, _onInputFileSelected);
			_inputFile.browse([applicationModel.fileFilter]);
		}

		private function _onInputFileSelected(event : Event) : void {
			settingsModel.inputFilePath = _inputFile.nativePath;
			view.inputFileText.text = _inputFile.nativePath;
		}

		private function _changeOutputPath(event : UserEvent) : void {
			_outputFile = new File();
			_outputFile.addEventListener(Event.SELECT, _onOutputFileSelected);
			_outputFile.browseForSave("Save..");
		}

		private function _onOutputFileSelected(event : Event) : void {
			settingsModel.outputFilePath = _outputFile.nativePath;
			view.outputFileText.text = settingsModel.outputFilePath;
		}

		private function _setQuality(event : UserEvent) : void {
			settingsModel.quality = settingsModel.availableQualities[event.payload.qualityIndex].val;
		}
	}
}
