package com.beautifycode.lamer.views {
	import com.bit101.components.PushButton;
	import com.bit101.components.Text;

	import flash.display.Sprite;

	/**
	 * @author marvin
	 */
	public class ApplicationView extends Sprite {

		private var _loadingView : LoadingView;
		private var _userSelectionView : UserSelectionView;
		private var _preferencesView : PreferencesView;
		private var _progressView : ProgressView;

		public function ApplicationView() {
		}

		public function build() : void {
			_loadingView = new LoadingView();
			_userSelectionView = new UserSelectionView();
			_progressView = new ProgressView();
			_preferencesView = new PreferencesView();
			
			addChild(_userSelectionView);
			addChild(_progressView);
		
			_layout();
		}

		private function _layout() : void {
			// @TODO: Assets & Design for InitialSelectionView
		}

		public function showProgress(ps : String) : void {
			_progressView.textArea.text += ps + "\n";
		}

	}
}
