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


function doSubmitBotones(accion){

		if(accion == "SIGUIENTE"){
			/*alert("Entra al if SIGUIENTE");
			if(validaLimiteConsumo()){
				alert("validado limite consumo");
				document.forms[0].bolRespContinuar.value = "true";
				document.forms[0].submit();
				alert("realiza Submit");
			}*/
			if ( eventSend() ){
			  	document.forms[0].submit();
			}
		}
	
}

function reloadData(form){
var i
	for (i=0;i<form.radSiniestro.length;i++){
       	if (form.radSiniestro[i].checked){
			break;
		}
    }

	var lonNumSiniestro = document.getElementsByName("lonNumSiniestro").item(i);
	var strFechaSiniestro = document.getElementsByName("strFechaSiniestro").item(i);
	var strDetCausa = document.getElementsByName("strDetCausa").item(i);
	var strDetEstado = document.getElementsByName("strDetEstado").item(i);
	var strObservaciones = document.getElementsByName("strObservaciones").item(i);
	var lonNumConstancia = document.getElementsByName("lonNumConstancia").item(i);
	var strFechaActual = document.getElementsByName("strFechaActual").item(i);
	var strTipTerminal = document.getElementsByName("strTipTerminal").item(i);
	
	document.getElementById("NumSiniestro").innerHTML = lonNumSiniestro.value;
	document.getElementById("fechaSiniestro").innerHTML = strFechaSiniestro.value;
	document.getElementById("causa").innerHTML = strDetCausa.value;
	document.getElementById("estado").innerHTML = strDetEstado.value;
	document.getElementById("lonNumConstPolicial").innerHTML = lonNumConstancia.value;
	document.getElementById("strFechaRestitucion").innerHTML = strFechaActual.value;
	document.getElementById("strObservacion").value = strObservaciones.value;
	
	document.getElementById("lonIdSiniestro").value = lonNumSiniestro.value;
	document.getElementById("lonConstPolicial").value = lonNumConstancia.value;
	document.getElementById("strFecRestitucion").value = strFechaActual.value;
	
	document.getElementById("strTipTerminalSel").value = strTipTerminal.value;
	
}

function eventSend(){

  if(document.getElementById("NumSiniestro").innerHTML == ""){
    alert('Debe indicar algún Aviso de Siniestro');
    return false;
  }else if(document.getElementById("strFechaRestitucion").innerHTML == ""){
    alert('Debe indicar la Fecha de Restitución');
    return false;
  }else{
  	return true;
  }
}


function doSend(form){
	if ( eventSend() ){
		alert(document.getElementById("lonIdSiniestro").value);
	  	form.submit();
	}
}

function salir(){

	desbloqueaVendedor();
}

function callbackDesbloqueaVendedor(){
	
	window.location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

</script>

</head>

<body class="body" onload="">

<html:form action="/SeguimientoSiniestroAction" method="POST">
	<input type="hidden" name="strTipTerminalSel" id="strTipTerminalSel" value=""/>
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
