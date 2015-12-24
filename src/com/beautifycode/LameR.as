package com.beautifycode {
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import com.beautifycode.lamer.LameRConfig;
	import com.beautifycode.lamer.views.MainView;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.display.Sprite;
	import flash.events.Event;

	/**
	 * @author marvin
	 */
	public class LameR extends Sprite {
		private var _contextView : ContextView;
		private var _context : IContext;
		private var _mainView : MainView;

		public function LameR() {
			_contextView = new ContextView(this);
			_context = new Context()
				.install(MVCSBundle)
				.configure(LameRConfig, _contextView);
				
			// @TODO: Configure AIR application
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}

		private function _onAddedToStage(event : Event) : void {
			MonsterDebugger.initialize(this);
			_createChildren();
		}

		private function _createChildren() : void {
			_mainView = new MainView();
			addChild(_mainView);
		}
	}
}
