package com.beautifycode.lamer.views {
	import robotlegs.bender.bundles.mvcs.Mediator;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;

	import flash.desktop.ClipboardFormats;
	import flash.desktop.NativeDragManager;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.NativeDragEvent;
	import flash.filesystem.File;

	/**
	 * @author marvin
	 */
	public class UserSelectionMediator extends Mediator {
		[Inject]
		public var view : UserSelectionView;

		[Inject]
		public var conversionModel : ConversionModel;

		[Inject]
		public var applicationModel : ApplicationModel;
		private var _userEvent : UserEvent;
		private var _selectedUserFile : File;
		private var _draggingFiles : Array;

		override public function initialize() : void {
			view.selectFileBtn.addEventListener(MouseEvent.CLICK, _onFileSelectClick);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_ENTER, _onDragEnter);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_COMPLETE, _onDropComplete);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_DROP, _onDropComplete);
			view.dragArea.stage.addEventListener(NativeDragEvent.NATIVE_DRAG_EXIT, _onDragExit);
		}

		private function _onDragEnter(event : NativeDragEvent) : void {
			// @TODO: Show DragAreaPreview
			
			_draggingFiles = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			for each (var file : File in _draggingFiles) {
				if (!applicationModel.validFileTypes[file.extension.toLowerCase()])
					return;
			}

			NativeDragManager.acceptDragDrop(view);
		}

		private function _onDropComplete(event : NativeDragEvent) : void {
			Debug.log("UserSelectionMediator - _onDropComplete");
			_draggingFiles = event.clipboard.getData(ClipboardFormats.FILE_LIST_FORMAT) as Array;
			_userEvent = new UserEvent(UserEvent.SELECT_INITIAL_FILE, true, false);
			_userEvent.payload = {filepath:_draggingFiles[0].nativePath};
			eventDispatcher.dispatchEvent(_userEvent);
		}

		private function _onDragExit(event : NativeDragEvent) : void {
			// @TODO: Cancel DragAreaPreview
		}

		private function _onFileSelectClick(event : MouseEvent) : void {
			_selectedUserFile = new File();
			_selectedUserFile.addEventListener(Event.SELECT, _onInputFileSelected);
			_selectedUserFile.browse([applicationModel.fileFilter]);
		}

		private function _onInputFileSelected(event : Event) : void {
			_userEvent = new UserEvent(UserEvent.SELECT_INITIAL_FILE, true, false);
			_userEvent.payload = {filepath:_selectedUserFile.nativePath};
			eventDispatcher.dispatchEvent(_userEvent);
		}
	}
}
