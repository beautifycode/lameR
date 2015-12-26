package com.beautifycode.lamer.views {
	import com.bit101.components.Label;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class BootView extends Sprite {
		private var _dragArea : Sprite;
		private var _dropAnywhereLabel : Label;

		public function BootView(sw : int, sh : int) {
			_dragArea = new Sprite();
			_dragArea.graphics.beginFill(0xEEEEEE);
			_dragArea.graphics.drawRect(0, 0, sw, sh);
			addChild(_dragArea);

			_dropAnywhereLabel = new Label();
			_dropAnywhereLabel.text = "Loading...";
			_dropAnywhereLabel.y = sh/2 - 40;
			_dropAnywhereLabel.x = sw/2 - 20;
			addChild(_dropAnywhereLabel);
		}
	}
}
