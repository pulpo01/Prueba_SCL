<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>

<html:hidden property="condicH" />
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
			
		</script>
		<logic:present name="Abonado" property="productoContratados">
		<bean:size id="sizepc" name="Abonado" property="productoContratados"/>
	<logic:equal name="sizepc" value="0">
			<!-- Crear un mensaje si no encuentra -->
			<h1 class="textoSubTitulo">No existen planes adicionales por defecto</h1>
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
		<input type="hidden" name="idControlCh" id="idControlCh" value="" />
	<logic:greaterThan name="sizepc" value="0">    

		<tr class="textoColumnaTabla">
			<td width="9%" >Contratar </td>
			<td width="11%">C&oacute;digo </td>
			<td colspan="2" >Producto </td>
			<td width="11%"> Tipo </td>
			<td width="18%" >Modo Contrataci&oacute;n</td>
		</tr>

		<logic:iterate id="Contratados" name="Abonado" property="productoContratados">      
		<input type="hidden" id="ind_paquete_<%=idProducto%>" value="<bean:write name="Contratados" property="paquete"/>">
		<input type="hidden" id="codigo_<%=idProducto%>c" value="<bean:write name="Contratados" property="codigo"/>">        
		<input type="hidden" id="codPadre_<%=idProducto%>c" value="<bean:write name="Contratados" property="codPadre"/>">
		<!--input type="hidden" id="inicial_<%=idProducto%>" value="<bean:write name="Contratados" property="cantidadContratado"/>"-->
		<!--input type="hidden" id="maxcon_<%=idProducto%>" value="<bean:write name="Contratados" property="maximo"/>"-->
		<!--cierra el table del detalle del paquete de productos-->
		<script>cierraPaq('<bean:write name="Contratados" property="codPadre"/>c','<bean:write name="Contratados" property="paquete"/>');</script>				  
		<bean:define id="isPaquetec" name="Contratados" property="paquete"/>	 
	    <logic:equal name="isPaquetec" value="1"> 			   	  	 			  		
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>  
			<td width="9%" align="left">
				<input type="checkbox" name="check_<%=idProducto%>c" id='<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>'
				       value='<bean:write name="Contratados" property="chequeado"/>'
				       onclick="gestionProductoCont(this,'<%=idProducto%>',
				       '<bean:write name="Contratados" property="paquete"/>',
				       '<bean:write name="Contratados" property="idProdContratado"/>',
				       '<bean:write name="Contratados" property="esAutoAfin"/>')"/>
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
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>
			<td width="9%" align="left">
				<input type="hidden" name="idProducto_<%=idProducto%>" value="<%=idProducto%>">        					
				<input type="checkbox" name="check_<%=idProducto%>c" id='<%=idProducto%>_<bean:write name="Contratados" property="idProdContratado"/>' 
				 	   value='<bean:write name="Contratados" property="chequeado"/>'
				       onclick="gestionProductoCont(this,'<%=idProducto%>',
				       '<bean:write name="Contratados" property="paquete"/>',
				       '<bean:write name="Contratados" property="idProdContratado"/>',
				       '<bean:write name="Contratados" property="esAutoAfin"/>')"/>
			</td>
			<td width="14%"><bean:write name="Contratados" property="codProducto"/></td>
			<td width="34%"><bean:write name="Contratados" property="nombre"/></td>
			<td width="4%">	   	  	 			  								
				<input type="image" style="display:none" src="img/botones/btn_puntos_pre.gif" width="19" height="19" alt="producto"/>
			</td>
			<td>
				<script>descripcionTipo('<bean:write name="Contratados" property="comportamiento"/>');
						agregaCodProducto('<bean:write name="Contratados" property="codProducto"/>','<%=idProducto%>',0,'<bean:write name="Contratados" property="esHijo"/>');
				</script>
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
<table width="100%" border="0">	
	<tr>
		<td colspan="8"><h2 class="textoSubTitulo">Disponibles</h2></td>
	</tr>
	<tr>		
		<td colspan="8">
		<!-- td que encierra todo -->
		<logic:present name="Abonado" property="productoDisponibles">
		<bean:size id="sizepd" name="Abonado" property="productoDisponibles"/>
	<logic:equal name="sizepd" value="0">
			<!-- Crear un mensaje si no encuentra -->
			<h1 class="textoSubTitulo">No existen planes adicionales ofertados </h1>
	</logic:equal>
	<script>
	var	PadreChequeado='';
	tablaAbierta = false;
	</script>
	    <input type="text"   name="bitacorad" value="" id="bitacorad" size="200" style="display:none">
	<logic:greaterThan name="sizepd" value="0">    
		<!-- INPUT DEL PRODUCTO SELECIONADO -->
		<html:hidden property="codigo" styleId="codigo"/>
		<html:hidden property="comportamiento" styleId="comportamiento"/>
		<html:hidden property="codPadrePaq" styleId="codPadrePaq"/>
		<html:hidden property="idProducto" styleId="idProducto"/>
		<input type="hidden" name="productoDescripcion" id="productoDescripcion" value=""/>
		<input type="hidden" name="codigoProducto" id="codigoProducto"   value=""/>
		<input type="hidden" name="numeroMaximo" id="numeroMaximo"   value=""/>
		
		<!-- INPUT DE LOS PRODUCTOS SELECIONADOS -->
		<html:hidden property="pagina" value="productos"/>
		<input type="hidden" name="accion" value="">
		<input type="hidden" name="pagina" value="productos">
		<input type="hidden" name="idAbonado" id='abonado' value="<bean:write name="Abonado" property="idAbonado"/>">
		
		
		<tr class="textoColumnaTabla">
			<td width="7%" >Contratar </td>
			<td width="6%" >Cantidad</td>
			<td width="9%">C&oacute;digo </td>
			<td colspan="2" >Producto </td>
			<!-- td width="10%"><div align="left">Personalizado</div></td> -->
			<td width="10%"> Tipo </td>
			<td width="15%" >Modo Contrataci&oacute;n</td>
			<td colspan="2">
				<div align="center">Total Cargos</div>
			</td>
		</tr>
		<tr class="textoColumnaTabla">
			<td> </td>
			<td></td>
			<td> </td>
			<td colspan="2" > </td>			
			<td>  </td>
			<td></td>
			<td>
				<div align="center">Ocasionales</div>
			</td>
			<td>
				<div align="center">Recurrentes</div>
			</td>
		</tr>
		<logic:iterate indexId='indice' id="Disponibles" name="Abonado" property="productoDisponibles">      
		<input type="hidden" id="ind_paquete_<%=idProducto%>" value="<bean:write name="Disponibles" property="paquete"/>">
		<input type="hidden" id="codigo_<%=idProducto%>" value="<bean:write name="Disponibles" property="codigo"/>">        
		<input type="hidden" id="codPadre_<%=idProducto%>" value="<bean:write name="Disponibles" property="codPadre"/>">
		<input type="hidden" id="inicial_<%=idProducto%>" value="<bean:write name="Disponibles" property="cantidadContratado"/>">
		<input type="hidden" id="maxcon_<%=idProducto%>" value="<bean:write name="Disponibles" property="maximo"/>">
		<!--cierra el table del detalle del paquete de productos-->
		<script>cierraPaq('<bean:write name="Disponibles" property="codPadre"/>','<bean:write name="Disponibles" property="paquete"/>');</script>				  
		<bean:define id="isPaquete" name="Disponibles" property="paquete"/>	 
	    <logic:equal name="isPaquete" value="1"> 			   	  	 			  		
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>  
			<td width="9%" align="left">
				<input type="checkbox" name="check_<%=idProducto%>" id="check_<%=idProducto%>"        	
				       value='<bean:write name="Disponibles" property="chequeado"/>'
					   onclick='gestionProducto(maximoPaq_<%=idProducto%>,this,"<%=idProducto%>","<bean:write name="Disponibles" property="paquete"/>",
					   "<bean:write name="Disponibles" property="codProducto"/>","<bean:write name="Disponibles" property="esAutoAfin"/>","<bean:write name="Disponibles" property="esHijo"/>")'/>
			</td>
			<td align="left" width="6%">
				<input type="text" name="cantidades" id="maximoPaq_<%=idProducto%>" onfocus="javascript: setValorActual(this);"
				       onkeypress="javascript: validaNumero(this);" onblur="javascript: esNumerico(this);"
					   value='<bean:write name="Disponibles" property="cantidadContratado"/>'  
					   onChange	='maxpro(this,"<bean:write name="Disponibles" property="maximo"/>","<%=idProducto%>",
					                          "<bean:write name="Disponibles" property="codProducto"/>",true,"<bean:write name="Disponibles" property="cantidadContratado"/>","<bean:write name="Disponibles" property="esAutoAfin"/>")' size="4" maxlength="2"/>
			</td>
			<script>HabilitaTexto(document.getElementById('maximoPaq_<%=idProducto%>'),document.getElementsByName('check_<%=idProducto%>'),'<bean:write name="Disponibles" property="codigo"/>');</script>
			<td width="11%"><bean:write name="Disponibles" property="codProducto"/></td>
			<td width="31%"><bean:write name="Disponibles" property="nombre"/></td>
			<td width="4%">
				<img title="Personalizar paquete de productos" style="cursor: pointer" onclick='detallaPaquete("<bean:write name="Disponibles" property="codigo"/>")'
					 src="img/img_pack.gif" name="boton_<%=idProducto%>" id="boton_<%=idProducto%>"/>
				<script>setCodPadre('<bean:write name="Disponibles" property="codPadre"/>');</script>
			</td>
			<!--<td  width="4%">
				<div align="left"><bean:write name="Disponibles" property="personalizado"/></div></td>-->
			<td  width="4%">
				<script>descripcionTipo('<bean:write name="Disponibles" property="comportamiento"/>');
				</script>
			</td>
			<td align="left"  width="4%"><div align="left"><script>descripcionIndCont('<bean:write name="Disponibles" property="indCondicionContratacion"/>');</script></div></td>
			<td><div align="left">$<bean:write name="Disponibles" property="cargoOcasional"/></div></td>
			<td><div align="left">$<bean:write name="Disponibles" property="cargoFrecuente"/></div></td>
		</tr>
		    
		<tr class="textoidProductoTabla">
			<td align="left" colspan="8">
			<!-- PARA QUE EL TABLE DEL PAQUETE OCUPE 8 CELDAS!! -->
			<table border="0"  width="100%" id="<bean:write name="Disponibles" property="codigo"/>" style="display:none" bgcolor="#EEEEEE">
				<tr bgcolor="#DDDDDD">
					<td>  </td>
					<td>Cantidad </td>
					<td>C&oacute;digo </td>
					<td colspan="2" >Plan Adicional </td>			
					<td> Tipo </td>
					<td>Modo Contrataci&oacute;n</td>
					<td colspan="2">
						  
					</td>
				</tr>
				
				<script language="javascript">productoDePaquete=true;
					tablaAbierta = true;
				</script>
		
				<script>
					tablaAbierta = true;
					verificarCheck('<bean:write name="Disponibles" property="chequeado"/>','check_<%=idProducto%>','1','<bean:write name="Disponibles" property="codigo"/>');
				</script>
		</logic:equal>     
		
	  <logic:equal name="isPaquete" value="0">
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>
			<td width="9%" align="left">
				<input type="hidden" name="idProducto_<%=idProducto%>" value="<%=idProducto%>">        					
				<input type="checkbox" name="check_<%=idProducto%>" id='<bean:write name="Disponibles" property="codPadre"/>' 
				 	   value='<bean:write name="Disponibles" property="chequeado"/>'
					   onclick='gestionProducto(maximo_<%=idProducto%>,this,"<%=idProducto%>","<bean:write name="Disponibles" property="paquete"/>",
					   "<bean:write name="Disponibles" property="codProducto"/>","<bean:write name="Disponibles" property="esAutoAfin"/>","<bean:write name="Disponibles" property="esHijo"/>")'/>
			</td>
			<td align="left" width="6%">
				<input type="text" name="cantidades" id="maximo_<%=idProducto%>" onfocus="javascript: setValorActual(this);"
					   onkeypress="javascript: validaNumero(this);" onblur="javascript: esNumerico(this);"
					   value='<bean:write name="Disponibles" property="cantidadContratado"/>'  
					   onChange	='maxpro(this,"<bean:write name="Disponibles" property="maximo"/>","<%=idProducto%>","<bean:write name="Disponibles" property="codProducto"/>",true,"<bean:write name="Disponibles" property="cantidadContratado"/>","<bean:write name="Disponibles" property="esAutoAfin"/>")' size="4" maxlength="2"/>
			</td>
			<script>
				HabilitaTexto(document.getElementById('maximo_<%=idProducto%>'),document.getElementsByName('check_<%=idProducto%>'),'<bean:write name="Disponibles" property="codigo"/>');</script>
			<td width="11%"><bean:write name="Disponibles" property="codProducto"/></td>
			<td width="31%"><bean:write name="Disponibles" property="nombre"/></td>
			<td width="4%">	   	  	 			  								
				<input type="image" style="display:none" src="img/botones/btn_puntos_pre.gif" width="19" height="19" alt="producto"/>
			</td>
			<!-- <td><div align="left"><bean:write name="Disponibles" property="personalizado"/></div></td> -->
			
			<td>
				<script>descripcionTipo('<bean:write name="Disponibles" property="comportamiento"/>');
				</script>
			</td>					
			<td align="left"><div align="left">
			<script>descripcionIndCont('<bean:write name="Disponibles" property="indCondicionContratacion"/>');</script>
			</div>						
			</td>
			<td>
				<div align="left">
					<script>
					  if(!productoDePaquete)
					   { 
							 document.write('$<bean:write name="Disponibles" property="cargoOcasional"/>')
					   }
					 </script>
				 </div>
			</td>
			<td>
				<div align="left">
				   <script>
					 if(!productoDePaquete)
					 {
						 document.write('$<bean:write name="Disponibles" property="cargoFrecuente"/>')
					 }
					</script>
				 </div>
			</td>		


		 </tr>
		<script>
			verificarCheck('<bean:write name="Disponibles" property="chequeado"/>','check_<%=idProducto%>','0','<bean:write name="Disponibles" property="codigo"/>');
		</script>
	  </logic:equal>        			      

		<script>
		//alert("codPadre ["+'<bean:write name="Disponibles" property="codPadre"/>' +"] PadreChequeado ["+PadreChequeado+"]");
		if ('<bean:write name="Disponibles" property="codPadre"/>'==PadreChequeado)
		{
			document.getElementsByName('check_<%=idProducto%>').checked=true;
			document.getElementsByName('check_<%=idProducto%>').click();
			ProductoForm.maximo_<%=idProducto%>.disabled=false;
		}
		</script>
	  <%idProducto++; %>
	  </logic:iterate>
	 </table>
	  	<script>
			var totalProd = <%=idProducto%>;
		</script>
	  <table bordercolor="red" border="0" width="100%" border="0" cellspacing="0" cellpadding="0" id="error-msg" style="display:none">
		<tr>
		  <td width="3%" height="19" valign="bottom" class="textcaminohormigas"> <div align="left"><img src="img/alerta.gif" id="alerta"></div></td>
		  <td width="97%" valign="baseline" class="textcaminohormigas" id='tdError'><bean:message key="Error.producto"/></td>
		</tr>
	  </table>
	
	</table>
	</logic:greaterThan>
	</logic:present>      
	</td>
	</tr>
 </table>