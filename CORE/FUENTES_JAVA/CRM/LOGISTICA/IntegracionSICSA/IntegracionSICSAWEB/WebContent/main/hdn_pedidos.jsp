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
    parent.tablaScroll('95%','250px');
 }
</script>
</head>
<body>
<div id="dv-pedidos">
<logic:present name="pedidos">
	<html:form styleId="formBusquedaDetallePedido" method="post"
	action="/action/BuscaDetallePedidoAction" target="ctrl">
	<div id="tableContainer" class="tableContainer" >
	<table border=0 class="scrollTable" >
		<thead class="fixedHeader">
		<tr>
			<th class=detalle>Número de Pedido</th>
			<th class=detalle>Estado</th>
			<th class=detalle>Fecha</th>
			<th class=detalle></th>
		</tr>
		</thead>
		<tbody class="scrollContent">
		<logic:iterate name="pedidos" id="grilla">
			<tr>
				<td class=detalle><bean:write name="grilla"
					property="codPedido" /></td>
				<td class=detalle><bean:write name="grilla"
					property="estadoPedido" /></td>
				<td class=detalle><bean:write name="grilla" property="fecPedido" /></td>
				<td class=detalle><img src="../images/buscar.gif" onclick="buscarDetallePedido('<bean:write name='grilla'
					property='codPedido' />');" style="cursor: pointer;">
				</td>
			</tr>
		</logic:iterate>
		</tbody>
	</table>
	</div>
	<html:hidden styleId="codPedidoBusc" property="codPedidoBusc"/>
	<html:hidden styleId="opcion" property="opcion" value="buscarDetalle" />
	</html:form>
</logic:present> <logic:notPresent name="pedidos">
	<center><label class="error">No se encontraron resultados.</label></center>
</logic:notPresent>
</div>
</body>
</html>