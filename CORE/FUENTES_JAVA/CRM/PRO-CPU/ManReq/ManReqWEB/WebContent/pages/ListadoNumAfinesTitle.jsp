<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="productoOS" value="${sessionScope.productoAfinSelec}"></c:set>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">

</head>
<body>
 <table width="100%" border="0">
      <tr>
     <td class="mensajeError" align="center"><div id="mensajes"></div></td>
      </tr>
</table>
  <table width="100%" border="0">
    
      <td colspan="10"   class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" />Personalizaci&oacute;n  de Clientes Afines </td>
    <tr>
      <td colspan="10" >
        <table width="100%" border="0">
          
          <tr>
         	
            <td width="2%">&nbsp;</td>
            <td width="12%" class="campoInformativo">C&oacute;digo Producto </td>
            <td width="1%" >:</td>
            <td width="33%" class="valorCampoInformativo"><c:out value="${productoOS.codProducto}"/> </td>
            
            
            <td width="12%" class="campoInformativo">M&aacute;ximos permitidos </td>
            <td width="1%">:</td>
            <td width="33%" class="valorCampoInformativo"> <c:out value="${productoOS.maximo}"/>  </td>
            
          </tr>
          <tr>
            <td>&nbsp;</td>
            
            <td class="campoInformativo">Producto </td>
            <td >:</td>
            <td class="valorCampoInformativo"> <c:out value="${productoOS.nombre}"/>  </td>
            
            
            
            
          </tr>
        </table>        </td>
  </table>


</body>
</html>