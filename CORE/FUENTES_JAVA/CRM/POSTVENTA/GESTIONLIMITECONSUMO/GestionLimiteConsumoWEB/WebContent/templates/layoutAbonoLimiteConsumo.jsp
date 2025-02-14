<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
	long time = new java.util.Date().getTime();
	String cerrarAction = "../abonoLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Abono Limite Consumo Abonado :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>

<script language="javascript">

<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="strCantidadDecimal">
var numeroDecimal = '<bean:write name="cargaAbonoLimiteConsumoOutDTO" property="strCantidadDecimal"/>';
</logic:present>
<logic:notPresent name="cargaAbonoLimiteConsumoOutDTO" property="strCantidadDecimal">
var numeroDecimal = '0';
</logic:notPresent>

<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="douMontoMaximoAbono">
var valMaxAbono = '<bean:write name="cargaAbonoLimiteConsumoOutDTO" property="douMontoMaximoAbono"/>';
</logic:present>
<logic:notPresent name="cargaAbonoLimiteConsumoOutDTO" property="douMontoMaximoAbono">
var valMaxAbono = '0';
</logic:notPresent>
	
var valAbono = "";	
	
function validarDecimales(){

    var valorAbono = document.getElementById("abono").value;
	
    posicion = valorAbono.lastIndexOf('.');
    var posicionInicial = valorAbono.indexOf('.');
    
	if(posicion != "-1" ){
		if(posicion == posicionInicial){
			var separacionEnteroDecimal = valorAbono.split('.');
			var decimales = separacionEnteroDecimal[1];
	
			if(Number(decimales.length) > Number(numeroDecimal)){
		
				document.getElementById("abono").value = valAbono;
                return false;
			}
			
		}else{
		   //hay mas de un punto
		   document.getElementById("abono").value = valAbono;
           return false;
		}
	}	

    valAbono = valorAbono;
	
}	
	
function validaFormatoNumero(numero){
	
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

function validarFormulario(){

	var abono = document.getElementById("abono").value;
	
	if(trim(abono) == ""){
		
		alert("Debe ingresar un abono");
		
		return false;
	}
	
	if(Number(abono) == 0){
		
		alert("Monto de Abono debe ser mayor que cero");
		
		return false;
	}
	
	if(Number(valMaxAbono) < Number(abono)){
	
		alert("Monto de Abono, Excede al maximo permitido");
		
		return false;
	}
	
	return true;
}

function doSubmitBotones(accion){

	//if(accion == "SIGUIENTE"){
	
	var result = validarFormulario();
	
	if(result == false){
		return false;
	}
		
	document.forms[0].submit();
		
	//}
}

function salir(){

	window.location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

</script>

</head>

<body class="body"  onload="">	
	
<html:form action="/AbonoLimiteConsumoAction" method="POST" target="_self">
<input type="hidden" id="habilitado" name="habilitado" value="0"/>
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
