package com.beautifycode.lamer.views {
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {
		private var _loadingView : LoadingView;
		private var _userSelectionView : UserSelectionView;
		private var _progressView : ProgressView;
		private var _userSettingsView : UserSettingsView;

		public function ApplicationView() {
		}

		public function build(stageSize : Object) : void {
			_loadingView = new LoadingView();
			_userSelectionView = new UserSelectionView(stageSize.w, stageSize.h);
			_userSettingsView = new UserSettingsView();
			_progressView = new ProgressView();
			_progressView.visible = false;

			addChild(_userSelectionView);
			addChild(_userSettingsView);
			addChild(_progressView);

			_layout();
		}

		private function _layout() : void {
			// @TODO: Prepare transitional layout
		}

		public function showConversionSettings() : void {
			// @TODO: Transitions
			removeChild(_userSelectionView);
			_userSettingsView.visible = true;
			_progressView.visible = true;
		}

		public function appendLog(s : String) : void {
			_progressView.textArea.text += s + "\n";
		}
	}
}
