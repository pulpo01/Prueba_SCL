<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>
<%@page import="com.tmmas.scl.gestionlc.common.dto.ws.CargaRestitucionEquipoOutDTO"%>

<div id="mensajes" style="display: none">

<input type="hidden" id="nombreUsuario" value="<bean:write name="UserName"/>"/>	
<input type="hidden" id="numeroAbonado" value="<bean:write name="NumAbonado"/>"/>	

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
				<td colspan="70"><b>Celular:</b></td>
				<td colspan="80"><bean:write name="CargaRestitucionEquipoOutDTO" property="lonNumCelular" /></td>
				<td ><b>Usuario:</b></td>
				<td><bean:write name="CargaRestitucionEquipoOutDTO" property="strNomUsuario" /></td>
			</tr>
		
		</table>
		</td>
	</tr>
	
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Equipo Antiguo</td>
	</tr>
			
	<tr>
		<td colspan="4">
		
		<logic:present name="CargaRestitucionEquipoOutDTO" property="equipoAntiguoDTO">
			<bean:define name="CargaRestitucionEquipoOutDTO" property="equipoAntiguoDTO" id="equipoAntiguoDTO"/>
		</logic:present>
	
		<table>
			<tr>
				<td width="70px"><b>Equipo:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strDesEquipo">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strDesEquipo" /></td>
				</logic:present>
				<td width="100px"><b>Serie:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strNumSerie">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strNumSerie" /></td>
				</logic:present>
				<td width="100px"><b>S. Mec&aacute;nica:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strSerieMec">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strSerieMec" /></td>
				</logic:present>
			</tr>
			
			<tr>
				<td width="70px"><b>Tipo:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strTipTerminal">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strTipTerminal" /></td>
				</logic:present>
				<td width="100px"><b>Modalidad Venta:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strModalidadVenta">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strModalidadVenta" /></td>
				</logic:present>
				<td width="100px"><b>Propiedad:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strPropiedad">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strPropiedad" /></td>
				</logic:present>
			</tr>
			
			<tr>
				<td width="70px"><b>Contrato:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strDesContrato">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strDesContrato" /></td>
				</logic:present>
				<td width="100px"><b>Procedencia:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strProcedencia">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strProcedencia" /></td>
				</logic:present>
				<td width="100px"><b>Uso:</b></td>
				<logic:present name="equipoAntiguoDTO" property="strDesUso">
					<td colspan="80"> <bean:write name="equipoAntiguoDTO" property="strDesUso" /></td>
				</logic:present>
			</tr>
			<tr>
				<td colspan="70"><div id="numContrato"><b>N&uacute;m. Contrato:</b></div></td>
				<td>
					<input type="text" value="CL-" id="prefijoNumContrato" readonly="readonly" size="3"/>
					
					<input type="text" onpaste="return false" name="strCodNumContrato" id="CodNumContrato" size="11" maxlength="9" onKeyPress="validaIngresoNumeroContrato();" onchange="formatoNumeroContrato(this.value);"/>
					
					<input type="text" value="<bean:write name="CargaRestitucionEquipoOutDTO" property="strFolioContrato"/>" id="sufijoNumContrato" readonly="readonly" maxlength="9" size="10"/>
				</td>
			</tr>
		
		</table>
		</td>
		
	</tr>
	
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Equipo Nuevo</td>
	</tr>
	
	<tr>
		<td colspan="4">
		
		<table width="100%">
			<tr>
				<td style="width: 10%"><b>Procedencia:</b></td>
				<td style="width: 20%" colspan="5">
					<html:radio styleId="radioInterno" value="I" property="strProcedencia" onclick="marcado=true">Interno</html:radio>
					<html:radio disabled="true" styleId="radioExterno" value="E" property="strProcedencia" onclick="marcado=true">Externo</html:radio>
				</td>
			</tr>
			
			<tr>
				<td style="width: 10%"><b>Tipo Contrato:</b></td>
				<td style="width: 20%">
								
				<logic:present name="CargaRestitucionEquipoOutDTO" property="contratoDTOs">
					 <bean:define name="CargaRestitucionEquipoOutDTO" property="contratoDTOs" id="contratoDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboTipoContrato" property="strCodTipContrato" style="width: 165px;" onchange="cargaComboModalidadPago(this.value);" >
						<html:option value=''>Seleccione Tipo Contrato</html:option> 
						<html:options collection="contratoDTOs" property="strCodTipContrato" labelProperty="strDesTipContrato"/>
					</html:select>
				</logic:present>
				
				</td>
				<td style="width: 10%"><b>Modalidad Pago:</b></td>
				<td style="width: 20%">	
					<html:select styleClass="comboBox" styleId="comboModalidadPago" property="strCodModPago" style="width: 200px;" onchange="cargaComboCuota(this.value);">
						<html:option value="select">Seleccione Modalidad de Pago</html:option> 
					</html:select>
				</td>
				<td style="width: 10%"><b>Cuotas:</b></td>
				<td style="width: 20%">		
					<html:select styleClass="comboBox" styleId="comboCoutas" property="strCodCuota" style="width: 230px;" >
						<html:option value=''>Seleccione Cuota</html:option> 
					</html:select>
				</td>
			</tr>
			<tr height="10">
			</tr>
			<tr>
				<td><b>Categor&iacute;a Tributaria:</b></td>
				<td>
				<logic:present name="CargaRestitucionEquipoOutDTO" property="catTributariaDTOs">
					 <bean:define name="CargaRestitucionEquipoOutDTO" property="catTributariaDTOs" id="catTributariaDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboCategoriaTriburaria" property="strCodCatTributaria" style="width: 230px;" >
						<html:option value=''>Seleccione la categoría</html:option> 
							<html:options collection="catTributariaDTOs" property="strCodCaTribut" labelProperty="strDesTipDocum" />
					</html:select>
				</logic:present>
				</td>
				<td><b>Mes Prorroga:</b></td>
				<td width="20%">
				<logic:present name="CargaRestitucionEquipoOutDTO" property="prorrogaDTOs">
					 <bean:define name="CargaRestitucionEquipoOutDTO" property="prorrogaDTOs" id="prorrogaDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboMesProrroga" property="strCodMesProrroga" style="width: 230px;" >
						<html:option value=''>Seleccione Tipo Contrato</html:option> 
							<html:options collection="prorrogaDTOs" property="intNumMeses" labelProperty="strDesProrroga" />
					</html:select>
				</logic:present>
				</td>
			</tr>
			
		</table>
		</td>
	</tr>
</table>


