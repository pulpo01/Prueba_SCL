<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
</table>
<table width="100%" border="0">
      <tr>
       <td colspan="3" align="left" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
     </tr>
     
     <tr>
		<td width="5%">&nbsp;</td>
		<td width="50%" align="left">
		  <table border="0" cellpadding="0" cellspacing="0"  width="100%">	
		  <tr>
			<td width=35% class="valorCampoInformativo"><b>Nombre del Cliente :</td>
			<td width=1%  class="valorCampoInformativo"></td>
			<td width=64% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.nombres}"/></td>
		  </tr>
		</table>
	    </td>
	   <td width="45%"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
        <tr>
          <td width=29% class="valorCampoInformativo"><b>Código del
          	Cliente :</td>
          <td width=3%  class="valorCampoInformativo"></td>
          <td width=68% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.codCliente}"/></td>
       </tr>
    </table></td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="50%">&nbsp;</td>
	<td width="45%">&nbsp;</td>
  </tr>
</table>
