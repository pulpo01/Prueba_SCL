<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<%
long time = new java.util.Date().getTime();
String location = (String)request.getAttribute("location");

if(location == null){
	
	location = "../common/Empty.html";
}

location = location + "?timestamp=" + time;
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link href="../styles/mas.css" rel="stylesheet" type="text/css">
<title>Resultado</title>
<script language="javascript">
function formularioAceptar()
{
  parent.display.location.href="<%=location%>";
}
</script>
</head>
<body onload="document.getElementById('aceptar').focus()">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="textoTitulo"><img src="../images/green_arrow.gif" width="15" height="15" hspace="2" align="left"/> Carpeta Comercial</td>
  </tr>
</table>

<table width="90%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
	<td colspan="4">&nbsp;</td>
  </tr>
  <tr><td colspan="4">&nbsp;</td></tr>
  <tr>
	<td width="6%">&nbsp;</td>
	<td colspan="3">
	<div style="padding:8px;border:2px solid #8EC135;margin:0px">
	<table border="0" width="90%">
		<tr>
			<td align="center"><strong>Operaci&oacute;n finalizada con exito</strong></td>
		</tr>
	</table>
	</div>
	</td>
  </tr>
  <tr>
	<td>&nbsp;</td>
	<td colspan="3">&nbsp;</td>
  </tr>
</table> 
		
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td align="center"><input type="button" class="boton" id="aceptar" name="aceptar" value="ACEPTAR" onClick="formularioAceptar()" /></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>  

</body>
</html>