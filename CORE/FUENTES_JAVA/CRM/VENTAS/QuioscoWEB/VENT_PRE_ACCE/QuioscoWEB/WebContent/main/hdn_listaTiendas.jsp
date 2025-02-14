<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
String msgTienda = (String)request.getAttribute("msgTienda");

if(null==msgTienda||"".equals(msgTienda.trim()))
	 msgTienda="noMsg";
%>
<html>
<head>
<meta http-equiv="expires" content="0">
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
 	<%int cont = 0;%>
    var html = document.getElementById("tienda").innerHTML;
    parent.copiarDatos(html,"dv-lista-tiendas");
    //parent.document.getElementById("cadenaTienda").value = '<%=request.getAttribute("cadenaTien")%>';
    parent.limpiarMantTienda();
    parent.gifCargando('unload');  
     var msg = "<%= msgTienda%>";
         
    if("noMsg"!=msg)
         alert(msg);
}
</script>
<div id="tienda">
<div style="height: 320px; overflow: auto;">
<table id="tablaTienda" width="100%">
	<tr align="center" valign="top">
		<th width="auto" height="16">Nombre tienda</th>
		<th width="auto" height="16">Usuario SCL</th>
		<th width="auto" height="16">Usuario cajero</th>
		<th width="auto" height="16">Usuario</th>
		<th width="auto" height="16">C&oacutedigo cliente</th>
		<th width="auto" height="16">Caja</th>
		<th width="auto" height="16">Aplica Pago</th>			
		<th width="auto" height="16">eliminar / editar</th>
	</tr>
<logic:iterate id="lisTien" name="listaTienda" scope="session">
	<logic:notEmpty id="lisTien" name="listaTienda" scope="session">
			<tr align="center" valign="top" id="<bean:write name="lisTien" property="codTienda"/>" value="<%=++cont%> " ondblclick="copyLineaTienda(this.id, this.value)" >
				<td ><bean:write name="lisTien" property="nomTienda"/></td>
				<td><bean:write name="lisTien" property="usuaVendedor"/></td>
				<td><bean:write name="lisTien" property="usuacajero"/></td>
				<td><bean:write name="lisTien" property="usuaTien"/></td>
				<td><bean:write name="lisTien" property="codCliente"/></td>				
				<td><bean:write name="lisTien" property="desCaja"/></td>
				<td><bean:write name="lisTien" property="indApliPago"/></td>
				<td><input type="hidden" name="idLinTien" id="idLinTien" value="<bean:write name="lisTien" property="codTienda"/>" />
				<img name="elimLineaTien" id="<%=cont%>" src="<%=contextPath%>/imagenes/btnCancel.gif"  onclick="quitarLineaTienda('<bean:write name="lisTien" property="codTienda"/>');" /> 
				<img name="modiLineaTien" id="<%=cont%>" src="<%=contextPath%>/imagenes/editar2.png"   onclick="modificarLineaTienda('<bean:write name="lisTien" property="codTienda"/>', '<%=cont%>');" />
			</tr>
	</logic:notEmpty>
</logic:iterate>
</table>
</div>
</div>
</html>