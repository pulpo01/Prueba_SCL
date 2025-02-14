<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<c:set var="DatosSessionDTO" value="${sessionScope.DatosSessionDTO}"></c:set> 
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="/css/mas.css" rel="stylesheet" type="text/css" />

<title>.::Telefónica Móviles::.<c:out value="${DatosSessionDTO.nomOperadora }"/> </title>

	<table width="100%" border="0" >
		<tr>
			<td  width="100%"class="barraarriba">Usuario: <c:out value="${DatosSessionDTO.nomUsuario}"/> &nbsp; Operadora: <c:out value="${DatosSessionDTO.nomOperadora}"/></td>
			 
		</tr>
		<tr>
			<td>
			<h1><b><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
	       	Informaci&oacute;n del Cliente
      			</b>
      			</h1>
				<fieldset style="border: 1px solid rgb(0, 0, 160);>
					<legend class="textoSubTitulo"></legend>
					<table width="100%">
					   <tr>	
							<td width="15%">C&oacute;digo:</td><td><c:out value="${DatosSessionDTO.codCliente}"/></td>
							
							<td width="15%" align="right"> Cliente:</td><td><c:out value="${DatosSessionDTO.nomCliente}"/></td>
						</tr>
						<tr></tr>
						<tr>
							<td width="15%">N&uacute;mero Abonado:</td><td><c:out value="${DatosSessionDTO.codCliente}"/></td>
							<td width="15%" align="right">Celular:</td><td><c:out value="${DatosSessionDTO.codCliente}"/></td>
							<td width="25%" align="right">Plan Tarifario:</td><td><c:out value="${DatosSessionDTO.codCliente}"/></td>
						</tr>
						<p>
					</table>
				</fieldset>
			</td>
		</tr>
	</table>

</head>

