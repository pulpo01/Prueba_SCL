<%@ page language="java" contentType="text/html; charset=ISO-8859-1"    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Facturacion Diferenciada</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />

<script language="javascript">


function salir(){
	window.close();
}

  
</script>
</head>

<body class="body">

<form>
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
</table>

</form>
</body>
</html>