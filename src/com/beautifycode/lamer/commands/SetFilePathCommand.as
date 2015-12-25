package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ConversionModel;
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
		public var conversionModel : ConversionModel;
		
		override public function execute() : void {
			conversionModel.userFilePath = event.payload.filepath;
		}
	}
}
