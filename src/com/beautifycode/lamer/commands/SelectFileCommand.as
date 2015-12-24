package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;

	import com.beautifycode.lamer.services.FileService;

	/**
	 * @author marvin
	 */
	public class SelectFileCommand extends Command {
		[Inject]
		public var fileService:FileService;
		
		override public function execute() : void {
			fileService.selectFile();
		}
	}
}
