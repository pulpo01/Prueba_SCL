<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
 	window.history.forward(1);
	
 	
 	function obtenerDatosOverrideTexto() {
 		var resultado = "";
		var nombreTabla = "lineas";
		var tabla = document.getElementById(nombreTabla);
		var bodyTabla = tabla.getElementsByTagName("tbody")[0];
		for (var i = 0; i < bodyTabla.rows.length; i++) {
			var fila = bodyTabla.rows[i];
			for (var j = 0; j < fila.cells.length; j++) {
				var celda = fila.cells[j];
				var numAbonadoHidden = celda.getElementsByTagName("input")[0];
				if (numAbonadoHidden.name == "numAbonado" && numAbonadoHidden.type == "hidden") {
					var numAbonado = numAbonadoHidden.value;
					var dom = celda.getElementsByTagName("table")[0];
					dom = dom.rows[1];
					dom = dom.getElementsByTagName("table")[0];
					dom = dom.rows[1];
					dom = dom.getElementsByTagName("table")[0];
					var valoresOverride = ""; 
					for (var k = 1; k < dom.rows.length; k++) { //correlativos
						var f = dom.rows[k];
						var correlativoHidden = f.getElementsByTagName("input")[0];
						if (correlativoHidden.name == "correlativoCargo" && correlativoHidden.type == "hidden") {
							var importeOverrideInput = f.getElementsByTagName("td")[3].getElementsByTagName("input")[0];
							if (importeOverrideInput.name == "importeOverride" && importeOverrideInput.type == "text") {
								if (importeOverrideInput.value != "" && importeOverrideInput.value != null)
								{
									valoresOverride += correlativoHidden.value + ";" + importeOverrideInput.value + ";";
								}
							}
						}
					}
					if (valoresOverride != "" && valoresOverride != null)
					{
						resultado += numAbonado + ";" + valoresOverride + "-";	
					}
				}
			}
		}
		return resultado;
 	}
 	
 	function aceptar() {
 		var datosOverrideTexto = obtenerDatosOverrideTexto();
 		if (datosOverrideTexto != null && datosOverrideTexto != "")	{
 			if (window.confirm("¿Desea sobrescribir cargos?")) {
 				document.getElementById("valoresOverrideTabla").value = datosOverrideTexto;
 				document.getElementById("opcion").value = "aceptar";
 				document.forms[0].submit();
 			}
 		}
 		else {
 			if (window.confirm("No hay cargos sobreescritos. ¿Desea salir de esta página?")) {
 				document.getElementById("opcion").value = "cancelar";
				document.forms[0].submit();	 	
 			}
 		}
 	}
 	
 	function continuarFormalizacion() {
 		var datosOverrideTexto = obtenerDatosOverrideTexto();
 		if (datosOverrideTexto != null && datosOverrideTexto != "")	{
			document.getElementById("valoresOverrideTabla").value = datosOverrideTexto;
			document.getElementById("opcion").value = "continuarACargos";
			document.forms[0].submit();
 		}
 		else {
 			if (window.confirm("No hay cargos sobreescritos. ¿Desea continuar?")) {
 				document.getElementById("opcion").value = "continuarACargos";
				document.forms[0].submit();	 	
 			}
 		}
 	}
 	
 	function fncCancelar() {
		document.getElementById("opcion").value = "cancelar";
		document.forms[0].submit();	 
 	}
 	
 	function fncCancelarFormalizacion() {
		document.getElementById("opcion").value = "cancelarOverrideFormalizacion";
		document.forms[0].submit();	 
 	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	

</script>
<style type="text/css">
td {
	height: 20px;
}
</style>
</head>
<body onload="history.go(+1);" onkeydown="validarTeclas();">
<html:form method="POST" action="/OverrideSolicitudAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="flagPermiteCambioEstado" styleId="flagPermiteCambioEstado" />
	<html:hidden property="desEstadoNuevo" styleId="desEstadoNuevo" />
	<html:hidden property="valoresOverrideTabla" styleId="valoresOverrideTabla" />
	<html:hidden property="activarOverride" styleId="activarOverride" />
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left"><bean:write name="OverrideSolicitudForm" property="titulo" />
			&nbsp;N°&nbsp;<bean:write name="OverrideSolicitudForm" property="numVenta" />
			</td>
		</tr>
	</table>
	<table width="90%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="OverrideSolicitudForm" property="mensajeError">
				<bean:write name="OverrideSolicitudForm" property="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
	</table>
	<table width="100%" align="center">
		<tr>
			<td width="100%">
			<table width="100%">
				<tr>
					<td align="left" colspan="6"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Informaci&oacute;n del Cliente</td>
				</tr>
				<tr>
					<td align="left"><bean:write name="OverrideSolicitudForm" property="desTipoIdentificacion" /></td>
					<td align="right">:</td>
					<td align="left" colspan="4"><bean:write name="OverrideSolicitudForm"
						property="numIdentificacion" /></td>
				</tr>
				<logic:equal name="OverrideSolicitudForm" property="flagClienteEmpresa" value="0">
					<tr>
						<td align="left">Nombre y apellido</td>
						<td align="right">:</td>
						<td align="left" colspan="4"><bean:write name="OverrideSolicitudForm"
							property="nombreCompleto" /></td>
					</tr>
				</logic:equal>
				<logic:equal name="OverrideSolicitudForm" property="flagClienteEmpresa" value="1">
					<tr>
						<td align="left">Nombres empresa</td>
						<td align="right">:</td>
						<td align="left" colspan="4"><bean:write name="OverrideSolicitudForm"
							property="nombreEmpresa" /></td>
					</tr>
				</logic:equal>
				<tr>
					<td align="left" width="27%">Calificaci&oacute;n</td>
					<td align="right" width="3%">:</td>
					<td align="left" width="20%"><bean:write name="OverrideSolicitudForm"
						property="calificacion" /></td>
					<td align="left" width="17%">Clasificaci&oacute;n</td>
					<td align="right" width="3%">:</td>
					<td align="left" width="30%"><bean:write name="OverrideSolicitudForm"
						property="clasificacion" /></td>
				</tr>
				<tr>
					<td align="left">Color</td>
					<td align="right">:</td>
					<td align="left"><bean:write name="OverrideSolicitudForm" property="color" /></td>
					<td align="left">Segmento</td>
					<td align="right">:</td>
					<td align="left"><bean:write name="OverrideSolicitudForm" property="segmento" /></td>
				</tr>
				<tr>
					<td align="left">Monto preautorizado</td>
					<td align="right">:</td>
					<td align="left" colspan="4"><bean:write name="OverrideSolicitudForm"
						property="montoPreautorizado" /></td>
				</tr>
				<tr>
					<td colspan="6">
					<HR noshade>
					</td>
				</tr>
				<tr>
					<td align="left" colspan="4"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Informaci&oacute;n de L&iacute;neas de la Solicitud</td>
				</tr>
				<tr>
					<td align="left" width="27%">Modalidad Venta</td>
					<td align="right" width="3%">:</td>
					<td align="left" width="20%"><bean:write name="OverrideSolicitudForm"
						property="desModalidadVenta" /></td>
					<td align="left" width="17%">Tipo Contrato</td>
					<td align="right" width="3%">:</td>
					<td align="left" width="30%"><bean:write name="OverrideSolicitudForm"
						property="desTipoContrato" /></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td width="100%" align="center"><display:table id="lineas" name="OverrideSolicitudForm"
				property="arrayLineasSol" scope="session" pagesize="10" requestURI="" width="100%">
				<display:column width="100%">
					<html:hidden name="lineas" property="numAbonado" styleId="numAbonado" />
					<table width="100%">
						<tr>
							<td style="font-weight: bold">N&uacute;m. Abonado: <bean:write name="lineas" property="numAbonado" /></td>
							<logic:greaterThan value="0" name="lineas" property="numCelular">
								<td style="font-weight: bold">N&uacute;m. Tel&eacute;fono: <bean:write name="lineas" property="numCelular" /></td>
							</logic:greaterThan>
							<td style="font-weight: bold">Plan: <bean:write name="lineas" property="planTarifario" /></td>
							<td style="font-weight: bold">Descripci&oacute;n Equipo: <bean:write name="lineas" property="desEquipo" /></td>
						</tr>
						<tr>
							<td colspan="4">
							<table width="100%">
								<tr>
									<td width="50%" align="center" class="textoColumnaTabla">Detalle Cargos Recurrentes</td>
								</tr>
								<tr>
									<td valign="top">
									<table width="100%">
										<tr>
											<td width="55%" align="center"><u>Concepto</u></td>
											<td width="15%" align="center"><u>Precio</u></td>
											<td width="15%" align="center"><u>Moneda</u></td>
											<td width="15%" align="center"><u>Precio (Override)</u></td>
										</tr>
										<logic:iterate id="cargosRecurrentes" name="lineas" property="cargosRecurrentes">
											<tr>
												<html:hidden name="cargosRecurrentes" property="correlativoCargo" styleId="correlativoCargo" />
												<td align="left"><bean:write name="cargosRecurrentes" property="desConcepto" /></td>
												<td align="right"><bean:write name="cargosRecurrentes" property="cargos"
													locale="Locale-PortalVentas" format="###,##0.0000" /></td>
												<td align="center"><bean:write name="cargosRecurrentes" property="desMoneda" /></td>
												<logic:equal name="OverrideSolicitudForm" property="activarOverride" value="false">
													<td align="right"><bean:write name="cargosRecurrentes" property="importeOverride"
														locale="Locale-PortalVentas" format="###,##0.0000" /></td>
												</logic:equal>
												<logic:equal name="OverrideSolicitudForm" property="activarOverride" value="true">
													<td align="center"><html:text name="cargosRecurrentes"
														onkeyup="javascript:this.value = validarNumero(this.value, 10, 4)" styleId="importeOverride"
														property="importeOverride" style="text-align: right; width: 120px" value="" /></td>
												</logic:equal>
											</tr>
										</logic:iterate>
									</table>
									</td>
								</tr>
							</table>
							</td>
						</tr>
					</table>
				</display:column>
			</display:table></td>
		</tr>
	</table>
	<HR noshade>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td width="50%" align="left"></td>
			<td width="25%" align="right"><logic:equal name="OverrideSolicitudForm"
				property="codModuloOrigen" value="13.1">
				<html:button property="btnCancelar" onclick="ocultarMensajeError();fncCancelar()" styleId="btnCancelar"
					style="width: 120px; color: black; text-align: center;"><<</html:button>
			</logic:equal> <logic:equal name="OverrideSolicitudForm" property="codModuloOrigen" value="13.2">
				<html:button property="btnCancelar" onclick="ocultarMensajeError();fncCancelarFormalizacion()" styleId="btnCancelar"
					style="width: 120px; color: black; text-align: center;"><<</html:button>
			</logic:equal></td>
			<td width="25%" align="right"><logic:equal value="true" name="OverrideSolicitudForm"
				property="aplicaOverrideSolicitud">
				<html:button value="ACEPTAR" style="width: 120px; color: black; text-align: center;" styleId="btnAceptar"
					property="btnAceptar" onclick="ocultarMensajeError();aceptar();" />
			</logic:equal> <logic:equal value="true" name="OverrideSolicitudForm" property="aplicaOverrideFormalizacion">
				<html:button style="width: 120px; color: black; text-align: center;" property="btnAceptar" styleId="btnAceptar"
					onclick="ocultarMensajeError();continuarFormalizacion();">>></html:button>
			</logic:equal></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
