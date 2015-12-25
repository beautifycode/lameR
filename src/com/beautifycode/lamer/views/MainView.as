package com.beautifycode.lamer.views {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.bit101.components.PushButton;

	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;

	/**
	 * @author marvin
	 */
	public class MainView extends Sprite {
		private var _dragArea : Sprite;
		private var _selectFileBtn : PushButton;

		public function MainView() {
		}

		public function build() : void {
			_dragArea = new Sprite();
			_dragArea.graphics.beginFill(0xEEEEEE);
			_dragArea.graphics.drawRect(0, 0, 550, 400); // @TODO: StageSize
			_dragArea.x = 200;
			addChild(_dragArea);

			_selectFileBtn = new PushButton();
			_selectFileBtn.x = 100;
			_selectFileBtn.y = 100;
			_selectFileBtn.label = "Select File!";
			addChild(_selectFileBtn);

			_layout();
		}

		private function _layout() : void {
			// @TODO: Assets & Design for InitialSelectionView
		}

		public function get dragArea() : Sprite {
			return _dragArea;
		}

		public function get selectFileBtn() : PushButton {
			return _selectFileBtn;
		}
	}
}
