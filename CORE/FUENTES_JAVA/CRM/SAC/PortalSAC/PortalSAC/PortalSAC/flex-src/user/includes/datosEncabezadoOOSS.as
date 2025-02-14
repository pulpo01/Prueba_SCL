
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.core.Application;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.http.HTTPService;
	
	import user.libreria.clases.Utilidades;
	import user.libreria.clases.StringUtil;
		
	private function getErrorDatosEncabezado(event:FaultEvent):void    {
		        
		var mensaje:String = new String();
		mensaje = "Ha ocurrido un problema al buscar los datos del encabezado.";
		Alert.show( mensaje, 
						"Error", 
						mx.controls.Alert.OK,
						this,
						null,
						null,
						mx.controls.Alert.OK );
		
     } // getError

	// --------------------------------------------------------------------------------------------------------------------------------------
	
   	private function datosCuenta(codCuenta:Number):void	{

		var servicio:HTTPService = new HTTPService();
		
		servicio = new HTTPService();		
		servicio.addEventListener(FaultEvent.FAULT, getErrorDatosEncabezado);
		servicio.method="GET";
		servicio.resultFormat="e4x";
		servicio.addEventListener(ResultEvent.RESULT, getDatosCuenta);
		servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("cuentasXCodigo","PATH");				
		servicio.request = {codCuenta:codCuenta};
		servicio.send();

	} // datosCuenta

	// --------------------------------------------------------------------------------------------------------------------------------------
		
	private function getDatosCuenta(evento:ResultEvent):void	{

		setDatosEncabezado();
		
		if (evento.result != null)	{
			var resultados:ArrayCollection = Utilidades.fillArrayCollection(evento.result, generated.webservices.orquestador.CuentaDTO);
			DatosEncabezadoOOSS.nomCuenta.text = resultados[0].desCuenta;	// desCuenta
		} // if
		
		setPathTitulo();
		
	} // getDatosCuenta  
	
	// --------------------------------------------------------------------------------------------------------------------------------------
		
	private function datosCliente(codCliente:Number):void	{

		var servicio:HTTPService = new HTTPService();
		
		servicio = new HTTPService();		
		servicio.addEventListener(FaultEvent.FAULT, getErrorDatosEncabezado);
		servicio.method="GET";
		servicio.resultFormat="e4x";
		servicio.addEventListener(ResultEvent.RESULT, getDatosCliente);
		servicio.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("clientesXCodCliente","PATH");				
		servicio.request = {codCliente:codCliente};
		servicio.send();
		
	} // datosCuenta

	// --------------------------------------------------------------------------------------------------------------------------------------
		
	private function getDatosCliente(evento:ResultEvent):void	{
		
		setDatosEncabezado();

		if (evento.result != null)	{
			var resultados:ArrayCollection = Utilidades.fillArrayCollection(evento.result, generated.webservices.orquestador.ClienteDTO);
			DatosEncabezadoOOSS.nomCliente.text = resultados[0].nomCliente;	// desCuenta
		} // if

		setPathTitulo();
		
	} // getDatosCliente  
	
	// --------------------------------------------------------------------------------------------------------------------------------------
		
	private function setDatosEncabezado():void	{
		
		var nivel:String = StringUtil.getValor(Application.application.codEvento, "NIVEL");

		if (Application.application.cliSelect != null) DatosEncabezadoOOSS.numCliente.text = Application.application.cliSelect;								
		if (Application.application.ctaSelect != null) DatosEncabezadoOOSS.numCuenta.text =  Application.application.ctaSelect;		
		
		switch(nivel)	{
			case "CLIENTE":
				if (Application.application.nomCliSelect != null) DatosEncabezadoOOSS.nomCliente.text = Application.application.nomCliSelect;
				break;
				
			case "ABONADO":
				if (Application.application.aboSelect != null)	{
					DatosEncabezadoOOSS.numAbonad.visible=true;
					DatosEncabezadoOOSS.numCelular.visible=true;
					DatosEncabezadoOOSS.Situacion.visible=true;
					DatosEncabezadoOOSS.nomAbonado.visible=true;
					
					DatosEncabezadoOOSS.lbl1.visible=true;
					DatosEncabezadoOOSS.lbl2.visible=true;
					DatosEncabezadoOOSS.lbl3.visible=true;
					DatosEncabezadoOOSS.lbl4.visible=true;
					
					DatosEncabezadoOOSS.numAbonad.text = Application.application.aboSelect;
					if (Application.application.numCelAboSelect != null) DatosEncabezadoOOSS.numCelular.text = Application.application.numCelAboSelect;			
					if (Application.application.sitAboSelect != null) DatosEncabezadoOOSS.Situacion.text =  Application.application.sitAboSelect;
					if (Application.application.nomAboSelect != null) DatosEncabezadoOOSS.nomAbonado.text = Application.application.nomAboSelect;
				} // if
		} // switch
		
	} // setDatosEncabezado  
	
	// --------------------------------------------------------------------------------------------------------------------------------------
	
	private function setPathTitulo():void	{
		
		Application.application.lblPathTitulo.text = 
			"CUENTA : " + DatosEncabezadoOOSS.nomCuenta.text + 
			"/ CLIENTE : " + DatosEncabezadoOOSS.nomCliente.text +
			"/ ABONADO : " + DatosEncabezadoOOSS.nomAbonado.text;
			
	} // setPathTitulo
	
	// --------------------------------------------------------------------------------------------------------------------------------------
