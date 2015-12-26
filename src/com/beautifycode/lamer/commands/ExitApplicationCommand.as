package com.beautifycode.lamer.commands {
	import robotlegs.bender.bundles.mvcs.Command;
	import robotlegs.bender.extensions.contextView.ContextView;

	import com.beautifycode.lamer.controller.events.ApplicationEvent;
	import com.beautifycode.lamer.models.ApplicationModel;

	/**
	 * @author marvin
	 */
	public class ExitApplicationCommand extends Command {
		[Inject]
		public var contextView : ContextView;

		[Inject]
		public var event : ApplicationEvent;

		[Inject]
		public var applicationModel : ApplicationModel;

		override public function execute() : void {
			applicationModel.closeApplication();
		}
	}
}
