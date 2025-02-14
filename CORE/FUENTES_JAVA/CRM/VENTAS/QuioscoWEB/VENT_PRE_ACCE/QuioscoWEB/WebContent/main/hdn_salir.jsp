<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-datos-login").innerHTML;
    parent.copiarDatos(html,"dv-datos"); 
    parent.gifCargando('unload'); 	   
}
</script>
<div id="dv-datos-login">
<Table>
	<tr>
		<td>
		<table width=100% border="1" bordercolor="#848484">
			<!-- <tr>
						<th colspan=2> <h1>Ingrese su nombre de usuario, clave y tienda</h1></th>
						<br>
					</tr> -->
			<tr>
				<td width=100 align="right" class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Usuario</td>
				<td><input type="text" name="usuarioLogin" id="usuarioLogin"></td>
			</tr>
			<tr>
				<td width=100 align="right" class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Clave</td>
				<td><input type="password" name="passwordLogin" id="passwordLogin"></td>
			</tr>
			<tr>
				<td width=100 align="right" class="login"><img src="<%=contextPath%>/imagenes/fecha.JPG">Tienda</td>
				<td><select name="tiendasLogin" id="tiendasLogin">
					<option>Seleccione</option>
				</select></td>
			</tr>
			<tr>
				<td colspan=2 align=middle height=39><input type="image" name="entrar"
					src="<%=contextPath%>/imagenes/entrarLogin.png" onclick="enviarLoggeo();" /> <!-- <input type="submit" value="Ingresar" > -->
			</tr>
		</table>
		</td>
	</tr>
</Table>
</div>
</html>