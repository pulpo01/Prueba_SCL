<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>


	<div id="mensajes" style="display:none">
	<table width="100%" border="0" >
	  <tr>
	     <td class="mensajeError"><div id="textoerror" style="display:none;"></div></td>
	  </tr> 
	</table>
	</div>
	<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="abonado">
	<bean:define name="cargaAbonoLimiteConsumoOutDTO" property="abonado" id="abonado"/>
	</logic:present>
	<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="limiteConsumoUmbral">
	<bean:define name="cargaAbonoLimiteConsumoOutDTO" property="limiteConsumoUmbral" id="limiteConsumoUmbral"/>
	</logic:present>
	<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="limiteConsumoUtilizado">
	<bean:define name="cargaAbonoLimiteConsumoOutDTO" property="limiteConsumoUtilizado" id="limiteConsumoUtilizado"/>
	</logic:present>
	<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="strDescGrupoTecnologico">
	<bean:define name="cargaAbonoLimiteConsumoOutDTO" property="strDescGrupoTecnologico" id="descGrupoTecnologico"/>
	</logic:present>
	<logic:present name="cargaAbonoLimiteConsumoOutDTO" property="strDescSituacion">
	<bean:define name="cargaAbonoLimiteConsumoOutDTO" property="strDescSituacion" id="descSituacion"/>
	</logic:present>
		
	<table width="100%" border="0">
	<tr>
		<td align="left" colspan="4" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
	</tr>
   
     <tr>
		<td colspan="4">
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td width="115"> <b>Abonado :</td>
				<logic:present name="abonado" property="lonNumAbonado">
				<td colspan="2"> <bean:write name="abonado" property="lonNumAbonado" /></td>
				</logic:present>
				<logic:notPresent name="abonado" property="lonNumAbonado">
				<td colspan="2">&nbsp;</td>
				</logic:notPresent>
			</tr>
			<tr>
				<td width="115"> <b>Celular :</td>
				<logic:present name="abonado" property="lonNumCelular">
				<td colspan="2"> <bean:write name="abonado" property="lonNumCelular" /></td>
				</logic:present>
				<logic:notPresent name="abonado" property="lonNumCelular">
				<td colspan="2">&nbsp;</td>
				</logic:notPresent>
			</tr>
			<tr>
				<td width="115"> <b>Equipo :</td>
				<logic:present name="abonado" property="strNumSerie">
				<td colspan="2"> <bean:write name="abonado" property="strNumSerie" /></td>
				</logic:present>
				<logic:notPresent name="abonado" property="strNumSerie">
				<td colspan="2">&nbsp;</td>
				</logic:notPresent>
			</tr>
			<tr>
				<td width="115"> <b>Tecnolog&iacute;a :</td>
				<logic:present name="abonado" property="strCodTecnologia">
				<td> <bean:write name="abonado" property="strCodTecnologia" /></td>
				</logic:present>
				<logic:notPresent name="abonado" property="strCodTecnologia">
				<td>&nbsp;</td>
				</logic:notPresent>
				<logic:present name="descGrupoTecnologico">
				<td> <bean:write name="descGrupoTecnologico" /></td>
				</logic:present>
				<logic:notPresent name="descGrupoTecnologico">
				<td>&nbsp;</td>
				</logic:notPresent>
			</tr>
			<tr>
				<td width="115"> <b>Situaci&oacute;n :</td>
				<logic:present name="abonado" property="strCodSituacion">
				<td><bean:write name="abonado" property="strCodSituacion" /></td>
				</logic:present>
				<logic:notPresent name="abonado" property="strCodSituacion">
				<td>&nbsp;</td>
				</logic:notPresent>
				<logic:present name="descSituacion">
				<td><bean:write name="descSituacion" /></td>
				</logic:present>
				<logic:notPresent name="descSituacion">
				<td>&nbsp;</td>
				</logic:notPresent>
			</tr>
			</table>		
		
		</td>
     </tr>
     
     <tr>
		<td colspan="4">
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td> <b>Limite de Consumo Actual :</td>
			</tr>
			</table>
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<logic:present name="limiteConsumoUmbral" property="strCodLimiteConsumo">
				<td width="100"><bean:write name="limiteConsumoUmbral" property="strCodLimiteConsumo" /></td>
				</logic:present>
				<logic:notPresent name="limiteConsumoUmbral" property="strCodLimiteConsumo">
				<td width="100">&nbsp;</td>
				</logic:notPresent>
				<logic:present name="limiteConsumoUmbral" property="strDescLimiteConsumo">
				<td><bean:write name="limiteConsumoUmbral" property="strDescLimiteConsumo" /></td>
				</logic:present>
				<logic:notPresent name="limiteConsumoUmbral" property="strDescLimiteConsumo">
				<td>&nbsp;</td>
				</logic:notPresent>
			</tr>
			</table>
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td> <b>Umbral del L&iacute;mite de Consumo :</td>
			</tr>
			</table>
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<logic:present name="limiteConsumoUmbral" property="strCodigoUmbral">
				<td width="100"><bean:write name="limiteConsumoUmbral" property="strCodigoUmbral" /></td>
				</logic:present>
				<logic:notPresent name="limiteConsumoUmbral" property="strCodigoUmbral">
				<td width="100">&nbsp;</td>
				</logic:notPresent>
				<logic:present name="limiteConsumoUmbral" property="strDescUmbral">
				<td><bean:write name="limiteConsumoUmbral" property="strDescUmbral" /></td>
				</logic:present>
				<logic:notPresent name="limiteConsumoUmbral" property="strDescUmbral">
				<td>&nbsp;</td>
				</logic:notPresent>				
			</tr>
			</table>
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td> <b>Nivel de consumo :</td>
			</tr>
			</table>
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<logic:present name="limiteConsumoUtilizado" property="douMonto">
				<logic:equal name="limiteConsumoUtilizado" property="douMonto" value="0">
				<td>No existe Consumo</td>
				</logic:equal>
				<logic:notEqual name="limiteConsumoUtilizado" property="douMonto" value="0">
				<td><bean:write name="limiteConsumoUtilizado" property="douMonto" /></td>					
				</logic:notEqual>
				</logic:present>
				<logic:notPresent name="limiteConsumoUtilizado" property="douMonto">
				<td>No existe Consumo</td>
				</logic:notPresent>
			</tr>
			</table>		
		
		</td>
     </tr>
     <tr>
		<td colspan="4">&nbsp;</td>
	 </tr>
	 <tr>
		<td align="left" colspan="4" class="textoSubTitulo">Ingresar Abono</td>
	 </tr>
	 <tr>
		<td colspan="4">
			<table width="100%" cellpadding="2" cellspacing="2" align=center>
			<tr>
				<td width="100"> <b>ABONO :</b></td>
				<td><input type="text" onpaste="return false" name="abono" id="abono" onKeyPress="validaFormatoNumero(this,event);" onKeyUp="validarDecimales();" maxlength="15"/></td>
			</tr>
			</table>
		</td>
	</tr>
	</table>


	