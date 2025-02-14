<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
	<html:base/>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	<title>Telefónica Móviles .:Consulta de Suspensiones Voluntarias de Servicio :.</title>

	<script language="text/JavaScript" src="../suspensionVol/botones/presiona.js" type="text/javascript"></script>
	<script language="text/JavaScript" src="../suspensionVol/js/Calendar.js" type="text/javascript"></script>
	<script type='text/javascript' src='../suspensionVol/js/SuspensionVoluntaria.js'></script>
	
	<script>
// -----------------------------------------------------------------------------------------------------------------------------     		

		function validaFechas()	{
		
			try	{
				// Fecha desde requerida
				if (document.forms[0].fechaDesde.value == "")	{
					alert("La fecha de comienzo es requerida. \nCorrija antes de continuar.");
					return false;
				} // if
	
				// --------------------------------------
				// --------------------------------------
				
				var difFechas 	= compararFechas(document.forms[0].fechaDesde.value, document.forms[0].fechaHasta.value);
				// fechaDesde > fechaHasta => ERROR
				if (difFechas == -1)	{
					alert("La fecha de comienzo es mayor que la fecha de finalización. \nCorrija antes de continuar.");
					return false;
				} // if
				return true;
			} // try
			catch(e)	{
				alert("Ha ocurrido un error en la función validaFechas().");
			} // catch		
			
		} // validaFechas
		
// -----------------------------------------------------------------------------------------------------------------------------     		

		function submitForm( param )	{

		try	{
			if (validaFechas())		{
				// Se muestra en el textbox la fecha de hoy si esta vacia
				if (trim(document.forms[0].fechaHasta.value) == "")	{
					hoy = new Date();
					document.forms[0].fechaHasta.value = formateaFecha(hoy);
				} // if
				
				document.getElementById("btnSeleccionado").value = param;
				document.forms[0].submit();		
			} // if
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función submitForm().");
		} // catch		
			
	} // submitForm

// -----------------------------------------------------------------------------------------------------------------------------     	
	</script>
	
	<link href="../suspensionVol/css/mas.css" rel="stylesheet" type="text/css" />
	<link href="../suspensionVol/css/calendar.css" rel="stylesheet" type="text/css" />
</head>

<body class="body">

<html:form action="/ConsultaSuspensionVoluntariaAction" method="POST">

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
</table>

</html:form>
</body>
</html:html>
