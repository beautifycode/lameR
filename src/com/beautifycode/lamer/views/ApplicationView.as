package com.beautifycode.lamer.views {
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {
		private var _bootView : BootView;
		private var _userSelectionView : UserSelectionView;
		private var _progressView : ProgressView;
		private var _userSettingsView : UserSettingsView;

		public function build(stageSize : Object) : void {
			_bootView = new BootView(stageSize.w, stageSize.h);
			_userSelectionView = new UserSelectionView(stageSize.w, stageSize.h);
			_userSettingsView = new UserSettingsView();
			_progressView = new ProgressView();

			_showBootView();
		}

		private function _showBootView() : void {
			addChild(_bootView);
		}

		public function hideBootView() : void {
			removeChild(_bootView);
		}

		public function showSelectionView() : void {
			addChild(_userSelectionView);
		}

		public function hideSelectionView() : void {
			removeChild(_userSelectionView);
		}

		public function showConversionSettings() : void {
			addChild(_progressView);
			addChild(_userSettingsView);
		}

		public function appendLog(s : String) : void {
			_progressView.textArea.text += s + "\n";
		}
	}
}
