<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:hidden property="idProductoContratado"/>
<html:hidden property="codigoProducto"/>
<html:hidden property="nombreProducto"/>

<table width="100%" border="0">
  <tr>
    <td class="textoSubTitulo" colspan="8">Solicitudes de OOSS de Cambio de Plan Pendiente</td>
  </tr>
  <tr>
    <td class="textoSubTitulo" colspan="8"><br></td>
  </tr>
  <tr>
    <td class="textoSubTitulo" colspan="8"><img src="img/black_arrow.gif" width="7" height="7"/> Anular solicitudes</td>
  </tr>
  <tr>
    <td width="7%" class="textoColumnaTabla">Seleccionar <html:checkbox onclick ="checkearDescheckear(this);" name="ListaAnulaSolicitudForm" property="checkTodos"  /></td>
    <td width="6%" class="textoColumnaTabla">N&uacute;mero Abonado</td>
    <td width="9%" class="textoColumnaTabla">Celular</td>
    <td width="3%" class="textoColumnaTabla">OOSS</td>
    <td width="6%" class="textoColumnaTabla">PLAN ORIGEN</td>
    <td width="7%" class="textoColumnaTabla">PLAN NUEVO</td>
	<td width="11%" class="textoColumnaTabla">FECHA PROCESO</td>
	<td width="9%" class="textoColumnaTabla">Origen Solicitud</td>
  </tr>

  	<logic:present name="camPlanPendienteDTOarr" scope="session">
	   <bean:define id="solCamPlanPendArr" name="camPlanPendienteDTOarr" type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteDTO[]"/>
	   <logic:iterate id="solCamPlan" name="solCamPlanPendArr"  type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteDTO">
       <tr>
	        <td class="textoFilasTabla"> <html:multibox onclick="validaCheck(this)" name="ListaAnulaSolicitudForm" property="listaAbonados">
	                                        <bean:write name="solCamPlan" property="numAbonado" />
                                         </html:multibox> </td>
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="numAbonado"/></td> 
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="numCelular"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="numOS"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="planOrigen"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="planNuevo"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="fechaProceso"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="solCamPlan" property="origenSolicitud"/></td>    
	   </tr>
	   </logic:iterate>
 	</logic:present>
  </table>
 </td>
 </tr>  
</table>

