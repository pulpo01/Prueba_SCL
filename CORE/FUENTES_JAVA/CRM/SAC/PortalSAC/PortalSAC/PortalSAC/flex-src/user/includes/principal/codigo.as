// -------------------------------------------------------------------------------------------------------------------
import Consultas.Genericos.RegistrarConsulta;

import flash.events.TimerEvent;
import flash.utils.Timer;

import generated.webservices.orquestador.*;

import mx.core.Application;
import mx.events.CloseEvent;

public var wsORQOOSS:WSSEGPortal = new WSSEGPortal();
public var registrarConsultaCierre:Class = RegistrarConsulta;
public var minuteTimer:Timer;
public var paso:String = 'NO';

    private function init():void {
   
		var fecha:Date = new Date();
		lblFecha.text = fecha.getDate().toString() + " de " + vecMeses[fecha.getMonth()] + " de " + fecha.getFullYear().toString() + " V1.0";
		
		Application.application.boxOOSS = this.vbOOSS;
		Application.application.tabAreasTrabajo = this.tab1;
		Application.application.lblPathTitulo = this.lblDatosSeleccionados;
		Application.application.urlGeneraPdf = StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("urlGeneraPDF","VALOR");
		loadSearch();

		//Se llama al Ws para validar OOSS en ejecucion
		minuteTimer = new Timer(parseInt(StringUtil.getValor("timeRefrescoWS","VALOR")), 5);
            
        // designates listeners for the interval and completion events
        minuteTimer.addEventListener(TimerEvent.TIMER, cargaWS);
        minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, iterar);
            
        // starts the timer ticking
        minuteTimer.start();

		//timer = setInterval(loadSearch, 3000); 
    } // init
    
    
// -------------------------------------------------------------------------------------------------------------------

	private function getError(event:FaultEvent):void    {        
		
		Application.application.sesionFlagButon = false;
		
		try{
			//Se detien el proceso de consulta de OOSS en proceso
			minuteTimer.stop();
		} catch (error:Error) {
		}
		
		if(paso == 'NO'){
			paso = 'SI';
			if(flash.external.ExternalInterface.call('controlSession')) {
				/*
				var mensaje:String = new String();
				mensaje = event.fault.faultString + "\n" + event.fault.faultDetail;
		     	Alert.show(mensaje, "Error en la aplicación");
		     	*/
		     	
		     	var url:String = new String();
				url = StringUtil.getValor("urlApplicationLogout","VALOR");
				var urlLogout:URLRequest = new URLRequest(url);
				navigateToURL(urlLogout, "_top");
		     	
	  		}
  		}
     	
	} // getError
 		
// -------------------------------------------------------------------------------------------------------------------
 	
	private function modEventHandler(e:ModuleEvent):void {
	
		vb1.removeAllChildren();
		vb1.addChild(Application.application.info.factory.create() as DisplayObject);
		vb1.label="Búsqueda";
		//clearInterval(timer);
		
	} // modEventHandler

// -------------------------------------------------------------------------------------------------------------------
	
	private function loadSearch():void	{
	
		Application.application.info = ModuleManager.getModule("Busqueda.swf");
		Application.application.info.addEventListener(ModuleEvent.READY, modEventHandler)
		Application.application.info.load();
		
	 } // buscar

// -------------------------------------------------------------------------------------------------------------------

	private function logout():void	{

		if (StringUtil.getValor("urlApplicationLogout","VALOR") != "")	{
			Alert.yesLabel = "Si";
			Alert.noLabel = "No";
			
			Alert.show( "Desea salir de la aplicación ?", 
						"Advertencia", 
						mx.controls.Alert.YES|mx.controls.Alert.NO,
						this,
						logoutHandler,
						iconWarning,
						mx.controls.Alert.YES);
		}
		else
			Alert.show( "Falta el parámetro urlApplication en el archivo de propiedades", 
						"Error", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );		
	}	// logout
		
// -------------------------------------------------------------------------------------------------------------------
	
	private function logoutHandler(e:CloseEvent):void	{
		
		if (e.detail == 1)	{
			
			var  okRegistrar:Boolean = false;
			
			try{
				//Se detien el proceso de consulta de OOSS en proceso
				minuteTimer.stop();
			} catch (error:Error) {
			}
			
			if(Application.application.sesionFlagButon){
				okRegistrar = true;
			}
		
			if(okRegistrar){
				if (Application.application.flagVentanaConsultas!=true){
					registrarConsultaCierre.tipo = Application.application.sesionTipoBus;
					registrarConsultaCierre.fechaRegistrada = Application.application.sesionDate;
					
					//Luego de guardar el registro realiza el cierre
					registrarConsultaCierre.flagCierreApp = true;
					popUpParent = this;
					popUpWindow = PopUpManager.createPopUp(popUpParent, registrarConsultaCierre, true);
					PopUpManager.centerPopUp(popUpWindow);
				}
				
			}else{
				//Flujo original de cierre
				var url:String = new String();
				url = StringUtil.getValor("urlApplicationLogout","VALOR");
				var urlLogout:URLRequest = new URLRequest(url);
				navigateToURL(urlLogout, "_top");
				
			}
		
		} // if
					
	} // logoutHandler

// -------------------------------------------------------------------------------------------------------------------

	// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Moraga
		// Version : 1.0
		// Fecha : 02/08/2010
		// ------------------------------------------------------------------------------------------	
	
		private function cargaWS(event:TimerEvent):void	{

			try{
				wsORQOOSS.addWSSEGPortalFaultEventListener(getError);
				wsORQOOSS.addconsultaOoSsProcesoEventListener(getData);
				wsORQOOSS.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
				wsORQOOSS.consultaOoSsProceso(Application.application.parameters.usuario);			
			} catch (error:Error) {
			}
			
		} // getDataOOSSxNomUsuario  
		
		// ------------------------------------------------------------------------------------------
        
        private function getData(event:ConsultaOoSsProcesoResultEvent):void{
		
			try{
		    	if(event.result){
		    		txtOOSSEjecutadas.text = "Existen OOSS en Proceso de Ejecución";
		    		imgBuscarOossEjc.enabled = true;
		    	}else{
		    		txtOOSSEjecutadas.text = "";
		    		imgBuscarOossEjc.enabled = false;
		    	}
		    } catch (error:Error) {
			}
			
			wsORQOOSS.removeEventListener(ConsultaOoSsProcesoResultEvent.ConsultaOoSsProceso_RESULT,getData);
   		}
   		
		
		// ------------------------------------------------------------------------------------------

   		private function iterar(event:TimerEvent):void{
   			
   			try{
	   			//Se llama al Ws para validar OOSS en ejecucion
				minuteTimer = new Timer(parseInt(StringUtil.getValor("timeRefrescoWS","VALOR")), 5);
		            
		        // designates listeners for the interval and completion events
		        minuteTimer.addEventListener(TimerEvent.TIMER, cargaWS);
		        minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, iterarDos);
		            
		        // starts the timer ticking
		        minuteTimer.start();
	        } catch (error:Error) {
			}
	        
   		}
   			
   		private function iterarDos(event:TimerEvent):void{
   			
   			try{
	   			//Se llama al Ws para validar OOSS en ejecucion
				minuteTimer = new Timer(parseInt(StringUtil.getValor("timeRefrescoWS","VALOR")), 5);
		            
		        // designates listeners for the interval and completion events
		        minuteTimer.addEventListener(TimerEvent.TIMER, cargaWS);
		        minuteTimer.addEventListener(TimerEvent.TIMER_COMPLETE, iterar);
		            
		        // starts the timer ticking
		        minuteTimer.start();
	        } catch (error:Error) {
			}
   			
   		}

   		private function obtenerParametrosKiosco():void{
							
			trace("obtenerParametrosKiosco() [inicio]");
			
			wsORQOOSS.addWSSEGPortalFaultEventListener(getError);
			wsORQOOSS.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
			wsORQOOSS.addobtenerParametroKioscoEventListener(procesarParametrosKiosco);
			wsORQOOSS.obtenerParametroKiosco();
			
			trace("obtenerParametrosKiosco() [fin]");
			
		}
		
		private function procesarParametrosKiosco(event:ObtenerParametroKioscoResultEvent):void	{
			
			if (event.result.codError == null){
				
				if("TRUE" == event.result.flagKiosco){
				
					this.toolbarKiosko.visible = true;
						
				}else{
				
					this.toolbarKiosko.visible = false;
					
				}
				
				Application.application.dominioKiosco = event.result.dominioKiosco;
				
			}else{
				
				Alert.show( event.result.desError, 
							"Advertencia", 
							mx.controls.Alert.OK,
							this,
							null,
							iconWarning,
							mx.controls.Alert.OK );
														
			}
			
		}