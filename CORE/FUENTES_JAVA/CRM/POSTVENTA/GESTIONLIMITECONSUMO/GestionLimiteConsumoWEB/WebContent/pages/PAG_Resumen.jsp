<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
     

<table width="100%" border="0">
  <tr>
    <td colspan="3" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" />      Comentario</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>   
  <tr>
    <td colspan="3" ><html:textarea styleId="comentario" property="strComentario" tabindex="1" cols="80" rows="15" onkeypress="textCounter();"></html:textarea> </td> 
  </tr>     
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>  
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr> 
</table>
