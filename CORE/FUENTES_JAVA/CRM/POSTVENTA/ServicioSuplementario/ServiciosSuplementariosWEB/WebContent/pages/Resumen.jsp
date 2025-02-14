<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>


<table width="100%" border="0">
  <tr width="100%">
    <td width="50%">&nbsp;&nbsp;Orden de Servicio N°: <c:out value="${clienteOS.numOrdenServicio}"/></td>
	<td width="25%"></td>
	<td width="25%" >&nbsp;</td>	
  </tr>   
</table>   
<table width="100%" border="0">
  <tr width="100%">
    <td width="50%">&nbsp;&nbsp;<c:out value="${clienteOS.resumenOS}"/></td>
	<td width="25%">&nbsp;</td>
	<td width="25%">&nbsp;</td>	
  </tr>  
</table>     
<table width="100%" border="0">
  <tr width="100%" >
    <td width="25%" valign="top">&nbsp;&nbsp;Cargos a Aplicar: </td>
	<td width="45%" >
		<table width="100%" border="0">
			<logic:present name="listCarogos" >
			   	<logic:iterate indexId="j" id="CargoI" name="listCarogos" type="com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO" scope="session">    		
			    	<tr width="100%">
			  	    	<td width="30%"><%=String.valueOf(CargoI.getDescripcion())%>: </td>			  	        
			  	    	<td width="10%" class="textoDerechaResumenFilasTabla">&nbsp;<%=String.valueOf(CargoI.getSaldo())%></td>
			    	</tr> 	      					  		
    			</logic:iterate>
    		</logic:present>
   		    <tr width="100%" >
			  	<td width="30%">&nbsp;Total: </td>			  	        
			    <td width="10%" class="textoDerechaResumenFilasTabla">&nbsp;<c:out value="${CargosForm.total}"/></td>			  	    			  	    
			</tr> 	      
        </table>		
	</td>
	<td width="30%" >&nbsp;</td>	
  </tr> 
</table>
<table width="100%" border="0">
  <tr>
    <td colspan="3" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" />      Comentario</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>   
  <tr>
    <td colspan="3" ><textarea   tabindex="1" name="comentario" cols="80" rows="15" ><c:out value="${clienteOS.comentarioOS}"/></textarea> </td> 
  </tr>     
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>  
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr> 
</table>
<table width="100%" border="0">
  <tr>
    <td colspan="3" align="left"  class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" />   Carta de Atenci&oacute;n</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="23%"><div align="center"><a href="#"><img src="botones/btn_imprimircarta.gif" alt="Imprimir Carta" name="imprimircarta" width="143" height="19" border=0 id="imprimircarta" 
	onmouseover="sobreElBoton('imprimircarta','botones/btn_imprimircarta_roll.gif')" onmouseout="sobreElBoton('imprimircarta','botones/btn_imprimircarta.gif')" onclick="visualizarFactura()"/></a></div></td>
	<td width="37%">&nbsp;</td>
	<td width="40%">&nbsp;</td>	
  </tr>  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>            
</table>