	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	import flash.events.Event;
	import flash.external.ExternalInterface;
	import flash.net.LocalConnection;
	import flash.utils.setTimeout;
	
	import mx.controls.Alert;
	import mx.core.Application;
	
	import user.libreria.componentes.scrollbars.BarraDeProgreso3;

	public var popUpWindowSTP:IFlexDisplayObject;
	public var registrarConsulta:Class = RegistrarConsulta;
	public var searchingStop:Class = BarraDeProgreso3;
	
	private var conn:LocalConnection;
	private var connRetorno:LocalConnection;
	private var flagCerrar:Boolean = false;
	

	private function buscarPorCuenta(evento:String):void	{
		grupo2.selectedValue='Asc';
		if (gridCuentas.dataProvider.length == 0 && evento=="desdeCuentaClick")
			return;
	
		var validacion:ValidationResultEvent;
		var subOpcion:String;
				
		valTxtCuentaString.enabled = true;
		valTxtCuentaNumber.enabled = true;
		txtSearchCuenta.text = txtSearchCuenta.text.toUpperCase();
		
		if(evento == 'desdeCuentaButton' && cmboSearchCuenta.selectedItem.data == 0){
			Application.application.flagButon = true;
		}else{
			Application.application.flagButon = false;
		}
 
		if (evento == "desdeCuentaButton")	{						
			switch (cmboSearchCuenta.selectedItem.data)	{
				case 0:
					validacion = valTxtCuentaNumber.validate();
					valTxtCuentaString.enabled = false;
					subOpcion = "numCtaBtn";						
					break;
				case 1:
					validacion = valTxtCuentaString.validate();
					valTxtCuentaNumber.enabled = false;
					subOpcion = "nomCuentaBtn";						
					break;
				case 2:
					validacion = valTxtCuentaString.validate();
					subOpcion = "numIdentifBtn";						
			} // switch 
	
			if (validacion.type == ValidationResultEvent.VALID)	{
				// Cuentas
				valTxtCuentaString.enabled = false;
				valTxtCuentaNumber.enabled = false;
 
				executeWS("buscarPorCuenta", subOpcion, evento);
			} // if
			else{
				
				//se deshabilita los radio buton de las cuentas
				bloqAndDesBloqRadio('bloqCta');
				
				Alert.show( "Dato de la búsqueda Incorrecto.", 
					"Advertencia", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
					txtSearchCuenta.text = "";
					acGridCuenta = null;
			} // else
		}	// if
		
		
		if (evento == "desdeCuentaClick")	{
			// Cuentas
			valTxtCuentaString.enabled = false;
			valTxtCuentaNumber.enabled = false;

			executeWS("buscarPorCuenta", "cuentaClick", evento)
		}	// if
		
	} // buscarPorCuenta

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------

	private function buscarPorCliente(evento:String):void	{
		grupo4.selectedValue='Asc';
		if (gridClientes.dataProvider.length == 0 && evento=="desdeClienteClick")
			return;

		var validacion:ValidationResultEvent;
		var subOpcion:String;
		
		valTxtClienteString.enabled = true;
		valTxtClienteNumber.enabled = true;
		txtSearchCliente.text = txtSearchCliente.text.toUpperCase();


		if(evento == 'desdeClienteButton' && cmboSearchCliente.selectedItem.data == 0){
			Application.application.flagButon = true;
		}else{
			Application.application.flagButon = false;
		}

		if (evento == "desdeClienteButton")	{						
			switch (cmboSearchCliente.selectedItem.data)	{
				case 0:
					validacion = valTxtClienteNumber.validate();
					valTxtClienteString.enabled = false;
					subOpcion = "numCliBtn";						
					break;
				case 1:
					validacion = valTxtClienteString.validate();
					valTxtClienteNumber.enabled = false;
					subOpcion = "nomCliBtn";						
			} // switch 
	
			if (validacion.type == ValidationResultEvent.VALID)	{
				// Cuentas
				valTxtClienteString.enabled = false;
				valTxtClienteNumber.enabled = false;
		 
				executeWS("buscarPorCliente", subOpcion, evento)
			} // if
			else{
				
				//se deshabilita los radio buton de cliente
				bloqAndDesBloqRadio('bloqClie');
				
				Alert.show( "Dato de la búsqueda Incorrecto.", 
					"Advertencia", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
					txtSearchCliente.text = "";
					acGridCliente = null;
			} // else
		}	// if
		
		if (evento == "desdeClienteClick")	{
			// Cuentas
			valTxtClienteString.enabled = false;
			valTxtClienteNumber.enabled = false;
			
			executeWS("buscarPorCliente", "clienteClick", evento)
		}	// if
		
	} // buscarPorCliente

	// -------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 19/12/08
	// ------------------------------------------------------------------------------------------

	private function buscarPorAbonado(evento:String):void	{
	grupo6.selectedValue='Asc';
		if (gridAbonados.dataProvider.length == 0 && evento=="desdeAbonadoClick")		
			return;
		
		var validacion:ValidationResultEvent;
		var subOpcion:String;
		
		valTxtAbonadoNumber.enabled = true;
		txtSearchAbonado.text = txtSearchAbonado.text.toUpperCase();
		
		//Registro origen
		if(evento == 'desdeAbonadoButton' && cmboSearchAbonado.selectedItem.data == 0){
			Application.application.flagButon = true;	
		}else{
			Application.application.flagButon = false;
		}
		
		if (evento == "desdeAbonadoButton")	{						
			switch (cmboSearchAbonado.selectedItem.data)	{
				case 0:
					 validacion = valTxtAbonadoNumber.validate();
					  subOpcion = "numCeluBtn";						
					break;
			} // switch 
	
			if (validacion.type == ValidationResultEvent.VALID)	{
				// Cuentas 
				valTxtAbonadoNumber.enabled = false;
				executeWS("buscarPorAbonado", subOpcion, evento);
			} // if
			else{
				
				//se deshabilita los radio buton de Abonado
				bloqAndDesBloqRadio('bloqAbo');
				
				Alert.show( "Dato de la búsqueda Incorrecto.", 
					"Advertencia", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
					txtSearchAbonado.text = "";
					acGridAbonado = null;
			}
			
		}	// if
		
	
		if (evento == "desdeAbonadoClick")	{
			// Cuentas
			valTxtAbonadoNumber.enabled = false;
			executeWS("buscarPorAbonado", "desdeAbonadoClick", evento)
		}	// if
		
	} // buscarPorAbonado

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------
	
  	private function changeCmboSearchCuenta(event:Event):void {
		txtSearchCuenta.errorString = "";
	} // changeCmboSearchCuenta

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------

  	private function changeCmboSearchCliente(event:Event):void {
		txtSearchCliente.errorString = "";
	} // changeCmboSearchCliente

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------

  	private function changeCmboSearchAbonado(event:Event):void {
		txtSearchAbonado.errorString = "";
	} // changeCmboSearchAbonado

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 20/08/2010
	// ------------------------------------------------------------------------------------------

	private function levantaRegistrarConsulta(tipoIng:String, sesionFecha:String):void {
		
		var okRegistrar:Boolean = false;
		
		if(Application.application.flagButon){
		
			if(tipoIng == 'Abonado'){
		
				//if(Application.application.flagConsultaAbo > 0){
				if(Application.application.sesionFlagButon){
					okRegistrar = true;
					//}
				}else{
					Application.application.sesionNumAbo = Application.application.aboSelect;
					Application.application.sesionFlagButon = true;
					//Application.application.flagConsultaAbo = Application.application.flagConsultaAbo + 1;
				}
			
			}else if(tipoIng == 'Cliente'){
				
				//if(Application.application.flagConsultaClie > 0){
				if(Application.application.sesionFlagButon){
					okRegistrar = true;
					//}
				}else{
					Application.application.sesionCodClie = Application.application.cliSelect;
					Application.application.sesionFlagButon = true;
					//Application.application.flagConsultaClie = Application.application.flagConsultaClie + 1;
				}
				
			}else if(tipoIng == 'Cuenta'){
				
				//if(Application.application.flagConsultaCta > 0){
				if(Application.application.sesionFlagButon){
					okRegistrar = true;
					//}
				}else{
					Application.application.sesionNumCta = Application.application.ctaSelect;
					Application.application.sesionFlagButon = true;
					//Application.application.flagConsultaCta = Application.application.flagConsultaCta + 1;
				}
				
			}
		
		}else if(Application.application.sesionFlagButon){
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
			
			registrarConsulta.tipo = Application.application.sesionTipoBus;
			registrarConsulta.fechaRegistrada = sesionFecha;
			popUpParent = this;
			popUpWindow = PopUpManager.createPopUp(popUpParent, registrarConsulta, true);
			PopUpManager.centerPopUp(popUpWindow);
			
		}
		
	} // levantaRegistrarConsulta
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------
	
	public function openUrlSTP() : void {
		trace("openUrlSTP() [inicio]");
		/*if(!flash.external.ExternalInterface.call('controlPerfil')) {
    	 	Alert.show("No cumple con los permisos necesarios para realizar esta operación.","Advertencia");
    	}*/
    	if(!Application.application.activarBtnAccesoPortalSTP.activar ) {
    	 	trace("No tiene acceso por SCL");
    	 	Alert.show("No cumple con los permisos necesarios para realizar esta operación.", "Advertencia");
    	}
    	else {
    		trace("Tiene acceso por SCL");
	    	if (gridAbonados.selectedIndex == -1) {
				Alert.show("Debe seleccionarse un abonado antes de efectuar servicio técnico postventa","Advertencia");
			} 
			else if(gridAbonados.rowCount < 1) {
				Alert.show("Debe seleccionarse un abonado antes de efectuar servicio técnico postventa","Advertencia");
			}else if(Application.application.openSTP){
				Alert.show("STP se encuentra activo","Advertencia");
			}else{
				
				// Barra de proceso
			    popUpParent = Application.application.document;
			    popUpWindowSTP = PopUpManager.createPopUp(popUpParent,searchingStop,true);
				PopUpManager.centerPopUp(popUpWindowSTP);
				
				var url:String = StringUtil.getValor("AppServerRootURLSTP","VALOR") + "/PortalSTP";
				
				//open de Url de Portal STP
				flash.external.ExternalInterface.call('abrirSTP', url)
				
				/*
		    	var url :URLRequest = new URLRequest(StringUtil.getValor("AppServerRootURLSTP","VALOR") + "/PortalSTP");
		        navigateToURL(url, "_blank")
		        */
		        
		        //Se inicia Conexion
		        setTimeout(initConn,5000);
		        
		        //Se inicia conexion de retorno
		       setTimeout(InitConnRetorno,12000);
		       
	        }
     	}
        
    }


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------
	
	public function initConn():void {
	
		//btnSend.addEventListener(MouseEvent.CLICK, sendMessage);
		conn = new LocalConnection();
		conn.addEventListener(StatusEvent.STATUS, onStatus);
		
		setTimeout(sendMessage,3000);
		
	}

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------

	public function sendMessage():void {
		
		//Usuario conectado
		var usuarioLogin:String = Application.application.parameters.usuario;
		//Num Abonado
		var numAbo:Number = gridAbonados.selectedItem.numAbonado;	
		var numCelAbo:Number = gridAbonados.selectedItem.numCelular;
		
		trace("Datos ENVIO");
		trace("usuarioLogin:"+usuarioLogin);
		trace("numAbo:"+numAbo);
		trace("numCelAbo:"+numCelAbo);
		trace("flagCerrar:"+flagCerrar);
		trace("Datos ENVIO");
	
		try{
			conn.send("taskConnection", "localconnectionHandler", usuarioLogin, numAbo, numCelAbo, flagCerrar);
		} catch (error:Error) {
			trace("No se puede enviar a Portal STP.");
			setTimeout(restablecerPortalSAC,3000);
		}
	}

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------

	public function onStatus(event:StatusEvent):void {
		switch (event.level) {
			case "status":{
				trace("Conexion de envio establecida con Portal STP");
				flagCerrar = false;
				Application.application.openSTP = true;
				break;
			}
			case "error":{
				trace("Falla de conexion de envio con Portal STP");
				//flagCerrar = true;
				setTimeout(sendMessage,3000);
				break;
			}
			
		}
	
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------
	
	public function InitConnRetorno():void{
		
		connRetorno = new LocalConnection();
		connRetorno.client = this;
		
		try {
			connRetorno.connect("taskConnectionRetorno");
		}catch (error:Error) {
			trace("No se puede conectar el retorno con Portal STP.");
			setTimeout(restablecerPortalSAC,3000);
		}
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 23/08/2010
	// ------------------------------------------------------------------------------------------
	 			     
	public function restablecerPortalSAC():void {

		//Se restablece flag de Open STP
		Application.application.openSTP = false;
			
		//Cierre de conexion
		try{
			conn.close();
		} catch (error:Error) {
			trace("Error cierre conexion de envio:"+error);
		}
		try{
			connRetorno.close();
		} catch (error:Error) {
			trace("Error cierre conexion de retorno:"+error);
		}
			
		//Cierre barra de progreso
		PopUpManager.removePopUp(popUpWindowSTP);
		
	}

