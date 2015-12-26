package com.beautifycode.lamer.commands.macros {
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.commands.LoadPreferencesCommand;
	import com.beautifycode.lamer.commands.StartupCommand;
	import com.beautifycode.lamer.controller.events.ApplicationEvent;

	import flash.events.IEventDispatcher;

	/**
	 * @author marvin
	 */
	public class BootMacro extends SequenceMacro {
		[Inject]
		public var event : ApplicationEvent;

		[Inject]
		public var eventDispatcher : IEventDispatcher;

		override public function prepare() : void {
			Debug.log("BootMacro - init (atomic).");

			atomic = true;
			add(StartupCommand);
			add(LoadPreferencesCommand).withPayloads(event.payload);

			registerCompleteCallback(_onBootComplete);
		}

		private function _onBootComplete() : void {
			Debug.log("BootMacro - done.");
			eventDispatcher.dispatchEvent(new ApplicationEvent(ApplicationEvent.BOOT_COMPLETE, true, false));
		}
	}
}
