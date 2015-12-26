package com.beautifycode.lamer.commands {
	import eu.alebianco.robotlegs.utils.impl.AsyncCommand;

	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.AIRUpdateHelper.AIRUpdateHelper;
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.views.ApplicationView;

	/**
	 * @author marvin
	 */
	public class StartupCommand extends AsyncCommand {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var applicationModel : ApplicationModel;

		private var _applicationView : ApplicationView;

		override public function execute() : void {
			Debug.log("StartupCommand - init.");
			_applicationView = new ApplicationView();
			contextView.view.addChild(_applicationView);

			_setupNativeWindow();
			_checkVersion();
		}

		private function _setupNativeWindow() : void {
			applicationModel.setupNativeWindow(contextView.view.stage.nativeWindow);
		}

		private function _checkVersion() : void {
			AIRUpdateHelper.getAppInfo();
			AIRUpdateHelper.checkForUpdate("http://*.xml", _onUpdateSkip, _onFail);
		}

		private function _onUpdateSkip() : void {
			Debug.log("Update skipped");
			_resolve();
		}

		private function _onFail(s : String) : void {
			Debug.log(s);
			_resolve();
		}

		private function _resolve() : void {
			dispatchComplete(true);
			Debug.log("StartupCommand - done.");
		}
	}
}
