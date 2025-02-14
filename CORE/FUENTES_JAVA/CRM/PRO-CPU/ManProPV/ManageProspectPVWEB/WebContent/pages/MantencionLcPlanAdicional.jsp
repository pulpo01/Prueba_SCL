<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<%!String colorFila = null;%>
<%!public String getColorFila(int countNum)
  	{
		colorFila = "textoidProductoColorTabla";
		if ((countNum % 2) == 0)  colorFila = "textoidProductoTabla";
		return colorFila;
  	}
%>		
<html:hidden property="condicH" />
<html:hidden property="listaProductosContrados" />

<%int idProducto = 1;%>
<table width="100%" border="0">	
	<tr>
		<td colspan="8"><h2 class="textoSubTitulo">Contratados</h2></td>
	</tr>
	<tr>		
		<td colspan="8">
		<!-- td que encierra todo -->
		<script>
			setIdAbonado('<bean:write name="Abonado" property="idAbonado"/>');
			setHayAutoAfinCont('<bean:write name="Abonado" property="hayAutoAfinCont"/>');
			setValorSeleccionados();
		</script>
		<logic:present name="Abonado" property="productoContratados">
		<bean:size id="sizepc" name="Abonado" property="productoContratados"/>
	<logic:equal name="sizepc" value="0">
			<!-- Crear un mensaje si no encuentra -->
			<h1 class="textoSubTitulo">No existen planes contratados</h1>
	</logic:equal>
	<script>
	var	PadreChequeado='';
	</script>
		<!-- INPUT DEL PRODUCTO SELECIONADO -->
		<!--  <html:hidden property="codigo" styleId="codigo"/>
		<html:hidden property="comportamiento" styleId="comportamiento"/>
		<html:hidden property="codPadrePaq" styleId="codPadrePaq"/>
		<html:hidden property="idProducto" styleId="idProducto"/>-->
		<input type="hidden" name="productoDescripcion" id="productoDescripcion" value=""/>
		<input type="hidden" name="codigoProducto" id="codigoProducto"   value=""/>
		<input type="hidden" name="numeroMaximo" id="numeroMaximo"   value=""/>
		
		<!-- INPUT DE LOS PRODUCTOS SELECIONADOS -->
		<html:hidden property="pagina" value="productos"/>
		<input type="hidden" name="accion" value="">
		<input type="hidden" name="pagina" value="productos">
		<input type="hidden" name="idAbonado" id='abonado' value="<bean:write name="Abonado" property="idAbonado"/>">
		<input type="text"   name="bitacorac" value="" id="bitacorac" size="200" style="display:none">
		<input type="text" name="bitacoraLcDef" value="" id="bitacoraLcDef" size="200" style="display:none">
		<input type="hidden" name="idControlCh" id="idControlCh" value="" />
	<logic:greaterThan name="sizepc" value="0">    

		<tr class="textoColumnaTabla">
			<td width="9%" ></td>
			<td width="11%">C&oacute;digo Producto</td>
			<td colspan="2" >Descripci&oacute;n Producto </td>
			<td width="11%"> Tipo </td>
			<td width="20%">L&iacute;mite de Consumo</td>
			<td width="8%">Monto LC</td>
			<td width="18%" >Modo Contrataci&oacute;n</td>
		</tr>

		<logic:iterate id="Contratados" name="Abonado" property="productoContratados">      
		<input type="hidden" id="ind_paquete_<%=idProducto%>" value="<bean:write name="Contratados" property="paquete"/>">
		<input type="hidden" id="codigo_<%=idProducto%>c" value="<bean:write name="Contratados" property="codigo"/>">        
		<input type="hidden" id="codPadre_<%=idProducto%>c" value="<bean:write name="Contratados" property="codPadre"/>">
		<!--input type="hidden" id="inicial_<%=idProducto%>" value="<bean:write name="Contratados" property="cantidadContratado"/>"-->
		<input type="hidden" id="inicialLC_<%=idProducto%>" value="<bean:write name="Contratados" property="mtoConsumido"/>">
		<!--input type="hidden" id="maxcon_<%=idProducto%>" value="<bean:write name="Contratados" property="maximo"/>"-->
		<!--cierra el table del detalle del paquete de productos-->
		<script>cierraPaq('<bean:write name="Contratados" property="codPadre"/>c','<bean:write name="Contratados" property="paquete"/>');</script>				  
		<bean:define id="isPaquetec" name="Contratados" property="paquete"/>	 
	    <logic:equal name="isPaquetec" value="1"> 			   	  	 			  		
		<tr class="<%=getColorFila(idProducto)%>">
			<td width="9%" align="left">
				<input type="checkbox" style="visibility:hidden" name="check_<%=idProducto%>c" id='<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>'
				       value='<bean:write name="Contratados" property="chequeado"/>'
				       onclick="gestionProductoContManLc(this,'<%=idProducto%>',
				       '<bean:write name="Contratados" property="paquete"/>',
				       '<bean:write name="Contratados" property="idProdContratado"/>',
				       '<bean:write name="Contratados" property="esAutoAfin"/>','combo')"/>
			</td>
			<td width="14%"><bean:write name="Contratados" property="codProducto"/></td>
			<td width="34%"><bean:write name="Contratados" property="nombre"/></td>
			<td width="4%">
				<img title="Personalizar paquete de productos" style="cursor: pointer" 
				     onclick='detallaPaquete("<bean:write name="Contratados" property="idProdContratado"/>c")'
					 src="img/img_pack.gif" name="boton_<%=idProducto%>c" id="boton_<%=idProducto%>"/>
				<script>setCodPadre('<bean:write name="Contratados" property="codPadre"/>c');</script>
			</td>
			<td>
				<script>descripcionTipo('<bean:write name="Contratados" property="comportamiento"/>');
						agregaCodProducto('<bean:write name="Contratados" property="codProducto"/>','<%=idProducto%>',1,'<bean:write name="Contratados" property="esHijo"/>');
				</script>
			</td>
			<td>
			<td align="left"><div align="left">
			<script>descripcionIndCont('<bean:write name="Contratados" property="indCondicionContratacion"/>');</script>
			</div></td>
		</tr>			
		<tr>
			<td align="left" colspan="8">
			<!-- PARA QUE EL TABLE DEL PAQUETE OCUPE 8 CELDAS!! -->
			<table width="100%" id='<bean:write name="Contratados" property="idProdContratado"/>c' style="display:none" bgcolor="#EEEEEE">
			<script>
			tablaAbierta = true;
			verificarCheckCont('<bean:write name="Contratados" property="chequeado"/>','<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>','1',
			   '<bean:write name="Contratados" property="codigo"/>','<bean:write name="Contratados" property="indCondicionContratacion"/>');
			</script>
		</logic:equal>     
		
	  <logic:equal name="isPaquetec" value="0">
		<tr class="<%=getColorFila(idProducto)%>">
			<td width="9%" align="left">
				<input type="text" name="RegistraCambio" id="RegistraCambio_<%=idProducto%>" value="" style="display:none">
				<input type="hidden" name="idProducto_<%=idProducto%>" value="<%=idProducto%>">        					
				<input type="checkbox" style="visibility:hidden" name="check_<%=idProducto%>c" id='<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>' 
				 	   value='<bean:write name="Contratados" property="chequeado"/>'
				       onclick="gestionProductoContManLc(this,'<%=idProducto%>',
				       '<bean:write name="Contratados" property="paquete"/>',
				       '<bean:write name="Contratados" property="idProdContratado"/>',
				       '<bean:write name="Contratados" property="esAutoAfin"/>',document.ProductoForm.combo_lc_C<%=idProducto%>)"/>
			</td>
			<td width="14%"><bean:write name="Contratados" property="codProducto"/></td>
			<td width="34%"><bean:write name="Contratados" property="nombre"/></td>
			<td width="4%">	   	  	 			  								
				<input type="image" style="display:none" src="img/botones/btn_puntos_pre.gif" width="19" height="19" alt="producto"/>
			</td>
			<td>
				<script>descripcionTipo('<bean:write name="Contratados" property="comportamiento"/>');
				agregaCodProducto('<bean:write name="Contratados" property="codProducto"/>','<%=idProducto%>',0,'<bean:write name="Contratados" property="esHijo"/>');
				codLimCons[<%=idProducto%>] = new Array();
				desLimCons[<%=idProducto%>] = new Array();
				mtosConsum[<%=idProducto%>] = new Array();
				mtosMinimo[<%=idProducto%>] = new Array();
				mtosMaximo[<%=idProducto%>] = new Array();
				var cantidadLC;
				</script>
			</td>
			<td>
					  
					<bean:define id="listaLimConsumo" name="Contratados" property="listaLimiteConsumoValMto"/>
					  <!-- <select name="combo_lc_C" id="combo_lc_C<%=idProducto%>" onchange="registroCambio('<%=idProducto%>','<bean:write name="Contratados" property="codLimConsuInicial"/>',this);setValorSeleccionados();">-->
					   <!-- disabled = "disabled" -->
					   <select name="combo_lc_C" id="combo_lc_C<%=idProducto%>"  onchange='validarSelectLC(this,<%=idProducto%>,"<bean:write name="Contratados" property="codProducto"/>")'>
					       <logic:iterate indexId="countLC" id="element" name="listaLimConsumo">
				                <option value="<bean:write name='element' property='codLimCons'/>"><bean:write name="element" property="descripcion"/></option>
								<script language="JavaScript" type="text/javascript">
								 codLimCons[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="codLimCons" />';
								 desLimCons[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="descripcion" />';
								 mtosConsum[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoConsumido" />';
								 mtosMinimo[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoMinimo" />';
								 mtosMaximo[<%=idProducto%>][<%=countLC.intValue()%>] = '<bean:write name="element" property="mtoMaximo" />';
								 cantidadLC=<%=countLC.intValue()%>;
								</script>				                
				           </logic:iterate>
				        </select>
				            <script>
				            	syncSelect(document.ProductoForm.combo_lc_C<%=idProducto%>, '<bean:write name="Contratados" property="codLimConsuSeleccionado"/>');
				            	registroCambio('<%=idProducto%>','<bean:write name="Contratados" property="codLimConsuInicial"/>',document.ProductoForm.combo_lc_C<%=idProducto%>);
				            	cantLCProd[<%=idProducto%>] = cantidadLC+1;
				            </script>
				           
			</td>
			<td align="left" width="5%">
				<input type="text" name="montoslc_c" id="txtmtolc_c<%=idProducto%>" onfocus="javascript: setValorActual(this);"
					   onkeypress="javascript: validaNumero(this);" onblur="javascript: esNumerico(this);"
					   value='<bean:write name="Contratados" property="mtoConsumido"/>'  
					   onChange	='validarRangoLC(this,"<%=idProducto%>",
					   "<bean:write name="Contratados" property="codProducto"/>",
					   "<bean:write name="Contratados" property="mtoConsumido"/>", "check_<%=idProducto%>c")' size="11" maxlength="10"/>
			</td>							
			<td align="left"><div align="left"><script>descripcionIndCont('<bean:write name="Contratados" property="indCondicionContratacion"/>');</script></div>						
			</td>
		 </tr>
		<script>
		verificarCheckCont('<bean:write name="Contratados" property="chequeado"/>','<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>','0',
		    '<bean:write name="Contratados" property="codigo"/>','<bean:write name="Contratados" property="indCondicionContratacion"/>');
		</script>
	  </logic:equal>        			      
		<script>
		if ('<bean:write name="Contratados" property="codPadre"/>c'==PadreChequeado)
		{
			document.getElementsByName('check_<%=idProducto%>c').checked=true;
			document.getElementsByName('check_<%=idProducto%>c').click();
		}
		</script>	 		 
	  <%idProducto++; %>
	  </logic:iterate>
	 </table>
	  	<script>
			var totalProd = <%=idProducto%>;
		</script>
	  <!--<table width="100%" border="0" cellspacing="0" cellpadding="0" id="error-msg" style="display:none">
		<tr>
		  <td width="3%" height="19" valign="bottom" class="textcaminohormigas"> <div align="left"><img src="img/alerta.gif" id="alerta"></div></td>
		  <td width="97%" valign="baseline" class="textcaminohormigas"><bean:message key="Error.producto"/></td>
		</tr>
	  </table>-->
	
	</table>
	</logic:greaterThan>
	</logic:present>      
	</td>
	</tr>
</table>
<script>resetCodPadre();</script>
	</td>
	</tr>
 </table>