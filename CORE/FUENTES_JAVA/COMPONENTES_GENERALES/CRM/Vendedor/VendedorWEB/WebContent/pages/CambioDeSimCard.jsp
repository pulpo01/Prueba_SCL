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

	<input type="hidden" id="num_abonado" name="num_abonado" value="<c:out value="${ClienteOOSS.numAbonado}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${ClienteOOSS.usuario}"/>"/>
 	<input type="hidden" id="codTipContrato" name="codTipContrato" value="<c:out value="${usuarioAbonado.codTipContrato} "/>"/>
	<input type="hidden" id="des_tipcontrato" name="des_tipcontrato" value="<c:out value="${usuarioAbonado.des_tipcontrato}"/>"/>

	<input type="hidden" id="cod_vendedor" name="cod_vendedor" value="<c:out value="${usuarioSistema.cod_vendedor}"/>"/>
	<input type="hidden" id="cod_cliente" name="cod_cliente" value="<c:out value="${usuarioAbonado.cod_cliente}"/>"/>
	<input type="hidden" id="cod_tecnologia" name="cod_tecnologia" value="<c:out value="${usuarioAbonado.cod_tecnologia}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${usuarioSistema.nom_usuario}"/>"/>
	<input type="hidden" id="cod_tipcomis" name="cod_tipcomis" value="<c:out value="${usuarioSistema.cod_tipcomis}"/>"/>	
	<input type="hidden" id="cod_ooss" name="cod_ooss" value="<c:out value="${ClienteOOSS.codOrdenServicio}"/>"/>	

	<html:hidden property="cod_bodega"/>	
	<html:hidden property="cod_articulo"/>	
	<html:hidden property="tip_stock"/>		
	
	<input type="hidden" id="condicionError" name="condicionError" value=""/>	
	<input type="hidden" id="mensajeError" name="mensajeError" value=""/>	
	<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value=""/>		
	
	<!--  Este flag impide ejecutar el mismo proceso asincronico hasta que se ejecute su metodo de callback --> 
	<input type="hidden" id="flagT" name="flagT" value="0"/>
	<!--  flag de estado de bloqueo de serie --> 
	<input type="hidden" id="flagBloqueo" name="flagBloqueo"/>
 
	<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">SimCard Nueva</td>
	</tr>

	<tr>
		<td> 	
			<table width="100%">
				<tr>
					<td width="120">Causa de cambio</td>
					<td>
						<html:select tabindex="1"  size="1" property="causaCambio"  onchange="cargaComboModalidadPago(this.value, 'cambioSimcard');" >
							<option value="">
							<logic:iterate name="causaCambioLista" id="causaCambio" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO">
									<html:option value="<%= String.valueOf(causaCambio.getCod_caucaser())%>"><bean:write name="causaCambio" property="des_caucaser"/></html:option>
							</logic:iterate>
						</html:select>

<!--  					----------- SELECCION DE EQUIPO -----------		-->

					<td width="450" rowspan="5">
						<font class="textoSubTitulo"><img src="img/black_arrow.gif"> Seleccionar SimCard</font>
						
						<br><br>
						<table border=0 cellspacing=0 cellpadding=0  width="350">
						<tr height="25">
							<td align="right"> Nro.de Serie  &nbsp;</td>
							<td> 
								<html:text  tabindex="7" property="nroSerie" size="30" maxlength="30" onkeypress="if (window.event.keyCode==13) window.event.keyCode=0;"/>
							</td>
						</tr>	
						
						<tr height="25">
							<td align="right"> Uso   &nbsp;</td>
							<td>							
								<html:select  tabindex="8" size="1" property="usoVenta" disabled="false">
									<option value="">
									<logic:iterate name="usosLista" id="uso" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO">
											<html:option value="<%= String.valueOf(uso.getCod_uso())%>"><bean:write name="uso" property="des_uso"/></html:option>
									</logic:iterate>
								</html:select>
							</td>
						</tr>	
						
						<tr height="25">
						    <td align="center" colspan=2>
								<img style="cursor: pointer;" src="botones/btn_bloquear.gif" name="bloquear" border="0" id="bloquear"  alt="bloquear"
								onmouseover="sobreElBoton('bloquear','botones/btn_bloquear_roll.gif')" onMouseOut="sobreElBoton('bloquear','botones/btn_bloquear.gif')" onclick="bloquearSerie('bloquear');" />
								 <img src="botones/btn_desbloquear.gif" name="desbloquear" border="0" id="desbloquear" 
								onmouseover="sobreElBoton('desbloquear','botones/btn_desbloquear_roll.gif')" onMouseOut="sobreElBoton('desbloquear','botones/btn_desbloquear.gif')" onclick="bloquearSerie('desbloquear');" />
							</td>
						</tr>	
						</table>
					</td>
					
<!--  					---------------------------------------------------  -->						
				</tr>	
			
				<tr>
					<td> Tipo de contrato</td>
					<td>
						<html:select  tabindex="2" property="tipoContrato" size="1">
							<option value="">
							<logic:iterate name="tiposContratoLista" id="contrato" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO">
									<html:option value="<%= String.valueOf(contrato.getCod_tipcontrato())%>"><bean:write name="contrato" property="des_tipcontrato"/></html:option>
							</logic:iterate>
						</html:select>
					</td>
				</tr>	
				
				<tr>
					<td> Modalidad de venta</td>
					<td>
						<table cellspacing="0" cellpadding="0">
						<tr height="25">
							<td> 
							<html:select tabindex="3" property="modalidadPago" size="1"  onchange="cargaComboCuotas(this.value);">
									<option value="">						
								</html:select>
							</td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td>
								<div id="comboCuotas" style="display:none;">
									<table>
									<tr>
										<td> Cuotas  &nbsp;&nbsp;</td>
									 	<td>
											<html:select property="cuotas" size="1" tabindex="4">
												<option value="">									
											</html:select>
										</td>			
										
										<td>&nbsp;&nbsp;&nbsp;</td>

									<div id="radioabonoDiferido" style="display:NONE;">												
										<td> 
											Abono diferido &nbsp;&nbsp;
											<html:radio onclick="abono()" value="SI" property="abonoDiferido"  tabindex="5" /> Si
											&nbsp;&nbsp;
											<html:radio onclick="abono()" value="NO" property="abonoDiferido"  tabindex="6" /> No
										</td>
									</div>										
									</tr>
									</table>	
								</div>
							</td>					
						</tr>
						</table>	
					</td>
				</tr>	
					
				<tr>
					<td> Tipo de Terminal</td>
					<td>
						<html:select  tabindex="9"  property="tipoTerminal" size="1">
							<option value="">
							<logic:iterate name="terminalesLista" id="terminal" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO">
									<html:option value="<%= String.valueOf(terminal.getTip_terminal())%>"><bean:write name="terminal" property="des_terminal"/></html:option>
							</logic:iterate>
						</html:select>
					</td>
				</tr>	
			
			</table>
		</td>
	</tr>	
	</table>
	
	<br>



<!-- ---------------------------------------------------------------------------------------------- -->

