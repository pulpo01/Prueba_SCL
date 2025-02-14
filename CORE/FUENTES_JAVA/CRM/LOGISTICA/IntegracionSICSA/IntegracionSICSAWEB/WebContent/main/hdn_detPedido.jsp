<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IntegracionSICSA</title>
<script type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-pedidos").innerHTML;
    parent.copiarDatos(html,"dv-pedidos");  
    html = document.getElementById("dv-titulo").innerHTML;
    parent.copiarDatos(html,"dv-titulo");
    parent.tablaScroll('95%','150px');
 }
</script>
</head>
<body>
<div id="dv-pedidos">

<html:form styleId="formBusquedaDetallePedido" method="post"
		action="/action/BuscaDetallePedidoAction" target="ctrl">
<logic:present	name="detallePedidoDTO">
	
		<div id="tableContainer" class="tableContainer">
		<table border=0 class="scrollTable" width="50%">
			<thead class="fixedHeader">
				<tr>
					<th class=detalle>Tipo Stock</th>
					<th class=detalle>Modelo</th>
					<th class=detalle>Tecnologia</th>
					<th class=detalle>Cantidad</th>
					<th class=detalle>Precio Unitario</th>
					<th class=detalle>Valor Neto</th>
				</tr>
			</thead>
			<tbody class="scrollContent">
			<logic:iterate name="detallePedidoDTO" id="grilla">
				<tr onclick='mostrarSeries("<bean:write name='grilla'
					property='linPedido'/>","<bean:write name='grilla'
					property='desArticulo'/>")' style="cursor: pointer;" title="Ver series">
					<td class=detalle><bean:write name="grilla"
					property="desStock" /></td>
					<td class=detalle><bean:write name="grilla"
					property="desArticulo" /></td>
					<td class=detalle><bean:write name="grilla"
					property="desTecnologia" /></td>
					<td class=detalle><bean:write name="grilla"
					property="cantidad" /></td>
					<td class=detalle><bean:write name="grilla"
					property="mtoUnitario" /></td>
					<td class=detalle><bean:write name="grilla"
					property="mtoNeto" /></td>
				</tr>
			</logic:iterate>
			</tbody>
		</table>
		</div>
		<input  style="position:absolute; right:8%;  width: 120px;" type="button" name="btnVolverPedidos" id="btnVolverPedidos" onclick="volverPedidos();" value="Volver a los pedidos" class="barraarriba" />
		<br>
		<label class="txtSubTitulo">Series</label>
	<div id="dv-series"><label class="txtInfo">Seleccione un articulo para ver sus series</label></div>
	<html:hidden styleId="linPedidoBusc" property="linPedidoBusc"/>
	<input type="hidden" id="codPedidoBusc" name="codPedidoBusc" value="<%=(String)request.getAttribute("codPedido")%>"/>
	<html:hidden styleId="nomArticulo" property="nomArticulo"/>
	
</logic:present> <logic:notPresent name="detallePedidoDTO">
	<label class="error">No se encontraron detalles para el pedido.</label>
	<br><input type="button" name="btnVolverPedidos" id="btnVolverPedidos" onclick="volverPedidos();" value="Volver a los pedidos" class="barraarriba" />
</logic:notPresent>
<html:hidden styleId="opcion" property="opcion"/>
</html:form>
</div>
<div id="dv-titulo">
	<label class="txtSubTitulo">Detalle del pedido <%=(String)request.getAttribute("codPedido")%></label>
</div>
</body>
</html>