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
    var html = document.getElementById("dv-datos").innerHTML;
    parent.copiarDatos(html,"dv-datos");  
    parent.tablaScroll('95%','150px');
 }
</script>
</head>
<body>
<div id="dv-datos">

<div id="tableContainer" class="tableContainer">
<table border=0 class="scrollTable" width="50%">
	<thead class="fixedHeader">
		<tr>
			<th class=detalle>Correo</th>
			<th class=detalle>Nombre</th>
			<th class=detalle></th>
			<th class=detalle></th>
		</tr>
	</thead>
	<tbody class="scrollContent">
		<logic:iterate name="correoDTOs" id="grilla">
			<tr>
				<td class=detalle><bean:write name="grilla" property="mail" /></td>
				<td class=detalle><bean:write name="grilla"
					property="usuario" /></td>
				<td class=detalle><img src="../images/borrar.png" onclick="eliminar('<bean:write name='grilla'
					property='mail' />');" style="cursor: pointer;"></td>
				<td class=detalle><img src="../images/editar.png" onclick="popUpModif('<bean:write name='grilla'
					property='mail' />','<bean:write name='grilla'
					property='usuario' />');" style="cursor: pointer;"></td>
			</tr>
		</logic:iterate>
	</tbody>
</table>
</div>
<br></br>
<label class="txtSubTitulo">NUEVO REGISTRO</label>
<br>
<table>
<tr>
			<td class=detalle>Correo <input type="text" name="txtNewCorreo" id="txtNewCorreo"/></td>
			<td class=detalle>Nombre <input type="text"  name="txtNewUsuario" id="txtNewUsuario" /></td>
			<td class=detalle><img src="../images/ok.gif" onclick="agregarCorreo();" style="cursor: pointer;"></td>
</tr>
</table>
<div class="divBloqueador" id="divBloqueador" style="display: none;">
<div class="pantModif">
<label class="txtSubTitulo">MODIFICAR REGISTRO</label>
<br>
<br></br>
<table>
<tr>
			<td>Correo <input type="text" name="modifCorreo" id="modifCorreo"/></td>
			<td>&nbsp;&nbsp;&nbsp; Nombre <input type="text"  name="modifUsuario" id="modifUsuario" /></td>
</tr>
<tr>
<td colspan="2" align="center"><br></br><br></br><b>
<label onclick="aceptarUpdt();" style="cursor: pointer;">Aceptar</label> 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

<label onclick="cancelarUpdt();" style="cursor: pointer;">Cancelar</label></b></td>
</tr>
</table>
</div>
</div>
</div>
</body>
</html>