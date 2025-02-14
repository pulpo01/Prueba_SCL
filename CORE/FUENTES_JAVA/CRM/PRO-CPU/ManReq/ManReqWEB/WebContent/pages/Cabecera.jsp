<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
</table>

<table border="0" width="100%">
<tr>
<td colspan="3">


<table width="100%" border="0">
     <tr>
       	<td colspan="3" align="left" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
     </tr>
     
     <tr>
		<td width="3%">&nbsp;</td>
		<td width="46%" align="left">
		    <table border="0" cellpadding="0" cellspacing="0"  width="100%">	
			  <tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			  </tr>
			  <tr>
				<td width=24% class="campoInformativo">Nombre del Cliente</td>
				<td width=2%  class="valorCampoInformativo">:</td>
				<td width=74% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.nombres}"/></td>
			  </tr>
		    </table>
	    </td>

	    <td width="51%">
	   		<table border="0" cellpadding="0" cellspacing="0"  width="100%">
			    <tr>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
				  <td>&nbsp;</td>
			    </tr>
	         	<tr>
		          <td width=22% class="campoInformativo">Código del Cliente</td>
		          <td width=2%  class="valorCampoInformativo">:</td>
		          <td width=76% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.codCliente}"/></td>
	         	</tr>
	    	</table>
	   </td>
     </tr>
  
	 <tr>
	    <td width="3%">&nbsp;</td>
	    <td width="46%">&nbsp;</td>
		<td width="51%">&nbsp;</td>
	 </tr>
</table>

</td>
</tr>
</table>


<table width="100%" border="0" >
	<tr>
	   <td class="mensajeError"><div id="mensajes"></div></td>
	</tr> 
</table>
