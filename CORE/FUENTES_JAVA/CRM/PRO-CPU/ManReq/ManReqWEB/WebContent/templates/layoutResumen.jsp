<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
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
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<script language="javascript">
var codOrdenServicio="<c:out value="${clienteOS.codOrdenServicio}"/>";

var cantAbo = 0;
<c:if test="${clienteOS.codOrdenServicio != 40007}">
<logic:iterate id="abonado" name="Abonados" scope="session" type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       cantAbo++;
</logic:iterate>
</c:if> 

<c:if test="${clienteOS.codOrdenServicio == 40007}">
<logic:iterate id="abonado" name="AbonadosEmpresa" scope="session" type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO">
       cantAbo++;
</logic:iterate>
</c:if>

window.onload = function() {
	valoresDefaultCarga();
}

function valoresDefaultCarga()
{
    document.getElementById("cargaPagina").value = "CARGADA";
    if (cantAbo <= 1) {
        //no mostrar la lista de abonados
    	document.getElementById("abonadoSel").style["display"]="none";
    }
    var valorCarta="<c:out value="${sessionScope.canReg}"/>";
    if (valorCarta == 0){
       //no mostrar el boton de visualizar carta si no tiene carta configurada (valorCarta=0)
       document.getElementById("imprimircarta").style["display"]="none";
       document.getElementById("abonadoSel").style["display"]="none";
    }
	
}

function enviarFormulario()
  {
  	document.getElementById("btnSeleccionado").value = "siguiente";
    document.forms[0].submit();
  }
  
function registrarOS()
  {
   	document.getElementById("Anterior").disabled = true;
   	document.getElementById("Finalizar").disabled = true;
   	if (document.getElementById("btnSeleccionado").value != "registrarOS"){
  		document.getElementById("btnSeleccionado").value = "registrarOS";
    	document.forms[0].submit();
    }
  }
    
function formularioAnterior()
  {
  	document.getElementById("btnSeleccionado").value = "anterior";
    document.forms[0].submit();
  
  }
 
function visualizarFactura(){
    var abonados;
    var opcionSel;
    abonados = document.getElementById("abonadoSel");
    
    if(codOrdenServicio==40009){  // Orden de servicio ejecutada a nivel de cliente, por tanto no existen abonados SELECCIONADOS
    	document.getElementById("btnSeleccionado").value = "visualizar";
		document.forms[0].submit();
    } 
        
    // cuando existe mas de un abonado en la lista, se debe mostrar, por tanto debe validar que seleccione alguna opcion
    if (abonados.length > 1) {
    	opcionSel = document.getElementById("abonadoSel").value;
    	if (opcionSel == "") {
    		document.getElementById("imprimircarta").disabled = true;
    		alert("Debe seleccionar un abonado desde la lista para visualizar la carta");
    	}else {
    		document.getElementById("imprimircarta").disabled = false;
    		document.getElementById("btnSeleccionado").value = "visualizar";
			document.forms[0].submit();
    	}
    }
    
    if (abonados.length == 1) {
    	document.getElementById("btnSeleccionado").value = "visualizar";
		document.forms[0].submit();
    }
}

function activarBoton(){
	document.getElementById("imprimircarta").disabled = false;
}



function salir(){
	window.close();
}
</script>
</head>

<body>

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