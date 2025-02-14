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
    var html = document.getElementById("dv-devoluciones").innerHTML;
    parent.copiarDatos(html,"dv-devoluciones");  
    html = document.getElementById("dv-titulo").innerHTML;
    parent.copiarDatos(html,"dv-titulo");
    parent.tablaScroll('95%','150px');
 }
</script>
</head>
<body>
<div id="dv-devoluciones">

<html:form styleId="formBusquedaDetalleDevolucion" method="post"
		action="/action/BuscaDetalleDevolucionAction" target="ctrl">
<logic:present	name="detalleDevolucionDTO">
	
		<div id="tableContainer" class="tableContainer">
		<table border=0 class="scrollTable" width="50%">
			<thead class="fixedHeader">
				<tr>
					<th class=detalle>C&oacute;digo Pedido</th>
					<th class=detalle>Articulo</th>
					<th class=detalle>Serie</th>
					<th class=detalle>Tipo Devoluci&oacute;n</th>
				</tr>
			</thead>
			<tbody class="scrollContent">
			<logic:iterate name="detalleDevolucionDTO" id="grilla">
				<tr>
					<td class=detalle><bean:write name="grilla"
					property="codPedido" /></td>
					<td class=detalle><bean:write name="grilla"
					property="desArticulo" /></td>
					<td class=detalle><bean:write name="grilla"
					property="serie" /></td>
					<td class=detalle><bean:write name="grilla"
					property="tipoDevolucion" /></td>
				</tr>
			</logic:iterate>
			</tbody>
		</table>
		</div>
		<input  style="position:absolute; right:8%;  width: 130px;" type="button" name="btnVolverDevoluciones" id="btnVolverDevoluciones" onclick="volverDevolucion();" value="Volver a devoluciones" class="barraarriba" />
		<br>
		<label onclick="exportarTXT();" style="cursor: pointer;" class="txtInfo" title="Exportar Series en formato TXT" >Exportar a TXT</label>
	<html:hidden styleId="linDevolucionBusc" property="linDevolucionBusc"/>
	<input type="hidden" id="codDevolucionBusc" name="codDevolucionBusc" value="<%=(String)request.getAttribute("codDevolucion")%>"/>
		
</logic:present> <logic:notPresent name="detalleDevolucionDTO">
	<label class="error">No se encontraron detalles para la devoluci&oacute;n.</label>
	<br><input type="button" name="btnVolverDevoluciones" id="btnVolverDevoluciones" onclick="volverDevolucion();" value="Volver a devoluciones" class="barraarriba" />
</logic:notPresent>
<html:hidden styleId="opcion" property="opcion"/>
</html:form>
</div>
<div id="dv-titulo">
	<label class="txtSubTitulo">Detalle de la devoluci&oacute;n <%=(String)request.getAttribute("codDevolucion")%></label>
</div>
</body>
</html>