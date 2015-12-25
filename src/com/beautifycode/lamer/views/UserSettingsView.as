package com.beautifycode.lamer.views {
	import com.beautifycode.lamer.controller.events.UserEvent;

	import flash.events.MouseEvent;

	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;

	import flash.display.DisplayObject;
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class UserSettingsView extends Sprite {
		private var _inputPathLabel : Label;
		private var _inputFileText : Text;

		private var _outputPathLabel : Label;
		private var _outputFileText : Text;
		private var _changeOutputPathBtn : PushButton;
		private var _changeinputPathBtn : PushButton;

		private var _qualityLabel : Label;
		private var _easyQualityBtn : PushButton;
		private var _mediumQualityBtn : PushButton;
		private var _losslessQualityBtn : PushButton;

		private var _convertBtn : PushButton;

		public function UserSettingsView() {
		}

		// Will be replaced with assets
		public function build(ipf : String) : void {
			_inputPathLabel = new Label();
			_inputPathLabel.text = "Input Path:";
			_inputFileText = new Text();
			_inputFileText.text = ipf;

			_outputPathLabel = new Label();
			_outputPathLabel.text = "Output Path:";
			_outputFileText = new Text();

			_changeOutputPathBtn = new PushButton();
			_changeOutputPathBtn.label = "Change";
			_changeinputPathBtn = new PushButton();
			_changeinputPathBtn.label = "Change";

			_easyQualityBtn = new PushButton();
			_easyQualityBtn.label = "Easy";
			_mediumQualityBtn = new PushButton();
			_mediumQualityBtn.label = "Medium";
			_losslessQualityBtn = new PushButton();
			_losslessQualityBtn.label = "Lossless";
			_qualityLabel = new Label();
			_qualityLabel.text = "Chose quality";

			_convertBtn = new PushButton();
			_convertBtn.label = "Start!";
			_convertBtn.addEventListener(MouseEvent.CLICK, _onConvertBtnClick);

			_position(_inputPathLabel, 0, 0, 350);
			_position(_inputFileText, 0, 20, 350);

			_position(_outputPathLabel, 0, 60, 350);
			_position(_outputFileText, 0, 80, 350);

			_position(_changeinputPathBtn, 350, 20, 100);
			_position(_changeOutputPathBtn, 350, 80, 100);

			_position(_easyQualityBtn, 0, 150, 100);
			_position(_mediumQualityBtn, 110, 150, 100);
			_position(_losslessQualityBtn, 220, 150, 100);
			_position(_qualityLabel, 0, 130, 100);

			_position(_convertBtn, 0, 200, 100);

			addChild(_inputPathLabel);
			addChild(_inputFileText);
			addChild(_outputPathLabel);
			addChild(_outputFileText);
			addChild(_changeinputPathBtn);
			addChild(_changeOutputPathBtn);
			addChild(_easyQualityBtn);
			addChild(_mediumQualityBtn);
			addChild(_losslessQualityBtn);
			addChild(_qualityLabel);
			addChild(_convertBtn);
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
	}
}
