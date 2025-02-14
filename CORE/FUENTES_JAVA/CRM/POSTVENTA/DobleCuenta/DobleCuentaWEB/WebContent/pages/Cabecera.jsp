<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<table width="100%" border="0">
     <tr>
       <td colspan="3" align="left" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
     </tr>
     <tr>
		<td width="5%">&nbsp;</td>
		<td width="50%" align="left">
		  <table border="0" cellpadding="0" cellspacing="0"  width="100%">	
		  <tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		  </tr>
		  <tr>
			<td width=45% class="campoInformativo">N&uacute;mero de Orden de Servicio </td>
			<td width=1% class="valorCampoInformativo">:</td>
			<td width=54% class="valorCampoInformativo"><bean:write name="formCliente" property="codOOSS"/></td>
		  </tr>
         </table>
	    </td>
	   <td width="45%"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
        <tr>
          <td width=29% class="campoInformativo">C&oacute;digo del
          	Cliente</td>
          <td width=3%  class="valorCampoInformativo">:</td>
          <td width=68% class="valorCampoInformativo"><bean:write name="formCliente" property="codCliente"/></td>
       </tr>
    </table></td>
  </tr>
  <tr>
    <td width="5%">&nbsp;</td>
    <td width="50%">&nbsp;</td>
	<td width="45%">&nbsp;</td>
  </tr>
</table>