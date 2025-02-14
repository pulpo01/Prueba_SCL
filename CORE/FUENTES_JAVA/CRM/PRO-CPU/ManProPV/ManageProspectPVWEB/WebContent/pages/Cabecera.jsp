<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
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
		<td width="46%" align="left">
		    <table border="0" cellpadding="0" cellspacing="0"  width="100%">	
			  <tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			  </tr>
			  <tr>
				<td width=24% class="campoInformativo">Color</td>
				<td width=2%  class="valorCampoInformativo">:</td>
				<td width=74% class="valorCampoInformativo"><c:out value="${clienteOS.clColor}"/></td>
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
		          <td width=22% class="campoInformativo">Subsegmento</td>
		          <td width=2%  class="valorCampoInformativo">:</td>
		          <td width=76% class="valorCampoInformativo"><c:out value="${clienteOS.clSegmento}"/></td>
	         	</tr>
	    	</table>
	   </td>
     </tr>     
<!-- (+) EV 08/01/09 -->

<table width="100%" border="0">
     <tr>
		<td width="3%">&nbsp;</td>
		<td width="46%" align="left">
		    <table border="0" cellpadding="0" cellspacing="0"  width="100%">	
			<c:if test="${clienteOS.numAbonado >0}">
			<logic:present name="ClienteOOSS" scope="session">
			   <bean:define id="cliente" name="ClienteOOSS" scope="session"/>
			   <bean:define id="abonados" name="cliente" type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO[]" property="abonados"/>
				<logic:iterate id="abonado" name="abonados"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
				  <tr>
					<td width=24% class="campoInformativo">N&uacute;mero Abonado</td>
					<td width=2%  class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><bean:write name="abonado" property="numAbonado"/></td>
				  </tr>
				  <tr>
					<td width=24% class="campoInformativo">N&uacute;mero Celular</td>
					<td width=2%  class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><bean:write name="abonado" property="numCelular"/></td>
				  </tr>				  
				  <tr>
					<td width=24% class="campoInformativo">C&oacute;digo Usuario</td>
					<td width=2%  class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><bean:write name="abonado" property="codUsuario"/></td>
				  </tr>
				  <tr>
					<td width=24% class="campoInformativo">Plan Tarifario</td>
					<td width=2% class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><bean:write name="abonado" property="codPlanTarif"/></td>
				  </tr>
				  <tr>
					<td width=24% class="campoInformativo">Tipo Plan</td>
					<td width=2% class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><bean:write name="abonado" property="desTipoPlanTarif"/></td>
					<p></p>
				  </tr>			  
				</logic:iterate>
			</logic:present>	
			</c:if>			  
		    </table>
	    </td>

	    <td width="51%">&nbsp;
	   </td>
     </tr>
 </table>
<!-- (-) EV 08/01/09 -->  
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
