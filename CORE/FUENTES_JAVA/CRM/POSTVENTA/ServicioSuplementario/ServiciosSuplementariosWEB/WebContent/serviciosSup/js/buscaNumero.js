
	// -----------------------------------------------------------------------------------------------------------------------
	
	function fncInicio(){

		fncMostrarFiltros("inicio");

		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		var numeroSel = document.getElementById("numeroSel");

		if (numeroSel.value!=""){
			document.getElementById("divResultadoNumero").style["display"] = "";			
			document.getElementById("divResultadoBusqueda").style["display"] = "";			
			document.getElementById("divResultadoRango").style["display"] = "";			
		}else{
			var rdNumeroSel = document.getElementById("rdNumeroSel");
			var rdRangoSel = document.getElementById("rdRangoSel");
			
			if (rdNumeroSel != null || rdRangoSel != null){
				document.getElementById("divResultadoBusqueda").style["display"] = "";
			}
			
			if (rdNumeroSel != null ){
				document.getElementById("divResultadoNumero").style["display"] = "";
				document.getElementById("divResultadoRango").style["display"] = "none";
			}else{
				document.getElementById("divResultadoNumero").style["display"] = "none";
				document.getElementById("divResultadoRango").style["display"] = "";
			}
			
		}
		
		document.forms[0].busquedaRangoInfAux.onpaste = function() { return fncOnPasteValidaNumero();}; 
		document.forms[0].busquedaRangoSupAux.onpaste = function() { return fncOnPasteValidaNumero();}; 	
		document.forms[0].prefijo.onpaste = function() { return fncOnPasteValidaNumero();}; 	
		document.forms[0].numeroRango.onpaste = function() { return fncOnPasteValidaNumero();}; 			
			
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	
	function fncSeleccionaTipoBusqueda(rdTipoBusqueda)	{
		var tipoBusquedaAnt = document.getElementById("tipoBusqueda").value;	// campo oculto	
		var tipoBusquedaNue = rdTipoBusqueda.value;								// radio buttons de tipo de busqueda
		// Guardo la nueva seleccion del usuario
		document.getElementById("tipoBusqueda").value = tipoBusquedaNue;
						
		if (tipoBusquedaAnt!=tipoBusquedaNue)	{
			fncValidarAnularReservaNumAut();//si ya se busco por numeracion automatica, se debe reponer numero anterior
			fncMostrarFiltros("seleccion");//activa o desactiva controles de pagina
		} // if
		
	} // fncSeleccionaTipoBusqueda

	// -----------------------------------------------------------------------------------------------------------------------	
	
	function fncValidarAnularReservaNumAut()	{
	
		var tablaNumeracionAut = document.getElementById("tablaNumeracionAut");
		var rdNumeroSel = document.getElementById("rdNumeroSel");
		
		if (tablaNumeracionAut.value!="" && rdNumeroSel != null)	{
			document.getElementById("opcion").value = "validarAnularReservaNumAut";
			fncSubmit();
		} // if
		
	} // fncValidarAnularReservaNumAut

	// -----------------------------------------------------------------------------------------------------------------------	

	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
	
	function fncInvocarPaginaExpiraSesion()	{
    	document.forms[0].submit();
	}

	// -----------------------------------------------------------------------------------------------------------------------
	
	function fncSubmit()	{
		fncInvocarPaginaExpiraSesion()
	}
	
	// -----------------------------------------------------------------------------------------------------------------------
			
	function fncSeleccionaNumero(numero){
		document.getElementById("numeroSel").value = numero.value;
	}
		
	// -----------------------------------------------------------------------------------------------------------------------

	function fncMostrarFiltros(evento){
		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");

		if (tipoBusqueda.value == "M"){
			//activar combo de busqueda
			document.getElementById("codCriterioBusqueda").disabled = false;
			
			if (codCriterioBusqueda.value=="" || codCriterioBusqueda.value=="RE"){
				//ocultar campos rango
				document.getElementById("divFiltroRango").style["display"] = "none";
			}
			else{
				//mostrar campos rango
				document.getElementById("divFiltroRango").style["display"] = "";
				if (evento != "inicio"){
				  	document.getElementById("busquedaRangoInf").value = "";
				  	document.getElementById("busquedaRangoSup").value = "";
				  	document.getElementById("busquedaRangoInfAux").value = "";
				  	document.getElementById("busquedaRangoSupAux").value = "";
				  	document.getElementById("prefijo").value = "";
				}
			}
		}
		else if(tipoBusqueda.value == "A"){
			//desactivar combo de busqueda
		    document.getElementById("codCriterioBusqueda").selectedIndex = 0;
		    document.getElementById("codCriterioBusqueda").disabled = true;
			
			//ocultar campos rango
			document.getElementById("divFiltroRango").style["display"] = "none";
		}
		
		document.getElementById("divNumeroSelRango").style["display"] = "none";
		document.getElementById("divResultadoNumero").style["display"] = "none";
		document.getElementById("divResultadoRango").style["display"] = "none";
		document.getElementById("divResultadoBusqueda").style["display"] = "none";
		
	}  
	
	// -----------------------------------------------------------------------------------------------------------------------
	
	function fncBuscar()	{
	
		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		var rangoInf = document.getElementById("busquedaRangoInfAux");
		var rangoSup = document.getElementById("busquedaRangoSupAux");
				
		if (tipoBusqueda.value==""){
			alert("Debe Ingresar Tipo B\u00FAsqueda");
			return false;
		}
		
		if (tipoBusqueda.value == "M")	{ //Manual
			if (codCriterioBusqueda.value==""){
				alert("Debe Ingresar Criterio de B\u00FAsqueda");
				return false;
			}
			
			if ((codCriterioBusqueda.value == "RU") || (codCriterioBusqueda.value == "RA")){
				if (rangoInf.value=="" || rangoSup.value ==""){
					alert("Debe Ingresar Rango Inferior y Superior");
					return false;
				}
				document.getElementById("busquedaRangoInf").value = rangoInf.value
				document.getElementById("busquedaRangoSup").value = rangoSup.value	
			}
			
	      	fncValidarAnularReservaNumAut();//si ya se busco por numeracion automatica, se debe reponer numero anterior
	      		
			if (codCriterioBusqueda.value == "RU"){
				document.getElementById("opcion").value = "obtenerNumeracionReutilizable";
				fncSubmit();
			}else if (codCriterioBusqueda.value == "RA"){
				document.getElementById("opcion").value = "obtenerNumeracionRango";
				fncSubmit();
			}else{
				document.getElementById("opcion").value = "obtenerNumeracionReservada";
				fncSubmit();
			}		
		} // if Manual
		
		if (tipoBusqueda.value == "A"){//Automatica
				document.getElementById("opcion").value = "obtenerNumeracionAutomatica";
				fncSubmit();
		} // if
		
		if (tipoBusqueda.value == "C"){//Carrier
			alert("Busqueda no Implementada");
			return;
		}
		
		document.getElementById("btnBuscar").disabled=true;
		document.getElementById("divResultadoBusqueda").style["display"] = "none";

	}	// fncBuscar
	
	// -----------------------------------------------------------------------------------------------------------------------
		
	function fncAceptar()	{
	
		var numeroSel = document.getElementById("numeroSel");
		if (numeroSel==null || numeroSel.value==""){
			alert("Debe seleccionar un n\u00FAmero");
			return false;
		}

		activarDesactivarControles(true);	
		document.getElementById("opcion").value = "aceptar";		
		fncSubmit();
	   	
	}	// fncAceptar
	
	// -----------------------------------------------------------------------------------------------------------------------
		
	function activarDesactivarControles(valor)	{
	
		document.getElementById("btnAceptar").disabled = valor;
		document.getElementById("btnCancelar").disabled = valor;
		document.getElementById("btnBuscar").disabled = valor;		
		
	}	// activarDesactivarControles
	
	// -----------------------------------------------------------------------------------------------------------------------
		
	function fncCancelar()	{
	
		activarDesactivarControles(true);

		//verifica si ingreso numeracion automatica y anula si corresponde
		var tablaNumeracionAut = document.getElementById("tablaNumeracionAut");
		var rdNumeroSel = document.getElementById("rdNumeroSel");
		
		// Si hay un numero reservado se debe reservar antes de cerrar la ventana
		if (tablaNumeracionAut.value!="" && rdNumeroSel != null)
	        document.getElementById("opcion").value = "cancelar";
		else
	        document.getElementById("opcion").value = "cerrar";

		fncSubmit();
		
	} // fncCancelar
	
	// -----------------------------------------------------------------------------------------------------------------------
	
	//(+)---- valida y completa prefijo ----------------	
	function fncPrefijo(txt){
		var prefijo = txt.value;
		if (parseInt(prefijo)>=0){
			document.getElementById("busquedaRangoInfAux").value = fncObtenerCadenaPrefijo(prefijo, "0");
			document.getElementById("busquedaRangoSupAux").value = fncObtenerCadenaPrefijo(prefijo, "9");		
			document.getElementById("busquedaRangoInf").value = document.getElementById("busquedaRangoInfAux").value;
			document.getElementById("busquedaRangoSup").value = document.getElementById("busquedaRangoSupAux").value;	
		}
	}
	
	function fncObtenerCadenaPrefijo(prefijo, valorRelleno){
		var largoCelular = document.getElementById("largoNumCelular").value;
		var largoRelleno = largoCelular - prefijo.length;
		var cadenaRetorno = prefijo;
		
		for(var i=0; i<largoRelleno;i++){
			cadenaRetorno = cadenaRetorno + valorRelleno;
		}
		return cadenaRetorno;
	}
	//(-)---- valida y completa prefijo ----------------	
			
	function fncSeleccionaNumero(numero){
		document.getElementById("numeroSel").value = numero.value;
	}
	
	function fncSeleccionaRango(rangoIni, rangoFin){
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		document.getElementById("numeroSel").value = rangoIni;
		
		if (codCriterioBusqueda.value == "RA"){
			document.getElementById("rangoInfSel").value =rangoIni;
			document.getElementById("rangoSupSel").value =rangoFin;
			
			document.getElementById("divNumeroSelRango").style["display"] = "";
			document.getElementById("numeroRango").value = rangoIni;
		}
	}
	
	
	function fncValidarNumeroRango(numero){
		if (numero.value!=""){
			var rangoIni = document.getElementById("rangoInfSel").value;
			var rangoFin = document.getElementById("rangoSupSel").value;
			
			if ( (Number(numero.value)<Number(rangoIni)) || (Number(numero.value)>Number(rangoFin))	)
			{
				 alert("N\u00FAmero Fuera de Rango");
				 numero.value = rangoIni;
			}
			
			document.getElementById("numeroSel").value = numero.value;
		}//fin if (numero.value!=""){
	}