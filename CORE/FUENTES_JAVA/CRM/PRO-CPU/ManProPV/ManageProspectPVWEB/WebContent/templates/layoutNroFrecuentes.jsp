<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<script language="JavaScript" src="js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<c:set var="productoOS" value="${sessionScope.productoFrecSelec}"></c:set>

<title>Telef�nica M�viles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<script language="javascript">
var cantidadModificaciones="<c:out value="${productoOS.cantModificaciones}"/>";
var maximoModificaciones="<c:out value="${productoOS.maxModificaciones}"/>";
var idProdContratado="<c:out value="${productoOS.idProdContratado}"/>";


function enviarFormNF(enviar)
{
	if(enviar == 0)
	{
		history.back();//location.href=
	}
	else
	{
		document.getElementByName('numFrecArr').value = obtenerNumeros();
		alert("<%=request.getContextPath()%>");
		document.getElementByName('NumerosFrecuentesForm').action="<%=request.getContextPath()%>/producto/NumerosFrecuentesAction.do";
		document.getElementByName('NumerosFrecuentesForm').submit();
	}
}

function salir(){
	window.close();
}
</script>
</head>

<body >

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</body>
</html:html>