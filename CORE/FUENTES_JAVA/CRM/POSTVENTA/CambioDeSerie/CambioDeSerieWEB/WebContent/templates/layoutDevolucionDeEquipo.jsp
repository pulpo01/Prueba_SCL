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
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Devolución de Equipo :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="cambioSerie/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='/CambioDeSerieWEB/cambioSerie/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='cambioSerie/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/util.js'></script>



<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    
<!--  **********************************  -->


<script language="javascript">

	function enviarFormulario()
	  {
	  	document.getElementById("btnSeleccionado").value = "siguiente";
	    document.forms[0].submit();
	  }
	  
	function formularioAnterior()
	  {
	  	document.getElementById("btnSeleccionado").value = "anterior";
	    document.forms[0].submit();
	  
	  }
  
// -------------------------------------------------------------------------------------
  
	function devolucionEquipo(opValor)	{

		switch(opValor)	{
			case "si devuelve":
				document.getElementById("opCargador").disabled="false";
				document.getElementById("opEstadoEquipo").disabled="false";
				document.getElementById("bodegaDestino").disabled="false";
				document.getElementById("opAmistar").disabled="false";
				document.getElementById("opAmistar").checked=false;
				break;
				
			case "no devuelve":				
				document.getElementById("bodegaDestino").disabled="true";
				document.getElementById("opAmistar").disabled="true";
				document.getElementById("opAmistar").checked=false;
				document.getElementById("opEstadoEquipo").disabled="true";
				break;

			case "diferido":				
				document.getElementById("bodegaDestino").disabled="false";
				document.getElementById("opAmistar").disabled="true";
				document.getElementById("opAmistar").checked=false;
				document.getElementById("opEstadoEquipo").disabled="true";
				break;

			case "compra":				
				document.getElementById("bodegaDestino").disabled="false";
				document.getElementById("opAmistar").disabled="false";
				document.getElementById("opEstadoEquipo").disabled="true";				
				
		}	// switch

	}	// devolucionEquipo
	
function salir(){
	desReservaSerie();
	//window.close();
}
// -------------------------------------------------------------------------------------	
</script>
</head>

<body class="body">

<html:form action="/DevolucionDeEquipoAction" method="POST">
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footerOS" /></td></tr>  
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>