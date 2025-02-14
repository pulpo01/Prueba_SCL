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
<title>Telefónica Móviles .: Restitucion Equipo :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/RestitucionEquipo.js?timestamp=<%=time %>" type="text/javascript"></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/interface/RestitucionEquipoDWR.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/util.js'></script>

<script language="javascript">


window.onbeforeunload=confirm;
var rollback=true ;

function doSubmitBotones(accion){
	if(accion == 'SIGUIENTE'){
		enviarFormulario();
	}
}

function formularioAnterior(){
	rollback=false;
	ejecutar('Anterior');
}

function enviarFormulario(){
    
    // Hay que llamar al popup de ingreso de monto del abono
    var flag = document.getElementById("rbCiclo").value;
    if (flag == "SI")	{
	    var total = document.getElementById("totalPresupuesto").value;
	    var monto = window.showModalDialog("../pages/PAG_PagoAbono.jsp" , total, "dialogHeight:150px;dialogWidth:320px;center:yes;resizable:no;scroll:no;status:no");
		
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
	RestitucionEquipoDWR.rollbackReservaSerie(callbackDesreserva);
   //window.close();
}

function callbackDesreserva(){

	desbloqueaVendedor();
	
}

function callbackDesbloqueaVendedor(){
	
	location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
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
		RestitucionEquipoDWR.eliminarCargos();
			
	}
 function formatearNumerosPresupuesto(){
 
 	
 }
 
function convierte(texto)	{
	

	
} // convierte

</script>

</head>

<body class="body">

<html:form action="/PresupuestoAction.do" method="POST">

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
