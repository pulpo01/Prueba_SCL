<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<c:set var="usuarioAbonado" value="${sessionScope.usuarioAbonado}"></c:set>

	<div id="mensajes">
		<table width="100%" border="0" >
			<tr>
				<td class="mensajeError"><div id="textoerror"><c:out value="${mensajeOOSSAviso}"/></div></td>
			</tr> 
		</table>
	</div>
	
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
			<td colspan="4">
				<table width="100%" cellpadding="2" cellspacing="2" align=center border="0">
					<tr>
						<td colspan=6 class="textoSubTitulo"> <b>Equipo Actual</b></td>
					</tr>
					<tr>
						<td width="70"> <b>Equipo</b></td>
						<td width="400"> <c:out value="${usuarioAbonado.des_equipo}" /></td>
						<td width="70"> <b>Serie</b></td>
						<td width="200"> <c:out value="${usuarioAbonado.num_serie}" /></td>
						<td width="70"> <b>Propiedad</b></td>
						<td> <c:out value="${usuarioAbonado.ind_propiedad}" />
					</tr>
					<tr>
						<td width="70"> <b>Tipo</b></td>
						<td> <c:out value="${usuarioAbonado.des_terminal}" /></td>
						<td width="120"> <b>Num.IMEI</b></td>
						<td> <c:out value="${usuarioAbonado.num_imei}" /></td>
						<td width="120"> <b>Uso</b></td>
						<td> <c:out value="${usuarioAbonado.des_uso}" /></td>			
					</tr>
					<tr>
						<td width="70"> <b>Contrato</b></td>
						<td> <c:out value="${usuarioAbonado.des_tipcontrato}" /></td>
						<td width="70"> <b>Procedencia</b></td>
						<td> <c:out value="${usuarioAbonado.des_procequi}" /></td>
						<td width="70">&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
				</table>		
			</td>
		</tr>
	</table>


	