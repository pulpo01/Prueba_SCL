<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telef&oacute;nica M&oacute;viles .: <c:out value="${nombreOOSS}"/> :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/util.js'></script>

<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/SesionDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TipoDeContratoDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CausaCamSerieDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TipoTerminalDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TecnologiaDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CuotaDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/MensajeRetornoDTO.js'></script>

<script type='text/javascript' src='cambioSerie/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/util.js'></script>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="cambioSerie/css/mas.css" rel="stylesheet" type="text/css" />


<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    
<!--  **********************************  -->

<script language="javascript">

	var flagPagRecargada = false;
	
// -------------------------------------------------------------------------------------		

	function salir(){
		var ventana = window.self;
		ventana.opener = window.self;
		ventana.close();
	}

// -------------------------------------------------------------------------------------	

	function enviarFormulario()	  {
	
	if (document.getElementById("flagBloqueo").value == 1)	{
	  	document.getElementById("btnSeleccionado").value = "grabar";
	  	// habilita los controles que estan disabled
	  	habilitaControles();
	    document.forms[0].submit();
	    deshabilitaControles();
	 } // if
	 else
	 	alert ("No se ha bloqueado ning�n n�mero de serie hasta el momento.");
	 	
  }	// enviarFormulario
	  
// ------------------------------------------------------------------------------------

	function cargaDefault()	{

		document.getElementById("flagBloqueo").value=1;
		document.getElementById("flagT").value=0;
		
	} // cargaDefault

//onload="cargaDefault();"
</script>
  
</script>
</head>

<body class="body" onblur="window.focus();">

<table width="100%">
<tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
<tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
<tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
</table>

</body>
</html:html>