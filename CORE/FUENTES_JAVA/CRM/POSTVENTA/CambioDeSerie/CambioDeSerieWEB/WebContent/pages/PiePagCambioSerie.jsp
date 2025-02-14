<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>


<html:hidden property="condicH" />
<div id="condicionesComercialesDiv" style="display:<c:out value="${requestScope.condComCK}"/>;">
<table width="100%" border="0">
  <tr>
    <td colspan="4" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7"/>Condiciones de Atenci&oacute;n</td>
  </tr>
  
  <tr>
    <td width="33%" >
        <html:checkbox onclick ="asignaValorAControl();" name="CambioDeSerieForm" property="condicionesCK"  disabled="false"/>
    	Sin modificar Condiciones Comerciales
	</td>
       
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>   
</table>
<div>
