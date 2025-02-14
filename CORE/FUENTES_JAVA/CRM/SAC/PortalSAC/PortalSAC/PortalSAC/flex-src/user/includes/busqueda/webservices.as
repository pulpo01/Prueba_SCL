	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------

	import generated.webservices.orquestador.AbonadoDTO;
	import generated.webservices.orquestador.ClienteDTO;
	import generated.webservices.orquestador.CuentaDTO;
	
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import user.libreria.clases.StringUtil;
	import user.libreria.clases.Utilidades;
	
	private function getError(event:FaultEvent):void    {
		        
		PopUpManager.removePopUp(popUpWindowAbonado);
		PopUpManager.removePopUp(popUpWindowCliente);
		PopUpManager.removePopUp(popUpWindowCuenta);
		
		Application.application.sesionFlagButon = false;
		
		if(flash.external.ExternalInterface.call('controlSession')) {
			/*
			var mensaje:String = new String();
			mensaje = "Ha ocurrido un error en la petición a los servicios.";
			Alert.show( mensaje, 
							"Error", 
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
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------
	
	private function getCuentasXNumIdent(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("cuenta", evento.result);		
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("cuentas");
			
			//se deshabilita los radio buton de cuenta
			bloqAndDesBloqRadio('bloqCta');
			
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		PopUpManager.removePopUp(popUpWindowCuenta);	

	} // getCuentasXNumIdent  


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------
	
	private function getAbonadosXCelular(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("abonado", evento.result);
		else	{
			
			//se evita que se mantenga el flg si no ubo resultado de la consulta
			Application.application.flagButon = false;
			Application.application.sesionFlagButon = false;
			
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("abonados");
	
			//se deshabilita los radio buton de Abonado
			bloqAndDesBloqRadio('bloqAbo');
			
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		PopUpManager.removePopUp(popUpWindowAbonado);
				
	} // getAbonadosXCelular  

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 30/12/08
	// ------------------------------------------------------------------------------------------
	
	private function getCuentasXNombre(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == ""){
			processResult("cuenta", evento.result);
		}else{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("cuentas");
			
			//se deshabilita los radio buton de cuenta
			bloqAndDesBloqRadio('bloqCta');
			
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}

		PopUpManager.removePopUp(popUpWindowCuenta);
				
	} // getCuentasXNombre  


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------

	private function getClientesXCodCliente(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("cliente", evento.result);
		else	{
			
			//se evita que se mantenga el flg si no ubo resultado de la consulta
			Application.application.flagButon = false;
			Application.application.sesionFlagButon = false;
			
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("clientes");

			
			//se deshabilita los radio buton de cliente
			bloqAndDesBloqRadio('bloqClie');

			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}

		PopUpManager.removePopUp(popUpWindowCliente);
				
	} // getClientesXCodigo  


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 02/01/09
	// ------------------------------------------------------------------------------------------

	private function orquestaClienteClick(evento:ResultEvent):void	{
	
		if (evento.result != null)	{
			var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
			if (desError != "")	{
				mensajeAcumulado = desError; 
				acGridAbonado = null;
			}
			else	
				processResult("abonado", evento.result);

			var codCuenta:Number = parseInt(gridClientes.selectedItem.codCuenta);		
			orquestaBusquedaCuentas("numCtaBtn", codCuenta, false, false);

		} // if
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("abonados");

			//se deshabilita los radio buton de cliente
			bloqAndDesBloqRadio('bloqClie');

			Alert.show( evento.result.desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}

		PopUpManager.removePopUp(popUpWindowCliente);		
		
	} // getClientesXCodigo  


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 30/12/08
	// ------------------------------------------------------------------------------------------
	
	private function getClientesXNombre(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("cliente", evento.result);		
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("clientes");

			//se deshabilita los radio buton de cliente
			bloqAndDesBloqRadio('bloqClie');
		
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}

		PopUpManager.removePopUp(popUpWindowCliente);
				
	} // getClientesXNombre
	  
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	
	private function getCuentasXCodigo(evento:ResultEvent):void	{
		
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("cuenta", evento.result);
		else{
			clearForm();
			if (mensajeAcumulado != ""){ 
				mensajeAcumulado = mensajeAcumulado + "\n" + desError;
			}else{ 
				mensajeAcumulado = desError;
			}
			
			//se evita que se mantenga el flg si no ubo resultado de la consulta
			Application.application.flagButon = false;
			Application.application.sesionFlagButon = false;
			
			//se deshabilita los radio buton de las cuentas
			bloqAndDesBloqRadio('bloqCta');
			
		} // else

		PopUpManager.removePopUp(popUpWindowCuenta);
		
		if (mensajeAcumulado != "")
			Alert.show( mensajeAcumulado, 
				"Advertencia", 
				mx.controls.Alert.OK,
				this,
				null,
				iconWarning,
				mx.controls.Alert.OK );

		mensajeAcumulado = "";
						
	} // getCuentasXCodigo  

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	
	private function getClientesXCuenta(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("cliente", evento.result);
		else{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("clientes");

			//se deshabilita los radio buton de cliente
			bloqAndDesBloqRadio('bloqClie');

			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );		
		}
		
		PopUpManager.removePopUp(popUpWindowCliente);
				
	} // getClientesXCuenta  

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	
	private function getAbonadosXCliente(evento:ResultEvent):void	{
	
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")
			processResult("abonado", evento.result);
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			limpiaGrilla("abonados");

			//se deshabilita los radio buton de Abonado
			bloqAndDesBloqRadio('bloqAbo');

			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );	
		}
		
		PopUpManager.removePopUp(popUpWindowAbonado);
						
	} // getAbonadosXCliente  


	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.3
	// Fecha : 05/01/09
	// ------------------------------------------------------------------------------------------

	private function executeWS(opcion:String, subOpcion:String, evento:String):void	{
	
		// para saber cuando se ha hecho doble click
		this.nivelClick = subOpcion;

		if (opcion == "buscarPorCuenta")	{
			switch (subOpcion)	{
				case "numCtaBtn":
					var codCuenta:Number = parseInt(txtSearchCuenta.text);
					orquestaBusquedaCuentas(subOpcion, codCuenta, true, true);
					break;
					
				case "nomCuentaBtn":
					var nomCuenta:String = txtSearchCuenta.text;
					orquestaBusquedaCuentas(subOpcion, nomCuenta, true, true);
					break;
					
				case "numIdentifBtn":
					var numIdentif:String = txtSearchCuenta.text;
					orquestaBusquedaCuentas(subOpcion, numIdentif, true, true);
					break;
					
				case "cuentaClick":
					var codCuentaClick:Number = parseInt(gridCuentas.selectedItem.codCuenta);
					orquestaBusquedaCuentas(subOpcion, codCuentaClick, true, true);
			} // switch
		} // buscarPorCuenta
		else
		if (opcion == "buscarPorCliente")	{
			switch (subOpcion)	{
				case "numCliBtn":
					var codCliente:Number = parseInt(txtSearchCliente.text);
					orquestaBusquedaClientes(subOpcion, codCliente, true);
					break;
					
				case "nomCliBtn":
					var nomCliente:String = txtSearchCliente.text;
					orquestaBusquedaClientes(subOpcion, nomCliente, true);
					break;
					
				case "clienteClick":
					var codClienteClick:Number = parseInt(gridClientes.selectedItem.codCliente);
					
					// Si la grilla no tiene cuentas, entonces hay que buscar y no cambiar
					if (acGridCuenta != null && acGridCuenta.length > 0)
						orquestaBusquedaClientes(subOpcion, codClienteClick, true);
					else
						orquestaBusquedaClientes(subOpcion, codClienteClick, false);
			} // switch
		} // buscarPorCliente
		else
		if (opcion == "buscarPorAbonado")	{
			switch (subOpcion)	{
				case "numCeluBtn":
					var numCelular:Number = parseInt(txtSearchAbonado.text);
					orquestaBusquedaAbonados(subOpcion, numCelular);
					break;
					
				case "desdeAbonadoClick":
					orquestaBusquedaAbonados(subOpcion, "");
					break;
					
				case "desdeClienteClick":
					var codClienteGridClienteClick:Number = parseInt(gridClientes.selectedItem.codCliente);
					orquestaBusquedaAbonados(subOpcion, codClienteGridClienteClick);
			} // switch
		} // buscarPorAbonado
			
	} // executeWS

	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	
	private function orquestaBusquedaCuentas(subOpcion:String, datoCuenta:*, flagBorrarGrillas:Boolean, flagSwitch:Boolean ) : void	{
		
	    popUpParent = Application.application.document;
		
		if (subOpcion != "cuentaClick") {
			popUpWindowCuenta = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
			PopUpManager.centerPopUp(popUpWindowCuenta);
		}
		else	{
			popUpWindowCliente = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
			PopUpManager.centerPopUp(popUpWindowCliente);			
		}
						
		// Se eliminan los resultados de las otras grillas
		if (flagBorrarGrillas)	{
			dsGridCliente = null;
			dsGridAbonado = null;
		} // if	

		this.flagSwitchAccordion = flagSwitch;

		servicio = new HTTPService();		
		servicio.addEventListener(FaultEvent.FAULT, getError);
		servicio.method="GET";
		servicio.resultFormat="e4x";
				
		switch(subOpcion)	{
			case "numCtaBtn":
				servicio.addEventListener(ResultEvent.RESULT,getCuentasXCodigo);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("cuentasXCodigo","PATH");				
				servicio.request = {codCuenta:datoCuenta};
				servicio.send();
				break;
			case "numCtaBtn2":
				servicio.addEventListener(ResultEvent.RESULT,getCuentasXCodigo);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("cuentasXCodigo","PATH");				
				servicio.request = {codCuenta:datoCuenta};
				servicio.send();
				break;
			case "nomCuentaBtn":
				servicio.addEventListener(ResultEvent.RESULT,getCuentasXNombre);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("cuentasXNombre","PATH");				
				servicio.request = {descCuenta:datoCuenta};
				servicio.send();
				break;
			case "numIdentifBtn":
				servicio.addEventListener(ResultEvent.RESULT,getCuentasXNumIdent);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("cuentasXNumIdent","PATH");				
				servicio.request = {numIdent:datoCuenta};
				servicio.send();
				break;
			case "cuentaClick":
				// Se buscan los clientes
				clearFormCuentas(false);		
				clearFormClientes(false);
				
				servicio.addEventListener(ResultEvent.RESULT,getClientesXCuenta);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("clientesXCuenta","PATH");				
				servicio.request = {codCuenta:datoCuenta};
				servicio.send();	 
		} // switch

		// Verifica si se debe levantar el registro de consulta
		//Alert.show(Application.application.flagVentanaConsultas.toString(),"");
		if (Application.application.flagVentanaConsultas!=true){
			levantaRegistrarConsulta('Cuenta',Application.application.sesionDate);
		}

	} // orquestaBusquedaCuentas
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 18/12/08
	// ------------------------------------------------------------------------------------------
	
	private function orquestaBusquedaClientes(subOpcion:String, datoCliente:*, flagSwitch:Boolean ) : void	{
	
	    popUpParent = Application.application.document;
	    popUpWindowCliente = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindowCliente);
		
		this.flagSwitchAccordion = flagSwitch;
		
		servicio = new HTTPService();		
		servicio.addEventListener(FaultEvent.FAULT, getError);
		servicio.method="GET";
		servicio.resultFormat="e4x";
		servicio.contentType = "Content-type: text/plain;charset=UTF-8"; 
			
		switch (subOpcion)	{
			case "numCliBtn":
				servicio.addEventListener(ResultEvent.RESULT,getClientesXCodCliente);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("clientesXCodCliente","PATH");
				servicio.request = {codCliente:datoCliente};
				servicio.send();
				break;
				
			case "numCliBtn2":
				this.flagSwitchAccordion = false;
				// Se busca el cliente y al retornar solo la cuenta
				servicio.addEventListener(ResultEvent.RESULT,getClientesXCodCliente);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("clientesXCodCliente","PATH");
				servicio.request = {codCliente:datoCliente};
				servicio.send();
				break;
				
			case "nomCliBtn":
				servicio.addEventListener(ResultEvent.RESULT,getClientesXNombre);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("clientesXNombre","PATH");
				servicio.request = {nombre:unescape(datoCliente)};
				servicio.send();
				break;
				
			case "clienteClick":
				// Se buscan los clientes
				clearFormCuentas(false);		
				clearFormClientes(false);
		 		clearFormAbonados(false);
 					
				servicio.addEventListener(ResultEvent.RESULT,orquestaClienteClick);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("abonadosXCodCliente","PATH");
				servicio.request = {codCliente:datoCliente};
				servicio.send();
				break;
			
		} // switch
		
		
		// Verifica si se debe levantar el registro de consulta
		//Alert.show(Application.application.flagVentanaConsultas.toString(),"");
		if (Application.application.flagVentanaConsultas!=true){
			levantaRegistrarConsulta('Cliente', Application.application.sesionDate);
		}
		
	} // orquestaBusquedaClientes
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 19/12/08
	// ------------------------------------------------------------------------------------------
	
	private function orquestaBusquedaAbonados(subOpcion:String, datoAbonado:* ) : void	{
		
		// No se orquesta
		if (subOpcion != "desdeAbonadoClick")	{
		    popUpParent = Application.application.document;
		    popUpWindowAbonado = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
			PopUpManager.centerPopUp(popUpWindowAbonado);
		}
						
		this.flagSwitchAccordion = true;
		
		servicio = new HTTPService();		
		servicio.addEventListener(FaultEvent.FAULT, getError);
		servicio.method="GET";
		servicio.resultFormat="e4x";

		switch (subOpcion)	{
			// Hay que hacer que busque por codigo o nombre
			case "numCeluBtn":
				servicio.addEventListener(ResultEvent.RESULT,getAbonadosXCelular);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("abonadosXCelular","PATH");				
				servicio.request = {numCelular:datoAbonado};
				servicio.send();
				break;

			// Si se encontro, hay que buscar los clientes y cuenta asociada			
			case "desdeAbonadoClick":
				// Limpio los objetos
				clearFormCuentas(false);		
				clearFormClientes(false);
		 		clearFormAbonados(false);
		 						
				orquestaBusquedaClientes("numCliBtn", gridAbonados.selectedItem.codCliente, false);
				orquestaBusquedaCuentas("numCtaBtn", gridAbonados.selectedItem.codCuenta, false, false);
				break;
				
			case "desdeClienteClick":
				this.flagSwitchAccordion = false;
				
				servicio.addEventListener(ResultEvent.RESULT,getAbonadosXCliente);
				servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("abonadosXCodCliente","PATH");				
				servicio.request = {param:datoAbonado};
				servicio.send();
				break;				
		} // switch

		// Verifica si se debe levantar el registro de consulta
		//Alert.show(Application.application.flagVentanaConsultas.toString(),"");
		if (Application.application.flagVentanaConsultas!=true){
			levantaRegistrarConsulta('Abonado', Application.application.sesionDate);
		}

	} // orquestaBusquedaAbonados
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 06/01/09
	// ------------------------------------------------------------------------------------------

	private function seleccionaAbonado():void	{
		
		if (gridCuentas.selectedIndex > -1 && gridClientes.selectedIndex > -1 && gridAbonados.selectedIndex > -1)	{
			parentDocument.lblDatosSeleccionados.text = "CUENTA : " + gridCuentas.selectedItem.desCuenta +
									 					" / CLIENTE : " + gridClientes.selectedItem.nomCliente +
									 					" / ABONADO : " + gridAbonados.selectedItem.numAbonado; 
									 
			Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;
		 	Application.application.cliSelect = gridClientes.selectedItem.codCliente;
		 	Application.application.aboSelect = gridAbonados.selectedItem.numAbonado;
		 	Application.application.nomCliSelect = gridClientes.selectedItem.nomCliente;
			Application.application.nomCtaSelect = gridCuentas.selectedItem.desCuenta;
	 		Application.application.numCelAboSelect = gridAbonados.selectedItem.numCelular;
	 		Application.application.nomAboSelect = gridAbonados.selectedItem.nomUsuario;
	 		Application.application.sitAboSelect = gridAbonados.selectedItem.desSituacion;		 	
		 	
		 	Alert.show( "Ha seleccionado los siguientes datos de trabajo : \n\n" + 
		 				"Cuenta : " + gridCuentas.selectedItem.desCuenta + "\n" +
						"Cliente : " + gridClientes.selectedItem.nomCliente + "\n" +	 				
		 				"Abonado : " + gridAbonados.selectedItem.numAbonado, "Advertencia");
		} // else
		else
		 	Alert.show( "Verifique que haya elegido una cuenta,cliente y abonado.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		
			 	
	} // seleccionaAbonado
	
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 07/01/09
	// ------------------------------------------------------------------------------------------

	private function cambiaPath(nivel:String):void	{
		
		var strPath:String = parentDocument.lblDatosSeleccionados.text; 
		var path:Array = strPath.split("/");
		
		switch(nivel)	{
			case "cliente":
				if (gridCuentas.selectedIndex >= 0 && gridCuentas.selectedItem != null)	{
					path[0] = "CUENTA : " + gridCuentas.selectedItem.desCuenta;
					Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;	
				}

				if (gridClientes.selectedIndex >= 0 && gridClientes.selectedItem != null)	{
					path[1] = "CLIENTE : " + gridClientes.selectedItem.nomCliente;
					Application.application.cliSelect = gridClientes.selectedItem.codCliente;
				}
				parentDocument.lblDatosSeleccionados.text = path[0] + " / " + path[1] + " / " + path[2];
				
				break;
				
			case "cuenta":
				if (gridCuentas.selectedIndex >= 0)	{
					path[0] = "CUENTA : " + gridCuentas.selectedItem.desCuenta;
					Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;
				}
				
				parentDocument.lblDatosSeleccionados.text = path[0] + " / CLIENTE :  / ABONADO : ";
				
		
			case "abonado":
				if (gridCuentas.selectedIndex >= 0)	{
					path[0] = "CUENTA : " + gridCuentas.selectedItem.desCuenta;
					Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;	
				}

				if (gridClientes.selectedIndex >= 0)	{
					path[1] = "CLIENTE : " + gridClientes.selectedItem.nomCliente;
					Application.application.cliSelect = gridClientes.selectedItem.codCliente;
				}
				
				if (gridAbonados.selectedIndex >= 0)	{
					path[2] = "ABONADO : " + gridAbonados.selectedItem.numAbonado;
					Application.application.aboSelect = gridAbonados.selectedItem.numAbonado;				
				}
				
				parentDocument.lblDatosSeleccionados.text = path[0] + " / " + path[1] + " / " + path[2];

		} // switch
		
	} // cambiaPath
	
	// ------------------------------------------------------------------------------------------	
	
	private function limpiaGrilla(grilla:String):void	{
	
		switch(grilla)	{
			case "cuentas":
				acGridCuenta = null;
				gridCuentas.selectedIndex = -1;
				break;
				
			case "clientes":
				acGridCliente = null;
				gridClientes.selectedIndex = -1;
				break;
			
			case "abonados":
				acGridAbonado = null;
				gridAbonados.selectedIndex = -1;
				break;
		}	// switch
		
	} // limpiaGrilla
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 2.0
	// Fecha : 31/03/09
	// ------------------------------------------------------------------------------------------

	private function processResult(nivel:String, result:*):void	{
		
		if (this.flagSwitchAccordion)	{
			switch(nivel)	{
				case "cliente":
					acc1.selectedIndex = 1;
					break;
					
				case "cuenta":
					acc1.selectedIndex = 0;				
					break;
					
				case "abonado":
					acc1.selectedIndex = 2;		
			} // switch
		} // if

		var hoy:Date = new Date();
		var mes:Number = hoy.getMonth() + 1;
		var fechaCompl:String = hoy.getDate()+'/'+mes+'/'+hoy.getFullYear()+' '+hoy.getHours()+':'+hoy.getMinutes()+':'+hoy.getSeconds();

		switch(nivel)	{
			case "cuenta":
				acGridCuenta = Utilidades.fillArrayCollection(result, generated.webservices.orquestador.CuentaDTO);
				gridCuentas.selectedIndex = 0;
				//rbtAsc.selected=true;
				if (acGridCuenta.length > 0)	{
					gridCuentas.selectedItem = acGridCuenta[0];		
					Application.application.ctaSelect = gridCuentas.selectedItem.codCuenta;
					
					if(Application.application.flagButon){
						//Obtener la fecha actual de busqueda
						Application.application.sesionDate = fechaCompl;
						Application.application.sesionTipoBus = 'Cuenta';
						Application.application.sNumCta = gridCuentas.selectedItem.codCuenta;
						
						//Se registra el numCta de la consulta realizada
						Application.application.sesionNumCta = gridCuentas.selectedItem.codCuenta;
						
					}
					
					
					//se habilita los radio buton de cuenta
					bloqAndDesBloqRadio('desBloqCta');
				
					
				} // if
					
				break;
				
			case "cliente":
				acGridCliente = Utilidades.fillArrayCollection(result, generated.webservices.orquestador.ClienteDTO);
				gridClientes.selectedIndex = 0;
				//rbtAscCli.selected=true;
				if (acGridCliente.length > 0)	{
					gridClientes.selectedItem = acGridCliente[0];		
					Application.application.cliSelect = gridClientes.selectedItem.codCliente;
					
					if(Application.application.flagButon){
						//Obtener la fecha actual de busqueda
						Application.application.sesionDate = fechaCompl;
						Application.application.sesionTipoBus = 'Cliente';
						Application.application.sCodClie = gridClientes.selectedItem.codCliente;
						
						//Se registra el codCliente de la consulta realizada
						Application.application.sesionCodClie = gridClientes.selectedItem.codCliente;
					}
					
					//se habilita los radio buton de cliente
					bloqAndDesBloqRadio('desBloqClie');
				
				} // if
				
				break;
				
			case "abonado":
				acGridAbonado = Utilidades.fillArrayCollection(result, generated.webservices.orquestador.AbonadoDTO);
				gridAbonados.selectedIndex = 0;
				//rbtAscAbo.selected=true;
				if (acGridAbonado.length > 0)	{
					gridAbonados.selectedItem = acGridAbonado[0];		
					Application.application.aboSelect = gridAbonados.selectedItem.numAbonado;
				
					if(Application.application.flagButon){
						//Obtener la fecha actual de busqueda
						Application.application.sesionDate = fechaCompl;
						Application.application.sesionTipoBus = 'Abonado';
						Application.application.sNumAbo = gridAbonados.selectedItem.numAbonado;
						
						//Se registra el numAbonado de la consulta realizada
						Application.application.sesionNumAbo = gridAbonados.selectedItem.numAbonado;
					}
					
					//se habilita los radio buton de abonado
					bloqAndDesBloqRadio('desBloqAbo');
					
				} // if	
		} // switch
	
	/*
		if (this.nivelClick == "clienteClick")
			cambiaPath("cliente");
		else
			if (this.nivelClick == "desdeAbonadoClick")
				cambiaPath("abonado");
	*/
	} // processResult

		// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 13/07/09
	// ------------------------------------------------------------------------------------------
	
   	private function checkFirstLogin():void {
		
		var nomUsuario:String = Application.application.usuario.username;
		
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.addesPrimerLoginEventListener(getPrimerLogin);
		wsORQ.esPrimerLogin(nomUsuario);
		
	} // checkFirstLogin

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 13/07/09
	// ------------------------------------------------------------------------------------------
	  		
	private function getPrimerLogin(event:EsPrimerLoginResultEvent):void	{
	
		PopUpManager.removePopUp(popUpWindow);
		if (event.result)	{
			Application.application.paramGenerico = "firstLogin";
			cambiarClave();
		}
			
	} // getCheckPassword

  	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 14/07/09
	// ------------------------------------------------------------------------------------------

	private function cambiarClave():void {
		
		popUpParent = this;
		popUpWindow = PopUpManager.createPopUp(popUpParent, this.cambioPassword, true);
		PopUpManager.centerPopUp(popUpWindow);
		
	} // cambiarClave

  	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------

	private function gruposXNomUsuario(usuario:String):void {
		
		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.addgruposXNomUsuarioEventListener(getDataPerfil);
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		wsORQ.gruposXNomUsuario(usuario);
	
	} // gruposXNomUsuario
	
	
  	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------
	private function getDataPerfil(event:GruposXNomUsuarioResultEvent) : void {
		//var grupoDefaultPerfilamiento:String = StringUtil.getValor("grupoDefaultPerfilamiento", "VALOR");
		trace("getDataPerfil, inicio");
		var arrayGrupos:Array = event.result.arrayGrupos;
		var codGrupo:String = null;
		if (arrayGrupos == null) {
			return;
		}
		//var activarPerfilamiento:Boolean = false;
		for (var i:int = 0; i < arrayGrupos.length; i++) {
			codGrupo = arrayGrupos[i].codGrupo;
			trace("codGrupo [" + codGrupo + "]");
			//if (codGrupo == grupoDefaultPerfilamiento) {
				//activarPerfilamiento = true;
				break;
			//}
		}
		//if (!activarPerfilamiento) {
		//	trace("No tiene perfilamiento. No está presente en grupo " + grupoDefaultPerfilamiento);
		//	return;
		//}
		for (var j:int = 0; j < arrayGrupos.length; j++) {
			codGrupo = arrayGrupos[j].codGrupo;
			perfilaGrupo(codGrupo);
		}
		trace("getDataPerfil, fin");
	} // getDataPerfil  
				
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------
	// Obtengo todas las consultas  perfiladas para el grupo seleccionado
   	private function perfilaGrupo(codGrupo:String):void	{
		trace("perfilaGrupo(" + codGrupo + ")");
		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.addconsultasXCodGrupoEventListener(getDataConsultasGrupo);
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		wsORQ.consultasXCodGrupo(codGrupo, StringUtil.getValor("codigoPrograma","VALOR"), StringUtil.getValor("versionPrograma","VALOR"));
	} // perfilaGrupo	
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------	
	private function getDataConsultasGrupo(event:ConsultasXCodGrupoResultEvent):void	{
		PopUpManager.removePopUp(popUpWindow);
		var a:Array = event.result.arrayProcesos;
		if (a != null)	{
			cargaArraysConsultasUsuario(a);
		} // if
	} // getDataConsultasGrupo  

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------	
	// Pobla los arraycollection para mostrarse en los popups de consultas en la pantalla de busqueda
	private function cargaArraysConsultasUsuario(listadoConsultas:Array) : void	{
		trace("cargaArraysConsultasUsuario [inicio]");
		for (var i:Number = 0; i < listadoConsultas.length; i++)	{
			var codProceso:String = listadoConsultas[i].codProceso;
			var desProceso:String = listadoConsultas[i].desProceso;
			var nivel:String = StringUtil.getValor(codProceso, "NIVEL");
			trace("codProceso [" + codProceso + "]");
			trace("desProceso [" + desProceso + "]");
			trace("nivel [" + nivel + "]");
			switch (nivel) {
				case "CUENTA":
					Application.application.aPopMenuCuenta.addItem({label:desProceso, data:codProceso});
					break;
				case "CLIENTE":
					Application.application.aPopMenuCliente.addItem({label:desProceso, data:codProceso});
					break;
				case "ABONADO":
					Application.application.aPopMenuAbonado.addItem({label:desProceso, data:codProceso});
					break;
			}
			// switch
			if ((nivel == "OTRASOPERACIONES") && (codProceso == Application.application.activarBtnAccesoPortalSTP.codigo)) {
				trace("Usuario tiene acceso STP");
				Application.application.activarBtnAccesoPortalSTP.activar = true;
			}	
			if ((nivel == "REPORTESOOSS") && (codProceso == Application.application.activarBtnAccesoReportes.codigo)) {
				trace("Usuario tiene acceso Reportes");
				Application.application.activarBtnAccesoReportes.activar = true;
			}
		} // for
		trace("cargaArraysConsultasUsuario [fin]");
	} //cargaArraysConsultasUsuario
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------	
	
	private function cargaOOSSxNomUsuario(usuario:String):void	{

		// Se ha logrado cargar el archivo de properties 
		wsORQOOSS.addWSSEGPortalFaultEventListener(getError);
		wsORQOOSS.addcargaValidaOSUsuarioEventListener(getDataOOSSxNomUsuario);
		wsORQOOSS.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		wsORQOOSS.cargaValidaOSUsuario(usuario);

	} // cargaOOSSxNomUsuario
	

	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 08/09/09
	// ------------------------------------------------------------------------------------------	
	// Recibo el perfil de acceso a OOSS para este usuario

	private function getDataOOSSxNomUsuario(event:CargaValidaOSUsuarioResultEvent):void	{
	
		PopUpManager.removePopUp(popUpWindow);
		if (event.result != null)	{
			Application.application.aMenuCuenta = event.result.arrayOOSSXCuenta;
 			Application.application.aMenuCliente = event.result.arrayOOSSXCliente;
 			Application.application.aMenuAbonado = event.result.arrayOOSSXAbonado;
 			Application.application.aMenuUsuario = event.result.arrayOOSSXUsuario;
		} // if
		
	} // getDataOOSSxNomUsuario  

	// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Moraga L
		// Version : 1.0
		// Fecha : 17/08/2010
		// ------------------------------------------------------------------------------------------
		
		private function bloqAndDesBloqRadio(accion:String):void {

			if(accion == 'bloqCta'){
				hRadioCta1.enabled = false;
				hRadioCta2.enabled = false;
			}else if(accion == 'desBloqCta'){
				hRadioCta1.enabled = true;
				hRadioCta2.enabled = true;
			}else if(accion == 'bloqClie'){
				try{
					hRadioClie1.enabled = false;
					hRadioClie2.enabled = false;
				}catch (e:Error){
						
				}
			}else if(accion == 'desBloqClie'){
				try{
					hRadioClie1.enabled = true;
					hRadioClie2.enabled = true;
				}catch (e:Error){
						
				}
			}else if(accion == 'bloqAbo'){
				try{
					hRadioAbo1.enabled = false;
					hRadioAbo2.enabled = false;
				}catch (e:Error){
						
				}
			}else if(accion == 'desBloqAbo'){
				try{
					hRadioAbo1.enabled = true;
					hRadioAbo2.enabled = true;
				}catch (e:Error){
						
				}
			}
   
        }
	
	