<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<input type="hidden"  name="buscar" id="buscar" value="0" />
<html:hidden property="estadoValidacion"/>
<html:hidden property="numeroAgregar"/>
 
  <tr>
      <td colspan="6"><table width="100%" border="0">
        <tr>
          <td width="2%">&nbsp;</td>
          <td width="16%"><img src="img/black_arrow.gif" width="7" height="7" /><span class="valorCampoSeleccionable">Nuevo c&oacute;digo cliente</span></td>
          <td width="8%" valign="bottom"><strong>
          
            <input name="codigoCliente" type="text"  id="codigoCliente" value="" width="50" maxlength="10" onkeypress="esnumero(this);limpiaMensajeError();"/>
            
          </strong></td>
          <td width="74%"><strong><img src="img/botones/btn_ingresar.gif" alt="Ingresa N&deg; en lista" name="ingresar" width="85" height="19" border="0" id="ingresar" onclick="enviarFormulario();" onmouseover="sobreElBoton('ingresar','img/botones/btn_ingresar_roll.gif')" onmouseout="sobreElBoton('ingresar','img/botones/btn_ingresar.gif')" />
          <img src="img/botones/btn_buscar.gif" name="botonBuscar" width="85" height="19" border="0" id="botonBuscar" onclick="buscarFormulario();"	 onmouseover="sobreElBoton('botonBuscar','img/botones/btn_buscar_roll.gif')" onmouseout="sobreElBoton('botonBuscar','img/botones/btn_buscar.gif')"  /></strong></td>
          
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
      <td colspan="5"><table width="100%" border="0">
        
          
            <tr class="textoColumnaTabla">
              <!-- <td width="14%" ><input  alt="Seleccionar Todos" name="checkbox523" type="checkbox" value="checkbox" onclick="MarcarCS(this.form,this)" /></td>  -->
              <td width="10%">Seleccionar  </td>
              <td width="34%">C&oacute;digo Cliente</td>
              <td width="56%">Nombre Cliente</td>
            </tr>
            
          <logic:present name="listaClientes" scope="session"> 
             <logic:iterate id="cliente" name="listaClientes"  type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO" scope="session">
		          <tr>
			        <td class="textoFilasTabla"> <input type="checkbox" name="itemChequeados" id="itemChequeados" onclick="limpiaMensajeError();" value='<bean:write name="cliente" property="codCliente"/>' /></td>
			   		<td class="textoFilasTabla"><bean:write name="cliente" property="codCliente"/></td> 
			   		<td class="textoFilasTabla"><bean:write name="cliente" property="nombres"/> </td>
			   		   
			      </tr>
             </logic:iterate>
          </logic:present> 
          
          </td>
          <td width="18%">&nbsp;</td>
        </tr>
      </table></td>
    </tr>
    
    <tr>
      <td colspan="6">&nbsp;</td>
    </tr>
