	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	import generated.webservices.orquestador.CambiarDireccionesClienteResultEvent;
	import generated.webservices.orquestador.DireccionSACDTO;
	import generated.webservices.orquestador.ListadoDireccionesSACDTO;
	
	import user.libreria.clases.StringUtil;
	
	include "../registroConsulOoss.as";
	
	private function getError(event:FaultEvent):void    {
		        
		PopUpManager.removePopUp(popUpWindow);
		
		Application.application.sesionFlagButon = false;
		
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
  		
	} // getError
	
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
		
	private function executeWS(evento:String):void	{

		var nomUsuario:String = Application.application.usuario.username;
		var codEvento:String = Application.application.codEvento; 

		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		wsORQ.addWSSEGPortalFaultEventListener(getError);
		
		switch(evento)	{
			case "load":
				showBusy();
				flagCarga = 1;
				// Carga las direcciones del cliente
				var codCliente:Number = parseInt(Application.application.cliSelect);
				wsORQ.adddireccionesXCodClienteEventListener(getDataLoad);
				wsORQ.direccionesXCodCliente(codCliente, nomUsuario, codEvento);
				break;
				
			case "click":
				if (gridDirecciones.selectedItem != null)	{
					showBusy();
					flagCarga = 5;
					wsORQ.addgetDetalleDireccionEventListener(getDataClick);
					wsORQ.getDetalleDireccion(gridDirecciones.selectedItem.codDireccion, gridDirecciones.selectedItem.codTipDireccion);
				}
		} // switch
		
	} // executeWS

	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
					
	private function getDataLoad(event:DireccionesXCodClienteResultEvent):void	{
	
		hideScrollBar();
		
		if (event.result.desError == null)
			dsGrid = event.result.arrayDirecciones;
		else
			Alert.show( event.result.desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		
	} // getData  
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	private function getDataClick(event:GetDetalleDireccionResultEvent):void	{
	
		if (event.result.codError == null)	{
			detalleDireccionDTO = event.result;
			var codRegion:String = detalleDireccionDTO.codRegion;
			var codProvincia:String = detalleDireccionDTO.codProvincia;
			var codCiudad:String = detalleDireccionDTO.codCiudad;
			
			loadRegiones();
			loadProvincias(codRegion);
			loadCiudades(codRegion,codProvincia);
			loadComunas(codRegion,codProvincia,codCiudad);

			
			txtCalle.text = StringUtil.nulo2String(event.result.nomCalle);
			txtCodPostal.text = StringUtil.nulo2String(event.result.zip);
			txtNroExterno.text = StringUtil.nulo2String(event.result.numCalle);
			txtNroInterno.text = StringUtil.nulo2String(event.result.numPiso);

			// Por compatibilidad, se recortan a lo necesario.			
			txtComentarios.text = StringUtil.nulo2String(event.result.obsDireccion);
			txtComentarios.text = txtComentarios.text.substr(0,30);
			txtComentarios1.text = StringUtil.nulo2String(event.result.obsDireccion2);
			txtComentarios1.text = txtComentarios1.text.substr(0,30);
			btnActualizar.enabled=true;
		} // if
		else
			Alert.show( event.result.desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		
		hideScrollBar();
	
	} // getDataClick
	
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	private function getCambioDirecciones(event:CambiarDireccionesClienteResultEvent):void	{

		hideScrollBar();

		var mensaje:String = "";			
		if (event.result.arrayOOSS != null)	{
			
			var cont:Number=event.result.arrayOOSS.length;
			for (cont=0; cont<event.result.arrayOOSS.length; cont++)	{
				// Si solo se realizo una OOSS entonces se debe mostrar la seleccionada
				if (event.result.arrayOOSS.length == 1)
					mensaje = mensaje + gridDirecciones.selectedItem.desTipDireccion + ": ";
				else
					mensaje = mensaje + "- " + gridDirecciones.dataProvider[cont].desTipDireccion + ": ";
				
				if (event.result.arrayOOSS[cont].nroOOSS != 0)
				{
					wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
					wsORQ.insertComentario(txtComentario.text,event.result.arrayOOSS[cont].nroOOSS);
					mensaje = mensaje + "Número de la OOSS " + event.result.arrayOOSS[cont].nroOOSS + "\n\n";
					
					//Se levanta la pantalla de registro
		     		//levantaRegistroIngOoss('Cliente'); //Se comenta funcionalidad(No certificada) AF resposable : Ruben Araya
					
				}
				else			
					mensaje = mensaje + event.result.arrayOOSS[cont].desError;
			} // for
			
		} // if
		else
			mensaje = event.result.desError;
					
		Alert.show( mensaje, 
					"Modificación Direcciones Cliente", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
		cerrar();
	
	} // getCambioDirecciones
	
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 15-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	// Graba los cambios en la direccion
	private function actualizar():void	{

		if (validaCambios())	{
			showBusy();	
	  		var listadoDireccionesSACDTO:ListadoDireccionesSACDTO = new ListadoDireccionesSACDTO();
			
			[ArrayElementType("DireccionSACDTO")]
			var arrayDirec:Array = new Array();
			
			var cantidad:Number = gridDirecciones.dataProvider.length;
			if (!chkCopiar.selected) cantidad = 1;
  			// INICIO RRG 133125
  			if (txtCalle.text.length > 250) {
  				
  				Alert.show( "Longitud direccion mayor a lo permitido, debe ingresa menor a 50 caracteres ", 
  				"Advertencia", 
  				 Alert.OK,
  				this,
  				null,
  				iconWarning,
  				mx.controls.Alert.OK );
  				
  				txtCalle.setFocus();
  				
  				return;
  				
  			} else { 	//  RRG 133125
  			
  				// Se deben crear la cantidad de dto necesarios para enviar al WS		
  				for (var cont:Number=0; cont < cantidad; cont++)	{
  		  			var direccionSACDTO:DireccionSACDTO = new DireccionSACDTO();
  					direccionSACDTO.codCliente = parseInt(Application.application.cliSelect);
  					direccionSACDTO.codigoPostal = StringUtil.nulo2String(txtCodPostal.text);
  					direccionSACDTO.nombreCalle = StringUtil.nulo2String(txtCalle.text);
  					direccionSACDTO.numeroCalle = StringUtil.nulo2String(txtNroExterno.text);
  					direccionSACDTO.numeroPiso = StringUtil.nulo2String(txtNroInterno.text);
  					direccionSACDTO.descripcionDireccion1 = StringUtil.nulo2String(txtComentarios1.text);
  					//direccionSACDTO.descripcionDireccion2 = StringUtil.nulo2String(txtComentarios1.text);
  					//direccionSACDTO.observacion = StringUtil.nulo2String(txtComentario.text);
  					direccionSACDTO.observacion = StringUtil.nulo2String(txtComentarios.text);
  					direccionSACDTO.idCiudad = cboCiudad.selectedItem.codCiudad[0];		
  					direccionSACDTO.idComuna = cboReparto.selectedItem.codComuna[0];
  					direccionSACDTO.idProvincia = cboMunicipio.selectedItem.codProvincia[0];
  					direccionSACDTO.idRegion = cboDepartamento.selectedItem.codRegion[0];
  					if (cantidad == 1)
  						direccionSACDTO.tipoDireccion = gridDirecciones.selectedItem.codTipDireccion;
  					else
  						direccionSACDTO.tipoDireccion = gridDirecciones.dataProvider[cont].codTipDireccion;
  				
  					direccionSACDTO.idTipoDireccion = direccionSACDTO.tipoDireccion;
  					arrayDirec.push(direccionSACDTO);
  		  			direccionSACDTO = null;			
  				}	// for	
  			
  
  	  		listadoDireccionesSACDTO.arrayDirecciones = arrayDirec;
  			wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
  			wsORQ.addcambiarDireccionesClienteEventListener(getCambioDirecciones);
  			wsORQ.cambiarDireccionesCliente(listadoDireccionesSACDTO);
  			flagCarga = 1;
  			} // RRG 133125 
		}	// if
		else			
			Alert.show( "No se han producido cambios en la dirección del cliente o faltan datos requeridos.", 
			"Advertencia", 
			Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
			
	} // actualizar
		
		
