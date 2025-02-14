<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<table width="100%">
 <tr>
  <td class="barraarriba">Usuario: <c:out value="${clienteOS.usuario}"/> 
  </td>
 </tr>
 
 <tr>
    <td width="4%" colspan="3">
      <table width="100%" border="0">
		  <tr>
		   <td align="left" class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>Cambio Plan Unificado</td>
		  </tr>
		  <tr>
		    <td class="textcaminohormigas">Ingreso de números frecuentes</td>
		  </tr>
		   <tr>
	     	<td class="mensajeError"><div id="mensajes"></div></td>
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
       <td width="50%" align="right">&nbsp;</td>
     </tr>
     </table>
    </td>
  </tr>
  
  <tr>
    <td width="4%" colspan="3">&nbsp;</td>
  </tr>  
 
</table>

