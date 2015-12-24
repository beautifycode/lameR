package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;

	/**
	 * @author marvin
	 */
	public class MainMediator extends Mediator {
		[Inject]
		public var view : MainView;

		override public function initialize() : void {
			addViewListener(UserEvent.SELECT_FILE, dispatch, UserEvent);

			addContextListener(ConversionEvent.START, _onProgressStart);
			addContextListener(ConversionEvent.PROGRESS, _onProgress);
			addContextListener(ConversionEvent.FINISHED, _onProgressFinished);
		}

		private function _onProgressStart(event : ConversionEvent) : void {
		}

		private function _onProgress(event : ConversionEvent) : void {
		}

		private function _onProgressFinished(event : ConversionEvent) : void {
		}

		private function onFileSelected(event : UserEvent) : void {
		}
	}
}
