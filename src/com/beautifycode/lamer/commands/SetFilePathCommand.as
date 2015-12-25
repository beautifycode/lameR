package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.SettingsModel;
	import com.beautifycode.lamer.services.ConversionService;

	/**
	 * @author marvin
	 */
	public class SetFilePathCommand extends Command {
		[Inject]
		public var fileService:ConversionService;

		[Inject]
		public var event : UserEvent;

		[Inject]
		public var settingsModel : SettingsModel;
		
		override public function execute() : void {
			settingsModel.userFilePath = event.payload.filepath;
		}
	}
}
