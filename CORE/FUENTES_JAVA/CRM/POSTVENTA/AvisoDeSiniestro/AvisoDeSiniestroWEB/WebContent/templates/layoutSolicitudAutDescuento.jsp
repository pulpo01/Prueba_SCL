<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${nombreOOSS}"/> :.</title>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="avisoSiniestro/css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<script language="javascript">
  
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
     document.getElementById("Siguiente").disabled=false;
     document.getElementById("Siguiente2").disabled=false;
}  
  
function desactivaBotonSiguiente()
{
     document.getElementById("Siguiente").disabled=true;
     document.getElementById("Siguiente2").disabled=true;
} 

function inicio()
{
	var codEstadoSol = document.getElementById("estadoSolicitud").value;
	var numAutorizacion = document.getElementById("numAutorizacion").value;
	var codEstadoSolPD = document.getElementById("estadoSolicitudPendiente").value;
	var codEstadoSolAU = document.getElementById("estadoSolicitudAutorizada").value;
	var codEstadoSolCA = document.getElementById("estadoSolicitudCancelada").value;
				
	if (numAutorizacion=='undefined'||numAutorizacion==''||numAutorizacion == " " || numAutorizacion == null){
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
	window.close();
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
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>