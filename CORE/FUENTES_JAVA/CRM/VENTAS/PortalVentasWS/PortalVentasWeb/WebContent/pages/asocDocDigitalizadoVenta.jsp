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
			window.location.assign('AsocDocDigitalizadoVentaAction.do?opcion=eliminar&numCorrelativo=' + o);
		}
	}

	function visualizar(o) {
		var opciones = "location=no, menubar=no";
		var URL = '<%=request.getContextPath()%>/DocDigitalizadoServlet?numCorrelativo=' + o;
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
<html:form action="AsocDocDigitalizadoVentaAction.do?opcion=adjuntar"
	onsubmit="return validarFormulario()" enctype="multipart/form-data">
	<html:hidden property="extensionesValidas" name="AsocDocDigitalizadoVentaForm" styleId="extensionesValidas" />
	<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
		hspace="2" align="left" /> Asociación de Documentos</h2>
	<br />
	<div id="wrapper">
	<table>
		<tr>
			<td class="col1">Tipo de Documento (*)</td>
			<td class="col2"><html:select name="AsocDocDigitalizadoVentaForm"
				property="codTipoDocDigitalizado" styleId="codTipoDocDigitalizado">
				<html:optionsCollection property="arrayTipoDocDigitalizado" value="codTipoDocDigitalizado"
					label="desTipoDocDigitalizado" />
			</html:select></td>
			<td class="col1" />
			<td class="col2" />
		</tr>
		<tr>
			<td class="col1">Seleccione archivo (*):</td>
			<td colspan="3"><html:file style="width: 80%" name="AsocDocDigitalizadoVentaForm"
				property="archivoFormFile" styleId="archivoFormFile"/></td>
		</tr>
		<tr>
			<td class="col1">Observaciones:</td>
			<td colspan="3"><html:text style="width: 80%" name="AsocDocDigitalizadoVentaForm"
				property="observacion" styleId="observacion" /></td>
		</tr>
		<tr>
			<td class="col1"></td>
			<td colspan="3"><html:submit style="width: 120px">ADJUNTAR</html:submit></td>
		</tr>
		<tr>
			<td class="col1"></td>
			<td colspan="3"><i>(*): Campos obligatorios</i></td>
		</tr>
		<tr>
			<td colspan="4">
			<h3><bean:write name="AsocDocDigitalizadoVentaForm" property="mensajeAccion"></bean:write></h3>
			</td>
		</tr>
	</table>
	<hr />
	<br />
	<h2>Documentos asociados a la solicitud de venta N°: <bean:write
		name="AsocDocDigitalizadoVentaForm" property="numVenta" /></h2>
	<br />
	<div style="text-align: center;" align="center"><display:table width="100%" id="documentos"
		name="AsocDocDigitalizadoVentaForm" property="arrayDocDigitalizado" scope="session" pagesize="10"
		requestURI="">
		<display:column property="desTipoDocDigitalizado" title="Tipo Documento"
			headerClass="textoColumnaTabla" align="center" />
		<display:column property="observacion" title="Observaciones" headerClass="textoColumnaTabla"
			align="center" />
		<display:column property="fechaCreacion" title="Fecha Creación" headerClass="textoColumnaTabla"
			align="center" />
		<display:column title="" align="center" headerClass="textoColumnaTabla">
			<a href="javascript:visualizar('<bean:write name="documentos" property="numCorrelativo" />')">Ver</a>
		</display:column>
		<display:column title="" align="center" headerClass="textoColumnaTabla">
			<a href="javascript:eliminar('<bean:write name="documentos" property="numCorrelativo" />')">Eliminar</a>
		</display:column>
	</display:table></div>
	<table>
		<tr>
			<td>
			<h3><bean:write name="AsocDocDigitalizadoVentaForm" property="mensaje"></bean:write></h3>
			</td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
