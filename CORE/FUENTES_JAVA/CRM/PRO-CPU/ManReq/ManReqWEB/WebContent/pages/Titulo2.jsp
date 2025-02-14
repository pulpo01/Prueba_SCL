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
		   <td align="left" class="textoTitulo" width="95%"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>
		       <c:out value="${sessionScope.NombreOss}"/> <!-- AVC; se obtiene el nombre de la orden de servicio -->
		   </td>
		   <td align="right" class="textoTitulo" width="5%">
		      <c:out value="${sessionScope.version}"/> <!-- AVC; se obtiene la version  --> 
		   </td>
		  </tr>
	  </table>
	  <table width="100%" border="0">	  
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
          <img style="cursor: pointer;" src="botones/btn_anterior.gif" alt="Anterior" border="0" id="Anterior" 
	      onmouseover="sobreElBoton('Anterior','botones/btn_anterior_roll.gif')"  onmouseout="sobreElBoton('Anterior','botones/btn_anterior.gif')" onclick="formularioAnterior();"/>
          <img style="cursor: pointer;" src="botones/btn_siguiente.gif" name="Siguiente" width="85" height="19"  border="0" id="Siguiente"   alt="Siguiente"
		  onmouseover="sobreElBoton('Siguiente','botones/btn_siguiente_roll.gif')" onMouseOut="sobreElBoton('Siguiente','botones/btn_siguiente.gif')" onclick="enviarFormulario();" />
		  <img style="cursor: pointer;" src="botones/btn_salir.gif" name="Salir" width="85" height="19"  border="0" id="Salir" 
		  onmouseover="sobreElBoton('Salir','botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir','botones/btn_salir.gif')"onclick="salir();" /></td>
     </tr>
     </table>
    </td>
  </tr>
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
 
</table>

