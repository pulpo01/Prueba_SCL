<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<table width="100%" border="0" align="center">
  <tr height="10">
	 <td width="4%" colspan="3" align="center">
    	<span id="identMsg" style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;"></span>
    </td>
  </tr>
<logic:present name="tipValor" scope="session">
	<input type="hidden" name="tipValor" id="tipValor" value='<bean:write name="tipValor"/>'/>
</logic:present>
<tr height="10">
	<td width="4%" colspan="3" align="center">
		<logic:present name="error" scope="request">
			<span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;" id="error"><bean:write name="error"/></span>
		</logic:present>
	</td>
</tr>
</table>	  
<table width="100%" border="0" align="center">
	<tr class="textoColumnaTabla">
		<td width="20%">ABONADO</td>
		<td width="20%">CLIENTE ASOCIADO</td>
		<td width="20%">CONCEPTO FACTURABLE</td>
		<td width="20%">VALOR</td>
	</tr>
	<tr id="trAbonado" style="visibility:hidden" bgcolor="#ffffff">
		<td width="20%">
		<html:select property="listaAbonado" styleId="listaAbo" onchange="javascript:setDatos(this)" style="width:260px" styleClass="select"></html:select>
		</td>
		<td width="20%">
			<span id="desc_Clien_Asociado"></span>
		</td>
		<td width="30%">
			<span id="desc_Concepto"></span>
		</td>
		<td width="10%">
			<input type="Text" name="valor_1" id="valor_1" size="15" maxlength="15" onclick="limpiaMensajeError();validarMensaje();" onblur="extractNumber(this,2,false);" onkeyup="extractNumber(this,2,false);" onkeypress="return blockNonNumbers(this, event, true, false);" >
		</td>
		
		
		<input type="hidden" name="codigo_Abonado" id="codigo_Abonado">
		<input type="hidden" name="numero_Celular" id="numero_Celular">
		<input type="hidden" name="cod_Clien_Asociado" id="cod_Clien_Asociado">
		<input type="hidden" name="codigo_Concepto" id="codigo_Concepto">
		<input type="hidden" name="num_Secuencia_Detalle"   id="num_Secuencia_Detalle">

	</tr>
</table>
<br>
	
<center>
<input type="button" name="button" value="Modificar" onclick="update();" class="barraarriba"/>
</center> 