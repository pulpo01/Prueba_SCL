<jsp:include page="/pages/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<input type="hidden" id="codServicioSS" name="codServicioSS" value="<c:out value="${codServicioSS}"/>"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<input type="hidden" id="contextPathSS911CorreoFax" name="contextPathSS911CorreoFax" value="<c:out value="${pageContext.request.contextPath}"/>"/>

<script type='text/javascript' src='<%=request.getContextPath()%>/js/servsupl911correofax.js'></script>
<script language="javascript">
// Variable que almacena la cantidad de contactos iterados, no corresponden a los vizualizados en tabla;

var contContactos=0;



</script>
</head>

<body class="body" onload="display();cleanCampos();">

<html:form action="/ServiciosAdicionalesAction.do">
<table width="100%"  class="amarillo" >
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>