<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

	<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}"/> 
	<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />

	<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>

	<!--  Para la validacion si acepta el cambio de plan tarifario en caso de existir uno pendiente -->
	<input type="hidden" id="glosaCambioPlan" name="glosaCambioPlan" value="<c:out value="${requestScope.glosaCambioPlan}"/>"/>
	<input type="hidden" id="retornoCambioPlan" name="retornoCambioPlan" value="<c:out value="${requestScope.retornoCambioPlan}"/>"/>	
	
	<input type="hidden" id="num_abonado" name="num_abonado" value="<c:out value="${ClienteOOSS.numAbonado}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${ClienteOOSS.usuario}"/>"/>

	<input type="hidden" id="condicionError" name="condicionError" value=""/>	
	<input type="hidden" id="mensajeError" name="mensajeError" value=""/>	
	<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value=""/>		
	<input type="hidden" id="tipoSuspensionSel" name="tipoSuspensionSel" value="<c:out value="${requestScope.tipoSuspension}"/>"/>	
 
	<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">Campos</td>
	</tr>

	<tr>
		<td> 	
			<table width="100%">
			<tr>
				<td width="120">Número de Abonado</td>
				<td> <html:text style="text-align: right;" tabindex="1" property="nroAbonado" size="15" readonly="true"/> </td>				
			</tr>				
			
			
			<tr>
				<td width="120">Número de Terminal</td>
				<td> <html:text  style="text-align: right;"  tabindex="2" property="nroTerminal" size="15" readonly="true"/> </td>				

				<td width="120">Tecnología</td>
				<td> <html:text  tabindex="3" property="tecnologia" size="25" readonly="true"/> </td>				
			</tr>				
							
			<tr>				
				<td width="120">Fecha Siniestro</td>
				<td> <html:text tabindex="4"  property="fecSiniestro" maxlength="15" size="15"  readonly="true" /> 
				</td>				

				<td width="120">Tipo de Suspensión</td>
				<td> 
					<html:select   tabindex="5" property="tipoSuspencion" size="1">
						<option value="">
						<logic:iterate name="tipoSuspencionLista" id="tipoSuspencion" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO">
								<html:option value="<%= String.valueOf(tipoSuspencion.getCod_TipoSuspencion())%>"><bean:write name="tipoSuspencion" property="des_TipoSuspencion"/></html:option>
						</logic:iterate>
					</html:select>
				</td>				
			</tr>				
			
			<tr>
				<td width="120">Causa de Siniestro</td>
				<td> 
					<html:select property="causaSiniestro" size="1"  tabindex="6" onchange="fcBuscarTipSusp();">
						<option value="">
						<logic:iterate name="causaSiniestroLista" id="causaSiniestro" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO">
								<html:option value="<%= String.valueOf(causaSiniestro.getCod_causa())%>"><bean:write name="causaSiniestro" property="des_causa"/></html:option>
						</logic:iterate>
					</html:select>
				</td>				

				<td width="120">Tipo de Siniestro</td>
				<td> 
					<html:select property="tipoSiniestro" size="1"  tabindex="7" >
						<option value="">
						<logic:iterate name="tipoSiniestroLista" id="tipoSiniestro" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO">
								<html:option value="<%= String.valueOf(tipoSiniestro.getCod_TipoSiniestro())%>"><bean:write name="tipoSiniestro" property="des_TipoSiniestro"/></html:option>
						</logic:iterate>
					</html:select>
				</td>				
			</tr>	
			
			
			<tr>
				<td width="120">Desviar a Número</td>
				<td><input type="text" onpaste="return false" name="numeroDesviado" id="nroCelularDesviado" size="20" onkeypress="validaFormatoNumeroDesvio(this,event);" onblur="verificaNumeroDesvio(this.value);" maxlength="15"/></td>
			</tr>			

			<tr height="10" align="center">
				<td colspan=6>&nbsp;</td>
			</tr>					
			</table>
		</td>
	</tr>	
	</table>
	
	<br>



<!-- ---------------------------------------------------------------------------------------------- -->

