<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<%
	long time = new java.util.Date().getTime();
	
	String cerrarAction = "../abonoLimiteConsumo/CerrarAction.do?timestamp=" + time;
	
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>

<script language="javascript">
  
  function salir(){
	location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
  }

</script>
</head>

<body class="body">

<form>
<table width="100%" align="center">
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
</table>

</form>
</body>
</html:html>