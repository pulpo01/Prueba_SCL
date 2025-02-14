<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>

<table width="100%" border="0">
  <!-- Solo producto chequeados -->	
  <tr>
    <td width="57%" >
    </td>
    <td width="43%"><div align="right"><div align="right">
    <img 
    	src="img/botones/btn_grabar.gif" 
    	alt="guardar cambios" 
		name="ACEPTAR"
    	border="0" 
    	id="Anterior1" 
    	onmouseover="sobreElBoton('Anterior1','img/botones/btn_grabar_roll.gif')" 
    	onmouseout="sobreElBoton('Anterior1','img/botones/btn_grabar.gif')"
    	onclick="setValorSeleccionados();guardarProductosPorAbonado(ProductoForm,1,'<%=request.getContextPath()%>/navegaCliente.do')"
    />
 	<!-- img 
 		src="img/botones/btn_volver.gif" 
 		alt="Volver" 
 		name="CANCELAR" 
 		border="0" 
 		id="Salir1" 
 		onmouseover="sobreElBoton('Salir1','img/botones/btn_volver_roll.gif')" 
 		onmouseout="sobreElBoton('Salir1','img/botones/btn_volver.gif')"
 		onclick="guardarProductosPorAbonado(ProductoForm,0,'<%=request.getContextPath()%>/navegaCliente.do')"	
 	/!-->
 	</div>
 	</td>
  </tr>
</table>


