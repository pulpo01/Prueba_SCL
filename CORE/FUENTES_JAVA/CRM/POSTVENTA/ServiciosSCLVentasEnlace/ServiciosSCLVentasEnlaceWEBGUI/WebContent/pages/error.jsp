<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<title>Resultado operaci&oacute;n</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/ServiciosSCLVentasEnlaceWEBGUI/estilos/estilos.css"/>
</head>
<body>
<table width="600" height="72" align="center">
	<tr>
		<td class="TextoCampo" align="right"><logic:present name="fecha"><bean:write name="fecha"/></logic:present></td>
	</tr>
	<tr>
		<td class="TextoBlanco" align="right"><logic:present name="Form" property="nomUsuarioSCL">Usuario SCL: <bean:write name="Form" property="nomUsuarioSCL"/> / </logic:present>
											  <logic:present name="Form" property="numAbonado">Num. Abonado: <bean:write name="Form" property="numAbonado"/></logic:present></td>
	</tr>
</table>
<br>
<table class="principal" width="600" height="400" align="center" bordercolor="#9ECA52">
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td>
			<table width="50%" align="center">
				
				<tr>
					<td class="TextoLabelError" align="center">
						<logic:present name="Form" property="mostrarNroOOSS">
							<logic:present name="Form" property="nroOOSS">La orden de servicio se ha generado correctamente.</logic:present>
						</logic:present>
						<logic:notPresent name="Form" property="mostrarNroOOSS">
							<logic:present name="Form" property="codError"><bean:write name="Form" property="codError"/></logic:present>
							<logic:notPresent name="Form" property="codError">ERR.GUI</logic:notPresent>
						</logic:notPresent>
					</td>
				</tr>
				<tr>
					<td class="TextoLabelError" align="center">
						<logic:present name="Form" property="mostrarNroOOSS">
							<logic:present name="Form" property="nroOOSS">El n&uacute;mero de orden de servicio es: <bean:write name="Form" property="nroOOSS"/></logic:present>
						</logic:present>
						<logic:notPresent name="Form" property="mostrarNroOOSS">
							<logic:present name="Form" property="desError"><bean:write name="Form" property="desError"/></logic:present>
							<logic:notPresent name="Form" property="desError">Error al conectarse al servicio</logic:notPresent>
						</logic:notPresent>
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
</body>
</html:html>