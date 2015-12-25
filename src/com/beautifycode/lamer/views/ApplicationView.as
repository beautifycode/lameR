package com.beautifycode.lamer.views {
	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {

		private var _loadingView : LoadingView;
		private var _userSelectionView : UserSelectionView;
		private var _preferencesView : PreferencesView;
		private var _progressView : ProgressView;
		private var _userSettingsView : UserSettingsView;

		public function ApplicationView() {
		}

		public function build() : void {
			_loadingView = new LoadingView();
			_userSelectionView = new UserSelectionView();
			_userSettingsView = new UserSettingsView();
			_progressView = new ProgressView();
			_progressView.visible = false;
			_preferencesView = new PreferencesView();
			
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
			_userSelectionView.visible = false;
			_userSettingsView.visible = true;
		}

		public function showProgress(ps : String) : void {
			_progressView.visible = true;
			_progressView.textArea.text += ps + "\n";
		}
	}
}
