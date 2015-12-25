package com.beautifycode.lamer.views {
	import com.bit101.components.Text;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ProgressView extends Sprite {
		private var _textArea : Text;

		public function ProgressView() {
			_textArea = new Text();
			_textArea.editable = false;
			_textArea.text = "Waiting for file";
			_textArea.x = 0;
			_textArea.y = 200;
			addChild(_textArea);
		}

		public function get textArea() : Text {
			return _textArea;
		}
	}
}
