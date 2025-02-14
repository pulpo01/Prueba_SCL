<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
long time = new java.util.Date().getTime();
String loginURL = "../main/Login.jsp?timestamp=" + time;

%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../styles/mas.css" rel="stylesheet" type="text/css" />

<title>Session Expirada</title>
<script language="javascript">

function irLogin() {
	parent.location.href="<%=response.encodeRedirectURL(loginURL)%>";
}

</script>

</head>
<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="barraarriba">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="textoTitulo"><img src="../img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>Sessi&oacute;n Expirada </td>
  </tr>
</table>

<table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
	<td colspan="4">&nbsp;</td>
  </tr>
  <tr><td colspan="4">&nbsp;</td></tr>
  <tr>
	<td width="6%">&nbsp;</td>
	<td colspan="3">
	<div style="padding:8px;border:2px solid #8EC135;margin:0px">
	<table border="0" width="100%" align="center">
		<tr>
			<td align="center">La session expir&oacute;</td>
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
    <td colspan="5" align="center">
    <a href="#"><img style="cursor: pointer;" src="../botones/btn_salir.gif" alt="Salir" border="0" id="Salir2" onmouseover="sobreElBoton('Salir2','../botones/btn_salir_roll.gif')"  
    onmouseout="sobreElBoton('Salir2','../botones/btn_salir.gif')" width="85" height="19" onclick="salir();" /></a>
    </td>
  </tr> 
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

</body>
</html>