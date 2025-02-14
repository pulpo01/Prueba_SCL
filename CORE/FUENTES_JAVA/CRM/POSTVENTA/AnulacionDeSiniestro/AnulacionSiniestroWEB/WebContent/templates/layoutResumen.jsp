<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<link href="anulacionSiniestro/css/mas.css" rel="stylesheet" type="text/css" />
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<script language="javascript">

function enviarFormulario()
  {
  	document.getElementById("btnSeleccionado").value = "siguiente";
    document.forms[0].submit();
  }
  
function registrarOS()
  {
  	document.getElementById("btnSeleccionado").value = "registrarOS";
    document.forms[0].submit();
    document.getElementById("Finalizar").disabled=true;
    document.getElementById("Finalizar2").disabled=true;
  }
    
function formularioAnterior()
  {
  	document.getElementById("btnSeleccionado").value = "anterior";
    document.forms[0].submit();
  
  }
 
function visualizarFactura(){
	document.getElementById("btnSeleccionado").value = "visualizar";
	document.forms[0].submit();
}

function salir(){
	window.close();
}
</script>
</head>

<body class="body">

<html:form action="/ResumenAction.do">
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