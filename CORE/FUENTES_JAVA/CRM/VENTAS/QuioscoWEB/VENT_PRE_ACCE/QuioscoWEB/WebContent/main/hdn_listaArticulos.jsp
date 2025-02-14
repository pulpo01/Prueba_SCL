<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
    String msgTipif = (String)request.getAttribute("msgTipif");

	if(null==msgTipif||"".equals(msgTipif.trim()))
		 msgTipif="noMsg";
%>
<html>
<head>
<meta http-equiv="expires" content="0">
<script language="JavaScript" type="text/javascript">
onload = function() {
	<%int cont = 0;%>
    var html = document.getElementById("articulo").innerHTML;
    parent.copiarDatos(html,"dv-lista-articulos");
    parent.document.getElementById("cadenaArticulos").value = '<%=request.getAttribute("cadenaArti")%>';
    parent.limpiarMantClientizar();
    parent.gifCargando('unload');
    var msg = "<%= msgTipif%>";
    if("noMsg"!=msg)
         alert(msg);
}
</script>
</head>
<div id="articulo">
<div style="height: 300px; overflow: auto;">
<table id="tablaArticulo" width="100%">
	<tr align="center" valign="top">
		<th width="auto" height="16">C&oacute;digo articulo</th>
		<th width="auto" height="16">C&oacute;digo tipificaci&oacute;n</th>
		<th width="auto" height="16">Descripci&oacute;n Tipificaci&oacute;n </th>
		<!--  th width="auto" height="16">Tipificaci&oacute;n</th -->
		<th width="auto" height="16">Clientizable</th>
		<th width="auto" height="16">Usuario SCL</th>
		<th width="auto" height="16">eliminar/editar</th>
	</tr>
<logic:iterate id="lisArt" name="listaArticulo" scope="session">
	<logic:notEmpty id="lisArt" name="listaArticulo" scope="session">
		<tr align="center" valign="top" id="<bean:write name="lisArt" property="codArticulo"/>" value="<%=++cont%>" ondblclick="copyLinea(this.id, this.value)">
			<td><bean:write name="lisArt" property="codArticulo"/></td>
			<td><bean:write name="lisArt" property="codTipificacion"/></td>
			<td><bean:write name="lisArt" property="descripcion"/></td>
			<!--  td><bean:write name="lisArt" property="tipificacion"/></td -->
			<td><bean:write name="lisArt" property="clientizable"/></td>
			<td><bean:write name="lisArt" property="usuaSclClient"/></td>
			<td><input type="hidden" name="idLinArt" id="idLinArt" value="<bean:write name="lisArt" property="codArticulo"/>" />
			<img name="elimLinea" id="<%=cont%>"  src="<%=contextPath%>/imagenes/btnCancel.gif"  onclick="quitarLinea('<bean:write name="lisArt" property="codArticulo"/>');"/>
			/<img name="modiLinea" id="<%=cont%>" src="<%=contextPath%>/imagenes/editar2.png"  onclick="modificarLinea('<bean:write name="lisArt" property="codArticulo"/>', '<%=cont%>');" />
		</tr>
	</logic:notEmpty>
</logic:iterate>
</table>
</div>
</div>
</html>