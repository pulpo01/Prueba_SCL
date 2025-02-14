<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html:hidden name="PresupuestoForm" property="numProceso"/>
<html:hidden name="PresupuestoForm" property="accion"/>
<html:hidden name="PresupuestoForm" property="flgIniciado"/>
<table width="100%" border="0">
  <tr>
    <td colspan="4" class="textoSubTitulo">Presupuesto</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Tipo de documento</td>
    <td width="70%"><input type="text" name="textfield3" value ='<c:out value="${glsTipoDocumento}"/>'readonly="readonly"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Conceptos</td>
    <td width="70%"><input type="text" name="textfield" value='<c:out value="${totalesPresupuesto[0]}" />' readonly="readonly"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Impuestos</td>
    <td width="70%"><input type="text" name="textfield2" value='<c:out value="${totalesPresupuesto[1]}"/>' readonly="readonly"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Descuentos</td>
    <td width="70%"><input type="text" name="textfield3" value='<c:out value="${totalesPresupuesto[2]}"/>' readonly="readonly"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Presupuesto</td>
    <td width="70%"><input type="text" name="textfield3" value='<c:out value="${totalesPresupuesto[3]}"/>' readonly="readonly"/></td>
    <td width="3%">&nbsp;</td>
  </tr>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="70%"><img src="botones/btn_imprimirpresupuesto.gif" alt="Imprimir Presupuestos"  id="btn_imprimirpresupuesto"  onclick="ejecutar('Imprimir');"
	onmouseover="sobreElBoton('btn_imprimirpresupuesto','botones/btn_imprimirpresupuesto_roll.gif')" onmouseout="sobreElBoton('btn_imprimirpresupuesto','botones/btn_imprimirpresupuesto.gif')"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>   
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> 
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> 
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr> 
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>  
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  </table>
