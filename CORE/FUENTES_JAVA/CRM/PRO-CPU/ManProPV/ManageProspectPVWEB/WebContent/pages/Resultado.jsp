<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
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
    <td colspan="3" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" />      Resultado</td>
  </tr>
  
  <c:if test="${empty mensajeError}">  
  <tr>
    <td class="campoInformativo"><div id="mensajes"></div></td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>   
  <tr>
    <td colspan="3" > </td> 
  </tr>
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr>
     
  <tr>
    <td width="30%">&nbsp;</td>
	<td width="40%" class="campoInformativo">
		<c:if test="${clienteOS.codOrdenServicio!=40009}">Abonado</c:if>
		<c:if test="${clienteOS.codOrdenServicio==40009}">Cliente</c:if>-Orden de Servicio</td>
	 <td width="30%">&nbsp;</td>
  </tr> 
  <tr>
	  <td width="30%">&nbsp;</td>
	  <td width="40%">
      <html:select property="abonadoSel" size="6">
	      <c:if test="${not empty Abonados}">
			       	<logic:iterate id="abonado" name="Abonados" scope="session" type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
				  		<html:option value="<%=String.valueOf(abonado.getNumAbonado())%>"> <bean:write name="abonado" property="numAbonado"/>-<bean:write name="abonado" property="numeroOS"/> </html:option>
					</logic:iterate>
		  </c:if>    
		  <c:if test="${not empty AbonadosEmpresa}">
		       	<logic:iterate id="abonado" name="AbonadosEmpresa" scope="session" type="com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO">
			  		<html:option value="<%=String.valueOf(abonado.getNumAbonado())%>"> <bean:write name="abonado" property="numAbonado"/>-<bean:write name="abonado" property="numOOSS"/> </html:option>
				</logic:iterate>
          </c:if>
      </html:select>
	  </td>
	  <td width="30%">&nbsp;</td>
  </tr>
  </c:if>
  
  <c:if test="${not empty mensajeError}">
  <table width="100%" border="0" >
	<tr>
	   <td class="mensajeError" colspan="3" align="center"><bean:write name="mensajeError"/></div></td>
	</tr> 
  </table>
  </c:if>
   
  <tr>
    <td>&nbsp;</td>
	<td>&nbsp;</td>
	<td>&nbsp;</td>	
  </tr> 
</table>



