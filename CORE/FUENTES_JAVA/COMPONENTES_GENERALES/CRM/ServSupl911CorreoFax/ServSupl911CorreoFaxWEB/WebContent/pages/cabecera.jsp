<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<c:set var="DatosSessionDTO" value="${sessionScope.DatosSessionDTO}"></c:set> 

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
			<td><c:out value="${DatosSessionDTO.nomCliente}"/></td>
			<td width="300"></td>
			<td width="120"><b>C&oacute;digo del Cliente :</td>
			<td><c:out value="${DatosSessionDTO.codCliente}"/></td>
		</table>				
     </tr>     
	</table>