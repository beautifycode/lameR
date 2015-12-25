package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.services.ConversionService;

	/**
	 * @author marvin
	 */
	public class StartConversionCommand extends Command {
		[Inject]
		public var fileService:ConversionService;
		
		[Inject]
		public var conversionModel : ConversionModel;
		
		override public function execute() : void {
			fileService.startConversion(conversionModel.userFilePath);
		}
	}
}
