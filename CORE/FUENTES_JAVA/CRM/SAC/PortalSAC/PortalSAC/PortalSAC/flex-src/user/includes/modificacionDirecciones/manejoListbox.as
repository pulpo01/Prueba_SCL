
	import mx.collections.ArrayCollection;
	import mx.controls.ComboBox;
	import mx.collections.Sort;
	import mx.collections.SortField;
	import user.libreria.clases.dto.*;
	


	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 20-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	private function loadRegiones():void	{

		// Carga el combo de regiones
		httpSrvRegiones.addEventListener(FaultEvent.FAULT, getError);
		httpSrvRegiones.method="GET";
		httpSrvRegiones.resultFormat="e4x";
		httpSrvRegiones.addEventListener(ResultEvent.RESULT, getRegiones);
		httpSrvRegiones.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("ConsultaRegiones","PATH");
		httpSrvRegiones.send();

	} // loadRegiones


	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 20-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------

	private function loadProvincias(codRegion:String):void	{

		// Carga el combo de provincias
		httpSrvProvincias.addEventListener(FaultEvent.FAULT, getError);
		httpSrvProvincias.method="GET";
		httpSrvProvincias.resultFormat="e4x";
		httpSrvProvincias.addEventListener(ResultEvent.RESULT, getProvincias);
		httpSrvProvincias.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("ConsultaProvincias","PATH");
		httpSrvProvincias.request = {codRegion:codRegion};
		httpSrvProvincias.send();
	
	} // loadProvincias
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 20-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	private function loadCiudades(codRegion:String, codProvincia:String):void	{

		// Carga el combo de ciudades
		httpSrvCiudades.addEventListener(FaultEvent.FAULT, getError);
		httpSrvCiudades.method="GET";
		httpSrvCiudades.resultFormat="e4x";
		httpSrvCiudades.addEventListener(ResultEvent.RESULT, getCiudades);
		httpSrvCiudades.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("ConsultaCiudades","PATH");
		httpSrvCiudades.request = {codRegion:codRegion, codProvincia:codProvincia};
		httpSrvCiudades.send();
	
	} // loadCiudades		

	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 20-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------

	private function loadComunas(codRegion:String, codProvincia:String, codCiudad:String):void	{

		// Carga el combo de comunas
		httpSrvComunas.addEventListener(FaultEvent.FAULT, getError);
		httpSrvComunas.method="GET";
		httpSrvComunas.resultFormat="e4x";
		httpSrvComunas.addEventListener(ResultEvent.RESULT, getComunas);
		httpSrvComunas.url = StringUtil.getValor("AppServerRootURL","VALOR") + StringUtil.getValor("ConsultaComunas","PATH");
		httpSrvComunas.request = {codRegion:codRegion, codProvincia:codProvincia, codCiudad:codCiudad};
		httpSrvComunas.send();
	
	} // loadComunas	

	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 19-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------

	private function getProvincias(evento:ResultEvent):void	{
		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")	{
			cboMunicipio.labelField = "desProvincia";
			
			//Creamos el dummy
			var provinciaDTO:ProvinciaDTO = new ProvinciaDTO();
			provinciaDTO.codProvincia = "";
			provinciaDTO.desProvincia = "Seleccione...";
			
			var resultado:ArrayCollection = Utilidades.fillArrayCollection(evento.result, user.libreria.clases.dto.ProvinciaDTO);
						
			// Ordenamos el resultado
			var sort:Sort = new Sort();
			sort.fields = [new SortField("desProvincia",true)];
			resultado.sort = sort;
			resultado.refresh();
			resultado.sort = null;

			cboMunicipio.dataProvider = resultado;

			//Insertamos el dummy
			resultado.addItemAt(provinciaDTO,0);
			// Si no se ha cambiado
			if (!flagCambios) seteaIndiceListbox(cboMunicipio, "codProvincia", detalleDireccionDTO.codProvincia);
			else
				cboMunicipio.selectedIndex = 0;
		}
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		hideScrollBar();		
	} // getMunicipios
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 19-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
		
	private function getRegiones(evento:ResultEvent):void	{

		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")	{
			cboDepartamento.labelField = "desRegion";
		
			//Creamos el dummy
			var regionDTO:RegionDTO = new RegionDTO();
			regionDTO.codRegion = "";
			regionDTO.desRegion = "Seleccione...";
			
			var resultado:ArrayCollection = Utilidades.fillArrayCollection(evento.result, user.libreria.clases.dto.RegionDTO);
			
			// Ordenamos el resultado
			var sort:Sort = new Sort();
			sort.fields = [new SortField("desRegion",true)];
			resultado.sort = sort;
			resultado.refresh();
			resultado.sort = null;

			//Insertamos el dummy
			resultado.addItemAt(regionDTO,0);
			cboDepartamento.dataProvider = resultado;
			
			// Si no se ha cambiado
			if (!flagCambios) seteaIndiceListbox(cboDepartamento, "codRegion", detalleDireccionDTO.codRegion);
			else
				cboDepartamento.selectedIndex = 0;
			
		}
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		hideScrollBar();	

	} // getRegiones  
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 19-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------

	private function getCiudades(evento:ResultEvent):void	{

		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")	{
			cboCiudad.labelField = "desCiudad";
			
			//Creamos el dummy
			var ciudadDTO:CiudadDTO = new CiudadDTO();
			ciudadDTO.codCiudad = "";
			ciudadDTO.desCiudad = "Seleccione...";
			
			var resultado:ArrayCollection = Utilidades.fillArrayCollection(evento.result, user.libreria.clases.dto.CiudadDTO);
			
			// Ordenamos el resultado
			var sort:Sort = new Sort();
			sort.fields = [new SortField("desCiudad",true)];
			resultado.sort = sort;
			resultado.refresh();
			resultado.sort = null;
			
			//Insertamos el dummy
			resultado.addItemAt(ciudadDTO,0);
			cboCiudad.dataProvider = resultado;
			
			// Si no se ha cambiado
			if (!flagCambios) seteaIndiceListbox(cboCiudad, "codCiudad", detalleDireccionDTO.codCiudad);
			else
				cboCiudad.selectedIndex = 0;			
		}
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		hideScrollBar();	

	} // getCiudades  
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 19-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------
	
	private function getComunas(evento:ResultEvent):void	{

		var desError:String = Utilidades.buscarElementoEnXML(evento.result as XML, "desError");
		if (evento.result != null && desError == "")	{
			cboReparto.labelField = "desComuna";
				
			//Creamos el dummy
			var comunaDTO:ComunaDTO= new ComunaDTO();
			comunaDTO.codComuna = "";
			comunaDTO.desComuna = "Seleccione...";
			
			var resultado:ArrayCollection = Utilidades.fillArrayCollection(evento.result, user.libreria.clases.dto.ComunaDTO);
			
			// Ordenamos el resultado
			var sort:Sort = new Sort();
			sort.fields = [new SortField("desComuna",true)];
			resultado.sort = sort;
			resultado.refresh();
			resultado.sort = null;
			
			//Insertamos el dummy
			resultado.addItemAt(comunaDTO,0);
			cboReparto.dataProvider = resultado;

			// Si no se ha cambiado
			if (!flagCambios) seteaIndiceListbox(cboReparto, "codComuna", detalleDireccionDTO.codComuna);
			else
				cboReparto.selectedIndex = 0;			
		}
		else	{
			// Si no encuentra nada debe limpiar la grilla de posibles resultados anteriores
			Alert.show( desError, 
						"Advertencia", 
						mx.controls.Alert.OK,
						this,
						null,
						iconWarning,
						mx.controls.Alert.OK );
		}
		
		hideScrollBar();	

	} // getCiudades  
	
	// ----------------------------------------------------------------------------------------
	// Create by HGG 
	// Date 18-08-2009
	// Version 1.0
	// ----------------------------------------------------------------------------------------	

	private function cambiaListbox(combo:ComboBox):void	{
		
 		seteaFlagCambios();
		flagCarga = 1;
		switch(combo.id)	{
			case "cboDepartamento":
				cboMunicipio.dataProvider = null;
				cboCiudad.dataProvider = null;
				cboReparto.dataProvider = null;
				break;
				
			case "cboMunicipio":
				cboCiudad.dataProvider = null;
				cboReparto.dataProvider = null;
				break;
			
			case "cboCiudad":
				cboReparto.dataProvider = null;				
		} // switch

		if (combo.selectedIndex > 0)	{
			// PRocesando...
		    showBusy();

			flagCarga = 1;
			switch(combo.id)	{
				case "cboDepartamento":
					loadProvincias(cboDepartamento.selectedItem.codRegion[0]);
					break;
					
				case "cboMunicipio":
					loadCiudades(cboDepartamento.selectedItem.codRegion[0], cboMunicipio.selectedItem.codProvincia[0]);
					break;
	
				case "cboCiudad":
					loadComunas(cboDepartamento.selectedItem.codRegion[0], cboMunicipio.selectedItem.codProvincia[0], cboCiudad.selectedItem.codCiudad[0]);
			} // switch
		} // if
		
		
	} //cargaCombo
	
	