<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
    com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO[] clienteDTOs = (com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ClienteDTO[])session.getAttribute("categorias");
    com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[] regionDTOs = (com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.RegionDTO[])session.getAttribute("regiones");
    com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO[] identificadorCivilDTOs = (com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.IdentificadorCivilDTO[])session.getAttribute("tiposIdentificacion");
    com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO[] categoriasCambioDTOs = (com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CategoriaCambioDTO[]) session.getAttribute("categoriasCambio");
	String cargarCliente = (String)request.getAttribute("cargarCliente");
	String flgAplicaCategoriaCambio = (String)request.getAttribute("flgAplicaCategoriaCambio");
	
	if(null==cargarCliente)
		 cargarCliente="dv-datos-cliente-no";
	else
		cargarCliente="dv-datos-cliente-si";
	
	org.apache.commons.configuration.CompositeConfiguration config2;
	config2 = com.tmmas.cl.framework20.util.UtilProperty
			.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() { 
 	var dvDatos = "<%=cargarCliente%>"; 	
    var html = document.getElementById(dvDatos).innerHTML;    
    parent.copiarDatos(html,"dv-datos");    
    parent.gifCargando('unload');
}

</script>
<div id="dv-datos-cliente-no">
  <table width="479" border="0">
    <tr align="center" valign="top">
      <td colspan="2">REGISTRO DE CLIENTES PREPAGO</td>
    </tr>
    <tr>
      <td width="206">N&uacute;mero del celular del cliente</td>
      <td width="257"><input type="text" name="txtNumCelular" id="txtNumCelular"><img src="<%=contextPath%>/imagenes/btnBuscar.png" onclick="buscarCliente();"/>/<img src="<%=contextPath%>/imagenes/limpiar.png" onclick="limpiarCliente();"/></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>Tipo de identificaci&oacute;n </td>
      <td><select name="cboTipoIdentificacion" id="cboTipoIdentificacion">
      <option value="seleccione">seleccione</option>
       <%
    	for(int i=0;i<=identificadorCivilDTOs.length-1;i++){
    		%><option value="<%=identificadorCivilDTOs[i].getCodigoTipIdentif()%>"><%=identificadorCivilDTOs[i].getDescripcionTipIdentif()%></option>
      <%}
      %>
      </select></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>N&uacute;mero de identificaci&oacute;n</td>
      <td><input type="text" name="txtNumeroIdentificacion" id="txtNumeroIdentificacion" value="<bean:write name="cliente" property="numIdent"/>"></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>Nombre del Cliente </td>
      <td><input type="text" name="txtNombreCliente" id="txtNombreCliente" value="<bean:write name="cliente" property="nomCliente"/>"></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>Primer Apellido </td>
      <td><input type="text" name="txtPrimerApellido" id="txtPrimerApellido" value="<bean:write name="cliente" property="apellidoPaterno"/>"></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">&nbsp</span>Segundo Apellido </td>
      <td><input type="text" name="txtSegundoApellido" id="txtSegundoApellido" value="<bean:write name="cliente" property="apellidoMaterno"/>"></td>
    </tr>
    <tr>
      <td><span class="campoObligatorio">*</span>Categoria</td>
      <td><select name="cboCategoria" id="cboCategoria">
      <option value="seleccione">seleccione</option>
      <%
    	for(int i=0;i<=clienteDTOs.length-1;i++){
    		%><option <%if(clienteDTOs[i].getCodigoCategoria().equals(config2.getString("cod.categoria.prepago"))){out.println("selected");}%> value="<%=clienteDTOs[i].getCodigoCategoria()%>"><%=clienteDTOs[i].getDescripcionCategoria()%></option>
      <%}
	  %>
         
      </select></td>
    </tr>
    <!-- P-CSR-11002 - Inicio -->
    <tr>
      <bean:define id="mostrar" value="<%=flgAplicaCategoriaCambio%>" />
      <logic:equal name="mostrar" value="1">
	  <td  id="tdLabelCategoriaCambio"><span class="campoObligatorio">*</span>Categor&iacute;a de Cambio</td>
      <td  id="tdComboCategoriaCambio"><select name="cboCategoriaCambio" id="cboCategoriaCambio">
      <option value="seleccione">seleccione</option>
      <%
      if (null != categoriasCambioDTOs){
    	for(int i=0;i<=categoriasCambioDTOs.length-1;i++){
    		%><option value="<%=categoriasCambioDTOs[i].getCodCategoria()%>"><%=categoriasCambioDTOs[i].getDesCategoria()%></option>
      <%}
      }
	  %>         
      </select></td>
      </logic:equal>
    </tr>
    <logic:equal name="flagCtrlClasifCrediticia" value="1">
    <tr>
	  <td><span class="campoObligatorio">*</span>Crediticia</td>
      <td>
      <select name="cboCrediticia" id="cboCrediticia">
      	<logic:iterate name="crediticias" id="crediticia">
      	<logic:equal name="crediticia" property="indDefecto" value="1">
    	<option selected="selected" value="<bean:write name="crediticia" property="codClasificacion"/>"><bean:write name="crediticia" property="desClasificacion"/></option>
    	</logic:equal>
    	<logic:notEqual name="crediticia" property="indDefecto" value="1">
    	<option value="<bean:write name="crediticia" property="codClasificacion"/>"><bean:write name="crediticia" property="desClasificacion"/></option>
    	</logic:notEqual>
    	</logic:iterate>
      </select>
      </td>
    </tr>
    </logic:equal>
    <logic:equal name="flagCtrlClasifCrediticia" value="0">
    <tr style="display: none;">
	  <td><span class="campoObligatorio">*</span>Crediticia</td>
      <td>
      <select name="cboCrediticia" id="cboCrediticia">
      	<logic:iterate name="crediticias" id="crediticia">
      	<logic:equal name="crediticia" property="indDefecto" value="1">
    	<option selected="selected" value="<bean:write name="crediticia" property="codClasificacion"/>"><bean:write name="crediticia" property="desClasificacion"/></option>
    	</logic:equal>
    	<logic:notEqual name="crediticia" property="indDefecto" value="1">
    	<option value="<bean:write name="crediticia" property="codClasificacion"/>"><bean:write name="crediticia" property="desClasificacion"/></option>
    	</logic:notEqual>
    	</logic:iterate>
      </select>
      </td>
    </tr>
    </logic:equal>
    <!-- P-CSR-11002 - Fin -->
    <tr>
      <td colspan="2"></td>
    </tr>
    <tr>
      <td height="30" align="left" valign="bottom">DIRECCION</td>
      <td>&nbsp;</td>
    </tr>
    
    <logic:present name="datosDireccion">
    
	<bean:define id="direccionDTO" name="datosDireccion" property="direccionDTO"/>
	
	<bean:define id="conceptos" name="direccionDTO" property="conceptoDireccionDTOs"/>
    
    <logic:iterate id="concepto" name="conceptos">
    
      <tr>
      <td><logic:equal name="concepto" property="obligatoriedad" value="true"><span class="campoObligatorio">*</span></logic:equal>
          <logic:notEqual name="concepto" property="obligatoriedad" value="true"><span class="campoObligatorio">&nbsp</span></logic:notEqual>
		  <logic:notEqual name="concepto" property="caption" value="TIPO CALLE"><bean:write name="concepto" property="caption"/></logic:notEqual></td>
      <td>
      	<input type="hidden" name="tipoControl" id="tipo_control_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="tipoControl"/>">
		<input type="hidden" name="esObligatorio" id="es_obligatorio_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="obligatoriedad"/>">						
		<input type="hidden" name="caption" id="caption_<bean:write name="concepto" property="nombreColumna"/>" value="<bean:write name="concepto" property="caption"/>">
		
		<bean:define id="tipoControl" name="concepto" property="tipoControl"/>
		<logic:equal name="tipoControl" value="CMB">
		<logic:notEqual name="concepto" property="nombreColumna" value="COD_TIPOCALLE">
		<div id="dv-<bean:write name="concepto" property="nombreColumna"/>">
		<select name="control" id="control_<bean:write name="concepto" property="nombreColumna"/>" onchange="fncOnChangeCMB('<bean:write name="concepto" property="nombreColumna"/>');">
			<option value="seleccione">seleccione</option>
			<logic:notEmpty name="concepto" property="datosDireccionDTO">
			<bean:define id="datosDireccion" name="concepto" property="datosDireccionDTO"/>
			<logic:iterate id="datoDireccion" name="datosDireccion">
				<option value="<bean:write name="datoDireccion" property="codigo"/>"><bean:write name="datoDireccion" property="descripcion"/></option>
			</logic:iterate>
			</logic:notEmpty>
		</select>
		</div>
		</logic:notEqual>
		</logic:equal>
		<logic:equal name="tipoControl" value="TXT">			 							
      		<input type="text" name="control" id="control_<bean:write name="concepto" property="nombreColumna"/>" maxlength="<bean:write name="concepto" property="largoMaximo"/>" value="">
      	</logic:equal>
      	
      </td>
    </tr>
    
    </logic:iterate>
    </logic:present>
        
    <tr align="CENTER" valign="top">
     <td><img src="<%=contextPath%>/imagenes/CONTINUAR.jpg" onclick="registroClienteFin();"></td>
    </tr>
    <tr align="CENTER" valign="top">
     <td> <span class="campoObligatorio">* Campos Obligatorios</span></td>
    </tr>   
  </table>
  
    <div id="dv-provincia-vacio" style="display: none;">
      <select name="cboProvincia" id="cboProvincia">
      <option value="seleccione">seleccione</option>
      </select>
      </div>
      <div id="dv-ciudad-vacio" style="display: none;">
      <select name="cboCiudad" id="cboCiudad">
       <option value="seleccione">seleccione</option>
      </select>
      </div>
      <div id="dv-comuna-vacio" style="display: none;">
      <select name="cboComuna" id="cboComuna">
       <option value="seleccione">seleccione</option>
      </select>
     </div>
          
     <input type="hidden" name="codClienteHidden" id="codClienteHidden" value="0">
     <input type="hidden" name="codCuentaHidden"  id="codCuentaHidden"  value="0">
</div>

<div id="dv-datos-cliente-si">
  <table width="479" border="0">
    <tr align="center" valign="top">
      <td colspan="2">REGISTRO DE CLIENTES PREPAGO</td>
    </tr>
    <tr>
      <td width="206">N&uacute;mero del celular del cliente</td>
      <td width="257"><input type="text" name="txtNumCelular" id="txtNumCelular"><img src="<%=contextPath%>/imagenes/btnBuscar.png" onclick="buscarCliente();"/>/<img src="<%=contextPath%>/imagenes/limpiar.png" onclick="limpiarCliente();"/></td>
    </tr>
    <tr>
      <td>Tipo de identificaci&oacute;n </td>
      <td>
      <select name="cboTipoIdentificacion" id="cboTipoIdentificacion">
    		<option value="<bean:write name="cliente" property="codigoTipIdentif"/>"><bean:write name="cliente" property="descipcionTipIdentif"/></option>
      </select>
      </td>
    </tr>
    <tr>
      <td>N&uacute;mero de identificaci&oacute;n</td>
      <td><input type="text" name="txtNumeroIdentificacion" id="txtNumeroIdentificacion"  disabled="disabled" value="<bean:write name="cliente" property="numIdent"/>"></td>
    </tr>
    <tr>
      <td>Nombre del Cliente </td>
      <td><input type="text" name="txtNombreCliente"  id="txtNombreCliente" disabled="disabled" value="<bean:write name="cliente" property="nomCliente"/>"></td>
    </tr>
    <tr>
      <td>Primer Apellido </td>
      <td><input type="text" name="txtPrimerApellido" id="txtPrimerApellido" disabled="disabled" value="<bean:write name="cliente" property="apellidoPaterno"/>"></td>
    </tr>
    <tr>
      <td>Segundo Apellido </td>
      <td><input type="text" name="txtSegundoApellido" id="txtSegundoApellido" disabled="disabled" value="<bean:write name="cliente" property="apellidoMaterno"/>"></td>
    </tr>
    <tr>
      <td>Categoria</td>
      <td><select name="cboCategoria" id="cboCategoria">
		<option value="<bean:write name="cliente" property="codCategoria"/>"><bean:write name="cliente" property="descripcionCategoria"/></option>
      </select></td>
    </tr>
    <!-- P-CSR-11002 - INICIO -->
    <tr>
      <td>Categor&iacute;a de Cambio</td>
      <td><select name="cboCategoriaCambio" id="cboCategoriaCambio">
		<option value="<bean:write name="cliente" property="codCategoriaCambio"/>"><bean:write name="cliente" property="desCategoriaCambio"/></option>
      </select></td>
    </tr>
    <logic:equal name="flagCtrlClasifCrediticia" value="1">
    <tr>
	  <td>Crediticia</td>
      <td>
      <select name="cboCrediticia" id="cboCrediticia">
    	<option value="<bean:write name="cliente" property="codCrediticia"/>"><bean:write name="cliente" property="desCrediticia"/></option>
      </select>
      </td>
    </tr>
    </logic:equal>
    <!-- P-CSR-11002 - FIN -->
    <tr>
      <td colspan="2"></td>
    </tr>
    <tr>
      <td height="30" align="left" valign="bottom">DIRECCION</td>
      <td>&nbsp;</td>
    </tr>
    <logic:present name="datosDireccion2">
    
    <bean:define id="direccionDTO2" name="datosDireccion2" property="direccionDTO"/>
	
	<bean:define id="conceptos2" name="direccionDTO2" property="conceptoDireccionDTOs"/>
    
    <logic:iterate id="concepto2" name="conceptos2">
    	
      <tr>
      <td><logic:notEqual name="concepto2" property="caption" value="TIPO CALLE"><bean:write name="concepto2" property="caption"/></logic:notEqual></td>
      <td>
      	<input type="hidden" name="tipoControl" id="tipo_control_<bean:write name="concepto2" property="nombreColumna"/>" value="<bean:write name="concepto2" property="tipoControl"/>">
		<input type="hidden" name="esObligatorio" id="es_obligatorio_<bean:write name="concepto2" property="nombreColumna"/>" value="<bean:write name="concepto2" property="obligatoriedad"/>">						
		<input type="hidden" name="caption" id="caption_<bean:write name="concepto2" property="nombreColumna"/>" value="<bean:write name="concepto2" property="caption"/>">
		
		<bean:define id="tipoControl2" name="concepto2" property="tipoControl"/>
		<logic:equal name="tipoControl2" value="CMB">
		<logic:notEqual name="concepto2" property="nombreColumna" value="COD_TIPOCALLE">
		<div id="dv-<bean:write name="concepto2" property="nombreColumna"/>">
		<select name="control" id="control_<bean:write name="concepto2" property="nombreColumna"/>" >
			<logic:notEmpty name="concepto2" property="datosDireccionDTO">
			<bean:define id="datosDireccion2" name="concepto2" property="datosDireccionDTO"/>
			<logic:iterate id="datoDireccion2" name="datosDireccion2">
				<option value="<bean:write name="datoDireccion2" property="codigo"/>"><bean:write name="datoDireccion2" property="descripcion"/></option>
			</logic:iterate>
			</logic:notEmpty>
		</select>
		</div>
		</logic:notEqual>
		</logic:equal>
		<logic:equal name="tipoControl2" value="TXT">
			<logic:notEmpty name="concepto2" property="datosDireccionDTO">
			<bean:define id="datosDireccion2" name="concepto2" property="datosDireccionDTO"/>
			<logic:iterate id="datoDireccion2" name="datosDireccion2">
				<input type="text" name="control2" disabled="disabled" id="control_<bean:write name="concepto2" property="nombreColumna"/>" maxlength="<bean:write name="concepto2" property="largoMaximo"/>" value="<bean:write name="datoDireccion2" property="descripcion"/>">
			</logic:iterate>
			</logic:notEmpty>			 							
      	</logic:equal>
      </td>
    </tr>
    
    </logic:iterate>
    </logic:present>
    <tr align="CENTER" valign="top">
     <td><img src="<%=contextPath%>/imagenes/CONTINUAR.jpg" onclick="registroClienteFin();"></td>
    </tr>
  </table>
   <input type="hidden" name="codClienteHidden" id="codClienteHidden" value="<bean:write name="clienteCuenta" property="codCliente"/>">
    <input type="hidden" name="codCuentaHidden"  id="codCuentaHidden"  value="<bean:write name="clienteCuenta" property="codCuenta"/>">
</div>
</html>