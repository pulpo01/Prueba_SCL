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
<title>Telefónica Móviles .: Aviso de Siniestro :.</title>
<script language="JavaScript" src="avisoSiniestro/botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='avisoSiniestro/js/Calendar.js'></script>
<script type='text/javascript' src='avisoSiniestro/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='avisoSiniestro/js/AvisoDeSiniestro.js'></script>

<link href="avisoSiniestro/css/mas.css" rel="stylesheet" type="text/css" />
<link href="avisoSiniestro/css/calendar.css" type="text/css" rel="stylesheet" />    

<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    
<!--  **********************************  -->

<!-- Se realiza Llamado a DWR  -->
<script type='text/javascript' src='/AvisoDeSiniestroWEB/dwr/interface/JVerificaNumeroDesviadoDWR.js'></script>
<script type='text/javascript' src='/AvisoDeSiniestroWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/AvisoDeSiniestroWEB/dwr/util.js'></script>

<script language="javascript">

	var respuestaValidacionNumero;
	
	function validaFormatoNumeroDesvio(){

		var e = window.event;
	
		if(e.keyCode >= 48 && e.keyCode <= 57){

			//hace nada

		}else if(e.keyCode == 46){
			//hace nada
		}else{
			e.keyCode = 0;
		}

	}
	
	function verificaNumeroDesvio(numeroDesvio)
	{
		if(document.getElementById("nroCelularDesviado").value != "")
			verificacionDesvioNumero(numeroDesvio);
			
	}

	function salir(){
		window.close();
	}
	function enviarFormulario()
	  {
	  	if(respuestaValidacionNumero == "TRUE" || document.getElementById("nroCelularDesviado").value == ""){
		  	if (validaAvisoSiniestro())	{
			  	document.getElementById("btnSeleccionado").value = "grabar";
			    document.forms[0].submit();
			 }
			 else
			 	return false;
		}else
			alert("Debe ingresar un numero a desviar valido o dejar el campo vacío");	 	
	  }
	  
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
	  
	  function fechaActual()
	  {
	  var fecha = new Date();
	  var mesActual = fecha.getMonth()+1;
	  var anoActual = fecha.getYear();
	  var diaActual = fecha.getDate();
	  
	  var fecSiniestro = eval('document.AvisoSiniestroForm.fecSiniestro');
	  
	  if(mesActual < 10){
	  	var aux = '0';
	  	aux += mesActual;
	  	mesActual = aux;
	  }
	  
	  fecSiniestro.value = diaActual;
	  fecSiniestro.value += '/';
	  fecSiniestro.value += mesActual;
	  fecSiniestro.value += '/';
	  fecSiniestro.value += anoActual;
	  }
  
  
  function validaPlanComercial()	{
  	
  	if (document.getElementById("retornoCambioPlan").value == "1")	{
  		var mensaje = document.getElementById("glosaCambioPlan").value;

		// Si no confirma entonces hay que saltar a la pagina final
  		if (!confirm(mensaje))	{
		  	document.getElementById("btnSeleccionado").value = "noAceptaPlanComercial";
		    document.forms[0].submit();
  		} // if
  	} // if
  	
  } // validaPlanComercial()

  function fcBuscarTipSusp() {
    //Inlcuido por Santiago Ventura 19/04/2010
  	//document.getElementById("opcion").value = "obtenerTiposDeSuspencion";
  	//document.forms[0].submit();
  }
	
// -------------------------------------------------------------------------------------	
</script>
</head>

<body class="body" onload="javascript:validaPlanComercial();fechaActual()">

<html:form action="/AvisoSiniestroAction" method="POST">
<!--  Inlcuido por Santiago Ventura 19/04/2010 -->
<html:hidden property="opcion" value="inicio"/>
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