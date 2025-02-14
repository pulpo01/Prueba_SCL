<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<c:set var="usuarioAbonado" value="${sessionScope.usuarioAbonado}"></c:set>

	<div id="mensajes" style="display:none">
	<table width="100%" border="0" >
	  <tr>
	     <td class="mensajeError"><div id="textoerror" style="display:none;"></div></td>
	  </tr> 
	</table>
	</div>
	
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

     <tr>
		<td colspan="4">
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td colspan=6> <b>Equipo Actual</td>
			</tr>
			<tr>
				<td width="70"> <b>Equipo</td>
				<td> <c:out value="${usuarioAbonado.des_equipo}" /></td>
				<td width="70"> <b>Serie</td>
				<td> <c:out value="${usuarioAbonado.num_serie}" /></td>
				<td width="70"> <b>Num.IMEI</td>
				<td> <c:out value="${usuarioAbonado.num_imei}" /></td>
			</tr>
		
			<tr>
				<td width="70"> <b>Tipo</td>
				<td> <c:out value="${usuarioAbonado.des_terminal}" /></td>
				<td width="120"> <b>Modalidad de venta</td>
				<td> <c:out value="${usuarioAbonado.des_modventa}" /></td>
				<td width="70"> <b>Propiedad</td>
				<td> <c:out value="${usuarioAbonado.ind_propiedad}" /></td>
			</tr>
		
			<tr>
				<td width="70"> <b>Contrato</td>
				<td> <c:out value="${usuarioAbonado.des_tipcontrato}" /></td>
				<td width="70"> <b>Procedencia</td>
				<td> <c:out value="${usuarioAbonado.des_procequi}" /></td>
				<td width="70"> <b>Uso</td>
				<td> <c:out value="${usuarioAbonado.des_uso}" /></td>
			</tr>
			</table>		
		
		</td>
     </tr>
	</table>


	