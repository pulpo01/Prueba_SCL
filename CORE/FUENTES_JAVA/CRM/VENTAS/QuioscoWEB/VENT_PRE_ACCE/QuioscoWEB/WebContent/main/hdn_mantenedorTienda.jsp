<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO cajaDTOs = (com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsCajaOutDTO)session.getAttribute("cajasDTO");

%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-datos-mantencion").innerHTML;
    parent.copiarDatos(html,"dv-datos");
    parent.opcMantenedorTienda("cargaIni");
    parent.gifCargando('unload');

}
</script>
<div id="dv-datos-mantencion">
  <table width="650" border="0">
    <tr align="center" valign="top">
      <td colspan="3">Mantenedor de tiendas</td>
    </tr>
    <tr>
      <td>
      <Table border="1" bordercolor="green" align="center">
      	<tr>
	    	<td>Nombre de la tienda</td>
	      	<td>Usuario SCL</td>
	     	<td>Cajero</td>
    	</tr>
    	<tr>
	    	<td><input type="text" name="textNomTienda" maxlength="30" onblur="soloLetras2(event.keyCode);"
	    	onkeypress="soloLetras2(event.keyCode);"></td>
	      	<td><input type="text" name="textCajero" maxlength="30" onblur="soloLetras2(event.keyCode);"
	      	onkeypress="soloLetras2(event.keyCode);"></td>
			<td><input name="textCaja" type="text" maxlength="30" onblur="soloLetras2(event.keyCode);"
			onkeypress="soloLetras2(event.keyCode);"></td>
    	</tr>
   		<tr>
     		<td>C&oacutedigo cliente</td>
	  		<td>Caja</td>
	  		<td>Aplica Pago</td>
    	</tr>
    	<tr>
	  		<td><input type="text" name="textCodCliente" maxlength="30" onblur="soloLetras2(event.keyCode);"
	  		onkeypress="soloLetras2(event.keyCode);"></td>
	  		<td><select name="cboCaja" id="cboCaja">
	  			<option value="seleccione">seleccione</option>
      			<%
    			  for(int i=0;i<=cajaDTOs.getCajaDTOs().length-1;i++){
    				%><option value="<%=cajaDTOs.getCajaDTOs()[i].getCodCaja()%>"><%=cajaDTOs.getCajaDTOs()[i].getDesCaja()%></option>
      			<%}
	  			%>         
      		</select></td>
 			<td>
 				<select name="cboApliPago" id="cboApliPago">
	  			<option value="seleccione">seleccione</option>
	  			<option value="0">NO</option> 
	  			<option value="1">SI</option>        
      		</select>
 			</td>
    	</tr>
    	<tr>
    	<td colspan="3" align="center" onClick="agregarTiendaMant();"><input type="image" name="agregarTienda" src="<%=contextPath%>/imagenes/add.png" />Agregar tienda</td>
    	</tr>
       </Table> 
     </td>
    <tr>
      <td colspan="3"></td>
    </tr>
    <tr align="CENTER" valign="top">
     <td colspan="3"><div id="dv-lista-tiendas"></div></td>
    </tr>
  </table>
</div>
</html>