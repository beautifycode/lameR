package com.beautifycode.lamer.views {
	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.bit101.components.ComboBox;
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	/**
	 * @author marvin
	 */
	public class UserSettingsView extends Sprite {
		private var _inputPathLabel : Label;
		private var _inputFileText : Text;
		private var _changeInputPathBtn : PushButton;

		private var _outputPathLabel : Label;
		private var _outputFileText : Text;
		private var _changeOutputPathBtn : PushButton;

		private var _qualityLabel : Label;
		private var _qualityBox : ComboBox;

		private var _convertBtn : PushButton;
		private var _userEvent : UserEvent;

		public function UserSettingsView() {
		}

		// Will be replaced with assets
		public function build(ipf : String, qs : Array) : void {
			_inputPathLabel = new Label();
			_inputPathLabel.text = "Input Path:";
			_inputFileText = new Text();
			_inputFileText.text = ipf;

			_outputPathLabel = new Label();
			_outputPathLabel.text = "Output Path:";
			_outputFileText = new Text();
			_outputFileText.text = "Same directory.";

			_changeOutputPathBtn = new PushButton();
			_changeOutputPathBtn.label = "Change";
			_changeInputPathBtn = new PushButton();
			_changeInputPathBtn.label = "Change";

			_qualityBox = new ComboBox();
			_qualityBox.defaultLabel = "Quality:";
			_qualityBox.addEventListener(Event.SELECT, _onQualitySelect);

			// @TODO: Tell Keith his components bug.
			for (var i : int; i < qs.length; i++) {
				_qualityBox.addItem(qs[i]);
			}

			_qualityLabel = new Label();
			_qualityLabel.text = "Chose quality";

			_convertBtn = new PushButton();
			_convertBtn.label = "Start!";
			_convertBtn.addEventListener(MouseEvent.CLICK, _onConvertBtnClick);

			_position(_inputPathLabel, 0, 0, 350);
			_position(_inputFileText, 0, 20, 350);

			_position(_outputPathLabel, 0, 60, 350);
			_position(_outputFileText, 0, 80, 350);

			_position(_changeInputPathBtn, 350, 20, 100);
			_position(_changeOutputPathBtn, 350, 80, 100);

			_position(_qualityLabel, 0, 130, 100);
			_position(_qualityBox, 0, 150, 100);

			_position(_convertBtn, 150, 150, 100);

			addChild(_inputPathLabel);
			addChild(_inputFileText);
			addChild(_outputPathLabel);
			addChild(_outputFileText);
			addChild(_changeInputPathBtn);
			addChild(_changeOutputPathBtn);

			addChild(_qualityLabel);
			addChild(_qualityBox);
			addChild(_convertBtn);
		}

		private function _onQualitySelect(event : Event) : void {
			_userEvent = new UserEvent(UserEvent.SET_QUALITY, true, false);
			_userEvent.payload = {qualityIndex:_qualityBox.selectedIndex};
			dispatchEvent(_userEvent);
		}

		private function _onConvertBtnClick(event : MouseEvent) : void {
			dispatchEvent(new UserEvent(UserEvent.START_CONVERSION, true, false));
		}

		private function _position(t : DisplayObject, x : int, y : int, w : int, h : int = 20) : void {
			t.x = x;
			t.y = y;
			t.width = w;
			t.height = h;
		}

		public function get changeOutputPathBtn() : PushButton {
			return _changeOutputPathBtn;
		}

		public function get changeInputPathBtn() : PushButton {
			return _changeInputPathBtn;
		}

		public function set changeInputPathBtn(changeinputPathBtn : PushButton) : void {
			_changeInputPathBtn = changeinputPathBtn;
		}

		public function get inputFileText() : Text {
			return _inputFileText;
		}

		public function get outputFileText() : Text {
			return _outputFileText;
		}
	}
}
