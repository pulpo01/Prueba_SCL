<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<br>
<br>
<table width="100%" border="0">
<tr height="10">
	<td width="4%" colspan="3" align="center">
		<logic:present name="error" scope="session">
			<span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;"><bean:write name="error"/></span>
		</logic:present>
	</td>
</tr>
      <tr>
     <td class="mensajeError" align="center">
     <logic:present name="eliminado" scope="request">
     	<span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;"><bean:write name="eliminado"/></span>
      </logic:present>
      </tr>
</table>
<table border ="0" width="100%" id="tablaFactura" >
	<tr class="textoColumnaTabla">	
		<td><input alt="Seleccionar Todos" name="checkMasivo" type="checkbox" value="checkMasivo" id="checkMasivo" onclick="MarcarCheckAll(this.form,this)" /></td>	
		<td>Abonado</td>				
		<td>Cliente Asociado</td>
		<td>Concepto Facturable</td>		
		<td>Valor</td>
	</tr>
	<logic:present name="listaGrilla" scope="session"> 
            <logic:iterate id="listGri" name="listaGrilla"  type="com.tmmas.scl.doblecuenta.form.FacturacionDTO" scope="session">
     <tr bgcolor="#ffffff">
		<td><html:multibox name="FacturacionDifForm" property="listaCheckGrilla" disabled="false" onblur="limpiaMensajeError();" onclick=""><bean:write name="listGri" property="codigoAbonado"/>|<bean:write name="listGri" property="codClienAsociado"/>|<bean:write name="listGri" property="numSecuenciaDetalle"/>|
            </html:multibox>
		</td>		
		<td><bean:write name="listGri" property="numeroCelular"/> - <bean:write name="listGri" property="descAbonado"/></td>
		<td><bean:write name="listGri" property="descClienAsociado"/></td>
		<td><bean:write name="listGri" property="descConcepto"/></td>
		<td><bean:write name="listGri" property="valor"/></td>
	</tr>
      </logic:iterate>
   </logic:present>
   <logic:notPresent name="listaGrilla" scope="session">
   <tr bgcolor="#ffffff">
   	<td colspan="5" align="center">No existen datos</td>
   </tr>
   </logic:notPresent>
<input name="eliminarDatGrilla" type="hidden" id="eliminarDatGrilla"  value="" />
<input name="checkMasivo" type="hidden" id="checkMasivo" value=""  />
</table>
<br>
<br>
<center>
<img src="<%=request.getContextPath()%>/botones/btn_eliminar.gif" id="botonElimina" border="0" onclick="eliminarDatosGrilla();">
</center>