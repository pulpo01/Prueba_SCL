<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href='<%=request.getContextPath()%>/css/mas.css' rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JClienteCarrierPasilloLDIAJAX.js'></script>
<script type="text/javascript">
	
	function configurarForm() {
		var numCelularExterno = document.getElementById("numCelularExterno");
		var maxLength = '<bean:write name="ClienteCarrierPasilloLDIForm" property="largoNumTelefonoExterno" />';
		
		numCelularExterno.setAttribute('maxLength', maxLength);
			
		var mensaje = document.getElementById('mensaje').value;
		
		if (mensaje != null && mensaje != "") {
			window.alert(mensaje);
			document.getElementById("opcion").value = "irAMenu";
   			document.forms[0].submit();
		}
	
		var codTipoCliente = document.getElementById('codTipoCliente').value;
		if (codTipoCliente == "2") {
			document.getElementById("formParticular").style["display"] = "";
			document.getElementById("formEmpresa").style["display"] = "none";
			return;	
		}
		if (codTipoCliente == "1") {
			document.getElementById("formParticular").style["display"] = "none";
			document.getElementById("formEmpresa").style["display"] = "";
			return;	
		}
	}
	
	function enviar() {
		var codTipoCliente = document.getElementById("codTipoCliente").value;
		var nombres = document.getElementById("nombres").value;
		var apellido1 = document.getElementsByName("apellido1")[0].value;
		var nombreEmpresa = document.getElementById("nombreEmpresa").value;
		var numCelularExterno = document.getElementById("numCelularExterno").value;
		var direccionFacturacion = document.getElementById("direccionFacturacion").value;
		
		switch(codTipoCliente) {
			case "2": { 
			 	if (nombres == null || nombres == "") {
					alert("El campo \"Nombres\" es obligatorio");
					return false;
				}
				if (apellido1 == null || apellido1 == "") {
					alert("El campo \"Apellido 1\" es obligatorio");   
					return false;
				}
				break;
			}
			case "1": {
			  	if (nombreEmpresa == null || nombreEmpresa == "") {
					alert("El campo \"Nombre Empresa\" es obligatorio");
					return false;
				}
				break;
			}
			default: return false;
		}
		if (direccionFacturacion == null || direccionFacturacion == "") {
			alert ("El campo \"Dirección de Facturación\" es obligatorio");
			return false;
		}
		if (numCelularExterno == null || numCelularExterno == "") {
			alert ("El campo \"N° Teléfono\" es obligatorio");
			return false;
		}
		else {
			JClienteCarrierPasilloLDIAJAX.validarTelefonoLDI(numCelularExterno, resultadoValidarTelefonoLDI);
		}
	}
	
	function resultadoValidarTelefonoLDI(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError = data['msgError']; 
	        if (codError != "") {
				if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        else {
	        	valido = data['valido'];
	        	if (!valido) {
	        		alert("El n\u00FAmero de tel\u00E9fono ingresado no es v\u00E1lido.");
	        		return false;
	        	}
	        	else {
       				document.getElementsByName("opcion")[0].value = "enviar";
					document.forms[0].submit();
	        	}
	        }
	    }
	}
	
	function ingresarDireccion() {
		document.getElementById("opcion").value = "ingresarDireccionFacturacion";
   		document.forms[0].submit();
	}
	
    function soloNumeros(evt) {
    	var charCode = (evt.which) ? evt.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
			return false;
		}
		return true;
	}

</script>
</head>
<body onload="configurarForm();">
<div style="width: 100%; text-align: left;"><html:form
	action="/ClienteCarrierPasilloLDIAction.do" enctype="multipart/form-data">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden name="ClienteCarrierPasilloLDIForm" property="mensaje" styleId="mensaje" />
	<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
		hspace="2" align="left" />Alta Cliente Pasillo LDI</h2>
	<div style="margin-left: 10%; margin-right: 10%; ";><br />
	<table style="width: 100%">
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"><bean:write name="ClienteCarrierPasilloLDIForm"
				property="mensajeError" /></div>
			</td>
		</tr>
	</table>
	<br />
	<table id="formTipoCliente" style="width: 100%;">
		<tr>
			<td style="width: 20%;">Tipo de Cliente (*)</td>
			<td style="width: 80%;"><html:select style="width: 50%" name="ClienteCarrierPasilloLDIForm"
				property="codTipoCliente" styleId="codTipoCliente" onchange="configurarForm();">
				<logic:notEmpty name="ClienteCarrierPasilloLDIForm" property="arrayTipoCliente">
					<html:optionsCollection name="ClienteCarrierPasilloLDIForm" property="arrayTipoCliente"
						value="codigoValor" label="descripcionValor" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
		<tr>
			<td style="width: 20%;">Plan Tarifario (*)</td>
			<td style="width: 80%;"><html:select style="width: 50%" name="ClienteCarrierPasilloLDIForm"
				property="codigoPlanTarifario" styleId="codigoPlanTarifario">
				<logic:notEmpty name="ClienteCarrierPasilloLDIForm" property="arrayPlanTarifario">
					<html:optionsCollection name="ClienteCarrierPasilloLDIForm" property="arrayPlanTarifario"
						value="codigoPlanTarifario" label="descripcionPlanTarifario" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
	</table>
	<table id="formParticular" style="width: 100%;">
		<tr>
			<td style="width: 20%;">Nombres (*):</td>
			<td style="width: 80%;"><html:text style="width: 50%; text-transform: uppercase;"
				name="ClienteCarrierPasilloLDIForm" property="nombres" maxlength="50" styleId="nombres"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" /></td>
		</tr>
		<tr>
			<td>Apellido 1 (*):</td>
			<td><html:text style="width: 50%; text-transform: uppercase;"
				name="ClienteCarrierPasilloLDIForm" property="apellido1" maxlength="20" styleId="apellido1"
				onkeypress="soloCaracteresValidos()" onblur="upperCase(this);" /></td>
		</tr>
		<tr>
			<td>Apellido 2:</td>
			<td><html:text style="width: 50%; text-transform: uppercase;"
				name="ClienteCarrierPasilloLDIForm" property="apellido2" maxlength="20" styleId="apellido2"
				onkeypress="soloCaracteresValidos()" onblur="upperCase(this);" /></td>
		</tr>
	</table>
	<table id="formEmpresa" style="width: 100%; display: none; ">
		<tr>
			<td style="width: 20%;">Nombre Empresa (*):</td>
			<td style="width: 80%;"><html:text style="width: 50%; text-transform: uppercase;"
				name="ClienteCarrierPasilloLDIForm" property="nombreEmpresa" maxlength="50" styleId="nombreEmpresa"
				onkeypress="soloCaracteresValidos()" onblur="upperCase(this);" /></td>
		</tr>
		<tr>
			<td>Razón Social:</td>
			<td><html:text style="width: 50%; text-transform: uppercase;"
				name="ClienteCarrierPasilloLDIForm" property="razonSocial" maxlength="50" styleId="razonSocial"
				onkeypress="soloCaracteresValidos()" onblur="upperCase(this);" /></td>
		</tr>
	</table>
	<table id="formNumCelular" style="width: 100%;">
		<tr>
			<td style="width: 20%;">N° Teléfono (*):</td>
			<td style="width: 80%;"><html:text style="width: 50%" name="ClienteCarrierPasilloLDIForm"
				property="numCelularExterno" onkeypress="return soloNumeros(event)" styleId="numCelularExterno" /></td>
		</tr>
		<tr>
			<td style="width: 20%;"><a href="javascript:ingresarDireccion()">Dirección de
			Facturación (*):</a></td>
			<td style="width: 80%;"><html:text readonly="true" style="width: 50%"
				name="ClienteCarrierPasilloLDIForm" property="direccionFacturacion" styleId="direccionFacturacion" /></td>
		</tr>
		<tr>
			<td></td>
			<td><html:button property="btnEnviar" styleId="btnEnviar" onclick="javascript:enviar();"
				style="width: 20%; color:black; text-transform: uppercase;">Enviar</html:button></td>
		</tr>
		<tr>
			<td colspan="2"><i>(*): Campos obligatorios</i></td>
		</tr>
	</table>
	</div>
</html:form></div>
</body>
</html>
