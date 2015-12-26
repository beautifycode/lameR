package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ApplicationEvent;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;

	/**
	 * @author marvin
	 */
	public class ApplicationMediator extends Mediator {
		[Inject]
		public var view : ApplicationView;

		[Inject]
		public var conversionModel : ConversionModel;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var settingsModel : SettingsModel;

		override public function initialize() : void {
			view.build(applicationModel.stageSizeObject);

			addContextListener(ApplicationEvent.BOOT_COMPLETE, _onBootFinished);
			addContextListener(ConversionEvent.INITIAL_INPUTFILEPATH_SET, _onFilePathSet);
			addContextListener(ConversionEvent.START, _onProgressStart);
			addContextListener(ConversionEvent.PROGRESS, _onProgress);
			addContextListener(ConversionEvent.FINISHED, _onProgressFinished);
		}

		private function _onBootFinished(event : ApplicationEvent) : void {
			Debug.log("ApplicationViewMediator - _onBootFinished");
			view.hideBootView();
			view.showSelectionView();

			if (settingsModel.inputFilePath) {
				_onFilePathSet(null);
			}
		}

		private function _onFilePathSet(event : ConversionEvent) : void {
			view.hideSelectionView();
			view.showConversionSettings();
			
			view.appendLog("Hello.");
		}

		private function _onProgressStart(event : ConversionEvent) : void {
			Debug.log("ApplicationViewMediator - _onProgressStart");
			view.appendLog("Convert started.");
		}

		private function _onProgress(event : ConversionEvent) : void {
			var s : String = conversionModel.progress + "%";
			view.appendLog("Progress: " + s);
		}

		private function _onProgressFinished(event : ConversionEvent) : void {
			Debug.log("ApplicationViewMediator - _onProgressFinished");
			var s : String = "Conversion finished!";
			view.appendLog(s);
			// @TODO: Switch to ResultView
		}
	}
}
