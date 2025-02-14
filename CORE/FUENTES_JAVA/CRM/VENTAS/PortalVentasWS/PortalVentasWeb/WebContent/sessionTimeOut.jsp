<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Expiración</title>

<style type="text/css">				

.barraarriba {
	background-color: #8EC135;
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 10px;
	font-weight: bold;
	text-decoration: none;
	color: #ffffff;
	text-align: left;
	vertical-align: top;
	padding-left: 2px;
	border: 1px none #CCCCCC;
}

.textoTitulo {
	font-family: Verdana, Arial, Helvetica, sans-serif;
	font-size: 13px;
	font-weight: bold;
	color: #003399;
	margin-top: 1px;
	margin-right: 0;
	margin-bottom: 0;
	margin-left: 0;
}

</style>

<script language="javascript">
function fncInicio(){
	parent.fncOcultaMenu();
}

function fncLogin(){
//	parent.location.href="<%=request.getContextPath()%>/login.jsp";
	parent.location.href="<%=request.getContextPath()%>/CargarLogin.do";
}

</script>
</head>
<body onload="fncInicio();">

<table width="100%">
  
  <tr>
    <td width="4%" colspan="3" align="right">&nbsp;</td>
  </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
    <tr>
    <td>
	 <table width="100%" border="0">
     <tr>
	   <td align="left" class="textoTitulo">
	   	<center><p>Su sesi&oacute;n ha expirado</p></center> 
	   </td>
     </tr>
     </table>
    </td>
  </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="center">
 		<input type="button" name="btnLogin" value="LOGIN" onclick="fncLogin();" style="width:120px;color:black">
	</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>
 <tr>
 	<td width="4%" colspan="3" align="right">&nbsp;</td>
 </tr>

 
</table>

</body>
<html>
