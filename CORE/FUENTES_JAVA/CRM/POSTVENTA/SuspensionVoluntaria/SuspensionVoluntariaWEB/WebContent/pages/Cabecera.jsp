<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
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
				<table cellpadding="2" cellspacing="2" align=center border="0">
					<tr>
						<td width="120"><b>Nombre del Cliente : </td>
						<td><c:out value="${clienteOS.cliente.nombres}"/></td>
						<td width="300">&nbsp;</td>
						<td width="120"><b>C&oacute;digo del Cliente :</td>
						<td><c:out value="${clienteOS.cliente.codCliente}"/></td>
					</tr>
				</table>
			</td>				
		</tr>
		<tr>
			<td colspan="4" align="center">&nbsp;</td>			
		</tr>
	</table>

