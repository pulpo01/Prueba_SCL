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
    var html = document.getElementById("dv-datos-mantencion").innerHTML;
    parent.copiarDatos(html,"dv-datos");
    parent.opcMantenedorClientizar("cargaIni");
    parent.gifCargando('unload');

}
</script>
<div id="dv-datos-mantencion">
  <table width="650" border="0">
    <tr align="center" valign="top">
      <td colspan="3">Mantenedor clientizar - Tipificar art&iacute;culos</td>
    </tr>
    <tr>
      <td>
      <Table bordercolor="green" border="1" align="center">
	      <tr>
	      	<td>C&oacute;digo articulo</td>
	        <td>C&oacute;digo tipificaci&oacute;n</td>
	        <td>Descripci&oacute;n de Tipificaci&oacute;n:</td>
	      </tr>
	      <tr>
	      	<td><input type="text" name="txtCodigoArticulo" id="txtCodigoArticulo" maxlength="6" onblur="extractNonNumbers(this,0,false);"
			onkeypress="return blockNonNumbers(this, event, false, false);"></td>
	        <td><input type="text" name="txtCodigoTipificacion" name="txtCodigoTipificacion" maxlength="10" onblur="soloLetras2(event.keyCode);"
	        onkeypress="soloLetras2(event.keyCode);"></td>
	        <td><input name="txtDescripcion" type="text" maxlength="40"
	        onkeypress="soloLetras2(event.keyCode)"></td>
	      </tr>
          <tr>
      	  <form name="radioForm">
			<td>Clientizar Si<input name="radiobuttonClientizar" id="radiobuttonClientizar" type="radio" value="1" checked></td>
			<td>Clientizar No<input name="radiobuttonClientizar" id="radiobuttonClientizar" type="radio" value="0"></td>
	      </form>
	      	<td align="right" onClick="agregarArticuloClientizar();"><input type="image" name="agregarArticulo" src="<%=contextPath%>/imagenes/add.png" />
    		Agregar articulo</td>
          </tr>
   	</Table> 
     </td>
    <tr>
      <td colspan="3"></td>
    </tr>
    <tr align="CENTER" valign="top">
     <td colspan="3"><div id="dv-lista-articulos"></div></td>
    </tr>
  </table>
</div>
</html>