package com.beautifycode.lamer {
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;

	import com.beautifycode.lamer.commands.ConversionFinishedCommand;
	import com.beautifycode.lamer.commands.SetFilePathCommand;
	import com.beautifycode.lamer.commands.StartConversionCommand;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.PreferencesModel;
	import com.beautifycode.lamer.services.ConversionService;
	import com.beautifycode.lamer.views.MainMediator;
	import com.beautifycode.lamer.views.MainView;

	/**
	 * @author marvin
	 */
	public class LameRConfig implements IConfig {
		[Inject]
		public var injectormap : IInjector;

		[Inject]
		public var commandmap : IEventCommandMap;

		[Inject]
		public var mediatormap : IMediatorMap;

		public function configure() : void {
			// @TODO: NNF Singletons
			injectormap.map(ConversionService).asSingleton();
			injectormap.map(PreferencesModel).asSingleton();
			injectormap.map(ConversionModel).asSingleton();

			// carries filepath via dnd&select
			commandmap.map(UserEvent.SELECT_FILE).toCommand(SetFilePathCommand).withPayloadInjection();
			
			// @TODO: Has to be executed from UI w/ settings. FILEPATH_SET > UI change w/ Prelisten
			commandmap.map(ConversionEvent.FILEPATH_SET).toCommand(StartConversionCommand);		
			commandmap.map(ConversionEvent.FINISHED).toCommand(ConversionFinishedCommand);

			mediatormap.map(MainView).toMediator(MainMediator);
		}
	}
}
