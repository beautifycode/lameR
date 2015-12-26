package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.services.PreferenceService;

	/**
	 * @author marvin
	 */
	public class ClosingCommand extends Command {
		[Inject]
		public var prefService : PreferenceService;

		override public function execute() : void {
			prefService.savePreferences();
		}
	}
}
