package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.desktop.NativeApplication;
	import flash.events.InvokeEvent;

	/**
	 * @author marvin
	 */
	public class ApplicationViewMediator extends Mediator {
		[Inject]
		public var view : ApplicationView;

		[Inject]
		public var conversionModel : ConversionModel;

		[Inject]
		public var applicationModel : ApplicationModel;

		[Inject]
		public var settingsModel : SettingsModel;

		private var _userEvent : UserEvent;


		override public function initialize() : void {
			view.build(applicationModel.stageSizeObject);

			// @TODO: Work w/ PRE-INIT from RL2
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, _onAppInvoke);

			addViewListener(UserEvent.SELECT_INITIAL_FILE, dispatch, UserEvent);
			addContextListener(ConversionEvent.INITIAL_INPUTFILEPATH_SET, _onFilePathSet);

			addContextListener(ConversionEvent.START, _onProgressStart);
			addContextListener(ConversionEvent.PROGRESS, _onProgress);
			addContextListener(ConversionEvent.FINISHED, _onProgressFinished);
		}

		private function _onAppInvoke(event : InvokeEvent) : void {
			if (event.arguments[0]) {
				if (!settingsModel.inputFilePath) {
					_userEvent = new UserEvent(UserEvent.SELECT_INITIAL_FILE, true, false);
					_userEvent.payload = {filepath:event.arguments[0]};
					eventDispatcher.dispatchEvent(_userEvent);
				} else {
					// change input path
				}
			}
		}

		private function _onFilePathSet(event : ConversionEvent) : void {
			view.showConversionSettings();
			view.appendLog("Hello.");
		}

		private function _onProgressStart(event : ConversionEvent) : void {
			// @TODO: Switch to ProgressView
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
