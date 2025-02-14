<%@ page language="java" isErrorPage="true" %>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<input type="hidden" id="botonSeleccionado" name="botonSeleccionado"/>
<input type="hidden" id="total" name="total"/>
<input type="hidden" id="indCreaDescuento" name="total" value="<c:out value="${requestScope.indCreaDesc}"/>"/>
<input type="hidden" id="rangoInfPorcDescuento" name="total" value="<c:out value="${requestScope.rangoInf}"/>"/>
<input type="hidden" id="rangoSupPorcDescuento" name="total" value="<c:out value="${requestScope.rangoSup}"/>"/>
<input type="hidden" id="numDecimalesForm" name="numDecimalesForm" value="<c:out value="${sessionScope.numDecimalesFormulario}"/>"/>


<input type="hidden" id="cumpleDescuento" name="cumpleDescuento"/>

<table width="100%" border="0">
	<tr>
     	<td class="mensajeError" align="center"><div id="mensajes"></div></td>
  	</tr>
 	<tr>
     	<td class="mensajeError" align="center"><div id="mensajesDescMax"></div></td>
  	</tr>
  	<tr>
     	<td class="mensajeError" align="center"><div id="mensajesDescMin"></div></td>
  	</tr>
  	<tr>
     	<td class="mensajeError" align="center"><div id="mensajesDesc"></div></td>
  	</tr>
</table>

<table width="100%" border="0">
  <tr>
    <td class="textoSubTitulo">Condiciones Comerciales</td>
  </tr>
  <tr>
    <td><table width="100%" border="0">
      <tr>
        <td width="7">&nbsp;</td>
        <td width="161" class="campoSeleccionable">
			<div style="visibility: <% if (request.getAttribute("Vis_CargosCicloRB").equals("SI")) out.write("visible"); else  out.write("hidden");%>">
			  <img src="img/black_arrow.gif" width="7" height="7" />Cargos Inmediatos<!--Cargos a Factura de Ciclo-->&nbsp;&nbsp;&nbsp;		
			</div>
		</td>
        <td width="162" class="valorCampoSeleccionable">
          <div style="visibility: <% if (request.getAttribute("Vis_CargosCicloRB").equals("SI")) out.write("visible"); else  out.write("hidden"); %>">
        	Si <html:radio  tabindex="1" property="rbCiclo" value="SI" name="CargosForm" disabled="${Hab_CargosCicloRB}" />
        	No <html:radio  tabindex="2" property="rbCiclo" value="NO" name="CargosForm" disabled="${Hab_CargosCicloRBNO}" />
          </div>        	
        </td>
        <td width="32">&nbsp;</td>
        <td width="179" class="campoSeleccionable"><img src="img/black_arrow.gif" width="7" height="7" />Tipo de documento de cobro</td>
        <td width="173">
        
        <html:select property="cbTipoDocumento" name="CargosForm" disabled="true">
   		    <logic:notEmpty name="CargosForm" property="documentosList">
       		 <html:options collection="documentosList" property="codigo" labelProperty="descripcion" />
       		</logic:notEmpty>
        </html:select>

        
        <td width="144" rowspan="2">
           <div align="center" style="display:NONE;">
             <img src="botones/btn_calcularcargos.gif" alt="Calcular Cargos"  border="0" id="ConsultarCargoBT" onmouseover="sobreElBoton('ConsultarCargoBT','botones/btn_calcularcargos_roll.gif')" onmouseout="sobreElBoton('ConsultarCargoBT','botones/btn_calcularcargos.gif')" name="ConsultarCargoBT" onclick="calcularCargos();" width="143" height="19"/></a>
           </div>
        </td>
      </tr>
      <tr>
        <td width="7">&nbsp;</td>
        <td width="161" class="campoSeleccionable"><img src="img/black_arrow.gif" width="7" height="7" />Modalidad de Pago&nbsp;&nbsp;&nbsp;</td>
        <td width="162" class="valorCampoSeleccionable">
       	   <html:select property="cbModPago" name="CargosForm">
        		<html:options collection="formaPagoList" property="tipoValor" labelProperty="descripcionTipoValor" />
        	</html:select>
          </td>
        <td width="32">&nbsp;</td>
        
        <td width="179" class="campoSeleccionable">
         <div style="visibility: <% if (request.getAttribute("Vis_CuotasSO").equals("SI")) out.write("visible"); else  out.write("hidden"); %>">
           <img src="img/black_arrow.gif" width="7" height="7" />Numero de Cuotas
         </div>
        </td>
         
        <td width="173">
         <div style="visibility: <% if (request.getAttribute("Vis_CuotasSO").equals("SI")) out.write("visible"); else  out.write("hidden"); %>">
          <html:select property="cbNumCuotas" name="CargosForm" disabled="false">
        	<html:options collection="cuotasList" property="cod_cuota" labelProperty="des_cuota" />
          </html:select>
		 </div>
        </td>
        <td width="144" rowspan="2">&nbsp;
           </td>
      </tr>

    
    </table></td>
    </tr>
  <tr>
    <td>&nbsp;</td>
    </tr>
  <tr>
    <td class="textoSubTitulo"><img src="img/black_arrow.gif" width="7" height="7" /> Cargos a Cobrar</td>
    </tr>
  <tr>
    <td>
    
    <table width="100%" border="0" id="tablaDatos">
      <tr>
        <td width="3%" class="textoColumnaTabla">&nbsp;</td>
        <td width="4%" class="textoColumnaTabla">&nbsp;</td>
        <td width="25%" class="textoColumnaTabla">&nbsp;</td>
        <td width="6%" class="textoColumnaTabla">&nbsp;</td>
        <td width="6%" class="textoColumnaTabla">&nbsp;</td>
        <td colspan="2" class="textoColumnaTabla">Descuentos Autom&aacute;ticos</td>
        <td colspan="2" class="textoColumnaTabla">Descuentos Manuales</td>
        <td width="9%" class="textoColumnaTabla">&nbsp;</td>
        <td width="6%" class="textoColumnaTabla">&nbsp;</td>
      </tr>
      <tr>
        <td colspan="2" class="textoColumnaTabla">A/M</td>
        <td class="textoColumnaTabla">Descripci&oacute;n</td>
        <td class="textoColumnaTabla">Cantidad</td>
        <td class="textoColumnaTabla">Importe Total</td>
        <td width="12%" class="textoColumnaTabla">Tipo Descuento</td>
        <td width="8%" class="textoColumnaTabla">Descuento</td>
        <td width="11%" class="textoColumnaTabla">Tipo Descuento</td>
        <td class="textoColumnaTabla">Descuento</td>
        <td class="textoColumnaTabla">Saldo Total</td>
        <td class="textoColumnaTabla">Moneda</td>
        <script language="javascript"> var contador = 0;</script>
        </tr>
        
        <logic:present name="CargosForm" property="tablaCargos">
        <logic:iterate indexId="indice" id="i" name="CargosForm" property="tablaCargos">
	      <tr>
	        <td class="textoFilasTabla" id="<%=indice.intValue()%>Check">
		        <html:multibox disabled="true" name="CargosForm" property="selectedValorCheck" onclick="calcular();">
		        	<bean:write name="i" property="codConcepto" />
		        </html:multibox>
	        </td>
	        <td class="textoFilasTabla"><bean:write name="i" property="autManDes"/></td>
	        <td class="textoFilasTabla"><bean:write name="i" property="descripcion"/></td>
	        <td class="textoFilasTabla" style="text-align:right;"><bean:write name="i" property="cantidad"/><input type="hidden" id="importeTotalOriginal" name="importeTotalOriginal"/><input type="hidden" id="tipoDescuentoOriginal" name="tipoDescuentoOriginal"/></td>
	        <td class="textoFilasTabla" style="text-align:right;"><bean:write name="i" property="importeTotal"/></td>
	        <td class="textoFilasTabla" style="text-align:center;"><bean:write name="i" property="tipoDescuentoAut"/></td>
	        <td class="textoFilasTabla" style="text-align:right;"><bean:write name="i" property="descuentoUnitarioAut"/></td>
	        <td class="textoFilasTabla">
	        	<div align="center">
					<%String limpiacaja="limpiacaja("+indice.intValue()+");reCalcular()";%>
				    <html:select property="tipoDescuentoManual" name="i" onchange="<%=limpiacaja%>">
					<html:options collection="tipDescuentosList" property="codTipoDescuento" labelProperty="descTipoDescuento" />
	                </html:select>
	            </div>
	        </td>
	        <td class="textoFilasTabla" style="text-align:right;">
	          <%String calcular="calcular("+indice.intValue()+")";%>
	          <html:text property="descuentoUnitarioMan" name="i" disabled="false" onblur="<%=calcular%>" onkeypress="validaIngresoDecimales(this);" />
	        </td>
	        <td class="textoFilasTabla" style="text-align:right;"><bean:write property="saldo" name="i"/></td>
	        <td class="textoFilasTabla"><bean:write property="moneda" name="i"/><input type="hidden" name="totales" id="<%=indice.intValue()%>Totales"/></td>
	        </tr>
	    </logic:iterate> 
        </logic:present>   
  		
  		<tr>
			<td colspan="7" class="textoColumnaTabla">&nbsp;</td>
	        <td colspan="2" class="textoColumnaTabla">Total a Pagar sin Impuestos</td>
	        <td class="textoColumnaTabla" style="text-align:right;"><bean:write name="CargosForm" property="total"/></td>
	        <td class="textoColumnaTabla">&nbsp;</td>
        </tr>       
      
    </table></td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>


