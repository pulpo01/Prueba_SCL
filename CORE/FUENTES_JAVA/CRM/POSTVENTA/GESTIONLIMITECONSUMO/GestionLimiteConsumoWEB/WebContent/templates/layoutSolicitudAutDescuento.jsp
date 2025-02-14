<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>
 
<%
	long time = new java.util.Date().getTime();
	String cerrarAction = "../modificacionLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>

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
<title>Telefónica Móviles .: Restitucion de Equipo :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/RestitucionEquipo.js?timestamp=<%=time %>" type="text/javascript"></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/interface/RestitucionEquipoDWR.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/engine.js'></script>

<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/util.js'></script>


<script language="javascript">

function doSubmitBotones(accion){

	if(accion = 'SIGUIENTE'){
		enviarFormulario();
	}
}

function formularioAnterior()
{
	enviar("Anterior");
}

function enviarFormulario()
{
	enviar("Siguiente");
}

function enviar(accion)
{
  	document.getElementById("accion").value = accion;
    document.forms[0].submit();
}
function activaBotonSiguiente()
{
     document.getElementById("Siguiente1").disabled=false;
     document.getElementById("Siguiente2").disabled=false;
}  
  
function desactivaBotonSiguiente()
{
     document.getElementById("Siguiente1").disabled=true;
     document.getElementById("Siguiente2").disabled=true;
} 

function inicio()
{
	var codEstadoSol = document.getElementById("estadoSolicitud").value;
	var numAutorizacion = document.getElementById("numAutorizacion").value;
	var codEstadoSolPD = document.getElementById("estadoSolicitudPendiente").value;
	var codEstadoSolAU = document.getElementById("estadoSolicitudAutorizada").value;
	var codEstadoSolCA = document.getElementById("estadoSolicitudCancelada").value;
				
	if (numAutorizacion ==''&&numAutorizacion =='undefined'&&numAutorizacion == " " || numAutorizacion == null){
	   document.getElementById("consultar").disabled = true;
	}else{
	   document.getElementById("consultar").disabled = false;
	}
	
	if (codEstadoSol == codEstadoSolAU){
		document.getElementById("solicitar").disabled=true;
		document.getElementById("consultar").disabled=true;
		activaBotonSiguiente();
	}else{
		desactivaBotonSiguiente();
	}
} 
function salir(){
	RestitucionEquipoDWR.rollbackReservaSerie(callbackDesreserva);

}

function callbackDesreserva(){

	desbloqueaVendedor();
	
}

function callbackDesbloqueaVendedor(){
	
	location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

</script>

</head>

<body class="body" onload="inicio();">

<html:form  method="POST" action="/SolicitudAutDescuentoAction.do">

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <!-- tr>
    <td colspan="2"--><!-- tiles:insert attribute="footerOS" /--><!-- /td></tr-->
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>
</table>

</html:form>
</body>
</html:html>
