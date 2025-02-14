<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
	HttpSession se = request.getSession();
%>
<html>
<head>
<meta http-equiv="expires" content="0">
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var tienda = <%=se.getAttribute("tienda")%>
    if(tienda == null || tienda ==""){
    var html = document.getElementById("dv-datos-login").innerHTML;  
    parent.copiarDatos(html,"dv-datos");  	    
    parent.copiarDatos("","dv-datos-vendedor");
    parent.copiarDatos("","dv-datos-link");
    
    }
    else{
    parent.enviarLoggeo('seguridad');
    }
    parent.gifCargando('unload');
}
</script>
<body>

<div id="dv-datos-login">
<table width="auto" height="auto" border="0">
	<tr>
		<td width=100 align=right class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Usuario</td>
		<td><input type="text" name="usuarioLogin" id="usuarioLogin"></td>
	</tr>
	<tr>
		<td width=100 align=right class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Clave</td>
		<td><input type="password" name="passwordLogin" id="passwordLogin"></td>
	</tr>
	<tr>
		<td width=100 align=right class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Tienda</td>
		<td><select name="tiendasLogin" id="tiendasLogin">
			<logic:iterate id="lista" name="listaTiendas">
				<option value="<bean:write name="lista" property="codTienda"/>"><bean:write name="lista"
					property="desTienda" /></option>
			</logic:iterate>
		</select></td>
	</tr>
	<tr>
		<td colspan=2 align=middle height=39>
			<input type="image" name="entrar" src="<%=contextPath%>/imagenes/entrar.png" onclick="enviarLoggeo('LoginForm');" />
			<input type="image" name="salir" src="<%=contextPath%>/imagenes/salir.png" onclick="cerrarVentana();" />
	</tr>
</table>
</div>
</body>
</html>