<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<table width="100%">
 <tr>
  <td class="barraarriba">Usuario: <c:out value="${clienteOS.usuario}"/>  &nbsp;Operadora: <c:out value="${sessionScope.operadora}"/> 
  </td>
 </tr>
 
 <tr>
    <td width="4%" colspan="3">
      <table width="100%" border="0">
		  <tr>
		   <td align="left" class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>Cambio Plan Unificado</td>
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
          <img style="cursor: pointer;" src="botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior2" 
	      onmouseover="sobreElBoton('Anterior2','botones/btn_anterior_roll.gif')"  onmouseout="sobreElBoton('Anterior2','botones/btn_anterior.gif')" onclick="formularioAnterior();"/>
          <img style="cursor: pointer;" src="botones/btn_siguiente.gif" alt="Siguiente" name="Siguiente2" width="85" height="19"  border="0" id="Siguiente2"   align="Siguiente"
		  onmouseover="sobreElBoton('Siguiente2','botones/btn_siguiente_roll.gif')" onmouseout="sobreElBoton('Siguiente2','botones/btn_siguiente.gif')" onclick="enviarFormulario();" />
		  <img src="botones/btn_salir.gif" alt="Salir" name="Salir1" width="85" height="19"  border="0" id="Salir1" 
		  onmouseover="sobreElBoton('Salir1','botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir1','botones/btn_salir.gif')"onclick="salir();" /></td>
     </tr>
     </table>
    </td>
  </tr>
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
 
</table>

