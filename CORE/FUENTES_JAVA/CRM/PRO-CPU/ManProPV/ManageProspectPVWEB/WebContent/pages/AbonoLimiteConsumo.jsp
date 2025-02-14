<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"  pageEncoding="ISO-8859-1"%>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
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
		</script>
		<logic:present name="Abonado" property="limiteConsumoProductos">
		<bean:size id="sizepc" name="Abonado" property="limiteConsumoProductos"/>
	<logic:equal name="sizepc" value="0">
			<!-- Crear un mensaje si no encuentra -->
			<h1 class="textoSubTitulo">No existen planes contratados</h1>
	</logic:equal>
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
			<td width="8%">Abonar </td>
			<td colspan="2">Plan(es) Adicional(es)</td>
			<td colspan="4">Limite de Consumo</td>
		</tr>
		
		<tr class="textoColumnaTabla">
			<td> <div align="center"></div></td>
			<td width="20%"> <div align="center">Descripcion</div></td>
			<td width="8%"><div align="center">Tipo</div></td>
			<td width="20%"><div align="center">Descripcion</div></td>
			<td width="15%"><div align="center">Importe</div></td>			
			<td width="8%"><div align="center">Abono</div> </td>
			<td width="8%"><div align="center">Total</div></td>
		</tr>

		<logic:iterate id="Contratados" name="Abonado" property="limiteConsumoProductos">      
		
		<!-- Propiedades del grupo de productos -->
		<input type="hidden" id="max_abono_<%=idProducto%>" value="<bean:write name="Contratados" property="maximoAbono"/>">
		<input type="hidden" id="codigoLc_<%=idProducto%>" value="<bean:write name="Contratados" property="codLimConsumoProductos"/>">        
		<input type="hidden" id="importe_<%=idProducto%>" value="<bean:write name="Contratados" property="importe"/>">
		<input type="hidden" id="codServicioBase_<%=idProducto%>" value="<bean:write name="Contratados" property="codServicioBase"/>">
		<%if (idProducto%2==0){ %> 	
		<tr class="textoidProductoTabla">
		<%}else{ %>
		<tr class="textoidProductoColorTabla">
		<%}%>
			<td width="9%" align="center">
				<input type="text" name="RegistraCambio" id="RegistraCambio_<%=idProducto%>" value="0" style="display:none">
				<input type="hidden" name="idProducto_<%=idProducto%>" value="<%=idProducto%>">        					
				<input type="checkbox" name="check_<%=idProducto%>c" id="<%=idProducto%>_check" value='<bean:write name="Contratados" property="chequeado"/>'
				       onclick="gestionAbonoLimiteConsumo(this,document.ProductoForm.abono_<%=idProducto%>,<%=idProducto%>);"/>
			</td>
			<td width="25%">
				<ul> 
					<logic:iterate id="desProductos" name="Contratados" property="descripcionProductosContratados">
					<bean:write name="desProductos"/><br>
					</logic:iterate>
				</ul> 
			</td>
			<td width="8%">
			<script>
			descripcionTipo('<bean:write name="Contratados" property="codTipoComportamiento"/>');
			</script>
			</td>
			<td width="4%">
			        <bean:write name="Contratados" property="descripLimiteConsumo"/>
            </td>
			<td width="15%">
					<script>
							var importeFloat = parseFloat('<bean:write name="Contratados" property="importe"/>');
							var resultado = addCommas(importeFloat);
							document.write(resultado);
					</script>
			</td>
			<td align="center">
				<input type="text" name="abono_lc" value="" id="abono_<%=idProducto%>" Disabled = "disabled" onkeyup="controlarAbono(this,<%=idProducto%>);" onkeypress="controlarAbono(this,<%=idProducto%>);"/>
			</td>					
				<td class="mensajeError">
					<div id="total_<%=idProducto%>">
						<script>
							var TotalimporteFloat = parseFloat('<bean:write name="Contratados" property="importe"/>');
							var Totalresultado = addCommas(TotalimporteFloat);
							document.write(Totalresultado);
							
						</script>
					</div>
				</td>
			</td>
		 </tr>
	<%idProducto++; %>
	  </logic:iterate>
	 </table>
	  	<script>
			var totalProd = <%=idProducto%>;
		</script>
		<input type="text" name="TotalProductos" id="TotalProductos" value="<%=idProducto%>" style="display:none">
	</table>
	</logic:greaterThan>
	</logic:present>      
	</td>
	</tr>
</table>
	</td>
	</tr>
 </table>