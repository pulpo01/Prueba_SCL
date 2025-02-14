<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Ejecución</title>
<link rel="stylesheet" type="text/css" href="/ServiciosSCLVentasEnlaceWEBGUI/estilos/estilos.css"/>
<style type="text/css">
	table.principal {
		border-width: 5px;
		border-spacing: ;
		border-style: solid;
		border-color: rgb(132, 182, 220);/*#84B6DC*/
		border-collapse: collapse;
		
	}
</style>
	</head>
	<body>
		<html:form action="asociaRangoAction">
			<html:hidden property="accion" />
			<html:hidden property="numTransaccion"/>
			<table class="principal" width="600" height="400" align="center">
	<tr><td>&nbsp;</td></tr>
				<tr>
					<td>
						<table width=550" height="72" align="left">
							<tr>
								<td>&nbsp;</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
				</tr>				
				<tr>
					<td>
						<logic:present name="Form" property="codError">
							<table >
								<tr>
									<td colspan="2">Ejecuci&oacute;n fallida</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;
								</tr>
								<tr>
									<td>C&oacute;digo de error: </td>
									<td><html:text property="codError" readonly="true" size="65"/></td>
								</tr>
								<tr>
									<td>Descripci&oacute;n del error: </td>
									<td><html:text property="desError" readonly="true" size="65"/></td>
								</tr>
							</table>
						</logic:present>			
						<logic:notPresent name="Form" property="codError">
							<table class="principal">
								<tr>
									<td colspan="2">Ejecuci&oacute;n realizada exitosamente</td>
								</tr>
								<tr>
									<td colspan="2">&nbsp;
								</tr>
								<tr>
									<td>N&uacute;mero de orden de servicio: </td>
									<td><html:text property="nroOOSS" readonly="true" /></td>
								</tr>
							</table>
						</logic:notPresent>		
					</td>
				</tr>
			</table>
		</html:form>
	</body>
</html>
