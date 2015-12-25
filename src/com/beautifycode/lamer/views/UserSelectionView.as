package com.beautifycode.lamer.views {
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class UserSelectionView extends Sprite {
		private var _dragArea : Sprite;
		private var _selectFileBtn : PushButton;

		public function UserSelectionView() {
			_dragArea = new Sprite();
			_dragArea.graphics.beginFill(0xEEEEEE);
			_dragArea.graphics.drawRect(0, 0, 550, 400); // @TODO: StageSize
			_dragArea.x = 0;
			addChild(_dragArea);

			_selectFileBtn = new PushButton();
			_selectFileBtn.x = 100;
			_selectFileBtn.y = 100;
			_selectFileBtn.label = "Select File!";
			addChild(_selectFileBtn);
		}

		public function get selectFileBtn() : PushButton {
			return _selectFileBtn;
		}

		public function get dragArea() : Sprite {
			return _dragArea;
		}
	}
}
