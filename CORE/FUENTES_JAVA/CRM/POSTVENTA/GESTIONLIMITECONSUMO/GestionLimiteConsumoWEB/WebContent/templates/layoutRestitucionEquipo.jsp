<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>

<%
	long time = new java.util.Date().getTime();
	String cerrarAction = "../abonoLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<title>Telefónica Móviles .: Restitución de Equipo :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/RestitucionEquipo.js?timestamp=<%=time %>" type="text/javascript"></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/interface/RestitucionEquipoDWR.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/util.js'></script>



<script language="javascript">

var depliegueNumContrato ='<bean:write name="CargaRestitucionEquipoOutDTO" property="strDespIngContrato"/>';
var despliegueUpper=depliegueNumContrato.toUpperCase();


function activaTextNumContrato(){

	depliegueNumContrato = depliegueNumContrato.replace(/^\s*|\s*$/g,"");

	if(depliegueNumContrato == "false" || depliegueNumContrato == "FALSE"){
	
		document.getElementById("numContrato").innerHTML = "";
		document.getElementById("prefijoNumContrato").style.visibility = "hidden";
		document.getElementById("CodNumContrato").style.visibility = "hidden";
		document.getElementById("sufijoNumContrato").style.visibility = "hidden";
		
		
	}
}

function doSubmitBotones(accion){

		if(accion == "SIGUIENTE"){
			if(validacionIngreso()){
				document.forms[0].submit();
			}
		}
}

function validaIngresoNumeroContrato(){

	var e = window.event;

	if(e.keyCode >= 48 && e.keyCode <= 57){

		//hace nada

	}else if(e.keyCode == 46){
		//hace nada
	}	
	else{
	e.keyCode = 0;
	}
}

function formatoNumeroContrato(numeroContrato){
	
	while((numeroContrato.length)<9){
		numeroContrato = "0"+numeroContrato;
	}
	
	document.getElementById("CodNumContrato").value = numeroContrato;

}

function validacionIngreso(){

	var valida = false;
	
	if(despliegueUpper == "TRUE"){
	
		if(document.forms[0].strCodNumContrato.value == ""){
			valida = false;
			alert("Debe seleccionar el número de contrato");
		}else if(!document.getElementById("radioInterno").checked){
			if(!document.getElementById("radioExterno").checked){
				valida = false;
				alert("Debe seleccionar la Procedencia");
			}
		}else if(document.forms[0].strCodTipContrato.value == ""){
			valida = false;
			alert("Debe seleccionar el tipo de contrato");
		}else if(document.forms[0].strCodModPago.value == ""){
			valida = false;
			alert("Debe seleccionar la modalidad de pago");
		}else if(document.forms[0].strCodCatTributaria.value == ""){
			valida = false;
			alert("Debe seleccionar la categoría tributaria");
		}else if(document.forms[0].strCodMesProrroga.value == ""){
			valida = false;
			alert("Debe seleccionar el mes de prorroga");
		}else{
			valida = true;
		}
	
	}else{
	
		if(!document.getElementById("radioInterno").checked){
			if(!document.getElementById("radioExterno").checked){
				valida = false;
				alert("Debe seleccionar la Procedencia");
			}
		
		}else if(document.forms[0].strCodTipContrato.value == ""){
			valida = false;
			alert("Debe seleccionar el tipo de contrato");
		}else if(document.forms[0].strCodModPago.value == ""){
			valida = false;
			alert("Debe seleccionar la modalidad de pago");
		}else if(document.forms[0].strCodCatTributaria.value == ""){
			valida = false;
			alert("Debe seleccionar la categoría tributaria");
		}else if(document.forms[0].strCodMesProrroga.value == ""){
			valida = false;
			alert("Debe seleccionar el mes de prorroga");
		}else{
			valida = true;
		}
	}
	
	return valida;
	
}

//Inicio Funciones AJAX

function cargaModalidadPago(){
	
	alert("Se ha modificado el tipo de contrato");
	
	
	
} 

//Fin Funciones AJAX

function salir(){

	desbloqueaVendedor();
}

function callbackDesbloqueaVendedor(){
	
	window.location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

</script>

</head>

<body class="body" onload="activaTextNumContrato();">

<html:form action="/RestitucionEquipoAction" method="POST">

	<table width="100%">
		<tr>
			<td colspan="2"><tiles:insert attribute="title" /></td>
		</tr>
		<tr>
			<td colspan="2"><tiles:insert attribute="header" /></td>
		</tr>
		<tr>
			<td colspan="2"><tiles:insert attribute="body" /></td>
		</tr>
		<!-- tr>
    <td colspan="2"-->
		<!-- tiles:insert attribute="footerOS" /-->
		<!-- /td></tr-->
		<tr>
			<td colspan="2"><tiles:insert attribute="footer" /></td>
		</tr>
	</table>

</html:form>
</body>
</html:html>
