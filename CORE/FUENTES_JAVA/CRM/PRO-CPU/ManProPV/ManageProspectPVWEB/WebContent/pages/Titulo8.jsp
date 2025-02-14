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
		   <td align="left" class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/><c:out value="${clienteOS.nombOss}"/></td>
		  </tr>
		  <tr>
		    <td class="textcaminohormigas">Resultado envio mensaje a cola</td>
		  </tr>
	  </table>
    </td>
  </tr>  
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
  <tr>
      <td align="right" colspan="3">
		  <img style="cursor: pointer;" src="botones/btn_salir.gif" name="Salir" width="85" height="19"  border="0" id="Salir" 
		  onmouseover="sobreElBoton('Salir','botones/btn_salir_roll.gif')" onmouseout="sobreElBoton('Salir','botones/btn_salir.gif')"onclick="salir();" />
	  </td>
   </tr>
 
</table>