<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JCargosAJAX.js'></script>
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
<script>

 	window.history.forward(1);
 		 
	function fncAnterior() {
			document.getElementById("opcion").value = "anteriorMostrarLineas";
		   	document.forms[0].submit();
	}
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}
	
	function fncCompletarLinea(numLineaScoring) {
			document.getElementById("numLineaSel").value = numLineaScoring;	
			document.getElementById("opcion").value = "completarLineas";
		   	document.forms[0].submit();
	}
		
		
	function fncCancelar(o) {
		document.getElementById("btnCancelar").disabled = false;
		if (confirm("¿Está seguro que desea cancelar la solicitud?")) {
			document.getElementById("opcion").value = "cancelarSolicitud";
			document.getElementById("btnCancelar").disabled = true;
			document.forms[0].submit();
		}
	}
</script>
</head>
<body onload="history.go(+1);" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/GestionScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="numLineaSel" styleId="numLineaSel" />
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">L&iacute;neas agregadas a Solicitud de Scoring&nbsp;
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%">
		<bean:define id="solicitudSel" name="solicitudSel" scope="session" />
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Datos Solicitud:</td>
		</tr>
		<tr>
			<td align="left" width="15%">N&uacute;mero Scoring:</td>
			<td align="left" width="40%"><bean:write name="solicitudSel" property="nroSolScoring" /></td>
			<td align="left" width="10%">Fecha:</td>
			<td align="left" width="35%"><bean:write name="solicitudSel" property="fechaCreacion" /></td>
		</tr>
		<tr>
			<td align="left" width="15%">Vendedor:</td>
			<td align="left" colspan="3"><bean:write name="solicitudSel" property="nombreVendedor" /></td>
		</tr>
		<tr>
			<td align="left" width="15%">Cliente:</td>
			<td align="left" colspan="3"><bean:write name="solicitudSel" property="nombreCliente" /></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	<P><display:table id="lineas" name="lineasScoring" scope="session" pagesize="10" requestURI=""
		width="90%">
		<display:column property="numLineaScoring" title="N° L&iacute;nea" align="right"
			headerClass="textoColumnaTabla" width="10%" />
		<display:column property="desPrestacion" title="Prestaci&oacute;n" headerClass="textoColumnaTabla"
			width="20%" />
		<display:column property="desPlanTarifario" title="Plan Tarifario" headerClass="textoColumnaTabla"
			width="20%" />
		<display:column property="codUso" align="center" title="C&oacute;digo Uso"
			headerClass="textoColumnaTabla" width="10%" />
		<display:column title="" align="center" headerClass="textoColumnaTabla" width="17%">
			<a href="javascript:fncCompletarLinea('<bean:write name="lineas" property="numLineaScoring"/>');"><FONT
				color="#0000ff">Completar Linea</FONT></a>
		</display:column>
	</display:table>
	<P>
	<P>
	<P>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td width="25%" align="left"><html:button style="width:120px; color:black"
				property="btnAnterior" styleId="btnAnterior" onclick="fncAnterior();"><<</html:button></td>
			<td width="75%" align="right"><html:button value="CANCELAR" style="width:120px;color:black"
				property="btnCancelar" styleId="btnCancelar" onclick="fncCancelar();" /> <logic:notEmpty id="lineas"
				name="lineasScoring" scope="session">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuarDoc" styleId="btnContinuarDoc"
					onclick="fncContinuarMisPendientesInst();" />
			</logic:notEmpty>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
