package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.lamer.controller.events.ApplicationEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.SettingsModel;
	import com.beautifycode.lamer.services.PreferenceService;
	import com.beautifycode.lamer.views.ApplicationView;

	/**
	 * @author marvin
	 */
	public class BootCommand extends Command {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var event : ApplicationEvent;

		[Inject]
		public var applicationModel : ApplicationModel;
		
		[Inject]
		public var settingsModel : SettingsModel;

		[Inject]
		public var prefService : PreferenceService;

		private var _applicationView : ApplicationView;

		override public function execute() : void {
			_applicationView = new ApplicationView();
			contextView.view.addChild(_applicationView);

			_setupNativeWindow();
			_loadApplicationPreferences();
		}

		private function _setupNativeWindow() : void {
			applicationModel.setupNativeWindow(contextView.view.stage.nativeWindow);
		}

		private function _loadApplicationPreferences() : void {
			prefService.loadPreferences(event.payload.bootWithPath);
		}
	}
}
