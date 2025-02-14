<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Finalizar Venta</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	color: #666666;
	font-weight: bold;
	font-size: 12px;
}
-->
</style>
</head>

<body>
<table width="50%" border="0" align="center" class="textoColumnaTabla">
  <tr>
    <td><div align="left" class="style1">Finalizaci&oacute;n de venta </div></td>
  </tr>
  <tr>
    <td class="valorCampoInformativo">
	<p align="left" class="valorCampoInformativo">
		<logic:present name="mensajeSalida" scope="request">
	   		<bean:write name="mensajeSalida" scope="request"/>
	   	</logic:present>
	</p>
    </td>
  </tr>
</table>
</body>
</html>