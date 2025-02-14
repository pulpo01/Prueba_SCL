<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<head>
<title>Ingreso de datos</title>
<script>
 	function fncIngresarDireccion(){
		  	document.getElementById("opcion").value = "ingresarDireccionInstalacion";
	    	document.forms[0].submit();
	 }
	 
</script>	
</head>
<html:form method="POST" action="/DatosCorreoClienteAction.do"> 
<html:hidden property="opcion" value="inicio"/>
<html:hidden property="nombreProducto"  />
<html:hidden property="tipoCorreo"  />
<html:hidden property="largoNumCelular"  />

<table width="100%" border="0">	
	<tr>
		<td colspan="2"><h2 class="textoSubTitulo">Datos Adicionales Correo Movistar Seven</h2></td>
	</tr>
	<tr>	
		<td width="10%">&nbsp;</td>	
		<td colspan="7">
		<table width="100%"><!-- tabla principal -->
		<tr>
			<td width="30%">&nbsp;</td>
			<td width="70%">&nbsp;</td>
		</tr>
		
		<tr>
			<td  class="campoInformativo">Descripci&oacute;n del Producto</td>
			<td  class="valorCampoInformativo"><script>document.writeln(DatosCorreoClienteForm.nombreProducto.value)</script></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td align="left">Nombre del Contacto(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="nombreContacto"  style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="50"/></td>
		</tr>
		
		<logic:equal name="DatosCorreoClienteForm"  property="tipoCorreo" value="PEREMP">
		<tr>
			<td align="left">Correo Electr&oacute;nico Empresarial(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="correoElectronicoEmpresa" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);validaCorreo(this,correoElectronicoEmpresa);" size="50" maxlength="50"/></td>
		</tr>
		<tr>
			<td align="left">Correo Electr&oacute;nico Personal(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="correoElectronicoPersonal" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);validaCorreo(this,correoElectronicoPersonal);" size="50" maxlength="50"/></td>			
		</tr>
		</logic:equal>

		<logic:equal name="DatosCorreoClienteForm"  property="tipoCorreo" value="PER">
		<tr>
			<td align="left">Correo Electr&oacute;nico Personal(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="correoElectronicoPersonal" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);validaCorreo(this,correoElectronicoPersonal);" size="50" maxlength="50"/></td>			
		</tr>
		</logic:equal>
		
		<logic:equal name="DatosCorreoClienteForm"  property="tipoCorreo" value="EMP">
		<tr>
			<td align="left">Correo Electr&oacute;nico Empresarial(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="correoElectronicoEmpresa" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);validaCorreo(this,correoElectronicoEmpresa);" size="50" maxlength="50"/></td>
		</tr>
		</logic:equal>
		
		<tr>
			<td align="left">Tel&eacute;fono Cliente(*)</td>
			<td><html:text name="DatosCorreoClienteForm" property="telefono"  size="20" style="text-transform: uppercase;" onkeypress="onlyInteger();" maxlength="15"/></td>
		</tr>
		<tr>
			<td align="left" >
				<a href="javascript:fncIngresarDireccion();" ><FONT color="#0000ff">Ingresar Direcci&oacute;n de Instalaci&oacute;n(*)</FONT></a> 
			</td>
			<td>
				<html:text name="DatosCorreoClienteForm" property="direccionInstalacion" size="80" readonly="true" maxlength="80" />
			</td>			                               
		</tr>
		</table>
		</td>
	</tr>
	<tr>
      <td colspan="2" align="right">
	      <img src="botones/btn_aceptar.gif" name="Aceptar" width="85" height="19"  border="0" id="Aceptar"   align="siguiente"
		onmouseover="sobreElBoton('Aceptar','botones/btn_aceptar_roll.gif')" onmouseout="sobreElBoton('Aceptar','botones/btn_aceptar.gif')"
		onclick="guardarDatosAdicProducto();"
		/>
      </td>
    </tr>
<table>
</html:form>
