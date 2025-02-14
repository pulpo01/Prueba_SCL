<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
	org.apache.commons.configuration.CompositeConfiguration config2;
	config2 = com.tmmas.cl.framework20.util.UtilProperty
			.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
	
	com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO tiendaVendedorOutDTO =(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO) session.getAttribute("tiendaVendedor");
%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-datos-venta").innerHTML;
    var indPago="<%=tiendaVendedorOutDTO.getIndApliPAgo().trim()%>";
    parent.copiarDatos(html,"dv-datos");  	
    parent.focoSerie();
 	if("1"==indPago)
 	parent.mostrarPago();
 	
    parent.gifCargando('unload');
}
</script>
<body>
<div id="dv-datos-venta">
<table width="100%" border="0" height="100%">
	<tr>
		<td width="138" align="left" valign="top"><img src="<%=contextPath%>/imagenes/fecha.JPG">CANTIDAD<input
			name="txtCantidad" type="text" size="3" id="txtCantidad" value="1"></td>
		<td width="842" align="left" valign="top"><img src="<%=contextPath%>/imagenes/fecha.JPG">SERIE <input
			name="txtSerie" type="text" size="19" id="txtSerie"
			onkeydown="pistolear(event.keyCode,document.getElementById('txtSerie').value,document.getElementById('txtCantidad').value);">
		<input type="image" name="agregarArticulo" src="<%=contextPath%>/imagenes/add.png"
			onclick="agregarArticulo(document.getElementById('txtSerie').value,document.getElementById('txtCantidad').value);" />
		<div id="dv-error-articulo"></div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" valign="top">
		<div id="grilla-lineas">
		<fieldset style="height:80px;"><legend>Lineas</legend>No ha ingresado lineas</fieldset>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" valign="top">
		<div id="grilla-kit"><fieldset style="height:80px;"><legend>Kit</legend>No ha ingresado kit</fieldset></div>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" valign="top">
		<div id="grilla-accesorios"><fieldset style="height:80px;"><legend>Accesorios</legend>No ha ingresado accesorios</fieldset></div>
		</td>
	</tr>
	
	<tr>
		<td>&nbsp;</td>
		<td align="right" valign="top">
		<table width="auto" border="1">
			<tr>
				<td>
					<table align="right">
						<tr>
							<!-- Inicio JLGN -->
							<td style="padding-right:0px; width:288px">
										<table border="1" align="right">
										<tr>
											<td style="width:auto; padding-left:0px; border=0px;"></td>
											<td class="totales" width="138px;">PLAN TARIFARIO</td>
											<td  align="left" width="150px;">
												<select name='cmbPlanTarifario' id="cmbPlanTarifario">
										   			<option value="Seleccione">Seleccione</option>
										   				<logic:iterate id="listaPT" name="planTarifario">
										                   <option value="<bean:write name="listaPT" property="codPlanTarif"/>"><bean:write name="listaPT" property="desPlanTarif" />
									                    </logic:iterate>
									            </select>
											</td>
										</tr>
										</table>
							</td>
							<!-- Fin JLGN -->
							<td style="padding-right:0px; width:288px">
										<table border="1" align="right">
										<tr>
											<td style="width:auto; padding-left:0px; border=0px;"></td>
											<td class="totales" width="138px;">TIPO DE PRESTACION</td>
											<td  align="left" width="150px;">
												<select name='tipos' id="cmbPrestaciones">
										   			<option value="Seleccione">Seleccione</option>
										   				<logic:iterate id="lista" name="prestaciones">
										                   <option value="<bean:write name="lista" property="codPrestacion"/>"><bean:write name="lista" property="desPrestacion" />
									                    </logic:iterate>
									            </select>
											</td>
										</tr>
										</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td width="336" align="left" valign="top">
				<table border="0" bordercolor="#848484">
					<tr>
						<td align="left" valign="top" class="totales"><div id="fP" style="display: none;">FORMA DE PAGO</div></td>
						<td align="left" valign="top" class="totales"><div id="fPC" style="display: none;"><select name="formasPago" id="formasPago"
							onchange="cambiarFormaPago(document.getElementById('formasPago').value);">
							<option value="seleccione">Seleccione</option>
							<logic:iterate id="listaTiposPago" name="tiposPago">
								<logic:notEqual name="listaTiposPago" property="descripcionTipValor" value="DOLARES">
									<option value="<bean:write name="listaTiposPago" property="tipValor"/>">
										<bean:write	name="listaTiposPago" property="descripcionTipValor" /></option>	
								</logic:notEqual>
						</logic:iterate>
						</select></div></td>
						<td align="left" valign="top" class="totales">
						<div id="<%=config2.getString("forma.pago.efectivo")%>" style="display: none;">
						<table>
							 
							<tr style='display:none;'>
								<td align="center" valign="top" class="totales">RECIBIDO</td>
								<td><input type="text" name="txtRecibido" id="txtRecibido" value="0" onblur="formatearRecibido();" onkeypress="soloNumeros(event.keyCode);" onkeyup="calcularVuelto();" /></td>
							</tr>
							<tr style='display:none;'>
								<td align="center" valign="top" class="totales">VUELTO</td>
								<td><input type="text" name="txtVuelto" id="txtVuelto" disabled="disabled" /></td>
							</tr>
						 	
						</table>
						</div>
						<div id="<%=config2.getString("forma.pago.cheque")%>" style="display: none;">
						<table>
							<tr>
								<td align="center" valign="top" class="totales">BANCO</td>
								<td><select name="bancosCheque" id="bancosCheque">
									<option value="seleccione" >Seleccione</option>
									<logic:iterate id="lista" name="bancos">
										<option value="<bean:write name="lista" property="codBanco"/>          
                        "><bean:write
											name="lista" property="desBanco" />
									</logic:iterate>
								</select></td>
							</tr>
							<tr>
								<td align="center" valign="top" class="totales">Nro. Cheque</td>
								<td><input name="txtNroCheque" type="text" size="15" id="txtNroCheque" value="0" onkeypress="soloNumeros(event.keyCode);"/></td>
							</tr>
							<tr>
								<td align="center" valign="top" class="totales">Cuenta Corriente</td>
								<td><input name="txtCtaCorriente" type="text" size="18" maxlength="18" id="txtCtaCorriente" onkeypress="soloNumeros(event.keyCode);"/></td>
							</tr>
						</table>
						</div>
						<div id="<%=config2.getString("forma.pago.credito")%>" style="display: none;">
						<table>
							<tr>
								<td align="center" valign="top" class="totales">TIPO</td>
								<td><select name="tarjetasCredito" id="tarjetasCredito">
									<option value="seleccione">Seleccione</option>
									<logic:iterate id="lista" name="tarjetas">
										<option value="<bean:write name="lista" property="codTarjeta"/>          
                        ">
										<bean:write name="lista" property="desTarjeta" />
									</logic:iterate>
								</select></td>
							</tr>
							<tr>
								<td align="center" valign="top" class="totales">Nro. Tarjeta</td>
								<td><input name="txtNroTarjeta" type="text" size="15" id="txtNroTarjeta" value="0" onkeypress="soloNumeros(event.keyCode);" /></td>
							</tr>
						</table>
						</div>
						<div id="<%=config2.getString("forma.pago.debito")%>" style="display: none;">
						<table>
							<tr>
								<td align="center" valign="top" class="totales">BANCO</td>
								<td><select name="bancosDebito" id="bancosDebito">
									<option value="seleccione">Seleccione</option>
									<logic:iterate id="lista" name="bancos">
										<option value="<bean:write name="lista" property="codBanco"/>"><bean:write
											name="lista" property="desBanco" />
									</logic:iterate>
								</select></td>
							</tr>
						</table>
						</div>
						</td>

                <td width="288" align="left" valign="top">
				<div id="grilla-totales">
				<table width="288" border="1" bordercolor="#848484">
					<tr>
						<td width="103" align="left" valign="top" class="totales">TOTAL NETO</td>
						<td align="right" valign="top" class="totales">:</td>
						<td width="70" align="right" valign="top"><bean:write name="totalVO" property="subTotalRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">I.T.B.M</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="itbmRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">I.S.C</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="iscRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">TOTAL</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="totalRound" /> <input type="hidden"
							name="hdnTotal" id="hdnTotal" value="<bean:write name="totalVO" property="totalRound" />"></td>
					</tr>
				</table>
				</div>
				</td>						
						
						
						
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td colspan="2" align="center" valign="top"><img src="<%=contextPath%>/imagenes/CONTINUAR.jpg"
			onclick="llamarFormCliente('<%=tiendaVendedorOutDTO.getIndApliPAgo().trim()%>');"></td>
	</tr>
</table>
</div>
</body>
</html>