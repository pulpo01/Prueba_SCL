<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telef&oacute;nica M&oacute;viles .: <c:out value="${nombreOOSS}"/> :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/util.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/cambioSimCard/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='cambioSimCard/js/CambioDeSerie.js'></script>

<link href="cambioSimCard/css/mas.css" rel="stylesheet" type="text/css" />
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<script language="javascript">


function salir(){
	desReservaSerie();
	//window.close();
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
</html:html>