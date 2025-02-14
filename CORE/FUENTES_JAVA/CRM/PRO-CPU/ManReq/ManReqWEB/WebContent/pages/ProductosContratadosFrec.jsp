<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="ProductoContratadoFrec" value="${sessionScope.ProductoContratadoFrecList}"></c:set>


<%!String colorFila = null;%>
<table width="100%">
  <tr>
    <td colspan="3" align="left">
		<table width="100%" border="0" cellpadding="0" cellspacing="2">
		<tr>
	    	<td colspan="3"><table width="100%" border="0" cellpadding="0" cellspacing="2">
	    </tr>
	      <tr>
	        <td colspan="7" align="left" >&nbsp;</td>
	      </tr>
	      <tr>
	        <td width="100%" colspan="7" align="left" ><h2 class="textoSubTitulo"> Productos Contratados con N&uacute;meros Frecuentes</h2></td>
	      </tr>
	      <tr>
	        <td colspan="7" align="left" class="amarillo"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
	          <tr>
	            <td width="11%" class="campoInformativo" >N&uacute;mero Celular</td>
	            <td width="2%" class="campoInformativo"  >:</td>
	            <td width="87%" class="valorCampoInformativo" >92152194</td>
	          </tr>
	        </table></td>
	      </tr>
	      <tr>
	        <td colspan="7">&nbsp;</td>
	      </tr>
  			<tr>
				<td colspan="7">
				<table width="80%">
		          <tr class="textoColumnaTabla">
		            <td rowspan="2"><div align="center">#</div></td>
		            <td rowspan="2"><div align="center">C&oacute;digo</div></td>
		            <td colspan="2" rowspan="2"><div align="center">Descripci&oacute;n</div></td>
		            <td rowspan="2"><div align="center">Tipo</div></td>
		            <td rowspan="2"><div align="center">Modo Contrataci&oacute;n </div></td>
		            <td colspan="2"><div align="center">N&uacute;meros Frecuentes</div></td>
		            </tr>
		          <tr class="textoColumnaTabla">
		            <td><div align="center">Permitidos </div></td>
		            <td><div align="center">Ingresados</div></td>
		          </tr>
				<logic:present name="ProductoContratadoFrecList" scope="session">
	   			<bean:define id="productosContratadosFrec" name="ProductoContratadoFrecList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO[]"/>
	   			<logic:iterate indexId="count" id="productoContratadoFrec" name="productosContratadosFrec"  type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO">

				<%colorFila = null;
				if ((count.intValue() % 2) == 0) {
     					colorFila = "textoFilasTabla";
				} else {
					colorFila = "textoFilasColorTabla";
					System.out.println("colorFila "+colorFila);
				}%>		                    
				<tr class="<%=colorFila%>">
	   				<td><bean:write name="productoContratadoFrec" property="correlativo"/></td>
	   				<td><bean:write name="productoContratadoFrec" property="codigo"/></td> 
	   				<td><bean:write name="productoContratadoFrec" property="descripcion"/></td>
  					<td ><a href="NumerosFrecuentesAction.do?correlativo=<bean:write name="productoContratadoFrec" property="correlativo"/>">
  					        <img src="botones/btn_personalizar.gif" name="Image105"  border="0" id="Image105" alt="Personalizar" 
  					          onmouseover="sobreElBoton('Image105','botones/btn_personalizar.gif')" onmouseout="sobreElBoton('Image105','botones/btn_personalizar.gif')"/></a></td>
	   				<td><bean:write name="productoContratadoFrec" property="tipo"/></td> 
	   				<td><bean:write name="productoContratadoFrec" property="modoContratacion"/></td> 
	   				<td><bean:write name="productoContratadoFrec" property="numFrecuentesPermitidos"/></td> 
	   				<td><bean:write name="productoContratadoFrec" property="numFrecuentesIngresados"/></td>
	   			</tr>
	            </logic:iterate>
 	            </logic:present>
		        </table>
	  </table>
 </td>
 </tr>
 
 <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>
 </tr>
</table>

