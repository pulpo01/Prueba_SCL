
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/controlTimeOut.js' language='JavaScript'></script>
<input type="hidden" name="contextpathSS" id="contextpathSS"  value="<c:out value="${pageContext.request.contextPath}"/>"/>
<script>
 
</script>
<link href="/css/mas.css" rel="stylesheet" type="text/css"/>
</head>

<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

	<table width="100%" border="0" >
	  <tr>
	     <td class="mensajeError"><div id="mensajes"></div></td>
	  </tr> 
	</table>

	<table width="100%" border="0">
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
	</tr>
     
     <tr>
		<td colspan="4" align="center">
		<table cellpadding="2" cellspacing="2" align=center>
			<td width="120"><b>Nombre del Cliente : </td>
			<td><c:out value="${clienteOS.cliente.nombres}"/></td>
			<td width="300"></td>
			<td width="120"><b>C&oacute;digo del Cliente :</td>
			<td><c:out value="${clienteOS.cliente.codCliente}"/></td>
		</table>				
     </tr>     
	</table>
