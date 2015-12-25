package com.beautifycode.lamer.views {
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class UserSelectionView extends Sprite {
		private var _dragArea : Sprite;
		private var _selectFileBtn : PushButton;
		private var _dropAnywhereLabel : Label;

		public function UserSelectionView(sw : int, sh : int) {
			_dragArea = new Sprite();
			_dragArea.graphics.beginFill(0xEEEEEE);
			_dragArea.graphics.drawRect(0, 0, sw, sh); // @TODO: StageSize
			addChild(_dragArea);

			_selectFileBtn = new PushButton();
			_selectFileBtn.x = sw/2 - _selectFileBtn.width / 2;
			_selectFileBtn.y = sh/2 - _selectFileBtn.height / 2;
			_selectFileBtn.label = "Select File!";
			addChild(_selectFileBtn);
			
			_dropAnywhereLabel = new Label();
			_dropAnywhereLabel.text = "Drop a file.";
			_dropAnywhereLabel.y = _selectFileBtn.y - 40;
			_dropAnywhereLabel.x = _selectFileBtn.x + 25;
			addChild(_dropAnywhereLabel);
		}

		public function get selectFileBtn() : PushButton {
			return _selectFileBtn;
		}

		public function get dragArea() : Sprite {
			return _dragArea;
		}
	}
}
