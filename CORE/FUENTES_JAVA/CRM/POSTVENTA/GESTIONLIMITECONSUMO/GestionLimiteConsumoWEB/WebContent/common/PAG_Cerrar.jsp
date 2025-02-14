<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%

	request.getSession().invalidate();
%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="../css/mas.css" rel="stylesheet" type="text/css" />
<title>Cerrar</title>
<script language="javascript">

function cerrarAplicacion(){

	window.close();
}
</script>
</head>

<body onload="cerrarAplicacion();">
</body>
</html>
