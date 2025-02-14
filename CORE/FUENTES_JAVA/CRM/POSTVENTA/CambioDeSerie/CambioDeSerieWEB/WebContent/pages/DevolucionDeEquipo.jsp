<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

	<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>
	
	<table width="100%">
	<tr height="30">
		<td>Devoluci&oacute;n de Equipo Comodato</td>
	</tr>
	<tr>
		<td> 
			<table width="100%">
			<tr>
			<td> 	
				<table width="550" align=center>
				<tr valign=top>
					<td align=center> 	
						<table cellpadding=3 cellspacing=3>
						<tr>
							<td colspan=2 class="textoSubTitulo"> <b>Devoluci&oacute;n </td>
						<tr>
							<td> Devuelve equipo </td>
							<td align=middle> <html:radio value="si devuelve" onClick="devolucionEquipo(this.value)" property="opDevuelveEquipo"/></td>
						<tr>
							<td> NO Devuelve equipo </td>
							<td align=middle> <html:radio value="no devuelve"  onClick="devolucionEquipo(this.value)" property="opDevuelveEquipo"/></td>
							<tr>	
							<td> Devuelve equipo (Diferido)</td>
							<td align=middle> <html:radio value="diferido"  onClick="devolucionEquipo(this.value)" property="opDevuelveEquipo"/></td>
						<tr>		
							<td> Compra equipo </td>
							<td align=middle> <html:radio value="compra"  onClick="devolucionEquipo(this.value)" property="opDevuelveEquipo"/></td>		
						</tr>
						</table>
					</td>				
			
			
					<td align=center> 	
						<table cellpadding=3 cellspacing=3>
						<tr>
							<td colspan=2 class="textoSubTitulo"> <b>Estado del equipo devuelto </td>
						<tr>
							<td> Bueno </td>
							<td align=middle>  <html:radio value="B" property="opEstadoEquipo" disabled="true"/></td>
						<tr>
							<td> Regular </td>
							<td align=middle> <html:radio value="R" property="opEstadoEquipo" disabled="true"/> </td>
						<tr>	
							<td> Malo</td>
							<td align=middle> <html:radio value="M" property="opEstadoEquipo" disabled="true"/> </td>
						</tr>
						</table>
					</td>				
			
					<td align=center> 	
						<table cellpadding=3 cellspacing=3>
						<tr>
							<td colspan=2  class="textoSubTitulo"> <b>Devuelve cargador</td>
						<tr>
							<td> Si </td>
							<td align=middle> <html:radio value="" property="opCargador" disabled="true"/> </td>
						<tr>
							<td> No </td>
							<td align=middle> <html:radio value="" property="opCargador" disabled="true"/> </td>
						</tr>
						</table>
					</td>				
			
				</tr>	
				
				<tr valign=top height="30" class="textoSubTitulo">
					<td align=center colspan=3><html:checkbox property="opAmistar" disabled="true"/>
					Desea habilitarlo como AMISTAR </td>				
				</tr>		
			
				<tr valign=top height="30"  class="textoSubTitulo">
					<td align=center colspan=3> Obtiene Bodega Receptora
						&nbsp;&nbsp;
						<html:select size="1" property="bodegaDestino" disabled="true">
							<logic:iterate name="bodegasLista" id="bodega" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO">
									<html:option value="<%= String.valueOf(bodega.getCod_bodega())%>"><bean:write name="bodega" property="des_bodega"/></html:option>
							</logic:iterate>
						</html:select>
					</td>				
				</tr>		
				</table>
			</tr>
			</table>		
		</td>
	</tr>
	</table>


<!-- ---------------------------------------------------------------------------------------------- -->

