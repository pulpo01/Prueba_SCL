	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// ------------------------------------------------------------------------------------------		
	import generated.webservices.orquestador.ObtenerCausalCambioResultEvent;
	import generated.webservices.orquestador.ObtenerReporteCambioEquiGeneResultEvent;
	import generated.webservices.orquestador.ObtenerReporteIngrStatusEquiResultEvent;
	import generated.webservices.orquestador.ObtenerReportePresEquiIntResultEvent;
	
	import mx.controls.Alert;
	
	
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
	
	private function filldsGrid(documentos:Array):void	{

		for (var fila:Number=0; fila < documentos.length; fila++)	{
			var dto:DocCtaCteClienteDTO = new DocCtaCteClienteDTO();
			dto = documentos[fila];
			//dsGrid.push(dto);
			dto=null;
		} // for
		
	} // filldsGrid
	
	// --------------------------------------------------------------------------------
	
	private function getDataCambioEquiGene(event:ObtenerReporteCambioEquiGeneResultEvent):void	{
	
		if (event.result.reporteCamEquiGenDTO != null)	{
			
			gridCamEquiGend = event.result.reporteCamEquiGenDTO;
			
			if(rbt4.selected){
				alertRep1 = 1;
				alertMasivo();
			}else{
				PopUpManager.removePopUp(popUpWindow);
			}
			
		}else{
			
			if(rbt4.selected){
				alertRep1 = 2;
				alertMasivo();
			}else{
			
				//Se limpia la grilla
				limpiaGrid('reporte1');
				
				PopUpManager.removePopUp(popUpWindow);
				
				Alert.show( "No se encontraron datos para el reporte de cambio de equipo generado.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
			}
		}
				
	} // getDataCambioEquiGene
	
	// --------------------------------------------------------------------------------
	
	private function getDataIngrStatus(event:ObtenerReporteIngrStatusEquiResultEvent):void	{
	
		if (event.result.reporteIngrStatusEquiDTO != null)	{
			
			gridIngEquiStaEqui = event.result.reporteIngrStatusEquiDTO;
			
			if(rbt4.selected){
				alertRep2 = 1;
				alertMasivo();
			}else{
				PopUpManager.removePopUp(popUpWindow);
			}
			
		}else{
			
			if(rbt4.selected){
				alertRep2 = 2;
				alertMasivo();
			}else{
			
				//Se limpia la grilla
				limpiaGrid("reporte2");
				
				PopUpManager.removePopUp(popUpWindow);
				
				Alert.show( "No se encontraron datos para el reporte de ingreso de equipo y status del equipo.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
			}
		}
				
	} // getDataCambioEquiGene 
	
	// --------------------------------------------------------------------------------
	
	private function getDataPresEquiInt(event:ObtenerReportePresEquiIntResultEvent):void	{
	
		if (event.result.reportePresEquiIntDTO != null)	{
			
			gridPrestEquiInter = event.result.reportePresEquiIntDTO;
			
			if(rbt4.selected){
				alertRep3 = 1;
				alertMasivo();
			}else{
				PopUpManager.removePopUp(popUpWindow);
			}
			
		}else{
			
			if(rbt4.selected){
				alertRep3 = 2;
				alertMasivo();
			}else{
			
				//Se limpia la grilla
				limpiaGrid("reporte3");
				
				PopUpManager.removePopUp(popUpWindow);
				
				Alert.show( "No se encontraron datos para el reporte de prestamo de equipos internos.", 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
			}
		}
				
	} // getDataCambioEquiGene  
		
	// --------------------------------------------------------------------------------	

	private function executeWS():void	{

		//reset
		alertRep1 = 0;
		alertRep2 = 0;
		alertRep3 = 0;

		dcDesde.setVisible(false);
		dcHasta.setVisible(false);
		
		// se muestra el scrollbar
	    popUpParent = Application.application.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);


		if(rbt1.selected || rbt4.selected){

			if(combCbEquiGene.selectedIndex == -1){
				
				PopUpManager.removePopUp(popUpWindow);
				Alert.show( "Debe seleccionar una causal de cambio.", 
				"Advertencia", 
				mx.controls.Alert.OK,
				this,
				null,
				iconWarning,
				mx.controls.Alert.OK );
				
				return;
			}

		}
		
		if (dcHasta.selectedDate > dcDesde.selectedDate)	{
			
			
			this.fechaDesde;
			this.fechaHasta;
			
			wsORQ1.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
			wsORQ1.addWSSEGPortalFaultEventListener(getError);
		
			if(rbt1.selected){
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReporteCambioEquiGeneEventListener(getDataCambioEquiGene);
				wsORQ1.obtenerReporteCambioEquiGene(this.fechaDesde, this.fechaHasta, combCbEquiGene.selectedItem.data );
			}else if(rbt2.selected){
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReporteIngrStatusEquiEventListener(getDataIngrStatus);
				wsORQ1.obtenerReporteIngrStatusEqui(this.fechaDesde, this.fechaHasta);
			}else if(rbt3.selected){
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReportePresEquiIntEventListener(getDataPresEquiInt);
				wsORQ1.obtenerReportePresEquiInt(this.fechaDesde, this.fechaHasta);
			}else if(rbt4.selected){
				
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReporteCambioEquiGeneEventListener(getDataCambioEquiGene);
				wsORQ1.obtenerReporteCambioEquiGene(this.fechaDesde, this.fechaHasta, combCbEquiGene.selectedItem.data );
				
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReporteIngrStatusEquiEventListener(getDataIngrStatus);
				wsORQ1.obtenerReporteIngrStatusEqui(this.fechaDesde, this.fechaHasta);
				
				//Reporte de cambio de equipo Generado
				wsORQ1.addobtenerReportePresEquiIntEventListener(getDataPresEquiInt);
				wsORQ1.obtenerReportePresEquiInt(this.fechaDesde, this.fechaHasta);
			}
			
		}else{
			
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
  		
  		// se muestra el scrollbar
	    popUpParent = Application.application.document;
	    popUpWindow = PopUpManager.createPopUp(popUpParent,searchingPopUpView,true);
		PopUpManager.centerPopUp(popUpWindow);
  		
  		dcDesde.dayNames = ["D", "L", "M", "M", "J", "V", "S"];      
		dcDesde.monthNames = ["Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre","Diciembre"];
  		  		
  		dcHasta.dayNames = dcDesde.dayNames;
  		dcHasta.monthNames = dcDesde.monthNames;
  		
  		var hoy:Date = new Date();
  		dcHasta.selectedDate = hoy;
  		
  		var dias:Number = parseInt(StringUtil.getValor("RangoDiasCtaCte","VALOR"));
  		dcDesde.selectedDate = new Date(hoy.fullYear,hoy.month,hoy.date-dias);

		// Seteo las fechas para su busqueda  		
  		eligeFecha(1);
  		eligeFecha(2);
  		
  		//Carga combo causa
  		cargaCombCausa();
  		
	} // init

	// --------------------------------------------------------------------------------
	
	private function cerrar():void {
		PopUpManager.removePopUp(this);
	} // cerrar
	
	
	// --------------------------------------------------------------------------------
	
    public function cargaCombCausa():void {
    
	   wsORQ1.setearEndpoint(StringUtil.getValor("AppServerRootURL","VALOR")+StringUtil.getValor("endpointORQ","VALOR"));
	   wsORQ1.addWSSEGPortalFaultEventListener(getError);
	   wsORQ1.addobtenerCausalCambioEventListener(getDataCombCausa);
	   wsORQ1.obtenerCausalCambio();
	   
              
     }
     
      public function getDataCombCausa(event:ObtenerCausalCambioResultEvent):void	{
      	
      	PopUpManager.removePopUp(popUpWindow);
      	
      	if(event.result.causalCambioDTO != null){
      	
	      	var Comdata:ArrayCollection	 = new  ArrayCollection();
			var oDato : Object;
	
			var numcant:int = event.result.causalCambioDTO.length;
			
			for (var i:int = 0; i < numcant; i++){
				
		    	oDato = new Object();
				oDato.label = event.result.causalCambioDTO[i].desCaucaser;
				oDato.data = event.result.causalCambioDTO[i].codCaucaser;  
				Comdata.addItem(oDato);
				
		    }
		    
			combCbEquiGene.dataProvider = Comdata;
			combCbEquiGene.selectedIndex = -1;
		
		
		}else{

			Alert.show( "Problemas al obtener las causales de cambio", 
			"Advertencia", 
			mx.controls.Alert.OK,
			this,
			null,
			iconWarning,
			mx.controls.Alert.OK );
			
			cerrar();
		}
      	
      }
      
    // -------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga
	// Version : 1.0
	// Fecha : 31/08/2010
	// ------------------------------------------------------------------------------------------
      private function alertMasivo():void	{
      	
      	if(alertRep1 != 0 && alertRep2 != 0 && alertRep3 != 0) {
      		
      		var mensj:String = "No se encontraron datos para el reporte de";
      		var mosMenj:Boolean = false;
      		
      		if(alertRep1 == 2) {
      			mosMenj = true;
      			mensj = mensj + " cambio de equipo generado";
      			
      			//Se limpia la grilla
				limpiaGrid('reporte1');
      		}
      		if(alertRep2 == 2) {
      			mosMenj = true;
      			if(alertRep1 == 2) {
      				mensj = mensj + ", ingreso de equipo y status del equipo";	
      			}else{
      				mensj = mensj + " ingreso de equipo y status del equipo";	
      			}
      			
      			//Se limpia la grilla
				limpiaGrid('reporte2');
      		}
      		if(alertRep3 == 2) {
      			mosMenj = true;
      			if(alertRep1 == 2 || alertRep2 == 2) {
      				mensj = mensj + ", prestamo de equipos internos";	
      			}else{
      				mensj = mensj + " prestamo de equipos internos";
      			}
      			
      			//Se limpia la grilla
				limpiaGrid('reporte3');
      		}
      		
      		mensj = mensj + ".";
			PopUpManager.removePopUp(popUpWindow);
			
			if(mosMenj) {
				
				PopUpManager.removePopUp(popUpWindow);
				
				Alert.show(mensj, 
					"Advertencia", 
					mx.controls.Alert.OK,
					this,
					null,
					iconWarning,
					mx.controls.Alert.OK );	
			}
		}
      }