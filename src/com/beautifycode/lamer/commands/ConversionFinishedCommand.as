package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.services.ConversionService;

	/**
	 * @author marvin
	 */
	public class ConversionFinishedCommand extends Command {
		[Inject]
		public var fileService : ConversionService;

		override public function execute() : void {
			// @TODO: Compare Hashs
			// @TODO: Test output file
			// @TODO: Add preview UI 
			 
			Debug.log("ConversionFinishedCommand - execute");
		}
	}
}
