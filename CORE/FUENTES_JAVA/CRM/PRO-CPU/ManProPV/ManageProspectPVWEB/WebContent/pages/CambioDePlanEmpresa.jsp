<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.*"%>

<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<input type="hidden" name="radioTipoPlan" id="radioTipoPlan" />
<input type="hidden" name="codOSAnt" id="codOSAnt" value=0 />
<input type="hidden" name="codActuacion" id="codActuacion" />
<input type="hidden" name="aplicaTraspaso" id="aplicaTraspaso" />
<input type="hidden" name="codPlanServNuevo" id="codPlanServNuevo" />
<input type="hidden" name="desPlanTarifSelec" id="desPlanTarifSelec" />
<input type="hidden" name="fecDesdeLlam" id="fecDesdeLlam" />
<input type="hidden" name="periodoFact" id="periodoFact" />
<input type="hidden" name="saldo" id="saldo" />
<input type="hidden" name="codActAboAux" id="codActAboAux" />

<html:hidden property="codPlanTarifSelec"/>

<html:hidden property="codClienteDestSelec"/>
<html:hidden property="combinatoria" />
<html:hidden property="cargoBasicoSelec"/>
<html:hidden property="opcionPlanORango"/>
<html:hidden property="tipoPlanTarifDestino"/>
<html:hidden property="codLimiteConsumoSelec"/>
<html:hidden property="codCargoBasicoDestino"/>
<html:hidden property="numDiasDestino"/>
<html:hidden property="impFinalSelec"/>
<html:hidden property="limConsumoEvalCred"/>
<html:hidden property="botonSeleccionadoCambioPlan"/>
<html:hidden property="flgPaginaFiltro"/>
<html:hidden property="flgAplicaEvaluacion"/>
<html:hidden property="flgClienteDestinoEmpresa"/>
<html:hidden property="codCicloClienteDestino"/>
<html:hidden property="codVendedor"/>

<!-- Ingreso de Numeros Frecuentes CPU  -->
<input type="hidden" name="numFrecFijos" id="numFrecFijos" />
<input type="hidden" name="numFrecMovil" id="numFrecMovil" />
<input type="hidden" name="indFf" id="indFf" />
<input type="hidden" name="numFrecIng" id="numFrecIng" />
<input type="hidden" name="botonNumerosFrecuentesCPU" id="botonNumerosFrecuentesCPU" />
<input type="hidden" name="paginaRegreso" id="paginaRegreso" />

<div id="divCuentaPersonal" style="width:252px; height:20px; display:none; position:absolute; z-index:3; background:#F8f8f3" border="0" >
  <table width="100%" border="0">
    <tbody id="bodyCuentaPersonal">
	    <tr class="textoColumnaTabla">
	      <td colspan="2"><div align="center">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td width="91%"><div id="textoDesv" align="center">Cuenta Personal </div></td>
	            <td width="9%"><div align="right"><img src="img/close.gif" width="21"  height="21" border="0" 
	            onclick="ocultarVentana2('divCuentaPersonal');evaluarCondicionesAjaxOOSS();" style="cursor:pointer"></div></td>
	          </tr>
	        </table>	        
			</div>
		  </td>
	    </tr>  
	    <tr class="textoColumnaTabla">
	      <td class="valorCampoSeleccionable" >
	      	<label>Número Abonado:<span id="numeroAbo"></span></label>
	      </td>
	    </tr>  
	    <tr class="textoColumnaTabla">
	      <td class="valorCampoSeleccionable" >
	      	<label>Número Celular&nbsp;&nbsp;&nbsp;:<span id="numeroCel"></span></label>
	      </td>
	    </tr>
	    <tr class="textoColumnaTabla">
	      <td class="valorCampoSeleccionable" >
	      	<label>Número Personal:</label>&nbsp;&nbsp;&nbsp;<html:text name="CambiarPlanForm" property="celularPers" styleId="celularPers" maxlength="15" onkeypress="return acceptNum(event)"/>
	      </td>
	    </tr>	   
	    <tr class="textoColumnaTabla">
		    <td align="right">
	          <img style="cursor: pointer;" src="botones/btn_aceptar.gif" name="Aceptar2" width="85" height="19"  border="0" id="Aceptar2" align="Aceptar2"
			  onmouseover="sobreElBoton('Aceptar2','botones/btn_aceptar_roll.gif')" onMouseOut="sobreElBoton('Aceptar2','botones/btn_aceptar.gif')" onclick="validarOpcionesCuentaPersonal()" />
			</td>
	    </tr>	 
    </tbody>
  </table>
</div>

<table border="0" width="100%">
      <tr>
        <td colspan="3"><table border="0" width="100%">
            <tr>
              <td colspan="4" align="left" class="textoSubTitulo">Datos Adicionales del Cliente</td>
            </tr>
            <tr>
              <td width="3%">&nbsp;</td>
              <td width="46%" align="left"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
                  <tr>
                    <td width=25% class="campoInformativo">N&uacute;mero Abonados Vigentes</td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=73% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.numAbonados}"/></td>
                  </tr>
                  <tr>
                    <td width=25% class="campoInformativo">Tipo Terminal</td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=73% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.desTipoTerminal}"/></td>
                  </tr>
                  <tr>
                    <td width=25% class="campoInformativo">Plan Tarifario</td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=73% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.codPlanTarif}"/>-<c:out value="${clienteOS.cliente.desPlanTarif}"/></td>
                  </tr>
                  <tr>
					<td width=24% class="campoInformativo">Tipo Plan</td>
					<td width=2% class="valorCampoInformativo">:</td>
					<td width=74% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.desTipPlanTarif}"/></td>
					<p></p>
				  </tr>
              </table>
			 </td>
             <td width="51%"><table border="0" cellpadding="0" cellspacing="0"  width="100%">
                  <tr>
                    <td width=22% class="campoInformativo">Ciclo Facturaci&oacute;n</td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=76% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.codCiclo}"/></td>
                  </tr>
                  <tr>
                    <td width=22% class="campoInformativo">L&iacute;mite Consumo </td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=76% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.limiteConsumo}"/>-<c:out value="${clienteOS.cliente.desLimiteConsumo}"/></td>
                  </tr>
                  <tr>
                    <td width=22% class="campoInformativo">Cargo B&aacute;sico</td>
                    <td width=2% class="valorCampoInformativo">:</td>
                    <td width=76% class="valorCampoInformativo"><c:out value="${clienteOS.cliente.impCargoBasico}"/></td>
                  </tr>
              </table></td>
  	 
            </tr>
        </table></td>
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
      <tr>
        <td colspan="3"><table width="100%">
            <tr>
              <td colspan="4" align="left" class="textoSubTitulo">Ingreso de Informaci&oacute;n Cambio de Plan Producto</td>
            </tr>
            <tr>
              <td width="3%">&nbsp;</td>
              <td width="11%" class="campoSeleccionable">
	    <img src="img/black_arrow.gif" width="7" height="7" />Tipo Plan
	  <td width="1%" class="valorCampoSeleccionable">:</td>	
      <td width="85%" class="valorCampoSeleccionable">
      <label>
        <html:radio  name="CambiarPlanForm" property="tipoPlanRB" value="combopre" disabled="true"/>
        Prepago</label>
      <label>
        <html:radio onclick="activarCombosDependDelPlanEmpresa(this)" name="CambiarPlanForm" property="tipoPlanRB" value="combopos"/>
        Pospago</label>
      <label>
        <html:radio  name="CambiarPlanForm" property="tipoPlanRB" value="combohib" disabled="true"/> 
        Hibrido</label>
     </td>
     </tr>
        </table></td>
      </tr>
      <tr>
        <td width="3%">&nbsp;</td>
        
        
      <td width="97%"><table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr>
              <td width=12% class="campoInformativo">&nbsp;</td>
              <td width=1% class="campoInformativo">&nbsp;</td>
              <td width=87% class="campoInformativo">&nbsp;</td>
            </tr>
            
            <tr>
              <td width=12% class="campoSeleccionable"><img src="img/black_arrow.gif" width="7" height="7" />Plan Tarifario o Rango</td>
              <td width=1% class="valorCampoSeleccionable">:</td>
              <td width=87% class="valorCampoSeleccionable">
              
			  <table width="72%" border="0">
			  <tr>
				<td width="287" class="textoColumnaTabla"><label><html:radio onclick="activarPlanORango(this)" name="CambiarPlanForm" property="radioPlanORango" value="radioPlan" />Plan</label></td> 

				<td width="287" class="textoColumnaTabla"><label><html:radio onclick="activarPlanORango(this)" name="CambiarPlanForm" property="radioPlanORango" value="radioRango" />Rango</label></td> 
			  </tr>
			  
			  <tr>
				<td class="campoSeleccionable">C&oacute;digo Plan
			   <html:select onchange="validaComboPlanTarif(this)" size="3" property="combopos" >
					  <logic:iterate indexId="j" id="lp2" name="planTarifPospago" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
					  		<html:option value="<%=String.valueOf(lp2.getCodPlanTarif())%>"><bean:write name="lp2" property="desPlanTarif"/> </html:option>
					  </logic:iterate>
			   </html:select>
				                   
				  </td>
				<td class="campoSeleccionable">Monto Cargo B&aacute;sico
				  <div>
				  	<html:text property="montoCargo" onkeypress="return acceptNum(event)" onblur="validaMontoCargo(this);"/>
				  </div></td>
			  </tr>
			  
			  <tr>
				<td>&nbsp;</td>
				<td class="campoSeleccionable">Rangos
					<div>
					  <html:select property="rangoPlanCB" onchange="validaComboPlanTarifRango(this)" >
					    <html:option value="0">Seleccione... </html:option>
					    <logic:iterate id="rangoplan" name="rango" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
						  		<html:option value="<%=String.valueOf(rangoplan.getCodPlanTarif())%>"> <bean:write name="rangoplan" property="desPlanTarif"/> </html:option>
						</logic:iterate>
					  </html:select>
					</div></td>
			  </tr>
			 </table>
			</td>
            </tr>
            
            <tr>
              <td width=12% class="campoSeleccionable"><img src="img/black_arrow.gif" width="7" height="7" />Cliente Destino</td>
              <td width=1% class="valorCampoSeleccionable">:</td>
              <td width=87% class="valorCampoSeleccionable"><div>
                
            <html:select  property="clienteDestPos">
            	<logic:iterate id="clientepospago" name="clientesPospago" scope="session" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO">
				  		<html:option value="<%=String.valueOf(clientepospago.getCodCliente())%>"> <bean:write name="clientepospago" property="codCliente"/>-<bean:write name="clientepospago" property="nombreCompleto"/> </html:option>
				</logic:iterate>
            </html:select>
            
		  </div><br /></td>
           </tr>
            <tr>
              <td width=12% class="campoInformativo">Cuenta Destino</td>
              <td width=1% class="valorCampoInformativo">:</td>
              <td  width=87% class="valorCampoInformativo"> <c:out value="${clienteOS.cliente.codCuenta}"/>-<c:out value="${clienteOS.cliente.desCuenta}"/><br /></td></tr>
        	</tr>
        	
        	<tr style="visibility:hidden;position:absolute;">
              <td width=12% class="campoSeleccionable"><img src="img/black_arrow.gif" width="7" height="7" />Sub Cuenta</td>
              <td width=1% class="valorCampoSeleccionable">:</td>
              <td width=87% class="valorCampoSeleccionable">
	              <label>
			          <html:select property="subCuentaCB">
		            	<logic:iterate id="subcuenta" name="subCuentas" scope="request" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaDTO">
							<html:option value="<%=String.valueOf(subcuenta.getCodSubCuenta())%>"> <bean:write name="subcuenta" property="codSubCuenta"/>-<bean:write name="subcuenta" property="desSubCuenta"/> </html:option>
						</logic:iterate>
		              </html:select>
	              </label>
	              <br/>
              </td>
            </tr>

            <tr>
              <td width=12% class="campoInformativo">Ciclo</td>
              <td width=1% class="valorCampoInformativo">:</td>
              <td  width=87% class="valorCampoInformativo"><span id="codCicloCliente"><c:out value="${clienteOS.cliente.codCiclo}"/></span><br/></td></tr>
        </table></td>
        
      </tr>
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
      </tr>
 
      
  <tr>
    <td colspan="3" align="left">
	<table width="100%" border="0" cellpadding="0" cellspacing="2">
	 <tr>
    	 <td colspan="11" align="right" class="textoSubTitulo"> 
         	<img src="botones/btn_listafrecuentes.gif" 
         	  name="numfreccpu" width="85" height="19"  border="0" id="numfreccpu"  
		  	  onmouseover="sobreElBoton('numfreccpu','botones/btn_listafrecuentes_roll.gif')" 
		  	  onmouseout="sobreElBoton('numfreccpu','botones/btn_listafrecuentes.gif')" 
		 	  onclick="ingresarNumFrecCPU();"
		 	  style="cursor: pointer;display:none;background: url(botones/btn_listafrecuentes.gif); cursor: pointer; border-style: none; height: 20px; width: 140px;" 
		 	 />
	     </td>
  	</tr>	
	<tr>
    	<td colspan="11" align="left" class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" />Abonados a procesar</td>
    </tr>
    <tr>
    		  <td width="3%">&nbsp;</td>
              <td width=20% class="campoInformativo">Todos los Abonados</td>
    </tr>
    
  <tr id="encabezadoGrilla">
    <td width="7%" class="textoColumnaTabla">Seleccionar </td>
    <td width="6%" class="textoColumnaTabla">N&uacute;mero Abonado</td>
    <td width="9%" class="textoColumnaTabla">Celular</td>
    <td width="3%" class="textoColumnaTabla">Ciclo</td>
    <td width="6%" class="textoColumnaTabla">L&iacute;mite Consumo</td>
    <td width="7%" class="textoColumnaTabla">Tecnolog&iacute;a</td>
	<td width="11%" class="textoColumnaTabla">Situaci&oacute;n Actual</td>
	<td width="9%" class="textoColumnaTabla">Tipo Plan Tarifario</td>
	<td width="15%" class="textoColumnaTabla">Plan Tarifario</td>
  </tr>

<c:if test="${clienteOS.cliente.numAbonados >0}">
  	<logic:present name="ClienteOOSS" scope="session">
	   <bean:define id="cliente" name="ClienteOOSS" scope="session"/>
	   <bean:define id="abonados" name="cliente" type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO[]" property="abonados"/>
	   
	   <logic:iterate id="abonado" name="abonados"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       <tr id="dataGrilla">
	        <td class="textoFilasTabla"> 
	        <html:multibox onclick="validaCheck(this)" name="CambiarPlanForm" property="listaAbonados">
	           <bean:write name="abonado" property="numAbonado"/>
            </html:multibox> </td>
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="numAbonado"/></td> 
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="numCelular"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="codCiclo"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="limiteConsumo"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="codTecnologia"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="desSituacion"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="desTipoPlanTarif"/></td>   
	   		<td class="textoFilasTabla"><bean:write name="abonado" property="desPlanTarif"/></td>   
	   </tr>
	   </logic:iterate>
 	</logic:present>
</c:if>
  </table>
 </td>
 </tr>
      
      <tr>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
        <td>&nbsp;</td>
    </tr></table>
    

