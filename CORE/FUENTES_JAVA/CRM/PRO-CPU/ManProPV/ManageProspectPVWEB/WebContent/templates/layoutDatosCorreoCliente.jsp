<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Datos adicionales correo movistar seven :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="javascript">

function guardarDatosAdicProducto()
  {
	var tipoCorreo = document.getElementById("tipoCorreo").value;

	if (document.getElementById("nombreContacto").value == ""){
		alert("Ingrese nombre contacto");
		return false;
	}
	
	if (tipoCorreo=="EMP" || tipoCorreo=="PEREMP"){
		if (document.getElementById("correoElectronicoEmpresa").value == ""){
			alert("Ingrese correo empresa");
			return false;
		}
	}
	
	if (tipoCorreo=="PER" || tipoCorreo=="PEREMP"){
		if (document.getElementById("correoElectronicoPersonal").value == ""){
			alert("Ingrese correo personal");
			return false;
		}	
	}	

	if (document.getElementById("telefono").value == ""){
		alert("Ingrese tel\u00E9fono");
		return false;
	}

	if (document.getElementById("direccionInstalacion").value == ""){
		alert("Ingrese direcci\u00F3n de instalaci\u00F3n");
		return false;
	}

  	document.getElementById("opcion").value = "grabar";
   	document.forms[0].submit();
  }
  
  	function onlyInteger()
	{
		var keyASCII;
		var strNumber = new String(event.srcElement.value);
		keyASCII = window.event.keyCode;
		if( keyASCII != 13 && keyASCII != 75 && keyASCII < 48 || keyASCII > 57 ) //  And Not IsNumeric(Chr(CodAsc)) )
		{
		   window.event.keyCode = '';
		}
	}
	
	function soloCaracteresValidos()
	{
		var keyASCII;
		var strNumber = new String(event.srcElement.value);
		keyASCII = window.event.keyCode;
	
		if((keyASCII == 22) || (keyASCII == 39) || (keyASCII == 180) || (keyASCII == 13)) 
		{
		   window.event.keyCode = '';
		}
	}
	
	function upperCase(text){
	   var y = text.value;
	   text.value = y.toUpperCase();
	}
	
	function validaCorreo(theElement, elemento )
    {
     var s = theElement.value;
     var filter=/^[A-Za-z][A-Za-z0-9_.-]*@[A-Za-z0-9_.-]+\.[A-Za-z0-9_.-]+[A-za-z]$/;
     if (s.length == 0 ) return true;
     if (filter.test(s))
     {
         return true;
     }    
     else
     {
         alert("Ingrese una dirección de correo válida");
         theElement.focus();
         return false;
     }
    }	
	
function fncInicio(){
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		document.getElementById("telefono").maxLength = largoNumCelular;
}
		
</script>
</head>

<body onload="fncInicio();">
<table width="100%" border="0">
  <tr>
    <td width="100%"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td width="100%"><tiles:insert attribute="header" /></td></tr>    
  <tr>
    <td width="100%"><tiles:insert attribute="body" /></td></tr>  
</table>

</body>
</html:html>