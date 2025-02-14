<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html"	prefix="html"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<input type="hidden" id="num_abonado" name="num_abonado" value='<c:out value="${ClienteOOSS.numAbonado}"/>' />
<input type="hidden" id="nom_usuario" name="nom_usuario" value='<c:out value="${ClienteOOSS.usuario}"/>' />
<input type="hidden" id="codTipContrato" name="codTipContrato" value='<c:out value="${usuarioAbonado.codTipContrato} "/>' />
<input type="hidden" id="des_tipcontrato" name="des_tipcontrato" value='<c:out value="${usuarioAbonado.des_tipcontrato}"/>' />

<input type="hidden" id="cod_cliente" name="cod_cliente" value='<c:out value="${usuarioAbonado.cod_cliente}"/>' />
<input type="hidden" id="cod_tecnologia" name="cod_tecnologia" value='<c:out value="${usuarioAbonado.cod_tecnologia}"/>' />
<input type="hidden" id="nom_usuario" name="nom_usuario" value='<c:out value="${usuarioSistema.nom_usuario}"/>' />
<input type="hidden" id="cod_tipcomis" name="cod_tipcomis" value='<c:out value="${usuarioSistema.cod_tipcomis}"/>' />
<input type="hidden" id="cod_ooss" name="cod_ooss" value='<c:out value="${ClienteOOSS.codOrdenServicio}"/>' />

<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}" />
<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />

<input type="hidden" id="indiceAnular" name="indiceAnular"/>
<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>
<input type="hidden" id="flagCrearPeriodo" name="flagCrearPeriodo" />
<input type="hidden" id="indexFecSuspension" name="indexFecSuspension" />
<input type="hidden" id="flagOOSSCambiada" name="flagOOSSCambiada" />

<input type="hidden" id="condicionError" name="condicionError" value="" />
<input type="hidden" id="mensajeError" name="mensajeError" value="" />
<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value="" />

<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">Suspensiones del Abonado</td>
	</tr>
	<tr>
		<td align="center">
           <div style="overflow: auto;width:1100px; height:200px; SCROLLBAR-FACE-COLOR:#EBE9DC; BORDER-LEFT-COLOR: #EBE9DC BORDER-BOTTOM-COLOR: #EBE9DC; BORDER-TOP-COLOR: #EBE9DC; BORDER-RIGHT-STYLE: #EBE9DC;  ">
			<table width='1080px' border="0" cellpadding="3" cellspacing="3" id="tablaSuspensiones">
			<tr class="textoColumnaTabla">
				<td>Selec.
				<td>Fec.Solicitud
				<td>Fec.Suspensión
				<td>Fec.Rehabilitación
				<td>Causa
				<td>Estado
				<td>Cant.Días				
				<td>Anular
			</tr>           
			
			<c:if test="${suspensionesAbonado != null}">
				<logic:iterate indexId="indice" id="causa" name="suspensionesAbonado">
					<tr class="textoFilasTabla">
					<td align="center"><input type=radio name="radioSel" onclick="javascript:clickGrilla(<%=indice.intValue()+1%>, 'modificar');"></td>
					<td><fmt:formatDate value="${causa.fechaSolicitud}" pattern="dd/MM/yyyy"/></td>
					<td><fmt:formatDate value="${causa.fechaSuspension}" pattern="dd/MM/yyyy"/></td>
					<td><fmt:formatDate value="${causa.fechaRehabilitacion}" pattern="dd/MM/yyyy"/></td>
					<td><bean:write name="causa" property="causaSuspension.descripcionCausa"/></td>
					<td><bean:write name="causa" property="estado"/></td>
					<td align="right"><c:out value="${causa.diasSus1+causa.diasSus2}"/></td>
					<td align="center"><a href="#" onclick="javascript:clickGrilla(<%=indice.intValue()+1%>, 'anular'); return false;"><img src="../suspensionVol/botones/anular.gif" border=0></a></td>
				</logic:iterate>
			</c:if>					
			</table>
           </div>		
           </div>		
		</td>
	</tr>

	<tr height="10" align="center">
		<td colspan="6">&nbsp;</td>
	</tr>

	<tr height="30">
		<td class="textoSubTitulo">Datos de la Suspensión</td>
	</tr>
	<tr>
		<td align="center">
		<table width="100%">
			<tr>
				<td width="120" align="left">Número de Abonado</td>
				<td align="left"><html:text tabindex="1" style="text-align:right" readonly="true" size="15" property="nroAbonado"/></td>

				<td width="120" align="left">Número de Terminal</td>
				<td align="left"><html:text tabindex="2" style="text-align:right" readonly="true" size="15" property="nroTerminal"/></td>
			</tr>

			<tr>
				<td width="120" align="left">Fec.Solicitud</td>
				<td align="left"><html:text tabindex="3" readonly="true" size="15" property="fecSolicitud"/></td>

				<td width="120" align="left">Fec.Suspensión</td>
				<td align="left"> 
					<html:select size="1" property="fecSuspension"  onchange="javascript:validaFechaSuspension();limpiar('parte');">	
						<option value="">
						<logic:iterate name="fecSuspension" id="fecha" scope="request" type="com.tmmas.scl.framework.productDomain.dataTransferObject.FechasSuspensionDTO">
							<option value="<fmt:formatDate value="${fecha.fechaSuspencion}" pattern="dd/MM/yyyy"/>"><fmt:formatDate value="${fecha.fechaSuspencion}" pattern="dd/MM/yyyy"/>
						</logic:iterate>
					</html:select>
									
				<td width="120" align="left">Cantidad de Días</td>
				<td align="left"><html:text maxlength="4" tabindex="5" style="text-align:right" size="15" property="cantDias" onchange="calculaDias()"/></td>
			</tr>

			<tr>
				<td width="120" align="left">Causa</td>
				<td align="left">
					<html:select size="1" property="causaSuspension">
						<option value="">
						<logic:iterate name="causasSuspension" id="causa" scope="request" type="com.tmmas.scl.framework.productDomain.dataTransferObject.CausasSuspensionDTO">
								<html:option value="<%= String.valueOf(causa.getCodigoCausa())%>"><bean:write name="causa" property="descripcionCausa"/></html:option>
						</logic:iterate>
					</html:select>
				</td>

				<td width="120" align="left">Fec.Rehabilitación</td>
				<td align="left"><html:text tabindex="7" size="15" property="fecRehabilitacion" readonly="true"/></td>

			</tr>

			<tr>
				<td colspan="6" align="center">
					<br>
					<img border=0 src="../suspensionVol/botones/btn_limpiar.gif" onclick="limpiar('todo')" alt="">
				</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr height="10" align="center">
		<td colspan="6">&nbsp;</td>
	</tr>
</table>
