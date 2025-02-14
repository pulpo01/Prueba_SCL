	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		
	
	private function getError(event:FaultEvent):void    {
		        
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

	// --------------------------------------------------------------------------------
	
	private function getDataDeuda(event:GetDeudaClienteResultEvent):void	{
	
		if (event.result != null)	{
			txtDeudaTotal.text = event.result.deudaTotal.toString();
			if (txtDeudaTotal.text != "0")
				txtDeudaTotal.text = formato.format(txtDeudaTotal.text);
		} // if
		
		hideScrollBar();
				
	} // getDataDeuda  
	
	// --------------------------------------------------------------------------------			
	
	private function filldsGrid(documentos:Array):void	{

		for (var fila:Number=0; fila < documentos.length; fila++)	{
			var dto:DocCtaCteClienteDTO = new DocCtaCteClienteDTO();
			dto = documentos[fila];
			dsGrid.push(dto);
			dto=null;
		} // for
		
		//Se habilita los radio boton
		bloqAndDesBloqRadio('desBloq');
		
	} // filldsGrid
	
	// --------------------------------------------------------------------------------

	private function getDataDocs(event:GetDocsCtaCteClienteResultEvent):void	{
	
		if (event.result.arrayDocumentos!= null)	{
			filldsGrid(event.result.arrayDocumentos);
			ac.refresh();
		} // if

		hideScrollBar();
				
	} // getDataDocs  
				
	// --------------------------------------------------------------------------------	

	private function executeWS(opcion:String):void	{

		grupo1.selectedValue='fecEmisionOrd';
		grupo2.selectedValue='Asc';

		dcDesde.setVisible(false);
		dcHasta.setVisible(false);
		
		// se muestra el scrollbar
	    popUpParent = Application.application.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);
 
 		if (opcion == "todos")	{
			// Cuando se carga la pantalla se busca tambien la deuda total del cliente
			this.flagCarga = 2;

			// Busco la deuda actual del cliente
			wsORQ1.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
			wsORQ1.addgetDeudaClienteEventListener(getDataDeuda);
			wsORQ1.getDeudaCliente(this.codCliente);
		} // if
		else 
			this.flagCarga = 1;


		if (dcHasta.selectedDate > dcDesde.selectedDate)	{
			dsGrid = new Array();

			// Datos del cliente
			var obj:GetDocsClienteINDTO = new GetDocsClienteINDTO();
			obj.codCliente = codCliente;
			obj.fecInicio = this.fechaDesde;
			obj.fecFin = this.fechaHasta;
			
			// Para auditoria
			var nomUsuario:String = Application.application.usuario.username;
			var codEvento:String = Application.application.codEvento; 
			
			// Busco las facturas
	 		wsORQ2.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
			wsORQ2.addWSSEGPortalFaultEventListener(getError);
			wsORQ2.addgetDocsCtaCteClienteEventListener(getDataDocs);
			wsORQ2.getDocsCtaCteCliente(obj, nomUsuario, codEvento);
		} //  if
		else	{
			PopUpManager.removePopUp(popUpWindow);
			Alert.show( "El rango de fechas ingresado no es válido", 
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
		} // else
		
		
	} // executeWS

	// --------------------------------------------------------------------------------
				
  	private function showCalendar(flag:Number):void {
	  	switch(flag)	{
  			// fecha inicio
  			case 1:
				dcDesde.setVisible(true); 
  				break;
  			// fecha fin
  			case 2:
				dcHasta.setVisible(true);	
  		} // switch 
  		
	} // showCalendar

	// --------------------------------------------------------------------------------

	private function eligeFecha(flagFecha:Number):void {
  		
  		switch (flagFecha)	{
  			// fecha inicio
  			case 1:
  				btnDesde.label = "Desde " + dcDesde.selectedDate.date.toString() + "/" + (dcDesde.selectedDate.month+1).toString() + "/" + dcDesde.selectedDate.fullYear;
  				this.fechaDesde = dcDesde.selectedDate.date.toString() + "/" + (dcDesde.selectedDate.month+1).toString() + "/" + dcDesde.selectedDate.fullYear; 
  				dcDesde.setVisible(false); 
  				break;
  			// fecha fin
  			case 2:
  				btnHasta.label = "Hasta " + dcHasta.selectedDate.date.toString() + "/" + (dcHasta.selectedDate.month+1).toString() + "/" + dcHasta.selectedDate.fullYear;
  				this.fechaHasta = dcHasta.selectedDate.date.toString() + "/" + (dcHasta.selectedDate.month+1).toString() + "/" + dcHasta.selectedDate.fullYear;
  				dcHasta.setVisible(false);	
  		} // switch 
  		
	} // eligeFecha

  	// --------------------------------------------------------------------------------
  	
  	private function init():void {
  		
  		dcDesde.dayNames = ["D", "L", "M", "M", "J", "V", "S"];      
		dcDesde.monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"];
  		  		
  		dcHasta.dayNames = dcDesde.dayNames;
  		dcHasta.monthNames = dcDesde.monthNames;
  		
  		txtCliente.text  = "(" + Application.application.clienteDTO.codCliente + ") " + Application.application.clienteDTO.nomCliente;
  		
  		var hoy:Date = new Date();
  		dcHasta.selectedDate = hoy;
  		
  		var dias:Number = parseInt(StringUtil.getValor("RangoDiasCtaCte","VALOR"));
  		dcDesde.selectedDate = new Date(hoy.fullYear,hoy.month,hoy.date-dias);

		// Seteo las fechas para su busqueda  		
  		eligeFecha(1);
  		eligeFecha(2);
  		
		executeWS("todos");
	} // init

	// --------------------------------------------------------------------------------
	
	private function cerrar():void {
		PopUpManager.removePopUp(this);
	} // cerrar
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
		 	
	private function filtrar():void	{
		ac.filterFunction = filtroGrilla;
		ac.refresh();
	}
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.1
	// Fecha : 17/12/08
	// ------------------------------------------------------------------------------------------
	
	private function filtroGrilla(item:Object):Boolean 	{
		var campo:String;
	
		switch(cboFiltro.selectedItem.data)	{
			case 1:	
				if  (item.numFolio.toString().toUpperCase().indexOf(txtFiltro.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 2:								
				if  (item.fecEmision.toUpperCase().indexOf(txtFiltro.text.toUpperCase()) >= 0)	
					return true;
				else
					return false;
			case 3:	
				if  (item.fecVencimiento != null)	{
					if (item.fecVencimiento.toUpperCase().indexOf(txtFiltro.text.toUpperCase()) >= 0)	
						return true;
					else
						return false;
				} // if
				else
					return false;
		} // switch
			 
		return true;
		 
	} // procesarFiltro
	
	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Galetti
	// Version : 1.0
	// Fecha : 19/12/08
	// ------------------------------------------------------------------------------------------

	private function changeCombo(combo:ComboBox):void	{

		txtFiltro.text = "";
		ac.refresh();						
		
	} // changeCombo

	// --------------------------------------------------------------------------------
	// Si se terminaron de orquestar todos los servicios de la pagina entonces se oculta el scrollbar
	private function hideScrollBar():void	{
	
		this.flagCarga--;
		if (this.flagCarga==0)	{
			PopUpManager.removePopUp(popUpWindow);

			// Verificamos despues que se ejecuto todo a ver si no han traido nada todos los servicios			
			if (dsGrid.length == 0){
				
				//Se deshabilita los radio boton
				bloqAndDesBloqRadio('bloq');
				
				Alert.show( "No se han encontrado documentos para este cliente.", 
					"Advertencia", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );
			}
		} // if
		
	} // hideScrollBar
	
	// --------------------------------------------------------------------------------
	
	private function verFacturaEnPdf():void	{

		if (gridCtaCte.selectedItem != null && gridCtaCte.selectedItem.textoDetalle != null)	{
			var IND_ORDENTOTAL:String = gridCtaCte.selectedItem.indOrdenTotal;
	
			// Se reemplazan los valores de los parametros
			var url:String = StringUtil.getValor("doc1server","VALOR");
			url = url.replace("%IND_ORDENTOTAL%",IND_ORDENTOTAL );
			url = url.replace("%COD_CLIENTE%", this.codCliente);
							
			// Se invoca la url
			var oossExterna:URLRequest = new URLRequest(url);
			flash.net.navigateToURL(oossExterna, "new");
		} // if
		
	} // verFacturaEnPdf
	
	// --------------------------------------------------------------------------------
	
    public function myStyleFunction(data:Object, column:AdvancedDataGridColumn):Object	{            
    
	    var desTipDocum:String = String(data.desTipDocum);            
                
	    if (desTipDocum.indexOf("Factura") >= 0)	
     		return {background: true, backgroundColor: 0xAA0000};           
        else
        	return {}; 
              
     }
     
     // ------------------------------------------------------------------------------------------
		// Autor : Gabriel Moraga L
		// Version : 1.0
		// Fecha : 17/08/2010
		// ------------------------------------------------------------------------------------------
		
		private function bloqAndDesBloqRadio(accion:String):void {

			if(accion == 'bloq'){
				hRadio1.enabled = false;
				hRadio2.enabled = false;
			}else if(accion == 'desBloq'){
				hRadio1.enabled = true;
				hRadio2.enabled = true;
			}
   
        }
