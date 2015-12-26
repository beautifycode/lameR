package com.beautifycode {
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import com.beautifycode.lamer.LameRConfig;
	import com.beautifycode.lamer.views.ApplicationView;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.desktop.NativeApplication;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.InvokeEvent;

	/**
	 * @author marvin
	 */
	public class LameR extends Sprite {
		private var _contextView : ContextView;
		private var _context : IContext;
		private var _mainView : ApplicationView;

		public function LameR() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			MonsterDebugger.initialize(this);

			_contextView = new ContextView(this);
			_context = new Context()
				.install(MVCSBundle)
				.configure(LameRConfig, _contextView);

			// @TODO: Configure AIR application
			addEventListener(Event.ADDED_TO_STAGE, _onAddedToStage);
		}

		private function _onAddedToStage(event : Event) : void {
			_createChildren();
		}

		private function _createChildren() : void {
			_mainView = new ApplicationView();
			addChild(_mainView);
		}
	}
}
