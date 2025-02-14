<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link rel="stylesheet" type="text/css" href="/css/mas.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mas.css" />
<script type="text/javascript" src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JConsultaVentasVendedorAJAX.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JSolicitudScoringAJAX.js'></script>
<script type="text/javascript">

	DWREngine.setErrorHandler(errorHandler);
	
	function aceptar(o) {
		o.disabled = true;
		if (validar()) {
			validarTarjeta();
		}
		else {
			o.disabled = false;
			return false;
		}
	}
	
	function finalizarSolicitud() {
		document.body.style.cursor = "wait";
		document.getElementsByName("opcion")[0].value = "finalizarSolicitud";
		document.forms[0].submit();
	}
	
	function validarTarjeta() {
		var codTipoTarjeta = obtenerControl("codTipoTarjeta");
		var codTipoTarjetaSCL = obtenerControl("codTipoTarjetaSCL");
		var numTarjeta = obtenerControl("numTarjeta");
		if (codTipoTarjeta.value != "") {
			JSolicitudScoringAJAX.validarTarjeta(numTarjeta.value, codTipoTarjetaSCL.value, resultadoValidarTarjeta);
		}
		else {
			finalizarSolicitud();
		}
	}
	
	function errorHandler(msg, exc) {
  		alert("Error: + \n -Description [" + msg.description + "]\n -Message [" + msg.message + "]");
	}
	
	function resultadoValidarTarjeta(data) {
		if (data != null) {
	       	var codError = data["codError"];
	       	if (codError == "-100") {
				fncInvocarPaginaExpiraSesion();
		        return;
		    }
	        var valido = data["valido"];
	        if (!valido) {
		       	mostrarMensajeError(data["msgError"]);
		       	var aceptarButton = obtenerControl("aceptarButton");
		       	document.getElementById("numTarjeta").focus();
		       	aceptarButton.disabled = false;
		       	return;
		    }
        	finalizarSolicitud();
	    }
	}
	
	function anterior() {
		document.getElementById("opcion").value = "anterior";
	   	document.forms[0].submit();
	}
	
	function validar() {
		var codTipoDocumento = document.getElementById("codTipoDocumento");
		if (codTipoDocumento.value == "") {
			alert("Debe seleccionar Tipo de Identificación");
			return false;
		}
		else {
			var documento = document.getElementById("documento");
			if (codTipoDocumento.value == "C") {
				var ingresoCedulaMandatorio = document.getElementById("ingresoCedulaMandatorio");
				if ( ingresoCedulaMandatorio.value == "SI" && nullOrEmpty(documento.value) ) {
					alert("Debe ingresar N° Identificación");
					return false;
				}
			}
			else if (codTipoDocumento.value == "P") {
				var ingresoPasaporteMandatorio = document.getElementById("ingresoPasaporteMandatorio");
				if ( ingresoPasaporteMandatorio.value == "SI" && nullOrEmpty(documento.value) ) {
					alert("Debe ingresar N° Identificación");
					return false;
				}
			}
		}
		
		var primer_nombre = document.getElementsByName("primer_nombre")[0].value;
		if (primer_nombre == "") {
			alert("Debe ingresar Primer Nombre");
			return false;
		}
		
		var segundo_nombre = document.getElementsByName("segundo_nombre")[0].value;
		if (segundo_nombre == "") {
			alert("Debe ingresar Segundo Nombre");
			return false;
		}
		
		var codNacionalidad = document.getElementsByName("codNacionalidad")[0].value;
		if (codNacionalidad == "") {
			alert("Debe seleccionar Nacionalidad");
			return false;
		}
	
		var codEstadoCivil = document.getElementsByName("codEstadoCivil")[0].value;
		if (codEstadoCivil == "") {
			alert("Debe seleccionar Estado Civil");
			return false;
		}
		
		var codNivelAcademico = document.getElementsByName("codNivelAcademico")[0].value;
		if (codNivelAcademico == "") {
			alert("Debe seleccionar Nivel Académico");
			return false;
		}
		
		var codTipoEmpresa = document.getElementsByName("codTipoEmpresa")[0].value;
		if (codTipoEmpresa == "") {
			alert("Debe seleccionar Tipo Empresa");
			return false;
		}
		
		var antiguedad_laboral = document.getElementsByName("antiguedad_laboral")[0].value;
		if (antiguedad_laboral == null || antiguedad_laboral == "") {
			alert("Debe ingresar Antigüedad Laboral (Años)");
			return false;
		}
		
		if (document.getElementById("ingresosMensuales").value == "" || document.getElementById("ingresosMensuales").value == 0 ) {
	  	   	alert("Debe agregar Ingresos Mensuales");
	  		return false;
	  	}
		
		var codTipoTarjeta = document.getElementsByName("codTipoTarjeta")[0];
		if (codTipoTarjeta.value != "") {
			var codBancoTarjeta = document.getElementsByName("codBancoTarjeta")[0];
			if (codBancoTarjeta.value == "") {
				alert ("Debe seleccionar Banco");
	  	   		return false;
			}
			if (!esFechaValida()) {
				alert ("Fecha de Vencimiento no válida");
				return false;
			}
			var codTipoTarjetaSCL = document.getElementsByName("codTipoTarjetaSCL")[0];
			if (codTipoTarjetaSCL.value == "") {
				alert ("Debe seleccionar Marca");
	  	   		return false;
			}
			var numTarjeta = document.getElementsByName("numTarjeta")[0];
			if (numTarjeta == null || numTarjeta.value == "") {
				alert ("Debe ingresar N° Tarjeta");
	  	   		return false;
			}
		}
		return true;
	}
	
	function esFechaValida() {
		var mesSel = parseInt(document.getElementById("mesVencimientoTarjeta").value);
		var anioSel = parseInt(document.getElementById("anioVencimientoTarjeta").value);
		var hoy = new Date();
		if (hoy.getFullYear() < anioSel) {
			return true;
		} 
		else if (hoy.getFullYear() == anioSel) {
			return ((hoy.getMonth() + 1) < mesSel);
		}
		return false;
	}
	
	function activarDesactivarControlesTarjeta(b) {
		document.getElementById("tarjetaTable").style["display"] = b ? "" : "none";
		if (!b) {
			document.getElementById("codBancoTarjeta").value = "";
    		document.getElementById("numTarjeta").value = "";
			document.getElementById("codTipoTarjetaSCL").selectedIndex = 0;
			document.getElementById("mesVencimientoTarjeta").selectedIndex = 0;
			document.getElementById("anioVencimientoTarjeta").selectedIndex = 0;
		}
	}
	
	function codTipoTarjeta_onchange(obj) {
		if (obj != null && obj.value != "") {
			activarDesactivarControlesTarjeta(true);
		}
		else {
			activarDesactivarControlesTarjeta(false);
		}
	}
	
	function body_onload() {
		document.body.style.cursor = "auto";
		var aceptarButton = document.getElementById("aceptarButton");
		if (aceptarButton != null) {
			aceptarButton.disabled = false;
		}
	}

	function codTipoDocumento_onchange(o) {
		var documento = document.getElementById("documento");
		documento.value = "";
		if (o != null && o.value != "") {
			var documentoLabel = document.getElementById("documentoLabel");
			if (o.value == "C") {
				documento.maxLength = 11;
				var ingresoCedulaMandatorio = document.getElementById("ingresoCedulaMandatorio");
				if (ingresoCedulaMandatorio.value == "SI") {
					documentoLabel.innerHTML = "N° Identificación (*):";
				}
				else {
					documentoLabel.innerHTML = "N° Identificación:";
				}
			}
			else if (o.value == "P") {
				documento.maxLength = 20;
				var ingresoPasaporteMandatorio = document.getElementById("ingresoPasaporteMandatorio");
				if (ingresoPasaporteMandatorio.value == "SI") {
					documentoLabel.innerHTML = "N° Identificación (*):";
				}
				else {
					documentoLabel.innerHTML = "N° Identificación:";
				}
			}
		}
		else {
			documento.maxLength = 0;
		}
	}
	
	function fncValidaMontoDecimal(campoTexto) {
  		if (campoTexto.value!="") {
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)) {
	  	  		alert("Monto inv\u00E1lido");
	  	  		campoTexto.value = "";
	  	  		campoTexto.focus();
	  	  	}
		}
	}
	
	function numTarjeta_onblur(o) {

	}
	
	function codTipoTarjetaSCL_onchange(o) {

	}
	
	function documento_onkeypress(o) {
		var codTipoDocumento = document.getElementById("codTipoDocumento");
		if (codTipoDocumento.value == "C") {
			cambiaAMayuscula();
			if ( !(esA_Z() || esDigito() || esGuion() || esEspacio()) ) {
				window.event.keyCode = '';
			}
		}
		else if (codTipoDocumento.value == "P") {
			cambiaAMayuscula();
			if ( !(esA_Z() || esDigito()) ) {
				window.event.keyCode = '';
			}
		}
		else {
			window.event.keyCode = '';
		}
	}
	
	function obtenerControl(nombre) {
		return document.getElementsByName(nombre)[0];
	}
	
	function mostrarMensajeError(mensaje) {
	    window.alert(mensaje);
	}
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}

</script>
</head>
<body onload="body_onload()" onkeydown="validarTeclas()">
<html:form method="POST" action="/SolicitudScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden name="SolicitudScoringForm" property="nit" styleId="nit"/>
	<html:hidden name="SolicitudScoringForm" property="codCliente" styleId="codCliente"/>
	<html:hidden name="SolicitudScoringForm" property="primer_apellido" styleId="primer_apellido"/>
	<html:hidden name="SolicitudScoringForm" property="segundo_apellido" styleId="segundo_apellido"/>
	<html:hidden name="SolicitudScoringForm" property="ingresoCedulaMandatorio" styleId="ingresoCedulaMandatorio"/>
	<html:hidden name="SolicitudScoringForm" property="ingresoPasaporteMandatorio" styleId="ingresoPasaporteMandatorio"/>
	<table>
		<tr>
			<td class="amarillo">
			<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left" />Solicitud Scoring</h2>
			</td>
		</tr>
	</table>
	<p />
	<div id="wrapper">
	<table>
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"><bean:write name="SolicitudScoringForm"
				property="mensajeError" /></div>
			</td>
		</tr>
	</table>
	<p />
	<table>
		<tr>
			<td colspan="4">
			<h3>Datos del Cliente:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">NIT (*):</td>
			<td class="col2"><bean:write name="SolicitudScoringForm" property="nit" /></td>
			<td class="col1">Código Cliente:</td>
			<td class="col2"><bean:write name="SolicitudScoringForm" property="codCliente" /></td>
		</tr>
		<tr>
			<td class="col1">Tipo Identificación (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codTipoDocumento" styleId="codTipoDocumento"
				onchange="codTipoDocumento_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioTipoDocumento"
					value="codigo" label="valor" />
			</html:select></td>
			<td class="col1"><label id="documentoLabel">N° Identificaci&oacute;n:</label></td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="documento" styleId="documento" maxlength="0" onkeypress="documento_onkeypress()" /></td>
		</tr>
		<tr>
			<td class="col1">Primer Nombre (*):</td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="primer_nombre" styleId="primer_nombre"
				maxlength="20" onkeypress="soloCaracteresValidos();onlyUpperCase();" /></td>
			<td class="col1">Segundo Nombre (*):</td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="segundo_nombre" styleId="segundo_nombre"
				maxlength="20" onkeypress="soloCaracteresValidos();onlyUpperCase();" /></td>
		</tr>
		<tr>
			<td class="col1">Apellido Paterno (*):</td>
			<td class="col2"><bean:write name="SolicitudScoringForm" property="primer_apellido" /></td>
			<td class="col1">Apellido Materno (*):</td>
			<td class="col2"><bean:write name="SolicitudScoringForm" property="segundo_apellido" /></td>
		</tr>
		<tr>
			<td class="col1">Fecha Nacimiento (*):</td>
			<td class="col2"><bean:write name="SolicitudScoringForm" property="fecha_nacimiento"
				format="dd-MM-yyyy" /></td>
			<td class="col1">Nacionalidad (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codNacionalidad" styleId="codNacionalidad">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioNacionalidad"
					value="codigo" label="valor" />
			</html:select></td>
		</tr>
		<tr>
			<td class="col1">Estado Civil (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codEstadoCivil" styleId="codEstadoCivil">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioEstadoCivil"
					value="codigo" label="valor" />
			</html:select></td>
			<td class="col1">Nivel Académico (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codNivelAcademico" styleId="codNivelAcademico">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioNivelAcademico"
					value="codigo" label="valor" />
			</html:select></td>
		</tr>
	</table>
	<table>
		<tr>
			<td colspan="4">
			<hr />
			</td>
		</tr>
		<tr>
			<td colspan="4">
			<h3>Datos Laborales:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">Tipo Empresa (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codTipoEmpresa" styleId="codTipoEmpresa">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioTipoEmpresa"
					value="codigo" label="valor" />
			</html:select></td>
			<td class="col1">Antigüedad Laboral (Años) (*):</td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="antiguedad_laboral" styleId="antiguedad_laboral"
				maxlength="2" onkeypress="onlyInteger()" /></td>
		</tr>
		<tr>
			<td class="col1">Ingresos Mensuales:</td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="ingresosMensuales" styleId="ingresosMensuales"
				onkeypress="onlyFloat(this.value,4)" onblur="fncValidaMontoDecimal(this);" size="30"
				maxlength="15" /></td>
			<!-- <td class="col1"><html:button property="actualizaButton" onclick="actualizarIngresos()"
				style="width: 112px">Actualizar Ingresos</html:button></td>
			<td class="col2"></td>-->
		</tr>
	</table>
	<table>
		<tr>
			<td colspan="4">
			<hr />
			</td>
		</tr>
		<tr>
			<td colspan="4">
			<h3>Datos Tarjeta:</h3>
			</td>
		</tr>
		<tr>
			<td class="col1">Tipo Tarjeta:</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codTipoTarjeta" styleId="codTipoTarjeta"
				onchange="codTipoTarjeta_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
				<html:optionsCollection name="SolicitudScoringForm" property="arrayDominioTipoTarjeta"
					value="codigo" label="valor" />
			</html:select></td>
			<td class="col1"></td>
			<td class="col2"></td>
		</tr>
	</table>
	<table id="tarjetaTable" style="display: none;">
		<tr>
			<td class="col1">Banco (*):</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codBancoTarjeta" styleId="codBancoTarjeta">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="SolicitudScoringForm" property="bancos">
					<html:optionsCollection name="SolicitudScoringForm" property="bancos" value="codigoBanco"
						label="descripcionBanco" />
				</logic:notEmpty>
			</html:select></td>
			<td class="col1">Fecha Vencimiento (mm/yyyy) (*):</td>
			<td class="col2">
				<table style="text-align: left;">
					<tr>
						<td width="25%"><html:select style="width: 100%;" name="SolicitudScoringForm" styleId="mesVencimientoTarjeta"
							property="mesVencimientoTarjeta">
							<html:options name="SolicitudScoringForm" property="rangoMeses" />
						</html:select></td>
						<td width="5%">/</td>
						<td width="25%"><html:select style="width: 100%;" name="SolicitudScoringForm"
							property="anioVencimientoTarjeta" styleId="anioVencimientoTarjeta">
							<html:options name="SolicitudScoringForm" property="rangoAnios" />
						</html:select></td>
						<td width="45%"></td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class="col1">Marca (*)</td>
			<td class="col2"><html:select name="SolicitudScoringForm" property="codTipoTarjetaSCL" styleId="codTipoTarjetaSCL"
				onchange="codTipoTarjetaSCL_onchange(this)">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="SolicitudScoringForm" property="tiposTarjetaSCL">
					<html:optionsCollection name="SolicitudScoringForm" property="tiposTarjetaSCL"
						value="codigoTarjeta" label="descripcionTarjeta" />
				</logic:notEmpty>
			</html:select></td>
			<td class="col1">N° Tarjeta (*):</td>
			<td class="col2"><html:text name="SolicitudScoringForm" property="numTarjeta" maxlength="16" styleId="numTarjeta"
				onkeypress="onlyInteger()" onblur="numTarjeta_onblur(this)" /></td>
		</tr>
	</table>
	<hr />
	<p />
	<table class="botones">
		<tr>
			<td class="col1"><html:button property="anteriorButton" onclick="anterior()" styleId="anteriorButton"
				style="width: 180px"><<</html:button></td>
			<td class="col2"></td>
			<td class="col1"></td>
			<td class="col2"><html:button property="aceptarButton" onclick="aceptar(this)" styleId="aceptarButton"
				style="width: 180px">ACEPTAR</html:button></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
