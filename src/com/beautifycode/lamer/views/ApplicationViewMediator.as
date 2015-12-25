package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;

	import flash.filesystem.File;

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
		private var _userEvent : UserEvent;
		private var _selectedUserFile : File;

		override public function initialize() : void {
			// @TODO: Add drag&drop on view
			view.build(applicationModel.stageSizeObject);

			addViewListener(UserEvent.SELECT_FILE, dispatch, UserEvent);

			addContextListener(ConversionEvent.INITIAL_FILEPATH_SET, _onFilePathSet);
			addContextListener(ConversionEvent.START, _onProgressStart);
			addContextListener(ConversionEvent.PROGRESS, _onProgress);
			addContextListener(ConversionEvent.FINISHED, _onProgressFinished);
		}

		private function _onFilePathSet(event : ConversionEvent) : void {
			view.showConversionSettings();
		}

		private function _onProgressStart(event : ConversionEvent) : void {
			Debug.log("ApplicationViewMediator - _onProgressStart");
			// @TODO: Switch to ProgressView
		}

		private function _onProgress(event : ConversionEvent) : void {
			var s : String = conversionModel.progress + "%";
			view.showProgress(s);
		}

		private function _onProgressFinished(event : ConversionEvent) : void {
			Debug.log("ApplicationViewMediator - _onProgressFinished");
			var s : String = "Conversion finished!";
			view.showProgress(s);
			// @TODO: Switch to ResultView
		}
	}
}
