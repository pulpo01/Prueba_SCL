	// ------------------------------------------------------------------------------------------
	// Autor : Gabriel Moraga L.
	// Version : 1.0
	// Fecha : 13/08/2010
	// ------------------------------------------------------------------------------------------
	
	import OOSS.General.RegistrarIngresoOoss;
	
	import mx.core.Application;
	
	public var registrarIngresoOoss:Class = RegistrarIngresoOoss;
	
	private function levantaRegistroIngOoss(origen:String):void	{
	
		//Se obtiene la fecha de registro de OK de la session
		var hoy:Date = new Date();
		var mes:Number = hoy.getMonth() + 1;
		var fechaCompl:String = hoy.getDate()+'/'+mes+'/'+hoy.getFullYear()+' '+hoy.getHours()+':'+hoy.getMinutes()+':'+hoy.getSeconds();

		//Se mantiene en session la fecha
		Application.application.sesionDateOOSS = fechaCompl;
		     	
		//Se levanta la pantalla para realizar el resgistro
		registrarIngresoOoss.tipo = origen;
		popUpParent = this;
		popUpWindow = PopUpManager.createPopUp(popUpParent, registrarIngresoOoss, true);
		PopUpManager.centerPopUp(popUpWindow);

	}