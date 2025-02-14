<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>

<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<table width="100%" border="0">
    <tr class="textcaminohormigas">
      <td>Contrataci&oacute;n de Planes Adicionales/Detalle de Cargos </td>
    </tr>
    <tr>
      <td><img src="img/green_arrow.gif" > <span class="textoTitulo">Detalle de cargos Planes Adicionales</span></td>
    </tr>
    <tr>
      <td>
	  <table width="100%" border="0">
          <tr>
            <td width="57%">
			<table border="0" cellpadding="0" cellspacing="0"  width="100%">
                <tr>
                  <td width="4%"  >&nbsp;</td>
                  <td width="12%"  class="campoInformativo">Cliente</td>
                  <td width="2%"  >:</td>
                  <td width="82%" class="valorCampoInformativo" >
                    <logic:present name="ClienteSession" scope="session">
                  		<bean:write name="ClienteSession" property="nombres" scope="session" /> - <bean:write name="ClienteSession" property="codCliente" scope="session" /> 
                  	</logic:present>
                  </td>
                </tr>
            </table>
			</td>
            <td width="43%">&nbsp;</td>
          </tr>
      </table>
</table>