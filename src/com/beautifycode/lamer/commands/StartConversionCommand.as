package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.services.ConversionService;

	/**
	 * @author marvin
	 */
	public class StartConversionCommand extends Command {
		[Inject]
		public var fileService:ConversionService;
		
		override public function execute() : void {
			fileService.startConversion();
		}
	}
}
