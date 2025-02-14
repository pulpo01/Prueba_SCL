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
<title>Telefónica Móviles .: Anulación de Siniestros :.</title>
<script language="JavaScript" src="anulacionSiniestro/botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='/AnulacionSiniestroWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/AnulacionSiniestroWEB/dwr/interface/SesionDTO.js'></script>
<script type='text/javascript' src='/AnulacionSiniestroWEB/dwr/interface/MensajeRetornoDTO.js'></script>

<script type='text/javascript' src='/AnulacionSiniestroWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/AnulacionSiniestroWEB/dwr/util.js'></script>

<script type='text/javascript' src='anulacionSiniestro/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='anulacionSiniestro/js/Calendar.js'></script>

<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    

<!--  **********************************  -->



<link href="anulacionSiniestro/css/mas.css" rel="stylesheet" type="text/css" />
<link href="anulacionSiniestro/css/calendar.css" type="text/css" rel="stylesheet" />    

<script language="javascript">
	
	function salir()	{
	if (!window.closed)
		window.close();
	}
	
	function enviarFormulario()	  {
		if (validaAnulacionSiniestro())	{
		  	document.getElementById("btnSeleccionado").value = "grabar";
		    document.forms[0].submit();
		 }
		 else
		 	return false;	
	}	// enviarFormulario
	  
	function formularioAnterior()
	  {
	  	document.getElementById("btnSeleccionado").value = "anterior";
	    document.forms[0].submit();
	  
	  }
	  
	  function asignaValorAControl()
	  {
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";   
	  }
	  
	  function cargaCheckListNegra()	{
		try{
			desTerminal=document.getElementById("tipTerminal").value;
			desTerminal=desTerminal==""||desTerminal=='undefined'?"SIMCARD":desTerminal;
			var verdiv="none";
			if ("SIMCARD"!=desTerminal){
				verdiv="inline";
				if (document.getElementById("vaListaNegra").value=="1"){
					document.getElementById("vaListaNegra").checked=true;
				 }
				}
			else if (desTerminal!=""){
				verdiv="none";
			}	
			document.getElementById("listaNegra").style.display=verdiv;
				
		}
		catch(e){
		}	
	}	
  
	
// -------------------------------------------------------------------------------------	
</script>
</head>

<body class="body" onload="cargaCheckListNegra()";>

<html:form action="/AnulacionSiniestroAction" method="POST">
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
