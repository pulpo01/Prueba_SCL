<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<html>
<head>
<script>
if(window.history.forward(1) != null)
{
	window.history.forward(1);
	alert('Por favor use las opciones que se encuentran en la pagina para navegar');                 
}
                 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Prueba</title>
</head>
<body>
<br>

<bean:write name="Abonado" property="nombreAbonado"/>
<h1>PRODUCTOS CONTRATADOS</h1>
	<logic:present name="Abonado" property="productoContratados">
	<bean:size id="size" name="Abonado" property="productoContratados"/>
	<logic:equal name="size" value="0">
	<!-- Crear un mensaje si no encuentra -->
	</logic:equal>
	<logic:greaterThan name="size" value="0">
		<logic:iterate id="Contratados" name="Abonado" property="productoContratados">
			<hr>
			<bean:write name="Contratados" property="nombre"/>
			<hr>
			<bean:write name="Contratados" property="codigo"/>
			<hr>
			<bean:write name="Contratados" property="tipo"/>
		</logic:iterate>
	</logic:greaterThan>
</logic:present>

<h1>PRODUCTOS DISPONIBLES</h1>
	<logic:present name="Abonado" property="productoDisponibles">
	<bean:size id="max" name="Abonado" property="productoDisponibles"/>
	<logic:equal name="max" value="0">
	<!-- Crear un mensaje si no encuentra -->
	</logic:equal>

	<logic:greaterThan name="max" value="0">
		<logic:iterate id="Disponibles" name="Abonado" property="productoDisponibles">
			<hr>
			<bean:write name="Disponibles" property="nombre"/>
			<hr>
			<bean:write name="Disponibles" property="codigo"/>
			<hr>
			<bean:write name="Disponibles" property="tipo"/>
		</logic:iterate>
	</logic:greaterThan>
</logic:present>




</head>
<body>

</body>
</html>