<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<body onload="cargarClienteBuscado();validarMensaje();">
 
  <tr>
      <td colspan="6"><table width="100%" border="0">
        <tr>
          <td width="2%">&nbsp;</td>
          <td width="16%"><img src="img/black_arrow.gif" width="7" height="7" /><span class="valorCampoSeleccionable">Nuevo c&oacute;digo cliente</span></td>
          <td width="8%" valign="bottom"><strong>
            <input name="codigoCliente" type="text"  id="codigoCliente" value="" width="50" maxlength="10"  onfocus="limpiaText();" onkeypress="soloCaracteresValidos();"/>
            <!-- html:hidden property="codigoCliente" styleId="codigoCliente" / -->
          </strong></td>
          <td width="74%"><strong><img src="img/botones/btn_ingresar.gif" alt="Ingresa N&deg; en lista" name="ingresar" width="85" height="19" border="0" id="ingresar" onclick="enviarFormulario('<bean:write name="numeroMax" />');" onmouseover="sobreElBoton('ingresar','img/botones/btn_ingresar_roll.gif')" onmouseout="sobreElBoton('ingresar','img/botones/btn_ingresar.gif')" />
          <img src="img/botones/btn_buscar.gif" name="botonBuscar" width="85" height="19" border="0" id="botonBuscar" onclick="buscarFormulario('<bean:write name="numeroMax" />');"	 onmouseover="sobreElBoton('buscar','img/botones/btn_buscar_roll.gif')" onmouseout="sobreElBoton('buscar','img/botones/btn_buscar.gif')"  /></strong></td>
          <input type="hidden"  name="buscar" id="buscar" value="0" />
        </tr>
        <tr>
          <td>&nbsp;</td>
          <td><div align="center"></div></td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    
    <tr>
      <td colspan="6"><table width="100%" border="0">
        <tr>
          <td width="3%">&nbsp;</td>
          <td width="79%"><table width="100%" border="0"  cellpadding="0" cellspacing="2">
            <tr class="textoColumnaTabla">
              <td width="14%" ><input  alt="Seleccionar Todos" name="checkbox523" type="checkbox" value="checkbox" onclick="MarcarCS(this.form,this)" /></td>
              <td width="34%" >C&oacute;digo </td>
              <td width="52%">Nombre</td>
            </tr>
            <logic:present name="listaCliente" scope="session"> 
            <logic:iterate id="listClient" name="listaCliente"  type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO" scope="session">
          <tr>
	        <td class="textoFilasTabla"> 
	        	<input type="checkbox" name="itemChequeados" id="itemChequeados"  value='<bean:write name="listClient" property="codCliente"/>' />
	        </td>
	   		<td class="textoFilasTabla"><bean:write name="listClient" property="codCliente"/></td> 
	   		<td class="textoFilasTabla"><bean:write name="listClient" property="nombres"/>
	   		<bean:write name="listClient" property="apellido1"/>
	   		<bean:write name="listClient" property="apellido2"/>
	   	 </td>
	   		   
	      </tr>
            </logic:iterate>
           </logic:present> 
          </table></td>
          <td width="18%">&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>
</body>
