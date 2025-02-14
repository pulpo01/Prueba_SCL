<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!-- TRAZADOR 2 -->
<html:hidden property="cadenaProductosSeleccionados" styleId="cadenaProductosSeleccionados" value=""/>
  <tr>
   <td colspan="3"><table width="100%">
    <tr>
      <td colspan="4" align="left" class="textoSubTitulo">Seleccione Tipo de Comportamiento</td>
    </tr>
  <tr>
    <td colspan="3" align="left">
  <table id="tablaAbonados" width="50%" border="0" cellpadding="0" cellspacing="2">
  <tr>
	<td width="20%" class="textoColumnaTabla">Todos<html:checkbox onclick ="checkearDescheckear(this);" name="SelectTipoComportamientoForm" property="checkTodos"  /></td>    
        <td width="80%" class="textoColumnaTabla">Tipo Comportamiento</td>
  </tr>
  	<logic:present name="tiposCompList" scope="session">
	   <bean:define id="tiposComp" name="tiposCompList" scope="session"/>
	     <logic:notEmpty name="tiposComp" property="tipoComportamientoList">
	       <bean:define id="tipoComportamientoList" name="tiposComp" type="com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoDTO[]" property="tipoComportamientoList"/>
		   <logic:iterate id="tipoComportamiento" name="tipoComportamientoList"  type="com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoDTO">
	         <tr>
		        <td class="textoFilasTabla"> 
                   <div align="center">
			          <html:multibox onclick="validaCheck(this)" name="SelectTipoComportamientoForm" property="listaTiposCom">
			        	<bean:write name="tipoComportamiento" property="tipoComportamiento"/>
			          </html:multibox> 		          
                   </div>             
		        </td>
				<td class="textoFilasTabla">
					  <bean:write name="tipoComportamiento" property="tipoComportamiento"/> - <bean:write name="tipoComportamiento" property="descComportamiento"/> 
				</td> 
		     </tr>
	       </logic:iterate>
	      	<tr>
	      		<td colspan="2">
				  <label for="total" id="lbMensajePA" class="textoSubTitulo"></label>
		     	</td>
		   </tr>
	     </logic:notEmpty>
 	</logic:present>
  </table>
 </td>
 </tr>
</table>



