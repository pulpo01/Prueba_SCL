<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<html>
<head>
  <title>Paso3</title>
</head>
<body>
<h2>Wizard paso 3/3</h2>
  <html:form method="post" action="/AccionPaso3">
    Datos Completos....
    <p>
    <html:submit property="accionEjecutar">
         <bean:message key="boton.previo"/>
    </html:submit> 
    <html:submit property="accionEjecutar">
         <bean:message key="boton.finalizar"/>
    </html:submit>     
    </p>
  </html:form>
  <hr />
</body>
</html>