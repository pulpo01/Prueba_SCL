<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet"
	type="text/css" />
<script type='text/javascript'
	src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JDatosLineaAJAX.js'></script>
<script><!--

	//P-CSR-11002 JLGN 16-05-2011
	var flagExisteClienteBuro = "<bean:write name="noExisteClienteBuro"/>";
	var flagMuestraCalificacion = "<bean:write name="flagMuestraCalificacion"/>";	
	
	window.history.forward(1);
	
	var ejecutandoAjax = false;
	
	var ultimoObjetoFoco;
 	//P-CSR-11002 JLGN 06-06-2011
 	//var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	var validandoIdentificacion=false; 	
	
	var listaCeldas = new Array();
	var listaTiposPrestacion = new Array();
	var listaCentrales = new Array();
	var listaLimiteConsumo = new Array();
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";	

	//Inicio P-CSR-11002 JLGN 19-08-2011
	var flagClienteExcepcionado = "<bean:write name="clienteExcepcionado"/>";
	//P-CSR-11002 JLGN 08-11-2011
	var flagCierraApli = false;
	
	//Inicio Inc.179734 06-01-2012 JLGN 
	var flagLineasDDA = false;
	var mensajErrorDDA;
	//Fin Inc.179734 06-01-2012 JLGN 
	 	
 	function fncInicio() {

		var flgConsultaFinalizar = document.getElementById("flgConsultaFinalizar");
		var flgConsultaPA = document.getElementById("flgConsultaPA");
		
		/* P-CSR-11002 JLGN
		if (flgConsultaPA.value == "1") {
			if (confirm("¿Desea contratar planes adicionales?")){
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
		
		if (flgConsultaFinalizar.value == 1){//consulta si finaliza solicitud
			document.getElementById("flgConsultaFinalizar").value = 0;
			
			var	mensajes = document.getElementById("mensajes").innerHTML;
			if (mensajes == ""){//verifica que no hay errores
				var confirmar = confirm("¿Desea finalizar la solicitud?");
				if (confirmar){
					fncFinalizarSolicitud();
					return;
				}
			}
		}*/
		
		//Inicio P-CSR-11002 JLGN 16-05-2011
		if (flagExisteClienteBuro == "true"){
			if (!confirm("Cliente no existe en Buró, para realizar venta Pospago es imprescindible que presente el resguardo de la fianza en el banco ¿Desea continuar con la Solicitud?")) {
				flagExisteClienteBuro = "false";
				document.getElementById("opcion").value = "anterior";
				document.forms[0].submit();
			}		
		}
		//Fin P-CSR-11002 JLGN 16-05-2011
		
	 	fncActivarDesacControlesGrupoPrestacion();
	 	fncObtenerProvincia();
	 	
		var tipoIdentificacionUsuario = document.getElementById("tipoIdentificacionUsuario");
		/*P-CSR-11002 JLGN 06-06-2011
		if (tipoIdentificacionUsuario.value == codigoNIT){
			document.getElementById("lbNumeroIdentificacionUsuario").innerHTML = formatoNIT;
		}*/
		
		var flgAplicaSeguro = document.getElementById("flgAplicaSeguro");
		var codProcedenciaEquipo = document.getElementById("codProcedenciaEquipo");
		var codTipoCliente = document.getElementById("codTipoCliente");
		var codTipoClientePrepago = document.getElementById("codTipoClientePrepago");
					
		/* P-CSR-11002 JLGN 25-05-2011
		if (codProcedenciaEquipo.value == "0" && flgAplicaSeguro.value == "1" && codTipoCliente.value != codTipoClientePrepago.value){
			document.getElementById("codTipoSeguro").disabled=false;
		}else{
			document.getElementById("codTipoSeguro").selectedIndex=0;
			document.getElementById("codTipoSeguro").disabled=true;
			document.getElementById("codTipoSeguro").value="";
			document.getElementById("vigenciaSeguro").value = "";
		}*/
		
		if (codTipoCliente.value == codTipoClientePrepago.value){
			document.getElementById("divDireccionPersonal").style["display"] = "none";
			document.getElementById("divDireccionInstalacion").style["display"] = "none";			
		}else{
			document.getElementById("divDireccionPersonal").style["display"] = "";
		}
		
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		document.getElementById("numCelular").maxLength = largoNumCelular;
		document.getElementById("numCelularInternet").maxLength = largoNumCelular;
		document.getElementById("telefono").maxLength = largoNumCelular;
		
		fncConfigPantallaSegunTipoPrestacion();
		
		//Inicio P-CSR-11002 JLGN 11-05-2011
		document.getElementById("codRegion").disabled= true;
		document.getElementById("codProvincia").disabled= true;
		document.getElementById("codCiudad").disabled= true;		
		//Fin P-CSR-11002 JLGN 11-05-2011	
		
		//Inicio P-CSR-11002 JLGN 16-05-2011
		if (flagMuestraCalificacion =="true"){
			if (document.getElementById("flagCalificacion").value =="true"){
				//Mostrar textbox Calificacion 
				document.getElementById("divCalificacion").style["display"] = "";
				document.getElementById("passCalificacion").disabled = true;
				document.getElementById("btnValidar").disabled = true;
			}else{
				document.getElementById("divCalificacion").style["display"] = "none";
				document.getElementById("passCalificacion").disabled = false;
				document.getElementById("btnValidar").disabled = false;
			}
		}
		//Fin P-CSR-11002 JLGN 16-05-2011
		
		//Inicio P-CSR-11002 JLGN 18-07-2011
		if (codTipoCliente.value != codTipoClientePrepago.value){
			if(document.getElementById("codPlanTarifSeleccionado").value !=""){
				obtieneCargoPT(document.getElementById("codPlanTarifSeleccionado"));		
			}
		}	
		//Fin P-CSR-11002 JLGN 18-07-2011
		
		//Inicio p-CSR-11002 JLGN 17-08-2011
		var flagObtPT = "<bean:write name="flagObtPT"/>";	
		if (flagObtPT =="true"){
			if (document.getElementById("limiteCreditoIngresado").value != "" && document.getElementById("codCalificacionIngresado").value != ""){
				document.getElementById("limiteCredito").value = document.getElementById("limiteCreditoIngresado").value;
				document.getElementById("codCalificacion").value = document.getElementById("codCalificacionIngresado").value;
				document.getElementById("limiteCredito").disabled = true; 
				document.getElementById("codCalificacion").disabled = true;
				document.getElementById("btnCalificacion").disabled = true;
			}else{
				document.getElementById("limiteCredito").disabled = false; 
				document.getElementById("codCalificacion").disabled = false;
				document.getElementById("btnCalificacion").disabled = false;
			}	
		}else{
			if(flagExisteClienteBuro == "true"){
				document.getElementById("limiteCredito").disabled = false; 
				document.getElementById("codCalificacion").disabled = false;
				document.getElementById("btnCalificacion").disabled = false;
			}	
		}
		
		if (document.getElementById("numCelular").value == ""){
			document.getElementById("btnBuscar").disabled=false;
		}else{
			document.getElementById("btnBuscar").disabled=true;
		}
		//Fin p-CSR-11002 JLGN 17-08-2011
		
		//Inicio P-CSR-11002 JLGN 19-08-2011
		if(flagClienteExcepcionado == "true"){
			document.getElementById("btnAgregar").disabled = true;
		}else{
			document.getElementById("btnAgregar").disabled = false;
		}
		
		//Fin P-CSR-11002 JLGN 19-08-2011		
		
		//Inicio P-CSR-11002 JLGN 18-10-2011
		if(document.getElementById("numEquipo").value != "" ){
			document.getElementById("btnSinNumero").disabled = true;		
		}
		//Fin P-CSR-11002 JLGN 18-10-2011
		
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
		
    }
 	
  	//(+) Carga de combos ----------------------------
 	
	function fncActivarDesacControlesGrupoPrestacion() {
		
		var codGrpPrestacion = document.getElementById("codGrpPrestacion");
		if (codGrpPrestacion.value != "") {
			JDatosLineaAJAX.obtenerTiposPrestacion(codGrpPrestacion.value,fncResultadoObtenerTiposPrestacion);
		}
		else {
			DWRUtil.removeAllOptions("codTipoPrestacion");
	    	DWRUtil.addOptions("codTipoPrestacion",{'':'- Seleccione -'});
	    	DWRUtil.removeAllOptions("codNivel1");
	    	DWRUtil.addOptions("codNivel1",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codNivel2");
	    	DWRUtil.addOptions("codNivel2",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codNivel3");
	    	DWRUtil.addOptions("codNivel3",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codUsoLinea");
	    	DWRUtil.addOptions("codUsoLinea",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});		
			/*P-CSR-11002 JLGN 25-05-2011	
			DWRUtil.removeAllOptions("codCausaDescuento");
	    	DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});*/
			fncLimpiarServiciosSuplementarios();
			fncLimpiarNumeracion();
			document.getElementById("tipoRed").value = "";
			document.getElementById("indNumero").value = "";
			document.getElementById("indDirInstalacion").value = "";
			document.getElementById("indInvFijo").value = "";	
			document.getElementById("indSS").value = "";
			document.getElementById("indNumeroPiloto").value = "";			
			document.getElementById("filtroPlan").selectedIndex = 0;
	    	document.getElementById("filtroPlan").value = "";
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML="";
			document.getElementById("indNumeroCortoSMS").value = "";
			fncConfigPantallaSegunTipoPrestacion();
	    }
	}
	
	function fncResultadoObtenerTiposPrestacion(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			var codTipoPrestacionSeleccionada = document.getElementById("codTipoPrestacionSeleccionada").value;
					    		
		    DWRUtil.removeAllOptions("codTipoPrestacion");
		    DWRUtil.addOptions("codTipoPrestacion",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codTipoPrestacion",listaActualizada,"codPrestacion","desPrestacion");

			//(+)carga lista con informacion adicional del tipo de prestacion
			listaTiposPrestacion = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++){
				  	 var tipoPrestacion = new Array(7);
				  	 tipoPrestacion[0] = listaActualizada[indice]["codPrestacion"];
				  	 tipoPrestacion[1] = listaActualizada[indice]["tipoRed"];
				  	 tipoPrestacion[2] = listaActualizada[indice]["indNumero"];
				  	 tipoPrestacion[3] = listaActualizada[indice]["indDirInstalacion"];		  	 				  	 
				  	 tipoPrestacion[4] = listaActualizada[indice]["indInventario"];
				  	 tipoPrestacion[5] = listaActualizada[indice]["indSSInternet"];
				  	 tipoPrestacion[6] = listaActualizada[indice]["indNumeroPiloto"];
				  	 listaTiposPrestacion[indice] = tipoPrestacion;
			}
			//(-)
			
		    if (codTipoPrestacionSeleccionada !=""){
			    var codTipoPrestacion = document.getElementById("codTipoPrestacion");
			    var encontrado = false;
			    for (index = 0; index< codTipoPrestacion.length; index++) {
			       	  if (codTipoPrestacion[index].value == codTipoPrestacionSeleccionada){
			        	codTipoPrestacion.selectedIndex = index;
			        	encontrado = true;
			        	//(+) obtiene otros datos de la prestacion
						for (var indice=0; indice < listaTiposPrestacion.length; indice++){
							if (listaTiposPrestacion[indice][0] == codTipoPrestacion.value){
								document.getElementById("tipoRed").value = listaTiposPrestacion[indice][1];
								document.getElementById("indNumero").value = listaTiposPrestacion[indice][2];
								document.getElementById("indDirInstalacion").value = listaTiposPrestacion[indice][3];
								document.getElementById("indInvFijo").value = listaTiposPrestacion[indice][4];
								document.getElementById("indSS").value = listaTiposPrestacion[indice][5];	
								document.getElementById("indNumeroPiloto").value = listaTiposPrestacion[indice][6];	
								var codGrpPrestacion = document.getElementById("codGrpPrestacion");	
								if(codGrpPrestacion == "SMS"){	
									document.getElementById("indNumeroCortoSMS").value = "1";			
								}
							}
						}
						//(-)
			        	fncConfigPantallaSegunTipoPrestacion();
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codTipoPrestacionSeleccionada").value = ""
		    }
		    
		    //actualizar otros combos
		    fncObtenerNivel1();
		    fncObtenerUsos();
  			fncObtenerCentrales();
	    }//fin if (data!=null)
	}
	
	//(+)-- carga combos de niveles --
	function fncObtenerNivel1(){
		var codPrestacion = document.getElementById("codTipoPrestacion");
		if (codPrestacion.value != "") {
			JDatosLineaAJAX.obtenerNivelesPrestacion(codPrestacion.value,0,fncResultadoObtenerNivel1);
		}else{
			DWRUtil.removeAllOptions("codNivel1");
	    	DWRUtil.addOptions("codNivel1",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codNivel2");
	    	DWRUtil.addOptions("codNivel2",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codNivel3");
	    	DWRUtil.addOptions("codNivel3",{'':'- Seleccione -'});
		}
	}

	function fncResultadoObtenerNivel1(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			var codNivel1Seleccionado = document.getElementById("codNivel1Seleccionado").value;
    		
		    DWRUtil.removeAllOptions("codNivel1");
		    DWRUtil.addOptions("codNivel1",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codNivel1",listaActualizada,"codNivel","descripcionNivel");

		    if (codNivel1Seleccionado !=""){
			    var codNivel1 = document.getElementById("codNivel1");
			    var encontrado = false;
			    for (index = 0; index< codNivel1.length; index++) {
			       	  if (codNivel1[index].value == codNivel1Seleccionado){
			        	codNivel1.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codNivel1Seleccionado").value = ""
		    }
		    
		    //actualizar otros combos
		    fncObtenerNivel2();
	    }//fin if (data!=null)
	}
	//---------------------------------------------------------------------------------------
	
	function fncObtenerNivel2(){
		var codPrestacion = document.getElementById("codTipoPrestacion");
		if (codPrestacion.value != "") {
			var codNivel = document.getElementById("codNivel1");		
			if (codNivel.value!=""){
				JDatosLineaAJAX.obtenerNivelesPrestacion(codPrestacion.value,codNivel.value,fncResultadoObtenerNivel2);
			}else{
				DWRUtil.removeAllOptions("codNivel2");
		    	DWRUtil.addOptions("codNivel2",{'':'- Seleccione -'});
				DWRUtil.removeAllOptions("codNivel3");
		    	DWRUtil.addOptions("codNivel3",{'':'- Seleccione -'});
		    }
		}
	}

	function fncResultadoObtenerNivel2(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			var codNivel2Seleccionado = document.getElementById("codNivel2Seleccionado").value;
    		
		    DWRUtil.removeAllOptions("codNivel2");
		    DWRUtil.addOptions("codNivel2",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codNivel2",listaActualizada,"codNivel","descripcionNivel");

		    if (codNivel2Seleccionado !=""){
			    var codNivel2 = document.getElementById("codNivel2");
			    var encontrado = false;
			    for (index = 0; index< codNivel2.length; index++) {
			       	  if (codNivel2[index].value == codNivel2Seleccionado){
			        	codNivel2.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codNivel2Seleccionado").value = ""
		    }
		    
		    //actualizar otros combos
		    fncObtenerNivel3();
	    }//fin if (data!=null)
	}
	//---------------------------------------------------------------------------------------

	function fncObtenerNivel3(){
		var codPrestacion = document.getElementById("codTipoPrestacion");
		if (codPrestacion.value != "") {
			var codNivel = document.getElementById("codNivel2");		
			if (codNivel.value!=""){
				JDatosLineaAJAX.obtenerNivelesPrestacion(codPrestacion.value,codNivel.value,fncResultadoObtenerNivel3);
			}else{
				DWRUtil.removeAllOptions("codNivel3");
		    	DWRUtil.addOptions("codNivel3",{'':'- Seleccione -'});
		    }
		}
	}	
	function fncResultadoObtenerNivel3(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			var codNivel3Seleccionado = document.getElementById("codNivel3Seleccionado").value;
    		
		    DWRUtil.removeAllOptions("codNivel3");
		    DWRUtil.addOptions("codNivel3",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codNivel3",listaActualizada,"codNivel","descripcionNivel");

		    if (codNivel3Seleccionado !=""){
			    var codNivel3 = document.getElementById("codNivel3");
			    var encontrado = false;
			    for (index = 0; index< codNivel3.length; index++) {
			       	  if (codNivel3[index].value == codNivel3Seleccionado){
			        	codNivel3.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codNivel3Seleccionado").value = ""
		    }
		    
		    //actualizar otros combos
	    }//fin if (data!=null)
	}
	//(-)-- carga combos de niveles --
	
	//(+)-- carga combo de provincia --
	function fncObtenerProvincia() {
		var codRegion = document.getElementById("codRegion");
		if (codRegion.value != "") {
			JDatosLineaAJAX.obtenerProvincias(codRegion.value,fncResultadoObtenerProvincia);
		}else{
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
			fncLimpiarNumeracion();
	    }
	}
	
	function fncResultadoObtenerProvincia(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			var codProvinciaSeleccionada = document.getElementById("codProvinciaSeleccionada").value;
    		
		    DWRUtil.removeAllOptions("codProvincia");
		    DWRUtil.addOptions("codProvincia",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codProvincia",listaActualizada,"codigo","descripcion");

		    if (codProvinciaSeleccionada !=""){
			    var codProvincia = document.getElementById("codProvincia");
			    var encontrado = false;
			    for (index = 0; index< codProvincia.length; index++) {
			       	  if (codProvincia[index].value == codProvinciaSeleccionada){
			        	codProvincia.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codProvinciaSeleccionada").value = ""
		    }
		    
		    //actualizar otros combos
		    fncObtenerCiudad();
	    }//fin if (data!=null)
	}
	//(-)-- carga combo de provincia --
	
	//(+)-- carga combo de ciudad --
	function fncObtenerCiudad() {
		var codRegion = document.getElementById("codRegion");
		var codProvincia = document.getElementById("codProvincia");
	
		if (codRegion.value!="" && codProvincia.value != "") {
			JDatosLineaAJAX.obtenerCiudades(codRegion.value, codProvincia.value,fncResultadoObtenerCiudad);
		}else{
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
			fncLimpiarNumeracion();
	    }
	}
	
	function fncResultadoObtenerCiudad(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codCiudadSeleccionada = document.getElementById("codCiudadSeleccionada").value;
					    		
		    DWRUtil.removeAllOptions("codCiudad");
		    DWRUtil.addOptions("codCiudad",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCiudad",listaActualizada,"codigo","descripcion");

		    if (codCiudadSeleccionada !=""){
			    var codCiudad = document.getElementById("codCiudad");
			    var encontrado = false;
			    for (index = 0; index< codCiudad.length; index++) {
			       	  if (codCiudad[index].value == codCiudadSeleccionada){
			        	codCiudad.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codCiudadSeleccionada").value = ""
		    }
		    
		    //actualizar otros combos
			fncObtenerCeldas();
	    }//fin if (data!=null)
	}
	
	//(+)-- carga combo de celdas --
	function fncObtenerCeldas() {
		var codRegion = document.getElementById("codRegion");
		var codProvincia = document.getElementById("codProvincia");
		var codCiudad = document.getElementById("codCiudad");		
	
		if (codRegion.value!="" && codProvincia.value != "" && codCiudad.value != "") {
			JDatosLineaAJAX.obtenerCeldas(codRegion.value, codProvincia.value, codCiudad.value, fncResultadoObtenerCeldas);
		}else{
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
			fncLimpiarNumeracion();
	    }
	}
	
	function fncResultadoObtenerCeldas(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codCeldaSeleccionada = document.getElementById("codCeldaSeleccionada").value;
 		
		    DWRUtil.removeAllOptions("codCelda");
		    DWRUtil.addOptions("codCelda",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCelda",listaActualizada,"codigoCelda","descripcionCelda");

			//(+)carga lista con codigo celda y codSubAlm
			listaCeldas = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++){
				  	 var celda = new Array(2);
				  	 celda[0] = listaActualizada[indice]["codigoCelda"];
				  	 celda[1] = listaActualizada[indice]["codSubAlm"];
				  	 listaCeldas[indice] = celda;
			}
			//(-)
		    if (codCeldaSeleccionada !=""){
			    var codCelda = document.getElementById("codCelda");
			    var encontrado = false;
			    for (index = 0; index< codCelda.length; index++) {
			       	  if (codCelda[index].value == codCeldaSeleccionada){
			        	codCelda.selectedIndex = index;
			        	encontrado = true;
			        	//(+) selecciona codSubAlm asociada a celda seleccionada
			        	var codSubAlm = "";
						for (var indice=0; indice < listaCeldas.length; indice++){
							if (listaCeldas[indice][0] == codCelda.value){
								codSubAlm = listaCeldas[indice][1];
								document.getElementById("codSubAlm").value = codSubAlm;
								break;
							}
						}
						//(-)
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codCeldaSeleccionada").value = ""
		    }		    
		    //actualizar otros combos
			fncObtenerCentrales();
	    }//fin if (data!=null)
	}
	
	//(+)-- carga combo de centrales --
	function fncObtenerCentrales() {
		var codCelda = document.getElementById("codCelda");
		var codPrestacion= document.getElementById("codTipoPrestacion");
		//(+) este es un caso particular(ajax), dado que codCelda se demora mas en cargar el combo
		//que tipo prestacion, y si es invocado este metodo desde tipo prestacion la celda podría
		//aun no ser cargada
		if (codCelda.value=="") codCelda = document.getElementById("codCeldaSeleccionada"); 
		if (codPrestacion.value=="") codPrestacion = document.getElementById("codTipoPrestacionSeleccionada"); 
		//(-)
		
		if (codCelda.value != "" && codPrestacion.value !="" ) {
			var codSubAlm = document.getElementById("codSubAlm").value
			if (codSubAlm!=""){
				JDatosLineaAJAX.obtenerCentrales(codSubAlm,codPrestacion.value, fncResultadoObtenerCentrales);
			}
		}else{
			DWRUtil.removeAllOptions("codCentral");
	    	DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});		    
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});  
			document.getElementById("codTecnologia").value = "";	  
			fncLimpiarServiciosSuplementarios();
			fncLimpiarNumeracion();
			fncLimpiarSeries();
	    }
	}
	
	function fncResultadoObtenerCentrales(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			//(+)carga lista centrales con codigo central y tecnologia
			listaCentrales = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++){
				  	 var central = new Array(2);
				  	 central[0] = listaActualizada[indice]["codigoCentral"];
				  	 central[1] = listaActualizada[indice]["codigoTecnologia"];
				  	 listaCentrales[indice] = central;
			}
			//(-)
			
			var codCentralSeleccionada = document.getElementById("codCentralSeleccionada").value;
 		
		    DWRUtil.removeAllOptions("codCentral");
		    DWRUtil.addOptions("codCentral",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCentral",listaActualizada,"codigoCentral","descripcionCentral");

		    if (codCentralSeleccionada !=""){
			    var codCentral = document.getElementById("codCentral");
			    var encontrado = false;
			    for (index = 0; index< codCentral.length; index++) {
			       	  if (codCentral[index].value == codCentralSeleccionada){
			        	codCentral.selectedIndex = index;
			        	encontrado = true;
			        	//(+) selecciona tecnologia asociada a central seleccionada
						for (var indice=0; indice < listaCentrales.length; indice++){
							if (listaCentrales[indice][0] == codCentral.value){
								document.getElementById("codTecnologia").value = listaCentrales[indice][1];
								break;
							}
						}
						//(-)
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codCentralSeleccionada").value = ""
		    }else{//Inicio P-CSR-11002 12-05-2011 JLGN
		    	var codCentral = document.getElementById("codCentral");
			    var encontrado = false;			   		       	
	            codCentral.selectedIndex = 1;
	            encontrado = true;
	            //(+) selecciona tecnologia asociada a central seleccionada
			    for (var indice=0; indice < listaCentrales.length; indice++){
			  	  if (listaCentrales[indice][0] == codCentral.value){
			  	  	  document.getElementById("codTecnologia").value = listaCentrales[indice][1];
					  break;
				  }
	     	    }							    
			    if (!encontrado) document.getElementById("codCentralSeleccionada").value = ""		    	
		    }//Fin P-CSR-11002 JLGN 12-05-2011
		    
		    //actualizar otros combos
		    obtenerPlanesServicio();
		    obtenerTiposTerminal();
	    }//fin if (data!=null)
	}
	
	//(-)-- carga combo de ciudad --
		
	//(+)-- carga combo de usos --
	function fncObtenerUsos() {
		var codTipoPrestacion = document.getElementById("codTipoPrestacion");
		if (codTipoPrestacion.value != null && codTipoPrestacion.value != "") {
			var codTipoRed = document.getElementById("tipoRed");
			if (codTipoRed.value != null && codTipoRed.value != "") {
				JDatosLineaAJAX.obtenerUsos(codTipoRed.value, fncResultadoObtenerUsos);
			}
		}
		else {
			DWRUtil.removeAllOptions("codUsoLinea");
	    	DWRUtil.addOptions("codUsoLinea",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});		
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});	
			/*P-CSR-11002 JLGN 25-05-2011
			DWRUtil.removeAllOptions("codCausaDescuento");
	    	DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});
	    	*/
	    	DWRUtil.removeAllOptions("codCampanaVigente");
	    	DWRUtil.addOptions("codCampanaVigente",{'':'- Seleccione -'});		    
			
			document.getElementById("filtroPlan").selectedIndex = 0;
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML="";
			fncLimpiarServiciosSuplementarios();
			fncLimpiarNumeracion();
			fncLimpiarSeries();
	    }
	}
	
	function fncResultadoObtenerUsos(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];

			var codUsoLineaSeleccionado = document.getElementById("codUsoLineaSeleccionado").value;
 		
		    DWRUtil.removeAllOptions("codUsoLinea");
		    DWRUtil.addOptions("codUsoLinea",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codUsoLinea",listaActualizada,"codUso","desUso");

		    if (codUsoLineaSeleccionado !=""){
			    var codUsoLinea = document.getElementById("codUsoLinea");
			    var encontrado = false;
			    for (index = 0; index< codUsoLinea.length; index++) {
			       	  if (codUsoLinea[index].value == codUsoLineaSeleccionado){
			        	codUsoLinea.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codUsoLineaSeleccionado").value = ""
		    }
		    
		    //actualizar otros combos
			obtenerPlanesTarifarios();
			/*P-CSR-11002 JLGN 25-05-2011
			obtenerCausasDescuento();*/
			getListadoCampaniasVigentesXCodUso();
	    }//fin if (data!=null)
	}
	//(-)-- carga combo de usos --	
		
	//(+)-- carga combo de planes tarifarios --
	function obtenerPlanesTarifarios() {
		var codUsoLinea = document.getElementById("codUsoLinea");
		var codPrestacion =document.getElementById("codTipoPrestacion");
		var filtroPlan =document.getElementById("filtroPlan");
		// P-CSR-11002 JLGN 17-05-2011
		var codCalificacion =document.getElementById("codCalificacion");
		var limiteCredito = document.getElementById("limiteCredito");
		if (codUsoLinea.value != "") {
			
			var indRenovacion = 0;
			/*P-CSR-11002 JLGN 25-05-2011
			if (document.getElementById("codRenovacion") != null) {
				indRenovacion = document.getElementById("codRenovacion").value;
			}*/
			//P-CSR-11002 JLGN 17-05-2011
			//JDatosLineaAJAX.obtenerPlanesTarifarios(codUsoLinea.value,codPrestacion.value,filtroPlan.value, indRenovacion, fncResultadoObtenerPlanesTarifarios);
			if(codCalificacion == null){
				JDatosLineaAJAX.obtenerPlanesTarifarios(codUsoLinea.value,codPrestacion.value,filtroPlan.value, indRenovacion, "", "",fncResultadoObtenerPlanesTarifarios);
			}else{
				JDatosLineaAJAX.obtenerPlanesTarifarios(codUsoLinea.value,codPrestacion.value,filtroPlan.value, indRenovacion, codCalificacion.value,limiteCredito.value,fncResultadoObtenerPlanesTarifarios);
			}
		}
		else {
			DWRUtil.removeAllOptions("codPlanTarif");
	    	DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});		
			document.getElementById("filtroPlan").selectedIndex = 0;
	    	document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML="";
			fncLimpiarServiciosSuplementarios();
	    }
	}
		
	function fncResultadoObtenerPlanesTarifarios(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codPlanTarifSeleccionado = document.getElementById("codPlanTarifSeleccionado").value;
 		
		    DWRUtil.removeAllOptions("codPlanTarif");
		    DWRUtil.addOptions("codPlanTarif",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codPlanTarif", listaActualizada, "codigoPlanTarifario", "descripcionPlanTarifario");
		    
		    listaPlanesTarifarios = listaActualizada;
		    
		    if (codPlanTarifSeleccionado !=""){
			    var codPlanTarif = document.getElementById("codPlanTarif");
			    var encontrado = false;
			    for (index = 0; index< codPlanTarif.length; index++) {
			       	  if (codPlanTarif[index].value == codPlanTarifSeleccionado){
			        	codPlanTarif.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codPlanTarifSeleccionado").value = ""
		    }
		    
		    //actualizar otros combos
		    obtenerPlanesServicio();
			obtenerLimitesConsumo();
			mostrarOcultarFilaLC();
			
			//P-CSR-11002 JLGN 14-05-2011
			fncCursorNormal();			
	    }//fin if (data!=null)
	}		
	//(-)-- carga combo de planes tarifarios --
		
	//(+)-- carga combo de planes servicio --
	function obtenerPlanesServicio() {
		var codPlanTarif = document.getElementById("codPlanTarif");
		var codCentral = document.getElementById("codCentral");				
		if (codPlanTarif.value != "" && codCentral.value != "") {
			var codTecnologia = document.getElementById("codTecnologia").value;
			if (codTecnologia!=""){
				JDatosLineaAJAX.obtenerPlanesServicio(codPlanTarif.value, codTecnologia, fncResultadoObtenerPlanesServicio);
			}
		}else{
			DWRUtil.removeAllOptions("codPlanServicio");
	    	DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});		    	    	
	    }
	}
	
	function fncResultadoObtenerPlanesServicio(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codPlanServicioSeleccionado = document.getElementById("codPlanServicioSeleccionado").value;
 		
		    DWRUtil.removeAllOptions("codPlanServicio");
		    DWRUtil.addOptions("codPlanServicio",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codPlanServicio",listaActualizada,"codigoPlanServicio","descripcionPlanServicio");

		    if (codPlanServicioSeleccionado !=""){
			    var codPlanServicio = document.getElementById("codPlanServicio");
			    var encontrado = false;
			    for (index = 0; index< codPlanServicio.length; index++) {
			       	  if (codPlanServicio[index].value == codPlanServicioSeleccionado){
			        	codPlanServicio.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codPlanServicioSeleccionado").value = ""
		    }
		    
		    //actualizar otros combos
			
	    }//fin if (data!=null)
	}			
	//(-)-- carga combo de planes servicio --
	
	//(+)-- carga combo de limites de consumo --
	function obtenerLimitesConsumo() {
		var codPlanTarif = document.getElementById("codPlanTarif");
		if (codPlanTarif.value != "") {
			JDatosLineaAJAX.obtenerLimitesConsumo(codPlanTarif.value, fncResultadoObtenerLimitesConsumo);
		}else{
			DWRUtil.removeAllOptions("codLimiteConsumo");
	    	DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});		 
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;	
			document.getElementById("montoLimiteConsumo").value = 0;  
			document.getElementById("lbMontoLimiteConsumo").innerHTML="";  	   	    	
	    }
	}
	
	function fncResultadoObtenerLimitesConsumo(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			
			//(+)carga lista de limites de consumo con informacion de rangos
			listaLimiteConsumo = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++){
				  	 var limiteConsumo = new Array(5);
				  	 limiteConsumo[0] = listaActualizada[indice]["codigoLimiteConsumo"];
				  	 limiteConsumo[1] = listaActualizada[indice]["montoMinimo"];
				  	 limiteConsumo[2] = listaActualizada[indice]["montoMaximo"];
				  	 limiteConsumo[3] = listaActualizada[indice]["flgCorte"];
				  	 limiteConsumo[4] = listaActualizada[indice]["montoCons"];
				  	 listaLimiteConsumo[indice] = limiteConsumo;
			}
			//(-)
			
			
			var codLimiteConsumoSeleccionado = document.getElementById("codLimiteConsumoSeleccionado").value;
 		
		    DWRUtil.removeAllOptions("codLimiteConsumo");
		    DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codLimiteConsumo",listaActualizada,"codigoLimiteConsumo","descripcionLimiteConsumo");

		    if (codLimiteConsumoSeleccionado != "") {
			    var codLimiteConsumo = document.getElementById("codLimiteConsumo");
			    var encontrado = false;
			    for (index = 0; index< codLimiteConsumo.length; index++) {
			       	  if (codLimiteConsumo[index].value == codLimiteConsumoSeleccionado){
			        	codLimiteConsumo.selectedIndex = index;
			        	encontrado = true;
			        	
			        	//(+) obtiene informacion de rangos
						for (var indice=0; indice < listaLimiteConsumo.length; indice++){
							if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value){
								document.getElementById("montoMinimo").value = listaLimiteConsumo[indice][1];
								document.getElementById("montoMaximo").value = listaLimiteConsumo[indice][2];
								document.getElementById("flgCorte").value = listaLimiteConsumo[indice][3];
								document.getElementById("montoCons").value = listaLimiteConsumo[indice][4];	
								break;
							}
						}
						//(-)
						
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
					document.getElementById("lbMontoLimiteConsumo").innerHTML="";
			    }
		    }else{//Inicio P-CSR-11002 JLGN 12-05-2011 Carga el Primer LC que se encuentre
		    	var codLimiteConsumo = document.getElementById("codLimiteConsumo");
			    var encontrado = false;
	        	codLimiteConsumo.selectedIndex = 1;
	        	encontrado = true;			        	
	        	//(+) obtiene informacion de rangos
				for (var indice=0; indice < listaLimiteConsumo.length; indice++){
					if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value){
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
		    }// Fin P-CSR-11002 JLGN 12-05-2011
		    //actualizar otros combos
	    }//fin if (data!=null)
	}			
	//(-)-- carga combo de limites de consumo --
	
	//(+)-- carga combo de tipos de terminal --
	function obtenerTiposTerminal() {
		var codCentral = document.getElementById("codCentral");
		if (codCentral.value != "") {
			var codTecnologia = document.getElementById("codTecnologia").value;			
			if (codTecnologia!=""){
				JDatosLineaAJAX.obtenerTiposTerminal(codTecnologia, fncResultadoObtenerTiposTerminal);
			}
		}else{
			DWRUtil.removeAllOptions("codTipoTerminal");
	    	DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});	
			fncLimpiarSeries();   	    	
	    }
	}
		
	function fncResultadoObtenerTiposTerminal(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codTipoTerminalSeleccionado = document.getElementById("codTipoTerminalSeleccionado").value;
 		
		    DWRUtil.removeAllOptions("codTipoTerminal");
		    DWRUtil.addOptions("codTipoTerminal",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codTipoTerminal",listaActualizada,"tipTerminal","desTerminal");

		    if (codTipoTerminalSeleccionado !=""){
			    var codTipoTerminal = document.getElementById("codTipoTerminal");
			    var encontrado = false;
			    for (index = 0; index< codTipoTerminal.length; index++) {
			       	  if (codTipoTerminal[index].value == codTipoTerminalSeleccionado){
			        	codTipoTerminal.selectedIndex = index;
			        	encontrado = true;
			        	//P-CSR-11002 JLGN 27-07-2011
			        	fncConfigPantallaSegunTipoPrestacion();
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codTipoTerminalSeleccionado").value = ""
		    }
		    
		    //actualizar otros combos
			
	    }//fin if (data!=null)
	}					
	//(-)-- carga combo de tipos de terminal --
	
	//(+)-- carga combo de causa de descuento --
	/*P-CSR-11002 JLGN 25-05-2011
	function obtenerCausasDescuento() {
		var codUsoLinea = document.getElementById("codUsoLinea");
		if (codUsoLinea.value != "") {
			JDatosLineaAJAX.obtenerCausalDescuento(codUsoLinea.value, fncResultadoObtenerCausasDescuento);
		}
		else {
			DWRUtil.removeAllOptions("codCausaDescuento");
	    	DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});		
	    }
	}

	function fncResultadoObtenerCausasDescuento(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
			var codCausaDescuentoSeleccionada = document.getElementById("codCausaDescuentoSeleccionada").value;
 		
		    DWRUtil.removeAllOptions("codCausaDescuento");
		    DWRUtil.addOptions("codCausaDescuento",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codCausaDescuento",listaActualizada,"codigoCausalDescuento","descripcionCausalDescuento");

		    if (codCausaDescuentoSeleccionada !=""){
			    var codCausaDescuento = document.getElementById("codCausaDescuento");
			    var encontrado = false;
			    for (index = 0; index< codCausaDescuento.length; index++) {
			       	  if (codCausaDescuento[index].value == codCausaDescuentoSeleccionada){
			        	codCausaDescuento.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codCausaDescuentoSeleccionada").value = ""
		    }
			
	    }//fin if (data!=null)
	}*/
	//(-)-- carga combo de causa de descuento --

	//(-) Carga de combos ----------------------------
		
	//(+)-- valida tipo identificacion --		
	function fncValidaTipoIdentificacion(tipoIdentSel,numIdentText) {
		if (!validandoIdentificacion){
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				ejecutandoAjax = true;
				JDatosLineaAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
			}
		}
	}
	
	function fncResultadoValidacion(data) {
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}			
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
				ultimoObjetoFoco.focus();
			}else{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
			validandoIdentificacion = false;
		}
		ejecutandoAjax = false;
	}
	//(-)-- valida tipo identificacion --	
	
	//(+)-- valida numero internet --	
	function fncValidarNumeroInternet() {
		var numCelularInternet = document.getElementById("numCelularInternet");
		var procedenciaNumero = document.getElementById("procedenciaNumero");
	
		if (numCelularInternet.value != "" && procedenciaNumero.value != "") {
				ejecutandoAjax = true;
				JDatosLineaAJAX.validarNumeroInternet(numCelularInternet.value,procedenciaNumero.value,fncResultadoValidacionNumeroInternet);
		}
	}

	function fncResultadoValidacionNumeroInternet(data) {
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("N\u00FAmero no existe o no es v\u00E1lido de acuerdo a los requerimientos comerciales");
				document.getElementById("numCelularInternet").value="";
				document.getElementById("numCelularInternet").focus();
			}
		}
		ejecutandoAjax = false;

	}
	//(-)-- valida numero internet --	
		
	//(+)-- valida plan tarifario --	
	function fncValidarPlanCompartido(codPlanTarif) {
		if (codPlanTarif.value != ""){
				ejecutandoAjax = true;
				JDatosLineaAJAX.validarPlanCompartido(codPlanTarif.value,fncResultadoValidarPlanCompartido);
		}
	}

	function fncResultadoValidarPlanCompartido(data) {
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				var mensajeError =  data['msgError']; 
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}			
				var codPlanTarif = document.getElementById("codPlanTarif").value;
	        	//mensajeError =  "Cliente Ha sobrepasado la cantidad de abonados permitida por el plan " + codPlanTarif;
	        	mostrarMensajeError(mensajeError);
				document.getElementById("codPlanTarifSeleccionado").value="";
				document.getElementById("codPlanTarif").value="";
				document.getElementById("codPlanTarif").focus();
			}
		}
		ejecutandoAjax = false;

	}
	//(-)-- valida plan tarifario --		
		
	//(+)-- obtiene vigencia del seguro --
	/*P-CSR-11002 JLGN 25-05-2011
	function fncObtieneVigenciaSeguro(codSeguro){
		if (codSeguro.value != ""){
			ejecutandoAjax = true;
			JDatosLineaAJAX.obtenerFechaVigenciaSeguro(codSeguro.value,fncResultadoObtenerFechaVigenciaSeguro);
		}else{
			document.getElementById("vigenciaSeguro").value = "";
		}
	}

	function fncResultadoObtenerFechaVigenciaSeguro(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			document.getElementById("vigenciaSeguro").value = data["resultado"];
	    }//fin if (data!=null)
	    ejecutandoAjax = false;
	}	*/
	//(-)-- obtiene vigencia del seguro --
		 	
	//(+) -- seleccion de combos --

 	function fncSeleccionaTiposPrestacion(codTipoPrestacion){
		document.getElementById("codTipoPrestacionSeleccionada").value = codTipoPrestacion.value;
		if (codTipoPrestacion.value != "") {
			//(+)obtener otros datos de la prestacion
			var tipoRed = "";
			var indNumero = "";
			var indDirInstalacion = "";
			var indInvFijo = "";	
			var indSS = "";					
			var indNumeroPiloto = "";
			for (var indice=0; indice < listaTiposPrestacion.length; indice++){
				if (listaTiposPrestacion[indice][0] == codTipoPrestacion.value){
					tipoRed = listaTiposPrestacion[indice][1];
					indNumero = listaTiposPrestacion[indice][2];
					indDirInstalacion = listaTiposPrestacion[indice][3];
					indInvFijo = listaTiposPrestacion[indice][4];
					indSS = listaTiposPrestacion[indice][5];				
					indNumeroPiloto = listaTiposPrestacion[indice][6];					
				}
			}
			//(-)
			document.getElementById("tipoRed").value = tipoRed;
			document.getElementById("indNumero").value = indNumero;
			document.getElementById("indDirInstalacion").value = indDirInstalacion;
			document.getElementById("indInvFijo").value = indInvFijo;	
			document.getElementById("indSS").value = indSS;	
			document.getElementById("indNumeroPiloto").value = indNumeroPiloto;	
			
			//Inicio P-CSR-11002 JLGN 19-08-2011
			if (flagMuestraCalificacion == "true"){
				document.getElementById("passCalificacion").value = "";
				document.getElementById("passCalificacion").disabled = false;
				document.getElementById("btnValidar").disabled = false;
				document.getElementById("limiteCreditoIngresado").value = "";
				document.getElementById("codCalificacionIngresado").value = "";
				document.getElementById("codPlanTarifSeleccionado").value = "";
				document.getElementById("limiteCredito").value = "";
				document.getElementById("limiteCredito").disabled = false;
				document.getElementById("codCalificacion").value = "";
				document.getElementById("codCalificacion").disabled = true;
				document.getElementById("btnCalificacion").disabled = true;
				document.getElementById("divCalificacion").style["display"] = "none";
			}	
			//Fin P-CSR-11002 JLGN 19-08-2011

			var codGrpPrestacion = document.getElementById("codGrpPrestacion");	
			if(codGrpPrestacion == "SMS"){	
				document.getElementById("indNumeroCortoSMS").value = "1";			
			}
			
		}else{
			document.getElementById("tipoRed").value = "";
			document.getElementById("indNumero").value = "";
			document.getElementById("indDirInstalacion").value = "";
			document.getElementById("indInvFijo").value = "";	
			document.getElementById("indSS").value = "";
			document.getElementById("indNumeroPiloto").value = "";	
			document.getElementById("indNumeroCortoSMS").value = "";	
		}
		
		fncConfigPantallaSegunTipoPrestacion();
		
	}
	
	function fncSeleccionaNivel1(codNivel){
		document.getElementById("codNivel1Seleccionado").value = codNivel.value;
	}
	
	function fncSeleccionaNivel2(codNivel){
		document.getElementById("codNivel2Seleccionado").value = codNivel.value;
	}
	
	function fncSeleccionaNivel3(codNivel){
		document.getElementById("codNivel3Seleccionado").value = codNivel.value;
	}
	
	function fncSeleccionaProvincia(codProvincia){
		document.getElementById("codProvinciaSeleccionada").value = codProvincia.value;
	}
	
	function fncSeleccionaCiudad(codCiudad){
		document.getElementById("codCiudadSeleccionada").value = codCiudad.value;
	}
		
	function fncSeleccionaCelda(){
		var codCelda = document.getElementById("codCelda");	//P-CSR-11002 JLGN 12-05-2011
		document.getElementById("codCeldaSeleccionada").value = codCelda.value;		
		if (codCelda.value !=""){
			//(+)obtener codSubAlm
			var codSubAlm = "";
			for (var indice=0; indice < listaCeldas.length; indice++){
				if (listaCeldas[indice][0] == codCelda.value){
					codSubAlm = listaCeldas[indice][1];
					break;
				}
			}
			//(-)
			document.getElementById("codSubAlm").value = codSubAlm;
		}else{
			document.getElementById("codSubAlm").value = "";
		}
		fncLimpiarNumeracion();
	}	
	
	function fncSeleccionaCentral(codCentral){
		document.getElementById("codCentralSeleccionada").value = codCentral.value;
		if (codCentral.value != "") {
			//(+)obtener tecnologia
			var codTecnologia = "";
			for (var indice=0; indice < listaCentrales.length; indice++){
				if (listaCentrales[indice][0] == codCentral.value){
					codTecnologia = listaCentrales[indice][1];
					break;
				}
			}
			//(-)
			document.getElementById("codTecnologia").value = codTecnologia;
		}
		else {
			document.getElementById("codTecnologia").value = "";
		}
		fncLimpiarNumeracion();
		fncLimpiarSeries();		
		fncLimpiarServiciosSuplementarios();	
		fncConfigPantallaSegunTipoPrestacion();
	}

	function fncSeleccionaUso(codUso){
		document.getElementById("codUsoLineaSeleccionado").value = codUso.value;
		fncLimpiarNumeracion();
		fncLimpiarSeries();		
	}
	
			
	function fncSeleccionaPlanTarif(codPlanTarif){
		document.getElementById("codPlanTarifSeleccionado").value = codPlanTarif.value;
		fncValidarPlanCompartido(codPlanTarif);		
		fncLimpiarServiciosSuplementarios();
	    mostrarOcultarFilaLC();
	}	


	function fncSeleccionaPlanServicio(codPlanServicio){
		document.getElementById("codPlanServicioSeleccionado").value = codPlanServicio.value;
	}		
	
	function fncSeleccionaLimiteConsumo(codLimiteConsumo){
		document.getElementById("codLimiteConsumoSeleccionado").value = codLimiteConsumo.value;
		if (codLimiteConsumo.value != "") {
			//(+)obtener rangos
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
			//(-)
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
	
	function fncSeleccionaTipoTerminal(codTipoTerminal){
		document.getElementById("codTipoTerminalSeleccionado").value = codTipoTerminal.value;
		fncConfigPantallaSegunTipoPrestacion();
		fncLimpiarSeries();
	}
	
	/* P-CSR-11002 JLGN 25-05-2011
	function fncSeleccionaCausaDescuento(codCausaDescuento){
		document.getElementById("codCausaDescuentoSeleccionada").value = codCausaDescuento.value;
	}*/

	function fncSeleccionaProcedenciaNumero(rdProcedenciaNumero){
		document.getElementById("procedenciaNumero").value = rdProcedenciaNumero.value;
	}

	//(-) -- seleccion de combos --
	
	//(+) -- configuracion de pantalla segun tipo prestacion --
	function fncConfigPantallaSegunTipoPrestacion(){
			var codTelefoniaMovil = document.getElementById("codTelefoniaMovil").value;
			var codTelefoniaFija = document.getElementById("codTelefoniaFija").value;	
			var codInternet = document.getElementById("codInternet").value;	
			var codCarrier = document.getElementById("codCarrier").value;	
									
			var codGrpPrestacion = document.getElementById("codGrpPrestacion").value;	
			var indInvFijo = document.getElementById("indInvFijo").value;
			var indNumero = document.getElementById("indNumero").value;
			var indDirInstalacion = document.getElementById("indDirInstalacion").value;			
			var indSS = document.getElementById("indSS").value;
			var indNumeroPiloto = document.getElementById("indNumeroPiloto").value;
			var codTecnologia = document.getElementById("codTecnologia").value;
			
			//alert("codGrpPrestacion,indInvFijo,indNumero,indSS,codTecnologia,indDirInstalacion"+
			//codGrpPrestacion+","+indInvFijo+","+indNumero+","+indSS+","+codTecnologia+","+indDirInstalacion);
			
			//(+) ------------- Simcard y Equipo --------------------
			//inventario fijo				
			if((indInvFijo == "1") && (codGrpPrestacion == codTelefoniaMovil || codGrpPrestacion == codTelefoniaFija) ){
			
				if (codGrpPrestacion == codTelefoniaMovil){ //TM
					if (codTecnologia == "GSM"){
						//mostrar seccion simcard y equipo
						document.getElementById("divSimcardTitulo").style["display"] = "";
						document.getElementById("divSimcardLink").style["display"] = "";
						document.getElementById("divSimcard").style["display"] = "";						
						document.getElementById("divEquipoTitulo").style["display"] = "";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "";
						document.getElementById("divEquipoLink").style["display"] = "";						
						document.getElementById("divEquipo").style["display"] = "";						
					}else if (codTecnologia == "CDMA"){
						//mostrar seccion equipo, y ocultar simcard
						document.getElementById("divSimcardTitulo").style["display"] = "none";
						document.getElementById("divSimcardLink").style["display"] = "none";						
						document.getElementById("divSimcard").style["display"] = "none";						
						document.getElementById("divEquipoTitulo").style["display"] = "";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "";						
						document.getElementById("divEquipoLink").style["display"] = "";						
						document.getElementById("divEquipo").style["display"] = "";						
					}else{
						//ocultar seccion simcard y equipo
						document.getElementById("divSimcardTitulo").style["display"] = "none";
						document.getElementById("divSimcardLink").style["display"] = "none";
						document.getElementById("divSimcard").style["display"] = "none";						
						document.getElementById("divEquipoTitulo").style["display"] = "none";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "none";
						document.getElementById("divEquipoLink").style["display"] = "none";						
						document.getElementById("divEquipo").style["display"] = "none";
						
					}
					
				}
				if (codGrpPrestacion == codTelefoniaFija){ //TF
					//mostrar seccon equipo externo, ocultar simcard
					document.getElementById("divSimcardTitulo").style["display"] = "none";
					document.getElementById("divSimcardLink").style["display"] = "none";
					document.getElementById("divSimcard").style["display"] = "none";					
					document.getElementById("divEquipoTitulo").style["display"] = "";
					document.getElementById("divEquipoLinkSeguro").style["display"] = "";
					document.getElementById("divEquipoLink").style["display"] = "";					
					document.getElementById("divEquipo").style["display"] = "";					
				}
				
			}else{
				//ocultar seccion simcard y equipo
				document.getElementById("divSimcardTitulo").style["display"] = "none";
				document.getElementById("divSimcardLink").style["display"] = "none";
				document.getElementById("divSimcard").style["display"] = "none";
				document.getElementById("divEquipoTitulo").style["display"] = "none";
				document.getElementById("divEquipoLinkSeguro").style["display"] = "none";
				document.getElementById("divEquipoLink").style["display"] = "none";				
				document.getElementById("divEquipo").style["display"] = "none";				
			}
			//(-)  ------------- Simcard y Equipo --------------------
			
			//(+) --------------- numeracion -------------------------
			if (indNumero == "1") {
				//mostrar seccion numero
				//deshabilitar texto ingreso numero		
				document.getElementById("divNumeracionTitulo").style["display"] = "";
				document.getElementById("divNumeracionLink").style["display"] = "";				
				document.getElementById("divNumeracion").style["display"] = "";
				document.getElementById("divNumeracionInternet").style["display"] = "none";
			}
			else {
				if (codGrpPrestacion == codInternet) { //IE
					//Incidencia 134176. Se elimina la numeracion en el caso del grupo de prestaciones internet
					//document.getElementById("divNumeracionTitulo").style["display"] = "";
					document.getElementById("divNumeracionTitulo").style["display"] = "none";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					//document.getElementById("divNumeracionInternet").style["display"] = "";		
					document.getElementById("divNumeracionInternet").style["display"] = "none";
					//document.forms[0].rdProcedenciaNumero[0].disabled = false;
				}
				else if (codGrpPrestacion == codCarrier) { //CA
					//habilitar texto ingreso numero y ocultar link numero
					document.getElementById("divNumeracionTitulo").style["display"] = "";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					document.getElementById("divNumeracionInternet").style["display"] = "";		
					document.getElementById("procedenciaNumero").value = "E";
					document.forms[0].rdProcedenciaNumero[0].disabled = true;
					document.forms[0].rdProcedenciaNumero[1].checked = true;											
				}
				else {
					//ocultar seccion numero
					document.getElementById("divNumeracionTitulo").style["display"] = "none";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					document.getElementById("divNumeracionInternet").style["display"] = "none";	
				}
			}
			//(-) --------------- numeracion -------------------------
			
			//(+) ---------- servicios suplementarios ----------------
			if (indSS == "1"){
				//mostrar seccion SS
				document.getElementById("divSS").style["display"] = "";
			}else{
				//ocultar seccion SS
				document.getElementById("divSS").style["display"] = "none";				
			}
			//(-) ---------- servicios suplementarios ----------------
			
			//Tipo Seguro
			
			var codTipoCliente = document.getElementById("codTipoCliente").value;
			var codTipoClientePrepago = document.getElementById("codTipoClientePrepago").value;
					
			if (codTipoCliente == codTipoClientePrepago){
				document.getElementById("divDireccionPersonal").style["display"] = "none";
				document.getElementById("divDireccionInstalacion").style["display"] = "none";			
			}else{
				document.getElementById("divDireccionPersonal").style["display"] = "";
				//Direccion de instalacion
				if (indDirInstalacion=="1"){
					document.getElementById("divDireccionInstalacion").style["display"] = "";
				}else{
					document.getElementById("divDireccionInstalacion").style["display"] = "none";
				}
			}

			var flgSerieKit = document.getElementById("flgSerieKit");
			if (flgSerieKit.value =="1"){//oculta links de ingreso de series y numero
				document.getElementById("divEquipoTitulo").style["display"] = "";
				document.getElementById("divEquipoLinkSeguro").style["display"] = "";
				document.getElementById("divEquipoLink").style["display"] = "none";
				document.getElementById("divEquipo").style["display"] = "";
				document.getElementById("divNumeracionTitulo").style["display"] = "";				
				document.getElementById("divNumeracionLink").style["display"] = "none";
				document.getElementById("divNumeracion").style["display"] = "";		
				document.getElementById("divNumeracionInternet").style["display"] = "none";				
			}
			
			var flgSerieNumerada = document.getElementById("flgSerieNumerada");
			if (flgSerieNumerada.value =="1"){//oculta link de ingreso de numero
				document.getElementById("divNumeracionTitulo").style["display"] = "";				
				document.getElementById("divNumeracionLink").style["display"] = "none";
				document.getElementById("divNumeracion").style["display"] = "";		
				document.getElementById("divNumeracionInternet").style["display"] = "none";	
			}
			
	}//fin fncConfigPantallaSegunTipoPrestacion
	
	//(-) -- configuracion de pantalla segun tipo prestacion --
			 	
	 function fncBuscarSimcard(){
	 	 	if (ejecutandoAjax) return;
	 	 	
	 		if (fncVerificaParametrosSeries()){
	 		  	document.getElementById("opcion").value = "buscarSimcard";
	 		   	document.forms[0].submit();
	 		}
	 }
	 	
	 function fncBuscarEquipo(){
	 	 	if (ejecutandoAjax) return;
	 	 	
			if (fncVerificaParametrosSeries()){
	 	  		document.getElementById("opcion").value = "buscarEquipo";
	    		document.forms[0].submit();
	    	}
	 }
	
	function fncVerificaParametrosSeries(){
		var codTecnologia = document.getElementById("codTecnologia");
		var codTipoTerminal = document.getElementById("codTipoTerminal");
		var codUso = document.getElementById("codUsoLinea");
	
		if (codTecnologia.value ==""){
			alert("Debe Seleccionar Central");
			return false;
		}					
		if (codTipoTerminal.value == ""){
			alert("Debe Seleccionar Tipo Terminal");
			return false;
		}
		if (codUso.value == ""){
			alert("Debe Seleccionar Uso");
			return false;
		}
		
		return true;
	}
	
	function fncBuscarNumero(){
	
		if (ejecutandoAjax) return;
		 	
	 	if (fncVerificaParametrosNumeracion()){
	 	  	document.getElementById("opcion").value = "buscarNumero";
	    	document.forms[0].submit();
	    }
	}
	
	function fncVerificaParametrosNumeracion(){
		var codCelda = document.getElementById("codCelda");
		var codCentral = document.getElementById("codCentral");
		var codUso = document.getElementById("codUsoLinea");

		if (codCelda.value == ""){
			alert("Debe Seleccionar Celda");
			return false;
		}
		if (codCentral.value == ""){
			alert("Debe Seleccionar Central");
			return false;
		}		
		if (codUso.value == ""){
			alert("Debe Seleccionar Uso");
			return false;
		}
		
		return true;
	}
	
	 function fncServiciosSupl(){
	 
	 	if (ejecutandoAjax) return;
	 	 	
		if (fncVerificaParametrosSS()){
			document.getElementById("opcion").value = "serviciosSupl";
	    	document.forms[0].submit();
	    }
	 }	
	 
	function fncVerificaParametrosSS(){
		var codTecnologia = document.getElementById("codTecnologia");
	 	var codPlanTarif = document.getElementById("codPlanTarif");
			
		if (codTecnologia.value == ""){
			alert("Debe Seleccionar Central");
			return false;
		}		
		if (codPlanTarif.value == ""){
			alert("Debe Seleccionar Plan Tarifario");
			return false;
		}
		
		return true;
	}
	
	//(+) -- limpieza de controles por cambios en combos --
	//se ejecuta despues de limpiar numeracion, no antes
	function fncLimpiarSeries(){
		//anular reserva si corresponde
			var flgSerieKit = document.getElementById("flgSerieKit");
			var flgSerieNumerada = document.getElementById("flgSerieNumerada");
	
			if (flgSerieKit.value == "1" || flgSerieNumerada.value == "1"){
				var numSerie = document.getElementById("numSerie");
				if (numSerie.value!=""){
					JDatosLineaAJAX.anularReservaSimcard(numSerie.value,fncResultadoAnularReservaSimcard);
					document.getElementById("numSerie").value = "";
					document.getElementById("numEquipo").value = "";
					document.getElementById("codProcedenciaEquipo").value = "";
					document.getElementById("codArticuloEquipo").value = "";
					document.getElementById("glsArticuloEquipo").value = "";				
					document.getElementById("numCelular").value = "";
					//P-CSR-11002 JLGN 18-08-2011
					document.getElementById("btnBuscar").disabled = false;
					document.getElementById("flgSerieKit").value = "0";
					//P-CSR-11002 JLGN 18-10-2011
					document.getElementById("btnSinNumero").disabled = false;
				}
			
			}else{
				var numSerie = document.getElementById("numSerie");
				if (numSerie.value!=""){
					JDatosLineaAJAX.anularReservaSimcard(numSerie.value,fncResultadoAnularReservaSimcard);
					document.getElementById("numSerie").value = "";
				}
				
				var numEquipo = document.getElementById("numEquipo");
				if (numEquipo.value!=""){
					var codProcedenciaEquipo = document.getElementById("codProcedenciaEquipo");
					if (codProcedenciaEquipo.value =="0"){
						JDatosLineaAJAX.anularReservaEquipo(numEquipo.value,fncResultadoAnularReservaEquipo);
					}
					document.getElementById("numEquipo").value = "";
					document.getElementById("codProcedenciaEquipo").value = "";
					document.getElementById("codArticuloEquipo").value = "";
					document.getElementById("glsArticuloEquipo").value = "";
					//P-CSR-11002 JLGN 18-10-2011
					document.getElementById("btnSinNumero").disabled = false;						
				}
			}//fin else
	}
	
	function fncResultadoAnularReservaSimcard(data){
		if (data!=null){
			var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			//alert("Se ha anulado reserva de Simcard");
	    }
	}
	
	function fncResultadoAnularReservaEquipo(data){
		if (data!=null){
			var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			//alert("Se ha anulado reserva de Equipo");
	    }
	}
	
	function fncLimpiarNumeracion(){
		//anular reserva si corresponde
		var flgSerieKit = document.getElementById("flgSerieKit");
		var flgSerieNumerada = document.getElementById("flgSerieNumerada");
		if (flgSerieKit.value != "1" && flgSerieNumerada.value !="1"){ 
			var divNumeracion = document.getElementById("divNumeracion").style["display"]
			if (divNumeracion == ""){
				var numCelular = document.getElementById("numCelular");
				//Inicio P-CSR-11002 JLGN 19-08-2011
				var numAutomatico = document.getElementById("numCelular").value;
				var tablaNumeracion = document.getElementById("tablaNumeracion").value;
				var categoriaNumeracion = document.getElementById("categoriaNumeracion").value;
				
				//si ya se busco por numeracion automatica, se debe reponer numero anterior		
				if(numAutomatico != "" && tablaNumeracion != "" && categoriaNumeracion !=""){
					JDatosLineaAJAX.reponerNumeracionAutomatica(numAutomatico,tablaNumeracion,categoriaNumeracion, fncResultadoReponerNumeracionAutomatica );
					document.getElementById("numCelular").value = "";
					document.getElementById("btnBuscar").disabled = false;
				}else if (numCelular.value!="" ){ //Fin P-CSR-11002 JLGN 19-08-2011				
					JDatosLineaAJAX.anularReservaNumeracion(numCelular.value,fncResultadoAnularReservaNumeracion);
					document.getElementById("numCelular").value = "";
					//P-CSR-11002 JLGN 18-08-2011
					document.getElementById("btnBuscar").disabled = false;
				}
			}
		}
	}
	
	function fncResultadoAnularReservaNumeracion(data){
		if (data!=null){
			var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			//alert("Se ha anulado reserva de Numero Celular");
	    }
	}
	
	function fncLimpiarServiciosSuplementarios(){
		JDatosLineaAJAX.limpiarServiciosSuplementarios(fncResultadolimpiarServiciosSuplementarios);
	}
	
	function fncResultadolimpiarServiciosSuplementarios(data){
		if (data!=null){
			var resultado = data['resultado'];
			if (resultado == "1"){//existia lista de SS en sesion
				//alert("Se ha actualizado lista de servicios suplementarios");
			}
	    }
	}
	//(-) -- limpieza de controles --
	
	 function fncIngresarDireccionPersonal(){
	 
	 	if (ejecutandoAjax) return;
	 	
		 var direccionPersonal = document.getElementById("direccionPersonal");
		 var irADirecciones = true;
		 
		 if (direccionPersonal.value == ""){
			 var direccionInstalacion = document.getElementById("direccionInstalacion");
			 if (direccionInstalacion.value!=""){
				 var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Instalaci\u00F3n como Personal?");
				 if (confirmar){
					//copiar INST en PERS
					JDatosLineaAJAX.copiarDireccion("INST_USU","PERS_USU",fncDummy);
					document.getElementById("direccionPersonal").value = document.getElementById("direccionInstalacion").value;
					irADirecciones = false;
				}
			 }
		 }//fin if (direccionPersonal.value == "")
		 
 		if (irADirecciones){
		  	document.getElementById("opcion").value = "ingresarDireccionPersonal";
	    	document.forms[0].submit();
	    }
	 }	
	
	 function fncIngresarDireccionInstalacion(){
	 
	 	if (ejecutandoAjax) return;
	 
		 var direccionInstalacion = document.getElementById("direccionInstalacion");
		 var irADirecciones = true;
		 
		 if (direccionInstalacion.value == ""){
			 var direccionPersonal = document.getElementById("direccionPersonal");
			 if (direccionPersonal.value!=""){
				 var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Instalaci\u00F3n ?");
				 if (confirmar){
					//copiar PERS en INST
					JDatosLineaAJAX.copiarDireccion("PERS_USU","INST_USU",fncDummy);
					document.getElementById("direccionInstalacion").value = document.getElementById("direccionPersonal").value;
					irADirecciones = false;
				}
			 }
		 }//fin if (direccionPersonal.value == "")	 
		 
 		if (irADirecciones){	 
		  	document.getElementById("opcion").value = "ingresarDireccionInstalacion";
	    	document.forms[0].submit();
	    }
	 }
	 
	function codGrpPrestacion_onchange() {
		 ocultarMensajeError();
		 fncActivarDesacControlesGrupoPrestacion();
		 mostrarOcultarFilaLC();
	}
	
	function fncValidaMontoDecimal(campoTexto){
  		if (campoTexto.value!=""){
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)){
	  	  		alert("Monto inv\u00E1lido");
	  	  		campoTexto.value="";
	  	  		campoTexto.focus();
	  	  	}
		}
	}
	
	function fncValidaRangoLimite(campoMontoLimiteConsumo){
		var montoMinimo = parseFloat(document.getElementById("montoMinimo").value);
		var montoMaximo = parseFloat(document.getElementById("montoMaximo").value);
		var montoLimiteIngresado = parseFloat(campoMontoLimiteConsumo.value);
		
		if (montoLimiteIngresado < montoMinimo || montoLimiteIngresado > montoMaximo){
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
	
	var listaPlanesTarifarios = null;
	
	var grpPrestacionesSinLC = new Array(); //TV=TV Cable, IE=Internet. Seteados desde properties

	var tiposPlanTarifarioSinLC = new Array(); //3=Hibrido. Seteados desde properties

	function LCMandatorio() {
		if (grpPrestacionesLCMandatorio() == false) {
			return false;
		}
		else {
			if (tiposPlanTarifarioLCMandatorio() == false) {
				return false;
			}
		}
		return true;
	}
	
	function grpPrestacionesLCMandatorio() {
		var codGrpPrestacion = document.getElementById("codGrpPrestacion").value;
		if (codGrpPrestacion == "")	{
			return false;
		}
		for (var i = 0; i < grpPrestacionesSinLC.length; i++) {
			if (codGrpPrestacion == grpPrestacionesSinLC[i]) {
				return false;
			}
		}
		return true;
	}
	
	function tiposPlanTarifarioLCMandatorio() {
		var codPlanTarifario = document.getElementById("codPlanTarif").value;
		if (codPlanTarifario == "") {
			return false;
		}
		for (var i = 0; i < listaPlanesTarifarios.length; i++) {
	    	var cod = listaPlanesTarifarios[i]["codigoPlanTarifario"];
	    	var tip = parseInt(listaPlanesTarifarios[i]["tipoProducto"]);
	    	if (codPlanTarifario == cod) {
	    		for (var j = 0; j < tiposPlanTarifarioSinLC.length; j++) {
					if (tip == parseInt(tiposPlanTarifarioSinLC[j])) {
						return false;
					}
				}
    			break;
	    	}
	    }
		return true;
	}
	
	function fncValidaCampos() {
		if (document.getElementById("codGrpPrestacion").value=="")
		{
	  	   alert ("Debe seleccionar Grupo Prestaci\u00F3n");
	  	   return false;
		}
		  	
		if (document.getElementById("codTipoPrestacion").value=="")
		{
	  	   alert ("Debe seleccionar Tipo Prestaci\u00F3n");
	  	   return false;
		}

		if (document.getElementById("codRegion").value=="")
		{
	  	   alert ("Debe seleccionar Departamento");
	  	   return false;
		}

		if (document.getElementById("codProvincia").value=="")
		{
	  	   alert ("Debe seleccionar Municipio");
	  	   return false;
		}		

		if (document.getElementById("codCiudad").value=="")
		{
	  	   alert ("Debe seleccionar Canton");
	  	   return false;
		}

		if (document.getElementById("codCelda").value=="")
		{
	  	   alert ("Debe seleccionar Celda");
	  	   return false;
		}

		if (document.getElementById("codCentral").value=="")
		{
	  	   alert ("Debe seleccionar Central");
	  	   return false;
		}

		if (document.getElementById("codUsoLinea").value=="")
		{
	  	   alert ("Debe seleccionar Uso de la L\u00EDnea");
	  	   return false;
		}
		
		if (document.getElementById("codPlanTarif").value=="")
		{
	  	   alert ("Debe seleccionar Plan Tarifario");
	  	   return false;
		}		

		if (document.getElementById("codCreditoConsumo")!= null
			&& document.getElementById("codCreditoConsumo").value=="")
		{
	  	   alert ("Debe seleccionar Cr\u00E9dito de Consumo");
	  	   return false;
		}
		
		var codLimiteConsumo = document.getElementById("codLimiteConsumo");
		
		if (LCMandatorio() && codLimiteConsumo.value == "")
		{
	  	   	alert("Debe seleccionar L\u00EDmite de Consumo");
	  	   	return false;
		}
				
		if (document.getElementById("codTipoCliente").value != document.getElementById("codTipoClientePrepago").value) {
			if (LCMandatorio() && document.getElementById("montoLimiteConsumo").value==0)
			{
		  	   	alert ("Debe ingresar L\u00EDmite de Consumo");
		  	   	return false;
			}
		}
		
		if (document.getElementById("codPlanServicio").value=="")
		{
	  	   alert ("Debe seleccionar Plan de Servicio");
	  	   return false;
		}	
			
		if (document.getElementById("codGrupoCobroServ").value=="")
		{
	  	   alert ("Debe seleccionar Grupo Cobro Servicio");
	  	   return false;
		}					
		
		if (document.getElementById("codTipoTerminal").value=="")
		{
	  	   alert ("Debe seleccionar Tipo Terminal");
	  	   return false;
		}	
		/* P-CSR-11002 JLGN 25-05-2011		
		if (document.getElementById("codCausaDescuento").value=="")
		{
	  	   alert ("Debe seleccionar Causal de Descuento");
	  	   return false;
		}*/
		
		if ( document.getElementById("valorRefPorMinuto")!=null 
				&& document.getElementById("valorRefPorMinuto").value  == 0)
		{
	  	   alert ("Debe ingresar Valor Ref. X Minuto");
	  	   return false;
		}
		
		if (document.getElementById("codMoneda")!=null 
				&& document.getElementById("codMoneda").value=="")
		{
	  	   alert ("Debe seleccionar Moneda");
	  	   return false;
		}

		var divSimcard  = document.getElementById("divSimcard").style["display"];
		if (divSimcard == ""){
		  	if (document.getElementById("numSerie").value=="")
		  	{
		  	    alert("Debe ingresar Simcard");
		  	    return false;
		  	} 				
		}
		
		var divEquipo  = document.getElementById("divEquipo").style["display"];
		if (divEquipo == ""){
		  	if (document.getElementById("numEquipo").value=="")
		  	{
		  	    alert("Debe ingresar Equipo");
		  	    return false;
		  	} 				
		}
						
		var divNumeracion = document.getElementById("divNumeracion").style["display"]
		
		if (divNumeracion == "") {
		  	if (document.getElementById("numCelular").value=="") {
		  	    alert("Debe ingresar Numeraci\u00F3n");
		  	    return false;
		  	} 				
		}
		
		var divNumeracion = document.getElementById("divNumeracionInternet").style["display"];
		
		if (divNumeracion == "") {
		  	if (document.getElementById("numCelularInternet").value=="") {
		  	    alert("Debe ingresar Numeraci\u00F3n");
		  	    return false;
		  	} 				

		  	if (document.getElementById("procedenciaNumero").value=="") {
		  		//verificar si radio tiene valor
				var chekRDInterno  = document.forms[0].rdProcedenciaNumero[0].checked;
				var chekRDExterno  = document.forms[0].rdProcedenciaNumero[1].checked;
				if(chekRDInterno) {
					document.getElementById("procedenciaNumero").value = "I";
				}
				else if(chekRDExterno) {
					document.getElementById("procedenciaNumero").value = "E";
				}
				else {
			  	    alert("Debe indicar si N\u00FAmero es Interno o Externo");
			  	    return false;
			  	}
		  	} 
		}
		
		if (document.getElementById("nomUsuario").value=="") {
	  	   alert ("Debe ingresar Nombre de Usuario");
	  	   return false;
		}
		
		if (document.getElementById("tipoIdentificacionUsuario").value=="") {
	  	   alert ("Debe ingresar Tipo Identificaci\u00F3n del Usuario");
	  	   return false;
		}
		
		if (document.getElementById("apellido1").value=="") {
	  	    alert("Debe ingresar Primer Apellido del Usuario");
	  	    return false;
	  	}
	  	
  	 	if (document.getElementById("apellido2").value=="") {
	  	    alert("Debe ingresar Segundo Apellido del Usuario");
	  	    return false;
	  	}
	  	 
	  	if (document.getElementById("tipoIdentificacionUsuario").value=="") {
	  	    alert("Debe ingresar Tipo de Identificaci\u00F3n del Usuario");
	  	    return false;
	  	}
	  	
	  	//P-CSR-11002 JLGN 14-04-2011 
	  	/*if (document.getElementById("telefono").value=="") {
	  	    alert("Debe ingresar Tel\u00E9fono del Usuario");
	  	    return false;
		}*/
	  	 	  	
		var divDireccionPersonal = document.getElementById("divDireccionPersonal").style["display"];	
		
		if (divDireccionPersonal == "") {	  	 	  	
		  	 if (document.getElementById("direccionPersonal").value=="")
		  	 {
		  	    alert("Debe ingresar Direcci\u00F3n Personal");
		  	    return false;
		  	 } 
	  	}	
		
		var divDireccionInstalacion = document.getElementById("divDireccionInstalacion").style["display"];				

		if (divDireccionInstalacion == "") {
		  	if (document.getElementById("direccionInstalacion").value=="")
		  	{
		  	    alert("Debe ingresar Direcci\u00F3n de Instalaci\u00F3n");
		  	    return false;
		  	} 				
		}
		
		//y SS?????
		return true;
	}
  	
	function fncIngresarFrecuentes() {
	  	document.getElementById("opcion").value = "ingresarNumerosFrecuentes";
	   	document.forms[0].submit();
	}	
	
	function fncAgregarSolicitud() { 
	 	if (fncValidaCampos()) {
	 		var divNumeracion = document.getElementById("divNumeracionInternet").style["display"]
			if (divNumeracion == "") {
				document.getElementById("numCelular").value = document.getElementById("numCelularInternet").value;
			}
			//Inicio P-CSR-11002 JLGN 16-05-2011
			document.getElementById("codRegionAux").value = document.getElementById("codRegion").value;
			document.getElementById("codProvinciaAux").value = document.getElementById("codProvincia").value;
			document.getElementById("codCiudadAux").value = document.getElementById("codCiudad").value;
			//Fin P-CSR-11002 JLGN 16-05-2011
		 	document.getElementById("btnAgregar").disabled =true;
	 	  	document.getElementById("opcion").value = "agregarSolicitud";
	    	document.forms[0].submit();
	    }
	}
	 
	function fncFinalizarSolicitud() {
		document.getElementById("btnAnterior").disabled = true;			
		document.getElementById("btnAgregar").disabled = true;
		document.getElementById("btnFinalizar").disabled = true;			
		document.getElementById("opcion").value = "finalizarSolicitud";
	   	document.forms[0].submit();
	}
    	
	function fncVolver() {
		if (confirm("¿Desea volver al men\u00FA?")) {
			//invocar a funcion que limpie las series numeracion y ss
			fncLimpiarNumeracion(); //1
			fncLimpiarSeries(); //2
			fncLimpiarServiciosSuplementarios();
			///////////////
			var win = parent;
			win.fncActDesacMenu(false);
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}
	
	function fncAnterior() {
			var flgActivarBtnFinalizar = document.getElementById("flgActivarBtnFinalizar");
			if (flgActivarBtnFinalizar.value == "1"){
				var msgConfirm = "Se eliminar\u00E1 la informaci\u00F3n asociada a esta venta. ¿Desea Continuar?";
				if (!confirm(msgConfirm)) return false;
			}else{
				fncLimpiarNumeracion(); //1
				fncLimpiarSeries(); //2
				fncLimpiarServiciosSuplementarios();
			}
			
			document.getElementById("opcion").value = "anterior";
		   	document.forms[0].submit();
	}
		
	// Muestra formato NIT
	/*P-CSR-11002 JLGN 06-06-2011
	function fncCambiarLabelNIT(tipoIdent, label){
		if (tipoIdent.value==codigoNIT)	label.innerHTML = formatoNIT;
		else							label.innerHTML = "";
	}*/
  	// Muestra mensajes de error
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}	  
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncDummy(){}	
	
	function fncInvocarPaginaExpiraSesion() {
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
	        	if (codError == "-100") {
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
		ocultarMensajeError();
		fncSeleccionaUso(o);
		obtenerPlanesTarifarios();
		/*P-CSR-11002 JLGN 25-05-2011
		obtenerCausasDescuento();*/
		mostrarOcultarFilaLC();
		getListadoCampaniasVigentesXCodUso();
	}
	
	function codCampanaVigente_onchange(o) {
		ocultarMensajeError();
		document.getElementById("codCampanaVigenteSeleccionada").value = o.value;
	}
	
	//P-CSR-11002 JLGN 07/04/2011	
	function valNumeroIdentificacion (numIdent, tipoIdent){
		var e = window.event;		
		if (document.getElementById(tipoIdent).value == "01"){
			if(e.keyCode >= 48 && e.keyCode <= 57){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaIdentidad){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
		}else if (document.getElementById(tipoIdent).value == "02"){
			if(e.keyCode >= 48 && e.keyCode <= 57){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaJuridica){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
			
		}else{
			if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 65 && e.keyCode <= 90 || e.keyCode >= 97 && e.keyCode <= 122){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaOtras){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
		}
	}
	
	function limpiaNumeroIdentificacion(numIdent){
		document.getElementById(numIdent).value = "";
	}
	
	function irAPlanesAdicionales() {		
		//P-CSR-11002 JLGN 06-06-2011
		if (fncVerificaParametrosPA()){
			document.getElementById("opcion").value = "irAPlanesAdicionales";
		    document.forms[0].submit();
	    }	
	}
	
	//P-CSR-11002 JLGN 06-06-2011
	function fncVerificaParametrosPA(){
	 	var codPlanTarif = document.getElementById("codPlanTarif");

		if (codPlanTarif.value == ""){
			alert("Debe Seleccionar Plan Tarifario");
			return false;
		}		
		return true;
	}
	
	function fncSelecCelda(){
		document.getElementById("codCelda").selectedIndex = 1;		
	}
	
	function fncValidarPass(){
		document.getElementById("opcion").value = "validarPass";
		document.forms[0].submit();
	}
	
	//Inicio P-CSR-11002 JLGN  17-05-2011 JLGN 
	function fncObtienePTCalifi(){
		var flagReturn;
		if (document.getElementById("codGrpPrestacion").value == ""){
			alert("Debe Seleccionar Grupo Prestaci\u00F3n");
		  	flagReturn = false;
		}
		if (document.getElementById("codTipoPrestacion").value == ""){
			alert ("Debe seleccionar Tipo Prestaci\u00F3n");
		  	flagReturn = false;
		}
		if (document.getElementById("codUsoLinea").value == ""){
			alert("Debe Seleccionar Uso");
		  	flagReturn = false;
		}
		//Inicio P-CSR-11002 JLGN 16-08-2011
		if (document.getElementById("limiteCredito").value == ""){
			alert("Debe Ingresar Limite de Credito");
		  	flagReturn = false;
		}
		//Fin P-CSR-11002 JLGN 16-08-2011
		if (document.getElementById("codCalificacion").value == ""){
			alert ("Debe ingresar Calificaci\u00F3n");
		  	flagReturn = false;
		}
		
		if (flagReturn == false){
			fncCursorNormal();
			return false;
		}
		
		//Inicio P-CSR-11002 JLGN 17-08-2011
		document.getElementById("limiteCredito").disabled = true; 
		document.getElementById("codCalificacion").disabled = true;
		document.getElementById("btnCalificacion").disabled = true;
		document.getElementById("limiteCreditoIngresado").value = document.getElementById("limiteCredito").value;
		document.getElementById("codCalificacionIngresado").value = document.getElementById("codCalificacion").value;
		//Fin P-CSR-11002 JLGN 17-08-2011
		
		obtenerPlanesTarifarios();				
	}
	//Fin P-CSR-11002 JLGN  17-05-2011 JLGN 
	
	//Fin P-CSR-11002 JLGN
	
	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }		
    
    //P-CSR-11002 JLGN 01-07-2011
    function obtieneCargoPT(codPlanTarif){
		var flagCalcLC = "<bean:write name="flagCalcLC"/>";   	
		if (flagCalcLC =="true"){	
		    if (codPlanTarif.value != "") {
				JDatosLineaAJAX.getCargoPlanTarif(codPlanTarif.value, fncResultadoObtieneCargoPT);
			}
		}	
    }
    
    //P-CSR-11002 JLGN 04-07-2011
    function fncResultadoObtieneCargoPT(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        var cargoPT = data['cargoPT'];
	        //Valida que el cargo no sea menor a 0
	        var limiteDeCredito = "<bean:write name="datosClienteBuro2" property="limiteDeCredito"/>";		        
	        
	        //Inicio P-CSR-11002 JLGN 17-08-2011
	        if (flagMuestraCalificacion == "true"){
		        if(document.getElementById("divCalificacion").style["display"] == ""){
		        	limiteDeCredito = document.getElementById("limiteCredito").value;
		        }
		    }    
	        //Fin P-CSR-11002 JLGN 17-08-2011
	        
	        if((limiteDeCredito - cargoPT) < 0){
	        	mostrarMensajeError("El límite de crédito del cliente no alcanza para comprar la línea");
	        	document.getElementById("btnAgregar").disabled=true;	        	
	        	return;
	        }else{
	        	if(flagClienteExcepcionado == "true"){
					document.getElementById("btnAgregar").disabled = true;
				}else{
					document.getElementById("btnAgregar").disabled = false;
				}	        	
	        	return;
	        }
	    }//fin if (data!=null)
	}
	
	//Inicio P-CSR-11002 JLGN 03-08-2011
	function fncBuscarNumeroAutomatico(){
	
	var numAutomatico = document.getElementById("numCelular").value;
	var tablaNumeracion = document.getElementById("tablaNumeracion").value;
	var categoriaNumeracion = document.getElementById("categoriaNumeracion").value;
	
	//Inicio P-CSR-11002 JLGN 24-08-2011
	var codCelda = document.getElementById("codCelda");
	var codCentral = document.getElementById("codCentral");
	var codUso = document.getElementById("codUsoLinea");

	if (codCelda.value == ""){
		alert("Debe Seleccionar Celda");
		fncCursorNormal();
		return false;
	}
	if (codCentral.value == ""){
		alert("Debe Seleccionar Central");
		fncCursorNormal();
		return false;
	}		
	if (codUso.value == ""){
		alert("Debe Seleccionar Uso");
		fncCursorNormal();
		return false;
	}
	//Fin P-CSR-11002 JLGN 24-08-2011

	//si ya se busco por numeracion automatica, se debe reponer numero anterior		
	if(numAutomatico != "" && tablaNumeracion != "" && categoriaNumeracion != ""){
		JDatosLineaAJAX.reponerNumeracionAutomatica(numAutomatico,tablaNumeracion,categoriaNumeracion, fncResultadoReponerNumeracionAutomatica );
	}
	
	fncCursorEspera();
	JDatosLineaAJAX.obtenerNumeracionAutomatica(document.getElementById("codCelda").value,document.getElementById("codCentral").value,document.getElementById("codUsoLinea").value,document.getElementById("codSubAlm").value,fncResultadoObtenerNumeracionAutomatica);
	document.getElementById("btnBuscar").disabled=true;	
	}
	
	function fncResultadoReponerNumeracionAutomatica(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);	
	        	return;
	        }
	    }//fin if (data!=null)
	}
		
	function fncResultadoObtenerNumeracionAutomatica(data){		
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	document.getElementById("btnBuscar").disabled=false;
	        	fncCursorNormal();
	        	return;
	        }
	        
	        //obtener nombre tabla , categoria, y fecha de baja
	        document.getElementById("tablaNumeracion").value = data['tablaNumeracion'];
	        document.getElementById("categoriaNumeracion").value = data['categoria'];	        
	        document.getElementById("numCelular").value = data['numero'];      
	    }//fin if (data!=null)
	    fncCursorNormal();
	}
	//Fin P-CSR-11002 JLGN 03-08-2011
	
	//Inicio P-CSR-11002 JLGN 18-10-2011
	function fncSinNumeroEquipos(){
		fncCursorEspera();
		document.getElementById("numEquipo").value = "SIN NUMERO";
		document.getElementById("btnSinNumero").disabled = true;
		fncCursorNormal();
	}
	
	//P-CSR-11002 07-11-2011
	/*function fncValidaLineas(){
		if(window.event.clientX > 0 && window.event.clientY < 0){
			var flgActivarBtnFinalizar = document.getElementById("flgActivarBtnFinalizar");
			if (flgActivarBtnFinalizar.value == "1"){
				var msgConfirm = "Se eliminar\u00E1 la informaci\u00F3n asociada a esta venta. ¿Desea Continuar?";
				if (!confirm(msgConfirm)){
					flagCierraApli = false;
					return false;
				}else{
					flagCierraApli = true;
				} 
			}else{
				flagCierraApli = true;
				fncLimpiarNumeracion(); //1
				fncLimpiarSeries(); //2
				fncLimpiarServiciosSuplementarios();
			}			
			document.getElementById("opcion").value = "anterior";
		   	document.forms[0].submit();
		}   	
	}
	
	function fncCerrar(){
		if(window.event.clientX > 0 && window.event.clientY < 0){
			if(flagCierraApli = false){
				return false;
			}
		}			
	}
	// onkeydown="validarTeclas();" onbeforeunload="fncValidaLineas();" onunload="fncCerrar();">
	
	*/
	
--></script>

<style type="text/css">
.comboDatosLinea
{
	font-size: 10px;
	width: 92%;
}
</style>

</head>

<body onload="history.go(+1);fncInicio();" onpaste="return false;"
	onkeydown="validarTeclas();">
<html:form method="POST" action="/DatosLineaAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codProcedencia" styleId="codProcedencia" />
	<html:hidden property="codTipoPrestacionSeleccionada" styleId="codTipoPrestacionSeleccionada" />
	<html:hidden property="codNivel1Seleccionado" styleId="codNivel1Seleccionado" />
	<html:hidden property="codNivel2Seleccionado" styleId="codNivel2Seleccionado" />
	<html:hidden property="codNivel3Seleccionado" styleId="codNivel3Seleccionado" />
	<html:hidden property="codProvinciaSeleccionada" styleId="codProvinciaSeleccionada" />
	<html:hidden property="codCiudadSeleccionada" styleId="codCiudadSeleccionada" />
	<html:hidden property="codCeldaSeleccionada" styleId="codCeldaSeleccionada" />
	<html:hidden property="codCentralSeleccionada" styleId="codCentralSeleccionada" />
	<html:hidden property="codSubAlm" styleId="codSubAlm" />
	<html:hidden property="codUsoLineaSeleccionado" styleId="codUsoLineaSeleccionado" />
	<html:hidden property="codPlanTarifSeleccionado" styleId="codPlanTarifSeleccionado" />
	<html:hidden property="codPlanServicioSeleccionado" styleId="codPlanServicioSeleccionado" />
	<html:hidden property="codLimiteConsumoSeleccionado" styleId="codLimiteConsumoSeleccionado" />
	<html:hidden property="codTipoTerminalSeleccionado" styleId="codTipoTerminalSeleccionado" />
	<!--<html:hidden property="codCausaDescuentoSeleccionada" styleId="codCausaDescuentoSeleccionada"/> -->
	<html:hidden property="codCampanaVigenteSeleccionada" styleId="codCampanaVigenteSeleccionada" />
	<html:hidden property="codTecnologia" styleId="codTecnologia" />
	<html:hidden property="codProcedenciaEquipo" styleId="codProcedenciaEquipo" />
	<html:hidden property="codArticuloEquipo" styleId="codArticuloEquipo" />
	<html:hidden property="glsArticuloEquipo" styleId="glsArticuloEquipo" />
	<html:hidden property="flgMostrarFrecuentes" styleId="flgMostrarFrecuentes" />
	<html:hidden property="flgAplicaSeguro" styleId="flgAplicaSeguro" />
	<html:hidden property="codTipoCliente" styleId="codTipoCliente" />
	<html:hidden property="codTipoClientePrepago" styleId="codTipoClientePrepago" />
	<html:hidden property="codCentralDefault" styleId="codCentralDefault" />
	<html:hidden property="tipoRed" styleId="tipoRed" />
	<html:hidden property="indNumero" styleId="indNumero" />
	<html:hidden property="indDirInstalacion" styleId="indDirInstalacion" />
	<html:hidden property="indInvFijo" styleId="indInvFijo" />
	<html:hidden property="indSS" styleId="indSS" />
	<html:hidden property="indNumeroPiloto" styleId="indNumeroPiloto" />
	<html:hidden property="indNumeroCortoSMS" styleId="indNumeroCortoSMS" />
	<html:hidden property="codTelefoniaMovil" styleId="codTelefoniaMovil" />
	<html:hidden property="codTelefoniaFija" styleId="codTelefoniaFija" />
	<html:hidden property="codInternet" styleId="codInternet" />
	<html:hidden property="codCarrier" styleId="codCarrier" />
	<html:hidden property="procedenciaNumero" styleId="procedenciaNumero" />
	<html:hidden property="flgSerieKit" styleId="flgSerieKit" />
	<html:hidden property="flgSerieNumerada" styleId="flgSerieNumerada" />
	<html:hidden property="largoNumCelular" styleId="largoNumCelular" />
	<html:hidden property="flgActivarBtnFinalizar" styleId="flgActivarBtnFinalizar" />
	<html:hidden property="flgConsultaFinalizar" styleId="flgConsultaFinalizar" />
	<html:hidden property="codGrupoCobroServ" styleId="codGrupoCobroServ" />
	<html:hidden property="codCreditoConsumo" styleId="codCreditoConsumo" />
	<html:hidden property="montoMinimo" styleId="montoMinimo" />
	<html:hidden property="montoMaximo" styleId="montoMaximo" />
	<html:hidden property="flgCorte" styleId="flgCorte" />
	<html:hidden property="montoCons" styleId="montoCons" />
	<html:hidden property="flgConsultaPA" styleId="flgConsultaPA" />
	<html:hidden property="codRegionAux" styleId="codRegionAux" />
	<html:hidden property="codProvinciaAux" styleId="codProvinciaAux" />
	<html:hidden property="codCiudadAux" styleId="codCiudadAux" />
	<html:hidden property="flagCalificacion" styleId="flagCalificacion" />
	<!-- P-CSR-11002 JLGN 03-08-2011 -->
	<html:hidden property="tablaNumeracion" styleId="tablaNumeracion" />
	<html:hidden property="categoriaNumeracion" styleId="categoriaNumeracion" />
	<html:hidden property="limiteCreditoIngresado" styleId="limiteCreditoIngresado" />
	<html:hidden property="codCalificacionIngresado" styleId="codCalificacionIngresado" />
	
	<logic:iterate id="grupos" name="DatosLineaForm"
		property="grpPrestacionesSinLC">
		<script>
		var item = '<bean:write name="grupos"/>';
		grpPrestacionesSinLC.push(item);	
	</script>
	</logic:iterate>

	<logic:iterate id="planes" name="DatosLineaForm"
		property="tiposPlanTarifarioSinLC">
		<script>
		var item = '<bean:write name="planes"/>';
		tiposPlanTarifarioSinLC.push(item);	
	</script>
	</logic:iterate>

	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif"
				width="15" height="15" hspace="2" align="left">DATOS LINEA
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="mensajeError">
				<bean:write name="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="96%">
		<tr>
			<td width="100%">

			<table width="100%">

				<tr>
					<td>

					<table width="100%">
						<tr>
							<td align="left" colspan="4">
							<h3>Home de L&iacute;nea (<font
								style="color: #78B454; font-weight: bold; text-align: left;">Líneas:
							<bean:write name="DatosLineaForm" property="cantidadLineas" /></font>)</h3>
							</td>
						</tr>
						<tr>
							<td align="left" width="18%">Grupo Prestaci&oacute;n (*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codGrpPrestacion"
								styleId="codGrpPrestacion" style="width: 92%;"
								onchange="codGrpPrestacion_onchange()">
								<html:option value="">- Seleccione -</html:option>
								<logic:notEmpty name="DatosLineaForm"
									property="arrayGrpPrestacion">
									<html:optionsCollection property="arrayGrpPrestacion"
										value="codGrupoPrestacion" label="desGrupoPrestacion" />
								</logic:notEmpty>
							</html:select></td>
							<td align="left" width="18%">Tipo Prestaci&oacute;n (*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codTipoPrestacion"
								style="width: 92%;" styleId="codTipoPrestacion"
								onchange="ocultarMensajeError();fncSeleccionaTiposPrestacion(this);fncObtenerNivel1();fncObtenerUsos();fncSelecCelda();fncSeleccionaCelda();fncObtenerCentrales();">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
						</tr>

					</table>
					<!-- Se ocultan niveles de prestación. Quitar display: none para mostrar -->
					<table id="nivelesPrestacion" width="100%" style="display: none">
						<tr>
							<td align="left" width="18%">Nivel 1</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codNivel1" style="width: 92%;"
								styleId="codNivel1"
								onchange="ocultarMensajeError();fncSeleccionaNivel1(this);fncObtenerNivel2();">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<td align="left" width="18%">Nivel 2</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codNivel2" style="width: 92%;"
								styleId="codNivel2"
								onchange="ocultarMensajeError();fncSeleccionaNivel2(this);fncObtenerNivel3();">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
						</tr>
						<tr>
							<td align="left" width="18%">Nivel 3</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codNivel3" style="width: 92%;"
								styleId="codNivel3"
								onchange="ocultarMensajeError();fncSeleccionaNivel3(this);">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<td></td>
							<td></td>
						</tr>
					</table>
					<table width="100%">

						<!--  P-CSR-11002 JLGN 25-05-2011
    <bean:define id="aplicaRenovacion" name="DatosLineaForm" type="java.lang.String" property="aplicaRenovacion"/>
	<logic:equal value="1" name="aplicaRenovacion" >
	<tr>
		<td align="left" width="18%">Renovaci&oacute;n</td>
        <td align="left" width="32%">
        <html:select name="DatosLineaForm" property="codRenovacion" style="width: 92%;" styleId="codRenovacion" onchange="ocultarMensajeError();obtenerPlanesTarifarios();">
			<html:option value="0">- Seleccione -</html:option>
			<html:option value="1">SI</html:option> 
			<html:option value="0">NO</html:option>   					
		</html:select>	 	
        </td> 
        <td></td>
        <td></td>
	</tr>
	</logic:equal>
	-->

						<tr>
							<!--  <td align="left" width="18%">Departamento (*)</td> P-CSR-11002 JLGN 11-05-2011-->
							<td align="left" width="18%"><bean:write
								name="provinciaVenta" /> (*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codRegion" style="width: 92%;"
								styleId="codRegion"
								onchange="ocultarMensajeError();fncObtenerProvincia();">
								<html:option value="">- Seleccione -</html:option>
								<logic:notEmpty name="DatosLineaForm" property="arrayRegiones">
									<html:optionsCollection property="arrayRegiones" value="codigo"
										label="descripcion" />
								</logic:notEmpty>
							</html:select></td>
							<!--  <td align="left" width="18%">Municipio (*)</td> P-CSR-11002 JLGN 11-05-2011-->
							<td align="left" width="18%"><bean:write name="cantonVenta" />
							(*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codProvincia"
								style="width: 92%;" styleId="codProvincia"
								onchange="ocultarMensajeError();fncSeleccionaProvincia(this);fncObtenerCiudad();">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
						</tr>
						<tr>


							<bean:define id="codOperadoraSalvador" name="DatosLineaForm"
								property="codOperadoraSalvador" type="java.lang.String" />
							<logic:notEqual name="DatosLineaForm" property="codOperadora"
								value="<%= codOperadoraSalvador %>">
								<!-- <td align="left">Zona (*)</td> P-CSR-11002 JLGN 11-05-2011-->
								<td align="left"><bean:write name="distritoVenta" /> (*)</td>
							</logic:notEqual>
							<logic:equal name="DatosLineaForm" property="codOperadora"
								value="<%= codOperadoraSalvador %>">
								<td align="left">Cant&oacute;n (*)</td>
							</logic:equal>

							<td align="left"><html:select name="DatosLineaForm"
								property="codCiudad" style="width: 92%;" styleId="codCiudad"
								onchange="ocultarMensajeError();fncSeleccionaCiudad(this);fncObtenerCeldas()">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<td align="left">Celda (*)</td>
							<td align="left"><html:select name="DatosLineaForm"
								property="codCelda" style="width: 92%;" styleId="codCelda"
								onchange="ocultarMensajeError();fncSeleccionaCelda();fncObtenerCentrales();">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
						</tr>
						<tr>
							<td align="left">Central (*)</td>
							<td align="left"><html:select name="DatosLineaForm"
								property="codCentral" style="width: 92%;" styleId="codCentral"
								onchange="ocultarMensajeError();fncSeleccionaCentral(this);obtenerTiposTerminal();obtenerPlanesServicio();">
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
					</td>
				</tr>

				<!-- Inicio P-CSR-11002 JLGN 16-05-2011 -->
				<logic:equal name="DatosLineaForm" property="flagExisteClienteBuro"
					value="true">
					<tr>
						<td>
						<table width="100%">
							<tr>
								<td align="left" colspan="4"
									style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
								Datos Clasificaci&oacute;n:</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td>
						<table width="100%">
							<tr>
								<td align="left" width="18%">Password</td>
								<td align="left" width="32%"><html:password
									name="DatosLineaForm" style="width: 92%"
									styleId="passCalificacion" property="passCalificacion"
									size="37" maxlength="20" /></td>
								<td width="18%"><html:button value="VALIDAR"
									property="btnValidar" style="width:70px;color:black"
									styleId="btnValidar"
									onclick="fncCursorEspera();ocultarMensajeError();fncValidarPass();" />
								</td>
								<td width="32%"></td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td>
						<div id="divCalificacion" style="display:none">
						<table width="100%">
							<!-- Inicio P-CSR-11002 JLGN 16-08-2011 -->
							<tr>
								<td align="left" width="18%">Limite de Credito</td>
								<td align="left" width="32%"><html:text
									name="DatosLineaForm" property="limiteCredito"
									styleId="limiteCredito"
									style="text-transform: uppercase; width: 92%"
									onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
									size="37" maxlength="30" onchange="ocultarMensajeError();" /></td>
								<td width="30%"></td>
								<td width="20%"></td>
							</tr>
							<!-- Fin P-CSR-11002 JLGN 16-08-2011 -->
							<tr>
								<td align="left" width="18%">Calificaci&oacute;n</td>
								<td align="left" width="32%"><html:text
									name="DatosLineaForm" property="codCalificacion"
									styleId="codCalificacion"
									style="text-transform: uppercase; width: 92%"
									onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
									size="37" maxlength="5" onchange="ocultarMensajeError();" /></td>
								<td width="30%"><html:button
									value="OBTIENE PLANES TARIFARIOS" property="btnCalificacion"
									style="width:224px;color:black" styleId="btnCalificacion"
									onclick="fncCursorEspera();ocultarMensajeError();fncObtienePTCalifi();" />
								</td>
								<td width="20%"></td>
							</tr>
							<tr>
							<td align="left" width="18%"></td>
							<td align="left" width="32%"><i>Cliente Excepcionado solo se le puede vender una linea</i></td>
							<td width="30%"></td>
							<td width="20%"></td>
							</tr>
						</table>
						</div>
					<tr>
						<td colspan="4">
						<HR noshade>
						</td>
					</tr>
					</td>
					</tr>

				</logic:equal>
				<!-- Fin P-CSR-11002 JLGN 16-05-2011 -->

				<tr>
					<td>
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Datos Comerciales:</td>
						</tr>
						<tr>
							<td align="left" width="18%">Uso de la L&iacute;nea (*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codUsoLinea" style="width: 92%;"
								styleId="codUsoLinea" onchange="codUsoLinea_onchange(this)">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<td align="left" width="18%">Tipo de Terminal (*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codTipoTerminal"
								style="width: 92%;" styleId="codTipoTerminal"
								onchange="ocultarMensajeError();fncSeleccionaTipoTerminal(this);">
								<!-- P-CSR-11002 JLGN 28-07-2011-->
								<!-- onchange="ocultarMensajeError();fncSeleccionaTipoTerminal(this);"> -->
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
						</tr>
						<tr>

							<td align="left">Filtro Plan Tarifario</td>
							<td align="left"><html:select name="DatosLineaForm"
								disabled="true" property="filtroPlan" style="width: 92%;"
								styleId="filtroPlan"
								onchange="ocultarMensajeError();obtenerPlanesTarifarios()">
								<html:option value="">- Todos -</html:option>
								<html:option value="DIS">DISTRIBUIBLES</html:option>
							</html:select></td>
							<td align="left">Plan Tarifario (*) <bean:define
								id="flgMostrarFrecuentes" name="DatosLineaForm"
								property="flgMostrarFrecuentes" /> <logic:equal
								name="flgMostrarFrecuentes" value="S">
								<a href="javascript:fncIngresarFrecuentes();"><FONT
									color="#0000ff">Agregar Frecuentes</FONT></a>
							</logic:equal></td>
							<!--Inicio P-CSR-11002 JLGN 05-07-2011 -->
							<bean:define id="prepago" name="DatosLineaForm"
								property="codTipoClientePrepago" type="java.lang.String" />
							<logic:equal name="DatosLineaForm" property="codTipoCliente"
								value="<%= prepago %>">
								<td align="left"><html:select name="DatosLineaForm"
									property="codPlanTarif" styleId="codPlanTarif"
									styleClass="comboDatosLinea"
									onchange="ocultarMensajeError();fncSeleccionaPlanTarif(this);obtenerPlanesServicio();obtenerLimitesConsumo();">
									<html:option value="">- Seleccione -</html:option>
								</html:select></td>
							</logic:equal>
							<logic:notEqual name="DatosLineaForm" property="codTipoCliente"
								value="<%= prepago %>">
								<td align="left"><html:select name="DatosLineaForm"
									property="codPlanTarif" styleId="codPlanTarif"
									styleClass="comboDatosLinea"
									onchange="ocultarMensajeError();fncSeleccionaPlanTarif(this);obtieneCargoPT(this);obtenerPlanesServicio();obtenerLimitesConsumo();">
									<html:option value="">- Seleccione -</html:option>
								</html:select></td>
							</logic:notEqual>
							<!--Fin P-CSR-11002 JLGN 05-07-2011 -->
						</tr>
						<bean:define id="prepago" name="DatosLineaForm"
							property="codTipoClientePrepago" type="java.lang.String" />
						<logic:equal name="DatosLineaForm" property="codTipoCliente"
							value="<%= prepago %>">
							<tr>
								<td align="left">L&iacute;mite de Consumo (*)</td>
								<td align="left"><html:select name="DatosLineaForm"
									property="codLimiteConsumo" styleId="codLimiteConsumo"
									styleClass="comboDatosLinea"
									onchange="ocultarMensajeError();fncSeleccionaLimiteConsumo(this);">
									<html:option value="">- Seleccione -</html:option>
								</html:select></td>
								<td colspan="3" align="left"><html:hidden
									property="montoLimiteConsumo" styleId="montoLimiteConsumo" />
								<div id="divLbMontoLimiteConsumo" style="display:none"><label
									for="montoLimiteConsumo" id="lbMontoLimiteConsumo"></label></div>
								</td>
							</tr>
						</logic:equal>
						<logic:notEqual name="DatosLineaForm" property="codTipoCliente"
							value="<%= prepago %>">

							<tr id="filaLC" style="display: none;">
								<td align="left">L&iacute;mite de Consumo (*)</td>
								<td align="left"><html:select name="DatosLineaForm"
									property="codLimiteConsumo" styleId="codLimiteConsumo"
									styleClass="comboDatosLinea"
									onchange="ocultarMensajeError();fncSeleccionaLimiteConsumo(this);">
									<html:option value="">- Seleccione -</html:option>
								</html:select></td>
								<td align="left" rowspan="2" valign="top"><html:text
									name="DatosLineaForm" property="montoLimiteConsumo"
									styleId="montoLimiteConsumo" readonly="true" size="20"
									maxlength="15" onkeypress="onlyFloat(this.value,4)"
									onblur="fncValidaMontoDecimal(this);fncValidaRangoLimite(this);"
									onchange="ocultarMensajeError();" /> <BR>
								<b><label for="montoLimiteConsumo" id="lbMontoLimiteConsumo"></label></b>
								</td>
								<td rowspan="2" valign="top" align="left"><b>Segmento:
								</b><bean:write name="DatosLineaForm" property="descripcionSegmento" /><BR>
								<b>Color: </b><bean:write name="DatosLineaForm"
									property="descripcionColor" /></td>
							</tr>

						</logic:notEqual>

						<tr>
							<td align="left">Plan de Servicio (*)</td>
							<td align="left"><html:select name="DatosLineaForm"
								property="codPlanServicio" styleId="codPlanServicio"
								style="width: 92%;"
								onchange="ocultarMensajeError();fncSeleccionaPlanServicio(this);">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td align="left" width="18%">Campa&ntilde;as Vigentes</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="codCampanaVigente"
								styleId="codCampanaVigente" style="width: 92%;"
								onchange="codCampanaVigente_onchange(this)">
								<html:option value="">- Seleccione -</html:option>
							</html:select></td>
							<logic:equal name="esPrepagoBuro" value="true">
									<td align="left" width="18%"><b>Limite de Credito del Cliente: </b></td>
									<td align="left" width="18%"><bean:write name="datosClienteBuro2" property="limiteDeCredito" />&nbsp;<b>Colones</b></td>
							</logic:equal>
							<logic:notEqual name="esPrepagoBuro" value="true">
								<td align="left" width="18%">
							</logic:notEqual>
							<td align="left" width="32%"></td>
						</tr>
						<tr>
							<td align="left" width="18%"></td>
							<td align="left" width="32%"></td>
							<logic:equal name="esPrepagoBuro" value="true">
								<td align="left" width="18%"><b>Calificaci&oacute;n del
								Cliente: </b><bean:write name="datosClienteBuro2"
									property="resulCalificacion" /></b><BR>
								</td>
							</logic:equal>
							<logic:notEqual name="esPrepagoBuro" value="true">
								<td align="left" width="18%">
							</logic:notEqual>
							<td align="left" width="32%"></td>
						</tr>
						<!-- P-CSR-11002 JLGN 25-05-2011 
     <tr>        
         <td align="left">Causal de Descuento (*)</td>
         <td align="left">
     		<html:select name="DatosLineaForm" property="codCausaDescuento" styleId="codCausaDescuento" style="width: 92%;" onchange="ocultarMensajeError();fncSeleccionaCausaDescuento(this);"> 
				<html:option value="">- Seleccione -</html:option>
 	     	</html:select>         
         </td>
         <td></td>
         <td></td> 
     </tr> 
	-->
						<bean:define id="codOperadoraSalvador" name="DatosLineaForm"
							property="codOperadoraSalvador" type="java.lang.String" />
						<logic:equal name="DatosLineaForm" property="codOperadora"
							value="<%= codOperadoraSalvador %>">

							<bean:define id="prepago" name="DatosLineaForm"
								property="codTipoClientePrepago" type="java.lang.String" />
							<logic:notEqual name="DatosLineaForm" property="codTipoCliente"
								value="<%= prepago %>">
								<tr>
									<td align="left">Valor Ref. X Minuto (*)</td>
									<td align="left"><html:text name="DatosLineaForm"
										property="valorRefPorMinuto" styleId="valorRefPorMinuto"
										size="37" maxlength="15" onkeypress="onlyFloat(this.value,4)"
										onblur="fncValidaMontoDecimal(this);"
										onchange="ocultarMensajeError();" /></td>
									<td align="left">Moneda (*)</td>
									<td align="left"><html:select name="DatosLineaForm"
										property="codMoneda" styleId="codMoneda" style="width: 92%;"
										onchange="ocultarMensajeError();">
										<html:option value="">- Seleccione -</html:option>
										<logic:notEmpty name="DatosLineaForm" property="arrayMonedas">
											<html:optionsCollection property="arrayMonedas"
												value="codigo" label="descripcion" />
										</logic:notEmpty>
									</html:select></td>
								</tr>
							</logic:notEqual>

						</logic:equal>

						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divSimcardTitulo" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Datos Simcard:</td>
						</tr>
					</table>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divSimcardLink" style="display:none">
					<table width="100%">
						<tr>
							<td align="left"><a href="javascript:fncBuscarSimcard();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Buscar Simcard</FONT></a></td>
						</tr>
					</table>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divSimcard" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%">N&uacute;mero de Serie(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" style="width: 92%" styleId="numSerie"
								property="numSerie" size="37" readonly="true" /></td>
							<td width="18%"></td>
							<td width="32%"></td>
						</tr>
						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divEquipoTitulo" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Datos Equipo:</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divEquipoLinkSeguro" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="50%" colspan="2">
							<div id="divEquipoLink" style="display: none;">
							<table width="100%">
								<tr>
									<td><a href="javascript:fncBuscarEquipo();"
										onclick="fncCursorEspera();ocultarMensajeError();"><FONT
										color="#0000ff">Buscar Equipo</FONT></a></td>
								</tr>
							</table>
							</div>
							</td>
							</td>
							<!-- P-CSR-11002 JLGN 25-05-2011 
        <td align="left" width="18%">Tipo de Seguro</td>
        <td align="left" width="32%" >
        	<html:select name="DatosLineaForm" property="codTipoSeguro" styleId="codTipoSeguro" style="width: 92%;" onchange="ocultarMensajeError();fncObtieneVigenciaSeguro(this);"> 
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosLineaForm" property="arrayTiposSeguro">
	              <html:optionsCollection property="arrayTiposSeguro" value="codSeguro" label="desSeguro"/>
	          	</logic:notEmpty>				
 	     	</html:select>
		</td> 
		-->
						</tr>
					</table>
					</div>
					</td>
				</tr>



				<tr>
					<td>
					<div id="divEquipo" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%">N&uacute;mero del Equipo(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" property="numEquipo" styleId="numEquipo"
								size="37" style="width: 92%" readonly="true" /></td>
							<td align="left" width="18%">
							<!-- Inicio P-CSR-11002 JLGN 18-10-2011 -->
								<html:button  value="SIN NUMERO DE EQUIPO" style="width:185px;color:black" property="btnSinNumero" styleId="btnSinNumero" onclick="fncCursorEspera();ocultarMensajeError();fncSinNumeroEquipos();"/>
							<!-- Fin P-CSR-11002 JLGN 18-10-2011 -->
							</td>
							<td align="left" width="32%"></td>
							<!-- P-CSR-11002 JLGN 25-05-2011 
        <td align="left" width="18%">Vigencia Seguro</td>
        <td align="left" width="32%">
			<html:text name="DatosLineaForm" property="vigenciaSeguro" styleId="vigenciaSeguro" size="37" style="width: 92%" readonly="true"/>
		</td>   
		-->
						</tr>
						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divNumeracionTitulo" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Numeraci&oacute;n:</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divNumeracionLink" style="display:none">
					<table width="100%">
						<tr>
							<td align="left"><a href="javascript:fncBuscarNumero();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Buscar N&uacute;mero</FONT></a></td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divNumeracion" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%">N&uacute;mero de Celular(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" property="numCelular" styleId="numCelular"
								size="37" maxlength="20" style="width: 92%" readonly="true" /></td>
							<td align="left" width="18%">
							<!-- Inicio P-CSR-11002 JLGN 03-08-2011 -->
							<html:button  value="BUSCAR NUMERO" style="width:136px;color:black" property="btnBuscar" styleId="btnBuscar" onclick="fncCursorEspera();ocultarMensajeError();fncBuscarNumeroAutomatico();"/>
							<!-- Fin P-CSR-11002 JLGN 03-08-2011 -->
							</td>
							<td align="left" width="32%">
						</tr>
						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divNumeracionInternet" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%">N&uacute;mero de
							Tel&eacute;fono(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" property="numCelularInternet"
								styleId="numCelularInternet" style="width: 92%" size="37"
								maxlength="20" onkeypress="onlyInteger();"
								onblur="fncValidarNumeroInternet();"
								onchange="ocultarMensajeError();" /></td>
							<td width="18%" align="left"><html:radio
								name="DatosLineaForm" property="rdProcedenciaNumero"
								styleId="rdProcedenciaNumero" value="I"
								onclick="ocultarMensajeError();fncSeleccionaProcedenciaNumero(this);fncValidarNumeroInternet();">Interno&nbsp;&nbsp;</html:radio>
							<html:radio name="DatosLineaForm" property="rdProcedenciaNumero"
								styleId="rdProcedenciaNumero" value="E"
								onclick="ocultarMensajeError();fncSeleccionaProcedenciaNumero(this);fncValidarNumeroInternet();">Externo</html:radio>
							</td>
							<td width="32%">&nbsp;</td>
						</tr>
						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>


				<tr>
					<td>
					<div id="divSS" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Servicios:</td>
						</tr>
						<tr>
							<td align="left" colspan="4"><a
								href="javascript:fncServiciosSupl();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Servicios Suplementarios</FONT></a></td>
						</tr>
						<tr>
							<td colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					<table width="100%">
						<tr>
							<td align="left" colspan="4">
							<h3>Planes Adicionales:</h3>
							</td>
						</tr>
						<tr>
							<td align="left" colspan="4"><a
								href="javascript:irAPlanesAdicionales();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Planes Adicionales</FONT></a></td>
						</tr>
						<tr>
							<td align="left" colspan="4">
							<HR noshade>
							</td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<table width="100%">
						<tr>
							<td align="left" colspan="4"
								style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
							Datos Usuario:</td>
						</tr>
						<tr>
							<td align="left" width="18%">Nombre Usuario(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" property="nomUsuario" styleId="nomUsuario"
								style="text-transform: uppercase; width: 92%;"
								onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
								size="37" maxlength="50" onchange="ocultarMensajeError();" /></td>
							<td align="left" width="18%">Tipo Identificación(*)</td>
							<td align="left" width="32%"><html:select
								name="DatosLineaForm" property="tipoIdentificacionUsuario"
								styleId="tipoIdentificacionUsuario" style="width: 92%;"
								onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacionUsuario');">
								<html:option value="">- Seleccione -</html:option>
								<logic:notEmpty name="DatosLineaForm"
									property="arrayIdentificadorUsuario">
									<html:optionsCollection property="arrayIdentificadorUsuario"
										value="codigoTipIdentif" label="descripcionTipIdentif" />
								</logic:notEmpty>
							</html:select></td>
						</tr>
						<tr>
							<td align="left" width="18%">Apellido 1 (*)</TD>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm"
								style="text-transform: uppercase; width: 92%;"
								styleId="apellido1" property="apellido1"
								onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
								size="37" maxlength="20" onchange="ocultarMensajeError();" /></td>
							<td align="left" width="18%">N&uacute;m. Identif.(*)</td>
							<td align="left" width="32%"><html:text
								name="DatosLineaForm" property="numeroIdentificacionUsuario"
								size="37" maxlength="20"
								style="text-transform: uppercase; width: 92%;"
								styleId="numeroIdentificacionUsuario" onblur="upperCase(this);"
								onchange="ocultarMensajeError();"
								onkeypress="soloCaracteresValidos(); valNumeroIdentificacion('numeroIdentificacionUsuario','tipoIdentificacionUsuario');" />
							&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionUsuario"
								id="lbNumeroIdentificacionUsuario" class="textoAzul"></label></td>
						</tr>
						<tr>
							<td align="left">Apellido 2 (*)</td>
							<td align="left"><html:text name="DatosLineaForm"
								style="text-transform: uppercase; width: 92%;"
								property="apellido2" styleId="apellido2"
								onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
								size="37" maxlength="20" onchange="ocultarMensajeError();" /></td>
							<td align="left">Tel&eacute;fono</td>
							<td align="left"><html:text name="DatosLineaForm"
								property="telefono" styleId="telefono"
								style="text-transform: uppercase; width: 92%"
								onkeypress="onlyInteger();" size="37" maxlength="15"
								onchange="ocultarMensajeError();" /></td>
						</tr>

					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divDireccionPersonal" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%"><a
								href="javascript:fncIngresarDireccionPersonal();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Direcci&oacute;n Personal(*)</FONT></a></td>
							<td align="left" colspan="3"><html:text
								name="DatosLineaForm" property="direccionPersonal"
								styleId="direccionPersonal" size="130" readonly="true"
								maxlength="80" /></td>
						</tr>
					</table>
					</div>
					</td>
				</tr>

				<tr>
					<td>
					<div id="divDireccionInstalacion" style="display:none">
					<table width="100%">
						<tr>
							<td align="left" width="18%"><a
								href="javascript:fncIngresarDireccionInstalacion();"
								onclick="fncCursorEspera();ocultarMensajeError();"><FONT
								color="#0000ff">Direcci&oacute;n de Instalaci&oacute;n(*)</FONT></a>
							</td>
							<td align="left" colspan="3"><html:text
								name="DatosLineaForm" property="direccionInstalacion"
								styleId="direccionInstalacion" size="130" readonly="true"
								maxlength="80" /></td>
						</tr>
					</table>
					</div>
					</td>
				</tr>
				<!-- P-CSR-11002 JLGN 25-05-2011 
	<tr>	
	<td>	
	<table width="100%">  
		<tr>
		   <td align="left" width="18%">Instancia</td> 
		   <td align="left" width="32%">
				<html:text maxlength="50" name="DatosLineaForm" property="observacion" styleId="observacion" style="text-transform: uppercase; width: 100%;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
		   </td>
		   <td width="18%"></td>
		   <td width="32%"></td>
		</tr>
	</table>
    </td>    	
    </tr>
    -->
			</table>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>
			<TABLE cellSpacing=0 cellPadding=0 width="94%" border=0 align=center>
				<tr>
					<td align="left" width="25%"><html:button
						property="btnAnterior" value="<<" style="
						width:120px;color:black" styleId="btnAnterior"
						onclick="fncCursorEspera();ocultarMensajeError();fncAnterior();" />
					</td>
					<td align="left" width="25%"><!--  <input type="button" name="btnVolver" value="VOLVER AL MENU" onclick="ocultarMensajeError();fncVolver();" style="width:150px;color:black">   -->
					</td>
					<td align="right" width="25%"><html:button
						value="AGREGAR LINEA A SOLICITUD" property="btnAgregar"
						style="width:180px;color:black" styleId="btnAgregar"
						onclick="fncCursorEspera();ocultarMensajeError();fncAgregarSolicitud()" />
					</td>
					<td align="right" width="25%"><logic:equal
						name="DatosLineaForm" property="flgActivarBtnFinalizar" value="1">
						<html:button value="FINALIZAR SOLICITUD" property="btnFinalizar"
							style="width:170px;color:black" styleId="btnFinalizar"
							onclick="fncCursorEspera();ocultarMensajeError();fncFinalizarSolicitud()" />
					</logic:equal> <logic:equal name="DatosLineaForm"
						property="flgActivarBtnFinalizar" value="0">
						<html:button value="FINALIZAR SOLICITUD" property="btnFinalizar"
							style="width:170px;color:black" styleId="btnFinalizar"
							disabled="true" />
					</logic:equal></td>
				</tr>
			</TABLE>
			</td>
		</tr>
	</table>

	<P>
	<TABLE align="center" width="92%">
		<tr>
			<td align="left"><i>(*): Dato es obligatorio</i></td>
		</tr>
	</TABLE>
</html:form>

</body>
</html:html>
