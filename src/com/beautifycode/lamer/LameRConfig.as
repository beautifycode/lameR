package com.beautifycode.lamer {
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IInjector;

	import com.beautifycode.lamer.commands.ConversionFinishedCommand;
	import com.beautifycode.lamer.commands.SetInitialFilePathCommand;
	import com.beautifycode.lamer.commands.StartConversionCommand;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;
	import com.beautifycode.lamer.services.ConversionService;
	import com.beautifycode.lamer.views.ApplicationView;
	import com.beautifycode.lamer.views.ApplicationViewMediator;
	import com.beautifycode.lamer.views.UserSelectionMediator;
	import com.beautifycode.lamer.views.UserSelectionView;
	import com.beautifycode.lamer.views.UserSettingsMediator;
	import com.beautifycode.lamer.views.UserSettingsView;

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
			injectormap.map(ConversionModel).asSingleton();
			injectormap.map(ApplicationModel).asSingleton();
			injectormap.map(SettingsModel).asSingleton();

			commandmap.map(UserEvent.SELECT_INITIAL_FILE).toCommand(SetInitialFilePathCommand).withPayloadInjection();
			commandmap.map(UserEvent.START_CONVERSION).toCommand(StartConversionCommand);		
			commandmap.map(ConversionEvent.FINISHED).toCommand(ConversionFinishedCommand);

			mediatormap.map(ApplicationView).toMediator(ApplicationViewMediator);
			mediatormap.map(UserSelectionView).toMediator(UserSelectionMediator);
			mediatormap.map(UserSettingsView).toMediator(UserSettingsMediator);
		}
	}
}
