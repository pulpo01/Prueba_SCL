<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<html:form action="producto.do">

<table width="100%" border="0">	
	<tr>
		<td colspan="8"><h2 class="textoSubTitulo">Disponibles</h2></td>
	</tr>
	<tr>		
		<td colspan="8">
		<!-- td que encierra todo -->
		<script>
			setIdAboando('<bean:write name="Abonado" property="idAbonado"/>');			
		</script>
<logic:present name="Abonado" property="productoDisponibles">
		<bean:size id="sizepd" name="Abonado" property="productoDisponibles"/>
			<logic:equal name="sizepd" value="0">
					<!-- Crear un mensaje si no encuentra -->
					<h1 class="textoSubTitulo">No existen planes adicionales ofertados </h1>
			</logic:equal>
	<script>
	var	PadreChequeado='';
	</script>
	
	<html:hidden property="codigo" styleId="codigo"/>
	<html:hidden property="comportamiento" styleId="comportamiento"/>
	<html:hidden property="tipoCobro" styleId="tipoCobro"/>
	<html:hidden property="codPadrePaq" styleId="codPadrePaq"/>
	<html:hidden property="idProducto" styleId="idProducto"/>	
	<html:hidden property="idEspecProvision" styleId="idEspecProvision"/>		
		
	<input type="hidden" name="accion" value="">
	<input type="hidden" name="bitacora" value="" id="bitacora" size="200">
	<input type="hidden" name="bitacoraLcDef" value="" id="bitacoraLcDef" size="200">
	<input type="hidden" name="montoslc_D_ih" value="" id="montoslc_D_ih" size="300">
	<!--  logic:greaterThan name="sizepd" value="0" -->    
		<!-- INPUT DEL PRODUCTO SELECIONADO -->		
		<input type="hidden" name="productoDescripcion"   id="productoDescripcion" value=""/>
		<input type="hidden" name="codigoProducto" id="codigoProducto"   value=""/>
		<input type="hidden" name="numeroMaximo" id="numeroMaximo"   value=""/>
		
		<!-- INPUT DE LOS PRODUCTOS SELECIONADOS -->
		<html:hidden property="pagina" value="productos"/>
		<input type="hidden" name="pagina" value="productos">
		<input name="idAbonado" type="hidden" value="<bean:write name="Abonado" property="idAbonado"/>" id="abonado">		
		
		
		<tr class="textoColumnaTabla">
			<td>Contratar </td>
			<td>Cantidad</td>
			<td>C&oacute;digo </td>
			<td colspan="2" >Plan Adicional </td>			
			<td> Tipo </td>
			<td>L&iacute;mite de Consumo</td>
			<td>Monto LC</td>
			<td>Modo Contrataci&oacute;n</td>
			<td colspan="2">
				<div align="center">Total Cargos</div>
			</td>
			<td rowspan="2">
				<div align="center">Tipo Cobro</div>
			</td>
		</tr>
		<tr class="textoColumnaTabla">
			<td></td>
			<td></td>
			<td> </td>
			<td colspan="2" > </td>			
			<td></td>
			<td></td>
			<td></td>
			<td></td>
			<td>
				<div align="center">Ocasionales</div>
			</td>
			<td>
				<div align="center">Recurrentes</div>
				
			</td>
		</tr>
		
		<%
		int idProducto = 1;
		%>

		<logic:iterate id="Disponibles" name="Abonado" property="productoDisponibles"> 
		<input type="hidden" id="inicialLC_<%=idProducto%>" value="<bean:write name="Disponibles" property="mtoConsumido"/>">    
		<Script>
		//cierra el table del detalle del paquete de productos
			cierraPaq('<bean:write name="Disponibles" property="codPadre"/>','<bean:write name="Disponibles" property="paquete"/>');
		</script>				  
		<bean:define id="isPaquete" name="Disponibles" property="paquete"/>	
		
	    <logic:equal name="isPaquete" value="1"> 		    		   	  	 			  		
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>  
			<td align="center">
				<bean:write name="Disponibles" property="tipoPlanAdic"/>
				<input type="hidden" name="ind_paquete_<%=idProducto%>" id="ind_paquete_<%=idProducto%>" value="<bean:write name="Disponibles" property="paquete"/>">
				<input type="hidden" name="max_disponible_<%=idProducto%>" id="max_disponible_<%=idProducto%>" value="<bean:write name="Disponibles" property="maximo"/>"><!-- GAP MIX-09003 -->
				<input type="hidden" name="tipoPlanAdic_<%=idProducto%>" value="<bean:write name="Disponibles" property="tipoPlanAdic"/>"><!-- INI MIX-09003 -->				
				<input 
				name		="check_<%=idProducto%>" 
				id			="check_<%=idProducto%>" 
				type		="checkbox" 	       	
				value		="<bean:write name="Disponibles" property="chequeado"/>"
				onclick		='gestionProducto(maximoPaq_<%=idProducto%>,this,"<%=idProducto%>",
						"<bean:write name="Disponibles" property="paquete"/>",
						"<bean:write name="Disponibles" property="codProducto"/>",
						"<bean:write name="Disponibles" property="maximo"/>",
						'combo',
						txtmtolc_<%=idProducto%>,
                        "<bean:write name="Disponibles" property="tipoPlanAdic"/>")
				'/>
				
			</td>
			<td align="center" >
				<input 
				id			="maximoPaq_<%=idProducto%>" 
				name		="cantidades" 
				type		="text"
				onfocus     ="javascript: setValorActual(this);"	
				value       ='<bean:write name="Disponibles" property="cantidadContratado"/>' 			
				onChange	="maxpro(this,<bean:write name="Disponibles" property="maximo"/>,<%=idProducto%>,<bean:write name="Disponibles" property="paquete"/>)" 
				size		="4" 
				maxlength	="2" />
			</td>
			<script>
			    //HabilitaTexto(document.ProductoForm.maximoPaq_<%=idProducto%>,document.ProductoForm.check_<%=idProducto%>,<%=idProducto%>);
			    HabilitaTexto(document.ProductoForm.maximo_<%=idProducto%>,document.ProductoForm.check_<%=idProducto%>,'<bean:write name="Disponibles" property="tipoPlanAdic"/>');
				//HabilitaTexto(document.ProductoForm.maximoPaq_<%=idProducto%>,document.ProductoForm.check_<%=idProducto%>,'<bean:write name="Disponibles" property="codigo"/>');
			</script>
			<td ><bean:write name="Disponibles" property="codProducto"/></td>
			<td width="100px"><nobr><bean:write name="Disponibles" property="nombre"/></nobr></td>
			<td >
				<input type="hidden" name="codigo_<%=idProducto%>" value="<bean:write name="Disponibles" property="codigo"/>">        
				<input type="hidden" name="codPadre_<%=idProducto%>" id="codPadre_<%=idProducto%>" value="<bean:write name="Disponibles" property="codPadre"/>">     		
				<img
					title="Personalizar paquete de productos" 
					style="cursor: pointer"
					onclick="detallaPaquete('<bean:write name="Disponibles" property="codigo"/>')"
					src="img/img_pack.gif" 
					name="boton_<%=idProducto%>" 
					id="boton_<%=idProducto%>"
				/>
				<script>
				setCodPadre('<bean:write name="Disponibles" property="codPadre"/>');
				</script>
				<img 
					src="img/botones/btn_puntos_error.gif" 
					id="boton_error_<%=idProducto%>" 
					style="display:none"
				/>
			</td>
			
			
					
			<td>			
				<script>
					descripcionTipo('<bean:write name="Disponibles" property="comportamiento"/>');
				</script>
			</td>
			<!-- INI INC155400 VMB -->
			<!-- <td align="center"><div align="left">Opcional</div></td>  -->
			<td align="center">
			<div align="left">
				<script>
					descripcionTipoProducto('<bean:write name="Disponibles" property="tipoPlanAdic"/>');
				</script>
			</div>
			</td>
			<!-- FIN INC 155400 VMB -->
			<td>
				<div align="left">$<bean:write name="Disponibles" property="cargoOcasional"/></div>
			</td>
			<td>
				<div align="left">$<bean:write name="Disponibles" property="cargoFrecuente"/></div>
			</td>	
			<td>
			<script>
				descripcionTipoCobro('<bean:write name="Disponibles" property="tipoCobroCargo"/>');
			</script>
			</td>
			</tr>		
				
			<tr>
			
			<td align="center" colspan="9">			
			<!-- PARA QUE EL TABLE DEL PAQUETE OCUPE 8 CELDAS!! -->
			<table border="0"  width="100%" id="<bean:write name="Disponibles" property="codigo"/>" style="display:none" bgcolor="#EEEEEE">
				<tr bgcolor="#DDDDDD">
					<td>  </td>
					<td>Cantidad </td>
					<td>C&oacute;digo </td>
					<td colspan="2" >Plan Adicional </td>			
					<td> Tipo </td>
					<td>L&iacute;mite de Consumo</td>
					<td width="8%">Monto LC</td>
					<td>Modo Contrataci&oacute;n</td>
					<td colspan="2">
					</td>
				</tr>
				
				<script language="javascript">productoDePaquete=true;
					tablaAbierta = true;
				</script>
		</logic:equal>     
		
		
		
	  <logic:equal name="isPaquete" value="0">
				<%if (idProducto%2==0){ %> 	
				<tr class="textoidProductoTabla">
				<%}else{ %>
				<tr class="textoidProductoColorTabla">
				<%}%>  

										 
					<td  align="center">
					    <input type="hidden" id="inicial_<%=idProducto%>" name="inicial_<%=idProducto%>" value="<bean:write name="Disponibles" property="cantidadDesplegado"/>">
			            <input type="hidden" id="maxcon_<%=idProducto%>" name="maxcon_<%=idProducto%>" value="<bean:write name="Disponibles" property="maximo"/>">			
						<input type="hidden" id="ind_paquete_<%=idProducto%>" name="ind_paquete_<%=idProducto%>" value="<bean:write name="Disponibles" property="paquete"/>">
						<input type="hidden" id="max_disponible_<%=idProducto%>" name="max_disponible_<%=idProducto%>" value="<bean:write name="Disponibles" property="maximo"/>"><!-- INC 155400 18102010 -->
						<input type="hidden" name="tipoPlanAdic_<%=idProducto%>" id="tipoPlanAdic_<%=idProducto%>" value="<bean:write name="Disponibles" property="tipoPlanAdic"/>"><!-- INI MIX-09003 -->
						<input type="hidden" name="codigo_<%=idProducto%>" id="codigo_<%=idProducto%>" value="<bean:write name="Disponibles" property="codigo"/>">        
						<input type="hidden" name="codProducto_<%=idProducto%>" id="codProducto_<%=idProducto%>" value="<bean:write name="Disponibles" property="codProducto"/>">        
						<input type="hidden" name="codPadre_<%=idProducto%>" id="codPadre_<%=idProducto%>" value="<bean:write name="Disponibles" property="codPadre"/>">     		
						
						<input 
						id		="check_<%=idProducto%>" 
						name = "<bean:write name="Disponibles" property="codPadre"/>"
						type		="checkbox" 	       	
						value		="<bean:write name="Disponibles" property="chequeado"/>"						
                       <logic:equal name="Disponibles" property="tipoPlanAdic" value="2">
						disabled	="true"
						checked 	="true"
						</logic:equal> 					
						onclick		='gestionProducto(maximo_<%=idProducto%>,this,"<%=idProducto%>",
						"<bean:write name="Disponibles" property="paquete"/>",
						"<bean:write name="Disponibles" property="codProducto"/>",
						"<bean:write name="Disponibles" property="maximo"/>",
						document.ProductoForm.combo_lc_<%=idProducto%>,
						txtmtolc_<%=idProducto%>,
                        "<bean:write name="Disponibles" property="tipoPlanAdic"/>")
						'/>
					</td>
					
					
					<td align="center" >
						<input 
						id			="maximo_<%=idProducto%>" 
						name		="cantidades" 
						type		="text" 
						value       ='<bean:write name="Disponibles" property="cantidadContratado"/>' 
						onfocus     ="javascript: setValorActual(this);"						
						onChange	="maxpro(this,<bean:write name="Disponibles" property="maximo"/>,<%=idProducto%>,<bean:write name="Disponibles" property="paquete"/>)" 
						size		="4" 
						maxlength	="2"		
					   
						/>
						
					</td>
					<script>
						HabilitaTexto(document.ProductoForm.maximo_<%=idProducto%>,document.ProductoForm.check_<%=idProducto%>,'<bean:write name="Disponibles" property="tipoPlanAdic"/>');
						// gestionProducto(document.getElementByID('maximo_<%=idProducto%>'),'<%=idProducto%>','<bean:write name="Disponibles" property="paquete"/>');
					</script>
					
					
					
					<td ><bean:write name="Disponibles" property="codProducto"/> </td>
					<td width="100px"><nobr><bean:write name="Disponibles" property="nombre"/></nobr></td>
					<td >
						
						 
						<bean:define id="isPersonalizable" name="Disponibles" property="modificable"/>	 
						
					    <logic:equal name="isPersonalizable" value="1"> 	
					    <%System.out.println("PASO name=isPersonalizable value=1"); %>
					    <!-- PRODUCTO PERSONALIZABLE (Frecuentes, Afines, Datos adicionales Cmovistar)-->	
				    	<logic:equal name="Disponibles"  property="comportamiento" value="PFRC">   	
				    	 <%System.out.println("PASO value=PFRC"); %> 			  								
							<input 
								type="image" 
								title="Personalizar Frecuentes" 
								<logic:notEqual name="Disponibles" property="tipoPlanAdic" value="2">
									style="cursor: pointer;display:none"
								</logic:notEqual>
								onclick="guardarCabecera(this.form,'<bean:write name="Disponibles" property="nombre"/>','<bean:write name="Disponibles" property="codProducto"/>','<bean:write name="Disponibles" property="numMaximoLista"/>');return producto(ProductoForm,maximo_<%=idProducto%>,'<bean:write name="Disponibles" property="comportamiento"/>','<bean:write name="Disponibles" property="codigo"/>','<bean:write name="Disponibles" property="codPadre"/>','<bean:write name="Disponibles" property="idEspecProvision"/>')" 
								src="img/botones/btn_puntos.gif" width="19" height="19" 
								name="boton_<%=idProducto%>" 
								id="boton_<%=idProducto%>"
								alt="Haga click para personalizar este producto"
							/>
						</logic:equal>
				    	<logic:notEqual name="Disponibles"  property="comportamiento" value="PFRC">
							<logic:equal name="Disponibles"  property="comportamiento" value="PAFN">				    		  	 			  								
								<input 
									type="image" 
									title="Personalizar Frecuentes" 
									style="cursor: pointer;display:none"
									onclick="guardarCabecera(this.form,'<bean:write name="Disponibles" property="nombre"/>','<bean:write name="Disponibles" property="codProducto"/>','<bean:write name="Disponibles" property="numMaximoLista"/>');return producto(ProductoForm,maximo_<%=idProducto%>,'<bean:write name="Disponibles" property="comportamiento"/>','<bean:write name="Disponibles" property="codigo"/>','<bean:write name="Disponibles" property="codPadre"/>','<bean:write name="Disponibles" property="idEspecProvision"/>')" 
									src="img/botones/btn_puntos.gif" width="19" height="19" 
									name="boton_<%=idProducto%>" 
									id="boton_<%=idProducto%>"
									alt="Haga click para personalizar este producto"
								/>
							</logic:equal>
							<logic:notEqual name="Disponibles"  property="comportamiento" value="PAFN">				    		  	 			  								
								<input 
									type="image" 
									title="Datos Adicionales" 
									style="cursor: pointer;display:none"
									onclick="guardarCabecera(this.form,'<bean:write name="Disponibles" property="nombre"/>','<bean:write name="Disponibles" property="codProducto"/>','<bean:write name="Disponibles" property="numMaximoLista"/>');return producto(ProductoForm,maximo_<%=idProducto%>,'<bean:write name="Disponibles" property="comportamiento"/>','<bean:write name="Disponibles" property="codigo"/>','<bean:write name="Disponibles" property="codPadre"/>','<bean:write name="Disponibles" property="idEspecProvision"/>')" 
									src="img/botones/btn_puntos.gif" width="19" height="19" 
									name="boton_<%=idProducto%>" 
									id="boton_<%=idProducto%>"
									alt="Haga click para ingresar datos adicionales de correo movistar"
								/>
							</logic:notEqual>
						</logic:notEqual>
						 <%System.out.println("NO PASO"); %> 	
					
						<img 
							src="img/botones/btn_puntos_error.gif" 
							id="boton_error_<%=idProducto%>" 
							style="display:none"
							alt="No se puede personalizar el plan adicional seleccionado"
						/>
						<logic:notEqual name="Disponibles" property="tipoPlanAdic" value="2">
							<img 
						 		src="img/botones/btn_puntos_pre.gif" 
								id="boton_inicial_<%=idProducto%>" 
								alt="Seleccione antes de personalizar este producto"
							
							/>
						</logic:notEqual>	
						
						</logic:equal>
					    <logic:equal name="isPersonalizable" value="0"> 			   	  	 			  								
					    <!-- PRODUCTO NO PERSONALIZABLE -->		   	  	 			  								
						<img
							title="no es posible personalizar este producto" 
							style="display:none"
							src="img/botones/btn_puntos_pre.gif" width="19" height="19" 
							name="boton_<%=idProducto%>" 
							id="boton_<%=idProducto%>"
							alt="no es posible personalizar este producto"
						/>
						<img 
							src="img/botones/btn_puntos_error.gif" 
							id="boton_error_<%=idProducto%>" 
							style="display:none"
							alt="No se puede personalizar el plan adicional seleccionado"
						/>
						<img 
							src="img/botones/btn_puntos_pre.gif" 
							id="boton_inicial_<%=idProducto%>" 
							alt="no es posible personalizar este producto"
						/>
						</logic:equal>
						
					</td>			
					
					<td >
						<script>
						descripcionTipo('<bean:write name="Disponibles" property="comportamiento"/>');
						codLimCons[<%=idProducto%>] = new Array();
						desLimCons[<%=idProducto%>] = new Array();
						mtosConsum[<%=idProducto%>] = new Array();
						mtosMinimo[<%=idProducto%>] = new Array();
						mtosMaximo[<%=idProducto%>] = new Array();
						var cantidadLC;							
						</script>
					</td>
					<td align="center">
					<bean:define id="listaLimConsumo" name="Disponibles" property="listaLimiteConsumoValMto"/>
					   <select name="combo_lc" id="combo_lc_<%=idProducto%>" disabled = "disabled" 
					           onchange='validarSelectLC(this,<%=idProducto%>,"<bean:write name="Disponibles" property="codProducto"/>")'
					           style="width:200px;">
					       <logic:iterate indexId="countLC" id="element" name="listaLimConsumo">
				            <%//<option value="<bean:write name='element' property='key'/>"><bean:write name="element" property="value"/></option>%>
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
				            	syncSelect(document.ProductoForm.combo_lc_<%=idProducto%>, '<bean:write name="Disponibles" property="codLimConsuSeleccionado"/>');
				            	verificarSelect(document.ProductoForm.combo_lc_<%=idProducto%>,cantidadLC+1);
				            	cantLCProd[<%=idProducto%>] = cantidadLC+1;									 								
				            </script>
				            
   		            </td>
					<td align="left" width="5%">
						<input type="text" name="montoslc" id="txtmtolc_<%=idProducto%>" disabled="disabled" onfocus="javascript: setValorActual(this);"
							   onkeypress="javascript: validaNumero(this);" onblur="javascript: esNumerico(this);"
							   value='<bean:write name="Disponibles" property="mtoConsumido"/>'  
							   onChange	='validarRangoLC(this,"<%=idProducto%>",
							   "<bean:write name="Disponibles" property="codProducto"/>",
							   "<bean:write name="Disponibles" property="mtoConsumido"/>", "check_<%=idProducto%>")' size="11" maxlength="10"/>
					</td>   		         				
					<td  align="center">
						<div align="left">
						  <script>
						descripcionTipoProducto('<bean:write name="Disponibles" property="tipoPlanAdic"/>'); <!-- GAP MIX-09003 -->										
						  </script>
						</div>
						<!-- FIN INC 155400 18112010 -->
						<input type="hidden" name="idProducto_<%=idProducto%>" value="<%=idProducto%>">        					
						<input type="hidden" name="inicial_<%=idProducto%>" value="<bean:write name="Disponibles" property="cantidadContratado"/>">
						<input type="hidden" name="maxcon_<%=idProducto%>" value="<bean:write name="Disponibles" property="maximo"/>">						
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
					<td align="center" width="2%">
					<script>
						descripcionTipoCobro('<bean:write name="Disponibles" property="tipoCobroCargo"/>');
					</script>
					</td>
				 </tr>			      
	  </logic:equal>        			      
	  
	  
		<script>			
				
		if('<bean:write name="Disponibles" property="chequeado"/>'=='true')
		{		
			ProductoForm.check_<%=idProducto%>.click();
			if ('1'=='<bean:write name="Disponibles" property="paquete"/>')
			{
				PadreChequeado = '<bean:write name="Disponibles" property="codigo"/>'
			}
		}
		
		if ('<bean:write name="Disponibles" property="codPadre"/>'==PadreChequeado)
		{
			ProductoForm.check_<%=idProducto%>.checked=true;
			ProductoForm.check_<%=idProducto%>.click();
			ProductoForm.maximo_<%=idProducto%>.disabled=false;
		}
		
		if ('0'=='<bean:write name="Disponibles" property="paquete"/>')
		{
			var valorLC = document.getElementById("txtmtolc_<%=idProducto%>").value;
			if ( valorLC == '0' || valorLC == '0.0')
			{
				document.getElementById("txtmtolc_<%=idProducto%>").value = '0.0';
			}
		}
		
		
		</script>	 		 
	  <%idProducto++; %>
	  </logic:iterate>
	 </table>	  	
	<!-- INI GAP MIX-09003 -->
	<script>
	   //agregaPlanOpcOblDefecto(<%=idProducto%> );
	</script>
<!-- FIN GAP MIX-09003 -->
	<table bordercolor="red" border="0" width="100%" border="0" cellspacing="0" cellpadding="0" id="error-msg" style="display:none">
		<tr>
		  <td width="3%" height="19" valign="bottom" class="textcaminohormigas"> <div align="left"><img src="img/alerta.gif" id="alerta"></div></td>
		  <td width="97%" valign="baseline" class="textcaminohormigas" id='tdError'><bean:message key="Error.producto"/></td>
		</tr>
    </table>
	
	</table>
	<!-- /logic:greaterThan -->
	</logic:present>      
	</td>
	</tr>
	</table>
	  
</html:form>

