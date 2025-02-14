	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		
	import flash.display.DisplayObject;
	import flash.external.ExternalInterface;
	
	import generated.webservices.orquestador.AbonadoDTO;
	import generated.webservices.orquestador.ClienteDTO;
	import generated.webservices.orquestador.SolicitaUrlDominioPuertoResultEvent;
	import generated.webservices.orquestador.WSSEGPortal;
	
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	import user.libreria.componentes.scrollableMenu.controls.ScrollableArrowMenu;
	
	var wsORQ2:WSSEGPortal = new WSSEGPortal();

	private function menuConsultaPopup(event:MenuEvent):void	{
		
		popUpParent = this;
 
	    var opcion:String = event.item.data;
	    var mensajeError:String = null;
	    var nivelConsulta:String = StringUtil.getValor(opcion, "NIVEL")
	   	
	   	Application.application.codEvento = opcion;
	    switch (nivelConsulta)	{
	    	case "CUENTA":
	    		if (validaRequisitos("cuenta") == null)	{
	    			Application.application.numAbonadoDetalle = 0;
	    			Application.application.codClienteDetalle = 0;
	    			Application.application.codCuentaDetalle = gridCuentas.selectedItem.codCuenta;

	    			switch (opcion)	{
	    				case "CI20001":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, infoCuenta);
			    			break;
	    				case "CI20002":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossEjectutadas, true);
			    			break;
	    				case "CI20015":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossAgendadas, true);
	    			}
	    		} // if
	    		else 
	    			mensajeError = "Debe seleccionarse una cuenta antes de efectuar la consulta";
	    		break;	

	    	case "CLIENTE":
	    		if (validaRequisitos("cliente") == null)	{
    				Application.application.numAbonadoDetalle = 0;
	    			Application.application.codCuentaDetalle = 0;
	    			Application.application.codClienteDetalle = gridClientes.selectedItem.codCliente;
	    			Application.application.abonadoDTO = null;	
	    			switch (opcion)	{
	    				case "CI20003":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, infoCliente, true);
			    			break;
	    				case "CI20006":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossEjectutadas, true);
			    			break;
			    		case "CI20004":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, direcClientes, true);
			    			break;
			    		case "CI20005":
			    			var cli:ClienteDTO = new ClienteDTO();
	    					cli.codCliente = gridClientes.selectedItem.codCliente;
	    					cli.codCuenta =  gridClientes.selectedItem.codCuenta;
	    					cli.nomCliente = gridClientes.selectedItem.nomCliente;
			    			Application.application.clienteDTO =  cli;
			    			
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, ctaCteCliente, true);
			    			break;	
			    		case "CI20009":
			    			Application.application.numAbonadoDetalle = 0;
				   			Application.application.codClienteDetalle = gridClientes.selectedItem.codCliente;
				   			
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, listadoProductos, true);
			    			break;
			    		case "CI20016":
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossAgendadas, true);
			    			
	    			}
	    		} // if
	    		else 
	    			mensajeError = "Debe seleccionarse un cliente antes de efectuar la consulta";
	    		break;	

	    	case "ABONADO":
				if (validaRequisitos("abonado") == null)	{
					Application.application.numCelAboSelect = gridAbonados.selectedItem.numCelular;
					switch (opcion)	{
			    		case "CI20013":
			    			if (esAbonadoPospago())	{
					    		var aboDetLlam:AbonadoDTO = new AbonadoDTO();
				    			aboDetLlam.numAbonado = gridAbonados.selectedItem.numAbonado;
				    			aboDetLlam.nomUsuario = gridAbonados.selectedItem.nomUsuario;
				    			Application.application.abonadoDTO = aboDetLlam;
				    			aboDetLlam = null;
			
								var cliDetLlam:ClienteDTO = new ClienteDTO();
				    			cliDetLlam.codCliente = gridAbonados.selectedItem.codCliente;
				    			Application.application.clienteDTO =  cliDetLlam;
				    			cliDetLlam = null;	
		    			
				    			popUpWindow = PopUpManager.createPopUp(popUpParent, detalleLlamadasAbonado, true);
				    		}
				    		else
				    			mensajeError = "No puede accederse a esta consulta si el abonado es prepago.";

			    			break;
						case "CI20010":
			    			Application.application.codCuentaDetalle = 0;
			    			Application.application.codClienteDetalle = 0;	
				   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;
	    			
			    			var abo:AbonadoDTO = new AbonadoDTO();
			    			abo.codCliente = gridAbonados.selectedItem.codCliente;
			    			abo.codCuenta =  gridAbonados.selectedItem.codCuenta;
			    			abo.nomUsuario = gridAbonados.selectedItem.nomUsuario;
			    			abo.numCelular = gridAbonados.selectedItem.numCelular;
			    			abo.codUso =  gridAbonados.selectedItem.codUso;
			    			Application.application.abonadoDTO = abo;	
	    			
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossEjectutadas, true);
			    			break;
						case "CI20007":
				   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;	    			
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, InformacionAbonado, true);
			    			break;
			    		case "CI20011":
					   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;
		    					Application.application.codClienteDetalle = gridAbonados.selectedItem.codCliente;
		    		
				    			var abo1:AbonadoDTO = new AbonadoDTO();
				    			abo1.codCliente = gridAbonados.selectedItem.codCliente;
				    			abo1.codCuenta =  gridAbonados.selectedItem.codCuenta;
				    			abo1.nomUsuario = gridAbonados.selectedItem.nomUsuario;
				    			
				    			Application.application.abonadoDTO = abo1;
		    				    			
				    			popUpWindow = PopUpManager.createPopUp(popUpParent, beneficiosAbonado, true);
			    			break;
						case "CI20008":
				   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, datosEquipoAbonado, true);
			    			break;
			    		case "CI20012":
			    			if (esAbonadoPospago())	{
					   			var abo2:AbonadoDTO = new AbonadoDTO();
								abo2.numAbonado = gridAbonados.selectedItem.numAbonado;	    			
				    			abo2.codCliente = gridAbonados.selectedItem.codCliente;
				    			abo2.codCuenta =  gridAbonados.selectedItem.codCuenta;
				    			abo2.nomUsuario = gridAbonados.selectedItem.nomUsuario;
				    			
				    			Application.application.abonadoDTO = abo2;
								Application.application.codClienteDetalle = gridAbonados.selectedItem.codCliente;
				    			popUpWindow = PopUpManager.createPopUp(popUpParent, limiteConsumoAbonado, true);
			    			} // if
				    		else
				    			mensajeError = "No puede accederse a esta consulta si el abonado es prepago.";
			    			break;
						case "CI20014":
			    			Application.application.codClienteDetalle = 0;
				   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, listadoProductos, true);
			    			break;
			    		case "CI20017":
			    		
			    			Application.application.codCuentaDetalle = 0;
			    			Application.application.codClienteDetalle = 0;	
				   			Application.application.numAbonadoDetalle = gridAbonados.selectedItem.numAbonado;
	    			
			    			var aboRC:AbonadoDTO = new AbonadoDTO();
			    			aboRC.codCliente = gridAbonados.selectedItem.codCliente;
			    			aboRC.codCuenta =  gridAbonados.selectedItem.codCuenta;
			    			aboRC.nomUsuario = gridAbonados.selectedItem.nomUsuario;
			    			aboRC.numCelular = gridAbonados.selectedItem.numCelular;
			    			aboRC.codUso =  gridAbonados.selectedItem.codUso;
			    			Application.application.abonadoDTO = aboRC;	
	    			
			    			popUpWindow = PopUpManager.createPopUp(popUpParent, oossAgendadas, true);
			    								    			
				 	} // switch	    			    		
				} // if
				else 
	    			mensajeError = "Debe seleccionarse un abonado antes de efectuar la consulta";
   			
  	    } // switch
	    
	   	PopUpManager.centerPopUp(popUpWindow);
	   	
	    if (mensajeError != null)
			Alert.show( mensajeError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );	    	
		
	} // menuConsultaPopup

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuCtaOOSS(posX:int, posY:int):void {

		if (Application.application.aMenuCuenta != null)	{
			var lista:ArrayCollection = new ArrayCollection();
			for (var fila:Number=0; fila < Application.application.aMenuCuenta.length; fila++)
				lista.addItem({label:Application.application.aMenuCuenta[fila].descripcion.toUpperCase(), data:Application.application.aMenuCuenta[fila].codOOSS});
				
	        var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, lista, false);
			menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuHandler);
	        menu.maxHeight = 150;
	        menu.show(posX, posY);
		} // if
		
    } // addMenuCtaOOSS

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuCliOOSS(posX:int, posY:int):void {

		if (Application.application.aMenuCliente != null)	{
			var lista:ArrayCollection = new ArrayCollection();
			for (var fila:Number=0; fila < Application.application.aMenuCliente.length; fila++)
				lista.addItem({label:Application.application.aMenuCliente[fila].descripcion.toUpperCase(), data:Application.application.aMenuCliente[fila].codOOSS});
		
	        var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, lista, false);
			menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuHandler);
	        menu.maxHeight = 200;
	        menu.show(posX, posY);
		} // if 
		
    } // addMenuCliOOSS

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuAboOOSS(posX:int, posY:int):void {

		if (Application.application.aMenuAbonado != null)	{
			var lista:ArrayCollection = new ArrayCollection();
			for (var fila:Number=0; fila < Application.application.aMenuAbonado.length; fila++)
				lista.addItem({label:Application.application.aMenuAbonado[fila].descripcion.toUpperCase(), data:Application.application.aMenuAbonado[fila].codOOSS});
			
	        var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, lista, false);
			menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuHandler);
	        menu.maxHeight = 250;
	        menu.show(posX, posY);
		} // if
		
    } // addMenuAboOOSS

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuAboCons(posX:int, posY:int):void {

		if (Application.application.aPopMenuAbonado != null)	{
	        var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, Application.application.aPopMenuAbonado, false);
	        menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuConsultaPopup);
	        menu.maxHeight = 250;
	        menu.show(posX, posY);
		} // if
		        
    } // addMenuAbonado

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuCliCons(posX:int, posY:int):void {
    	
		if (Application.application.aPopMenuCliente != null)	{    	
	        var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, Application.application.aPopMenuCliente, false);
	        menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuConsultaPopup);
	        menu.maxHeight = 250;
	        menu.show(posX, posY);
		} // if
    } // addMenuCliente

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		

    private function addMenuCtaCons(posX:int, posY:int):void {

		if (Application.application.aPopMenuCuenta != null)	{
		    var menu:ScrollableArrowMenu = ScrollableArrowMenu.createMenu(null, Application.application.aPopMenuCuenta, false);
			menu.labelField="label";
	        menu.verticalScrollPolicy = vertScrollPolicy;
	        menu.arrowScrollPolicy = arrowScrollPolicy;
	        menu.addEventListener(MenuEvent.ITEM_CLICK, menuConsultaPopup);
	        menu.maxHeight = 150;
	        menu.show(posX, posY);
		} // if
		
    } // addMenuCuenta


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 07/01/09
	// ------------------------------------------------------------------------------------------
	

  	private function toolbar(event:MouseEvent):void {

		var imagen:mx.controls.Image = event.currentTarget as mx.controls.Image;
		if (imagen.source.toString().indexOf("cambioClave")>=0)
			cambiarClave();
		else if (imagen.source.toString().indexOf("clearForm")>=0)
			clearForm();
	} // toolbar
	

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 07/01/09
	// ------------------------------------------------------------------------------------------
	
	private function clearForm():void {
		
		parentDocument.lblDatosSeleccionados.text = "CUENTA : / CLIENTE :  / ABONADO : ";
		
		Application.application.ctaSelect = null;
	 	Application.application.cliSelect = null;
	 	Application.application.aboSelect = null;
	 	Application.application.nomCliSelect = null;
		Application.application.nomCtaSelect = null;
 		Application.application.numCelAboSelect = null;
 		Application.application.nomAboSelect = null;
 		Application.application.sitAboSelect = null;
 		
		clearFormCuentas(true);		
		clearFormClientes(true);
 		clearFormAbonados(true);
 		
	} // clearForm
	
	
	private function clearFormCuentas(ambito:Boolean):void {

 		txtSearchCuenta.text = "";
 		txtFiltroCuentas.text = "";
 		cboFiltroCuentas.selectedIndex = 0;
		
		if (ambito)	{
			acGridCuenta = null;
 			txtSearchCuenta.errorString = ""; 		
 			cmboSearchCuenta.selectedIndex = 0;
 		} // if 		

	} // clearFormCuentas

	private function clearFormClientes(ambito:Boolean):void {

 		txtSearchCliente.text = "";
 		txtFiltroClientes.text = "";
 		cboFiltroClientes.selectedIndex = 0;

		if (ambito)	{
			acGridCliente = null;
 			cmboSearchCliente.selectedIndex = 0;
 			txtSearchCliente.errorString = "";
 		} // if	 		
 		
	} // clearFormClientes

	private function clearFormAbonados(ambito:Boolean):void {

 		txtSearchAbonado.text = "";
 		txtFiltroAbonados.text = "";
 		cboFiltroAbonados.selectedIndex = 0;
		
		if (ambito)	{
			acGridAbonado = null;
			txtSearchAbonado.errorString = "";
			cmboSearchAbonado.selectedIndex = 0;
		} // if	
 		
	} // clearFormAbonados
		


	private function esAbonadoPospago():Boolean	{
	
		if (gridAbonados.selectedItem.codUso == "PREPAGO")	return false;
		else
			return true;
		
	} 	// Boolean
	
	// ------------------------------------------------------------------------------------------
	// Autor : Rafael Agüero Vega
	// Version : 1.0
	// Fecha : 04/04/2011
	// ------------------------------------------------------------------------------------------
		
		private function getErrors(event:FaultEvent):void    {
		        
		PopUpManager.removePopUp(popUpWindow);
		
		Application.application.sesionFlagButon = false;
		
		if(flash.external.ExternalInterface.call('controlSession')) {
			/*
			var mensaje:String = new String();
			mensaje = event.fault.faultString + "\n" + event.fault.faultDetail;
	     	Alert.show( mensaje, 
						"Advertencia", 
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
	
	// ------------------------------------------------------------------------------------------
	// Autor : Rafael Agüero Vega
	// Version : 1.0
	// Fecha : 04/04/2011
	// ------------------------------------------------------------------------------------------

	private function getSolicitaUrlDominioPuerto(event:SolicitaUrlDominioPuertoResultEvent):void	{
			
			var codEvento:String = this.codOOSSMenu;
			var result:String;
			
			// Reemplazamos los posibles parametros
			var url:String = StringUtil.getValor(this.codOOSSMenu, "PATH");
				
			var usuario:String = parentApplication.usuario.username;		
			if(event.result.strUrlDomPuer != '0'){
				
				url = url.replace("%COD_CLIENTE%",Application.application.cliSelect );
				url = url.replace("%NUM_ABONADO%", Application.application.aboSelect);
				url = url.replace("%COD_CUENTA%", Application.application.ctaSelect);
				url = url.replace("%USERNAME%", usuario);
				url = url.replace("%DOMINIO_OOSS%", event.result.strUrlDomPuer);
				
				//ejecuta el metodo JSP externo para asi ejecutar JAVA o cualquier otro evento externo
				result = ExternalInterface.call("ejecutaOOSSExterna", url, StringUtil.getValor("widthOOSSWin", "VALOR"), StringUtil.getValor("heightOOSSWin", "VALOR"));
			}
			//Metodo que limpia la ejecucion del servicio JAVA.pasa asi no pisar datos anteriores.
			
			wsORQ2.removeEventListener(SolicitaUrlDominioPuertoResultEvent.SolicitaUrlDominioPuerto_RESULT,getSolicitaUrlDominioPuerto);
				
	} //   
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 09/01/09
	// ------------------------------------------------------------------------------------------
	
	
	
	private function ejecutaOOSSExterna():void	{
	
		if (ExternalInterface.available) {
			// Se invoca al WS para efectuar la auditoria		
			
			var codEvento:String = this.codOOSSMenu;
			
			//Envio al servicio java el cual retorna la URL con el dominio y el puerto, y estos son asignados a la variable strDominio
	 		wsORQ2.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
			wsORQ2.addWSSEGPortalFaultEventListener(getErrors);
			wsORQ2.addsolicitaUrlDominioPuertoEventListener(getSolicitaUrlDominioPuerto);
			wsORQ2.solicitaUrlDominioPuerto(this.codOOSSMenu);

		} // if	
		else
			Alert.show( "Error en la comunicación en la interface de OOSS externas.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
	} // ejecutaOOSSExterna

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 09/01/09
	// ------------------------------------------------------------------------------------------

	private function validaRequisitos(nivel:String):String	{
		
		var resultado:String = null;
		
		// Valida el primer requisito para todas las OOSS
		switch(nivel)	{
			case "cuenta":
				if (gridCuentas.selectedIndex == -1)	
					resultado = "Debe seleccionarse una cuenta antes de efectuar la OOSS";
				break;
				
			case "cliente":
				if (gridClientes.selectedIndex == -1)	
					resultado = "Debe seleccionarse un cliente antes de efectuar la OOSS";
				break;
				
			case "abonado":
				if (gridAbonados.selectedIndex == -1)  
					resultado = "Debe seleccionarse un abonado antes de efectuar la OOSS";	
		} // switch

		// Valida requisitos puntuales a cada OOSS
		/*
		switch(this.codOOSSMenu)	{
			case "10921":
				if (!esAbonadoPospago()) resultado = "E";
		} // switch
		*/

		return resultado;
		
	} 	// Boolean

	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 09/01/09
	// ------------------------------------------------------------------------------------------
	
	private function menuHandler(event:MenuEvent):void  {
		
		this.codOOSSMenu = event.item.data;

		if (StringUtil.getValor(this.codOOSSMenu, "PATH") == "")	{
			Alert.show( "La OOSS seleccionada no está construída", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
			return;	    	
		} // if
		
		var mensajeError:String = null;
		switch (StringUtil.getValor(this.codOOSSMenu, "NIVEL"))	{
			case "CUENTA":
				// En caso de error de validacion el metodo validaRequisitos devuelve nulo
				mensajeError = validaRequisitos("cuenta"); 
				if (mensajeError == null) Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;
 				break;
 				
			case "CLIENTE":
				// En caso de error de validacion el metodo validaRequisitos devuelve nulo
				mensajeError = validaRequisitos("cliente");
				if (mensajeError == null) {
					Application.application.ctaSelect = gridClientes.selectedItem.codCuenta;
			 		Application.application.cliSelect = gridClientes.selectedItem.codCliente;
			 		Application.application.nomCliSelect = gridClientes.selectedItem.nomCliente;
		  		} // if
				break;
				
			case "ABONADO":
				// En caso de error de validacion el metodo validaRequisitos devuelve nulo
				mensajeError = validaRequisitos("abonado");
				if (mensajeError == null) {
					Application.application.ctaSelect = gridAbonados.selectedItem.codCuenta;
			 		Application.application.cliSelect = gridAbonados.selectedItem.codCliente;
			 		Application.application.aboSelect = gridAbonados.selectedItem.numAbonado;
			 		Application.application.numCelAboSelect = gridAbonados.selectedItem.numCelular;
			 		Application.application.nomCliSelect = null;
			 		Application.application.sitAboSelect = gridAbonados.selectedItem.desSituacion;
			 		Application.application.nomAboSelect = gridAbonados.selectedItem.nomUsuario;
			 } // if
   			
  	    } // switch
	    
	    if (mensajeError != null)
			Alert.show( mensajeError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		else	    	
	   		if (StringUtil.getValor(this.codOOSSMenu, "INTERNA") == "SI")	{
				modulo = ModuleManager.getModule(StringUtil.getValor(this.codOOSSMenu, "PATH"));   			
				modulo.addEventListener(ModuleEvent.READY, handlerLoadOOSS)
				modulo.load();
	   		} // if
	   		else
	   			ejecutaOOSSExterna();
   		
    } // menuHandler
    
    // ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 11/05/09
	// ------------------------------------------------------------------------------------------
	
   	private function handlerLoadOOSS(e:ModuleEvent):void {
		
		// Si se cargo bien el modulo, entonces guardo el codEvento  para la auditoria
		Application.application.codEvento = this.codOOSSMenu;
		
		Application.application.boxOOSS.removeAllChildren();
		Application.application.boxOOSS.addChild(modulo.factory.create() as DisplayObject);
		Application.application.boxOOSS.enabled = true;
		Application.application.tabAreasTrabajo.selectedIndex = 2;
	
	} // modEventHandler
	
