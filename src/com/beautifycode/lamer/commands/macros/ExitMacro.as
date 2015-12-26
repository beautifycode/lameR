package com.beautifycode.lamer.commands.macros {
	import eu.alebianco.robotlegs.utils.impl.SequenceMacro;

	import com.beautifycode.lamer.commands.GoodByeCommand;
	import com.beautifycode.lamer.commands.SavePreferencesCommand;
	import com.beautifycode.lamer.models.ApplicationModel;

	/**
	 * @author marvin
	 */
	public class ExitMacro extends SequenceMacro {
		[Inject]
		public var applicationModel : ApplicationModel;

		override public function prepare() : void {
			add(GoodByeCommand);
			add(SavePreferencesCommand);
			registerCompleteCallback(_closeApplication);
		}

		private function _closeApplication() : void {
			applicationModel.closeApplication();
		}
	}
}
