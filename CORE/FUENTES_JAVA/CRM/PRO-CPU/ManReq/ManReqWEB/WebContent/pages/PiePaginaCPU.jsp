<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<table width="100%" border="0">
  <tr>
  	<td width="3%">
    <td width="52%">Condiciones Actuales:&nbsp;<span id="condicionesActuales"><bean:write name="CambiarPlanForm" property="detalleControles"/></span></td>
    <td width="45%" align="right">
    <img style="cursor: pointer;" src="botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior1" 
    onmouseover="sobreElBoton('Anterior1','botones/btn_anterior_roll.gif')" onmouseout="sobreElBoton('Anterior1','botones/btn_anterior.gif')" onclick="formularioAnterior();"/>
	<img style="cursor: pointer;" src="botones/btn_siguiente.gif" name="Siguiente1" width="85" height="19"  border="0" id="Siguiente1"  alt="Siguiente"
	onmouseover="sobreElBoton('Siguiente1','botones/btn_siguiente_roll.gif')" onmouseout="sobreElBoton('Siguiente1','botones/btn_siguiente.gif')" onclick="enviarFormulario();" />
	 <img src="botones/btn_salir.gif" alt="Salir" name="Salir" width="85" height="19"  border="0" id="Salir2" 
	onmouseover="sobreElBoton('Salir2','botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir2','botones/btn_salir.gif')"onclick="salir();" /></td>
  </tr>  
</table>
