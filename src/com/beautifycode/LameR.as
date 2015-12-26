package com.beautifycode {
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import com.beautifycode.lamer.configs.LameRBootConfig;
	import com.demonsters.debugger.MonsterDebugger;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	/**
	 * @author marvin
	 */
	public class LameR extends Sprite {
		private var _contextView : ContextView;
		private var _context : IContext;

		public function LameR() {
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;

			MonsterDebugger.initialize(this);

			_contextView = new ContextView(this);
			_context = new Context()
				.install(MVCSBundle)
				.configure(LameRBootConfig, _contextView);
		}
	}
}
