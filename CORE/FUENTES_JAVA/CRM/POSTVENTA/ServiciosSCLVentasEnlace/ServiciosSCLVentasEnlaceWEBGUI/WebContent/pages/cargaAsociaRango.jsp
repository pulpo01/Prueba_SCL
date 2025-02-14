<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<title>Asociación y desasociación de rangos a número piloto</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="/ServiciosSCLVentasEnlaceWEBGUI/estilos/estilos.css"/>
<script type='text/javascript'>
function fsalir(){
	alert('Recuerde cerrar la ventana despues de cerrar el browser.');
	if (navigator.appName=="Microsoft Internet Explorer") {
		this.focus();self.opener = this;self.close();
	} else {
		window.open('','_parent',''); window.close();
	}
}

function validaLongitud(obj, largo)
{
	if (obj != null && obj.value.length > largo)
	{
		alert("El campo " + obj.name + " excede la longitud permitida de " + largo + " caracteres.");
	}
}

function go()
{
	if (!confirm("¿Est\u00E1 Usted seguro(a) de ejecutar la orden de servicio?"))
		return;

	selectAll(document.getElementById("rangosAsociadosSelectId"));
	selectAll(document.getElementById("rangosDisponiblesSelectId"));

	document.asociaRangoForm.accion.value = 'ejecucion'; 
	
	document.asociaRangoForm.opcion[0].disabled = true;
	document.asociaRangoForm.opcion[1].disabled = true;
	
	document.asociaRangoForm.submit();
}

function fDesasociarRangos()
{
	moveOption(document.getElementById("rangosDisponiblesSelectId"), document.getElementById("rangosAsociadosSelectId"));			
}

function fAsociarRangos()
{
	moveOption(document.getElementById("rangosAsociadosSelectId"), document.getElementById("rangosDisponiblesSelectId"));			
}

function selectAll(target)
{
	for(i = 0; i < target.options.length; i++)
		target.options[i].selected = true;
}

function init()
{
	unselectAll(document.getElementById("rangosAsociadosSelectId"));
	unselectAll(document.getElementById("rangosDisponiblesSelectId"));
}

function unselectAll(target)
{
	for(i = 0; i < target.options.length; i++)
		target.options[i].selected = false;
}

function selectToProperty(source, target)
{
	target.value = "";

	for(i = 0; i < source.options.length; i++)
		target.value = target.value + source.options[i].value + ",";
}

function moveOption(destiny, source)
{
	if (source.options.length > 0)
		while(areThereSelectedOnes(source))
			for(i = 0; i < source.options.length; i++)
				if (source.options[i].selected)
				{
					addSelectOption(destiny, source.options[i].text, source.options[i].value, false);
					source.options[i] = null;
				}
}

function areThereSelectedOnes(selectObj)
{
	for(i = 0; i < selectObj.options.length; i++)
		if (selectObj.options[i].selected)
			return true;
			
	return false;
}

function addSelectOption(selectObj, text, value, isSelected) 
{
    if (selectObj != null && selectObj.options != null)
        selectObj.options[selectObj.options.length] = new Option(text, value, false, isSelected);
}
		</script>		
</head>
<body>
	<html:form action="/asociaRangoAction">
	<html:hidden property="accion" value="ejecucion" />
	<html:hidden property="numTransaccion" />
		<table width="600" align="center">
			<tr>
				<td class="TextoCampo" align="right"><bean:write name="fecha"/></td>
			</tr>
			<tr>
				<td class="TextoCampo" align="right">Usuario SCL: <bean:write name="asociaRangoForm" property="nomUsuarioSCL"/> / Num. Abonado: <bean:write name="asociaRangoForm" property="numAbonado"/></td>
			</tr>
		</table>
		<br>		
		<table class="principal" width="600" height="200" align="center" bordercolor="#9ECA52">
			<tr>
				<th align="left" colspan="2" bgcolor="#9ECA52" class="EncabezadoTabla">&gt;&gt; Asociación y desasociación de rangos a número piloto</th>
			</tr>
			<tr>
				<td class="TextoLabel" align="right">N&uacute;mero de Abonado&nbsp;</td>
				<td><html:text property="cargaAsociaRangoDTO.numAbonado" styleClass="TextoCampo" readonly="true" /></td>
				
			</tr>
			
			<tr>
				<td class="TextoLabel" align="right">Nombre del cliente&nbsp;</td>
				<td><html:text property="cargaAsociaRangoDTO.nomCliente" styleClass="TextoCampo" readonly="true" size="35"/></td>
			</tr>
			<tr>				
				<td class="TextoLabel" align="right">N&uacute;mero piloto&nbsp;</td>
				<td><html:text property="cargaAsociaRangoDTO.numCelular" styleClass="TextoCampo" readonly="true" /></td>				
			</tr>
			<tr>				
				<td class="TextoLabel" align="right">Comentario&nbsp;</td>
				<td><html:textarea property="comentario" onblur="validaLongitud(document.asociaRangoForm.comentario, 500);" styleClass="TextoCampo"  rows="5" cols="80"/></td>
			</tr>			
			<tr>
			<td colspan="2">
			<table cellspacing="10">
				<tr>
					<td align="center" class="TextoLabelNoAlign">Disponibles</td>					
					<td>&nbsp;</td>
					<td align="center" class="TextoLabelNoAlign">Asociados</td>
				</tr>
				<tr>
					<td width="150px"><html:select
						styleId="rangosDisponiblesSelectId"
						property="rangosDisponiblesSeleccionados" multiple="multiple"
						size="15" style="width: 210px" styleClass="TextoCampo">
						<logic:present name="asociaRangoForm"
							property="rangosDisponibles">
							<html:optionsCollection property="rangosDisponibles"
								value="value" label="label" />
						</logic:present>
					</html:select></td>
					<td>
					<table>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td nowrap><img
								src="/ServiciosSCLVentasEnlaceWEBGUI/imagenes/botones/FwkFirstOn.gif">
								<input type="button" value="Desasociar"
								style="height: 20px; width: 80px"
								onclick="fDesasociarRangos()" class="boton"> <img
								src="/ServiciosSCLVentasEnlaceWEBGUI/imagenes/botones/FwkFirstOn.gif">
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td nowrap><img
								src="/ServiciosSCLVentasEnlaceWEBGUI/imagenes/botones/FwkLastOn.gif">
							<input type="button" value="Asociar"
								style="height: 20px; width: 80px" onclick="fAsociarRangos();"
								class="boton"> <img
								src="/ServiciosSCLVentasEnlaceWEBGUI/imagenes/botones/FwkLastOn.gif">
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
					</td>
					<td width="150px"><html:select
						styleId="rangosAsociadosSelectId"
						property="rangosAsociadosSeleccionados" multiple="multiple"
						size="15" style="width: 210px" styleClass="TextoCampo">
						<logic:present name="asociaRangoForm"
							property="rangosAsociados">
							<html:optionsCollection property="rangosAsociados"
								value="value" label="label" />
						</logic:present>
					</html:select></td>
				</tr>
			</table>
			</td>
			</tr>
					<tr>
						<td align="center" colspan="2">
						<table>
							<tr>
								<td>
								<center><html:button styleClass="boton"
									property="opcion" value="Aceptar" onclick="go();"
									style="width: 80px" /></center>
								</td>
								<td>
								<center><html:button styleClass="boton"
									property="opcion" value="Salir" onclick="fsalir();"
									style="width: 80px" /></center>
								</td>
							</tr>
						</table>
						</td>
					</tr>
		</table>
	</html:form>
</body>
</html:html>