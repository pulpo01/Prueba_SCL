<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@page import="com.tmmas.scl.gestionlc.common.dto.ws.CargaSeguimientoSiniestroOutDTO"%>

<div id="mensajes" style="display: none">
<table width="100%" border="0">
	<tr>
		<td class="mensajeError">
		<div id="textoerror" style="display: none;"></div>
		</td>
	</tr>
</table>
</div>
<table width="100%" border="0">
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Informaci&oacute;n
		de Atenci&oacute;n</td>
	</tr>
	<tr>
		<td colspan="4">
		
		<table>
		
			<tr>
				<td width="100px"><b>Celular</b></td>

				<td><bean:write name="CargaSeguimientoSiniestroOutDTO" property="lonNumTerminal" /></td>
			</tr>
			
			<tr>
				<td><b>Numero Siniestro</b></td>
				<td colspan="20">
				<div id="NumSiniestro"></div>
				<html:hidden styleId="lonIdSiniestro" property="lonIdSiniestro"/>
				</td>
				<td><b>Fecha Siniestro</b></td>
				<td><div id="fechaSiniestro"></div>
				</td>
			</tr>
			<tr>
				<td><b>Causa</b></td>
				<td colspan="20"><div id="causa"></div>
				</td>
				<td><b>Estado</b></td>
				<td><div id="estado"></div>
				</td>
			</tr>
			<tr>
				<td><b>Constancia Policial</b></td>
				<td colspan="20"><div id="lonNumConstPolicial"></div>
				<html:hidden styleId="lonConstPolicial" property="lonConstPolicial"/>
				</td>
				
				<td><b>Fecha Restituci&oacute;n</b></td>
				<td><div id="strFechaRestitucion"></div>
				<html:hidden styleId="strFecRestitucion" property="strFecRestitucion"/>
				</td>
			</tr>
			<tr>
				<td width="150"><b>Observaciones</b></td>
				<td colspan="3"><textarea tabindex="1" name="strObservacion" id="strObservacion" cols="50"
					rows="8"></textarea></td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
				<td>
					<logic:present name="CargaSeguimientoSiniestroOutDTO" property="siniestroDTOs">
							<bean:define name="CargaSeguimientoSiniestroOutDTO" property="siniestroDTOs" id="siniestroDTOs"/>
						</logic:present>
					<table  width="50%" border="0" align="center">
						<tr>
							<td width="10%" class="barraarriba"></td>
							<td width="15%" class="barraarriba">Siniestro</td>
							<td width="15%" class="barraarriba">Estado</td>
							<td width="20%" class="barraarriba">Causa</td>
							<td width="25%" class="barraarriba">F. Formalizacion</td>
							<td width="22%" class="barraarriba">Terminal</td>
						</tr>
					
						<logic:iterate name="siniestroDTOs" id="siniestros">
							<tr >
								<td width="10%"><input id="radSiniestro" name="radSiniestro" value="<bean:write name="siniestros" property="lonNumSiniestro"/>
								" type="radio" onClick="javascript:reloadData(this.form);">
								</td>
								<td width="15%"><bean:write name="siniestros" property="lonNumSiniestro"/><input type="hidden" name="lonNumSiniestro" value="<bean:write name="siniestros" property="lonNumSiniestro"/>"/></td>
								<td width="15%"><bean:write name="siniestros" property="strDetEstado"/><input type="hidden" name="strDetEstado" value="<bean:write name="siniestros" property="strDetEstado"/>"/></td>
								<td width="20%"><bean:write name="siniestros" property="strDetCausa"/><input type="hidden" name="strDetCausa" value="<bean:write name="siniestros" property="strDetCausa"/>"/></td>
								<td width="20%"><bean:write name="siniestros" property="strFechaFormaliza"/><input type="hidden" name="strFechaSiniestro" value="<bean:write name="siniestros" property="strFechaSiniestro"/>"/></td>
								<td width="20%"><bean:write name="siniestros" property="strDesTerminal"/><input type="hidden" name="strTipTerminal" value="<bean:write name="siniestros" property="strTipTerminal"/>"/>
								<input type="hidden" name="lonNumConstancia" value="<bean:write name="siniestros" property="lonNumConstancia"/>"/>
								<input type="hidden" name="strObservaciones" value="<bean:write name="siniestros" property="strObservaciones"/>"/>
								<input type="hidden" name="strFechaActual" value="<bean:write name="CargaSeguimientoSiniestroOutDTO" property="strFechaActual"/>"/>
								
								</td>
							</tr>
						</logic:iterate>
					</table>				
				</td>
			</tr>
			
	<tr>
		<td colspan="4"></td>
	</tr>
</table>


