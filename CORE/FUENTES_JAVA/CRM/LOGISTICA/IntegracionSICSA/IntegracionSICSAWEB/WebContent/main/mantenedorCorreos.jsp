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
<script language="javascript" src="../js/jquey.js"
	type="text/javascript"></script>
<title>IntegracionSICSA</title>
<script type="text/javascript">
var jq=jQuery.noConflict();

function copiarDatos(html,idDiv){
	document.getElementById(idDiv).innerHTML=html;
	detenerCarga();
}

function enviarForm(form){
document.getElementById(form).submit();
iniciarCarga();
}

function iniciarCarga(){
document.getElementById("cargando").style.display="block";
document.getElementById("bloqueaTodo").style.display="block";
}

function detenerCarga(){
document.getElementById("cargando").style.display="none";
document.getElementById("bloqueaTodo").style.display="none";
}

function buscarCorreos(){
	var codGrupo = document.getElementById("cmbGrupo").value;
	document.getElementById("accion").value="buscarCorreos";
	if("0"==codGrupo){
		copiarDatos("","dv-datos");
	}else{
		enviarForm("formMantenerCorreos");
	}
}

function eliminar(mail){
	document.getElementById("antiCorreo").value=mail;
	document.getElementById("accion").value="eliminarCorreo";
	enviarForm("formMantenerCorreos");
}

function agregarCorreo(){
	if(""==jq.trim(document.getElementById("txtNewCorreo").value)){
		alert("Debe ingresar un correo");
		return false;
	}
	
	if(validarEmail(document.getElementById("txtNewCorreo").value)){
		document.getElementById("nuevoCorreo").value=document.getElementById("txtNewCorreo").value;
		document.getElementById("nuevoUsuario").value=document.getElementById("txtNewUsuario").value;
		document.getElementById("accion").value="insertarCorreo";
		enviarForm("formMantenerCorreos");
	}
}

function popUpModif(mail, usuario){
	document.getElementById("modifCorreo").value=mail;
	document.getElementById("modifUsuario").value=usuario;
	document.getElementById("antiCorreo").value=mail;
	document.getElementById("divBloqueador").style.display="block";
}

function cancelarUpdt(){
	document.getElementById("divBloqueador").style.display="none";
}

function aceptarUpdt(){
	if(""==jq.trim(document.getElementById("modifCorreo").value)){
		alert("Debe ingresar un correo");
		return false;
	}
	
	if(validarEmail(document.getElementById("modifCorreo").value)){
	
		document.getElementById("nuevoCorreo").value=document.getElementById("modifCorreo").value;
		document.getElementById("nuevoUsuario").value=document.getElementById("modifUsuario").value;
		document.getElementById("accion").value="modificarCorreo";
		enviarForm("formMantenerCorreos");
	
	}
}

function validarEmail(valor) {
  if (/^([A-Za-z0-9_\-\.])+\@([A-Za-z0-9_\-\.])+\.([A-Za-z]{2,4})$/.test(valor)){
   return true;
  } else {
   alert("La dirección de email es incorrecta.");
   return false;
  }
}

//Tabla con Scroll 
function tablaScroll(ancho, alto){
    jq('.tableContainer').css({'width':ancho,'overflow':'scroll','height':alto});
    jq('.tableContainer table').css({'width':'98%'});
    jq('.fixedHeader tr').css({'position':'relative','display':'block'});
}
</script>
</head>
<body>
<html:form styleId="formMantenerCorreos" method="post"
	action="/action/MantenerCorreosAction" target="ctrl">
	<center><img src="../images/cargando.gif" id="cargando"
		style="display: none"></center>
	<br>
	<label class="txtTitulo">Mantenedor de Correos
	<hr style="margin-left: 0%; margin-right: 1%"></hr>
	</label>
	<br>
	<center><label class="txtInfo"> Seleccione un grupo de Correos 
	<html:select property="cmbGrupo" onchange="buscarCorreos()" styleId="cmbGrupo">
		<html:option value="0">Seleccione</html:option>
		<html:optionsCollection name="grupoCorreosDTOs" value="codGrupo" label="desGrupo"/>
	</html:select> </label> <br><br></br><br></br>
	<div id="dv-datos" class="divDatos"></div>
	</center>
	<html:hidden property="accion" styleId="accion"/>
	<html:hidden property="antiCorreo" styleId="antiCorreo"/>
	<html:hidden property="nuevoCorreo" styleId="nuevoCorreo"/>
	<html:hidden property="nuevoUsuario" styleId="nuevoUsuario"/>
</html:form>
<iframe name="ctrl" style="display: none;"></iframe>
<div class="divBloqueador" id="bloqueaTodo" style="display: none;">
</div>
</body>
</html>