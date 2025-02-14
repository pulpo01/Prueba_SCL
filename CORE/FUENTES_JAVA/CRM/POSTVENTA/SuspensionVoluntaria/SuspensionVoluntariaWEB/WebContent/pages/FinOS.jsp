<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="suspensionVoluntariaForm" value="${sessionScope.suspensionVoluntariaForm}"></c:set> 

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
     <td colspan="5" align="center" class="textoSubTitulo">Finalizaci&oacute;n registro OOSS</td>
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
			<p class="style1">Se ha registrado la orden de servicio exitosamente </p>
			<p class="style1">
				<b>Los números de OOSS <c:out value="${sessionScope.textoNumOOSS}"/> son:<br>
				- Número de Suspensión: <c:out value="${suspensionAbonado.numOsSus}"/><br>
				- Número de Rehabilitación: <c:out value="${suspensionAbonado.numOsReh}"/></b> 
			 </p>				
     </td>
  </tr>     
  <tr>     
     <td colspan="5">
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
    <td colspan="5" align="center">
    <img style="cursor: pointer;" src="botones/btn_salir.gif" alt="Salir" border="0" id="Salir2" onmouseover="sobreElBoton('Salir2','botones/btn_salir_roll.gif')"  
    onmouseout="sobreElBoton('Salir2','botones/btn_salir.gif')" width="85" height="19" onclick="salir();" />
    </td>
  </tr> 
</table>
