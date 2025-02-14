<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<logic:present name="ClienteVTA" property="listadoAbonados">
	<bean:size id="size" name="ClienteVTA" property="listadoAbonados"/>
	<logic:equal name="size" value="0">
	<!-- Crear un mensaje si no encuentra -->				
			<h2>No posee Abonados</h2>		
	</logic:equal>
	
	<logic:greaterThan name="size" value="0">
		<html:hidden property="idAbonado" styleId="idAbonado" value="0"/>
		<html:hidden property="idCliente" styleId="idCliente" value="0"/>
		<html:hidden property="cadenaProductosSeleccionados" styleId="cadenaProductosSeleccionados" value=""/>
				
		<table width="100%" border="0" align="left">
			<tr>	  	
				<td width="7%">&nbsp;</td>
				<td width="73%">				
				<table width="100%" border="0" cellpadding="0" cellspacing="2">
					<tr class="textoColumnaTabla">
						<td width="12%" >Abonado</td>
						<td  >N&uacute;mero celular</td>
						<td  colspan="2">Usuario l&iacute;nea </td>
						<td  >Prestaci&oacute;n </td>
			<!--  td height="15" colspan="2" >Planes Adicionales</td -->
					</tr>
			<!-- tr class="textoColumnaTabla">
			<td width="12%" >Contratados</td>
			<td width="12%" height="15" >Personalizados</td -->
			</tr>
		    <%int filas = 0;%>
			<logic:iterate id="listadoAbonados" name="ClienteVTA" property="listadoAbonados">
				<logic:notEqual name="listadoAbonados" property="idAbonado" value="0">
				    <%if (filas%2==0){ %> 	
				    <tr class="textoFilasTabla">
				    <%}else{ %>
				    <tr class="textoFilasColorTabla">
					    <%}%>    
							<td align="center"><bean:write name="listadoAbonados" property="idAbonado"/></td>
							<td align="center"><bean:write name="listadoAbonados" property="numCelular"/></td>
							<td align="center">
									<img style="cursor: pointer"
										 alt="Contratar Planes Adicionales al Abonado" 
										 onclick="desplegarPorAbonado('<bean:write name="listadoAbonados" property="idAbonado"/>')" 
										 src="img/botones/ico_contrata_sintexto.gif" 
									/>					
							</td>
							<td align="left"><bean:write name="listadoAbonados" property="nombreAbonado"/></td>
							<td align="left"><bean:write name="listadoAbonados" property="desPrestacion"/></td>
							<!--  td align="center">SI</td -->
							<!--  td align="center">SI</td -->
					</tr>
				<%filas++; %> 
				</logic:notEqual>
			</logic:iterate> 
		    </table>
    </logic:greaterThan>
    </td>
  </tr>
</table>
</logic:present>
