
	import Consultas.Genericos.RegistrarConsulta;
	
	import flash.events.HTTPStatusEvent;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	
	import user.libreria.clases.StringUtil;

	public var errorCarga:Boolean = false;
	public var paramUser:String;
	public var paramServer:String; 
	
	public const user:String = "ONOVOA";
	public const srv:String = "http://eq90445:19120/";
	
	public var registrarConsulta:Class = RegistrarConsulta;
	
	//public const user:String = "ONOVOA";
	//public const srv:String = "http://127.0.0.1:7001/";
	
	
	// --------------------------------------------------------------------------------
	
	private function init():void	{
		
		//Security.loadPolicyFile("http://127.0.0.1:7001/crossdomain.xml");
		
		//Se incian valores
		seteoInicialDato();
		
		// Barra de proceso
	    popUpParent = Application.application.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);
		// Tomo el usuario que se ha logueado a la aplicacion para fines de auditoria y llamado a OOSS
		paramUser = Application.application.parameters.usuario;
		paramServer = Application.application.parameters.server;
		var indice:Number = paramServer.indexOf("//");
		var newServer:String = paramServer.slice(indice,paramServer.length);
		paramServer = "http:" + newServer;
		usuario.username = paramUser.toUpperCase();
		// Si esta corriendo localmente toma el seteo en duro para desarrollo y testing
		seteoLocal();
		// Cargo los properties del sistema
		loadPropiedadesGenerales(paramServer);
		// Cargo las configuraciones de las OOSS
		loadConfigOOSS(paramServer);
		// Cargo las configuraciones de las consultas de busquedas
		loadConfigHttpServices(paramServer);
		// Cargo las configuraciones de las consultas
		loadConfigConsultas(paramServer);

	} // init

	private function seteoInicialDato():void	{
	
		//Flag tipo consulta y cuantas consultas
		//Application.application.flagConsultaCta = 0;
		//Application.application.flagConsultaClie = 0;
		//Application.application.flagConsultaAbo = 0;
		
		//Datos consulta guardada en session
		Application.application.sesionNumCta = 0;
		Application.application.sesionCodClie = 0;
		Application.application.sesionNumAbo = 0;

	}

	// --------------------------------------------------------------------------------
	
	private function seteoLocal():void	{
		
		var indice:int = this.url.indexOf("file://"); 
		if (indice >= 0)	{
			this.paramUser=user;
			this.paramServer=srv;
		} // if
		
	} // seteoLocal 

	// --------------------------------------------------------------------------------
	
	private function loadPropiedadesGenerales(paramServer:String):void	{
		
		servPropGenerales.addEventListener(FaultEvent.FAULT, getErrorProperties);
		servPropGenerales.addEventListener(HTTPStatusEvent.HTTP_STATUS, getErrorProperties);
		servPropGenerales.method="POST";
		servPropGenerales.resultFormat="e4x";
		servPropGenerales.addEventListener(ResultEvent.RESULT,getProperties);
		servPropGenerales.url = paramServer + "ConsultaSACWEB/ConsultasPropiedades/PortalSACConfig";				
		servPropGenerales.send();
			
	} // loadPropiedadesGenerales
	
	// --------------------------------------------------------------------------------

	private function loadConfigOOSS(paramServer:String):void	{
		
		servPropOOSS.addEventListener(FaultEvent.FAULT, getErrorProperties);
		servPropOOSS.method="POST";
		servPropOOSS.resultFormat="e4x";
		servPropOOSS.addEventListener(ResultEvent.RESULT,getConfigOOSS);
		servPropOOSS.url = paramServer + "ConsultaSACWEB/ConsultasPropiedades/OOSSConfig";				
		servPropOOSS.send();
		
	} // loadConfigOOSS
	
	// --------------------------------------------------------------------------------
	
	private function loadConfigHttpServices(paramServer:String):void	{

		servPropHTTP.addEventListener(FaultEvent.FAULT, getErrorProperties);
		servPropHTTP.method="POST";
		servPropHTTP.resultFormat="e4x";
		servPropHTTP.addEventListener(ResultEvent.RESULT,getConfigHttpServices);
		servPropHTTP.url = paramServer + "ConsultaSACWEB/ConsultasPropiedades/HttpServicesConfig";				
		servPropHTTP.send();
				
	} // loadConfigHttpServices
	
	// --------------------------------------------------------------------------------	

	private function loadConfigConsultas(paramServer:String):void	{

		servPropConsultas.addEventListener(FaultEvent.FAULT, getErrorProperties);
		servPropConsultas.method="POST";
		servPropConsultas.resultFormat="e4x";
		servPropConsultas.addEventListener(ResultEvent.RESULT,getConfigConsultas);
		servPropConsultas.url = paramServer + "ConsultaSACWEB/ConsultasPropiedades/ConsultasConfig";				
		servPropConsultas.send();
				
	} // loadConfigConsultas
	
	// --------------------------------------------------------------------------------	
	private function getConfigConsultas(event:ResultEvent):void	{
		xmlConfigConsultas = new XML(event.result);
		if (xmlConfigHttpServices!=null && xmlConfig !=null && xmlConfigOOSS !=null && xmlConfigConsultas != null)	{
			PopUpManager.removePopUp(popUpWindow);
			login();
		}
	} // getConfigConsultas
	
	// --------------------------------------------------------------------------------

	private function getConfigHttpServices(event:ResultEvent):void	{
		xmlConfigHttpServices =	new XML(event.result);
		if (xmlConfigHttpServices!=null && xmlConfig !=null && xmlConfigOOSS !=null && xmlConfigConsultas != null)	{
			PopUpManager.removePopUp(popUpWindow);
			login();
		}
	} // getConfigHttpServices
	
	// --------------------------------------------------------------------------------
	private function getConfigOOSS(event:ResultEvent):void	{
		xmlConfigOOSS =	new XML(event.result);
		if (xmlConfigHttpServices!=null && xmlConfig !=null && xmlConfigOOSS !=null && xmlConfigConsultas != null)	{
			PopUpManager.removePopUp(popUpWindow);
			login();
		}
	} // getProperties
	
	// --------------------------------------------------------------------------------
	
	private function getErrorProperties(event:FaultEvent):void    {
		       
		if (!errorCarga)	{
			errorCarga = true;
			PopUpManager.removePopUp(popUpWindow);
		
	 		Alert.show( "Existe un problema por el cual no se ha podido configurar la aplicación. No es posible continuar.", 
					"Error en la aplicación", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
		} // if
			    	
	} // getError

	// --------------------------------------------------------------------------------
	
	private function getProperties(event:ResultEvent):void	{
		xmlConfig=	new XML(event.result);
		
		if (StringUtil.getValor("validaPuerto","VALOR") == "1")	{
			if (validaPuertoSSL() == false)	{
				Alert.show( "La aplicación no está corriendo sobre la plataforma adecuada.", 
							"Error", 
							mx.controls.Alert.OK,
							this,
							null,
							iconWarning,
							mx.controls.Alert.OK );
			
				this.removeAllChildren();
				this.setVisible(false);
			} // if
		} // if			

		if (xmlConfigHttpServices!=null && xmlConfig !=null && xmlConfigOOSS !=null && xmlConfigConsultas != null)	{
			PopUpManager.removePopUp(popUpWindow);
			login();
		}

		
	} // getProperties
	
	// --------------------------------------------------------------------------------
	
	private function validaPuertoSSL():Boolean	{
		
		if ( parseInt(StringUtil.getPort(this.url)) == parseInt(StringUtil.getValor("puertoSSL","VALOR")))
			return true;
		else
			return false;
			
	} // validaPuertoSSL
	
	// --------------------------------------------------------------------------------
	
	private function getError(event:FaultEvent):void    {
		        
		PopUpManager.removePopUp(popUpWindow);
		
		Application.application.sesionFlagButon = false;
		
		if(flash.external.ExternalInterface.call('controlSession')) {
			
			/*
			var mensaje:String = new String();
			mensaje = "Ha ocurrido un error en la petición a los servicios.";
			Alert.show( mensaje, 
								"Error en la aplicación", 
								mx.controls.Alert.OK,
								this,
								null,
								iconWarning,
								mx.controls.Alert.OK );
			*/
			
			var url:String = new String();
			url = StringUtil.getValor("urlApplicationLogout","VALOR");
			var urlLogout:URLRequest = new URLRequest(url);
			navigateToURL(urlLogout, "_top");
			
		}
     	
	} // getError
	
	// --------------------------------------------------------------------------------
	
	private function modEventHandler(e:ModuleEvent):void {

		Application.application.removeAllChildren();
		Application.application.setStyle("backgroundImage", "");
    	this.addChild(info.factory.create() as DisplayObject);
    	
	} // modEventHandler
	
	// --------------------------------------------------------------------------------

   	private function login():void	{

		if (xmlConfigHttpServices!=null && xmlConfig !=null && xmlConfigOOSS !=null && xmlConfigConsultas !=null)
			timer = setInterval(loadPrincipal, 500);
		else	
			getErrorProperties(null); 
		
	 } // login	


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------
	
	private function loadPrincipal():void	{
	
		// -- Si ok entonces carga modulo principal
		info = ModuleManager.getModule("Principal.swf");
		info.load();
		info.addEventListener(ModuleEvent.READY, modEventHandler);
		clearInterval(timer);

	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 12/09/2010
	// ------------------------------------------------------------------------------------------
	
	private function levantaRegistrarConsultaExit():void {

		if(!Application.application.flagVentanaConsultas){

			if(cantIntentos == 0){
	
				var okRegistrar:Boolean = false;
				var tipoIng:String = Application.application.sesionTipoBus;
	
				if(Application.application.sesionFlagButon){
					/*
					if(tipoIng == 'Abonado'){
				
						if(Application.application.flagConsultaAbo > 0){
								okRegistrar = true;
						}
					
					}else if(tipoIng == 'Cliente'){
						
						if(Application.application.flagConsultaClie > 0){
								okRegistrar = true;
						}
						
					}else if(tipoIng == 'Cuenta'){
						
						if(Application.application.flagConsultaCta > 0){
								okRegistrar = true;
						}
						
					}
					*/
					okRegistrar = true;
				}
	
				if(okRegistrar){
			
					Application.application.cantIntentos = Application.application.cantIntentos + 1;
				
					registrarConsulta.tipo = tipoIng;
					registrarConsulta.estadoGuarda = true;
					registrarConsulta.fechaRegistrada = Application.application.sesionDate;
					popUpParent = this;
					popUpWindow = PopUpManager.createPopUp(popUpParent, registrarConsulta, true);
					PopUpManager.centerPopUp(popUpWindow);
						
				}
			
			}
			
		}
		
	} // levantaRegistrarConsulta
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 12/09/2010
	// ------------------------------------------------------------------------------------------
	
	private function validarEstadoOK():Boolean {
		
		var okRegistrar:Boolean = true;
		
		//var tipoIng:String = Application.application.sesionTipoBus;
		
		if(Application.application.sesionFlagButon){
			/*
			if(tipoIng == 'Abonado'){
			
				if(Application.application.flagConsultaAbo > 0){
						okRegistrar = Application.application.estadoGuaOK;
				}
				
			}else if(tipoIng == 'Cliente'){
					
				if(Application.application.flagConsultaClie > 0){
						okRegistrar = Application.application.estadoGuaOK;
				}
					
			}else if(tipoIng == 'Cuenta'){
					
				if(Application.application.flagConsultaCta > 0){
						okRegistrar = Application.application.estadoGuaOK;
				}
					
			}
			*/
			
			okRegistrar = Application.application.estadoGuaOK;
		}
		
		return okRegistrar;
	}

	// --------------------------------------------------------------------------------
