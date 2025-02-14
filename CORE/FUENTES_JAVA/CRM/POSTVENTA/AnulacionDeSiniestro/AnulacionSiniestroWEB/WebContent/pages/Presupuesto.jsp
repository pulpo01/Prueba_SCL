<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html:hidden name="PresupuestoForm" property="numProceso"/>
<html:hidden name="PresupuestoForm" property="accion"/>
<html:hidden name="PresupuestoForm" property="flgIniciado"/>
<html:hidden name="PresupuestoForm" property="montoAbono"/>
<html:hidden name="PresupuestoForm" property="rbCiclo"/>

<table width="100%" border="0">
  <tr>
    <td colspan="4" class="textoSubTitulo">Presupuesto</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Tipo de documento</td>
    <td width="70%"><input tabindex="1" type="text"  id="tipoDocumento" name="tipoDocumento" value ='<c:out value="${glsTipoDocumento}"/>' disabled="disabled"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Conceptos</td>
    <td width="70%"><input style="text-align: right;" tabindex="2" type="text" id="totalConceptos"  name="totalConceptos" value='<c:out value="${totalesPresupuesto[0]}"/>' disabled="disabled"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Impuestos</td>
    <td width="70%"><input style="text-align: right;" tabindex="3" type="text" id="totalImpuestos"  name="totalImpuestos" value='<c:out value="${totalesPresupuesto[1]}"/>' disabled="disabled"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Descuentos</td>
    <td width="70%"><input style="text-align: right;" tabindex="4" type="text" id="totalDescuentos"  name="totalDescuentos" value='<c:out value="${totalesPresupuesto[2]}"/>' disabled="disabled"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Total Presupuesto</td>
    <td width="70%"><input style="text-align: right;" tabindex="5" type="text" id="totalPresupuesto" name="totalPresupuesto" value='<c:out value="${totalesPresupuesto[3]}"/>' disabled="disabled"/></td>
    <td width="3%">&nbsp;</td>
  </tr>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;Numero Venta</td>
    <td class="textoDerechaFilasTabla">&nbsp;<c:out value="${numeroVenta}"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="70%"></td>
    <td width="3%">&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;<a href="#"><img src="botones/btn_imprimirpresupuesto.gif" alt="Imprimir Presupuestos"  border="0" id="btn_imprimirpresupuesto"  onclick="ejecutar('Imprimir');"
	onmouseover="sobreElBoton('btn_imprimirpresupuesto','botones/btn_imprimirpresupuesto_roll.gif')" onmouseout="sobreElBoton('btn_imprimirpresupuesto','botones/btn_imprimirpresupuesto.gif')"/></a></td>
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
