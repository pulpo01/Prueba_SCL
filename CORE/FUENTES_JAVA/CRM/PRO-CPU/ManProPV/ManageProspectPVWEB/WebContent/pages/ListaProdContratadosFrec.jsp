<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:hidden property="idProductoContratado"/>
<html:hidden property="codigoProducto"/>
<html:hidden property="nombreProducto"/>

<table width="100%" border="0">
  <tr >
    <td class="textoSubTitulo" colspan="8">Contratados </td>
  </tr>
  <tr>
    <td valign="top" colspan="8">
    
    <table width="100%" border="0" cellpadding="0" cellspacing="2">
    
      <tr class="textoColumnaTabla">
        
        <td width="11%">C&oacute;digo Producto</td>
        <td colspan="2">Descripci&oacute;n Producto</td>
        <td width="11%"> Tipo</td>
        <td width="18%" >Modo Contrataci&oacute;n </td>
        <td width="11%">Permitidos</td> 
        <td width="11%">Ingresados</td>     
      </tr>
      <%int idProducto = 0;%>
      <logic:present name="productosContratadosFrec" scope="session">
      	  <bean:define id="productos" name="productosContratadosFrec" type="java.util.ArrayList"/>
      	  <logic:iterate id="producto" name="productos" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO">  
	      	  <%if (idProducto%2==0){ %> 	
		      <tr class="textoidProductoTabla">
		      <%}else{ %>
		      <tr class="textoidProductoColorTabla">
		      <%}%>
		            
      	  	  <td align="center">
        		<bean:write name="producto" property="codProducto"/>
        	  </td>
        	  <td align="center">
        	  	
        	  
        		<bean:write name="producto" property="nombre"/>
        		<td>
        			<img style="cursor: pointer" onclick="guardarParametros('<bean:write name="producto" property="idProdContratado"/>','<bean:write name="producto" property="codProducto"/>','<bean:write name="producto" property="nombre"/>')" src="img/botones/btn_puntos.gif" width="19" height="19" />
	        					
				</td>
				
				
        	
        	  </td>
        	  <td align="center">
        	    <script>
					descripcionTipo('<bean:write name="producto" property="comportamiento"/>');
				</script> 
        	  </td>
        	  <td align="center">
        	    <script>
					descripcionIndCond('<bean:write name="producto" property="indCondicionContratacion"/>');
				</script>  
        	  </td>
        	  <td align="center">
        		<bean:write name="producto" property="maximo"/>
        	  </td> 
        	  <td align="center">
        		<bean:write name="producto" property="permitidos"/>
        	  </td> 
        	  
	      
	      </logic:iterate>
      
      </logic:present>
     
      
      
    </table>
	
    </td>
  </tr>
</table>

