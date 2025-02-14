<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link type="text/css" rel="stylesheet" href="/css/mas.css" />
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/css/mas.css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script language="javascript">
	function eliminar(o) {
		if (confirm('¿Está seguro que desea eliminar este documento?'))	{
			window.location.assign('AsocDocDigitalizadoScoringAction.do?opcion=eliminar&numCorrelativo=' + o);
		}
	}

	function visualizar(o) {
		var opciones = "location=no, menubar=no";
		var numSolScoring = "<bean:write name='AsocDocDigitalizadoScoringForm' property='numSolScoring' />";
		var URL = '<%=request.getContextPath()%>/DocDigitalizadoArchivoServlet?numCorrelativo=' + o + '&numSolScoring=' + numSolScoring;
		window.open(URL, '_blank', opciones);
	}
	
	function obtenerExtensionesValidas() {
		var exts = document.getElementById("extensionesValidas").value.toString().toLowerCase();
		return exts.split(",");
	}
	
	function validarExtension(nombreArchivo) {
		var t = "";
	    var r = false;
	    t = nombreArchivo.slice(nombreArchivo.indexOf("\\") + 1);
        var ext = nombreArchivo.slice(nombreArchivo.lastIndexOf(".")).toLowerCase();
        var exts = obtenerExtensionesValidas();
	    for (var i = 0; i < exts.length; i++) {
           if (ext == ('.' + exts[i]) ) { 
		        r = true;
		        break;
	       }
	    }
	    return r;
	}
	
	function aceptar() {
		window.location.assign('ResumenScoringAction.do?opcion=inicio');
	}
	
	function validarFormulario() {
		archivo = document.getElementById("archivoFormFile");
		texto = archivo.value.toString().toLowerCase();
		if (texto == null || texto == "") {
			alert('Seleccione un archivo');
			return false;
		}
		if (!validarExtension(texto)) {
			var f = "";
			var exts = obtenerExtensionesValidas();
			for(var i = 0; i < exts.length; i++) {
				f = f + '*.' + exts[i] + ', ';
			}
			f.substr(0, f.length - 3)
			var mensaje = 'Seleccione tipo de archivo válido. \n\nSólo se aceptan: ' + f;
			alert(mensaje);
			return false;
		}
		return true;
	}
</script>
</head>
<body>
<html:form action="AsocDocDigitalizadoScoringAction.do?opcion=adjuntar"
	onsubmit="return validarFormulario()" enctype="multipart/form-data">
	<html:hidden name="AsocDocDigitalizadoScoringForm" property="extensionesValidas" styleId="extensionesValidas" />
	<table>
		<tr>
			<td class="amarillo">
			<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left" />Solicitud Scoring N°: <bean:write
				name="AsocDocDigitalizadoScoringForm" property="numSolScoring" /> - <bean:write
				name="AsocDocDigitalizadoScoringForm" property="desEstadoActual" /> - Asociación de Documentos</h2>
			</td>
		</tr>
	</table>
	<br />
	<div id="wrapper">
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"><bean:write name="AsocDocDigitalizadoScoringForm"
				property="mensajeAccion"></bean:write></div>
			</td>
		</tr>
	</table>
	<br />
	<table>
		<tr>
			<td class="col1">Tipo de Documento (*):</td>
			<td class="col2"><html:select name="AsocDocDigitalizadoScoringForm"
				property="numCorrelativo" styleId="numCorrelativo">
				<html:optionsCollection property="arrayTipoDocumento" value="codigo" label="valor" />
			</html:select></td>
			<td class="col1" />
			<td class="col2" />
		</tr>
		<tr>
			<td class="col1">Seleccione Archivo (*):</td>
			<td colspan="3"><html:file style="width: 80%" name="AsocDocDigitalizadoScoringForm"
				property="archivoFormFile" styleId="archivoFormFile" /></td>
		</tr>
		<tr>
			<td class="col1">Observaciones:</td>
			<td colspan="3"><html:text style="width: 80%" name="AsocDocDigitalizadoScoringForm"
				property="observacion" styleId="observacion" /></td>
		</tr>
	</table>
	<br />
	<table class="botones">
		<tr>
			<td class="col1" colspan="2"><i>(*): Campos obligatorios</i></td>
			<td colspan="3"><html:submit style="width: 120px">ADJUNTAR</html:submit></td>
		</tr>
	</table>
	<hr />
	<br />
	<h2>Documentos Asociados a la Solicitud</h2>
	<br />
	<html:form action="AsocDocDigitalizadoScoringAction.do?opcion=adjuntar"
		onsubmit="return validarFormulario()" enctype="multipart/form-data">
		<div style="text-align: center;" align="center"><display:table width="100%" id="documentos"
			name="AsocDocDigitalizadoScoringForm" property="arrayDocDigitalizadoScoring" scope="session"
			pagesize="20" requestURI="">
			<display:column property="desScoring" title="Tipo Documento" headerClass="textoColumnaTabla"
				align="center" />
			<display:column title="Requerido" headerClass="textoColumnaTabla">
				<html:checkbox name="documentos" property="requeridoScoring" styleId="requeridoScoring" disabled="true" />
			</display:column>
			<display:column title="Fecha Creación" headerClass="textoColumnaTabla" align="center">
				<logic:notEmpty name="documentos" property="nombreArchivo">
					<bean:write name="documentos" property="fechaCreacion" />
				</logic:notEmpty>
			</display:column>
			<display:column title="Observaciones" align="center" headerClass="textoColumnaTabla">
				<logic:notEmpty name="documentos" property="nombreArchivo">
					<bean:write name="documentos" property="observacion" />
				</logic:notEmpty>
			</display:column>
			<display:column width="100" title="" align="center" headerClass="textoColumnaTabla">
				<logic:notEmpty name="documentos" property="nombreArchivo">
					<a href="javascript:visualizar('<bean:write name="documentos" property="numCorrelativo" />')">Ver
					Documento</a>
				</logic:notEmpty>
				<logic:empty name="documentos" property="nombreArchivo">
					Ver Documento
				</logic:empty>
			</display:column>
		</display:table></div>
	</html:form>
	<table class="botones">
		<tr>
			<td class="col1"></td>
			<td class="col2"></td>
			<td class="col1"></td>
			<td class="col2"><html:button property="aceptarButton" style="width: 180px" styleId="aceptarButton"
				onclick="aceptar()">ACEPTAR</html:button></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
