<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page import="com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesSuspensionDTO" %>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<html:base/>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Suspensión Voluntaria de Servicio :.</title>

<script language="text/JavaScript" src="../suspensionVol/botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='../suspensionVol/js/SuspensionVoluntaria.js'></script>

<link href="../suspensionVol/css/mas.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	// Cantidad maxima de dias a suspender
	var maxDias = "<c:out value="${datosGenerales.maxDiasSuspVol}"/>";
	var cantSuspensiones = "<c:out value="${cantSuspensiones}"/>";
	
<%
	try {
		// Genero array tablaPeriodosSusp
		String codigo = null;
		codigo = Utilidades.generaMatrizPeriodosSup(request);
      	out.println(codigo);
	}
	catch (Exception ex)	{
		ex.printStackTrace();
	}	
%>

// ------------------------------------------------------------------------

	function defaults()	{
		document.forms[0].fecSuspension.selectedIndex = <%=session.getAttribute("indexFecSuspension")%>
	
	} // defaults

// ------------------------------------------------------------------------	
</script>	
</head>

<body class="body"  oncontextmenu="return false"  onload="javascript:defaults();">

<html:form action="/SuspensionVoluntariaAction" method="POST">

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>
