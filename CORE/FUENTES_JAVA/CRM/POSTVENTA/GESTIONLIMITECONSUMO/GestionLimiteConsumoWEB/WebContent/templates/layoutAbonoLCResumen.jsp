<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%
	long time = new java.util.Date().getTime();
	String cerrarAction = "../abonoLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Abono Limite Consumo Abonado :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>

<script language="javascript">

var largoComentario = '<bean:write name="MaxComentario"/>';

function textCounter() {
			
			var valorAbono = document.getElementById("comentario").value;
			var e = window.event; 
			
			if (valorAbono .length >= largoComentario){ 
				alert("Se ha sobrepasado el largo máximo para el comentario");
				e.keyCode=0;
			}else{

			}	
}

function validacionObservacion(){

	var comentario = document.getElementById('comentario').value
	if(trim(document.getElementById('comentario').value) == ""){
		alert("La comentario no puede ser vacia.");
		document.getElementById('comentario').focus();
		return false;
		
	}else if(trim(comentario).length > largoComentario ){
	
		alert("Comentario no puede ser mayor a " + largoComentario + " caracteres" );
		document.getElementById('comentario').focus();
				
	}else{
	
		return true;
	}

}
function doSubmitBotones(accion){

	if(accion == "FINALIZAR"){
		
		if(validacionObservacion()){
	document.forms[0].submit();
}
	}
}

function salir(){

	location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}
</script>
</head>

<body class="body">

<html:form action="/ResumenAction" method="POST" target="_self">
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <!-- tr>
    <td colspan="2"--><!-- tiles:insert attribute="footer" /--><!-- /td></tr-->  
</table>

</html:form>
</body>
</html:html>