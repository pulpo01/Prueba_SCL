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
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JDatosEmpresaAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ultimoObjetoFoco;
	var flgSubmitAceptar = false;
	var validandoIdentificacion=false;
	var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";
		
	function fncInicio(){
			var tipoIdentificacionRepLegal = document.getElementById("tipoIdentificacionRepLegal");
						
			if (tipoIdentificacionRepLegal.value == codigoNIT){
				document.getElementById("lbNumeroIdentificacionRepLegal").innerHTML = formatoNIT;
			}
			fncCursorNormal();
	}
	
	function fncAceptar() {
	  	if (validandoIdentificacion) {//validando nit
	  		flgSubmitAceptar = true;
	  		return;
	  	}
  		flgSubmitAceptar = false;
	  	if (document.getElementById("nombreEmpresa").value == "") {
	  	   alert("Debe ingresar nombre de la empresa");
	  	   return false; 
	  	}
	  	var datosRepLegalMandatorio = document.getElementById("datosRepLegalMandatorio");
	  	if (datosRepLegalMandatorio.value == "SI") {
		  	var tipoIdentificacionRepLegal = document.getElementById("tipoIdentificacionRepLegal");
		  	if (tipoIdentificacionRepLegal == null || tipoIdentificacionRepLegal.value == "") {
		  		alert("Debe seleccionar tipo de identificación del Representante Legal");
	  	   		return false; 
	  		}
	  		var numeroIdentificacionRepLegal = document.getElementById("numeroIdentificacionRepLegal");
	  		if (numeroIdentificacionRepLegal == null || numeroIdentificacionRepLegal.value == "") {
		  		alert("Debe ingresar N° de identificación del Representante Legal");
	  	   		return false; 
	  		}
	  		var nombreRepLegal = document.getElementById("nombreRepLegal");
	  		if (nombreRepLegal == null || nombreRepLegal.value == "") {
		  		alert("Debe ingresar nombre del Representante Legal");
	  	   		return false; 
	  		}
	  	}
	  	document.getElementById("opcion").value = "aceptar";
    	document.forms[0].submit();
	}
	
	//(+)-- CANCELAR --
 	function fncCancelar() {
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}
 	//(-)-- CANCELAR --
 	
	function fncValidaTipoIdentificacion(tipoIdentSel, numIdentText) {
		if (!validandoIdentificacion) {
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				JDatosEmpresaAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
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
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value = "";
				ultimoObjetoFoco.focus();
			}
			else {
				ultimoObjetoFoco.value = data["identificadorFormateado"];
				validandoIdentificacion = false;				
				if (flgSubmitAceptar) fncAceptar(); //valida  				
			}
			validandoIdentificacion = false;
		}
	}
	
	//Muestra formato NIT
	function fncCambiarLabelNIT(tipoIdent, label){
		if (tipoIdent.value==codigoNIT)	label.innerHTML = formatoNIT;
		else							label.innerHTML = "";
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

	//P-CSR-11002 07/04/2011
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
<body onload="history.go(+1);fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/DatosEmpresaAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="datosRepLegalMandatorio" styleId="datosRepLegalMandatorio"/>
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Creación de Clientes - Datos Cliente Empresa
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%" align="center" border="0">
		<tr>
			<td align="left" width="25%">Nombre Empresa (*):</td>
			<td align="left" width="75%" colspan="3"><html:text name="DatosEmpresaForm"
				property="nombreEmpresa" style="text-transform: uppercase;" styleId="nombreEmpresa"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="50"
				onchange="ocultarMensajeError();" /></td>
		</tr>
		<tr>
			<td align="left">Raz&oacute;n Social</td>
			<td align="left" colspan="3"><html:text name="DatosEmpresaForm" property="razonSocial"
				style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" styleId="razonSocial"
				onblur="upperCase(this);" size="60" maxlength="50" onchange="ocultarMensajeError();" /></td>
		</tr>
		<tr>
			<td align="left">Patente Comercio:</td>
			<td align="left" colspan="3"><html:text name="DatosEmpresaForm" property="patenteComercio"
				style="text-transform: uppercase;" styleId="patenteComercio" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="90" maxlength="90" onchange="ocultarMensajeError();" /></td>
		</tr>
		<tr>
			<td align="left" colspan="4">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td align="left" colspan="4"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
			Representante Legal del Cliente:</td>
		</tr>
		<tr>
			<td align="left" width="26%"><logic:equal name="DatosEmpresaForm"
				property="datosRepLegalMandatorio" value="SI">
				Tipo Identificaci&oacute;n (*):
			</logic:equal> <logic:equal name="DatosEmpresaForm" property="datosRepLegalMandatorio" value="NO">
				Tipo Identificaci&oacute;n:
			</logic:equal></td>
			<td align="left" width="32%"><html:select name="DatosEmpresaForm"
				property="tipoIdentificacionRepLegal" style="width:200px;" styleId="tipoIdentificacionRepLegal"
				onchange="ocultarMensajeError(); limpiaNumeroIdentificacion('numeroIdentificacionRepLegal');">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosEmpresaForm" property="arrayIdentificadorCliente">
					<html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif"
						label="descripcionTipIdentif" />
				</logic:notEmpty>
			</html:select></td>
			<td align="left" width="21%"><logic:equal name="DatosEmpresaForm"
				property="datosRepLegalMandatorio" value="SI">
				N&uacute;m. Identificaci&oacute;n (*):
			</logic:equal> <logic:equal name="DatosEmpresaForm" property="datosRepLegalMandatorio" value="NO">
				N&uacute;m. Identificaci&oacute;n:
			</logic:equal></td>
			<td align="left" width="21%"><html:text name="DatosEmpresaForm"
				property="numeroIdentificacionRepLegal" style="text-transform: uppercase;" size="37"
				maxlength="20" styleId="numeroIdentificacionRepLegal"
				onblur="upperCase(this);"
				onchange="ocultarMensajeError();"
				onkeypress="soloCaracteresValidos();valNumeroIdentificacion('numeroIdentificacionRepLegal','tipoIdentificacionRepLegal');" />
			&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionRepLegal"
				id="lbNumeroIdentificacionRepLegal" class="textoAzul"></label></td>
		</tr>
		<tr>
			<td align="left" width="26%"><logic:equal name="DatosEmpresaForm"
				property="datosRepLegalMandatorio" value="SI">
				Nombre (*):
			</logic:equal> <logic:equal name="DatosEmpresaForm" property="datosRepLegalMandatorio" value="NO">
				Nombre:
			</logic:equal></td>
			<td align="left" colspan="3" width="74%"><html:text name="DatosEmpresaForm"
				property="nombreRepLegal" styleId="nombreRepLegal" style="text-transform: uppercase;"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="40"
				onchange="ocultarMensajeError();" /></td>
		</tr>
	</table>
	<P>
	<P>
	<P>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td align="left" width="50%"></td>
			<td width="25%" align="right"><html:button value="CANCELAR" style="width:120px;color:black"
				property="btnCancelar" onclick="fncCursorEspera();ocultarMensajeError();fncCancelar()" styleId="btnCancelar" /></td>
			<td width="25%" align="right"><html:button value="ACEPTAR" style="width:120px;color:black"
				property="btnAceptar" onclick="fncCursorEspera();ocultarMensajeError();fncAceptar()" styleId="btnAceptar"/></td>
		</tr>
	</TABLE>
	<P>
	<TABLE align="center" width="90%">
		<tr>
			<td align="left"><i>(*): Dato es obligatorio</i></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
