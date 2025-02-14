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
	<logic:present name="CargaModificacionLimiteConsumoOutDTO" property="abonado">
		<bean:define name="CargaModificacionLimiteConsumoOutDTO" property="abonado" id="abonado"/>
	</logic:present>
	<logic:present name="CargaModificacionLimiteConsumoOutDTO" property="limiteConsumo">
		<bean:define name="CargaModificacionLimiteConsumoOutDTO" property="limiteConsumo" id="limiteConsumo"/>
	</logic:present>
	<logic:present name="CargaModificacionLimiteConsumoOutDTO" property="segmentacion">
		<bean:define name="CargaModificacionLimiteConsumoOutDTO" property="segmentacion" id="segmentacion"/>
	</logic:present>
	<logic:present name="CargaModificacionLimiteConsumoOutDTO" property="planTarifario">
		<bean:define name="CargaModificacionLimiteConsumoOutDTO" property="planTarifario" id="planTarifario"/>
	</logic:present>
	
	<html:hidden property="strRespContinuar" value=""/>
	
	<table width="100%" border="0">
	<tr>
		<td align="left" colspan="15" class="textoSubTitulo">Informaci&oacute;n de Atenci&oacute;n</td>
	</tr>
   
     <tr>
		<td colspan="15">
			<table>
				
				<tr>
					<td width="90"> <b>Abonado :</b></td>
					<logic:present name="abonado" property="lonNumAbonado">
					<td colspan="2"> <bean:write name="abonado" property="lonNumAbonado" /></td>
					</logic:present>
					<td colspan = "250"> </td>
					<td> <b>Celular</b>:</td>
					<logic:present name="abonado" property="lonNumCelular">
					<td colspan="2"> <bean:write name="abonado" property="lonNumCelular" /></td>
					</logic:present>

				</tr>
				
				<tr>
					<td></td>
				</tr>
				
				<tr>
					<td width="90"> <b>Tipo Plan :</b></td>
					<logic:present name="abonado" property="strTipPlanTarif">
					<td colspan="2"> <bean:write name="abonado" property="strTipPlanTarif" /></td>
					</logic:present>
					<td colspan = "250"> </td>
					<td width="110"> <b>Plan Tarifario:</b></td>
					<logic:present name="planTarifario" property="strDescPlanTarifario">
							<td width="400"> <bean:write name="planTarifario" property="strCodCargoBasico" /> - <bean:write name="planTarifario" property="strDescPlanTarifario" /></td>
					</logic:present>
				</tr>
				
				<tr>
					<td></td>
				</tr>
					
			</table>
			
			<table>
					<tr>
					<td width="90"> <b>Color :</b></td>
					<logic:present name="segmentacion" property="strCodColor">
					<td> <bean:write name="segmentacion" property="strCodColor" /></td>
					</logic:present>
					<td>-</td>
					<logic:present name="segmentacion" property="strDescColor">
					<td> <bean:write name="segmentacion" property="strDescColor" /></td>
					</logic:present>
				</tr>
				
				<tr>
					<td></td>
				</tr>
					
				<tr>
					<td width="90"> <b>Segmento :</b></td>
					<logic:present name="segmentacion" property="strCodSegmento">
					<td> <bean:write name="segmentacion" property="strCodSegmento" /></td>
					</logic:present>
					<td>-</td>
					<logic:present name="segmentacion" property="strDescSegmento">
					<td> <bean:write name="segmentacion" property="strDescSegmento" /></td>
					</logic:present>
				
				</tr>
				
				<tr>
					<td></td>
				</tr>
			
			</table>
			
			<table>
				<tr> 
					<td width="200"><b>L&iacute;mite de Consumo Actual :</b></td>
					<logic:present name="abonado" property="strCodLimConsumo">
							<td> <bean:write name="abonado" property="strCodLimConsumo" /></td>
					</logic:present>
					
					<logic:present name="limiteConsumo" property="strDescripcion">
						<td> <bean:write name="limiteConsumo" property="strDescripcion" /></td>
					</logic:present>
				</tr>
				
				<tr>
					<td></td>
				</tr>
				
				<tr>
					<td><b>Rango L&iacute;mite de Consumo :</b></td>
					<logic:present name="limiteConsumo" property="strDescMontMinMax">
						<td colspan ="2"> <bean:write name="limiteConsumo" property="strDescMontMinMax" /></td>
					</logic:present>
					<td colspan = "130"></td>
					<td> <b>Valor</b></td>
					<td><input type="text" onpaste="return false" name="strLimiteConsumo" id="limiteConsumo" size="20" onKeyPress="validaFormatoNumero(this,event);" onKeyUp="validarDecimales();" maxlength="15"/></td>
				</tr>
				
				<tr>
					<td></td>
				</tr>
				
			</table>
			
					
		
		</td>
     </tr>
     
     <tr>
		<td colspan="16">
			<table>
				<tr>
					<td width="110"> <b>Abono M&iacute;nimo :</b></td>
					<logic:present name="limiteConsumo" property="douMontoMinimo">
						<td colspan ="2"> <bean:write name="limiteConsumo" property="douMontoMinimo" /></td>
					</logic:present>
					<td colspan = "50"></td>
					<td width="130"> <b>Abono M&aacute;ximo :</b></td>
					<logic:present name="limiteConsumo" property="douMontoMaximo">
						<td colspan ="2"> <bean:write name="limiteConsumo" property="douMontoMaximo" /></td>
					</logic:present>
				</tr>
				
				<tr>
					<td></td>
				</tr>
				
				<tr>
					<td width="110"> <b>Fecha Desde :</b></td>
					<logic:present name="limiteConsumo" property="strFechaDesde">
						<td colspan ="2"> <bean:write name="limiteConsumo" property="strFechaDesde" /></td>
					</logic:present>
					<td colspan = "50"> </td>
					<td width="130"> <b>Fecha Expiraci&oacute;n :</b></td>
					<logic:present name="limiteConsumo" property="strFechaHasta">
						<td colspan ="2"> <bean:write name="limiteConsumo" property="strFechaHasta" /></td>
					</logic:present>
				</tr>
				
			</table>
			
		
			
			
			
					
		</td>
     </tr>
     <tr>
		<td colspan="15">&nbsp;</td>
	 </tr>
	 <tr>
    	<td>&nbsp;</td>
	 </tr>
  	 <tr>
    	<td>&nbsp;</td>
  	 </tr>
	</table>
	
	


	