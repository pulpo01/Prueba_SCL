<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link rel="stylesheet" type="text/css" href="/css/mas.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mas.css" />
<script type="text/javascript">

	function anterior() {
		document.getElementById("opcion").value = "anterior";
	   	document.forms[0].submit();
	}

</script>
</head>
<body>
<html:form method="POST" action="/DatosLineaScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<table>
		<tr>
			<td class="amarillo">
			<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left" />Solicitud Scoring</h2>
			</td>
		</tr>
	</table>
	<p />
	<div id="wrapper">
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="mensajeError">
				<bean:write name="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
	</table>
	<br />
	<table class="botones">
		<tr>
			<td class="col1"><html:button property="anteriorButton" onclick="anterior()" styleId="anteriorButton"
				style="width: 180px"><<</html:button></td>
			<td class="col2"></td>
			<td class="col1"></td>
			<td class="col2"></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
