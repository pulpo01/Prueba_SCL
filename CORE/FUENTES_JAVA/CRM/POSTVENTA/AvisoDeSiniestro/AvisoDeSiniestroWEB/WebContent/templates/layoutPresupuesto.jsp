<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${nombreOOSS}"/> :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<link href="avisoSiniestro/css/mas.css" rel="stylesheet" type="text/css" />
<link href="css/mas.css" rel="stylesheet" type="text/css" />


<!-- Se realiza Llamado a DWR  -->
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/JEliminarCargosDWR.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/util.js'></script>

<script language="javascript">

window.onbeforeunload=confirm;
var rollback=true ;

function formularioAnterior(){
	rollback=false;
	ejecutar('Anterior');
}

function enviarFormulario(){
    
    // Hay que llamar al popup de ingreso de monto del abono
    var flag = document.getElementById("rbCiclo").value;
    if (flag == "SI")	{
	    var total = document.getElementById("totalPresupuesto").value;
	    var monto = window.showModalDialog("/CambioDeSimCardWEB/pages/PagoAbono.jsp" , total, "dialogHeight:150px;dialogWidth:320px;center:yes;resizable:no;scroll:no;status:no");
		
		// Asigno el monto de abono ingresado en el popup
		document.getElementById("montoAbono").value = monto;
	} // if
	
	rollback=false;
	ejecutar('Siguiente');
}

function ejecutar(accion){
     rollback=false;
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