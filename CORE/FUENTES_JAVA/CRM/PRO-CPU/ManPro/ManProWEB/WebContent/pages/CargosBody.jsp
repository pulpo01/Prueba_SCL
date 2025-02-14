<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>

<input type="hidden" id="indCreaDescuento" name="total" value="${indCreaDesc}"/>
<input type="hidden" id="rangoInfPorcDescuento" name="total" value="${rangoInf}"/>
<input type="hidden" id="rangoSupPorcDescuento" name="total" value="${rangoSup}"/>
<input type="hidden" id="tipoCobro_A" name="tipoCobro_A" value="${tipoCobro_A}"/>

<!--  iframe id="iframeParche"  scrolling="no" frameborder="0" style="background-color:transparent; position:absolute;  border:none; display:none; z-index:2"> 
</iframe -->
<script language="javascript">
var indice=0;
 <logic:present name="ListaCargosMostrados" scope="session"> 
            <logic:iterate  name="ListaCargosMostrados" id="cargo"  type="com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.CargoWebDTO" scope="session">
            		listaCodConceptos[indice]="<bean:write name='cargo' property='codConcepto'/>";
            		listaImportes[indice]="<bean:write name='cargo' property='importe'/>";
            		listaCantidades[indice]="<bean:write name='cargo' property='cantidad'/>";
            		indice++;
		    </logic:iterate>
  </logic:present>
  
</script>

<div id="descuentosAutomaticos" style="width:252; height:20px;  display:none; position:absolute; z-index:3; background:#F8f8f3" >
  
  <table width="100%" border="0" bgcolor="#EBE9DC">
    <tbody id="bodyTablaDescuentos">
	    <tr class="textoColumnaTabla">
	      <td colspan="2"><div align="center">
	        <table width="100%" border="0" cellspacing="0" cellpadding="0">
	          <tr>
	            <td width="91%"><div id="textoDescAuto" align="center">Descuento Autom&aacute;tico </div></td>
	            <td width="9%"><div align="right"><img src="img/close.gif" width="21"  height="21" border="0" onClick="ocultarObjeto('descuentosAutomaticos');ocultarObjeto('iframeParche');" style="cursor:pointer"></div></td>
	          </tr>
	        </table>
	        
			</div></td>
	    </tr>
	    <tr class="textoColumnaTabla">
	      <td width="8%">Tipo Descuento </td>
	      <td width="11%">Valor Descuento </td>
	    </tr>	   
    </tbody>
  </table>
</div>

<table width="100%" border="0">
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td class="textoSubTitulo">Cargos</td>
    </tr>
    <tr bgcolor="#F8F8F3">
      <td>
	  
	  <table width="100%" border="0">
		  <tr class="textoColumnaTabla">
		         <td colspan="3">&nbsp;</td>
		         <td colspan="2">Descuento Manual </td>
		         <td colspan="4">&nbsp;</td>
		  </tr>
		  <tr class="textoColumnaTabla">
		        <td width="10%">Descripci&oacute;n Cargo</td>
		        <td width="7%">Cantidad</td>
		        <td width="12%">Importe Total </td>		        
		        <td width="12%">Tipo Descuento </td>
		        <td width="11%">Valor Descuento </td>
		        <td colspan="2">Descuento Autom&aacute;tico </td>
		        <td width="13%">Saldo Total </td>
		        <td width="20%">Moneda</td>
		  </tr>
			  	
	  	 <logic:present name="ListaCargosMostrados" scope="session"> 
            <logic:iterate  name="ListaCargosMostrados" id="cargo"  type="com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.CargoWebDTO" scope="session">            		
			          <tr bgcolor="#FFFFFF">
			            <td>
 		            	    <input type="hidden" name='totalDescuentos' id='totalDescuentos' value="0">	
 		            	    <input type="hidden" name='cantidades' id='cantidades' value="<bean:write name='cargo' property='cantidad'/>">
			            	<nobr><bean:write name="cargo" property="descripcion"/></nobr>
			            </td>
			            <td><div align="center"><bean:write name="cargo" property="cantidad"/></div></td>
						


						<td>
			            	<div align="right">			            	   		            		
			            	     <input type="hidden" name='importe_<bean:write name="cargo" property="codConcepto"/>' id='importe_<bean:write name="cargo" property="codConcepto"/>' value="<bean:write name="cargo" property="importe"/>">
			            	     <span  id="span_importe_<bean:write name='cargo' property='codConcepto'/>">
				            	     <bean:write name="cargo" property="importe"/>
			            	     </span>				            	
				            </div>
		            	</td>
			


			          <!--td><div align="right"><bean:write name="cargo" property="importe"/></div></td-->			            


			            <td align="right">
				            <select "tipoDescuento_<bean:write name='cargo' property='codConcepto'/>" id="tipoDescuento_<bean:write name='cargo' property='codConcepto'/>" onchange="setTipoDescuento(this,'<bean:write name='cargo' property='codConcepto'/>','<bean:write name='cargo' property='tipoCobro'/>')">
				             <logic:equal name="cargo" property="tipoCobro" value="A" >
				             	<option value="-1" selected="selected">...</option>
				                <option value="monto">Monto</option>
				                <option value="porcentaje">Porcentaje</option>
				             </logic:equal>
							 <logic:notEqual name="cargo" property="tipoCobro" value="A" >
							    <option value="-1" selected="selected">...</option>
				                <option value="monto">Monto</option>
				                <option value="porcentaje">Porcentaje</option>
				             </logic:notEqual>   
				            </select>
			            </td>
			            <td>
			            	<div align="left">
			            	    <input type="hidden" name="codConceptos" value="<bean:write name='cargo' property='codConcepto'/>">
			            		<input disabled="true" type="text" name="valorDescuento_<bean:write name='cargo' property='codConcepto'/>" id="valorDescuento_<bean:write name='cargo' property='codConcepto'/>" maxlength="10" size="8" id="valorDescuento" value="0" onkeypress="validaIngresoDecimales(this);" onblur="refreshSaldoTotal(this,'<bean:write name="cargo" property="codConcepto"/>');"> <span id="tipoDesc_<bean:write name='cargo' property='codConcepto'/>"> </span>
			            	</div>
			            </td>
			            <td>
			            	<div align="right">
			            		 <bean:write name="cargo" property="totalDescuentosAutomaticos"/> 
			            	</div>			
			            </td>
			            <td ><div align="left"></div></td>
			            <td>
			            	<div align="right">			            	   		            		
			            	     <input type="hidden" name='saldoTotal_<bean:write name="cargo" property="codConcepto"/>' id='saldoTotal_<bean:write name="cargo" property="codConcepto"/>' value="<bean:write name="cargo" property="saldoTotal"/>">
			            	     <span  id="span_saldoTotal_<bean:write name='cargo' property='codConcepto'/>">
				            	     <bean:write name="cargo" property="saldoTotal"/>
			            	     </span>				            	
				            </div>
		            	</td>
			            <td align="right">
			            	<bean:write name="cargo" property="desMoneda"/>
			            </td>
			          </tr>
            </logic:iterate>
         </logic:present> 
	  			     <tr>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td colspan="2">&nbsp;</td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			            <td>&nbsp;</td>
			          </tr>
			          <tr bgcolor="#f8f8f3">
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td colspan="2" bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			            <td bgcolor="#FFFFFF">&nbsp;</td>
			          </tr>			      		
	  
         
      </table></td>
    </tr>
    <tr>
      <td>
      <table width="100%" border="0">
          <tr class="textoColumnaTabla">
            <td width="67%"><div align="right"><strong>Total a pagar: </strong></div></td>
            <td width="14%"><strong><div align="right" id="totalAPagar">0</div></strong></td>
            <td width="19%">&nbsp;</td>
          </tr>
      </table>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
</table>