<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prueba</title>
<br>

<bean:write name="ClienteVTA" property="nombre"/> <bean:write name="ClienteVTA" property="apellidoPaterno"/> <bean:write name="ClienteVTA" property="apellidoMaterno"/>
<hr>
<logic:present name="ClienteVTA" property="listadoAbonados">
	<bean:size id="size" name="ClienteVTA" property="listadoAbonados"/>
	<logic:equal name="size" value="0">
	<!-- Crear un mensaje si no encuentra -->
	</logic:equal>

	<logic:greaterThan name="size" value="0">
		<logic:iterate id="listadoAbonados" name="ClienteVTA" property="listadoAbonados">
			<hr>
			<bean:write name="listadoAbonados" property="numAbonado"/>
			<hr>
			<bean:write name="listadoAbonados" property="numCelular"/>
			<hr>
			<bean:write name="listadoAbonados" property="nombreAbonado"/>
		</logic:iterate>
	</logic:greaterThan>
</logic:present>
</head>
<body>

</body>
</html>