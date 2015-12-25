package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;

	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;

	/**
	 * @author marvin
	 */
	public class MainMediator extends Mediator {
		[Inject]
		public var view : MainView;
		private var _userEvent : UserEvent;
		private var _selectedUserFile : File;

		override public function initialize() : void {
			// @TODO: Add drag&drop on view
			view.build();

			addViewListener(UserEvent.SELECT_FILE, dispatch, UserEvent);

			addContextListener(ConversionEvent.START, _onProgressStart);
			addContextListener(ConversionEvent.PROGRESS, _onProgress);
			addContextListener(ConversionEvent.FINISHED, _onProgressFinished);

			view.selectFileBtn.addEventListener(MouseEvent.CLICK, _onFileSelectClick);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, _onDragEnter);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, _onDropComplete);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, _onDropComplete);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, _onDragExit);
		}

		private function _onDragEnter(event : NativeDragEvent) : void {
			NativeDragManager.acceptDragDrop(view);
			// @TODO: Show DragAreaPreview
		}

		private function _onDropComplete(event : NativeDragEvent) : void {
			var f : Array = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			_userEvent = new UserEvent(UserEvent.SELECT_FILE, true, false);
			_userEvent.payload = {filepath:f[0].nativePath};
			eventDispatcher.dispatchEvent(_userEvent);
		}

		private function _onDragExit(event : NativeDragEvent) : void {
			// @TODO: Cancel DragAreaPreview
		}

		private function _onFileSelectClick(event : MouseEvent) : void {
			_selectedUserFile = new File();
			_selectedUserFile.addEventListener(Event.SELECT, _onFileFromSystemSelected);
			_selectedUserFile.browse();
		}

		private function _onFileFromSystemSelected(event : Event) : void {
			_userEvent = new UserEvent(UserEvent.SELECT_FILE, true, false);
			_userEvent.payload = {filepath:_selectedUserFile.nativePath};
			eventDispatcher.dispatchEvent(_userEvent);
		}

		private function _onProgressStart(event : ConversionEvent) : void {
			Debug.log("MainMediator - _onProgressStart");
			// @TODO: Switch to ProgressView
		}

		private function _onProgress(event : ConversionEvent) : void {
			// @TODO: Show progress
		}

		private function _onProgressFinished(event : ConversionEvent) : void {
			Debug.log("MainMediator - _onProgressFinished");
			// @TODO: Switch to ResultView
		}
	}
}
