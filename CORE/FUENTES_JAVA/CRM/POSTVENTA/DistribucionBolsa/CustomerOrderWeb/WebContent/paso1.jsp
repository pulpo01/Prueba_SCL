<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<html>
<head>
  <title>Paso1</title>
</head>
<body>
<h2>Wizard paso 1/3</h2>
  <html:form method="post" action="/AccionPaso1">
    Name:&nbsp;<html:text property="name"/>
    <p>
    <html:submit property="accionEjecutar">
         <bean:message key="boton.proximo"/>
    </html:submit> 
    </p>
  </html:form>
  <hr />
</body>
</html>