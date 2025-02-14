<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html:hidden name="CargaPdfForm" property="accion"/>
<html:hidden name="CargaPdfForm" property="flgIniciado"/>
<html:hidden name="CargaPdfForm" property="intervaloMilisegundos"/>
<html:hidden name="CargaPdfForm" property="maxIntentos"/>
<html:hidden name="CargaPdfForm" property="numIntento"/>
<table width="100%" border="0" >
  <tr>
     <td class="mensajeError"><div id="mensajes"></div></td>
  </tr> 
</table>
<table width="100%" border="0">
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
    <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
     <td colspan="5" align="center" class="textoSubTitulo">Visualizando Factura</td>
  </tr>
  <tr>
    <td width="18%">&nbsp;</td>
    <td width="12%">&nbsp;</td>
    <td width="17%">&nbsp;</td>
    <td width="18%">&nbsp;</td>
    <td width="35%">&nbsp;</td>
  </tr>     
  <tr>
     <td colspan="5">
	     <c:if test="${CargaPdfForm.accion == 'TerminarConsulta'}">
		     <p class="style1"><font color="crimson" size="2">Demora en Impresi&oacute;n, Busque documento <c:out value="${glsTipoDocumento}"/> en modulo de facturaci&oacute;n</font></p>
	     </c:if>
	     <c:if test="${CargaPdfForm.accion == 'Consultar'}">
 			 <p class="style1">Obteniendo factura ...     </p>
	     </c:if>     
     </td>
  </tr>     
  <tr>     
     <td colspan="5">
	     <c:if test="${CargaPdfForm.accion == 'Consultar'}">
 			 <p class="style1">Si usted quiere obtener la factura, presione el bot&oacute;n Salir     </p>
	     </c:if>     
     </td>     
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="5">&nbsp;</td>
  </tr> 
   <tr>
    <td colspan="5" align="center">
    <a href="#"><img style="cursor: pointer;" src="botones/btn_salir.gif" alt="Salir" border="0" id="Salir2" onmouseover="sobreElBoton('Salir2','botones/btn_salir_roll.gif')"  
    onmouseout="sobreElBoton('Salir2','botones/btn_salir.gif')" width="85" height="19" onclick="salir();" /></a>
    </td>
  </tr> 
</table>
