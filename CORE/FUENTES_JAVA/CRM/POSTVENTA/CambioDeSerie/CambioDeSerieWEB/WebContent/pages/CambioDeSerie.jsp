<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

	<c:set var="codigoPrograma" value="${requestScope.codigoPrograma}"/> 
	<c:set var="versionPrograma" value="${requestScope.versionPrograma}" />

	<input type="hidden" id="btnSeleccionado" name="btnSeleccionado"/>
	<input type="hidden" id="showVendedor" name="showVendedor" value="<c:out value="${requestScope.showVendedor}"/>"/>	
	<input type="hidden" id="num_abonado" name="num_abonado" value="<c:out value="${ClienteOOSS.numAbonado}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${ClienteOOSS.usuario}"/>"/>
 	<input type="hidden" id="codTipContrato" name="codTipContrato" value="<c:out value="${usuarioAbonado.codTipContrato} "/>"/>
	<input type="hidden" id="des_tipcontrato" name="des_tipcontrato" value="<c:out value="${usuarioAbonado.des_tipcontrato}"/>"/>
	<input type="hidden" id="tipTerminalSimcard" name="tipTerminalSimcard" value="${requestScope.tipTerminalSimcard}"/>	
	<input type="hidden" id="condicionError" name="condicionError" value=""/>	
	<input type="hidden" id="numMeses" name="numMeses" value="${requestScope.numMeses}"/>	
	<input type="hidden" id="grupoTecnoGSM" name="grupoTecnoGSM" value="<c:out value="${requestScope.grupoTecnoGSM}"/>"/>
	<input type="hidden" id="mensajeError" name="mensajeError" value=""/>	
	<input type="hidden" id="mensajeStackTrace" name="mensajeStackTrace" value=""/>
	<input type="hidden" id="contextpathCSerie" name="contextpathCSerie" value="<c:out value="${pageContext.request.contextPath}"/>"/>
	
	<!--  INICIO 177697 PAH -->
	<input type="hidden" id="usoVentaEquip" name="usoVentaEquip" value="<c:out value="${ClienteOOSS.abonados[0].codUso}"/>"/>
	<!--  FIN 177697 PAH -->
	
	<!--  Este flag impide ejecutar el mismo proceso asincronico hasta que se ejecute su metodo de callback --> 
	<input type="hidden" id="flagT" name="flagT" value="0"/>
	<!--  flag de estado de bloqueo de serie --> 
	<input type="hidden" id="flagBloqueo" name="flagBloqueo"/>
	<input type="hidden" id="flagBloqueoEquipo" name="flagBloqueoEquipo"/>
	<input type="hidden" id="flagBloqueoEquipoEx" name="flagBloqueoEquipoEx"/>

	<!--  Para ver si se debe habilitar el bloqueo de simcard  -->
	<input type="hidden" id="habilitaSimcard" name="habilitaSimcard"/>
	
	<input type="hidden" id="cod_vendedor" name="cod_vendedor" value="<c:out value="${usuarioSistema.cod_vendedor}"/>"/>
	<input type="hidden" id="cod_cliente" name="cod_cliente" value="<c:out value="${usuarioAbonado.cod_cliente}"/>"/>
	<input type="hidden" id="cod_tecnologia" name="cod_tecnologia" value="<c:out value="${usuarioAbonado.cod_tecnologia}"/>"/>
	<input type="hidden" id="nom_usuario" name="nom_usuario" value="<c:out value="${usuarioSistema.nom_usuario}"/>"/>
	<input type="hidden" id="cod_tipcomis" name="cod_tipcomis" value="<c:out value="${usuarioSistema.cod_tipcomis}"/>"/>	
	<input type="hidden" id="cod_ooss" name="cod_ooss" value="<c:out value="${ClienteOOSS.codOrdenServicio}"/>"/>	
	<input type="hidden" id="numTransaccionBloqDes" name="numTransaccionBloqDes"/>
	<input type="hidden" id="numMesesProrrg" name="numMesesProrrg"/>
	<input type="hidden" id="codArticuloTerminal" name="codArticuloTerminal"/>
	<input type="hidden" id="numTransBloqDesSerie"  name="numTransBloqDesSerie"/>
	<input type="hidden" id="numTransBloqDesEquipo" name="numTransBloqDesEquipo"/>
	<input type="hidden" id=descripcionEquipo name="descripcionEquipo"/>
	<input type="hidden" id=nroSerieEquipExMec name="nroSerieEquipExMec"/>
	<input type="hidden" id="codArticuloEx" name="codArticuloEx" value="<c:out value="${codArticuloEx}"/>"/>
	<input type="hidden" id="codArticulo" name="codArticulo" value="<c:out value="${codArticulo}"/>"/>
	
	

	

	<html:hidden property="cod_bodega"/>	
	<html:hidden property="cod_articulo"/>	
	<html:hidden property="tip_stock"/>		
	
	<!--  Este flag impide ejecutar el mismo proceso asincronico hasta que se ejecute su metodo de callback --> 
	<input type="hidden" id="flagT" name="flagT" value="0"/>
	
	
 
	<table width="100%">
	<tr>
	<td>
	
	<table width="100%">
	<tr height="30">
		<td class="textoSubTitulo">Equipo Nuevo</td>
	</tr>
	<tr align=top>
		<td width="450"> 
			<table width="450">
			<tr> 
				<td colspan=2>Procedencia nuevo equipo</td>
			</tr> 
			<tr> 
				<td>
					<table>
					<tr id="btn"> 
						<td> <html:radio  onclick="window.document.CambioDeSerieForm.procEquipoNuevo.value='I';cargaComboTiposContrato('I');evaluaEquipo(this.value);" property="procedNuevoEquipo" value="I"/>Interno</td>
						<td> <html:radio onclick="window.document.CambioDeSerieForm.procEquipoNuevo.value='E';cargaComboTiposContrato('E');evaluaEquipo(this.value);" property="procedNuevoEquipo" value="E"/>Externo</td>
						<td> 
							<div id="radioSubsidiado" style="display:NONE;">		
								<html:radio  property="procedNuevoEquipo" value="S"/>Subsidiado
							</div>
						</td>
					</tr> 
					</table>
				</td>
				
				<td align=center> 
					<div id="radioabonoDiferido" style="display:NONE;">		
					<table>
					<tr> 
						<td> 
							Abono diferido &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<html:radio onclick="abono()" value="SI" property="abonoDiferido"/> Si
							&nbsp;&nbsp;
							<html:radio onclick="abono()" value="NO" property="abonoDiferido"/> No
						</td>
					</tr> 
					</table>
					</div>
				</td>
			</tr> 
			</table>
		</td>
	</tr>

	<tr>
		<td> 	
			<table width="100%">
				<tr>
					<td width="160">Causa de cambio</td>
					<td>
						<html:select size="1" property="causaCambio"  onchange="cargaComboModalidadPago(this.value, 'cambioSerie', window.document.CambioDeSerieForm.procEquipoNuevo.value);">
							<option value="">
							<logic:iterate name="causaCambioLista" id="causaCambio" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO">
									<html:option value="<%= String.valueOf(causaCambio.getCod_caucaser())%>"><bean:write name="causaCambio" property="des_caucaser"/></html:option>
							</logic:iterate>
						</html:select>
				</tr>	
			
				<tr>
					<td> Tipo de contrato</td>
					<td>
						<html:select property="tipoContrato" size="1"  onchange="valoresDefectoMesesProrrogaCliente(this.value);">
							<option value="">
							<logic:iterate name="tiposContratoLista" id="contrato" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO">
									<html:option value="<%= String.valueOf(contrato.getCod_tipcontrato())%>"><bean:write name="contrato" property="des_tipcontrato"/></html:option>
							</logic:iterate>
						</html:select>
					</td>
				</tr>	
				
				<tr>
					<td> Modalidad de pago</td>
					<td>
						<table cellspacing="0" cellpadding="0">
						<tr height="25">
							<td> 
							<html:select property="modalidadPago" size="1"  onchange="cargaComboCuotas(this.value);"  disabled="true">
									<option value="">						
								</html:select>
							</td>
							<td>&nbsp;&nbsp;&nbsp;</td>
							<td>
								<div id="comboCuotas" style="display:none;">
									<table>
									<tr>
										<td> Cuotas</td>
									 	<td>
											<html:select property="cuotas" size="1">
												<option value="">									
											</html:select>
										</td>					
									</tr>
									</table>	
								</div>
							</td>					
						</tr>
						</table>	
					</td>
				</tr>	
				
				<div id="comboTecnologia" style="display:NONE;">
				<tr>
					<td> Tecnolog&iacute;a</td>
					<td>
						<html:select property="tecnologia" size="1" onchange="cargaComboTipoTerminal(this.value);validaCambioTecnologia(this.value);">
							<option value="">
							<logic:iterate name="tecnologiasLista" id="tecnologia" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO">
									<html:option value="<%= String.valueOf(tecnologia.getCod_tecnologia())%>"><bean:write name="tecnologia" property="des_tecnologia"/></html:option>
							</logic:iterate>
						</html:select>

					</td>
					
				</tr>	
				</div>
					
				<tr>
					<td> Tipo de Terminal</td>
					<td>
						<html:select property="tipoTerminal" size="1">
							<option value="">						
						</html:select>

					</td>
				</tr>	
				
				<tr>
					<td> Meses de prorroga
					<td>
						<html:select property="mesesProrroga" size="1" disabled="true">
							<option value="">
							<logic:iterate name="mesesLista" id="mes" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO">
									<html:option value="<%= String.valueOf(mes.getNum_meses())%>"><bean:write name="mes" property="des_prorroga"/></html:option>
							</logic:iterate>
						</html:select>
					
					</td>
				</tr>	
			</table>
		</td>
	</tr>	
	
	<tr>
		<td>
			<div id="comboCargaTributaria" style="display:inline;">
				<table width="100%">
				<tr>
					<td colspan=2 class="textoSubTitulo"> <br>N&uacutemero de Contrato (Formato CL-999999999-99-00000)</td>
				<tr>
					<td> <br>Nro.Contrato  &nbsp; &nbsp; &nbsp;
						<html:text readonly="true" property="nroContratoParte1" size="3" maxlength="3"/>
						<html:text readonly="true" property="nroContratoParte2" size="12" maxlength="10"/>
						<html:text readonly="true" property="nroContratoParte3" size="8" maxlength="10"/>				
					</td>
				</tr>
				</table>	
			</div>
		</td>
	</tr>
	</table>
	</td>
		
	<td width="50">&nbsp;</td>
	
	<td width="550">
	<!--  					----------- SELECCION DE EQUIPO -----------		-->
		<font class="textoSubTitulo"><img src="img/black_arrow.gif"> <a href="#"  class="textoSubTitulo"><font  class="textoSubTitulo"id="titEquipo" >Seleccionar Equipo</font></a></font>
		
		<br><br>
		<table border=0 cellspacing=0 cellpadding=0>
		<tr><td>
		<!--div id="selEquipo" style="display: inline;"-->
		<table border="0" cellspacing="0" cellpadding="0" width="100%">
		<!-- INICIO 177697 PAH -->
		<!--<tr height="25">-->
			<!--<td align="left" width="100" colspan="2">  Uso   &nbsp;</td>-->
		<!--</tr>-->
		<!--<tr height="25">-->
			<!--<td colspan="2">-->
			    <!-- html:select  tabindex="8" size="1" property="usoVentaEquip" disabled="false" -->
				<!--<html:select  tabindex="8" size="1" property="usoVentaEquip">-->
					<!--<option value="">-->
					<!--<logic:iterate name="usosLista" id="uso" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO">-->
						<!--<html:option value="<%= String.valueOf(uso.getCod_uso())%>"><bean:write name="uso" property="des_uso"/></html:option>-->
					<!--</logic:iterate>-->
				<!--</html:select>-->
			<!--</td>-->
		<!--</tr>-->
		<!-- FIN 177697 PAH -->
		<!-- MODIFICADO POR SANTIAGO -->		
		<tr height="25">			
			<td align="left" width="100" colspan="2"> Nro.de Serie  &nbsp;</td>			
		</tr>
    	<tr height="25">			
			<td height="25" align="left" colspan="2">
        		<div id="divLnkSelSerie" style="display: inline;">
					<a href="javascript:fncBuscarSerie('<%=request.getContextPath()%>/BuscaSeriesAction.do?opcion=inicioEquipo');"><font color="#0000ff">Buscar Serie</font></a>
				</div>				         
	   		</td>   		
		</tr>		
		<tr>
			<td colspan="2"><html:text id="nroSerieEquip" tabindex="7" property="nroSerieEquip" size="30" maxlength="30" onblur="validaSerieElectronica(this.value)"/>&nbsp;</td>                            
     	</tr>
	
		<!-- MODIFICADO POR SANTIAGO FIN -->
		</table>
		
		<div id="selEquipoExterno" style="display: inline;">
		<table border=0 cellspacing=0 cellpadding=0>
		
		<tr height="25">
			<td align="right" width="100"> Artículos  &nbsp;</td>
			<td> 
				<html:select property="articulos" size="1"  onchange="getFabricante(this.value);">
					<option value="">						
				</html:select>
			</td>	
		</tr>	
		<tr height="25">
			<td align="right"> Fabricante  &nbsp;</td>
			<td> 
				<html:text  tabindex="7" property="desFabricante" size="30" maxlength="30" readonly="true"/>
			</td>
		</tr>
		
		<tr height="25">
			<td align="right"> Modelo  &nbsp;</td>
			<td> 
				<html:text  tabindex="7" property="modelo" size="30" maxlength="30" readonly="true"/>
			</td>

		</tr>	
		
	
		
		<tr height="25">
		    <td align="center" colspan=2>
				<img style="cursor: pointer;" src="botones/btn_aceptar.gif" name="aceptar" border="0" id="aceptar"  alt="aceptar"
				onmouseover="sobreElBoton('aceptar','botones/btn_aceptar_roll.gif')" onMouseOut="sobreElBoton('aceptar','botones/btn_aceptar.gif')" onclick="validaSerieExterna('bloquearEx', 'nroSerieEquip', 'usoVentaEquip', 'equipo');" />
				  <!-- INC-70904; COL; 19-01-2009; AVC-->
				<img style="cursor: pointer;" src="botones/btn_cancelar.gif" name="cancelar" border="0" id="cancelar"  alt="cancelar"
				onmouseover="sobreElBoton('cancelar','botones/btn_cancelar_roll.gif')" onMouseOut="sobreElBoton('cancelar','botones/btn_cancelar.gif')" onclick="habilitaControlesExterno();document.getElementById('flagBloqueoEquipoEx').value=0" /></td>
			<td align="center" colspan=2>				  
			</td>
			
		</tr>	
		</table>
		</div>
		</td></tr>
		</table>
		
		
		<div id="selEquipo" style="display: inline;">
		<table border=0 cellspacing=0 cellpadding=0>
		<tr height="25">
		    <td align="center" colspan=2>
				<img style="cursor: pointer;" src="botones/btn_bloquear.gif" name="bloquear" border="0" id="bloquear"  alt="reservar"
				onmouseover="sobreElBoton('bloquear','botones/btn_bloquear_roll.gif')" onMouseOut="sobreElBoton('bloquear','botones/btn_bloquear.gif')" onclick="bloquearSerie('bloquear', 'nroSerieEquip', 'usoVentaEquip', 'equipo');" />
				 <img src="botones/btn_desbloquear.gif" name="desbloquear" border="0" id="desbloquear" lt="cancelar"
				onmouseover="sobreElBoton('desbloquear','botones/btn_desbloquear_roll.gif')" onMouseOut="sobreElBoton('desbloquear','botones/btn_desbloquear.gif')" onclick="bloquearSerie('desbloquear', 'nroSerieEquip', 'usoVentaEquip', 'equipo');" />
			</td>
		</tr>	
		</table>
		</div>
	
	
		<!-- ----------------------------------------------------------------------------------------------------- -->
		
		<!-- ----------------------------------------------------------------------------------------------------- -->		
	
	
		<div id="titSimcard" style="display: inline;>
		<br><br>			
		<font class="textoSubTitulo"><img src="img/black_arrow.gif"> <a href="#" class="textoSubTitulo"><font  class="textoSubTitulo" id="titSimcard" style="display: inline;">Seleccionar Simcard</font></a></font>
		<br><br>
		</div>
		<div id="selSimcard" style="display: inline;">
		<table border=0 cellspacing=0 cellpadding=0>
		<tr height="25">
			<td align="right"> Nro.de Serie  &nbsp;</td>
			<td> 
				<html:text   tabindex="7" property="nroSerieSim" size="30" maxlength="30"  onchange="limpiarCajasBoqueoSerieSimcard(); cargaComboCentralHlr(this.value);" onkeypress="if (window.event.keyCode==13) window.event.keyCode=0;"/>
			</td>

			<td width=15 rowspan="3">&nbsp;</td>
			
			<td align="right"> Central   &nbsp;</td>
			<td> 
				<html:select property="central" size="1"  onchange="cargaValorHlr(this.value);">
					<option value="">						
				</html:select>
			</td>	
		</tr>	
		
		<tr height="25">
			<td align="right"> Uso   &nbsp;</td>
			<td>							
				<html:select  tabindex="8" size="1" property="usoVentaSim" disabled="false">
					<option value="">
					<logic:iterate name="usosLista" id="uso" scope="request" type="com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO">
							<html:option value="<%= String.valueOf(uso.getCod_uso())%>"><bean:write name="uso" property="des_uso"/></html:option>
					</logic:iterate>
				</html:select>
			</td>
			
			<td align="right"> HLR  &nbsp;</td>
			<td> 
				<html:text  tabindex="7" property="hlr" size="30" maxlength="30" readonly="true"/>
			</td>
		</tr>	
		
		<tr height="25">
		    <td align="center" colspan=6>
				<img style="cursor: pointer;" src="botones/btn_bloquear.gif" name="bloquear" border="0" id="bloquear"  alt="bloquear"
				onmouseover="sobreElBoton('bloquear','botones/btn_bloquear_roll.gif')" onMouseOut="sobreElBoton('bloquear','botones/btn_bloquear.gif')" onclick="bloquearSerie('bloquear','nroSerieSim', 'usoVentaSim', 'simcard');" />
				 <img src="botones/btn_desbloquear.gif" name="desbloquear" border="0" id="desbloquear" 
				onmouseover="sobreElBoton('desbloquear','botones/btn_desbloquear_roll.gif')" onMouseOut="sobreElBoton('desbloquear','botones/btn_desbloquear.gif')" onclick="bloquearSerie('desbloquear','nroSerieSim', 'usoVentaSim', 'simcard');" />
			</td>
		</tr>	
		</table>						
	</td>
	</div>

	</td>
	
	<!--  columna de relleno vertical -->
	<td width="500"></td>

	</tr>	
	</table>						
	<input type="hidden" id="procEquipoNuevo" name="procEquipoNuevo" value="I"/>
		
<!-- ---------------------------------------------------------------------------------------------- -->

