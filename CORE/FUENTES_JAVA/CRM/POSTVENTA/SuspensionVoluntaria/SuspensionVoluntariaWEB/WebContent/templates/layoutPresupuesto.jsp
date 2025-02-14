<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Activación y Desactivación de Servicios Suplementarios :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="suspensionVol/css/mas.css" rel="stylesheet" type="text/css" />
<script language="javascript">

function formularioAnterior(){
	rollback=false;
	ejecutar('Anterior');
}

function enviarFormulario(){
	rollback=false;
	ejecutar('Siguiente');
}

function ejecutar(accion){
	document.getElementById('accion').value = accion;
	document.forms[0].submit();
}

function salir(){
    rollback=true;
    window.close();
}

function confirm() {
	if (rollback){
		eliminaCargosFacturaCiclo();
	}
}

//funcion DWR para eliminar los cargos si solo "NO" es factura a ciclo

function eliminaCargosFacturaCiclo()
	{
		alert("Eliminación de cargos en Proceso");
		JEliminarCargosDWR.eliminarCargos();
			
	}
  
</script>
</head>

<body class="body">

<html:form action="/PresupuestoAction.do">
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