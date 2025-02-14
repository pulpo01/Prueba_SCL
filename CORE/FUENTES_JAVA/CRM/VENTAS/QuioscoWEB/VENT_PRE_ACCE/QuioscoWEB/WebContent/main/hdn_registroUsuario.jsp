<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();

com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO[] centrales= (com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CentralDTO[])request.getAttribute("centrales");
%>	
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-datos-usuario").innerHTML;
    parent.copiarDatos(html,"dv-datos");  
    parent.gifCargando('unload');	    
}
</script>
<div id="dv-datos-usuario">
  <table width="479" border="0">
    <tr align="center" valign="top">
      <td colspan="2">REGISTRO DE USUARIO PREPAGO</td>
    </tr>
    <tr align="left" valign="top">
      <td colspan="2">DATOS GENERALES</td>
    </tr>
    <tr>
      <td>Cliente: <bean:write name="clienteRegistrado" property="nomCliente"/></td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td>Serie:  <bean:write name="lineaVO" property="simcard"/> </td>
      <td>Celular: <bean:write name="lineaVO" property="celular"/>&nbsp;
      <%if(null!=centrales&&centrales.length>0){%> 
       -&nbsp;Simcard No Es Numerada, Por Favor Seleccione Un Producto:
      <select name="cboCentrales" id="cboCentrales">
      <option value="seleccione">seleccione</option>
       <%
    	for(int i=0;i<=centrales.length-1;i++){
    		%><option value="<%=centrales[i].getCodigoCentral()%>"><%=centrales[i].getDescripcionCentral()%></option>
      <%}
      %>
      </select>
      <%}else{%>
      <input type="hidden" name="cboCentrales" id="cboCentrales" value="0">
      <%} %>
	  </td>
    </tr>
    <tr>
      <td height="40" align="left" valign="bottom">DATOS PERSONALES </td>
      <td>&nbsp;</td>
    </tr>
    <tr>
      <td width="206"><span class="campoObligatorio">*</span>Nombre del Usuario </td>
      <td width="257"><input type="text" name="txtNombreUsuario" id="txtNombreUsuario" value="<bean:write name="clienteRegistrado" property="nomCliente"/>">        </td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>Primer Apellido </td>
      <td><input type="text" name="txtPrimerApellido" id="txtPrimerApellido" value="<bean:write name="clienteRegistrado" property="apellidoPaterno"/>" ></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">&nbsp</span>Segundo Apellido</td>
      <td><input type="text" name="txtSegundoApellido" id="txtSegundoApellido" value="<bean:write name="clienteRegistrado" property="apellidoMaterno"/>" ></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">&nbsp</span>E-Mail</td>
      <td><input type="text" id="txtMail" name="txtMail"></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">&nbsp</span>Telefono Contacto </td>
      <td><input type="text" name="txtTelefonoContacto" id="txtTelefonoContacto"></td>
    </tr>
    <tr align="center" valign="top">
      <td colspan="2"> <img src="<%=contextPath%>/imagenes/CONTINUAR.jpg" onclick="registrarUsuario();"></td>
    </tr>
    <tr align="CENTER" valign="top">
     <td> <span class="campoObligatorio">* Campos Obligatorios</span></td>
    </tr> 
  </table>
  <input type="hidden" name="hiddenSimcard" id="hiddenSimcard" value="<bean:write name="lineaVO" property="simcard"/>">
  <input type="hidden" name="hiddenCelular" id="hiddenCelular" value="<bean:write name="lineaVO" property="celular"/>">
  <input type="hidden" name="hiddenTerminal" id="hiddenTerminal" value="<bean:write name="lineaVO" property="imei"/>">
</div>
</html>