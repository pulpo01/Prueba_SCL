<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JDatosLineaAJAX.js'></script>
<script type="text/javascript">
	
	window.history.forward(1);
	var ejecutandoAjax = false;
	var listaCeldas = new Array();
	var listaTiposPrestacion = new Array();
	var listaCentrales = new Array();
	var listaPlanesTarifarios = null;
	var listaLimiteConsumo = new Array();

	/*var logger = new Log(Log.DEBUG, Log.popupLogger);*/
	
	/*
	function debug(o, enabled) {
		if (enabled) {
			if (logger == null) {
				logger = new Log(Log.DEBUG, Log.popupLogger);
			}
			logger.debug(o);
		}
	}
	*/
	
	/*
	function debug(o) { 
		debug(o, true);		
	}
	*/
	
	function fncInicio() {
		
		/*
		var flgConsultaFinalizar = document.getElementById("flgConsultaFinalizar");
		var flgConsultaPA = document.getElementById("flgConsultaPA");
		if (flgConsultaPA.value == "1") {
			if (confirm("¿Desea contratar planes adicionales?")) {
				document.getElementById("opcion").value = "irAPlanesAdicionales";
		    	document.forms[0].submit();
		    	return;
			}
			else {
				document.getElementById("opcion").value = "contratarPlanesDefecto";
		    	document.forms[0].submit();
	    		return;
	    	}
		}
		if (flgConsultaFinalizar.value == 1) {//consulta si finaliza solicitud
			document.getElementById("flgConsultaFinalizar").value = 0;
			var	mensajes = document.getElementById("mensajes").innerHTML;
			if (mensajes == "") {//verifica que no hay errores
				if (confirm("¿Desea finalizar la solicitud?")) {
					fncFinalizarSolicitud();
					return;
				}
			}
		}
		*/
		
	 	fncActivarDesacControlesGrupoPrestacion();
	 	fncObtenerProvincia();
		var flgAplicaSeguro = document.getElementById("flgAplicaSeguro");
		var codTipoCliente = document.getElementById("codTipoCliente");
		if (flgAplicaSeguro.value == "1") {
			document.getElementById("codTipoSeguro").disabled = false;
		}
		else {
			document.getElementById("codTipoSeguro").selectedIndex = 0;
			document.getElementById("codTipoSeguro").disabled = true;
			document.getElementById("codTipoSeguro").value = "";
			document.getElementById("vigenciaSeguro").value = "";
		}
		fncConfigPantallaSegunTipoPrestacion();
		
    }
	
	function byId(id) {
		return document.getElementById(id);
	}
	
	function procesarDataAJAX(data) {
		if (data != null) {
	        var codError = data["codError"]; 
	        var mensajeError = data["msgError"]; 
	        if (codError != "") {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
        	return data["lista"];
	    }
    	return null;
	}
	
	function actualizarCombo(nombreCombo, lista, nombreCampoCodigo, nombreCampoValor, nombreSeleccionado) {
		DWRUtil.removeAllOptions(nombreCombo);
	    DWRUtil.addOptions(nombreCombo,{"":"- Seleccione -"});
	    
	    if (lista == null) return;
	    DWRUtil.addOptions(nombreCombo, lista, nombreCampoCodigo, nombreCampoValor);
	    
	    var combo = byId(nombreCombo);
		if (combo == null) return;
		
	    var sel = byId(nombreSeleccionado);
	    if (sel == null) return;
	    if (sel.value == "") return;

	    var encontrado = false;
	    var index = 0;
	    for (index = 0; index < combo.length; index++) {
   	  		if (combo[index].value == sel.value) {
	        	combo.selectedIndex = index;
    	    	encontrado = true;
        		break;
        	}
       	} 
	    if (!encontrado) {
	    	sel.value = ""; 
	    }
	}
    
    function getArrayDeString(str, separador) {
    	var r = new Array();
		var a = str.split(separador);
		for (var i = 0; i < a.length; i++) {
			r.push(a[i]);	
		}
		return r; 
    }
    
    function getArrayTiposPlanTarifariosSinLC() {
		return getArrayDeString(document.getElementById("tiposPlanTarifarioSinLC").value, ",")
    }
    
    function getArrayGrpPrestacionesSinLC() {
       	return getArrayDeString(document.getElementById("grpPrestacionesSinLC").value, ",")
    }
    
    /*function devErrorHandler(msg, exc) {
  		alert("Error: + \n -description [" + msg.description + "]\n -message [" + msg.message + "]");
	}*/
	
	//DWREngine.setErrorHandler(devErrorHandler);
 	
	function fncActivarDesacControlesGrupoPrestacion() {
		var codGrpPrestacion = byId("codGrpPrestacion");
		var codTipoCliente = byId("codTipoCliente");

		if (codGrpPrestacion != null && codGrpPrestacion.value != "" && codTipoCliente != null && codTipoCliente.value != "") {
			JDatosLineaAJAX.obtenerTiposPrestacionXTipoCliente(codGrpPrestacion.value, codTipoCliente.value, 	fncResultadoObtenerTiposPrestacionXTipoCliente);
		}
		else {
			DWRUtil.removeAllOptions("codTipoPrestacion");
	    	DWRUtil.addOptions("codTipoPrestacion",{"":"- Seleccione -"});
			DWRUtil.removeAllOptions("codUsoLinea");
	    	DWRUtil.addOptions("codUsoLinea",{"":"- Seleccione -"});
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{"":"- Seleccione -"});
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{"":"- Seleccione -"});
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo",{"":"- Seleccione -"});	
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codCausaDescuento");
	    	DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});		
			document.getElementById("tipoRed").value = "";
			document.getElementById("indInvFijo").value = "";	
			document.getElementById("indSS").value = "";
			document.getElementById("indNumeroPiloto").value = "";			
			document.getElementById("filtroPlan").selectedIndex = 0;
	    	document.getElementById("filtroPlan").value = "";
			document.getElementById("indNumeroCortoSMS").value = "";
			fncLimpiarServiciosSuplementarios();
			fncConfigPantallaSegunTipoPrestacion();
	    }
		//debug('fncActivarDesacControlesGrupoPrestacion(), fin');
	}
	
	function fncResultadoObtenerTiposPrestacionXTipoCliente(data) {
		var listaActualizada = procesarDataAJAX(data);
		if (listaActualizada != null) {
		    DWRUtil.removeAllOptions("codTipoPrestacion");
		    DWRUtil.addOptions("codTipoPrestacion",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codTipoPrestacion", listaActualizada, "codPrestacion", "desPrestacion");
			listaTiposPrestacion = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++) {
				var tipoPrestacion = new Array(7);
				tipoPrestacion[0] = listaActualizada[indice]["codPrestacion"];
				tipoPrestacion[1] = listaActualizada[indice]["tipoRed"];
				tipoPrestacion[2] = listaActualizada[indice]["indNumero"];
				tipoPrestacion[4] = listaActualizada[indice]["indInventario"];
				tipoPrestacion[5] = listaActualizada[indice]["indSSInternet"];
				tipoPrestacion[6] = listaActualizada[indice]["indNumeroPiloto"];
				listaTiposPrestacion[indice] = tipoPrestacion;
			}
			
			
			var codTipoPrestacionSeleccionada = document.getElementById("codTipoPrestacionSeleccionada").value;
		    if (codTipoPrestacionSeleccionada != "") {
			    var codTipoPrestacion = document.getElementById("codTipoPrestacion");
			    var encontrado = false;
			    for (index = 0; index < codTipoPrestacion.length; index++) {
			   		if (codTipoPrestacion[index].value == codTipoPrestacionSeleccionada) {
			     		codTipoPrestacion.selectedIndex = index;
			     		encontrado = true;
						for (var indice=0; indice < listaTiposPrestacion.length; indice++) {
							if (listaTiposPrestacion[indice][0] == codTipoPrestacion.value) {
								document.getElementById("tipoRed").value = listaTiposPrestacion[indice][1];
								document.getElementById("indNumero").value = listaTiposPrestacion[indice][2];
								document.getElementById("indInvFijo").value = listaTiposPrestacion[indice][4];
								document.getElementById("indSS").value = listaTiposPrestacion[indice][5];	
								document.getElementById("indNumeroPiloto").value = listaTiposPrestacion[indice][6];	
								var codGrpPrestacion = document.getElementById("codGrpPrestacion");	
								if(codGrpPrestacion == "SMS") {	
									document.getElementById("indNumeroCortoSMS").value = "1";			
								}
							}
						}
			     		fncConfigPantallaSegunTipoPrestacion();
			     		break;
			    	} 
			    }
			    if (!encontrado) {
			    	document.getElementById("codTipoPrestacionSeleccionada").value = "";
			    }
		    }
		    fncObtenerUsos();
  			fncObtenerCentrales();
	    }
	}
	
	function fncObtenerProvincia() {
		var codRegion = document.getElementById("codRegion");
		if (codRegion.value != "") {
			JDatosLineaAJAX.obtenerProvincias(codRegion.value, fncResultadoObtenerProvincia);
		}
		else {
			DWRUtil.removeAllOptions("codProvincia");
	    	DWRUtil.addOptions("codProvincia",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codCiudad");
	    	DWRUtil.addOptions("codCiudad",{'':'- Seleccione -'});	   
			DWRUtil.removeAllOptions("codCelda");
	    	DWRUtil.addOptions("codCelda",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});		    	 	
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});	
			document.getElementById("codTecnologia").value = "";	
			document.getElementById("codSubAlm").value = "";    
			fncLimpiarServiciosSuplementarios();
	    }
	}
	
	function fncResultadoObtenerProvincia(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codProvincia");
		    DWRUtil.addOptions("codProvincia",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codProvincia", listaActualizada, "codigo", "descripcion");

		    var codProvinciaSeleccionada = document.getElementById("codProvinciaSeleccionada").value;
		    if (codProvinciaSeleccionada != "") {
			    var codProvincia = document.getElementById("codProvincia");
			    var encontrado = false;
			    for (index = 0; index < codProvincia.length; index++) {
					if (codProvincia[index].value == codProvinciaSeleccionada) {
						codProvincia.selectedIndex = index;
						encontrado = true;
						break;
					} 
			    }
			    if (!encontrado) 
			    	document.getElementById("codProvinciaSeleccionada").value = ""
		    }
		    fncObtenerCiudad();
	    }
	}
	
	function fncObtenerCiudad() {
		var codRegion = document.getElementById("codRegion");
		var codProvincia = document.getElementById("codProvincia");
		if (codRegion.value!="" && codProvincia.value != "") {
			JDatosLineaAJAX.obtenerCiudades(codRegion.value, codProvincia.value, fncResultadoObtenerCiudad);
		}
		else {
			DWRUtil.removeAllOptions("codCiudad");
	    	DWRUtil.addOptions("codCiudad",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codCelda");
	    	DWRUtil.addOptions("codCelda",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});
			document.getElementById("codTecnologia").value = "";	
			document.getElementById("codSubAlm").value = "";    
			fncLimpiarServiciosSuplementarios();
	    }
	}
	
	function fncResultadoObtenerCiudad(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
		    DWRUtil.removeAllOptions("codCiudad");
		    DWRUtil.addOptions("codCiudad",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCiudad",listaActualizada,"codigo","descripcion");
		    
		    var codCiudadSeleccionada = document.getElementById("codCiudadSeleccionada").value;
		    if (codCiudadSeleccionada != "") {
			    var codCiudad = document.getElementById("codCiudad");
			    var encontrado = false;
			    for (index = 0; index< codCiudad.length; index++) {
			       	  if (codCiudad[index].value == codCiudadSeleccionada) {
			        	codCiudad.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codCiudadSeleccionada").value = ""
		    }
			fncObtenerCeldas();
	    }
	}
	
	function fncObtenerCeldas() {
		var codRegion = document.getElementById("codRegion");
		var codProvincia = document.getElementById("codProvincia");
		var codCiudad = document.getElementById("codCiudad");		
		if (codRegion.value!="" && codProvincia.value != "" && codCiudad.value != "") {
			JDatosLineaAJAX.obtenerCeldas(codRegion.value, codProvincia.value, codCiudad.value, fncResultadoObtenerCeldas);
		}
		else {
			DWRUtil.removeAllOptions("codCelda");
	    	DWRUtil.addOptions("codCelda",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});	
			document.getElementById("codTecnologia").value = "";	
			document.getElementById("codSubAlm").value = "";    
			fncLimpiarServiciosSuplementarios();
	    }
	}
	
	function fncResultadoObtenerCeldas(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codCelda");
		    DWRUtil.addOptions("codCelda",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCelda", listaActualizada, "codigoCelda", "descripcionCelda");
	
			listaCeldas = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++) {
				var celda = new Array(2);
				celda[0] = listaActualizada[indice]["codigoCelda"];
				celda[1] = listaActualizada[indice]["codSubAlm"];
				listaCeldas[indice] = celda;
			}
	
			var codCeldaSeleccionada = document.getElementById("codCeldaSeleccionada").value;
	
		    if (codCeldaSeleccionada != "") {
			    var codCelda = document.getElementById("codCelda");
			    var encontrado = false;
			    for (index = 0; index< codCelda.length; index++) {
			       	  if (codCelda[index].value == codCeldaSeleccionada) {
			        	codCelda.selectedIndex = index;
			        	encontrado = true;
	
			        	var codSubAlm = "";
						for (var indice=0; indice < listaCeldas.length; indice++) {
							if (listaCeldas[indice][0] == codCelda.value) {
								codSubAlm = listaCeldas[indice][1];
								document.getElementById("codSubAlm").value = codSubAlm;
								break;
							}
						}
			        	break;
			       	  } 
			    }
			    if (!encontrado) 
			    	document.getElementById("codCeldaSeleccionada").value = "";
		    }
			fncObtenerCentrales();
	    }
	}
	
	function fncObtenerCentrales() {
		//debug('fncObtenerCentrales()');
		var codCelda = document.getElementById("codCelda");
		var codPrestacion = document.getElementById("codTipoPrestacion");
		
		if (codCelda.value == "") 
			codCelda = document.getElementById("codCeldaSeleccionada"); 
		
		if (codPrestacion.value == "") 
			codPrestacion = document.getElementById("codTipoPrestacionSeleccionada"); 
		
		if (codCelda.value != "" && codPrestacion.value != "") {
			var codSubAlm = document.getElementById("codSubAlm").value
			if (codSubAlm != "") {
				JDatosLineaAJAX.obtenerCentrales(codSubAlm,codPrestacion.value, fncResultadoObtenerCentrales);
			}
		}
		else {
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});		    
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});  
			document.getElementById("codTecnologia").value = "";	  
			fncLimpiarServiciosSuplementarios();
	    }
	}
	
	function fncResultadoObtenerCentrales(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			listaCentrales = new Array();
			for (var indice = 0; indice < listaActualizada.length; indice++) {
			  	 var central = new Array(2);
			  	 central[0] = listaActualizada[indice]["codigoCentral"];
			  	 central[1] = listaActualizada[indice]["codigoTecnologia"];
			  	 listaCentrales[indice] = central;
			}
		 		
		    DWRUtil.removeAllOptions("codCentral");
		    DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCentral", listaActualizada, "codigoCentral","descripcionCentral");
	
			var codCentralSeleccionada = document.getElementById("codCentralSeleccionada").value;
		    if (codCentralSeleccionada != "") {
			    var codCentral = document.getElementById("codCentral");
			    var encontrado = false;
			    for (index = 0; index< codCentral.length; index++) {
			       	  if (codCentral[index].value == codCentralSeleccionada) {
			        	codCentral.selectedIndex = index;
			        	encontrado = true;
						for (var indice=0; indice < listaCentrales.length; indice++) {
							if (listaCentrales[indice][0] == codCentral.value) {
								document.getElementById("codTecnologia").value = listaCentrales[indice][1];
								break;
							}
						}
			        	break;
			       	  } 
			    }
			    if (!encontrado) 
			    	document.getElementById("codCentralSeleccionada").value = "";
		    }
		    obtenerPlanesServicio();
		    obtenerTiposTerminal();
	    }
	}

	function fncObtenerUsos() {
		var codTipoPrestacion = document.getElementById("codTipoPrestacion");
		if (codTipoPrestacion.value != "") {
			var codTipoRed = document.getElementById("tipoRed").value;
			var codTipoCliente = document.getElementById("codTipoCliente").value;
			if (codTipoRed != "" && codTipoCliente != null && codTipoCliente != "") {
				JDatosLineaAJAX.obtenerUsosXTipoCliente(codTipoRed, codTipoCliente, fncResultadoObtenerUsosXTipoCliente);
			}
		}
		else {
			DWRUtil.removeAllOptions("codUsoLinea");
	    	DWRUtil.addOptions("codUsoLinea",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});
	    	
	    	DWRUtil.removeAllOptions("codCampanaVigente");
	    	DWRUtil.addOptions("codCampanaVigente",{'':'- Seleccione -'});
	    	
			document.getElementById("filtroPlan").selectedIndex = 0;
			fncLimpiarServiciosSuplementarios();
	    }
	}
	
	function fncResultadoObtenerUsosXTipoCliente(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError = data['msgError']; 
	        if (codError != "") {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codUsoLinea");
		    DWRUtil.addOptions("codUsoLinea",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codUsoLinea", listaActualizada, "codUso", "desUso");
  	       
		    var codUsoLineaSeleccionado = document.getElementById("codUsoLineaSeleccionado").value;
		    if (codUsoLineaSeleccionado != "") {
			    var codUsoLinea = document.getElementById("codUsoLinea");
			    var encontrado = false;
			    for (index = 0; index< codUsoLinea.length; index++) {
			       	  if (codUsoLinea[index].value == codUsoLineaSeleccionado) {
			        	codUsoLinea.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado)
			    	document.getElementById("codUsoLineaSeleccionado").value = "";
		    }
			obtenerPlanesTarifarios();
			obtenerCausasDescuento();
			obtenerArticulos();
	    }
	}
		
	function obtenerPlanesTarifarios() {
		var codUsoLinea = document.getElementById("codUsoLinea");
		var codPrestacion = document.getElementById("codTipoPrestacion");
		var filtroPlan = document.getElementById("filtroPlan");
		if (codUsoLinea.value != "") {
			var indRenovacion = 0;
			if (document.getElementById("indRenovacion") != null) {
				indRenovacion = document.getElementById("indRenovacion").value;
			}
			JDatosLineaAJAX.obtenerPlanesTarifarios(codUsoLinea.value, codPrestacion.value, filtroPlan.value, indRenovacion, fncResultadoObtenerPlanesTarifarios);
		}
		else {
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});	
			document.getElementById("filtroPlan").selectedIndex = 0;
			fncLimpiarServiciosSuplementarios();
	    }
	}
		
	function fncResultadoObtenerPlanesTarifarios(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codPlanTarif");
		    DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codPlanTarif", listaActualizada, "codigoPlanTarifario", "descripcionPlanTarifario");
		    var codPlanTarifSeleccionado = document.getElementById("codPlanTarifSeleccionado").value;
		    listaPlanesTarifarios = listaActualizada;
		    if (codPlanTarifSeleccionado != "") {
			    var codPlanTarif = document.getElementById("codPlanTarif");
			    var encontrado = false;
			    for (index = 0; index < codPlanTarif.length; index++) {
			       	  if (codPlanTarif[index].value == codPlanTarifSeleccionado) {
			        	codPlanTarif.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) 
			    	document.getElementById("codPlanTarifSeleccionado").value = "";
		    }
		    obtenerPlanesServicio();
		    obtenerLimitesConsumo();
			mostrarOcultarFilaLC();
			activarDesactivarPA();
	    }
	}		
		
	function obtenerPlanesServicio() {
		var codPlanTarif = document.getElementById("codPlanTarif");
		var codCentral = document.getElementById("codCentral");	
		if (codPlanTarif != null && codPlanTarif.value != "" && codCentral != null && codCentral.value != "") {
			var codTecnologia = document.getElementById("codTecnologia");
			if (codTecnologia != null && codTecnologia.value != "") {
				JDatosLineaAJAX.obtenerPlanesServicio(codPlanTarif.value, codTecnologia.value, fncResultadoObtenerPlanesServicio);
			}
		}
		else {
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});		    	    	
	    }
	}
	
	function fncResultadoObtenerPlanesServicio(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codPlanServicio");
		    DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codPlanServicio", listaActualizada, "codigoPlanServicio", "descripcionPlanServicio");
			var codPlanServicioSeleccionado = document.getElementById("codPlanServicioSeleccionado").value;
		    if (codPlanServicioSeleccionado != "") {
			    var codPlanServicio = document.getElementById("codPlanServicio");
			    var encontrado = false;
			    for (index = 0; index < codPlanServicio.length; index++) {
			       	if (codPlanServicio[index].value == codPlanServicioSeleccionado) {
			        	codPlanServicio.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	} 
			    }
			    if (!encontrado) 
			    	document.getElementById("codPlanServicioSeleccionado").value = "";
		    }
	    }
		//debug('fncResultadoObtenerPlanesServicio(data), fin');
	}
	
	function obtenerTiposTerminal() {
		//debug('obtenerTiposTerminal(), inicio');
		var codCentral = document.getElementById("codCentral");
		if (codCentral.value != "") {
			var codTecnologia = document.getElementById("codTecnologia").value;			
			if (codTecnologia!="") {
				JDatosLineaAJAX.obtenerTiposTerminal(codTecnologia, fncResultadoObtenerTiposTerminal);
			}
		}
		else {
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});	
	    }
		//debug('obtenerTiposTerminal(), fin');
	}
		
	function fncResultadoObtenerTiposTerminal(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
 		
		    DWRUtil.removeAllOptions("codTipoTerminal");
		    DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codTipoTerminal", listaActualizada, "tipTerminal", "desTerminal");

			var codTipoTerminalSeleccionado = document.getElementById("codTipoTerminalSeleccionado").value;
		    if (codTipoTerminalSeleccionado != "") {
			    var codTipoTerminal = document.getElementById("codTipoTerminal");
			    var encontrado = false;
			    for (index = 0; index< codTipoTerminal.length; index++) {
			       	  if (codTipoTerminal[index].value == codTipoTerminalSeleccionado) {
			        	codTipoTerminal.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codTipoTerminalSeleccionado").value = ""
		    }
		    obtenerArticulos();
	    }
	}					
		
	function fncValidarPlanCompartido(codPlanTarif) {
		if (codPlanTarif.value != "") {
			ejecutandoAjax = true;
			var codCliente = document.getElementById("codCliente");
			JDatosLineaAJAX.validarPlanCompartidoXCodPlanTarifYCodCliente(codPlanTarif.value, codCliente.value, fncResultadoValidarPlanCompartido);
		}
	}

	function fncResultadoValidarPlanCompartido(data) {
		if (data != null) {
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				var mensajeError =  data['msgError']; 
				if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		
				var codPlanTarif = document.getElementById("codPlanTarif").value;
	        	//mensajeError = "Cliente Ha sobrepasado la cantidad de abonados permitida por el plan " + codPlanTarif;
	        	mostrarMensajeError(mensajeError);
				document.getElementById("codPlanTarifSeleccionado").value = "";
				document.getElementById("codPlanTarif").value="";
				document.getElementById("codPlanTarif").focus();
			}
		}
		ejecutandoAjax = false;
	}
		
	function fncObtieneVigenciaSeguro(codSeguro) {
		var codPeriodo = document.getElementById("codPeriodo");
		if (codSeguro.value != "" && codSeguro.value != null && codPeriodo.value != "" && codPeriodo.value != null) {
			ejecutandoAjax = true;
			JDatosLineaAJAX.obtenerFechaVigenciaSeguroXPeriodo(codSeguro.value, codPeriodo.value, fncResultadoObtenerFechaVigenciaSeguroXPeriodo);
		}
		else {
			document.getElementById("vigenciaSeguro").value = "";
		}
	}

	function fncResultadoObtenerFechaVigenciaSeguroXPeriodo(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
				if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			document.getElementById("vigenciaSeguro").value = data["resultado"];
	    }
	    ejecutandoAjax = false;
	}	

 	function fncSeleccionaTiposPrestacion(codTipoPrestacion) {
		document.getElementById("codTipoPrestacionSeleccionada").value = codTipoPrestacion.value;
		if (codTipoPrestacion.value != "") {
			var tipoRed = "";
			var indNumero = "";
			var indDirInstalacion = "";
			var indInvFijo = "";	
			var indSS = "";					
			var indNumeroPiloto = "";
			for (var indice=0; indice < listaTiposPrestacion.length; indice++) {
				if (listaTiposPrestacion[indice][0] == codTipoPrestacion.value) {
					tipoRed = listaTiposPrestacion[indice][1];
					indNumero = listaTiposPrestacion[indice][2];
					indDirInstalacion = listaTiposPrestacion[indice][3];
					indInvFijo = listaTiposPrestacion[indice][4];
					indSS = listaTiposPrestacion[indice][5];				
					indNumeroPiloto = listaTiposPrestacion[indice][6];					
				}
			}
			document.getElementById("tipoRed").value = tipoRed;
			document.getElementById("indNumero").value = indNumero;
			//document.getElementById("indDirInstalacion").value = indDirInstalacion;
			document.getElementById("indInvFijo").value = indInvFijo;	
			document.getElementById("indSS").value = indSS;	
			document.getElementById("indNumeroPiloto").value = indNumeroPiloto;	

			var codGrpPrestacion = document.getElementById("codGrpPrestacion");	
			if(codGrpPrestacion == "SMS") {	
				document.getElementById("indNumeroCortoSMS").value = "1";			
			}
		}
		else {
			document.getElementById("tipoRed").value = "";
			document.getElementById("indNumero").value = "";
			//document.getElementById("indDirInstalacion").value = "";
			document.getElementById("indInvFijo").value = "";	
			document.getElementById("indSS").value = "";
			document.getElementById("indNumeroPiloto").value = "";	
			document.getElementById("indNumeroCortoSMS").value = "";	
		}
		fncConfigPantallaSegunTipoPrestacion();
	}
	
	function obtenerCausasDescuento() {
		//debug("obtenerCausasDescuento(), inicio");
		var codUsoLinea = document.getElementById("codUsoLinea");
		if (codUsoLinea.value != "") {
			JDatosLineaAJAX.obtenerCausalDescuento(codUsoLinea.value, fncResultadoObtenerCausasDescuento);
		}
		else {
			DWRUtil.removeAllOptions("codCausaDescuento");
	    	DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});		
	    }
	}
	
	function hasValue(o) {
		if (o == null) {
			return false;
		}
		if (o.value == null) {
			return false;
		}
		if (o.value == "") {
			return false;
		}
		//debug("hasValue [" + o.value + "]");
		return true;
	}
	
	function obtenerLimitesConsumo() {
		//debug("obtenerLimitesConsumo(), inicio");
		var codPlanTarif = document.getElementById("codPlanTarif");
		var codCliente = document.getElementById("codCliente");
		
		if (hasValue(codPlanTarif) && hasValue(codCliente)) {
			//debug("obtenerLimitesConsumo(), if");
			//debug("codPlanTarif.value [" + codPlanTarif.value + "]");
			//debug("codCliente.value [" + codCliente.value + "]");
			//debug("JDatosLineaAJAX.obtenerLimitesConsumoXPlanTarifYCodCliente...");
			JDatosLineaAJAX.obtenerLimitesConsumoXPlanTarifYCodCliente(codPlanTarif.value, codCliente.value, fncResultadoObtenerLimitesConsumo);
		}
		else {
			//debug("obtenerLimitesConsumo(), else");
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo", {"":"- Seleccione -"});
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML = "";
	    }
	    //debug("obtenerLimitesConsumo(), fin");
	}
	
	function fncResultadoObtenerLimitesConsumo(data){
		//debug("fncResultadoObtenerLimitesConsumo(data)");
		if (data != null) {
	        var codError = data["codError"]; 
	        var mensajeError =  data["msgError"]; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			listaLimiteConsumo = new Array();
			for (var indice = 0; indice < listaActualizada.length; indice++) {
				  	 var limiteConsumo = new Array(5);
				  	 limiteConsumo[0] = listaActualizada[indice]["codigoLimiteConsumo"];
				  	 limiteConsumo[1] = listaActualizada[indice]["montoMinimo"];
				  	 limiteConsumo[2] = listaActualizada[indice]["montoMaximo"];
				  	 limiteConsumo[3] = listaActualizada[indice]["flgCorte"];
				  	 limiteConsumo[4] = listaActualizada[indice]["montoCons"];
				  	 listaLimiteConsumo[indice] = limiteConsumo;
			}
			
		    DWRUtil.removeAllOptions("codLimiteConsumo");
		    DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codLimiteConsumo",listaActualizada,"codigoLimiteConsumo","descripcionLimiteConsumo");
		    
		    var codLimiteConsumoSeleccionado = document.getElementById("codLimiteConsumoSeleccionado").value;
		    if (codLimiteConsumoSeleccionado != "") {
			    var codLimiteConsumo = document.getElementById("codLimiteConsumo");
			    var encontrado = false;
			    for (index = 0; index < codLimiteConsumo.length; index++) {
			       	  if (codLimiteConsumo[index].value == codLimiteConsumoSeleccionado){
			        	codLimiteConsumo.selectedIndex = index;
			        	encontrado = true;
						for (var indice=0; indice < listaLimiteConsumo.length; indice++) {
							if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value){
								document.getElementById("montoMinimo").value = listaLimiteConsumo[indice][1];
								document.getElementById("montoMaximo").value = listaLimiteConsumo[indice][2];
								document.getElementById("flgCorte").value = listaLimiteConsumo[indice][3];
								document.getElementById("montoCons").value = listaLimiteConsumo[indice][4];	
								break;
							}
						}
			        	break;
					} 
			    }
			    if (!encontrado) {
			    	document.getElementById("codLimiteConsumoSeleccionado").value = "";			    
					document.getElementById("montoMinimo").value = 0;
					document.getElementById("montoMaximo").value = 0;
					document.getElementById("flgCorte").value = "";
					document.getElementById("montoCons").value = 0;
					document.getElementById("montoLimiteConsumo").value = 0;
					document.getElementById("lbMontoLimiteConsumo").innerHTML = "";
			    }
		    }
	    }
	}
	
	function fncResultadoObtenerCausasDescuento(data) {
		var listaActualizada = procesarDataAJAX(data);
		actualizarCombo("codCausaDescuento", listaActualizada, "codigoCausalDescuento", "descripcionCausalDescuento", "codCausaDescuentoSeleccionada");		    
	}
	
	function obtenerArticulos() {
		//debug("obtenerArticulos(), inicio");
		var codUsoLinea = document.getElementById("codUsoLinea");
		var codTecnologia = document.getElementById("codTecnologia");	
		var codTipoTerminal = document.getElementById("codTipoTerminal");	
		var indEquipo = document.getElementById("indEquipo");	
		
		if (codUsoLinea.value != "" && codTecnologia.value != "" && codTipoTerminal.value != "" && indEquipo.value != "") {
			
			//debug("codUsoLinea [" + codUsoLinea.value + "]");
			//debug("codTecnologia [" + codTecnologia.value + "]");
			//debug("codTipoTerminal [" + codTipoTerminal.value + "]");
			//debug("indEquipo [" + indEquipo.value + "]");
			
			JDatosLineaAJAX.obtenerArticulos(codTecnologia.value, codUsoLinea.value, codTipoTerminal.value, indEquipo.value, fncResultadoObtenerArticulos);
		}
		else {
			DWRUtil.removeAllOptions("codArticuloEquipo");
	    	DWRUtil.addOptions("codArticuloEquipo",{'':'- Seleccione -'});		    	    	
	    }
		//debug('obtenerArticulos(), fin');
	}
	
	function fncResultadoObtenerArticulos(data) {
		var listaActualizada = procesarDataAJAX(data);
		actualizarCombo("codArticuloEquipo", listaActualizada, "codArticulo", "desArticulo", "codArticuloEquipoSeleccionado");		    
	}
	
	function fncSeleccionaProvincia(codProvincia) {
		document.getElementById("codProvinciaSeleccionada").value = codProvincia.value;
	}
	
	function fncSeleccionaCiudad(codCiudad) {
		document.getElementById("codCiudadSeleccionada").value = codCiudad.value;
	}
		
	function fncSeleccionaCelda(codCelda) {
		document.getElementById("codCeldaSeleccionada").value = codCelda.value;
		if (codCelda.value != "") {
			var codSubAlm = "";
			for (var indice=0; indice < listaCeldas.length; indice++) {
				if (listaCeldas[indice][0] == codCelda.value) {
					codSubAlm = listaCeldas[indice][1];
					break;
				}
			}
			document.getElementById("codSubAlm").value = codSubAlm;
		}
		else {
			document.getElementById("codSubAlm").value = "";
		}
	}	
	
	function fncSeleccionaCentral(codCentral) {
		document.getElementById("codCentralSeleccionada").value = codCentral.value;
		if (codCentral.value != "") {
			var codTecnologia = "";
			for (var indice=0; indice < listaCentrales.length; indice++) {
				if (listaCentrales[indice][0] == codCentral.value) {
					codTecnologia = listaCentrales[indice][1];
					break;
				}
			}
			document.getElementById("codTecnologia").value = codTecnologia;
		}
		else {
			document.getElementById("codTecnologia").value = "";
		}
		fncLimpiarServiciosSuplementarios();	
		fncConfigPantallaSegunTipoPrestacion();
	}
	
	function fncSeleccionaUso(codUso) {
		document.getElementById("codUsoLineaSeleccionado").value = codUso.value;
		obtenerPlanesTarifarios();
		obtenerCausasDescuento();
		obtenerArticulos();
		mostrarOcultarFilaLC();
	}
			
	function fncSeleccionaPlanTarif(codPlanTarif) {
		document.getElementById("codPlanTarifSeleccionado").value = codPlanTarif.value;
		fncValidarPlanCompartido(codPlanTarif);		
		fncLimpiarServiciosSuplementarios();
		mostrarOcultarFilaLC();
	}
	
	function codGrpPrestacion_onchange() {
		ocultarMensajeError();
		fncActivarDesacControlesGrupoPrestacion();
		mostrarOcultarFilaLC();
	}

	function fncSeleccionaPlanServicio(codPlanServicio) {
		document.getElementById("codPlanServicioSeleccionado").value = codPlanServicio.value;
	}		
	
	function fncSeleccionaTipoTerminal(codTipoTerminal) {
		document.getElementById("codTipoTerminalSeleccionado").value = codTipoTerminal.value;
		obtenerArticulos();
	}
	
	function codArticuloEquipo_onchange(o) {
		document.getElementById("codArticuloEquipoSeleccionado").value = o.value;
	}		

	function fncConfigPantallaSegunTipoPrestacion() {
		var codTelefoniaMovil = document.getElementById("codTelefoniaMovil").value;
		var codTelefoniaFija = document.getElementById("codTelefoniaFija").value;	
		var codInternet = document.getElementById("codInternet").value;	
		var codCarrier = document.getElementById("codCarrier").value;	
		var codGrpPrestacion = document.getElementById("codGrpPrestacion").value;	
		var indInvFijo = document.getElementById("indInvFijo").value;
		var indSS = document.getElementById("indSS").value;
		var indNumeroPiloto = document.getElementById("indNumeroPiloto").value;
		var codTecnologia = document.getElementById("codTecnologia").value;
		if (indSS == "1") {
			document.getElementById("divSS").style["display"] = "";
		}
		else {
			document.getElementById("divSS").style["display"] = "none";				
		}
		activarDesactivarPA();
	}

	function fncServiciosSupl() {
	 	if (ejecutandoAjax) 
	 		return;
		if (fncVerificaParametrosSS()) {
			document.getElementById("opcion").value = "serviciosSupl";
	    	document.forms[0].submit();
	    }
	}	
	 
	function fncVerificaParametrosSS() {
		var codTecnologia = document.getElementById("codTecnologia");
	 	var codPlanTarif = document.getElementById("codPlanTarif");
		if (codTecnologia.value == "") {
			alert("Debe Seleccionar Central");
			return false;
		}		
		if (codPlanTarif.value == "") {
			alert("Debe Seleccionar Plan Tarifario");
			return false;
		}
		return true;
	}

	function fncLimpiarServiciosSuplementarios() {
		JDatosLineaAJAX.limpiarServiciosSuplementarios(fncResultadolimpiarServiciosSuplementarios);
	}
	
	function fncResultadolimpiarServiciosSuplementarios(data) {
		if (data != null) {
			var resultado = data['resultado'];
			if (resultado == "1") {//existia lista de SS en sesion
				//alert("Se ha actualizado lista de servicios suplementarios");
			}
	    }
	}
	
	function fncValidaCampos() {
		if (document.getElementById("codGrpPrestacion").value == "") {
	  	   alert ("Debe seleccionar Grupo Prestaci\u00F3n");
	  	   return false;
		}
		if (document.getElementById("codTipoPrestacion").value == "") {
	  	   alert ("Debe seleccionar Tipo Prestaci\u00F3n");
	  	   return false;
		}
		if (document.getElementById("codRegion").value == "") {
	  	   alert ("Debe seleccionar Departamento");
	  	   return false;
		}
		if (document.getElementById("codProvincia").value == "") {
	  	   alert ("Debe seleccionar Municipio");
	  	   return false;
		}
		if (document.getElementById("codCelda").value == "") {
	  	   alert ("Debe seleccionar Celda");
	  	   return false;
		}
		if (document.getElementById("codCentral").value == "") {
	  	   alert ("Debe seleccionar Central");
	  	   return false;
		}
		if (document.getElementById("codUsoLinea").value == "") {
	  	   alert ("Debe seleccionar Uso de la L\u00EDnea");
	  	   return false;
		}
		if (document.getElementById("codPlanTarif").value == "") {
	  	   alert ("Debe seleccionar Plan Tarifario");
	  	   return false;
		}
		
		var codLimiteConsumo = document.getElementById("codLimiteConsumo");
		
		if (LCMandatorio() && codLimiteConsumo.value == "") {
	  	   	alert("Debe seleccionar L\u00EDmite de Consumo");
	  	   	return false;
		}
		
		if (document.getElementById("codPlanServicio").value == "") {
	  	   alert ("Debe seleccionar Plan de Servicio");
	  	   return false;
		}	
		if (document.getElementById("codTipoTerminal").value == "") {
	  	   alert ("Debe seleccionar Tipo Terminal");
	  	   return false;
		}	
		return true;
	}
	
	function fncAgregarLinea() {
	 	if (fncValidaCampos()) {
		 	document.getElementById("btnAgregar").disabled = true;
	 	  	document.getElementById("opcion").value = "agregarLinea";
	    	document.forms[0].submit();
	    }
	}
	
	function validarCamposCliente() {
		return true;
	}

	function fncFinalizarSolicitud() {
		desactivarBotones();
		if (validarCamposCliente()) {
			var msgConfirm = "SCORING DE CLIENTE\n - Para realizar la Solicitud, seleccione 'Aceptar'.\n - Para permanecer en esta página, seleccione 'Cancelar'.";
			if (confirm(msgConfirm)) {
				activarBotones();
				document.getElementById("opcion").value = "finalizarSolicitud";
		   		document.forms[0].submit();
		   	}
		   	else {
	   			activarBotones();
	   		}
	   	}
	   	else {
	   		activarBotones();
	   	}
	}
	
	function activarBotones() {
		activarDesactivarBotones(false);
	}
	
	function desactivarBotones() {
		activarDesactivarBotones(true);
	}
	
	function activarDesactivarBotones (b) {
		document.getElementById("btnCancelar").disabled = b;
		document.getElementById("btnAnterior").disabled = b;
		document.getElementById("btnAgregar").disabled = b;
		var btnFinalizar = document.getElementById("btnFinalizar");
		if (btnFinalizar != null) {
			btnFinalizar.disabled = b;
		}
	}
	
	function fncCancelar(o) {
		desactivarBotones();
		if (confirm("¿Está seguro que desea cancelar la solicitud de scoring pendiente?")) {
			activarBotones();
			document.getElementById("opcion").value = "cancelarSolicitud";
			document.forms[0].submit();
		}
		else {
			activarBotones();
		}
	}
	
	function fncAnterior() {
		var flgActivarBtnFinalizar = document.getElementById("flgActivarBtnFinalizar");
			if (flgActivarBtnFinalizar.value == "1") {
			var msgConfirm = "Se eliminar\u00E1 la informaci\u00F3n asociada a esta solicitud. ¿Desea Continuar?";
			if (!confirm(msgConfirm)) {
				return false;
			}
		}
		else {
			fncLimpiarServiciosSuplementarios();
		}
		document.getElementById("opcion").value = "anterior";
	   	document.forms[0].submit();
	}
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}
	
	function fncSeleccionaCausaDescuento(codCausaDescuento){
		document.getElementById("codCausaDescuentoSeleccionada").value = codCausaDescuento.value;
	}
	
	function LCMandatorio() {
		if (grpPrestacionesLCMandatorio() == false) {
			return false;
		}
		else if (tiposPlanTarifarioLCMandatorio() == false) {
			return false;
		}
		return true;
	}
	
	function grpPrestacionesLCMandatorio() {
		var codGrpPrestacion = document.getElementById("codGrpPrestacion").value;
		if (codGrpPrestacion == "")	{
			return false;
		}
		var arr = getArrayGrpPrestacionesSinLC();
		for (var i = 0; i < arr.length; i++) {
			if (codGrpPrestacion == arr[i]) {
				return false;
			}
		}
		return true;
	}
	
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}	  
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function tiposPlanTarifarioLCMandatorio() {
		var codPlanTarifario = document.getElementById("codPlanTarif").value;
		if (codPlanTarifario == "") {
			return false;
		}
		var arr = getArrayTiposPlanTarifariosSinLC();
		for (var i = 0; i < listaPlanesTarifarios.length; i++) {
	    	var cod = listaPlanesTarifarios[i]["codigoPlanTarifario"];
	    	var tipoProducto = parseInt(listaPlanesTarifarios[i]["tipoProducto"]);
	    	if (codPlanTarifario == cod) {
	    		for (var j = 0; j < arr.length; j++) {
					if (tipoProducto == parseInt(arr[j])) {
						return false;
					}
				}
    			break;
	    	}
	    }
		return true;
	}
	
	function fncValidaMontoDecimal(campoTexto) {
  		if (campoTexto.value != "") {
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)){
	  	  		alert("Monto inv\u00E1lido");
	  	  		campoTexto.value="";
	  	  		campoTexto.focus();
	  	  	}
		}
	}
	
	function fncSeleccionaLimiteConsumo(codLimiteConsumo) {
		document.getElementById("codLimiteConsumoSeleccionado").value = codLimiteConsumo.value;
		if (codLimiteConsumo.value != "") {
			for (var indice=0; indice < listaLimiteConsumo.length; indice++) {
				if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value) {
					document.getElementById("montoMinimo").value = listaLimiteConsumo[indice][1];
					document.getElementById("montoMaximo").value = listaLimiteConsumo[indice][2];
					document.getElementById("flgCorte").value = listaLimiteConsumo[indice][3];
					document.getElementById("montoCons").value = listaLimiteConsumo[indice][4];
					document.getElementById("montoLimiteConsumo").value = listaLimiteConsumo[indice][4];
					var lbCorte = "";
					if (document.getElementById("flgCorte").value == 1) {
						lbCorte = "Con Corte";
					}
					else if (document.getElementById("flgCorte").value == 0) {
						lbCorte = "Sin Corte";
					}
					document.getElementById("lbMontoLimiteConsumo").innerHTML = lbCorte;
					break;
				}
			}
			var min = document.getElementById("montoMinimo").value;
			var max = document.getElementById("montoMaximo").value;			
		}
		else {
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML = "";
		}
	}
	
	function fncValidaRangoLimite(campoMontoLimiteConsumo) {
		var montoMinimo = parseFloat(document.getElementById("montoMinimo").value);
		var montoMaximo = parseFloat(document.getElementById("montoMaximo").value);
		var montoLimiteIngresado = parseFloat(campoMontoLimiteConsumo.value);
		if (montoLimiteIngresado < montoMinimo || montoLimiteIngresado > montoMaximo) {
			alert("L\u00EDmite de Consumo fuera de rango");
			campoMontoLimiteConsumo.value = 0;
		}
	}
	
	function mostrarOcultarFilaLC() {
		if (document.getElementById("filaLC") == null) {
			return;
		}
		if (LCMandatorio() == true) {
			document.getElementById("filaLC").style["display"] = "";
		}
		else {
			document.getElementById("filaLC").style["display"] = "none";
		}
	}
	
	function body_onload() {
		fncInicio();
	}
	
	function irAPlanesAdicionales() {
		document.getElementById("opcion").value = "irAPlanesAdicionales";
	    document.forms[0].submit();
	}
	
	function getListadoCampaniasVigentesXCodUso() {
		var nombreCombo = "codCampanaVigente";
		var codUsoLinea = document.getElementById("codUsoLinea");
		if (codUsoLinea.value != "") {
			JDatosLineaAJAX.getListadoCampaniasVigentesXCodUso(codUsoLinea.value, fncResultadoGetListadoCampaniasVigentesXCodUso);
		}
		else {
			DWRUtil.removeAllOptions(nombreCombo);
	    	DWRUtil.addOptions(nombreCombo, {"":"- Seleccione -"});		
	    }
	}
	
	function fncResultadoGetListadoCampaniasVigentesXCodUso(data) {
		var nombreCombo = "codCampanaVigente";
		if (data != null) {
	        var codError = data["codError"]; 
	        var mensajeError = data["msgError"]; 
	        if (codError != "") {
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codCampanaVigente");
		    DWRUtil.addOptions("codCampanaVigente", {"":"- Seleccione -"});
		    DWRUtil.addOptions("codCampanaVigente", listaActualizada, "codigoCampanasVigentes", "descripcionCampanasVigentes");
		    
		    var sel = document.getElementById("codCampanaVigenteSeleccionada").value;
		   
		    if (sel != "" ) {
			    var combo = document.getElementById(nombreCombo);
			    var encontrado = false;
			    for (var index = 0; index < combo.length; index++) {
			       	  if (combo[index].value == sel){
			        	combo.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) {
			    	document.getElementById("codCampanaVigenteSeleccionada").value = "";
			    }
		    }
	    }
	}
	
	function codUsoLinea_onchange(o) {
		/*Original*/
		fncSeleccionaUso(o);
		activarDesactivarPA();
		limpiarPAScoring();
		
		/*Nuevo*/
		ocultarMensajeError();
		//fncSeleccionaUso(o);
		//obtenerPlanesTarifarios();
		obtenerCausasDescuento();
		mostrarOcultarFilaLC();
		getListadoCampaniasVigentesXCodUso();
	}
	
	function codCampanaVigente_onchange(o) {
		ocultarMensajeError();
		document.getElementById("codCampanaVigenteSeleccionada").value = o.value;
	}
	
	function codTipoPrestacion_onchange(o) {
		fncSeleccionaTiposPrestacion(o);
		fncObtenerUsos();
		fncObtenerCentrales();
		activarDesactivarPA();
		limpiarPAScoring();
	}
	
	function codPlanTarif_onchange(o) {
		fncSeleccionaPlanTarif(o);
		obtenerPlanesServicio();
		obtenerLimitesConsumo();
		activarDesactivarPA();
		limpiarPAScoring();
	}
	
	function limpiarPAScoring() {
		JDatosLineaAJAX.limpiarPAScoring(resultadoLimpiarPAScoring);
	}
	
	function resultadoLimpiarPAScoring(data) {
		if (data != null) {
			
	    }
	}
	
	function activarDesactivarPA () {
		var divPA = document.getElementById("divPA");
		var codTipoPrestacion = document.getElementById("codTipoPrestacion");
		var codPlanTarif = document.getElementById("codPlanTarif");
		if (divPA == null || codTipoPrestacion == null || codPlanTarif == null) {
			return;
		}
		divPA.style["display"] = codTipoPrestacion.value != "" && codPlanTarif.value != "" ? "" : "none";
	}
	
</script>
<style type="text/css">
.comboDatosLinea
{
	font-size: 10px;
	width: 92%;
}
</style>
</head>
</head>
<body onload="body_onload()" onpaste="return false;" onkeydown="validarTeclas()">
<html:form method="POST" action="/DatosLineaScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codProcedencia" styleId="codProcedencia"/>
	<html:hidden property="codTipoPrestacionSeleccionada" styleId="codTipoPrestacionSeleccionada"/>
	<html:hidden property="codProvinciaSeleccionada" styleId="codProvinciaSeleccionada"/>
	<html:hidden property="codCiudadSeleccionada" styleId="codCiudadSeleccionada"/>
	<html:hidden property="codCeldaSeleccionada" styleId="codCeldaSeleccionada"/>
	<html:hidden property="codCentralSeleccionada" styleId="codCentralSeleccionada"/>
	<html:hidden property="codSubAlm" styleId="codSubAlm"/>
	<html:hidden property="codUsoLineaSeleccionado" styleId="codUsoLineaSeleccionado"/>
	<html:hidden property="codPlanTarifSeleccionado" styleId="codPlanTarifSeleccionado"/>
	<html:hidden property="codPlanServicioSeleccionado" styleId="codPlanServicioSeleccionado"/>
	<html:hidden property="codTipoTerminalSeleccionado" styleId="codTipoTerminalSeleccionado"/>
	<html:hidden property="codCausaDescuentoSeleccionada" styleId="codCausaDescuentoSeleccionada"/>
	<html:hidden property="codLimiteConsumoSeleccionado" styleId="codLimiteConsumoSeleccionado"/>
	<html:hidden property="codCampanaVigenteSeleccionada" styleId="codCampanaVigenteSeleccionada"/>
	<html:hidden property="codTecnologia" styleId="codTecnologia"/>
	<html:hidden property="glsArticuloEquipo" styleId="glsArticuloEquipo"/>
	<html:hidden property="flgAplicaSeguro" styleId="flgAplicaSeguro"/>
	<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
	<html:hidden property="codCentralDefault" styleId="codCentralDefault"/>
	<html:hidden property="tipoRed" styleId="tipoRed"/>
	<html:hidden property="indNumero" styleId="indNumero"/>
	<html:hidden property="indDirInstalacion" styleId="indDirInstalacion"/>
	<html:hidden property="indInvFijo" styleId="indInvFijo"/>
	<html:hidden property="indSS" styleId="indSS"/>
	<html:hidden property="indNumeroPiloto" styleId="indNumeroPiloto"/>
	<html:hidden property="indNumeroCortoSMS" styleId="indNumeroCortoSMS"/>
	<html:hidden property="codTelefoniaMovil" styleId="codTelefoniaMovil"/>
	<html:hidden property="codTelefoniaFija" styleId="codTelefoniaFija"/>
	<html:hidden property="codInternet" styleId="codInternet"/>
	<html:hidden property="codCarrier" styleId="codCarrier"/>
	<html:hidden property="procedenciaNumero" styleId="procedenciaNumero"/>
	<html:hidden property="codGrupoCobroServ" styleId="codGrupoCobroServ"/>
	<html:hidden property="codCreditoConsumo" styleId="codCreditoConsumo"/>
	<html:hidden property="codPeriodo" styleId="codPeriodo"/>
	<html:hidden property="flgActivarBtnFinalizar" styleId="flgActivarBtnFinalizar"/>
	<html:hidden property="indEquipo" styleId="indEquipo"/>
	<html:hidden property="codArticuloEquipoSeleccionado" styleId="codArticuloEquipoSeleccionado"/>
	<html:hidden property="grpPrestacionesSinLC" styleId="grpPrestacionesSinLC"/>
	<html:hidden property="tiposPlanTarifarioSinLC" styleId="tiposPlanTarifarioSinLC"/>
	<html:hidden property="montoMinimo" styleId=""/>
	<html:hidden property="montoMaximo" styleId="montoMinimo"/>
	<html:hidden property="flgCorte" styleId="flgCorte"/>
	<html:hidden property="montoCons" styleId="montoCons"/>
	<html:hidden property="indVtaExterna" styleId="indVtaExterna"/>
	<html:hidden name="DatosLineaScoringForm" property="codCliente" styleId="codCliente"/>
	<html:hidden name="DatosLineaScoringForm" property="codTipoDocumento" styleId="codTipoDocumento"/>
	<html:hidden name="DatosLineaScoringForm" property="codEstadoCivil" styleId="codEstadoCivil"/>
	<html:hidden name="DatosLineaScoringForm" property="codNacionalidad" styleId="codNacionalidad"/>
	<html:hidden name="DatosLineaScoringForm" property="codNivelAcademico" styleId="codNivelAcademico"/>
	<html:hidden name="DatosLineaScoringForm" property="codTipoEmpresa" styleId="codTipoEmpresa"/>
	<html:hidden name="DatosLineaScoringForm" property="codTipoTarjeta" styleId="codTipoTarjeta"/>
	<html:hidden name="DatosLineaScoringForm" property="documento" styleId="documento"/>
	<html:hidden name="DatosLineaScoringForm" property="antiguedad_laboral" styleId="antiguedad_laboral" />
	<html:hidden name="DatosLineaScoringForm" property="nit" styleId="nit"/>
	<html:hidden name="DatosLineaScoringForm" property="aplicaTarjeta" styleId="aplicaTarjeta" />
	<html:hidden name="DatosLineaScoringForm" property="numSolScoring" styleId="numSolScoring"/>
	<table>
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left" alt="">Solicitud Scoring N° <bean:write
				name="DatosLineaScoringForm" property="numSolScoring" /> - <bean:write
				name="DatosLineaScoringForm" property="desEstadoActual" />
			</td>
		</tr>
	</table>
	<br />
	<div id="wrapper">
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="mensajeError">
				<bean:write name="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
	</table>
	<br />
	<table>
		<tr>
			<td align="left" colspan="4">
			<h3>Datos del Cliente:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">NIT:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="nit" /></td>
			<td class="col1"><bean:write name="DatosLineaScoringForm" property="desTipoDocumento" />:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="documento" /></td>
		</tr>
		<tr>
			<td class="col1">Nombre Cliente:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="nombreCompleto" /></td>
			<td class="col1">Código de Cliente:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="codCliente" /></td>
		</tr>
		<tr>
			<td class="col1">Fecha Nacimiento:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="fecha_nacimiento"
				format="dd-MM-yyyy" /></td>
			<td class="col1">Nacionalidad:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="desNacionalidad" /></td>
		</tr>
		<tr>
			<td class="col1">Estado Civil:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="desEstadoCivil" /></td>
			<td class="col1">Nivel Académico:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="desNivelAcademico" /></td>
		</tr>
		<tr>
			<td class="col1">Tipo Empresa:</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="desTipoEmpresa" /></td>
			<td class="col1">Antigüedad Laboral (Años):</td>
			<td class="col2"><bean:write name="DatosLineaScoringForm" property="antiguedad_laboral" /></td>
		</tr>
	</table>
	<logic:equal name="DatosLineaScoringForm" property="aplicaTarjeta" value="SI">
		<table>
			<tr>
				<td class="col1">Tipo Tarjeta:</td>
				<td class="col2"><bean:write name="DatosLineaScoringForm" property="desTipoTarjeta" /></td>
				<td class="col1">N° Tarjeta:</td>
				<td class="col2"><bean:write name="DatosLineaScoringForm" property="numTarjeta" /></td>
			</tr>
		</table>
	</logic:equal>
	<table>
		<tr>
			<td colspan="4">
			<hr />
			</td>
		</tr>
		<tr>
			<td align="left" colspan="4">
			<h3>Home de L&iacute;nea (<font style="color: #78B454; font-weight: bold; text-align: left;">Líneas:
			<bean:write name="DatosLineaScoringForm" property="cantidadLineas" /></font>)</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">Grupo Prestaci&oacute;n (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codGrpPrestacion" styleId="codGrpPrestacion"
				onchange="codGrpPrestacion_onchange()">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosLineaScoringForm" property="arrayGrpPrestacion">
					<html:optionsCollection property="arrayGrpPrestacion" value="codGrupoPrestacion"
						label="desGrupoPrestacion" />
				</logic:notEmpty>
			</html:select></td>
			<td class="col1">Tipo Prestaci&oacute;n (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codTipoPrestacion" styleId="codTipoPrestacion"
				onchange="codTipoPrestacion_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
		</tr>
	</table>
	<bean:define id="aplicaRenovacion" name="DatosLineaScoringForm" type="java.lang.String"
		property="aplicaRenovacion" /> <logic:equal value="1" name="aplicaRenovacion">
		<table>
			<tr>
				<td class="col1">Renovaci&oacute;n:</td>
				<td class="col2"><html:select name="DatosLineaScoringForm" property="indRenovacion" styleId="indRenovacion"
					onchange="obtenerPlanesTarifarios();">
					<html:option value="">- Seleccione -</html:option>
					<html:option value="1">SI</html:option>
					<html:option value="0">NO</html:option>
				</html:select></td>
				<td class="col1"></td>
				<td class="col2"></td>
			</tr>
		</table>
	</logic:equal>
	<table>
		<tr>
			<td class="col1">Departamento (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codRegion" styleId="codRegion"
				onchange="fncObtenerProvincia();">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosLineaScoringForm" property="arrayRegiones">
					<html:optionsCollection property="arrayRegiones" value="codigo" label="descripcion" />
				</logic:notEmpty>
			</html:select></td>
			<td class="col1">Municipio (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codProvincia" styleId="codProvincia"
				onchange="fncSeleccionaProvincia(this);fncObtenerCiudad();">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
		</tr>
		<tr>
			<td class="col1">Zona (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codCiudad" styleId="codCiudad"
				onchange="fncSeleccionaCiudad(this);fncObtenerCeldas()">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td class="col1">Celda (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codCelda" styleId="codCelda"
				onchange="fncSeleccionaCelda(this);fncObtenerCentrales();">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
		</tr>
		<tr>
			<td class="col1">Central (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codCentral" styleId="codCentral"
				onchange="fncSeleccionaCentral(this);obtenerTiposTerminal();obtenerPlanesServicio();">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td class="col1"></td>
			<td class="col2"></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td align="left" colspan="4">
			<h3>Datos Comerciales:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">Uso de la L&iacute;nea (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codUsoLinea" styleId="codUsoLinea"
				onchange="codUsoLinea_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td class="col1">Tipo de Terminal (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codTipoTerminal" styleId="codTipoTerminal"
				onchange="fncSeleccionaTipoTerminal(this);">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
		</tr>
		<tr>
			<td class="col1">Filtro Plan Tarifario:</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="filtroPlan" styleId="filtroPlan"
				onchange="obtenerPlanesTarifarios()">
				<html:option value="">- Todos -</html:option>
				<html:option value="DIS">DISTRIBUIBLES</html:option>
			</html:select></td>
			<td class="col1">Plan Tarifario (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" styleClass="comboDatosLinea" styleId="comboDatosLinea"
				property="codPlanTarif" onchange="codPlanTarif_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
		</tr>
		<tr id="filaLC" style="display: none;">
			<td align="left">L&iacute;mite de Consumo (*)</td>
			<td align="left"><html:select name="DatosLineaScoringForm" styleClass="comboDatosLinea" styleId="comboDatosLinea"
				property="codLimiteConsumo" onchange="fncSeleccionaLimiteConsumo(this)">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td align="left" valign="top"><html:text name="DatosLineaScoringForm"
				property="montoLimiteConsumo" size="20" maxlength="15" readonly="true" styleId="montoLimiteConsumo"
				onkeypress="onlyFloat(this.value,4)"
				onblur="fncValidaMontoDecimal(this); fncValidaRangoLimite(this);" /> <b><label
				for="montoLimiteConsumo" id="lbMontoLimiteConsumo"></label></b></td>
			<td valign="top" align="left"><b>Segmento: </b> <bean:write name="DatosLineaScoringForm"
				property="descripcionSegmento" /><BR>
			<b>Color: </b> <bean:write name="DatosLineaScoringForm" property="descripcionColor" /></td>
		</tr>
		<tr>
			<td class="col1">Plan de Servicio (*):</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codPlanServicio" styleId="codPlanServicio"
				onchange="fncSeleccionaPlanServicio(this);">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td class="col1"></td>
			<td class="col2"></td>
		</tr>
		<tr>
			<td align="left">Campa&ntilde;as Vigentes:</td>
			<td align="left"><html:select name="DatosLineaScoringForm" property="codCampanaVigente" styleId="codCampanaVigente" onchange="codCampanaVigente_onchange(this)" >
				<html:option value="">- Seleccione -</html:option>
				
			</html:select></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td align="left">Causal de Descuento (*):</td>
			<td align="left"><html:select name="DatosLineaScoringForm" property="codCausaDescuento" styleId="codCausaDescuento"
				onchange="fncSeleccionaCausaDescuento(this);">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td></td>
			<td></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	<div id="divSS" style="display: none">
	<table>
		<tr>
			<td colspan="4">
			<h3>Servicios:</h3>
			</td>
		</tr>
		<tr>
			<td colspan="4"><a href="javascript:fncServiciosSupl();">Servicios Suplementarios</a></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	</div>
	<div id="divPA" style="display: none">
	<table>
		<tr>
			<td colspan="4">
			<h3>Planes Adicionales:</h3>
			</td>
		</tr>
		<tr>
			<td colspan="4"><a href="javascript:irAPlanesAdicionales();">Planes Adicionales</a></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	</div>
	<table>
		<tr>
			<td colspan="4">
			<h3>Seguro:</h3>
			</td>
		</tr>
		<tr style="display: none;">
			<td style="display: none;">Art&iacute;culo</td>
			<td style="display: none;"><html:select name="DatosLineaScoringForm" styleId="codArticuloEquipo"
				property="codArticuloEquipo" onchange="codArticuloEquipo_onchange(this);">
				<html:option value="">- Seleccione -</html:option>
			</html:select></td>
			<td style="display: none;"></td>
			<td style="display: none;"></td>
		</tr>
		<tr>
			<td class="col1">Tipo de Seguro:</td>
			<td class="col2"><html:select name="DatosLineaScoringForm" property="codTipoSeguro" styleId="codTipoSeguro"
				onchange="fncObtieneVigenciaSeguro(this);">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosLineaScoringForm" property="arrayTiposSeguro">
					<html:optionsCollection property="arrayTiposSeguro" value="codSeguro" label="desSeguro" />
				</logic:notEmpty>
			</html:select></td>
			<td class="col1">Vigencia Seguro:</td>
			<td class="col2"><html:text name="DatosLineaScoringForm" property="vigenciaSeguro" styleId="vigenciaSeguro"
				readonly="true" /></td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td class="col1"><html:button property="btnAnterior" onclick="fncAnterior()" styleId="btnAnterior"
				style="width: 120px"><<</html:button></td>
			<td class="col2"><html:button property="btnCancelar" onclick="fncCancelar()" styleId="btnCancelar"
				style="width: 150px">CANCELAR SOLICITUD</html:button></td>
			<td class="col1"><html:button property="btnAgregar" onclick="fncAgregarLinea()" styleId="btnAgregar"
				style="width: 150px">AGREGAR L&Iacute;NEA</html:button></td>
			<td class="col2"><logic:equal name="DatosLineaScoringForm" property="flgActivarBtnFinalizar"
				value="1">
				<html:button property="btnFinalizar" styleId="btnFinalizar" onclick="fncFinalizarSolicitud()" style="width: 150px">ENVIAR SOLICITUD</html:button>
			</logic:equal></td>
		</tr>
	</table>
	<table>
		<tr>
			<td align="left"><i>(*): Campos obligatorios</i></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html:html>
