<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<body>
 <tr>
    <td><span class="textoSubTitulo"> Resultado b&uacute;squeda</span></td>
  </tr>
  <tr>
    <td><table width="100%" border="0">
      <tr class="textoColumnaTabla">
        <td width="9%">Seleccionar</td>
        <td width="14%">C&oacute;digo Cliente</td>
        <td width="49%">Nombre Cliente </td>
      </tr>
      <tr class="textoFilasTabla">
      <logic:present name="listaClientesDTO" scope="session"> 
            <logic:iterate id="listDTO" name="listaClientesDTO"  type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO" scope="session">
          <tr>
	        <td class="textoFilasTabla"><div align="center"> <input type="radio" name="itemRadioChequeados" onblur="limpiaMensajeError();" id="itemRadioChequeados" value='<bean:write name="listDTO" property="codCliente"/>' /></div></td>
	   		<td class="textoFilasTabla"><bean:write name="listDTO" property="codCliente"/></td>
	   		<td class="textoFilasTabla"><bean:write name="listDTO" property="nombres"/>
	   		<bean:write name="listDTO" property="apellido1"/>
	   		<bean:write name="listDTO" property="apellido2"/>
	   	 </td>
	     </tr>
            </logic:iterate>
         </logic:present>
      </tr>
    </table></td>
  </tr>
  <tr>
    <input name="volverAlistado" type="hidden" id="volverAlistado"  value="" />
    <td><div align="right">
      <img src="img/botones/btn_aceptar.gif" name="Aceptar" onclick="volverAfines();" width="85" height="19"  border="0" id="Aceptar"   align="siguiente="siguiente""
	onmouseover="sobreElBoton('Aceptar','img/botones/btn_aceptar_roll.gif')" onmouseout="sobreElBoton('Aceptar','img/botones/btn_aceptar.gif')"/>
	 <img src="img/botones/btn_volver.gif" name="Volver"  id="Volver"  onclick="volverAClientes();" width="85" height="19"  border="0"  align="siguiente="siguiente""
	onmouseover="sobreElBoton('Volver','img/botones/btn_volver_roll.gif')" onmouseout="sobreElBoton('Volver','img/botones/btn_volver.gif')"/>
    </div></td>
  </tr>
</table>

</body>
