<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link rel="stylesheet" type="text/css" href="/css/mas.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mas.css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JDatosLineaAJAX.js'></script>
<script type="text/javascript">

	function irAMenu() {
		parent.fncActDesacMenu(false);
		window.location.assign('iframe_portada.html');
	}
		
	function adjuntarDocumentos() {
		document.getElementById("opcion").value = "adjuntarDocumentos";
		document.forms[0].submit();
	}
	
	function anteriorGestionScoring() {
		document.getElementById("opcion").value = "anteriorGestionScoring";
	  	document.forms[0].submit();
	}
	
	function aceptar(o) {
		o.disabled = true;
		var codEstadoDestino = document.getElementsByName("codEstadoDestino")[0];
		var codEstadoScoringAprobado = document.getElementsByName("codEstadoScoringAprobado")[0];
		var codEstadoScoringCancelado = document.getElementsByName("codEstadoScoringCancelado")[0];
		var codEstadoActualizaSolicitudNormal = document.getElementsByName("codEstadoActualizaSolicitudNormal")[0];
		if (codEstadoDestino.value == codEstadoScoringAprobado.value) {
			if (confirm("¿Está seguro que desea aprobar esta solicitud?")) {
				document.body.style.cursor = "wait";
				document.getElementById("opcion").value = "aprobarScoring";
				document.forms[0].submit();
			} 
			else {
				o.disabled = false;
			}
		}
		else if (codEstadoDestino.value == codEstadoScoringCancelado.value) {
			if (confirm("¿Está seguro que desea cancelar esta solicitud?")) {
				document.body.style.cursor = "wait";
				document.getElementById("opcion").value = "cancelarScoring";
     			document.forms[0].submit();
     		}
     		else {
				o.disabled = false;
			}
		}
		else if (codEstadoDestino.value == codEstadoActualizaSolicitudNormal.value) {   		 
			if (confirm("¿Está seguro que desea actualizar a Solicitud Normal?")) {
				document.body.style.cursor = "wait";
				document.getElementById("opcion").value = "actualizaSolNormal";
     			document.forms[0].submit();
     		}
     		else {
				o.disabled = false;
			}
		}
		else {
			alert("Seleccione un Estado Nuevo");
			o.disabled = false;
		}
	}
	
	/*
	function irAReporteScoring() {
	  	document.getElementById("opcion").value = "irAReporteScoring";
	  	document.forms[0].submit();
	}*/
	
	function body_onload() {
		document.body.style.cursor = "auto";
		var aceptarButtonE = document.getElementById("aceptarButtonE");
		if (aceptarButtonE != null) {
			aceptarButtonE.disabled = false;
		}
		var aceptarButtonR = document.getElementById("aceptarButtonR");
		if (aceptarButtonR != null) {
			aceptarButtonR.disabled = false;
		}
	}
	
</script>
</head>
<body onload="body_onload()" onkeydown="validarTeclas()">
<html:form method="POST" action="/ResumenScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion"/>
	<html:hidden name="ResumenScoringForm" property="codTipoCliente" styleId="codTipoCliente" />
	<html:hidden name="ResumenScoringForm" property="codPeriodo" styleId="codPeriodo"/>
	<html:hidden property="codEstadoActualizaSolicitudNormal" styleId="codEstadoActualizaSolicitudNormal"/>
	<html:hidden name="ResumenScoringForm" property="codEstadoScoringAprobado" styleId="codEstadoScoringAprobado"/>
	<html:hidden name="ResumenScoringForm" property="codEstadoScoringCancelado" styleId="codEstadoScoringCancelado"/>
	<bean:define id="codEstadoActual" name="ResumenScoringForm" property="codEstadoActual"
		type="java.lang.String" />
	<bean:define id="codModuloOrigen" name="ResumenScoringForm" property="codModuloOrigen"
		type="java.lang.String" />
	<table>
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Solicitud Scoring N° <bean:write name="ResumenScoringForm"
				property="numSolScoring" /> - <bean:write name="ResumenScoringForm" property="desEstadoActual" />
			</td>
		</tr>
	</table>
	<br />
	<div id="wrapper">
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><bean:write name="ResumenScoringForm" property="mensajeError" /></div>
			</td>
		</tr>
	</table>
	<br />
	<table>
		<tr>
			<td colspan="4">
			<h3>Datos de Cliente:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">NIT:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="nit" /></td>
			<td class="col1"><bean:write name="ResumenScoringForm" property="desTipoDocumento" />:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="documento" /></td>
		</tr>
		<tr>
			<td class="col1">Nombre Cliente:</td>
			<td colspan="3"><bean:write name="ResumenScoringForm" property="nombreCompleto" /></td>
		</tr>
		<tr>
			<td class="col1">Fecha Nacimiento:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="fecha_nacimiento"
				format="dd-MM-yyyy" /></td>
			<td class="col1">Nacionalidad:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="desNacionalidad" /></td>
		</tr>
		<tr>
			<td class="col1">Estado Civil:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="desEstadoCivil" /></td>
			<td class="col1">Nivel Académico:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="desNivelAcademico" /></td>
		</tr>
		<tr>
			<td class="col1">Tipo Empresa:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="desTipoEmpresa" /></td>
			<td class="col1">Antigüedad Laboral (Años):</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="antiguedad_laboral" /></td>
		</tr>
	</table>
	<logic:equal name="ResumenScoringForm" property="aplicaTarjeta" value="SI">
		<table>
			<tr>
				<td class="col1">Tipo Tarjeta:</td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="desTipoTarjeta" /></td>
				<td class="col1">N° Tarjeta:</td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="numTarjeta" /></td>
			</tr>
		</table>
	</logic:equal> <logic:present name="ResumenScoringForm" property="clasificacion">
		<table>
			<tr>
				<td colspan=4>
				<hr />
				</td>
			</tr>
			<tr>
				<td class="col1">Clasificaci&oacute;n:</td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="clasificacion" /></td>
				<td class="col1">Punteo:</td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="punteo" /></td>
			</tr>
		</table>
	</logic:present> <logic:equal name="ResumenScoringForm" property="codEstadoScoringEvaluado"
		value="<%= codEstadoActual %>">
		<table>
			<tr>
				<td colspan=4>
				<hr />
				</td>
			</tr>
			<tr>
				<td colspan="4">
				<h3>Documentos:</h3>
				</td>
			</tr>
			<tr>
				<td colspan="4"><a href="javascript:adjuntarDocumentos()">Asociaci&oacute;n de
				Documentos</a></td>
			</tr>
		</table>
	</logic:equal>
	<table>
		<tr>
			<td colspan=4>
			<hr />
			</td>
		</tr>
		<logic:equal name="ResumenScoringForm" property="codEstadoScoringPendientePreactivar"
			value="<%= codEstadoActual %>">
			<tr>
				<td class="col1">N° Venta:</td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="numVenta" /></td>
				<td class="col2"><bean:write name="ResumenScoringForm" property="comentario" /></td>
			</tr>
		</logic:equal>
		<tr>
			<td class="col1">Estado Actual:</td>
			<td class="col2"><bean:write name="ResumenScoringForm" property="desEstadoActual" /></td>
			<td class="col1"><logic:equal name="ResumenScoringForm" property="codEstadoScoringEvaluado"
				value="<%= codEstadoActual %>">Estado Nuevo:</logic:equal> <logic:equal
				name="ResumenScoringForm" property="codEstadoScoringRechazado" value="<%= codEstadoActual %>">Estado Nuevo:</logic:equal></td>
			<td class="col2"><logic:equal name="ResumenScoringForm" property="codEstadoScoringEvaluado"
				value="<%= codEstadoActual %>">
				<html:select name="ResumenScoringForm" property="codEstadoDestino" styleId="codEstadoDestino">
					<html:option value="">- Seleccione Opción -</html:option>
					<html:optionsCollection name="ResumenScoringForm" property="arrayEstadosDestino"
						value="codEstado" label="desEstado" />
				</html:select>
			</logic:equal> <logic:equal name="ResumenScoringForm" property="codEstadoScoringRechazado"
				value="<%= codEstadoActual %>">
				<html:select name="ResumenScoringForm" property="codEstadoDestino" styleId="codEstadoDestino">
					<html:option value="">- Seleccione Opción -</html:option>
					<html:optionsCollection name="ResumenScoringForm" property="arrayEstadosDestino"
						value="codEstado" label="desEstado" />
				</html:select>
			</logic:equal></td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan=4>
			<hr />
			</td>
		</tr>
		<tr>
			<td class="col1"><logic:equal name="ResumenScoringForm" property="codModuloGestionScoring"
				value="<%= codModuloOrigen %>">
				<html:button style="width:150px; color:black;" property="anteriorButton" styleId="anteriorButton"
					onclick="anteriorGestionScoring()"><<</html:button>
			</logic:equal> <logic:notEqual name="ResumenScoringForm" property="codModuloGestionScoring"
				value="<%= codModuloOrigen %>">
				<html:button property="irAMenuButton" styleId="irAMenuButton" onclick="irAMenu()" style="width: 150px">VOLVER AL MENÚ</html:button>
			</logic:notEqual></td>
			<td class="col2"></td>
			<td class="col1"></td>
			<td class="col2"><logic:equal name="ResumenScoringForm" property="codEstadoScoringEvaluado"
				value="<%= codEstadoActual %>">
				<html:button property="aceptarButtonE" styleId="aceptarButtonE" onclick="aceptar(this)" style="width: 150px">ACEPTAR</html:button>
			</logic:equal> <logic:equal name="ResumenScoringForm" property="codEstadoScoringRechazado"
				value="<%= codEstadoActual %>">
				<html:button property="aceptarButtonR" styleId="aceptarButtonR" onclick="aceptar(this)" style="width: 150px">ACEPTAR</html:button>
			</logic:equal></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html:html>
