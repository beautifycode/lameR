package com.beautifycode.lamer.configs {
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;
	import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
	import robotlegs.bender.framework.api.IConfig;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.api.IInjector;

	import com.beautifycode.helpers.Debug;
	import com.beautifycode.lamer.commands.ConversionFinishedCommand;
	import com.beautifycode.lamer.commands.SetInitialFilePathCommand;
	import com.beautifycode.lamer.commands.StartConversionCommand;
	import com.beautifycode.lamer.commands.macros.BootMacro;
	import com.beautifycode.lamer.commands.macros.ExitMacro;
	import com.beautifycode.lamer.controller.events.ApplicationEvent;
	import com.beautifycode.lamer.controller.events.ConversionEvent;
	import com.beautifycode.lamer.controller.events.UserEvent;
	import com.beautifycode.lamer.models.ApplicationModel;
	import com.beautifycode.lamer.models.ConversionModel;
	import com.beautifycode.lamer.models.SettingsModel;
	import com.beautifycode.lamer.services.ConversionService;
	import com.beautifycode.lamer.views.ApplicationMediator;
	import com.beautifycode.lamer.views.ApplicationView;
	import com.beautifycode.lamer.views.UserSelectionMediator;
	import com.beautifycode.lamer.views.UserSelectionView;
	import com.beautifycode.lamer.views.UserSettingsMediator;
	import com.beautifycode.lamer.views.UserSettingsView;

	import flash.desktop.NativeApplication;
	import flash.events.IEventDispatcher;
	import flash.events.InvokeEvent;

	/**
	 * @author marvin
	 */
	public class LameRBootConfig implements IConfig {
		[Inject]
		public var injectormap : IInjector;

		[Inject]
		public var commandmap : IEventCommandMap;

		[Inject]
		public var mediatormap : IMediatorMap;

		[Inject]
		public var context : IContext;

		[Inject]
		public var eventDispatcher : IEventDispatcher;
		private var _applicationEvent : ApplicationEvent;

		public function configure() : void {
			Debug.log("LameRBootConfig");
			
			injectormap.map(ApplicationModel).asSingleton();
			injectormap.map(ConversionModel).asSingleton();
			injectormap.map(ConversionService).asSingleton();
			injectormap.map(SettingsModel).asSingleton();

			commandmap.map(ApplicationEvent.BOOT).toCommand(BootMacro).withPayloadInjection();
			commandmap.map(ApplicationEvent.EXIT).toCommand(ExitMacro);
			
			commandmap.map(UserEvent.SET_INPUTFILE).toCommand(SetInitialFilePathCommand).withPayloadInjection();
			commandmap.map(UserEvent.START_CONVERSION).toCommand(StartConversionCommand);
			commandmap.map(ConversionEvent.FINISHED).toCommand(ConversionFinishedCommand);

			mediatormap.map(ApplicationView).toMediator(ApplicationMediator);
			mediatormap.map(UserSelectionView).toMediator(UserSelectionMediator);
			mediatormap.map(UserSettingsView).toMediator(UserSettingsMediator);

			context.afterInitializing(_init);
		}

		private function _init() : void {
			NativeApplication.nativeApplication.addEventListener(InvokeEvent.INVOKE, _onAppInvoke);
		}

		private function _onAppInvoke(event : InvokeEvent) : void {
			_applicationEvent = new ApplicationEvent(ApplicationEvent.BOOT, true, false);
			_applicationEvent.payload = {bootWithPath:event.arguments[0]};
			eventDispatcher.dispatchEvent(_applicationEvent);
		}
	}
}
