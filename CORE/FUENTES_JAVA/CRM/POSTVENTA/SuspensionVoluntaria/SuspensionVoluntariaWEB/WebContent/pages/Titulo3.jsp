<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean" %>
<c:set var="titulo" value="${sessionScope.nombreOOSS}"></c:set>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<table width="100%">
 <tr>
  <td class="barraarriba">Usuario: <c:out value="${clienteOS.usuario}"/> &nbsp;Operadora: <bean:write name="operadora"/>
  </td>
 </tr>
 
 <tr>
    <td width="4%" colspan="3">
      <table width="100%" border="0">
		  <tr>
		   <td align="left" class="textoTitulo"><img src="../suspensionVol/img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>
		   <c:out value="${titulo}"/></td>
		  </tr>
		  <tr>
		    <td class="textcaminohormigas">Ingreso de información</td>
		  </tr>
	  </table>
    </td>
  </tr>  
  
   <tr>
    <td colspan="3">
	 <table width="100%" border="0">
     <tr>
       <td width="25%">&nbsp;</td>
       <td width="25%" align="center">&nbsp;</td>
       <td width="50%" align="right">
          <img style="cursor: pointer;" src="../suspensionVol/botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior" 
	      onmouseover="sobreElBoton('Anterior','../suspensionVol/botones/btn_anterior_roll.gif')"  onmouseout="sobreElBoton('Anterior','../suspensionVol/botones/btn_anterior.gif')" onclick="formularioAnterior();"/>
          <img style="cursor: pointer;" src="../suspensionVol/botones/btn_finalizar.gif" name="Finalizar" width="85" height="19"  border="0" id="Finalizar"  alt="Finalizar" 
	      onmouseover="sobreElBoton('Finalizar','../suspensionVol/botones/btn_finalizar_roll.gif')" onmouseout="sobreElBoton('Finalizar','../suspensionVol/botones/btn_finalizar.gif')" onclick="registrarOS();"/>
		  <img style="cursor: pointer;" src="../suspensionVol/botones/btn_salir.gif" name="Salir" width="85" height="19"  border="0" id="Salir" 
		  onmouseover="sobreElBoton('Salir','../suspensionVol/botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir','../suspensionVol/botones/btn_salir.gif')"onclick="salir();"/></td>
     </tr>
     </table>
    </td>
  </tr>
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
 
</table>