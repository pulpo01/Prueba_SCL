<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.or	g/TR/html4/loose.dtd">

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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JAltaClienteInicioAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ejecutandoAjax = false;
	var cambiaValorDefecto = false;
	var ultimoObjetoFoco;
	var validandoIdentificacion=false;	
	/*P-CSR-11002 JLGN 03-06-2011
	var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";*/
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";
	var flagDataBuro = "<bean:write name="flagDataBuro"/>";
	var flagOKBuro = "<bean:write name="flagOKBuro"/>";
	var botonPass = "<bean:write name="botonPass"/>";
	var flagPass = "<bean:write name="flagPass"/>";
	var cicloEmpresa = "<bean:write name="cicloFacturEmpre"/>";
	var cicloParticular = "<bean:write name="cicloFacturParti"/>";	
	//P-CSR-11002 JLGN 28-07-2011
	var flagLimCred = "<bean:write name="flagLimCred"/>";	
	//P-CSR-11002 JLGN 04-08-2011
	var mensajeErrorBuro = "<bean:write name="mensajeErrorBuro"/>";
	//Inicio Inc.179734 09-01-2012 JLGN 
	var flagDDA = "<bean:write name="datosClienteBuroDDA" property="flagDDA"/>";	
	//Fin Inc.179734 09-01-2012 JLGN 
	
	function fncInicio() {
			
			var tipoCliente = document.getElementById("tipoCliente");
			if (tipoCliente!=null){
		  		if (tipoCliente.value =="")			fncTipClienteSeleccione();
		 		else if(tipoCliente.value == "1")	fncTipoClienteEmpresa();
		 		else if(tipoCliente.value == "2")	fncTipoClienteParticular();
				else if(tipoCliente.value == "3")	fncTipoClientePrepago();
				else if (tipoCliente.value == "4")	fncTipoClienteEmpresa();

				fncObtenerSegmentos(tipoCliente);
				fncObtenerCiclos(tipoCliente);						
			}
			
			//P-CSR-11002 JLGN 03-06-2011
			if (tipoCliente!=null){
				if(tipoCliente.value == 3){
					//Cliente es Prepago No Se muestra pass para Excepcion
					document.getElementById("divUsuarioPass").style["display"] = "none";
				}else{
					if(botonPass == "false"){
						//No se Muestra Password
						document.getElementById("divUsuarioPass").style["display"] = "none";
					}else{
						//Se Muestra Password
						document.getElementById("divUsuarioPass").style["display"] = "";
					}
				}	
			}	
			
			var tipoIdentificacion1 = document.getElementById("tipoIdentificacion1");
			/* Inicio P-CSR-11002 JLGN 09-05-2011 
				var tipoIdentificacion2 = document.getElementById("tipoIdentificacion2");			
			   Fin P-CSR-11002 JLGN 09-05-2011*/
			var tipoIdentificacionUsuarioLegal = document.getElementById("tipoIdentificacionUsuarioLegal");
			var tipoIdentificacionUsuarioAut = document.getElementById("tipoIdentificacionUsuarioAut");
				
			/*P-CSR-11002 JLGN 03-06-2011			
			if (tipoIdentificacion1.value == codigoNIT){		
				document.getElementById("lbNumeroIdentificacion1").innerHTML = formatoNIT;
			}*/
			
			/* Inicio P-CSR-11002 JLGN 09-05-2011
			if (tipoIdentificacion2.value == codigoNIT){		
				document.getElementById("lbNumeroIdentificacion2").innerHTML = formatoNIT;
			}
			Fin P-CSR-11002 JLGN 09-05-2011*/
			/*P-CSR-11002 JLGN 03-06-2011					
			if (tipoIdentificacionUsuarioLegal.value == codigoNIT){
				document.getElementById("lbNumeroIdentificacionUsuarioLegal").innerHTML = formatoNIT;
			}
			
			if (tipoIdentificacionUsuarioAut.value == codigoNIT){
				document.getElementById("lbNumeroIdentificacionUsuarioAut").innerHTML = formatoNIT;
			}*/			

			var largoNumCelular = document.getElementById("largoNumCelular").value;
			document.getElementById("telefono").maxLength = largoNumCelular;
			// activaDesactivaLinkReferencias(); P-CSR-11002 JLGN 10-05-2011
			fncTipoCliente(); //P-CSR-11002 JLGN 12-05-2011
			
			//P-CSR-11002 JLGN 05-06-2011
			document.getElementById("passValidacion").value = "";
			if (tipoCliente.value == "3"){
				document.getElementById("btnContinuar").disabled=false;
			}else{
				if (flagPass == "true"){
					document.getElementById("btnContinuar").disabled=false;
				}else{
					document.getElementById("btnContinuar").disabled=true;
				}
			}
			//P-CSR-11002 JLGN 28-07-2011
			if(tipoCliente.value != "3"){
				if(flagLimCred == "true"){
					document.getElementById("btnContinuar").disabled=true;
					//P-CSR-11002 JLGN 28-07-2011
					alert("Cliente no posee Límite de Consumo "+ mensajeErrorBuro );
					//alert("Limite de Credito del Cliente es Cero "+ mensajeErrorBuro );
					//P-CSR-11002 JLGN 28-07-2011
					//if (confirm("Limite de Credito del Cliente es Cero ¿Desea continuar con el Alta de cliente Pospago?")) {
					//	document.getElementById("btnContinuar").disabled=false;
					//}					
				}
			}
			
			//Inicio Inc.179734 09-01-2012 JLGN 
			if(flagDDA == "true"){
				//no muestra datos de limite de credito y calificacion del buro
				document.getElementById("divCargoBuro").style["display"] = "none";
			}else{ 
			//Fin Inc.179734 09-01-2012 JLGN 
				//Inicio P-CSR-11002 JLGN 14-11-2011			
				if(tipoCliente.value == ""){
					document.getElementById("divCargoBuro").style["display"] = "none";
				}else{
					if(tipoCliente.value != "3"){
						//muestra datos de limite de credito y calificacion del buro
						document.getElementById("divCargoBuro").style["display"] = "";
					}else{
						document.getElementById("divCargoBuro").style["display"] = "none";
					}
				}
				//Fin P-CSR-11002 JLGN 14-11-2011
			}	
			//P-CSR-11002 JLGN 14-06-2011
			fncCursorNormal();	
	}
	
	/* Inicio P-CSR-11002 JLGN 10-05-2011
	function activaDesactivaLinkReferencias() {
		var tipoCliente = document.getElementById("tipoCliente");
		if (tipoCliente != null) {
			var row0 = document.getElementById("trReferencias0");
			var row1 = document.getElementById("trReferencias1");
			var row2 = document.getElementById("trReferencias2");
			if (tipoCliente.value != "") {
				row0.style["display"] = ""; 
				row1.style["display"] = "";
				row2.style["display"] = "";
			}
			else {
				row0.style["display"] = "none"; 
				row1.style["display"] = "none";
				row2.style["display"] = "none";
			}
		}
	}Fin P-CSR-11002 JLGN 10-05-2011*/
	
	function fncActivarDesacControles(tipoCliente) {
  		if (tipoCliente.value == "") {
  			fncTipClienteSeleccione();
 		}
 		else if(tipoCliente.value == "1" || tipoCliente.value == "4") {
 			fncTipoClienteEmpresa();
			/*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("registroFacturacion").selectedIndex = 1;
			  Fin P-CSR-11002 JLGN 25-04-2011 
			*/
			document.getElementById("envioFacturaFisica").selectedIndex = 1;
			document.getElementById("registroFacturacion").selectedIndex = 0;
 		}
 		else if(tipoCliente.value == "2") {
 			fncTipoClienteParticular();
			/*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("registroFacturacion").selectedIndex = 1;
			  Fin P-CSR-11002 JLGN 25-04-2011 
			*/
			document.getElementById("envioFacturaFisica").selectedIndex = 1;
			document.getElementById("registroFacturacion").selectedIndex = 0;
		}
		else if (tipoCliente.value == "3") {
			//P-CSR-11002 JLGN 12-07-2011
			//fncTipoClientePrepago();
			fncTipoClientePrepago2();
		}
		//setear valores por defecto correspondiente al segmento
		cambiaValorDefecto = true;
		//actualiza lista crediticia
		if (document.getElementById("codCrediticia")!=null){
			if (tipoCliente.value == "1" || tipoCliente.value == "2" || tipoCliente.value == "4")	JAltaClienteInicioAJAX.obtenerCrediticia(fncRetornoObtenerCrediticia);
		}
		//lista combos dependientes
		fncObtenerSegmentos(tipoCliente);
		fncObtenerCiclos(tipoCliente);
		//activaDesactivaLinkReferencias(); P-CSR-11002 JLGN 10-05-2011
		fncTipoCliente();
  	}

	function fncRetornoObtenerCrediticia(data){
		if (data!=null){
			var listaActualizada = data["lista"];
			var codClasifCrediticiaDef = "";
				
			//obtener valor por defecto
			for (index = 0; index< listaActualizada.length; index++) {
				var clasifCrediticia = listaActualizada[index];
		       	if (clasifCrediticia["indDefecto"] == "1"){
		       		codClasifCrediticiaDef = clasifCrediticia["codClasificacion"];
		        	break;
		       	} 
		    }

		    DWRUtil.removeAllOptions("codCrediticia");
		    DWRUtil.addOptions("codCrediticia",listaActualizada,"codClasificacion","desClasificacion");
		    
		    if (codClasifCrediticiaDef !=""){
			    var codCrediticia = document.getElementById("codCrediticia");
			    var encontrado = false;
			    for (index = 0; index< codCrediticia.length; index++) {
			       	  if (codCrediticia[index].value == codClasifCrediticiaDef){
			        	codCrediticia.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
		    }
	    }//fin if (data!=null)
	}
		
	function fncTipClienteSeleccione(){
	  		document.getElementById("btnEmpresa").disabled=true ;
	  		document.getElementById("btnParticular").disabled=true;
	  		if (document.getElementById("codSegmento")!=null){
		  		DWRUtil.removeAllOptions("codSegmento");
			    DWRUtil.addOptions("codSegmento",{'':'- Seleccione -'});
			}
   		    DWRUtil.removeAllOptions("cicloFact");
		    DWRUtil.addOptions("cicloFact",{'':'- Seleccione -'});
	   		document.getElementById("codSegmentoSeleccionado").value = "";
			document.getElementById("codCicloSeleccionado").value = "";
			document.getElementById("divUsuarioLegal").style["display"] = "none";
			/*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("registroFacturacion").selectedIndex = 1;
			*/
			document.getElementById("btnBuro").disabled=true;
			document.getElementById("envioFacturaFisica").selectedIndex = 1;
			document.getElementById("registroFacturacion").selectedIndex = 0;
			//Fin P-CSR-11002 JLGN 25-04-2011 
			//Inicio P-CSR-11002 JLGN 12-08-2011
			//document.getElementById("tipoIdentificacion1Seleccionado").value = "01";
			tipoIdentificacionCliente(document.getElementById("tipoCliente").value);
	}
	
	function fncTipoClienteEmpresa(){
  			document.getElementById("btnEmpresa").disabled=false ;
	  		document.getElementById("btnParticular").disabled=true;
			document.getElementById("divUsuarioLegal").style["display"] = "";
			//Inicio P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("btnBuro").disabled=false;
			//Fin P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("registroFacturacion").disabled = false;	
			document.getElementById("envioFacturaFisica").disabled = false;
			
			//Inicio P-CSR-11002 JLGN 09-05-2011
			if(flagDataBuro == "true"){
				if(document.getElementById("nombresUsuarioLegal").value!= ""){
					document.getElementById("tipoIdentificacionUsuarioAut").disabled = true;
					document.getElementById("numeroIdentificacionUsuarioAut").disabled = true;
					document.getElementById("nombresUsuarioAut").disabled = true;
					document.getElementById("apellido1UsuarioAut").disabled = true;
					document.getElementById("apellido2UsuarioAut").disabled = true;
					document.getElementById("tipoIdentificacionUsuarioLegal").disabled = true;
					document.getElementById("numeroIdentificacionUsuarioLegal").disabled = true;
					document.getElementById("nombresUsuarioLegal").disabled = true;
					document.getElementById("apellido1UsuarioLegal").disabled = true;
					document.getElementById("apellido2UsuarioLegal").disabled = true;
					document.getElementById("flagTipCliente").value = "true";
				}else{
					document.getElementById("tipoIdentificacionUsuarioAut").disabled = false;
					document.getElementById("numeroIdentificacionUsuarioAut").disabled = false;
					document.getElementById("nombresUsuarioAut").disabled = false;
					document.getElementById("apellido1UsuarioAut").disabled = false;
					document.getElementById("apellido2UsuarioAut").disabled = false;
					document.getElementById("tipoIdentificacionUsuarioLegal").disabled = false;
					document.getElementById("numeroIdentificacionUsuarioLegal").disabled = false;
					document.getElementById("nombresUsuarioLegal").disabled = false;
					document.getElementById("apellido1UsuarioLegal").disabled = false;
					document.getElementById("apellido2UsuarioLegal").disabled = false;
					document.getElementById("flagTipCliente").value = "false";
				}
			}	
			//Fin P-CSR-11002 JLGN 09-05-2011
			//Inicio P-CSR-11002 JLGN 12-08-2011
			//document.getElementById("tipoIdentificacion1Seleccionado").value = "02";
			tipoIdentificacionCliente(document.getElementById("tipoCliente").value);
	}
	
	function fncTipoClienteParticular(){
			document.getElementById("btnParticular").disabled=false ;
	  		document.getElementById("btnEmpresa").disabled=true ;	
			document.getElementById("divUsuarioLegal").style["display"] = "none";		
			//Inicio P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("btnBuro").disabled=false;
			//Fin P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("registroFacturacion").disabled = false;
			document.getElementById("envioFacturaFisica").disabled = false;
			
			//Inicio P-CSR-11002 JLGN 09-05-2011
			if(flagDataBuro == "true"){
				if(document.getElementById("nombresUsuarioLegal").value!= ""){
					document.getElementById("tipoIdentificacionUsuarioAut").disabled = true;
					document.getElementById("numeroIdentificacionUsuarioAut").disabled = true;
					document.getElementById("nombresUsuarioAut").disabled = true;
					document.getElementById("apellido1UsuarioAut").disabled = true;
					document.getElementById("apellido2UsuarioAut").disabled = true;
					document.getElementById("tipoIdentificacionUsuarioLegal").disabled = true;
					document.getElementById("numeroIdentificacionUsuarioLegal").disabled = true;
					document.getElementById("nombresUsuarioLegal").disabled = true;
					document.getElementById("apellido1UsuarioLegal").disabled = true;
					document.getElementById("apellido2UsuarioLegal").disabled = true;
					document.getElementById("flagTipCliente").value = "true";
				}else{
					document.getElementById("tipoIdentificacionUsuarioAut").disabled = false;
					document.getElementById("numeroIdentificacionUsuarioAut").disabled = false;
					document.getElementById("nombresUsuarioAut").disabled = false;
					document.getElementById("apellido1UsuarioAut").disabled = false;
					document.getElementById("apellido2UsuarioAut").disabled = false;
					document.getElementById("tipoIdentificacionUsuarioLegal").disabled = false;
					document.getElementById("numeroIdentificacionUsuarioLegal").disabled = false;
					document.getElementById("nombresUsuarioLegal").disabled = false;
					document.getElementById("apellido1UsuarioLegal").disabled = false;
					document.getElementById("apellido2UsuarioLegal").disabled = false;
					document.getElementById("flagTipCliente").value = "false";
				}
			}				
			//Fin P-CSR-11002 JLGN 09-05-2011
			//Inicio P-CSR-11002 JLGN 12-08-2011
			//document.getElementById("tipoIdentificacion1Seleccionado").value = "01";
			tipoIdentificacionCliente(document.getElementById("tipoCliente").value);			
	}
	
	function fncTipoClientePrepago(){
			/*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("registroFacturacion").selectedIndex = 1;
			  Fin P-CSR-11002 JLGN 25-04-2011 
			*/
			document.getElementById("registroFacturacion").selectedIndex = 1;
			document.getElementById("registroFacturacion").disabled = true;
			//Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("envioFacturaFisica").selectedIndex = 1;
			document.getElementById("envioFacturaFisica").disabled = true;
			//Fin P-CSR-11002 JLGN 25-04-2011 
			
			if (document.getElementById("codCrediticia")!=null){
				var codCrediticiaExcepcionado = document.getElementById("codCrediticiaExcepcionado").value;
				var codCrediticia = document.getElementById("codCrediticia");
				
				var clasifCrediticia =  new Object();
				clasifCrediticia["codClasificacion"] = codCrediticiaExcepcionado;
				clasifCrediticia["desClasificacion"] = "Excepcionado";
				var arrayCrediticiaEx = new Array();
				arrayCrediticiaEx[0] = clasifCrediticia;
				
				DWRUtil.removeAllOptions("codCrediticia");
			    DWRUtil.addOptions("codCrediticia",arrayCrediticiaEx,"codClasificacion","desClasificacion")
			}
			
   			document.getElementById("btnParticular").disabled=false ;
	  		document.getElementById("btnEmpresa").disabled=true ;	
			document.getElementById("divUsuarioLegal").style["display"] = "none";
			//Inicio P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("btnBuro").disabled=true;
			document.getElementById("passValidacion").value = "";
			document.getElementById("divUsuarioPass").style["display"] = "none";
			//Fin P-CSR-11002 JLGN 29-04-2011 
			
			//Inicio P-CSR-11002 JLGN 09-05-2011
			document.getElementById("tipoIdentificacionUsuarioAut").disabled = false;
			document.getElementById("numeroIdentificacionUsuarioAut").disabled = false;
			document.getElementById("nombresUsuarioAut").disabled = false;
			document.getElementById("apellido1UsuarioAut").disabled = false;
			document.getElementById("apellido2UsuarioAut").disabled = false;
			document.getElementById("tipoIdentificacionUsuarioLegal").disabled = false;
			document.getElementById("numeroIdentificacionUsuarioLegal").disabled = false;
			document.getElementById("nombresUsuarioLegal").disabled = false;
			document.getElementById("apellido1UsuarioLegal").disabled = false;
			document.getElementById("apellido2UsuarioLegal").disabled = false;
			document.getElementById("flagTipCliente").value = "false";
			//Fin P-CSR-11002 JLGN 09-05-2011
			//Inicio P-CSR-11002 JLGN 12-08-2011
			tipoIdentificacionCliente(document.getElementById("tipoCliente").value);			
	}
	
	//(+)-- carga segunda lista de identificacion eliminando el tipo identificador seleccionado en la primera lista, solo para SALVADOR
	/*function fncObtenerIdentificacion2(tipoIdentificador){
		var codOperadora = document.getElementById("codOperadora");
		var codOperadoraSalvador = document.getElementById("codOperadoraSalvador");

		if (codOperadora.value == codOperadoraSalvador.value){
			if (tipoIdentificador.value != "") {
				JAltaClienteInicioAJAX.obtenerIdentificadoresFiltro(tipoIdentificador.value,fncResultadoObtenerIdentificacion2);
			}
		}		
	}
	
	function fncResultadoObtenerIdentificacion2(data){
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
			
			var tipoIdentificacion2Seleccionado = document.getElementById("tipoIdentificacion2Seleccionado").value;
				
		    DWRUtil.removeAllOptions("tipoIdentificacion2");
		    DWRUtil.addOptions("tipoIdentificacion2",{'':'- Seleccione -'});
		    DWRUtil.addOptions("tipoIdentificacion2",listaActualizada,"codigoTipIdentif","descripcionTipIdentif");
		    
		    if (tipoIdentificacion2Seleccionado !=""){
			    var tipoIdentificacion2 = document.getElementById("tipoIdentificacion2");
			    var encontrado = false;
			    for (index = 0; index< tipoIdentificacion2.length; index++) {
			       	  if (tipoIdentificacion2[index].value == tipoIdentificacion2Seleccionado){
			        	tipoIdentificacion2.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) {
			    	document.getElementById("tipoIdentificacion2Seleccionado").value = "";
			    	document.getElementById("numeroIdentificacion2").value = "";			    	
			    }
		    }
	    }//fin if (data!=null)
	}*/
	//(-)-- carga segunda lista de identificacion
	
	//(+)-- carga combo de segmentos--
	function fncObtenerSegmentos(tipoCliente) {
		if (document.getElementById("codSegmento")!=null){
			if (tipoCliente.value != "") {
				JAltaClienteInicioAJAX.obtenerSegmentos(tipoCliente.value,fncResultadoObtenerSegmentos);
			}
		}
	}
	
	function fncResultadoObtenerSegmentos(data){
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
			
			var codSegmentoSeleccionado = document.getElementById("codSegmentoSeleccionado").value;
				
			if (cambiaValorDefecto){//obtener valor por defecto
				for (index = 0; index< listaActualizada.length; index++) {
					var clasifSegmento = listaActualizada[index];
			       	if (clasifSegmento["indDefecto"] == "1"){
				       	document.getElementById("codSegmentoSeleccionado").value = clasifSegmento["codClasificacion"];
			       		codSegmentoSeleccionado = clasifSegmento["codClasificacion"];
			        	break;
			       	} 
			    }
			}					    		
			
		    DWRUtil.removeAllOptions("codSegmento");
		    DWRUtil.addOptions("codSegmento",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codSegmento",listaActualizada,"codClasificacion","desClasificacion");
		    
		    if (codSegmentoSeleccionado !=""){
			    var codSegmento = document.getElementById("codSegmento");
			    var encontrado = false;
			    for (index = 0; index< codSegmento.length; index++) {
			       	  if (codSegmento[index].value == codSegmentoSeleccionado){
			        	codSegmento.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codSegmentoSeleccionado").value = ""
		    }
	    }//fin if (data!=null)
	    
	    cambiaValorDefecto = false;
	}
	//(-)-- carga combo de segmentos--
		
	//(+)-- carga combo de ciclos--	
	function fncObtenerCiclos(tipoCliente){
		if (tipoCliente.value!=""){
			if (document.getElementById("codCicloSeleccionado").value == ""){
				//Inicio P-CSR-11002 JLGN 15-06-2011
				if(tipoCliente.value == "1"){//Cliente Empresa
					document.getElementById("codCicloSeleccionado").value = cicloEmpresa;
				}else if (tipoCliente.value == "2"){//Cliente Particular
					document.getElementById("codCicloSeleccionado").value = cicloParticular;
				}else{
					document.getElementById("codCicloSeleccionado").value = "";
				}//Fin P-CSR-11002 JLGN 15-06-2011
			}	
			JAltaClienteInicioAJAX.obtenerCiclosFacturacion(tipoCliente.value,fncResultadoObtenerCiclos);		
		}
	}
	
	function fncResultadoObtenerCiclos(data){
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
			var codCicloSeleccionado = document.getElementById("codCicloSeleccionado").value;

		    DWRUtil.removeAllOptions("cicloFact");
		    DWRUtil.addOptions("cicloFact",{'':'- Seleccione -'});
		    DWRUtil.addOptions("cicloFact",listaActualizada,"codigoCicloFacturacion","descripcionCiclo");
		    
		    if (codCicloSeleccionado !=""){
		        var cicloFact = document.getElementById("cicloFact");
		        var encontrado = false;
			    for (index = 0; index< cicloFact.length; index++) {
			       	  if (cicloFact[index].value == codCicloSeleccionado){
			        	cicloFact.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    
			    var tipoCliente = document.getElementById("tipoCliente").value;
			     for (index = 1; index< cicloFact.length; index++) {
			       	if(tipoCliente== "1"||tipoCliente== "4"){//Cliente Empresa
			    		if (document.getElementById("cicloFact").options[index].value == "1"){
			    			document.getElementById("cicloFact").options[index].selected = true;
			    			break;
			    		}
					}else if (tipoCliente == "2"){//Cliente Particular
						if (document.getElementById("cicloFact").options[index].value == "11"){
			    			document.getElementById("cicloFact").options[index].selected = true;
			    			break;
			    		}
					}			       	  
			    }

			    
			    /*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			     if (!encontrado) document.getElementById("codCicloSeleccionado").value = ""*/
			     
			     if (!encontrado){
			     	cicloFact.selectedIndex = 1;
			    	document.getElementById("codCicloSeleccionado").value = cicloFact[1].value;
			     }//Fin P-CSR-11002 JLGN 25-04-2011
			     
		    }else{ //Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
		    	var cicloFact = document.getElementById("cicloFact");
		    	cicloFact.selectedIndex = 1;
		    	document.getElementById("codCicloSeleccionado").value = cicloFact[1].value;
		    }//Fin P-CSR-11002 JLGN 25-04-2011
	    }
	}
	//(-)-- carga combo de ciclos--
	
	function fncSeleccionaSegmento(codSegmento){
		document.getElementById("codSegmentoSeleccionado").value = codSegmento.value;
	}	
	
	/*function fncSeleccionaTipoIdentificacion2(tipoIdentificacion){
		document.getElementById("tipoIdentificacion2Seleccionado").value = tipoIdentificacion.value;
	}*/	
	
	function fncSeleccionaCiclo(codCiclo){
		document.getElementById("codCicloSeleccionado").value = codCiclo.value;
	}
	
	function fncDatosParticular() {
		if (ejecutandoAjax) return;

	  	document.getElementById("opcion").value = "ingresarDatosParticular";
    	document.forms[0].submit();
	}
	
	function fncDatosEmpresa() {
		if (ejecutandoAjax) return;
	  	document.getElementById("opcion").value = "ingresarDatosEmpresa";
    	document.forms[0].submit();
	}
	
	function fncReferencias() {
		if (ejecutandoAjax) return;
	  	document.getElementById("opcion").value = "ingresarReferencias";
    	document.forms[0].submit();
	}
	
	function fncCancelar() {
		if (confirm("¿Está seguro que desea cancelar Alta de Cliente?")) {
			document.getElementById("opcion").value = "cancelarAltaCliente";
			document.forms[0].submit();
		}
	}
	
	function validaCorreo(theElement, elemento) {
    	var s = theElement.value;
     	var filter=/^[A-Za-z][A-Za-z0-9_.-]*@[A-Za-z0-9_.-]+\.[A-Za-z0-9_.-]+[A-za-z]$/;
     	if (s.length == 0 ) return true;
     	if (filter.test(s)) {
			return true;
     	}    
     	else {
         	alert("Ingrese una dirección de correo válida");
         	theElement.focus();
         	return false;
     	}
    }

	function fncDatosTributarios() {
	  	if (ejecutandoAjax) return;
	  	var tipoCliente = document.getElementById("tipoCliente");
	  	if (tipoCliente.value == "") {
	  	    alert("Debe Ingresar Tipo de Cliente");
	  	    //P-CSR-11002 JLGN 21-06-2011
	  	    fncCursorNormal();	
	  	    return false; 
	  	}
	  	/* Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	var codOperadora = document.getElementById("codOperadora");
		var codOperadoraSalvador = document.getElementById("codOperadoraSalvador");
			
		if (codOperadora.value != codOperadoraSalvador.value) { //No aplica a El Salvador
	  		if (tipoCliente.value == "1" || tipoCliente.value == "2") {
	  			var refs = document.getElementById("cantidadReferenciasCliente");
	  			if (refs.value == "0") {
	  				alert("Debe ingresar Referencias de Cliente");
	  	   			return false;
	  	   		}
	  		}
	  	}
	  	Fin P-CSR-11002 JLGN 26-04-2011 */
	  	//Inicio P-CSR-11002 JLGN 03-10-2011
	  	if (document.getElementById("tipoCliente").value != 3){ 
		  	if (document.getElementById("registroFacturacion").value == "0" && document.getElementById("envioFacturaFisica").value == "0"){
			  	alert("Debe ingresar al menos un tipo de envío de Factura.");
		  	    fncCursorNormal();	
		  	    return false; 	  	
		  	   // INC INICIO 185493 30-07-2012 
		  	}else{
		  	
		  		if (document.getElementById("registroFacturacion").value == "1" && document.getElementById("envioFacturaFisica").value == "1"){
		  			alert("Debe ingresar solo un tipo de envío de Factura.");
		  			return false; 
		  		}
	  		}
	  	    // INC FIN 185493 30-07-2012 
	  	}
	  	//Fin P-CSR-11002 JLGN 03-10-2011
	  	
	  	if (document.getElementById("codColor")!=null && document.getElementById("codColor").value == "") {
	  	    alert("Debe ingresar Color");
	  	    //P-CSR-11002 JLGN 21-06-2011
	  	    fncCursorNormal();	
	  	    return false; 
	  	}
		if (document.getElementById("codSegmento")!=null && document.getElementById("codSegmento").value=="") {
	  	    alert("Debe ingresar Segmento");
	  	    //P-CSR-11002 JLGN 21-06-2011
	  	    fncCursorNormal();	
	  	    return false; 
	  	}
		if (document.getElementById("categoriaCliente")!=null && document.getElementById("categoriaCliente").value=="")
	  	{
	  	    alert("Debe ingresar Categoría del Cliente");
	  	    //P-CSR-11002 JLGN 21-06-2011
	  	    fncCursorNormal();	
	  	    return false; 
	  	}
	  	 if (document.getElementById("codCalificacion")!=null && document.getElementById("codCalificacion").value=="")
	  	 {
	  	     alert("Debe Ingresar Calificación");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 if (document.getElementById("codCrediticia")!=null && document.getElementById("codCrediticia").value=="")
	  	 {
	  	     alert("Debe Ingresar Crediticia");
	  	     //P-CSR-11002 JLGN 21-06-2011
 	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 if (document.getElementById("tipoIdentificacion1").value=="")
	  	 {
	  	     alert("Debe Ingresar Tipo identificaci\u00F3n");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 if (document.getElementById("numeroIdentificacion1").value=="")
	  	 {
	  	     alert("Debe Ingresar N\u00FAmero identificaci\u00F3n");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 
	  	 /*Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	 if (document.getElementById("tipoIdentificacion2").value=="" && document.getElementById("numeroIdentificacion2").value!="" )
	  	 {
	  	    alert("Es obligatorio indicar un tipo de identificaci\u00F3n si se digita un segundo n\u00FAmero de identificaci\u00F3n"); 
	  	    return false;
	  	 }
	  	 
	  	 if (document.getElementById("tipoIdentificacion2").value!="" && document.getElementById("numeroIdentificacion2").value=="" )
	  	 {
 	  	    alert("Es obligatorio indicar un n\u00FAmero de identificaci\u00F3n si se selecciona un segundo tipo de identificaci\u00F3n"); 
	  	    return false;
	  	 } Fin P-CSR-11002 JLGN 26-04-2011*/
	  	 
	  	 if (document.getElementById("cicloFact").value=="")
	  	 {
	  	     alert("Debe Ingresar ciclo de facturaci\u00F3n");
	  	     //P-CSR-11002 JLGN 21-06-2011
   	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 
	  	 if (document.getElementById("tipoCliente").value != 3 && document.getElementById("registroFacturacion").value=="")
	  	 {
	  	     alert("Debe Indicar si desea Factura Electr\u00F3nica");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 
	  	 //Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	 if (document.getElementById("tipoCliente").value != 3 && document.getElementById("envioFacturaFisica").value=="")
	  	 {
	  	     alert("Debe Indicar si desea Env\u00edo de Factura F\u00edsica");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 //Fin P-CSR-11002 JLGN 25-04-2011 
	  	 
	  	 if ( document.getElementById("tipoCliente").value != 3 && document.getElementById("registroFacturacion").value == "1" )
	  	 {
			if (document.getElementById("paramIndFacturaElectronica").value == "S" && document.getElementById("correo").value == ""){
		  	     alert("Debe Ingresar Correo Electr\u00F3nico");
		  	     //P-CSR-11002 JLGN 21-06-2011
	 	  	     fncCursorNormal();	
		  	     return false; 
			}	  	 
	  	 }
	  	 
	  	 if (document.getElementById("tipoIdentificacionUsuarioAut").value != "")
	  	 {
	 	  	 if (document.getElementById("numeroIdentificacionUsuarioAut").value=="")
		  	 {
		  	     alert("Si ingresa Tipo Identificaci\u00F3n de Usuario Autorizado, debe ingresar N\u00FAmero Identificaci\u00F3n ");
		  	     //P-CSR-11002 JLGN 21-06-2011
	  	         fncCursorNormal();	
		  	     return false; 
		  	 }else{
				 if (document.getElementById("nombresUsuarioAut").value=="")
			  	 {
			  	     alert("Si ingresa Identificaci\u00F3n de Usuario Autorizado, debe ingresar Nombres");
			  	     //P-CSR-11002 JLGN 21-06-2011
	  	    		 fncCursorNormal();	
			  	     return false; 
			  	 }
		  	 }
	  	 }else if (document.getElementById("numeroIdentificacionUsuarioAut").value != "")
	  	 {
	 	  	 if (document.getElementById("tipoIdentificacionUsuarioAut").value=="")
		  	 {
		  	     alert("Si ingresa N\u00FAmero Identificaci\u00F3n de Usuario Autorizado, debe ingresar Tipo Identificaci\u00F3n ");
		  	     //P-CSR-11002 JLGN 21-06-2011
	  	    	 fncCursorNormal();	
		  	     return false; 
		  	 }else{
				 if (document.getElementById("nombresUsuarioAut").value=="")
			  	 {
			  	     alert("Si ingresa Identificaci\u00F3n de Usuario Autorizado, debe ingresar Nombres");
			  	     //P-CSR-11002 JLGN 21-06-2011
	  	    		 fncCursorNormal();	
			  	     return false; 
			  	 }
		  	 }
	  	 }
	  	 
	  	 if (document.getElementById("tipoIdentificacionUsuarioLegal").value !="")
	  	 {
	 	  	 if (document.getElementById("numeroIdentificacionUsuarioLegal").value=="")
		  	 {
		  	     alert("Si ingresa Tipo Identificaci\u00F3n de Usuario Legal, debe ingresar N\u00FAmero Identificaci\u00F3n ");
		  	     //P-CSR-11002 JLGN 21-06-2011
	  	    	 fncCursorNormal();	
		  	     return false; 
		  	 }else{
				 if (document.getElementById("nombresUsuarioLegal").value=="")
			  	 {
			  	     alert("Si ingresa Identificaci\u00F3n de Usuario Legal, debe ingresar Nombres");
			  	     //P-CSR-11002 JLGN 21-06-2011
	  	    		 fncCursorNormal();	
			  	     return false; 
			  	 }
		  	 }
	  	 }else if (document.getElementById("numeroIdentificacionUsuarioLegal").value != "")
	  	 {
	 	  	 if (document.getElementById("tipoIdentificacionUsuarioLegal").value=="")
		  	 {
		  	     alert("Si ingresa N\u00FAmero Identificaci\u00F3n de Usuario Legal, debe ingresar Tipo Identificaci\u00F3n ");
		  	     //P-CSR-11002 JLGN 21-06-2011
	  	         fncCursorNormal();	
		  	     return false; 
		  	 }else{
				 if (document.getElementById("nombresUsuarioLegal").value=="")
			  	 {
			  	     alert("Si ingresa Identificaci\u00F3n de Usuario Legal, debe ingresar Nombres");
			  	     //P-CSR-11002 JLGN 21-06-2011
	  	    		 fncCursorNormal();	
			  	     return false; 
			  	 }
		  	 }
	  	 }

	  	 
	  	 if ((document.getElementById("tipoCliente").value == 1 || document.getElementById("tipoCliente").value == 4) && document.getElementById("flagDatosEmpresa").value=="0" )
	  	 {
	  	     alert("Debe ingresar Datos adicionales del cliente empresa");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 
	  	 }
	  	 if ((document.getElementById("tipoCliente").value != 1 && document.getElementById("tipoCliente").value != 4) && document.getElementById("flagDatosParticular").value=="0" )
	  	 {
	  	     alert("Debe ingresar Datos adicionales del cliente particular");
	  	     //P-CSR-11002 JLGN 21-06-2011
	  	     fncCursorNormal();	
	  	     return false; 	  	     
	  	 }
	  	 
		 document.getElementById("registroFacturacion").disabled=false;
		 //Inicio P-CSR-11002 JLGN 28-04-2011
		 document.getElementById("envioFacturaFisica").disabled=false;
		 //Fin P-CSR-11002 JLGN 28-04-2011
		 if (document.getElementById("codCrediticia")!=null)
			 document.getElementById("codCrediticia").disabled=false;		
		
	  	 document.getElementById("opcion").value = "ingresarDatosTributarios";
    	 document.forms[0].submit();
	}
  
	

	  	
	function fncValidaTipoIdentificacion(tipoIdentSel, numIdentText) {
		if (!validandoIdentificacion) {
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				ejecutandoAjax = true;
				JAltaClienteInicioAJAX.validarIdentificador(tipoIdentSel.value, numIdentText.value, fncResultadoValidacion);
			}
		}
	}
	
	function fncResultadoValidacion(data) {
		if (data != null) {
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	var msgError = data["msgError"];				
				alert(msgError);
				ultimoObjetoFoco.value = "";
				ultimoObjetoFoco.focus();
			}
			else {
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
			validandoIdentificacion = false;
		}
		ejecutandoAjax = false;
	}
	
	//Muestra formato NIT
	/*P-CSR-11002 JLGN 03-06-2011
	function fncCambiarLabelNIT(tipoIdent, label){
		if (tipoIdent.value==codigoNIT)	label.innerHTML = formatoNIT;
		else							label.innerHTML = "";
	}*/
	
  	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}
	
	function tipoCliente_onchange(o) {
		//Inicio P-CSR-11002 JLGN 14-11-2011
		if(o.value == ""){
			document.getElementById("divCargoBuro").style["display"] = "none";
		}else{
			if(o.value != "3"){
				//muestra datos de limite de credito y calificacion del buro
				document.getElementById("divCargoBuro").style["display"] = "";
			}else{
				document.getElementById("divCargoBuro").style["display"] = "none";
			}
		}	
		//Fin P-CSR-11002 JLGN 14-11-2011		
		ocultarMensajeError();
		fncActivarDesacControles(o);
		JAltaClienteInicioAJAX.eliminarReferenciasCliente(resultadoEliminarReferenciasCliente);
	}
	
	function resultadoEliminarReferenciasCliente(data) {
		if (data != null) {
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
			}
		}
	}
	
	//Inicio P-CSR-11002 JLGN 07/04/2011
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
	
	//Inicio MA-180654 HOM
	
	var objNewWindow;	
	
	function fncPopUpAbonadosAct(){
		var numIdent = document.getElementById("numeroIdentificacion1").value;
		var tipIdent = document.getElementById("tipoIdentificacion1").value;
		if(numIdent == null || numIdent == ""){
			alert("Debe Ingresar Numero de Identificacion");
	  	    return false; 
		}
		document.getElementById("strNumIdentConsAbo").value=numIdent;
		document.getElementById("strTipIdentConsAbo").value=tipIdent;		
		
    	document.getElementById("formDatosAbonadosActAction").submit();		

	}
	
	function levantarPopUp(){
		var strFeatures = "dialogTop=100px; dialogLeft=200px; dialogWidth=500px;" +
		"dialogHeight=265px; center=yes; help=no; font-family:Arial;" +
		"font-size:12px";
		var pagina = "<%=request.getContextPath()%>/pages/altaCliente/datosAbonadosActivos.jsp";
		objNewWindow = window.showModalDialog(pagina, "NewWin", strFeatures);
		fncCursorEspera();
		ocultarMensajeError();
		fncConsultaBuro();
	}
	//Fin MA-180654 HOM	
	
	//Fin P-CSR-11002 JLGN 07/04/2011
	//Inicio P-CSR-11002 JLGN 29-04-2011
	function fncConsultaBuro(){
		var numIdent = document.getElementById("numeroIdentificacion1").value;
		if(numIdent == null || numIdent == ""){
			alert("Debe Ingresar Numero de Identificacion");
	  	    return false; 
		}
		document.getElementById("numeroIdentificacion1")
		document.getElementById("opcion").value = "consultaBuro";
    	document.forms[0].submit();		
	}
	//Fin P-CSR-11002 JLGN 29-04-2011
	
	//Inicio P-CSR-11002 JLGN 12-05-2011
	function fncTipoCliente(){
		var tipoCliente = document.getElementById("tipoCliente");
		
		if (tipoCliente.value == "3"){
			document.getElementById("btnContinuar").disabled=false;
		}else if(tipoCliente.value != 3 && flagOKBuro == "false"){
			document.getElementById("btnContinuar").disabled = true;			
		}else if (tipoCliente.value != 3 && flagOKBuro == "true"){
			if(document.getElementById("nombresUsuarioLegal").value == ""){
				document.getElementById("btnContinuar").disabled = true;
			}else{
				document.getElementById("btnContinuar").disabled = false;
			}		
		}		
	}
	//Fin P-CSR-11002 JLGN 12-05-2011
	
	//Inicio P-CSR-11002 JLGN 05-06-2011
	function fncValidarPass(){
		document.getElementById("opcion").value = "validarPass";
		document.forms[0].submit();
	}
	//Fin P-CSR-11002 JLGN 05-06-2011
	
	//Inicio P-CSR-11002 JLGN 08-06-2011
	function fncLimpiaDatos(){
		document.getElementById("correo").value = "";
		document.getElementById("telefono").value = "";
		document.getElementById("cuentaFacebook").value = "";
		document.getElementById("cuentaTwitter").value = "";
		document.getElementById("numeroIdentificacionUsuarioAut").value = "";
		document.getElementById("nombresUsuarioAut").value = "";
		document.getElementById("apellido1UsuarioAut").value = "";
		document.getElementById("apellido2UsuarioAut").value = "";
		document.getElementById("numeroIdentificacionUsuarioLegal").value = "";
		document.getElementById("nombresUsuarioLegal").value = "";
		document.getElementById("apellido1UsuarioLegal").value = "";
		document.getElementById("apellido2UsuarioLegal").value = "";		
		document.getElementById("numeroIdentificacionUsuarioAut").disabled=false;
		document.getElementById("tipoIdentificacionUsuarioAut").disabled=false;
		document.getElementById("nombresUsuarioAut").disabled=false;		
		document.getElementById("apellido1UsuarioAut").disabled=false;
		document.getElementById("apellido2UsuarioAut").disabled=false;
		document.getElementById("tipoIdentificacionUsuarioLegal").disabled=false;
		document.getElementById("numeroIdentificacionUsuarioLegal").disabled=false;
		document.getElementById("nombresUsuarioLegal").disabled=false;
		document.getElementById("apellido1UsuarioLegal").disabled=false;
		document.getElementById("apellido2UsuarioLegal").disabled=false;
		document.getElementById("flagTipCliente").value = "false";
		document.getElementById("flagDatosEmpresa").value="0"
		document.getElementById("flagDatosParticular").value="0"
		
		if (document.getElementById("tipoCliente").value=="3"){
			//Cliente Prepago No se desactiva Boton continuar
			document.getElementById("btnContinuar").disabled=false;
		}else{
			//Inicio Inc.179734 JLGN 09-01-2012
			if(flagDDA == "false"){
				document.getElementById("btnContinuar").disabled=true;
			}else{
				document.getElementById("btnContinuar").disabled=false;
			}//Fin Inc.179734 JLGN 09-01-2012	
		}
		
	}
	//Fin P-CSR-11002 JLGN 08-06-2011
	
	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }
    
    //Inicio P-CSR-11002 JLGN 12-07-2011
    function fncTipoClientePrepago2(){
			/*Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("registroFacturacion").selectedIndex = 1;
			  Fin P-CSR-11002 JLGN 25-04-2011 
			*/
			document.getElementById("registroFacturacion").selectedIndex = 1;
			document.getElementById("registroFacturacion").disabled = true;
			//Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
			document.getElementById("envioFacturaFisica").selectedIndex = 1;
			document.getElementById("envioFacturaFisica").disabled = true;
			//Fin P-CSR-11002 JLGN 25-04-2011 
			
			if (document.getElementById("codCrediticia")!=null){
				var codCrediticiaExcepcionado = document.getElementById("codCrediticiaExcepcionado").value;
				var codCrediticia = document.getElementById("codCrediticia");
				
				var clasifCrediticia =  new Object();
				clasifCrediticia["codClasificacion"] = codCrediticiaExcepcionado;
				clasifCrediticia["desClasificacion"] = "Excepcionado";
				var arrayCrediticiaEx = new Array();
				arrayCrediticiaEx[0] = clasifCrediticia;
				
				DWRUtil.removeAllOptions("codCrediticia");
			    DWRUtil.addOptions("codCrediticia",arrayCrediticiaEx,"codClasificacion","desClasificacion")
			}
			
   			document.getElementById("btnParticular").disabled=false ;
	  		document.getElementById("btnEmpresa").disabled=true ;	
			document.getElementById("divUsuarioLegal").style["display"] = "none";
			//Inicio P-CSR-11002 JLGN 29-04-2011 
			document.getElementById("btnBuro").disabled=true;
			document.getElementById("passValidacion").value = "";
			document.getElementById("divUsuarioPass").style["display"] = "none";
			//Fin P-CSR-11002 JLGN 29-04-2011 
			
			//Inicio P-CSR-11002 JLGN 09-05-2011
			document.getElementById("tipoIdentificacionUsuarioAut").disabled = false;
			document.getElementById("numeroIdentificacionUsuarioAut").disabled = false;
			document.getElementById("nombresUsuarioAut").disabled = false;
			document.getElementById("apellido1UsuarioAut").disabled = false;
			document.getElementById("apellido2UsuarioAut").disabled = false;
			document.getElementById("tipoIdentificacionUsuarioLegal").disabled = false;
			document.getElementById("numeroIdentificacionUsuarioLegal").disabled = false;
			document.getElementById("nombresUsuarioLegal").disabled = false;
			document.getElementById("apellido1UsuarioLegal").disabled = false;
			document.getElementById("apellido2UsuarioLegal").disabled = false;
			document.getElementById("flagTipCliente").value = "false";
			
			document.getElementById("tipoIdentificacionUsuarioAut").value = "";
			document.getElementById("numeroIdentificacionUsuarioAut").value = "";
			document.getElementById("nombresUsuarioAut").value = "";
			document.getElementById("apellido1UsuarioAut").value = "";
			document.getElementById("apellido2UsuarioAut").value = "";
			document.getElementById("tipoIdentificacionUsuarioLegal").value = "";
			document.getElementById("numeroIdentificacionUsuarioLegal").value = "";
			document.getElementById("nombresUsuarioLegal").value = "";
			document.getElementById("apellido1UsuarioLegal").value = "";
			document.getElementById("apellido2UsuarioLegal").value = "";
			document.getElementById("telefono").value = "";			
			//Fin P-CSR-11002 JLGN 09-05-2011
			//Inicio P-CSR-11002 JLGN 12-08-2011
			tipoIdentificacionCliente(document.getElementById("tipoCliente").value);
	}
    //Fin P-CSR-1002 JLGN 12-07-2011
    
    function fncSeleccionaTipoIdentificacion1(tipoIdentificacion){
		document.getElementById("tipoIdentificacion1Seleccionado").value = tipoIdentificacion.value;
	}
    
    function tipoIdentificacionCliente(tipCliente){
    	JAltaClienteInicioAJAX.obtenerIdentificadoresClienteFiltro(tipCliente,fncResultadoObtenerIdentificacion);    	
    }
    
    function fncResultadoObtenerIdentificacion(data){
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
		    DWRUtil.removeAllOptions("tipoIdentificacion1");
		    DWRUtil.addOptions("tipoIdentificacion1",listaActualizada,"codigoTipIdentif","descripcionTipIdentif");		   
		    //P-CSR-11002 JLGN 22-08-2011
		    document.getElementById("tipoIdentificacion1").selectedIndex = 0;
		    document.getElementById("tipoIdentificacion1").value = document.getElementById("tipoIdentificacion1Seleccionado").value;
	    }
	}
    		  	
</script>
</head>

<body onload='history.go(+1);fncInicio()' onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/AltaClienteInicioAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="codSegmentoSeleccionado" styleId="codSegmentoSeleccionado"/>
<html:hidden property="tipoIdentificacion2Seleccionado" styleId="tipoIdentificacion2Seleccionado"/>
<html:hidden property="codCicloSeleccionado" styleId="codCicloSeleccionado"/>
<html:hidden property="flagDatosParticular" styleId="flagDatosParticular"/>
<html:hidden property="flagDatosEmpresa" styleId="flagDatosEmpresa"/>
<html:hidden property="paramIndFacturaElectronica" styleId="paramIndFacturaElectronica"/>
<html:hidden property="codCrediticiaExcepcionado" styleId="codCrediticiaExcepcionado"/>
<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
<html:hidden property="codOperadora" styleId="codOperadora"/>
<html:hidden property="codOperadoraSalvador" styleId="codOperadoraSalvador"/>
<html:hidden property="cantidadReferenciasCliente" styleId="cantidadReferenciasCliente"/>
<html:hidden property="flagTipCliente" styleId="flagTipCliente"/>
<html:hidden property="tipoIdentificacion1Seleccionado" styleId="tipoIdentificacion1Seleccionado"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Creación de Clientes&nbsp;
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr>
		     <td class="mensajeError">
		     	<div id="mensajes" >
		     		<logic:present name="mensajeError">
				     	  <bean:write name="mensajeError"/>
			     	</logic:present>
		     	</div>
		     </td>
		  </tr> 
		</table>		  
	  <P>
     <TABLE align="center" width="95%">			
        <tr>
           <td align="left" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Clasificacion del Cliente:
           </td>
	    </tr>
	    <tr>
          <td align="left" width="23%">
  			 Tipo de Cliente(*) 
  		  </td>
          <td align="left" width="30%">
			  <html:select name="AltaClienteInicioForm" property="tipoCliente" style="width:250px;" styleId="tipoCliente" onchange="tipoCliente_onchange(this);" > 
				<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayTipoCliente">
	              <html:optionsCollection property="arrayTipoCliente" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>	
          </td>
          
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifColor" value="1">          
          <td align="left" width="22%">
  			Color(*)
		  </td>
          <td align="left" width="25%">
				  <html:select name="AltaClienteInicioForm" property="codColor" style="width:200px;" styleId="codColor" onchange="ocultarMensajeError();"> 
				  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayColor">
			             <html:optionsCollection property="arrayColor" value="codClasificacion" label="desClasificacion"/>
		          	</logic:notEmpty>
		          </html:select>	
	      </td>		  
		</logic:equal>
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifColor" value="0">
			<td colspan="2"></td>
		</logic:equal>		       
		
        </tr>
        <tr>
        
       	<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifSegmento" value="1">        
          <td align="left" >
  			Segmentos(*)
		  </td>
          <td align="left" >
          		<html:select name="AltaClienteInicioForm" property="codSegmento" styleId="codSegmento" style="width:250px;" onchange="ocultarMensajeError();fncSeleccionaSegmento(this);"> 
					<html:option value="">- Seleccione -</html:option>
				</html:select>	
          </td>
		</logic:equal>          
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifSegmento" value="0">
			<td colspan="2"></td>
		</logic:equal>		       
		
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCrediticia" value="1">		
          <td align="left" >
  			Crediticia(*)
		  </td>
          <td align="left" >
				  <html:select name="AltaClienteInicioForm" property="codCrediticia" style="width:200px;" styleId="codCrediticia" onchange="ocultarMensajeError();"> 
					<logic:notEmpty name="AltaClienteInicioForm" property="arrayCrediticia">
		              <html:optionsCollection property="arrayCrediticia" value="codClasificacion" label="desClasificacion"/>
		          	</logic:notEmpty>
		          </html:select>				
          </td>
		</logic:equal>
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCrediticia" value="0">
			<td colspan="2"></td>
		</logic:equal>	
				
        </tr>
        <tr>
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCategoria" value="1">        
          <td align="left" >
               Categoria(*)
          </td>
          <td align="left" >
				  <html:select name="AltaClienteInicioForm" property="categoriaCliente" style="width:250px;" styleId="categoriaCliente" onchange="ocultarMensajeError();"> 
				  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayCategoriaCliente">
		              <html:optionsCollection property="arrayCategoriaCliente" value="codClasificacion" label="desClasificacion"/>
		          	</logic:notEmpty>
		          </html:select>	
          </td>
		</logic:equal>          
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCategoria" value="0">
			<td colspan="2"></td>
		</logic:equal>	
		
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCalificacion" value="1">				
          <td align="left" >
  			Calificaci&oacute;n(*)
		  </td>
          <td align="left" >
				   <html:select name="AltaClienteInicioForm" property="codCalificacion" style="width:200px;" styleId="codCalificacion" onchange="ocultarMensajeError();"> 
					<logic:notEmpty name="AltaClienteInicioForm" property="arrayCalificacion">
		              <html:optionsCollection property="arrayCalificacion" value="codClasificacion" label="desClasificacion"/>
		          	</logic:notEmpty>
		          </html:select>
          </td>
		</logic:equal>
		<logic:equal name="AltaClienteInicioForm" property="flagCtrlClasifCalificacion" value="0">
			<td colspan="2"></td>
		</logic:equal>	
		
        </tr>         
        <tr>
	      <td align="left" colspan="4">
	      <HR noshade>
	    </td>
        </tr>
        <tr>
           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Datos Generales:
           </td>
	    </tr>
        <tr>
          <td align="left" >
  			 Tipo Identificación (*)        
		  </td>
          <td align="left" >
			  <bean:define id="codOperadoraSalvador" name="AltaClienteInicioForm" property="codOperadoraSalvador" type="java.lang.String"/>          
			  
			  <html:select name="AltaClienteInicioForm" property="tipoIdentificacion1" style="width:250px;" styleId="tipoIdentificacion1"  onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacion1');fncSeleccionaTipoIdentificacion1(this);fncLimpiaDatos();"> 
				  <logic:equal name="AltaClienteInicioForm" property="codOperadora" value="<%= codOperadoraSalvador %>"> 
				  	<html:option value="">- Seleccione -</html:option>
				  </logic:equal>	
			  	  <logic:notEmpty name="AltaClienteInicioForm" property="arrayIdentificador1">
	                <html:optionsCollection name="AltaClienteInicioForm" property="arrayIdentificador1" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	  </logic:notEmpty>
	          </html:select>
	      </td>          
          <td align="left" >
  			 &nbsp;N&uacute;m. Identif.(*)
		  </td>
          <td align="left" >          
			  &nbsp;<html:text name="AltaClienteInicioForm" property="numeroIdentificacion1" size="25" maxlength="20" style="text-transform: uppercase;" styleId="numeroIdentificacion1" 
					onblur="upperCase(this);"  onchange="ocultarMensajeError(); fncLimpiaDatos();"
					onkeypress="soloCaracteresValidos();valNumeroIdentificacion('numeroIdentificacion1','tipoIdentificacion1');"/>
					<label for="numeroIdentificacion1" id="lbNumeroIdentificacion1" class="textoAzul"></label>
					<!--  Inicio P-CSR-11002 JLGN 29-04-2011-->
					<!-- INICIO MA-180654 HOM					
						<html:button value="BURO" style="color:black;" property="btnBuro" styleId="btnBuro" onclick="fncCursorEspera();ocultarMensajeError();fncConsultaBuro();"/>	-->
						<html:button value="BURO" style="color:black;" property="btnBuro" styleId="btnBuro" onclick="fncCursorEspera();ocultarMensajeError();fncPopUpAbonadosAct();"/>
					<!-- FIN MA-180654 HOM -->							
        			<!--  Fin P-CSR-11002 JLGN 29-04-2011 -->					
		  </td>		  
        </tr>  
        <!-- Inicio P-CSR-11002 JLGN 14-11-2011 -->
        <tr>
        <td  colspan="4" align="left" width="100%">
        <div id="divCargoBuro" style="display:none">
		<table width="100%" border="0" >
			<tr>
				<td align="left" width="53%"><b>Limite de Credito del Cliente: </b><bean:write name="datosClienteBuro3" property="limiteDeCredito" />&nbsp;<b>Colones</b></td>
				<td align="left" width="47%"><b>Calificaci&oacute;n del Cliente: </b><bean:write name="datosClienteBuro3" property="resulCalificacion" /></b><BR></td>
			</tr>
			<tr>
				<td align="left" width="53%"><b>Limite de Credito Disponible: </b><bean:write name="datosClienteBuro3" property="limiteDeCreditoConCargo" />&nbsp;<b>Colones</b></td>
				<td align="left" width="47%"></td>
			</tr>	
		</table>
		</td>
		</tr>
		<!-- Fin P-CSR-11002 JLGN 14-11-2011 -->
        <tr>
        <!-- Inicio P-CSR-11002 JLGN 05-06-2011 -->
        <td colspan="4" align="left" width="100%">
			<div id="divUsuarioPass" style="display:none">	        
        	<table width="100%" align="left">
		        <tr>
				    <td align="left" colspan="4"><HR noshade></td>
				</tr>	        	
		        <tr>  
		          <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
				   Ingreso Password
				  </td>
		        </tr>
		        <tr>
		          <td align="left" width="23%">
		  			Password        
				  </td>
		          <td align="left" width="30%" >
					  <html:password name="AltaClienteInicioForm" styleId="passValidacion" property="passValidacion" size="20" maxlength="20"/>
		          </td>
		          <td align="left" width="22%">
		  			<html:button value="VALIDAR" property="btnValidar" style="width:70px;color:black" styleId="btnValidar" onclick="fncCursorEspera();ocultarMensajeError();fncValidarPass();"/>
				  </td>
				  <td align="left" width="25%">
				  </td>
		        </tr>
		        <tr>
				    <td align="left" colspan="4"><HR noshade></td>
				</tr>
        	</table>
        </td>
        <!-- Fin P-CSR-11002 JLGN 05-06-2011 -->
        </tr>          
        <!-- Inicio P-CSR-11002 JLGN 25-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
        <tr>
          <td align="left" >
  			 Tipo Identificaci&oacute;n        
		  </td>
          <td align="left" >
			  <html:select name="AltaClienteInicioForm" property="tipoIdentificacion2" style="width:250px;" styleId="tipoIdentificacion2" onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacion2');" >
 			   <html:option value="">- Seleccione -</html:option>
 			   	<logic:notEmpty name="AltaClienteInicioForm" property="arrayIdentificador2">
	              <html:optionsCollection property="arrayIdentificador2" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          
          <td align="left" >
  			 &nbsp;N&uacute;m. Identif.        
		  </td>
          <td align="left" >
			  &nbsp;<html:text name="AltaClienteInicioForm" property="numeroIdentificacion2" size="37" maxlength="20" style="text-transform: uppercase;" styleId="numeroIdentificacion2"   
					onblur="upperCase(this);"  onchange="ocultarMensajeError();"
					onkeypress="soloCaracteresValidos(); valNumeroIdentificacion('numeroIdentificacion2','tipoIdentificacion2'); "/>
					&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacion2" id="lbNumeroIdentificacion2" class="textoAzul"></label>					
		  </td>
        </tr> 
        Fin P-CSR-11002 JLGN 25-04-2011-->
        <tr>
          <td align="left" >
  			Ciclo de Facturaci&oacute;n(*) 
		  </td>
          <td align="left">
			  <html:select name="AltaClienteInicioForm" property="cicloFact" style="width:250px;" styleId="cicloFact" onchange="ocultarMensajeError();fncSeleccionaCiclo(this);" >
			  	<html:option value="">- Seleccione -</html:option>
	          </html:select>
          </td>
	  	  <td align="left" >&nbsp;Factura Electr&oacute;nica(*)</td>
	  	  <td align="left" >
	     		  &nbsp;<html:select name="AltaClienteInicioForm" property="registroFacturacion" style="width:200px;" styleId="registroFacturacion" onchange="ocultarMensajeError();"> 
					<html:option value="1">SI</html:option>
					<html:option value="0">NO</html:option>
		          </html:select>	
	       </td>           
        </tr>  
        
        <tr>          
          <td align="left" >  
           Correo
          </td>
          <td align="left" >
			<html:text name="AltaClienteInicioForm" property="correo" style="text-transform: uppercase;" styleId="correo" size="37" maxlength="50" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);validaCorreo(this,correo);" onchange="ocultarMensajeError();"/>
          </td>
	      <td align="left" >
	      	&nbsp;Env&iacute;o Factura F&iacute;sica
		  </td>
			<td align="left" >
     		  &nbsp;<html:select name="AltaClienteInicioForm" property="envioFacturaFisica" style="width:200px;" styleId="envioFacturaFisica" onchange="ocultarMensajeError();" > 
				<html:option value="1">SI</html:option> 
				<html:option value="0">NO</html:option>
	          </html:select>			  
           </td>	      
        </tr>
        <!-- Inicio P-CSR-11002 JLGN 24-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
        <tr>          
           <td align="left" >
			Operadora Anterior
		  </td>
          <td align="left" colspan="3">
			  <html:select name="AltaClienteInicioForm" property="operadoraAnterior" style="width:350px;" styleId="operadoraAnterior" onchange="ocultarMensajeError();"> 
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="AltaClienteInicioForm" property="arrayOperadora">
	              <html:optionsCollection property="arrayOperadora" value="codigoOperadora" label="descripcionOperadora"/>
	          	</logic:notEmpty>
	          </html:select>	
          </td>
        </tr> 
         Fin P-CSR-11002 JLGN 24-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente-->
        <tr>
          <td align="left" >
  			Tel&eacute;fono
		  </td>
          <td align="left">
			<html:text name="AltaClienteInicioForm" property="telefono" style="text-transform: uppercase;" styleId="telefono" size="37" maxlength="15" onkeypress="onlyInteger();" onchange="ocultarMensajeError();"/>
          </td>  
          
          <td align="left" >
			&nbsp;Mensajes Promocionales
		  </td>
			<td align="left" >
			  <!--P-CSR-11002 JLGN 05-08-2011 -->
			  &nbsp;<html:select name="AltaClienteInicioForm" property="mensajesPromocionales" style="width:200px;" styleId="mensajesPromocionales" onchange="ocultarMensajeError();"> 
				  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayMensajesPromocionales">
			             <html:optionsCollection property="arrayMensajesPromocionales" value="codMensaje" label="desMensaje"/>
		          	</logic:notEmpty>
		          </html:select>
     		  <!-- P-CSR-11002 JLGN 05-08-2011  
     		    &nbsp;<html:select name="AltaClienteInicioForm" property="mensajesPromocionales" style="width:200px;" styleId="mensajesPromocionales" onchange="ocultarMensajeError();" > 
				<html:option value="">- Seleccione -</html:option>
				<html:option value="S">SI</html:option> 
				<html:option value="N">NO</html:option>
	          </html:select>-->
           </td> 
          
        </tr>
        <!-- Inicio P-CSR-11002 JLGN 24-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente -->
        <tr>
          <td align="left" >
  			Cuenta Facebook
		  </td>
          <td align="left">
			<html:text name="AltaClienteInicioForm" property="cuentaFacebook" style="text-transform: uppercase;" styleId="cuentaFacebook" size="37" maxlength="50" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
          </td>  
          
          <td align="left" >
			&nbsp;Cuenta Twitter
		  </td>
			<td align="left" >
     		  &nbsp;<html:text name="AltaClienteInicioForm" property="cuentaTwitter" style="text-transform: uppercase;" styleId="cuentaTwitter" size="37" maxlength="50" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>		  
           </td> 
          
        </tr>
        <!-- Fin P-CSR-11002 JLGN 24-04-2011-->                 	  
		 <!-- Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente        
        <tr id="trReferencias0" style="display: none;">
	      <td align="left" colspan="4">
	      <HR noshade>
	    </td>
        </tr>	    	   
	    <tr id="trReferencias1" style="display: none;" >
           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Referencia del Cliente:
           </td>
	    </tr>
	    <tr id="trReferencias2" style="display: none;">
          <td align="left" >
			<a href="javascript:fncReferencias();" onclick="ocultarMensajeError();" title="Ingreso y visualización de las referencias del cliente"><FONT color="#0000ff">Agregar Referencias</FONT></a>
		  </td>
        </tr>
         Fin P-CSR-11002 JLGN 26-04-2011 -->

        <tr>
	      <td align="left" colspan="4"><HR noshade></td>
        </tr>  

        <tr>  
          <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">  
            Usuario Autorizado
          </td>
        </tr>
        <tr>
          <td align="left" >
  			 Tipo Identificaci&oacute;n </td>
          <td align="left" >
			  <html:select name="AltaClienteInicioForm" property="tipoIdentificacionUsuarioAut" style="width:200px;" styleId="tipoIdentificacionUsuarioAut" onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacionUsuarioAut');">
		  		<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td align="left" >
  			 N&uacute;mero Identificaci&oacute;n 
  		  </td>
          <td align="left" >
			<html:text name="AltaClienteInicioForm" property="numeroIdentificacionUsuarioAut" size="37" maxlength="20"  style="text-transform: uppercase;" styleId="numeroIdentificacionUsuarioAut"
					onblur="upperCase(this);"  onchange="ocultarMensajeError();"
					onkeypress="soloCaracteresValidos(); valNumeroIdentificacion('numeroIdentificacionUsuarioAut','tipoIdentificacionUsuarioAut');"/>
					&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionUsuarioAut" id="lbNumeroIdentificacionUsuarioAut" class="textoAzul"></label>					
		  </td>
        </tr>
        <tr>  
          <td align="left" >
  			Nombres
		  </td>
          <td align="left" colspan="3" >
			<html:text name="AltaClienteInicioForm" property="nombresUsuarioAut" styleId="nombresUsuarioAut" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" size="60" maxlength="50" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>          
		  </td>
		</tr>
		<tr>
          <td align="left">
			Apellido1
		  </td>
          <td align="left" >
			<html:text name="AltaClienteInicioForm" property="apellido1UsuarioAut" styleId="apellido1UsuarioAut" style="text-transform: uppercase;"  size="37" maxlength="30" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
		  </td>
          <td align="left" >
			Apellido2     
		  </td>
          <td align="left" >
			<html:text name="AltaClienteInicioForm" property="apellido2UsuarioAut" styleId="apellido2UsuarioAut" style="text-transform: uppercase;"  size="37" maxlength="30" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
		  </td>
        </tr>
        <tr>
        <td colspan="4" align="left" width="100%">
			<div id="divUsuarioLegal" style="display:none">	        
        	<table width="100%" align="left">
		        <tr>
				    <td align="left" colspan="4"><HR noshade></td>
				</tr>	        	
		        <tr>  
		          <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
				   Usuario Legal
				  </td>
		        </tr>
		        <tr>
		          <td align="left" width="22%">
		  			Tipo Identificaci&oacute;n        
				  </td>
		          <td align="left" width="30%">
					  <html:select name="AltaClienteInicioForm" property="tipoIdentificacionUsuarioLegal" style="width:200px;" styleId="tipoIdentificacionUsuarioLegal" onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacionUsuarioLegal');">
				  		<html:option value="">- Seleccione -</html:option>
					  	<logic:notEmpty name="AltaClienteInicioForm" property="arrayIdentificadorCliente">
			              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
			          	</logic:notEmpty>
			          </html:select>
		          </td>
		          <td align="left" width="22%">
		  			N&uacute;mero Identificaci&oacute;n
				  </td>
		          <td align="left" width="25%">
					<html:text name="AltaClienteInicioForm" property="numeroIdentificacionUsuarioLegal" size="37" maxlength="20" style="text-transform: uppercase;" styleId="numeroIdentificacionUsuarioLegal"
							onblur="upperCase(this);"  onchange="ocultarMensajeError();"
							onkeypress="soloCaracteresValidos();valNumeroIdentificacion('numeroIdentificacionUsuarioLegal','tipoIdentificacionUsuarioLegal'); "/>
							&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionUsuarioLegal" id="lbNumeroIdentificacionUsuarioLegal" class="textoAzul"></label>
				  </td>
		        </tr>
		        <tr>  
		          <td align="left" >
		  			Nombres
				  </td>
		          <td align="left" colspan="3" >
					<html:text name="AltaClienteInicioForm" property="nombresUsuarioLegal" style="text-transform: uppercase;" styleId="nombresUsuarioLegal" onkeypress="soloCaracteresValidos();" size="60" maxlength="50" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>          
				  </td>
		        </tr>
		        <tr>
		          <td align="left" >
					Apellido1
				  </td>
		          <td align="left" >
					<html:text name="AltaClienteInicioForm" property="apellido1UsuarioLegal" style="text-transform: uppercase;" styleId="apellido1UsuarioLegal"  size="37" maxlength="30" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
				  </td>
		          <td align="left" >
					Apellido2   
				  </td>
		          <td align="left" >
					<html:text name="AltaClienteInicioForm" property="apellido2UsuarioLegal" style="text-transform: uppercase;" styleId="apellido2UsuarioLegal"  size="37" maxlength="30" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
				  </td>
		        </tr>
        	</table>
        </td>
        </tr>
	</table>
     <P>
     <P>
     <P>
     <P>
     <P>     
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="50%" >
            <html:button  value="DATOS PARTICULAR" style="width:130px;color:black" property="btnParticular" styleId="btnParticular" onclick="fncCursorEspera();ocultarMensajeError();fncDatosParticular();"/>
            <html:button  value="DATOS EMPRESA" style="width:130px;color:black" property="btnEmpresa" styleId="btnEmpresa" onclick="fncCursorEspera();ocultarMensajeError();fncDatosEmpresa();"/>
        </td>
        <td width="25%" align="left">
        	<bean:define id="codModuloSolicitudVenta" name="AltaClienteInicioForm" property="codModuloSolicitudVenta" type="java.lang.String"/>
			<logic:equal name="AltaClienteInicioForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>"> 
	           	<html:button value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();ocultarMensajeError();fncCancelar()"/>
           	</logic:equal>
        </td>
        <td width="25%" align="right">
              <html:button  value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="fncCursorEspera();ocultarMensajeError();fncDatosTributarios();"/>
        </td>
      </tr>
    </TABLE> 
     <P>    
   <TABLE align="center" width="95%">			
      <tr>
		  <td align="left"><i>(*):  Dato es obligatorio</i></td>
	  </tr>	   
   </TABLE>   
</html:form>

<!-- Inicio MA 180654 -->
<html:form action="/DatosAbonadosActAction.do" styleId="formDatosAbonadosActAction" target="frmOculto">
	<input type="hidden" name="strNumIdentConsAbo" id="strNumIdentConsAbo"/>
	<input type="hidden"  name="strTipIdentConsAbo" id="strTipIdentConsAbo"/>	
	<html:hidden property="opc" value="buscarAbonados" styleId="opc"/>
</html:form>
<iframe name="frmOculto"
	style="position: absolute; width: 220px; height: 50px; z-index: 1000; border-style: solid; border-width: 1; left: 80; top: 180; display: none;"
	ID="newmenuitem" MARGINHEIGHT=0 MARGINWIDTH=0 NORESIZE FRAMEBORDER=0 SCROLLING=NO</iframe>	
<!-- Fin MA 180654 -->	

</body>
</html:html>