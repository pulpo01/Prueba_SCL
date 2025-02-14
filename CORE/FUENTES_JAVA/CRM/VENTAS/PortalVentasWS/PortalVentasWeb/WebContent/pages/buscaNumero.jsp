<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display" %>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JBuscaNumeroAJAX.js'></script>
<script>
	window.history.forward(1);
	
	function fncInicioOriginal(){

		fncMostrarFiltros("inicio");

		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");

		var numeroSel = document.getElementById("numeroSel");

		if (numeroSel.value!=""){
   		    document.body.style.cursor="wait";
			JBuscaNumeroAJAX.cargaNumeroSel(numeroSel.value, fncResultadoObtenerNumeracion);	
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
	
	function fncInicio() {
		fncMostrarFiltros("inicio");
		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		var numeroSel = document.getElementById("numeroSel");
		if (numeroSel.value != "") {
			document.getElementById("divResultadoBusqueda").style["display"] = "";
			document.getElementById("divResultadoNumero").style["display"] = "";
			document.getElementById("divResultadoRango").style["display"] = "";
		}
		else {
			
			var rdNumeroSel = document.getElementById("rdNumeroSel");
			var rdRangoSel = document.getElementById("rdRangoSel");
			if (rdNumeroSel != null || rdRangoSel != null) {
				document.getElementById("divResultadoBusqueda").style["display"] = "";
			}
			if (rdNumeroSel != null ) {
				document.getElementById("divResultadoNumero").style["display"] = "";
				document.getElementById("divResultadoRango").style["display"] = "none";
			}
			else {
				document.getElementById("divResultadoNumero").style["display"] = "none";
				document.getElementById("divResultadoRango").style["display"] = "";
			}
		}
		document.forms[0].busquedaRangoInfAux.onpaste = function() { return fncOnPasteValidaNumero(); }
		document.forms[0].busquedaRangoSupAux.onpaste = function() { return fncOnPasteValidaNumero(); } 	
		document.forms[0].prefijo.onpaste = function() { return fncOnPasteValidaNumero(); }
		document.forms[0].numeroRango.onpaste = function() { return fncOnPasteValidaNumero(); }
		
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
	}
	
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
	
	function fncSeleccionaTipoBusqueda(rdTipoBusqueda){
			var tipoBusquedaAnt = document.getElementById("tipoBusqueda").value;		
			var tipoBusquedaNue = rdTipoBusqueda.value;
			document.getElementById("tipoBusqueda").value = tipoBusquedaNue;
							
			if (tipoBusquedaAnt!=tipoBusquedaNue){
				fncValidarAnularReservaNumAut();//si ya se busco por numeracion automatica, se debe reponer numero anterior
				fncMostrarFiltros("seleccion");//activa o desactiva controles de pagina
			}
	}
	
	function fncBuscar(){
		var tipoBusqueda = document.getElementById("tipoBusqueda");
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		var rangoInf = document.getElementById("busquedaRangoInfAux");
		var rangoSup = document.getElementById("busquedaRangoSupAux");
				
		if (tipoBusqueda.value==""){
			alert("Debe Ingresar Tipo B\u00FAsqueda");
			return false;
		}
		if (tipoBusqueda.value == "M"){ //Manual
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
			    document.body.style.cursor="wait";
				JBuscaNumeroAJAX.obtenerNumeracionReutilizable(rangoInf.value,rangoSup.value,fncResultadoObtenerNumeracion);
			}else if (codCriterioBusqueda.value == "RA"){
			    document.body.style.cursor="wait";
				JBuscaNumeroAJAX.obtenerNumeracionRango(rangoInf.value,rangoSup.value,fncResultadoObtenerNumeracion);
			}else{
			    document.body.style.cursor="wait";
				JBuscaNumeroAJAX.obtenerNumeracionReservada(fncResultadoObtenerNumeracion);			
			}
		}
		
		if (tipoBusqueda.value == "A"){//Automatica
	      	fncValidarAnularReservaNumAut();//si ya se busco por numeracion automatica, se debe reponer numero anterior		
	      	 document.body.style.cursor="wait";
			JBuscaNumeroAJAX.obtenerNumeracionAutomatica(fncResultadoObtenerNumeracionAutomatica);
		}
		
		if (tipoBusqueda.value == "C"){//Carrier
			alert("Busqueda no Implementada");
			return;
		}
		
		document.getElementById("btnBuscar").disabled=true;
		document.getElementById("divResultadoBusqueda").style["display"] = "none";

	}
	
	function fncResultadoObtenerNumeracion(data){
		document.getElementById("btnBuscar").disabled=false;
		
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
		document.getElementById("numeroSel").value = "";	
		document.getElementById("rangoInfSel").value = "";	
		document.getElementById("rangoSupSel").value = "";	   
		document.getElementById("opcion").value = "buscarNumero";
	   	document.forms[0].submit();
	   	document.body.style.cursor = "auto";
	}
	
	function fncResultadoObtenerNumeracionAutomatica(data){
		//document.getElementById("btnBuscar").disabled=false;
		
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
	        	return;
	        }
	        
	        //obtener nombre tabla , categoria, y fecha de baja
	        document.getElementById("tablaNumeracionAut").value = data['tablaNumeracion'];
	        document.getElementById("categoria").value = data['categoria'];	        
	        document.getElementById("numeroSel").value = data['numero'];      
	        document.getElementById("fechaBaja").value = data['fechaBaja'];	       
	        
	         

	    }//fin if (data!=null)
	    
	    document.body.style.cursor = "auto";
		  
		//se reserva inmediatamente y vuelve a pagina principal
		fncAceptar();
	}
	
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
	
	function fncValidarAnularReservaNumAut(){
		var tablaNumeracionAut = document.getElementById("tablaNumeracionAut");
		var rdNumeroSel = document.getElementById("rdNumeroSel");
		if (tablaNumeracionAut.value!="" && rdNumeroSel != null){
			var categoria = document.getElementById("categoria");
			JBuscaNumeroAJAX.reponerNumeracionAutomatica(rdNumeroSel.value, tablaNumeracionAut.value, categoria.value, fncResultadoReponerNumeracionAutomatica);
			//limpia variable
	        document.getElementById("tablaNumeracionAut").value = "";
			document.getElementById("categoria").value = "";
			document.getElementById("fechaBaja").value = "";  
			
		}
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
	
	function fncAceptar(){
		var numeroSel = document.getElementById("numeroSel");
		if (numeroSel==null || numeroSel.value==""){
			alert("Debe seleccionar un n\u00FAmero");
			return false;
		}
		activarDesactivarControles(true);	
		
		if (document.getElementById("indNumeroPiloto").value == "1"){
		
			document.getElementById("opcion").value = "asociarRangosPiloto";
			
		} else if (document.getElementById("indNumeroCortoSMS").value == "1"){
		
			document.getElementById("opcion").value = "asociarNumerosCortos";
						
		}else {
		
			document.getElementById("opcion").value = "aceptar";		
		}
	   	document.forms[0].submit();
	}	

	//(+)---- cancelar ----------------	
	function fncCancelar(){
	
		activarDesactivarControles(true);
		//verifica si ingreso numeracion automatica y anula si corresponde
		var tablaNumeracionAut = document.getElementById("tablaNumeracionAut");
		var rdNumeroSel = document.getElementById("rdNumeroSel");
		if (tablaNumeracionAut.value!="" && rdNumeroSel != null){
			var categoria = document.getElementById("categoria");
			JBuscaNumeroAJAX.reponerNumeracionAutomatica(rdNumeroSel.value, tablaNumeracionAut.value, categoria.value, fncResultadoCancelar);
		}else{
	        document.getElementById("opcion").value = "cancelar";
    		document.forms[0].submit();
		}
	}

	function fncResultadoCancelar(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
       			activarDesactivarControles(false);
	        	return;
	        }
	        //limpia variable
	        document.getElementById("tablaNumeracionAut").value = "";
			document.getElementById("categoria").value = "";
			document.getElementById("fechaBaja").value = "";			
	        
	        //continua cancelar
	        document.getElementById("opcion").value = "cancelar";
    		document.forms[0].submit();
	        
	    }//fin if (data!=null)
	}
	
	//(-)---- cancelar ----------------
		
	function fncVolver(){
	
		if (confirm("¿Desea volver al men\u00FA?")){
			activarDesactivarControles(true);
			var win = parent
			win.fncActDesacMenu(false);
		
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	

	function activarDesactivarControles(valor){
		document.getElementById("btnAceptar").disabled = valor;
		document.getElementById("btnCancelar").disabled = valor;
		//document.getElementById("btnVolver").disabled = valor;
		document.getElementById("btnBuscar").disabled = valor;		
	}	
	
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

	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }		
		
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/BuscaNumeroAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="tipoBusqueda" styleId="tipoBusqueda"/>
<html:hidden property="numeroSel" styleId="numeroSel"/>
<html:hidden property="busquedaRangoInf" styleId="busquedaRangoInf"/>
<html:hidden property="busquedaRangoSup" styleId="busquedaRangoSup"/>
<html:hidden property="rangoInfSel" styleId="rangoInfSel"/>
<html:hidden property="rangoSupSel" styleId="rangoSupSel"/>
<html:hidden property="largoPrefijo" styleId="largoPrefijo"/>
<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
<html:hidden property="tablaNumeracionAut" styleId="tablaNumeracionAut"/>
<html:hidden property="categoria" styleId="categoria"/>
<html:hidden property="fechaBaja" styleId="fechaBaja"/>
<html:hidden property="indNumeroPiloto" styleId="indNumeroPiloto"/>
<html:hidden property="indNumeroCortoSMS" styleId="indNumeroCortoSMS"/>

	
      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">B&uacute;squeda Numeraci&oacute;n&nbsp;
         </h2></td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr >
		     <td class="mensajeError"><div id="mensajes" class="mensajeError">
		     <bean:write name="BuscaNumeroForm" property="mensajeError" />
		     </div></td>
		  </tr> 
		</table>		  
	  <P>
	  
<table width="90%">
<tr><td width="100%">
      <table width="100%">	  
      <tr>
	      <td width="15%">&nbsp;</td>
          <td align="left" width="25%" >Tipo B&uacute;squeda</td>
 		  <td align="left" width="35%">
 		  	<html:radio onclick="ocultarMensajeError();fncSeleccionaTipoBusqueda(this);" name="BuscaNumeroForm" property="rdTipoBusqueda" styleId="rdTipoBusqueda" value="M">MANUAL&nbsp;&nbsp;</html:radio>
 		  	<html:radio onclick="ocultarMensajeError();fncSeleccionaTipoBusqueda(this);" name="BuscaNumeroForm" property="rdTipoBusqueda" styleId="rdTipoBusqueda" value="A">AUTOMATICA&nbsp;&nbsp;</html:radio>
		  </td>  	  
		  <td width="25%"></td>  	  
      </tr>
      <tr>
      	<td width="15%"></td>
      	<td align="left" width="25%">Buscar N&uacute;meros</td>
      	<td align="left" width="35%">
      		<html:select name="BuscaNumeroForm" property="codCriterioBusqueda" style="width:200px;" styleId="codCriterioBusqueda" onchange="ocultarMensajeError();fncMostrarFiltros();"> 
      			<html:option value="">- Seleccione -</html:option>
      			<html:option value="RE">RESERVADOS</html:option>
      			<html:option value="RU">REUTILIZABLES</html:option>
      			<html:option value="RA">RANGO</html:option>				
      		</html:select>	
      	</td>
      	<td width="25%">&nbsp;</td>
      </tr>
      </table>
 </td></tr>
 
 <tr><td> 
    <div id="divFiltroRango" style="display:none">    
    <table width="100%">    
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%">L&iacute;mite Inferior Rango</td>   
          <td align="left" width="35%">
	          <input type="text" onchange="ocultarMensajeError();" id="busquedaRangoInfAux" size="35" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>" 
	          value="<bean:write name="BuscaNumeroForm" property="busquedaRangoInf"/>" onkeypress="onlyInteger();">
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
     <tr>  
	      <td>&nbsp;</td>
          <td>L&iacute;mite Superior Rango</td>   
          <td align="left">
	          <input type="text" onchange="ocultarMensajeError();" id="busquedaRangoSupAux" size="35" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>" 
	          value="<bean:write name="BuscaNumeroForm" property="busquedaRangoSup"/>" onkeypress="onlyInteger();">
          </td>             
          <td>&nbsp;</td>      
	 </tr>	
     <tr>  
	      <td colspan="2">&nbsp;</td>	<html:hidden property="largoPrefijo"/>
          <td align="left">Prefijo&nbsp;&nbsp;
	          <input type="text" onchange="ocultarMensajeError();" id="prefijo" size="10" maxlength="<bean:write name="BuscaNumeroForm" property="largoPrefijo"/>" 
	          value="" onkeyup="fncPrefijo(this);" onkeypress="onlyInteger();">
          </td>             
          <td>&nbsp;</td>      
	 </tr>	
	 </table> 
     </div>
 </td></tr>

 <tr><td> 
	<table width="100%">    
     <tr>
	      <td width="15%">&nbsp;</td>
          <td width="25%">&nbsp;</td>   
          <td width="35%">&nbsp;</td>             
          <td align="left" width="25%">
			<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscar" styleId="btnBuscar" onclick="fncCursorEspera();ocultarMensajeError();fncBuscar();"/>          
          </td>  
     </tr>     
     <tr>
	     <td colspan="4">
	      <HR noshade>
	    </td>
	 </tr>       
    </table> 
 </td></tr>    
 <tr><td> 
    <div id="divNumeroSelRango" style="display:none">    
    <table width="100%">    
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%">N&uacute;mero</td>   
          <td align="left" width="35%">
              <input type="text" onchange="ocultarMensajeError();" id="numeroRango" size="20" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>"  value="" onkeypress="onlyInteger();" onblur="fncValidarNumeroRango(this);">
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
	 </table> 
     </div>
 </td></tr>
 
 </table> 
     
<P>
     <div id="divResultadoBusqueda" style="display:none">
	  <h2 align="center">Coincidencias:<br>
	  	  De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.
	  </h2>
	  </div>
     <P>
     
    <div id="divResultadoNumero" style="display:none" align="center">
	<display:table  id="numeros" name="listaNumeros" scope="session" pagesize="10" requestURI=""  width="90%" >
		<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="8%">
			<input type="radio" name="rdNumeroSel" onclick="ocultarMensajeError();fncSeleccionaNumero(this);" value="<bean:write name="numeros" property="numCelular"/>">
		</display:column>
		<display:column property="numCelular" title = "N&uacute;mero Celular" headerClass="textoColumnaTabla" width="%"/>
	</display:table>    
	</div> 
	
	<div id="divResultadoRango" style="display:none" align="center">
	<display:table  id="numeros" name="listaNumerosRango" scope="session" pagesize="10" requestURI=""  width="90%" >
		<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="8%">
			<input type="radio" name="rdRangoSel" onclick="ocultarMensajeError();fncSeleccionaRango('<bean:write name="numeros" property="numDesde"/>','<bean:write name="numeros" property="numHasta"/>');" value="<bean:write name="numeros" property="numDesde"/>">
		</display:column>
		<display:column property="numDesde" title = "N&uacute;mero Celular" headerClass="textoColumnaTabla" width="46%"/>
		<display:column property="numHasta" title = "Fin Rango" headerClass="textoColumnaTabla" width="numHasta%"/>		
	</display:table>    
	</div> 
	
     <P>
     <P>
    </p><TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="50%" align="left">
        </td>
        <td align="right" width="25%">
        	<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();ocultarMensajeError();fncCancelar()"/>
        </td>
        <td align="right" width="25%">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="fncCursorEspera();ocultarMensajeError();fncAceptar();"/>
        </td>
        
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>
