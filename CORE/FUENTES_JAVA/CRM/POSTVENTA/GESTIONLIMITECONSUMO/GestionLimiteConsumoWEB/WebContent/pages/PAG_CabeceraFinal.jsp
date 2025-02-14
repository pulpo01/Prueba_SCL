
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
 
<table width="100%">
  
   <tr>
    <td colspan="3">
	 <table width="100%" border="0">
     <tr>
       <td width="25%">&nbsp;</td>
       <td width="25%" align="center">&nbsp;</td>
       <td width="50%" align="right">
          <!--
          FPP col 08/04/2009 85422
          a href="#"><img style="cursor: pointer;" src="botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior" 
	      onmouseover="sobreElBoton('Anterior','botones/btn_anterior_roll.gif')"  onmouseout="sobreElBoton('Anterior','botones/btn_anterior.gif')" onclick="formularioAnterior();"/></a-->
          <a href="#"><img style="cursor: pointer;" src="../botones/btn_finalizar.gif" name="Finalizar" width="85" height="19"  border="0" id="Finalizar"  alt="Finalizar" 
	      onmouseover="sobreElBoton('Finalizar','../botones/btn_finalizar_roll.gif')" onmouseout="sobreElBoton('Finalizar','../botones/btn_finalizar.gif')" onclick="doSubmitBotones('FINALIZAR');"/></a>
		  <a href="#"><img style="cursor: pointer;" src="../botones/btn_salir.gif" name="Salir" width="85" height="19"  border="0" id="Salir" 
		  onmouseover="sobreElBoton('Salir','../botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir','../botones/btn_salir.gif')"onclick="salir();"/></a></td>
     </tr>
     </table>
    </td>
  </tr>
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
 
</table>