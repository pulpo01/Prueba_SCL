<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles"%>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested"%>


<div id="mensajes" style="display: none">

<input type="hidden" id="nombreUsuario" value="<bean:write name="UserName"/>"/>	
<input type="hidden" id="numeroAbonado" value="<bean:write name="NumAbonado"/>"/>
<input type="hidden" id="codModVenta" value="<bean:write name="StrCodModPago"/>"/>
<input type="hidden" id="codTipContrato" value="<bean:write name="StrCodTipContrato"/>"/>
<input type="hidden" id="numSiniestro" value="<bean:write name="NumSiniestro"/>"/>
<input type="hidden" id="strNumSerie" value=""/>
	

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
				<td height="60"></td>
			</tr>
			<tr>
				<td><b>Uso:</b></td>
				<td colspan="150">
				<logic:present name="CargaSeleccionEquipoOutDTO" property="usoDTOs">
					 <bean:define name="CargaSeleccionEquipoOutDTO" property="usoDTOs" id="usoDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboUso" property="intCodUso" onchange="validaSeleccionCombos();" >
						<html:option value=''>Seleccione el Uso</html:option> 
							<html:options collection="usoDTOs" property="intCodUso" labelProperty="strDesUso" />
					</html:select>
				</logic:present>
				</td>
				<td><b>Art&iacute;culo:</b></td>
				<td>
				<logic:present name="CargaSeleccionEquipoOutDTO" property="articuloDTOs">
					 <bean:define name="CargaSeleccionEquipoOutDTO" property="articuloDTOs" id="articuloDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboArticulo" property="intCodArticulo" onchange="validaSeleccionCombos();">
						<html:option value=''>Seleccione un Articulo</html:option> 
							<html:options collection="articuloDTOs" property="intCodArticulo" labelProperty="strDesArticulo" />
					</html:select>
				</logic:present>
				</td>
			</tr>
			
			<tr height="10">
			</tr>
			
			<tr>
				<td><b>Bodega:</b></td>
				<td colspan="150">
				<logic:present name="CargaSeleccionEquipoOutDTO" property="bodegaDTOs">
					 <bean:define name="CargaSeleccionEquipoOutDTO" property="bodegaDTOs" id="bodegaDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboBodega" property="intCodBodega" onchange="validaSeleccionCombos();">
						<html:option value=''>Seleccione una Bodega</html:option> 
							<html:options collection="bodegaDTOs" property="intCodBodega" labelProperty="strDesBodega" />
					</html:select>
				</logic:present>
				</td>
				<td><b>Estado:</b></td>
				<td>
				<logic:present name="CargaSeleccionEquipoOutDTO" property="estadoDTOs">
					 <bean:define name="CargaSeleccionEquipoOutDTO" property="estadoDTOs" id="estadoDTOs"/>			
					<html:select styleClass="comboBox" styleId="comboEstado" property="intCodEstado" onchange="validaSeleccionCombos();" >
						<html:option value=''>Seleccione un Estado</html:option> 
							<html:options collection="estadoDTOs" property="intCodEstado" labelProperty="strDesEstado" />
					</html:select>
				</logic:present>
				</td>
			</tr>
			<tr>
				<td height="40"></td>
			</tr>
		
		</table>
		</td>
	</tr>
	
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Informaci&oacute;n
		de Equipo</td>
	</tr>
	
	<tr>
		<td>
			<table width="680px" border="0" Style='margin-left:340px'>
				<tr>
					<td width="16px" class="barraarriba"></td>
					<td width="80px" class="barraarriba">Tipo Stock</td>
					<td width="90px" class="barraarriba">Núm. Serie</td>
					<td width="120px" class="barraarriba">Núm. Serie Mecánico</td>
					<td width="80px" class="barraarriba">Terminal</td>
				</tr>
			</table>
		</td>
	</tr>		
	<tr>
		<td>
			<div id="listaEquipos"  Style="overflow:auto; height:100px;width: 1020px"></div>
			
		</td>
	</tr>
	
</table>


