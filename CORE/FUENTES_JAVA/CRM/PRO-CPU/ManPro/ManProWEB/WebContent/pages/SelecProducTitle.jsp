<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set>
<table width="100%" border="0">
      <tr>
     <td class="mensajeError" align="center"><div id="mensajes" style="display:none;"></div></td>
      </tr>
</table>
<table width="100%" border="0">
  <tr class="textcaminohormigas">
    <td colspan="2" >Contrataci&oacute;n de Planes Adicionales/Selecci&oacute;n Productos </td>
  </tr>
  <tr>
    <td width="885" align="left"><img src="img/green_arrow.gif" width="15" height="15" /></span> <span class="textoTitulo">Contrataci&oacute;n Planes Adicionales</span></td>
  </tr>
  <tr>
    <td><table width="100%" border="0">
      <tr>
        <td width="57%"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
          <tr>
            <td width="4%"  >&nbsp;</td>
            <td width="12%"  class="campoInformativo">Cliente</td>
            <td width="2%"  >:</td>
            <td width="82%" class="valorCampoInformativo">
            	<bean:write name="ClienteVTA" property="nombre"/> 
	            <bean:write name="ClienteVTA" property="apellidoPaterno"/> 
	            <bean:write name="ClienteVTA" property="apellidoMaterno"/> - <bean:write name="ClienteVTA" property="idCliente"/>
             </td>
          </tr>
          <logic:notEqual name="Abonado" property="idAbonado" value="0">
	          <tr>
	            <td class="amarillo">&nbsp;</td>
	            <td class="campoInformativo">L&iacute;nea</td>
	            <td class="amarillo">:</td>
	            <td class="valorCampoInformativo"><bean:write name="Abonado" property="nombreAbonado"/> - <bean:write name="Abonado" property="idAbonado"/></td>
	          </tr>
          </logic:notEqual>
  		  <tr>
  		    <td width="4%"  >&nbsp;</td>
			<td width=12% class="campoInformativo">Color</td>
			<td width=2% class="valorCampoInformativo">:</td>
			<td width=82% class="valorCampoInformativo"><c:out value="${clienteOS.clColor}"/></td>
		  </tr>
  		  <tr>
  		    <td width="4%"  >&nbsp;</td>
			<td width=12% class="campoInformativo">Subsegmento</td>
			<td width=2% class="valorCampoInformativo">:</td>
			<td width=82% class="valorCampoInformativo"><c:out value="${clienteOS.clSegmento}"/></td>
		  </tr>            
        </table></td>
        <td width="43%">&nbsp;</td>
      </tr>
    </table></td>
  </tr>
</table>
