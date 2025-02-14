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
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/RestitucionEquipo.js?timestamp=<%=time %>" type="text/javascript"></script>
<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/interface/RestitucionEquipoDWR.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/util.js'></script>

<script language="javascript">

function doSubmitBotones(accion){

		if(accion == "SIGUIENTE"){
			if(validacionIngreso()){
				document.forms[0].submit();
			}		
		}
}

function validacionIngreso(){

	var valida = false;
	
	if(document.forms[0].intCodUso.value == ""){
		valida = false;
		alert("Debe seleccionar el uso");
	}else if(document.forms[0].intCodArticulo.value == ""){
		valida = false;
		alert("Debe seleccionar el artículo");
	}else if(document.forms[0].intCodBodega.value == ""){
		valida = false;
		alert("Debe seleccionar la bodega");
	}else if(document.forms[0].intCodEstado.value == ""){
		valida = false;
		alert("Debe seleccionar la estado");
	}else if(document.forms[0].strNumSerie == null){
		valida = false;
		alert("No hay series para seleccionar");
	}else if(document.forms[0].strNumSerie != null){
		
		valida = false;
		for( var i=0; i < (document.getElementsByName("strNumSerie").length); i++){
		
			if(document.getElementsByName("strNumSerie")[i].checked == true){
				valida = true;
			}
			
		}
		if(valida == false){
		
			alert("Debe seleccionar un número de serie");
		}
	}else{
		alert("strNumSerie: "+document.forms[0].strNumSerie.value);
		valida = true;
	}
	
	
	
	//alert("Equipo seleccionado: "+document.forms[0].strNumSerie.value);
	//alert("Equipo seleccionado: "+document.getElementById("strNumSerie").value);
	return valida;
	
}

function validaSeleccionCombos(){

	if(document.getElementById("comboUso").selectedIndex > 0){
		if(document.getElementById("comboArticulo").selectedIndex > 0){
			if(document.getElementById("comboBodega").selectedIndex > 0){
				if(document.getElementById("comboEstado").selectedIndex > 0){
					//alert("Se han seleccionado todos los combos");
					cargaGrillaEquipos();
				}//else
					//alert("No se han seleccionado todos los combos");
			}//else
				//alert("No se han seleccionado todos los combos");
		}//else
			//alert("No se han seleccionado todos los combos");
	}//else
		//alert("No se han seleccionado todos los combos");

}

function cargaNumSerie(numSerie){

	document.forms[0].strNumSerie.value = numSerie;

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

<div id="idEspere" class="textoSubTitulo" style="position:absolute;top:330px;left:615px;z-index: 101;visibility:hidden;">Cargando Información</div>
<div id="idCargando" class="imgCargando" style="position:absolute;top:110px;left:398px;z-index: 101;visibility:hidden;"></div>
<div id="capa_principal"></div>

<html:form action="/SeleccionEquipoAction" method="POST">

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
