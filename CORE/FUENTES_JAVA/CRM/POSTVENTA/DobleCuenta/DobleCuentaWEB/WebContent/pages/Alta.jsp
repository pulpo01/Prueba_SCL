<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<br>
<table border ="0" width="100%">
<logic:present name="tipValor" scope="session">
	<input type="hidden" name="tipValor" id="tipValor" value='<bean:write name="tipValor"/>'/>
</logic:present>
	<tr class="textoColumnaTabla">	
		<td><input  alt="Seleccionar Todos" name="checkbox524" type="checkbox" value="checkbox" onclick="MarcarChecAll(this.form,this)" /></td>	
		<td>Abonado</td>
		<td>Cliente Asociado</td>
		<td>Concepto Facturable</td>
		<td>Valor</td>
	</tr>
	<logic:present name="listaGrilla" scope="session"> 
            <logic:iterate id="listGri" name="listaGrilla"  type="com.tmmas.scl.doblecuenta.form.FacturacionDTO" scope="session">
	<tr bgcolor="#ffffff">
		<td><html:multibox name="FacturacionDifForm" property="listaCheckGrilla" disabled="true" ><bean:write name="listGri" property="codigoAbonado"/>|<bean:write name="listGri" property="codClienAsociado"/>|<bean:write name="listGri" property="codigoConcepto"/>|<bean:write name="listGri" property="valor"/>|<bean:write name="listGri" property="estadoListaFact"/> 
            </html:multibox>
		</td>		
		<td><font face="arial" size="1"><bean:write name="listGri" property="numeroCelular"/> - <bean:write name="listGri" property="descAbonado"/></font></td>
		<td><font face="arial" size="1"><bean:write name="listGri" property="descClienAsociado"/></font></td>
		<td><font face="arial" size="1"><bean:write name="listGri" property="descConcepto"/></font></td>
		<td><font face="arial" size="1"><bean:write name="listGri" property="valor"/></font></td>
		<input name="estadoLista" type="hidden" id="estadoLista"  value="<bean:write name="listGri" property="estadoListaFact"/>" />
	</tr>
      </logic:iterate>
   </logic:present>
   <logic:notPresent name="listaGrilla" scope="session">
   <tr bgcolor="#ffffff">
   		<td colspan="5" align="center">No existen datos</td>
   </tr>
   </logic:notPresent>
<input name="guardarDatGrilla" type="hidden" id="guardarDatGrilla"  value="" />	
</table>
<br>
<center>
<img src="<%=request.getContextPath()%>/images/bot_move_previous.gif" border="0" alt="move_previousGrilla"><img src="<%=request.getContextPath()%>/images/bot_move_first.gif" border="0" alt="move_firstGrilla"><img src="<%=request.getContextPath()%>/images/bot_move_last.gif" border="0" alt="move_lastGrilla"><img src="<%=request.getContextPath()%>/images/bot_move_next.gif" border="0" alt="move_nextGrilla">
</center>
<br>
<center>
<img src="<%=request.getContextPath()%>/botones/btn_guardar.gif" border="0" alt="guardarDatGrilla" id="guardarDatGrilla" onclick="guardarDatosGrilla();"  >
</center>