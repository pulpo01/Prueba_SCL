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
<script type="text/javascript">
	
	function irAMenu() {
		parent.fncActDesacMenu(false);
		window.location.assign('iframe_portada.html');
	}
	
	function anterior() {
		var codModuloOrigen = document.getElementById("codModuloOrigen");
		var codModuloOrigenScoring = document.getElementById("codModuloOrigenScoring");
		if (codModuloOrigen.value == codModuloOrigenScoring.value) {
			document.getElementById("opcion").value = "anteriorGestionScoring";
		}
		else {
			document.getElementById("opcion").value = "anterior";
		}
	  	document.forms[0].submit();
	}
	
	function irReporteScoring() {
	  	document.getElementById("opcion").value = "reportarScoring";
	  	document.forms[0].submit();
	}

	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
  	function fncImprimirReporteScoring() {
 		document.getElementById("opcion").value = "imprimirReporteScoring";
	   	document.forms[0].submit();
  	}
  	
</script>
</head>
<body onkeydown="validarTeclas();">
<html:form method="POST" action="/ReporteScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden name="ReporteScoringForm" property="codModuloOrigen" styleId="codModuloOrigen" />
	<html:hidden name="ReporteScoringForm" property="codModuloOrigenScoring" styleId="codModuloOrigenScoring" />
	<table>
		<tr>
			<td class="amarillo">
			<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left" />Reporte Solicitud Scoring N° <bean:write name="ReporteScoringForm"
				property="numSolScoring" /></h2>
			</td>
		</tr>
	</table>
	<div id="wrapper">
	<p />
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><bean:write name="ReporteScoringForm" property="mensajeError" /></div>
			</td>
		</tr>
	</table>
	<table>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>NIT:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="nit" /></td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b><bean:write
				name="ReporteScoringForm" property="desTipoDocumento" />:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="documento" /></td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Nombre Cliente:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm" property="primerNombre" />&nbsp;
			<bean:write name="ReporteScoringForm" property="segundoNombre" />&nbsp; <bean:write
				name="ReporteScoringForm" property="primerApellido" />&nbsp; <bean:write
				name="ReporteScoringForm" property="segundoApellido" /></td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>N° L&iacute;neas:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="cantidadLineas" /></td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>N° Planes Tarifarios:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="cantidadPlanes" /></td>
		</tr>		
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Planes Tarifarios:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="desPlanes" /></td>
		</tr>		
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>N° Servicios Suplemetarios:</td>
			<td align="left"><bean:write name="ReporteScoringForm" property="cantidadServSup" /></td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Fecha evaluaci&oacute;n
			scoring:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm"
				property="fechaEvaluacion" format="dd-MM-yyyy" />&nbsp;</td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Resultado Evaluaci&oacute;n:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm"
				property="resultadoScoring" />&nbsp;</td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Estados Scoring:</td>
			<td colspan="2" align="left" width="90%"><bean:write name="ReporteScoringForm"
				property="desEstado" />&nbsp;</td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Clasificaci&oacute;n:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm"
				property="clasificacionCliente" />&nbsp;</td>
		</tr>
		<logic:present name="ReporteScoringForm" property="punteo">
			<tr>
				<td class="col2" align="left" style="font-size: 11px"><b>Punteo:</td>
				<td colspan="2" align="left"><bean:write name="ReporteScoringForm" property="punteo" /></td>
			</tr>
		</logic:present>
		<logic:present name="ReporteScoringForm" property="mensaje">
			<tr>
				<td class="col2" align="left" style="font-size: 11px"><b>Mensaje:</td>
				<td colspan="2" align="left"><bean:write name="ReporteScoringForm" property="mensaje" /></td>
			</tr>
		</logic:present>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>Vendedor:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm" property="nombreVendedor" />&nbsp;
			</td>
		</tr>
		<tr>
			<td class="col2" align="left" style="font-size: 11px"><b>C&oacute;digo Vendedor:</td>
			<td colspan="2" align="left"><bean:write name="ReporteScoringForm" property="codVendedor" />&nbsp;
			</td>
		</tr>
	</table>
	<br />
	<c:if test="${empty reporteScoring.docsDigScoringDTO == 'false'}">
		<table border=0>
			<tr>
				<td colspan=4>
				<hr />
				</td>
			</tr>
			<tr align="left">
				<td width=75% style="font-size: 11px"><b>Documento</td>
				<td class="col1" style="font-size: 11px; text-align: center"><b>Subido</td>
				<td class="col1" style="font-size: 11px; text-align: center"><b>Requerido</td>
			</tr>
			<tr>
				<td colspan="4">
				<hr />
				</td>
			</tr>
			<logic:iterate id="reporte" name="reporteScoring" property="docsDigScoringDTO"
				type="com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring.DocDigitalizadoScoringDTO">
				<tr align="left">
					<td><bean:write name="reporte" property="desScoring" /></td>
					<td style="text-align: center"><bean:write name="reporte" property="subido" /></td>
					<td style="text-align: center"><bean:write name="reporte" property="requeridoScoringRep" /></td>
				</tr>
			</logic:iterate>
		</table>
	</c:if> <br />
	<table>
		<td class="col1"><html:button style="width:150px; color:black;" property="anteriorButton" styleId="anteriorButton"
			onclick="anterior()"><<</html:button></td>
		<td class="col2"><html:button style="width:150px;color:black;" property="irAMenuButton" styleId="irAMenuButton"
			onclick="irAMenu()">VOLVER AL MENÚ</html:button></td>
		<td class="col1"></td>
		<td class="col2"><input type="button" style="width:180px;color:black;"
			value="IMPRIMIR REPORTE SCORING" onclick="ocultarMensajeError();fncImprimirReporteScoring();" />
		</td>
	</table>
	</div>
</html:form>
</body>
</html:html>
