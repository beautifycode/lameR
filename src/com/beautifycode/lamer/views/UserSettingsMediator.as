package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.SettingsModel;

	/**
	 * @author marvin
	 */
	public class UserSettingsMediator extends Mediator {
		[Inject]
		public var view : UserSettingsView;

		[Inject]
		public var settingsModel : SettingsModel;

		override public function initialize() : void {
			view.visible = false;
			addContextListener(ConversionEvent.FILEPATH_SET, _showSettings);
			addViewListener(UserEvent.START_CONVERSION, dispatch, UserEvent);
		}

		private function _showSettings(event : ConversionEvent) : void {
			view.build(settingsModel.userFilePath);
		}
	}
}
