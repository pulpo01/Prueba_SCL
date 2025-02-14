<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../estilos/estilo.css" rel="stylesheet" type="text/css">
<link href="../images/calendar/calendar.css" rel="stylesheet"
	type="text/css">	
<script language="javascript" src="../js/mootools.js"
	type="text/javascript"></script>
	<script language="javascript" src="../js/jquey.js"
	type="text/javascript"></script>
<script language="javascript" src="../js/calendar.js"
	type="text/javascript"></script>
<title>IntegracionSICSA</title>
<script type="text/javascript">
var jq=jQuery.noConflict();
window.addEvent('domready', function() { myCal = new Calendar({ fec_desde: 'd/m/Y', fec_hasta : 'd/m/Y' },{direction: -1,tweak: { x: 10, y: 10 } }); });

function copiarDatos(html,idDiv){
	document.getElementById(idDiv).innerHTML=html;
	detenerCarga();
}

function buscarDevoluciones(){
	 var html="<label class='txtSubTitulo'>Resultado de la Busqueda</label>";
	 var numDevolucion = document.getElementById("txtDevolucion").value;
	 var fecDesde = document.getElementById("fec_desde").value;
	 var fecHasta = document.getElementById("fec_hasta").value;
	 if(""!=jq.trim(numDevolucion)){
	 	document.getElementById("fec_desde").value="";
	 	document.getElementById("fec_hasta").value="";
	 }else{
	 	if(""==jq.trim(fecHasta)&&""!=jq.trim(fecDesde)){
	 		alert("Seleccion una Fecha para el campo Hasta");
	 		return;
	 	}
	 }
	 copiarDatos(html,"dv-titulo");
	 enviarForm("formBusquedaDevolucion");
}

function enviarForm(form){
document.getElementById(form).submit();
iniciarCarga();
}

function iniciarCarga(){
document.getElementById("cargando").style.display="block";
}

function detenerCarga(){
document.getElementById("cargando").style.display="none";
}

function buscarDetalleDevolucion(devolucion){
	document.getElementById("codDevolucionBusc").value=devolucion;
	enviarForm("formBusquedaDetalleDevolucion");
}


//Tabla con Scroll 
function tablaScroll(ancho, alto){
    jq('.tableContainer').css({'width':ancho,'overflow':'scroll','height':alto});
    jq('.tableContainer table').css({'width':'98%'});
    jq('.fixedHeader tr').css({'position':'relative','display':'block'});
}

//Tabla con Scroll 
function tablaScrollSeries(ancho, alto){
    jq('.tableContainerSeries').css({'width':ancho,'overflow':'scroll','height':alto});
    jq('.tableContainerSeries table').css({'width':'98%'});
    jq('.fixedHeaderSeries tr').css({'position':'relative','display':'block'});
}
 
function mostrarSeries(linPedido, nomArticulo){
	document.getElementById("linDevolucionBusc").value=linPedido;
	document.getElementById("nomArticulo").value=nomArticulo;
	document.getElementById("opcion").value="mostrarSeries";
	enviarForm("formBusquedaDetalleDevolucion");
}

function exportarTXT(linPedido){
	document.getElementById("opcion").value="exportarTXT";
	document.getElementById("formBusquedaDetalleDevolucion").submit();
	
}

function limpiar(){
	document.getElementById("fec_hasta").value="";
	document.getElementById("fec_desde").value="";
	document.getElementById("txtDevolucion").value="";
}

function volverDevolucion(){
	document.getElementById("opcion").value="volver";
	document.getElementById("formBusquedaDetalleDevolucion").submit();
}

function soloNumeros(evt){
//asignamos el valor de la tecla a keynum
if(window.event){// IE
keynum = evt.keyCode;
}else{
keynum = evt.which;
}
//comprobamos si se encuentra en el rango
if(keynum>47 && keynum<58){
return true;
}else{
return false;
}
}
 
</script>
</head>
<body>
<html:form styleId="formBusquedaDevolucion" method="post"
	action="/action/BuscaDevolucionAction" target="ctrl">
	<center><img src="../images/cargando.gif" id="cargando" style="display: none"></center>
	<br>
	<label class="txtTitulo">Devoluciones
			realizadas por <bean:write name="usuarioDTO" property="nomUsuario" />
			&nbsp; <bean:write name="usuarioDTO" property="appUsuario" />
			<hr style="margin-left: 0%; margin-right: 1%"></hr></label>

	<table align="left" border=0 height="auto" style="margin-left: 0%" width="15%">
		<tr>
			<td class="subTitulo" align="left" valign="top"><br>
			<br>
			Buscar Devoluciones<br>
			<br>
			</td>
		</tr>
		<tr>
			<th class="detalle" align="left" valign="top">Número de Devolucion</th>
		</tr>
		<tr>
			<td class="detalle" colspan="1"><input class="campoText"
				type="text" size="10" name="txtDevolucion" id="txtDevolucion"  onkeypress="return soloNumeros(event)"/><br>
			<br>
			</td>
		</tr>
		<tr>
			<th class="detalle" colspan="1" align="left" width="10%" valign="top">Rango
			De Fechas</th>
		</tr>
		<tr>
			<td class="detalle" colspan="1" title="DESDE">D <input
				align="right" type="text" name="fec_desde" id="fec_desde" /> <br>
			<br>
			</td>
		</tr>
		<tr>
			<td class="detalle" colspan="1" title="HASTA">H <input
				type="text" name="fec_hasta" id="fec_hasta" /><br>
			<br>
			</td>
		</tr>
		<tr>
			<td class="detalle" colspan="1" align="center" valign="top"><input
				type="button" name="btnBusPedido" id="btnBusPedido"
				onclick="buscarDevoluciones();" value="Buscar Devoluci&oacute;n" class="barraarriba" />

			</td>
		</tr>
		<tr>
			<td class="detalle" colspan="1" align="center" valign="top"><input
				type="button" name="btnLimpiar" id="btnLimpiar"
				onclick="limpiar();" value="Limpiar" class="barraarriba" />

			</td>
		</tr>
	</table>	
</html:form> 
<br>
	<center>
		<div id="dv-titulo" class="divDatos">
			<label class="txtSubTitulo">Resultado de la Busqueda</label>
		</div>
	<br>
	<div id="dv-devoluciones" class="divDatos">
	<label class="txtInfo">Ingrese sus	datos de busqueda</label>
	</div>
	</center>

<iframe name="ctrl"	style="display: none;"></iframe>
</body>
</html>