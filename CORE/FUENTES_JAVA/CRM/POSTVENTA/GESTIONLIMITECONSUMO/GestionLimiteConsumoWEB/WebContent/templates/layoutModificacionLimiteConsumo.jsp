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
	String cerrarAction = "../modificacionLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Modificacion Limite Consumo :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>

<logic:present name="CargaModificacionLimiteConsumoOutDTO"
	property="limiteConsumo">
	<bean:define name="CargaModificacionLimiteConsumoOutDTO"
		property="limiteConsumo" id="limiteConsumo" />
</logic:present>


<script language="javascript">

<logic:present name="limiteConsumo" property="douMontoMaximo">
var montoMaximo = '<bean:write name="limiteConsumo" property="douMontoMaximo"/>';
</logic:present>
<logic:present name="limiteConsumo" property="douMontoMinimo">
var montoMinimo = '<bean:write name="limiteConsumo" property="douMontoMinimo"/>';
</logic:present>
var numeroDecimal = '<bean:write name="CargaModificacionLimiteConsumoOutDTO" property="strNumDecimal"/>';
var limitePendiente = '<bean:write name="CargaModificacionLimiteConsumoOutDTO" property="intLimPendiente"/>';


function validaFormatoNumero(){

	var e = window.event;
	
	if(e.keyCode >= 48 && e.keyCode <= 57){

		//hace nada

	}else if(e.keyCode == 46){
		//hace nada
	}else{
		e.keyCode = 0;
	}

}

function validarDecimales(){

   var valorAbono = document.getElementById("limiteConsumo").value;
       
   posicion = valorAbono.lastIndexOf('.');
   var posicionInicial = valorAbono.indexOf('.');
   
       if(posicion != "-1" ){
               if(posicion == posicionInicial){
                       var separacionEnteroDecimal = valorAbono.split('.');
                       var decimales = separacionEnteroDecimal[1];
       
                       if(Number(decimales.length) > Number(numeroDecimal)){
               
                               document.getElementById("limiteConsumo").value = valAbono;
               return false;
                       }
                       
               }else{
                  //hay mas de un punto
                  document.getElementById("limiteConsumo").value = valAbono;
          return false;
               }
       }        

   valAbono = valorAbono;
       
}



function doSubmitBotones(accion){
	if(accion == "SIGUIENTE"){
		if(validaLimiteConsumo()){
			if(limitePendiente > 0){
				var resultado = confirm("Ya existe cambio de Limite pendiente. ¿Desea Continuar?, Aceptar: se eliminara el cambio pendiente, Cancelar: Ooss no continuara."); 
				
					if(resultado == true){
						document.forms[0].strRespContinuar.value = resultado;
						document.forms[0].submit();
					}else{
						return false;
					}	
			}else{
				document.forms[0].submit();	
			}
		}
	}
}

function validaLimiteConsumo(){

	if(document.getElementById("limiteConsumo").value == ""){
		alert("La modificacion del Limite de Consumo no puede vacía.");
		document.getElementById('limiteConsumo').focus();
		return false;
	}else if(Number(document.getElementById("limiteConsumo").value) > Number(montoMaximo)){
		alert("La modificacion del Limite de Consumo no puede ser mayor que el Abono Máximo.");
		document.getElementById('limiteConsumo').focus();
		return false;
	}else if(Number(document.getElementById("limiteConsumo").value) < Number(montoMinimo)){
		alert("La modificacion del Limite de Consumo no puede ser menor que el Abono Mínimo.");
		document.getElementById('limiteConsumo').focus(); 
		return false;
	}else{
		return true;
	}
	
	return validaCampos;
}

function validaCantidadDecimales(numero){

	var separacionEnteroDecimal = numero.split('.');
	var entero = separacionEnteroDecimal[0];
	var decimales = separacionEnteroDecimal[1];
	
	if(Number(decimales.length) < Number(numeroDecimal)){
		alert("Se puede ingresar un decimal mas");
	}else{
		alert("No se pueden ingresar mas decimales");
	}

}

function salir(){

	window.location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

</script>

</head>

<body class="body" onload="">

<html:form action="/ModificacionLimiteConsumoAction" method="POST">

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
