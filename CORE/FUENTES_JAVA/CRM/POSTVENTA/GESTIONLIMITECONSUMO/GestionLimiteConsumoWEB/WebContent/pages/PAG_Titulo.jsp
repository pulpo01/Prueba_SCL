<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<table width="100%">
 <tr>
  <td class="barraarriba">Usuario: <bean:write name="login" property="username"/>  &nbsp;Operadora: <bean:write name="operadora"/>
  <td class="barraarriba" align="right" width="8%">Ver. 03/06/2010</td>
 </tr>
 
 <tr>
    <td width="4%" colspan="3">
      <table width="100%" border="0">
		  <tr>
		   <td align="left" class="textoTitulo"><img src="../img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>
		   <bean:write name="titulo"/></td>
		  </tr>
		  <tr>
		    <td class="textcaminohormigas">Ingreso de información</td>
		  </tr>
	  </table>
    </td>
  </tr>  
  
  <!-- 
   <tr>
    <td colspan="3">
	 <table width="100%" border="0">
     <tr>
       <td width="25%">&nbsp;</td>
       <td width="25%" align="center">&nbsp;</td>
       <td width="50%" align="right">
          <img style="cursor: pointer;" src="../botones/btn_siguiente.gif" name="Siguiente2" width="85" height="19"  border="0" id="Siguiente2"  align="Siguiente"  onmouseover="sobreElBoton('Siguiente2','../botones/btn_siguiente_roll.gif')" onMouseOut="sobreElBoton('Siguiente2','../botones/btn_siguiente.gif')" onclick="enviarFormulario();" />
		</td>
     </tr>
     </table>
    </td>
  </tr>
   -->
</table>

