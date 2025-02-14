	import generated.webservices.orquestador.DetalleAjusteVO;
	import mx.controls.Text;
	import generated.webservices.orquestador.ResulTransaccionDTO;
	import mx.rpc.events.ResultEvent;

	include "../registroConsulOoss.as";
	
	private function getError(event:FaultEvent):void    {

		PopUpManager.removePopUp(popUpWindow);
		
		Application.application.sesionFlagButon = false;
		
		if(flash.external.ExternalInterface.call('controlSession')) { 
			/*
			var mensaje:String = new String();
			mensaje = "Ha ocurrido un error en la petición a los servicios.";
	     	Alert.show(mensaje, "Error en la aplicación");
	     	*/
	     	
	     	var url:String = new String();
			url = StringUtil.getValor("urlApplicationLogout","VALOR");
			var urlLogout:URLRequest = new URLRequest(url);
			navigateToURL(urlLogout, "_top");
	     	
  		}
  		
     	cerrar();
     	
	} // getError
		
	// --------------------------------------------------------------------------------
	// HGG 
	// Version 1.1
	// 13/09/2009
	// -------------------------------------------------------------------------------- 
	private function getDataCargaExcepcion(event: CargarAjusteCExcepcionCargosResultEvent):void		{
		
		if (event.result.codError == null)	{
			numTransaccion= event.result.numTransaccion;
			
			if (event.result.arrayCausasPagoVO != null) {
				coCausaPago.labelField = "desCauPago";
				coCausaPago.dataProvider = event.result.arrayCausasPagoVO;
				coCausaPago.selectedIndex = -1;
			} // if
			
		
			if (event.result.arrayFoliosFacturasVO != null) {
				arrayFoliosFacturasdata = event.result.arrayFoliosFacturasVO.sortOn("nroFolio", Array.NUMERIC);
				coFoliosFacturas.dataProvider = Utilidades.creaOpcionesCombobox(arrayFoliosFacturasdata, "nroFolio", "nroFolio");
				coFoliosFacturas.selectedIndex = - 1;	
				coFoliosFacturas.enabled = true;
			} // if
			
			
			if (event.result.arrayNotaCreditoVO != null) {
				cboNotas.labelField = "desNC";
				cboNotas.dataProvider=event.result.arrayNotaCreditoVO;
				cboNotas.selectedIndex=-1;
			} // if
			
			if (event.result.arrayOrigenPagoVO != null) {
				coOrigenPago.labelField = "desOriPago";		
				coOrigenPago.dataProvider=event.result.arrayOrigenPagoVO;
				coOrigenPago.selectedIndex=-1;
			} // if
			
			mtoSaldoCliente.text = event.result.saldoCliente.toString();
			mtoOOSS = event.result.saldoCliente;	// Para ajuste total
			mtoOOSSPuntual = 0; 					// Para ajuste parcial
			IdMtoPago.text = event.result.saldoCliente.toString();
			tipoAjuste = 0; // Ajuste Total
			PopUpManager.removePopUp(popUpWindow);
		} // if
		else
		{
			PopUpManager.removePopUp(popUpWindow);	
     		Alert.show(event.result.desError, "No se puede ejecutar la OOSS");
     		cerrar();
		} // else		
				
	} // getDataCarga  
	
	// --------------------------------------------------------------------------------
	// HGG 
	// Version 1.1
	// 28/09/2009
	// -------------------------------------------------------------------------------- 

	private function getDataCargaReversion( event: CargarAjusteCReversionCargosResultEvent):void		{
		
		if (event.result.codError == null)	{
			numTransaccion= event.result.numTransaccion;
			
			if (event.result.arrayCausasPagoVO != null) {
				coCausaPago.labelField = "desCauPago";
				coCausaPago.dataProvider = event.result.arrayCausasPagoVO;
				coCausaPago.selectedIndex = -1;
			} // if
			

			if (event.result.arrayFoliosFacturasVO != null) {
				arrayFoliosFacturasdata = event.result.arrayFoliosFacturasVO.sortOn("nroFolio", Array.NUMERIC);
				coFoliosFacturas.dataProvider = Utilidades.creaOpcionesCombobox(arrayFoliosFacturasdata, "nroFolio", "nroFolio");
				coFoliosFacturas.selectedIndex = - 1;	
				coFoliosFacturas.enabled = true;
			} // if
			
		
			if (event.result.arrayNotaDebitoVO != null) {
				cboNotas.labelField = "desND";		
				cboNotas.dataProvider = event.result.arrayNotaDebitoVO;
				cboNotas.selectedIndex = -1;
			} // if

			if (event.result.arrayOrigenPagoVO != null) {
				coOrigenPago.labelField = "desOriPago";		
				coOrigenPago.dataProvider=event.result.arrayOrigenPagoVO;
				coOrigenPago.selectedIndex=-1;
			} // if
			
			mtoSaldoCliente.text = event.result.saldoCliente.toString();
			mtoOOSS = event.result.saldoCliente;	// Para ajuste total
			mtoOOSSPuntual = 0; 					// Para ajuste parcial
			IdMtoPago.text = event.result.saldoCliente.toString();
			tipoAjuste = 0; // Ajuste Total
			PopUpManager.removePopUp(popUpWindow);
		} // if
		else
		{
			PopUpManager.removePopUp(popUpWindow);	
     		Alert.show(event.result.desError, "No se puede ejecutar la OOSS");
     		cerrar();
		} // else	
		
					
	} // getDataCargaReversion  
		
	// --------------------------------------------------------------------------------
	
	private function getDataFiltroExcepcion(event: FiltrarDetDocAjusteCExcepcionCargosResultEvent):void	{
		
		if (event.result.codError == null && event.result.arrayDetalleDocumentoVO != null)	{
			mtoOOSSPuntual = 0;
			arrayDetalleDocumento = event.result.arrayDetalleDocumentoVO;
		} // if
		else
			Alert.show(event.result.desError,
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
		
		PopUpManager.removePopUp(popUpWindow);
		
		// Seteo los datos en la grilla del componente
		docsAjusteParcial.arrayDocs = arrayDetalleDocumento;
		docsAjusteParcial.txtMonto = IdMtoPago;
		docsAjusteParcial.ajuste = "excepcion";
		popUpParent = this;
		popUpWindow = PopUpManager.createPopUp(popUpParent, docsAjusteParcial);
		PopUpManager.centerPopUp(popUpWindow);
			
	} // getDataFiltroExcepcion
		
	// -----------------------------------------------------------------------------------------------------

	private function getDataFiltroReversion(event: FiltrarDetDocAjusteCReversionCargosResultEvent):void	{
		
		if (event.result.codError == null && event.result.arrayDetalleDocumentoVO != null)	{
			mtoOOSSPuntual = 0;
			arrayDetalleDocumento = event.result.arrayDetalleDocumentoVO;
		} // if
		else
			Alert.show(event.result.desError,
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
		
		PopUpManager.removePopUp(popUpWindow);
		
		// Seteo los datos en la grilla del componente
		docsAjusteParcial.arrayDocs = arrayDetalleDocumento;
		docsAjusteParcial.txtMonto = IdMtoPago;
		docsAjusteParcial.ajuste = "reversion";
		popUpParent = this;
		popUpWindow = PopUpManager.createPopUp(popUpParent, docsAjusteParcial);
		PopUpManager.centerPopUp(popUpWindow);
			
	} // getDataFiltroReversion
		
	// -----------------------------------------------------------------------------------------------------
	
	private function executeWSCarga():void	{
		
		var codEvento:String = parentApplication.codEvento;
		var password:String;
		
		// Si se solicita password debe ser igual a la ingresa en el popup de solicitud
		if (StringUtil.getValor("pedirPasswordFranquicias","VALOR") == "SI") password = txtClave.text;
		else
			password = "12345678";
			 
		popUpParent = parentApplication.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);

		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
				
		if (ajusteOOSS == "excepcion")	{
			wsORQ.addcargarAjusteCExcepcionCargosEventListener(getDataCargaExcepcion);
			wsORQ.cargarAjusteCExcepcionCargos(parentApplication.cliSelect, parentApplication.usuario.username, password, codEvento);			
		} // if
		else	{
			wsORQ.addcargarAjusteCReversionCargosEventListener(getDataCargaReversion);
			wsORQ.cargarAjusteCReversionCargos(parentApplication.cliSelect,parentApplication.usuario.username, password, codEvento);			
		} // else
				
	} // executeWS
		
	// -----------------------------------------------------------------------------------------------------
		
	private function executeWSFiltro():void	{
		
		popUpParent = parentApplication.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);
		
		var indice:int = coFoliosFacturas.selectedIndex;
        
		FiltroDTO.numTransaccion = numTransaccion; 						// numero de la transacción 
		FiltroDTO.nomUsuarioSCL = parentApplication.usuario.username;	// usuario logueado
		FiltroDTO.codError = "1";										// en duro para que sea null
		FiltroDTO.desError = "N";										// en duro para que sea null			
		FiltroDTO.nroOOSS = 1;
		FiltroDTO.codCentrEmi = arrayFoliosFacturasdata[indice].codCentrEmi;
		FiltroDTO.codTipDocum = arrayFoliosFacturasdata[indice].codTipDocum;
		FiltroDTO.codVendedor = arrayFoliosFacturasdata[indice].codVendedor;
		FiltroDTO.letra = arrayFoliosFacturasdata[indice].letra;
		FiltroDTO.nroSecuencia = arrayFoliosFacturasdata[indice].nroSecuencia;

		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));

		if (ajusteOOSS == "excepcion")	{
			wsORQ.addfiltrarDetDocAjusteCExcepcionCargosEventListener(getDataFiltroExcepcion);
			wsORQ.filtrarDetDocAjusteCExcepcionCargos(FiltroDTO);
		} // if
		else	{
			wsORQ.addfiltrarDetDocAjusteCReversionCargosEventListener(getDataFiltroReversion);
			wsORQ.filtrarDetDocAjusteCReversionCargos(FiltroDTO);
		} // else

	} // executeWSFiltro
	
	// -----------------------------------------------------------------------------------------------------
	
	private function getDataEjecutaReversion(event:EjecutarAjusteCReversionCargosResultEvent):void	{

		PopUpManager.removePopUp(popUpWindow);
		if (event.result.desError == null){
			
	     	Alert.show("Número de la OOSS.: " + event.result.nroOOSS.toString(), "OOSS Ajuste Nota Credito");
	     	
	     	//Se llama al WS para grabar el comentario
	     	wsInsertaComent(txtComentario.text, event.result.nroOOSS);
	     	
	     	//Se levanta la pantalla de registro
		    //levantaRegistroIngOoss('Cliente'); //Se comenta funcionalidad(No certificada) AF resposable : Ruben Araya
	     	
		}else{	
     		Alert.show(event.result.desError, "No se puede ejecutar la OOSS");
		}
		
		cerrar();

	} // getDataEjecutaReversion  
				
	// -----------------------------------------------------------------------------------------------------
	
	private function getDataEjecutaExcepcion(event:EjecutarAjusteCExcepcionCargosResultEvent):void	{

		PopUpManager.removePopUp(popUpWindow);
		
		if (event.result.desError == null){
							
	     	Alert.show("Número de la OOSS.: " + event.result.nroOOSS.toString(), "OOSS Ajuste Nota Credito");
	     	
	     	//Se llama al WS para grabar el comentario
	     	wsInsertaComent(txtComentario.text, event.result.nroOOSS);
	     	
	     	//Se levanta la pantalla de registro
		    //levantaRegistroIngOoss('Cliente'); //Se comenta funcionalidad(No certificada) AF resposable : Ruben Araya
	     	
		}else{	
     		Alert.show(event.result.desError, "No se puede ejecutar la OOSS");
		}
		cerrar();

	} // getDataEjecutaExcepcion  
				
	// -----------------------------------------------------------------------------------------------------
			
	private function cargaDatosComunesDTOEjecutar(datoDTO:*):void	{
		
		datoDTO.numTransaccion = numTransaccion; 								// numero de la transacción 
		datoDTO.observacion = txtComentario.text.toString();  					// observacion que va a la CI_ORSERV 
		datoDTO.nomUsuarioSCL = parentApplication.usuario.username;				// usuario logueado
		datoDTO.codError = "1";													// en duro para que sea null
		datoDTO.desError = "N";													// en duro para que sea null			
		datoDTO.nroOOSS = 1;
		datoDTO.tipoAjuste = tipoAjuste;										// tipo de ajuste (Parcial/Total)
		datoDTO.montoTotalAjuste = new Number(IdMtoPago.text.toString());
		datoDTO.codCauPago = coCausaPago.selectedItem.codCauPago.toString();	// Causa de pago
		datoDTO.codOriPago = coOrigenPago.selectedItem.codOriPago.toString(); 	// Codigo origen del pago
						
	} // cargaDTOEjecutar
		
	// -----------------------------------------------------------------------------------------------------
	
	private function cerrar():void {
		this.visible = false;
		parentDocument.vbOOSS.enabled = false;
		parentDocument.vb1.enabled = true;
		parentDocument.tab1.selectedIndex= 0;	
		return;
	} // cerrar

	// -----------------------------------------------------------------------------------------------------

	private function selectFolio():void	{
		if (coFoliosFacturas.selectedItem != null)
			executeWSFiltro();
		else
			Alert.show( "Debe seleccionar un documento.", 
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
				
	} // selectFolio

	// -----------------------------------------------------------------------------------------------------
	
	private function selectT():void	{
		
		lblMonto1.visible = true;
		lblMonto2.visible = true;
		IdMtoPago.visible = true;
		
		coFoliosFacturas.enabled = false;
		coFoliosFacturas.visible = false;
		titFolio.visible = false;
		btnDocs.visible = false;
		
		IdMtoPago.text = mtoOOSS.toString();
		tipoAjuste = 0;
		
	} // selectT

	// -----------------------------------------------------------------------------------------------------

	private function selectP():void	{

		lblMonto1.visible = false;
		lblMonto2.visible = false;
		IdMtoPago.visible = false;
		
		titFolio.visible = true;
		coFoliosFacturas.visible = true;
		btnDocs.visible = true;
		
		tipoAjuste = 1;
		IdMtoPago.text = mtoOOSSPuntual.toString();
		
		if (arrayFoliosFacturasdata != null)	
			coFoliosFacturas.enabled = true;
		else	{
			coFoliosFacturas.enabled = false;
			
			Alert.show( "No hay documentos para el cliente.", 
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
		} // else
		
	} // selectP

	// -----------------------------------------------------------------------------------------------------

	private function wsInsertaComent(comentario:String, numOoss:Number):void	{
		
		wsORQ.addWSSEGPortalFaultEventListener(getError);
		wsORQ.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
		//wsORQ.addobtenerOoSsAgendadasEventListener();
		wsORQ.insertComentario(comentario,numOoss);
	
	}		
	