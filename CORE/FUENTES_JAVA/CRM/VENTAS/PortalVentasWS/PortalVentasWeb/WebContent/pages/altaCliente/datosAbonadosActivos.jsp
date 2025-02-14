<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO"%>

<%AbonadoDTO[] listaAbonados = (AbonadoDTO[]) request.getSession().getAttribute("listaAbonados");%>
<html>
<head>    
<meta http-equiv="expires" content="0">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
</head>
<body>
		<fieldset style="height:80px;"><legend>Abonados Activos</legend>
<%if(null!=listaAbonados && listaAbonados.length >0){ %>
<center>
<table width="100%">
	<tr align="center" valign="top">
		<th width="auto" height="16">C&oacute;digo Cliente</th>
		<th width="auto" height="16">N&uacute;mero Celular</th>		
		<th width="auto" height="16">Fecha Alta</th>
		<th width="auto" height="16">Situaci&oacute;n</th>
		<th width="auto" height="16">Estado Venta</th>
		<th width="auto" height="16"></th>
	</tr>
	<logic:iterate id="abonados" name="listaAbonados">
		<tr align="center" valign="top">
			<td><bean:write name="abonados" property="codCliente"/></td>
			<td><bean:write name="abonados" property="numCelular"/></td>
			<td><bean:write name="abonados" property="fecAlta"/></td>
			<td><bean:write name="abonados" property="desSituacion"/></td>
			<td><bean:write name="abonados" property="strEstadoVenta"/></td>
		</tr>
    </logic:iterate>
</table>	
<html:button value="CONTINUAR(BURO)" style="color:black;" property="btnBuro" styleId="btnBuro" onclick="window.close();"/>
</center>
<%}else{%>
	<center>
<table width="100%">
	<tr align="center" valign="top">
		<th width="auto" height="16">C&oacute;digo Cliente</th>
		<th width="auto" height="16">N&uacute;mero Celular</th>		
		<th width="auto" height="16">Fecha Alta</th>
		<th width="auto" height="16">Situaci&oacute;n</th>
		<th width="auto" height="16">Estado Venta</th>
		<th width="auto" height="16"></th>
	</tr>
	<tr>
		<td colspan="6">N&uacute;mero de Identificaci&oacute;n NO tiene Abonados Vigente</td>
	</tr>
</table>	
<html:button value="CONTINUAR(BURO)" style="color:black;" property="btnBuro" styleId="btnBuro" onclick="window.close();"/>
</center>
<%}%>
</fieldset>
</body>
</html>