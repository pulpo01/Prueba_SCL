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
    parent.tablaScroll('95%','250px');
 }
</script>
</head>
<body>
<div id="dv-devoluciones">
<logic:present name="devoluciones">
	<html:form styleId="formBusquedaDetalleDevolucion" method="post"
	action="/action/BuscaDetalleDevolucionAction" target="ctrl">
	<div id="tableContainer" class="tableContainer" >
	<table border=0 class="scrollTable" >
		<thead class="fixedHeader">
		<tr>
			<th class=detalle>N&uacute;mero de Devoluci&oacute;n</th>
			<th class=detalle>Estado</th>
			<th class=detalle>Fecha</th>
			<th class=detalle></th>
		</tr>
		</thead>
		<tbody class="scrollContent">
		<logic:iterate name="devoluciones" id="grilla">
			<tr>
				<td class=detalle><bean:write name="grilla"
					property="codDevolucion" /></td>
				<td class=detalle><bean:write name="grilla"
					property="estadoPedido" /></td>
				<td class=detalle><bean:write name="grilla" property="fecDevolucion" /></td>
				<td class=detalle><img src="../images/buscar.gif" onclick="buscarDetalleDevolucion('<bean:write name='grilla'
					property='codDevolucion' />');" style="cursor: pointer;">
				</td>
			</tr>
		</logic:iterate>
		</tbody>
	</table>
	</div>
	<html:hidden styleId="codDevolucionBusc" property="codDevolucionBusc"/>
	<html:hidden styleId="opcion" property="opcion" value="buscarDetalle" />
	</html:form>
</logic:present> <logic:notPresent name="devoluciones">
	<center><label class="error">No se encontraron resultados.</label></center>
</logic:notPresent>
</div>
</body>
</html>