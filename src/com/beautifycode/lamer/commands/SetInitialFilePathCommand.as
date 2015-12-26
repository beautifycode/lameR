package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.SettingsModel;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class SetInitialFilePathCommand extends Command {
		[Inject]
		public var eventDispatcher : IEventDispatcher;

		[Inject]
		public var event : UserEvent;

		[Inject]
		public var settingsModel : SettingsModel;
		
		private var _conversionEvent : ConversionEvent;

		override public function execute() : void {
			settingsModel.inputFilePath = event.payload.filepath;

			_conversionEvent = new ConversionEvent(ConversionEvent.INITIAL_INPUTFILEPATH_SET, true, false);
			eventDispatcher.dispatchEvent(_conversionEvent);
		}
	}
}
