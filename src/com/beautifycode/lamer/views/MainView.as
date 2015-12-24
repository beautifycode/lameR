package com.beautifycode.lamer.views {
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.bit101.components.PushButton;

	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class MainView extends Sprite {
		public function MainView() {
			// @TODO: Everything, I guess
			var btn : PushButton = new PushButton();
			btn.addEventListener(MouseEvent.CLICK, _onFileSelectClick);
			btn.x = 100;
			btn.y = 100;
			btn.label = "Select File!";
			addChild(btn);
		}

		private function _onFileSelectClick(event : MouseEvent) : void {
			dispatchEvent(new UserEvent(UserEvent.SELECT_FILE, true, false));
		}
	}
}
