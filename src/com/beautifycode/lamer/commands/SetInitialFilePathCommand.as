package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.controller.ConversionLookupMap;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.SettingsModel;
	import com.beautifycode.lamer.services.ConversionService;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class SetInitialFilePathCommand extends Command {
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var fileService : ConversionService;

		[Inject]
		public var event : UserEvent;

		[Inject]
		public var settingsModel : SettingsModel;
		private var _conversionEvent : ConversionEvent;

		override public function execute() : void {
			_setupQualities();
			settingsModel.inputFilePath = event.payload.filepath;

			_conversionEvent = new ConversionEvent(ConversionEvent.INITIAL_INPUTFILEPATH_SET, true, false);
			eventDispatcher.dispatchEvent(_conversionEvent);
		}

		private function _setupQualities() : void {
			settingsModel.availableQualities = [{"label":"Easy", "val":ConversionLookupMap.LOW_QUALITY_KBPS}, {"label":"Med", "val":ConversionLookupMap.MED_QUALITY_KBPS}, {"label":"High", "val":ConversionLookupMap.HIGH_QUALITY_KBPS}];
		}
	}
}
