<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JReferenciasClienteAJAX.js'></script>
<script>
	window.history.forward(1);
	var colorResaltado = "#CCCCCC";
	var colorNormal = "#F8F8F3";
					
	function fncInicio() {
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		
		var telefonoReferenciaFijo = document.getElementById("telefonoReferenciaFijo");
		if (telefonoReferenciaFijo != null) {
			telefonoReferenciaFijo.maxLength = largoNumCelular;
		}
		
		var telefonoReferenciaMovil = document.getElementById("telefonoReferenciaMovil");
		if (telefonoReferenciaMovil != null) {
			telefonoReferenciaMovil.maxLength = largoNumCelular;
		}
		
		if (document.getElementById("referencias") != null) {
			var totalFilas = document.getElementById("referencias").rows.length;
			var maximoReferencias = document.getElementById("maximoReferencias").value;
			if (parseInt(totalFilas)>parseInt(maximoReferencias)) {
					document.getElementById("divBtnAgregar").style["display"] = "none";
			}
		}
	}
	
	var telFijo = null;
	var telMovil = null;
	
	function fcnActualizar() {
		if (document.getElementById("nombreReferencia").value == "") {
		  	alert("Debe ingresar nombres.");
			return false;
		}
		var codTipoCliente = document.getElementById("codTipoCliente");
	  	var codTipoClienteEmpresa = document.getElementById("codTipoClienteEmpresa");
	  	var esEmpresa = codTipoCliente.value == codTipoClienteEmpresa.value;
	  	if (!esEmpresa) {
	  		if (document.getElementById("primerApellido").value == "") {
		  	   	alert("Debe ingresar primer apellido.");
		  	   	return false; 
		  	}
	  	}
	  	telFijo = document.getElementById("telefonoReferenciaFijo");
	  	telMovil = document.getElementById("telefonoReferenciaMovil");
	  	if ( (telFijo == null || telFijo.value == "") && (telMovil == null || telMovil.value == "") ) {
	  	   	alert("Debe ingresar al menos un tel\u00E9fono.");
	  	   	return false;
	  	}
	  	if (telFijo != null && telFijo.value != "") {
		  	JReferenciasClienteAJAX.validarTelefonoReferencia(telFijo.value, "F", resultadoValidarTelefonoFijo);
		} 
		else if (telMovil != null && telMovil.value != ""){
			JReferenciasClienteAJAX.validarTelefonoReferencia(telMovil.value, "M", resultadoValidarTelefonoMovil);	        		
		}
	}
	
	function resultadoValidarTelefonoFijo(data) {
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
	        	valido = data["valido"];
	        	if (!valido) {
	        		alert("El n\u00FAmero de tel\u00E9fono fijo ingresado no es v\u00E1lido.");
	        		return false;
	        	}
	        	else {
	        		telMovil = document.getElementById("telefonoReferenciaMovil");
	        		if (telMovil != null && telMovil.value != "") {
		        		JReferenciasClienteAJAX.validarTelefonoReferencia(telMovil.value, "M", resultadoValidarTelefonoMovil);	        		
	        		}
	        		else {
	        			document.getElementById("opcion").value = "actualizarListaReferencias";
						document.forms[0].submit();
	        		}
	        	}
	        }
	    }
	}
	
	function resultadoValidarTelefonoMovil(data) {
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
	        	valido = data["valido"];
	        	if (!valido) {
	        		alert("El n\u00FAmero de tel\u00E9fono m\u00F3vil ingresado no es v\u00E1lido.");
	        		return false;
	        	}
	        	else {
	        		document.getElementById("opcion").value = "actualizarListaReferencias";
					document.forms[0].submit();
	        	}
	        }
	    }
	}
	
	function fncLimpiar() {
		document.getElementById("divBtnModificar").style["display"] = "none";
		if (document.getElementById("referencias") != null) {
			var totalFilas = document.getElementById("referencias").rows.length;
			var maximoReferencias = document.getElementById("maximoReferencias").value;
			if (parseInt(totalFilas) > parseInt(maximoReferencias)) {
				document.getElementById("divBtnAgregar").style["display"] = "none";
			}
			else {
				document.getElementById("divBtnAgregar").style["display"] = "";
			}
			
			var tablaRef = document.getElementById("referencias").getElementsByTagName("TBODY")[0];
			var numReferencia = document.getElementById("numReferencia").value;
			var indiceFilaSel = parseInt(numReferencia) - 1;
			for (var i = 0; tr = tablaRef.getElementsByTagName('tr')[i]; i++) {
				if (i == indiceFilaSel) {
					var td = tr.getElementsByTagName('td')[0];
					td.style.backgroundColor=colorNormal;
				}
			}//fin for
		}

		document.getElementById("numReferencia").value = "0";
		document.getElementById("nombreReferencia").value = "";
		document.getElementById("primerApellido").value= "";
		document.getElementById("segundoApellido").value = "";
		document.getElementById("telefonoReferenciaFijo").value = "";
		document.getElementById("telefonoReferenciaMovil").value = "";
	}
	
	function fncMostrarReferencia(numReferencia, nombre, primerAp, segundoAp, telFijo, telMovil) {
		document.getElementById("divBtnAgregar").style["display"] = "none";
		document.getElementById("divBtnModificar").style["display"] = "";
		document.getElementById("numReferencia").value = numReferencia;
		document.getElementById("nombreReferencia").value = nombre; 
		document.getElementById("primerApellido").value= primerAp; 
		document.getElementById("segundoApellido").value = segundoAp; 
		document.getElementById("telefonoReferenciaFijo").value = telFijo;
		document.getElementById("telefonoReferenciaMovil").value = telMovil;
		var tablaRef = document.getElementById("referencias").getElementsByTagName("TBODY")[0];
		var indiceFilaSel = parseInt(numReferencia) - 1;
		for (var i = 0; tr = tablaRef.getElementsByTagName('tr')[i]; i++) {
			if (i == indiceFilaSel) {
				var td = tr.getElementsByTagName('td')[0];
				td.style.backgroundColor=colorResaltado;
			}
		}//fin for
	}
	
	function fncEliminarReferencia(numReferencia) {
		var tablaRef = document.getElementById("referencias").getElementsByTagName("TBODY")[0];
		var indiceFilaSel = parseInt(numReferencia) - 1;
		for (var i=0; tr=tablaRef.getElementsByTagName('tr')[i]; i++) {
			if (i==indiceFilaSel) {
				var td = tr.getElementsByTagName('td')[0];
				td.style.backgroundColor=colorResaltado;
			}
		}//fin for
		
		//si estaba modificando, cancela la acción
		if (document.getElementById("divBtnModificar").style["display"] == "") {
			document.getElementById("divBtnModificar").style["display"] = "none";
			var totalFilas = document.getElementById("referencias").rows.length;
			var maximoReferencias = document.getElementById("maximoReferencias").value;
			if (parseInt(totalFilas)>parseInt(maximoReferencias)) {
				document.getElementById("divBtnAgregar").style["display"] = "none";
			}
			else {
				document.getElementById("divBtnAgregar").style["display"] = "";
			}
			
			var numReferenciaAntSel = document.getElementById("numReferencia").value;
			if (numReferencia != numReferenciaAntSel) {//cambia color td anterior seleccionado
				var indiceFilaSelAnt = parseInt(numReferenciaAntSel) - 1;
				for (var i = 0; trAnt=tablaRef.getElementsByTagName('tr')[i]; i++) {
					if (i == indiceFilaSelAnt) {
						var tdAnt = trAnt.getElementsByTagName('td')[0];
						tdAnt.style.backgroundColor=colorNormal;
					}
				}//fin for
			}
			
			document.getElementById("numReferencia").value = "0";
			document.getElementById("nombreReferencia").value = "";
			document.getElementById("primerApellido").value= "";
			document.getElementById("segundoApellido").value = "";
			document.getElementById("telefonoReferenciaFijo").value = "";
			document.getElementById("telefonoReferenciaMovil").value = "";
		}
		
		if (confirm("¿Esta seguro que desea eliminar la referencia?")) {
			document.getElementById("numReferencia").value = numReferencia;
		  	document.getElementById("opcion").value = "eliminarReferencia";
	    	document.forms[0].submit();
		}
		else {
			for (var i = 0; tr=tablaRef.getElementsByTagName('tr')[i]; i++) {
				if (i == indiceFilaSel) {
					var td = tr.getElementsByTagName('td')[0];
					td.style.backgroundColor=colorNormal;
				}
			}//fin for
		}
	}
	
	function fncAceptar() {
	  	document.getElementById("opcion").value = "aceptar";
    	document.forms[0].submit();
	}
	
 	function fncCancelar() {
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}
	
  	// Muestra mensajes de error
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
</script>
</head>
<body onload="history.go(+1);fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/ReferenciasClienteAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="numReferencia" styleId="numReferencia"/>
	<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
	<html:hidden property="maximoReferencias" styleId="maximoReferencias"/>
	<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
	<html:hidden property="codTipoClienteEmpresa" styleId="codTipoClienteEmpresa"/>
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Creación de Clientes&nbsp;</h2>
			</td>
		</tr>
	</table>
	<P></p>
	<table width="90%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"></div>
			</td>
		</tr>
	</table>
	<bean:define id="codTipoClienteEmpresa" name="ReferenciasClienteForm"
		property="codTipoClienteEmpresa" type="java.lang.String" />
	<table width="90%" align="center">
		<tr>
			<td width="100%">
			<table width="100%">
				<tr>
					<td align="left" colspan="2"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
					Datos de Referencia:</td>
				</tr>
				<tr>
					<td align="left" width="25%"><logic:notEqual name="ReferenciasClienteForm"
						property="codTipoCliente" value="<%=codTipoClienteEmpresa%>">Nombres (*)
				</logic:notEqual> <logic:equal name="ReferenciasClienteForm" property="codTipoCliente"
						value="<%=codTipoClienteEmpresa%>">Nombre Empresa (*)
				</logic:equal></td>
					<td align="left" width="75%" colspan="2"><html:text name="ReferenciasClienteForm"
						property="nombreReferencia" style="text-transform: uppercase;" styleId="nombreReferencia"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="50"
						onchange="ocultarMensajeError();" /></td>
				</tr>
				<logic:notEqual name="ReferenciasClienteForm" property="codTipoCliente"
					value="<%= codTipoClienteEmpresa %>">
					<tr>
						<td align="left">Apellido 1 (*)</td>
						<td align="left" width="60%" colspan="2"><html:text name="ReferenciasClienteForm"
							property="primerApellido" style="text-transform: uppercase;" size="37" maxlength="20" styleId="primerApellido"
							onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
							onchange="ocultarMensajeError();" /></td>
					</tr>
					<tr>
						<td align="left">Apellido 2</td>
						<td align="left" width="60%" colspan="2"><html:text name="ReferenciasClienteForm"
							property="segundoApellido" style="text-transform: uppercase;" size="37" maxlength="20" styleId="segundoApellido"
							onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
							onchange="ocultarMensajeError();" /></td>
					</tr>
				</logic:notEqual>
				<tr>
					<td align="left">Tel&eacute;fono Fijo (*)</td>
					<td align="left" colspan="2"><html:text name="ReferenciasClienteForm"
						property="telefonoReferenciaFijo" style="text-transform: uppercase;" size="37" maxlength="15" styleId="telefonoReferenciaFijo"
						onkeypress="onlyInteger();" onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td align="left">Tel&eacute;fono M&oacute;vil (*)</td>
					<td align="left" colspan="2"><html:text name="ReferenciasClienteForm"
						property="telefonoReferenciaMovil" style="text-transform: uppercase;" size="37" maxlength="15" styleId="telefonoReferenciaMovil"
						onkeypress="onlyInteger();" onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td colspan="2" align="left">&nbsp</td>
				</tr>
				<tr>
					<td colspan="2" align="left"><i>(*): Datos obligatorios. Ingrese al menos un teléfono.
					</i></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divBtnAgregar">
			<table width="100%">
				<tr>
					<td align="left"></td>
					<td align="right" width="25%"><html:button value="AGREGAR" style="width:120px;color:black"
						property="btnAgregar" styleId="btnAgregar" onclick="ocultarMensajeError();fcnActualizar()" /></td>
				</tr>
			</TABLE>
			</div>
	</TABLE>
	<div id="divBtnModificar" style="display:none">
	<table width="100%">
		<tr>
			<td align="left"><html:button value="LIMPIAR" style="width:120px;color:black"
				property="btnLimpiar" styleId="btnLimpiar" onclick="ocultarMensajeError();fncLimpiar()" /></td>
			<td align="right" width="25%"><html:button value="MODIFICAR" style="width:120px;color:black"
				property="btnModificar" styleId="btnModificar" onclick="ocultarMensajeError();fcnActualizar()" /></td>
		</tr>
	</TABLE>
	</div>
	<table width="100%">
		<tr>
			<td colspan="2">
			<HR noshade>
			</td>
		</tr>
		</td>
		</tr>
		<logic:notEmpty name="ReferenciasClienteForm" property="arrayRefCliente">
			<tr>
				<td width="90%" align="center">
				<h2 align="left">Referencias:</h2>
				<display:table id="referencias" name="ReferenciasClienteForm" property="arrayRefCliente"
					scope="session" pagesize="10" requestURI="" width="100%">
					<display:column property="numReferencia" title="N&uacute;mero" headerClass="textoColumnaTabla"
						width="10%" align="center" />
					<display:column title="Nombre" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
						width="55%">
						<a
							href="javascript:fncMostrarReferencia('<bean:write name="referencias" property="numReferencia"/>','<bean:write name="referencias" property="nombreReferencia"/>','<bean:write name="referencias" property="primerApellido"/>','<bean:write name="referencias" property="segundoApellido"/>','<bean:write name="referencias" property="telefonoReferenciaFijo"/>','<bean:write name="referencias" property="telefonoReferenciaMovil"/>');">
						<FONT color="#0000ff"> <bean:write name="referencias" property="nombreReferencia" /> <logic:notEmpty
							name="referencias" property="primerApellido">
						&nbsp;<FONT color="#0000ff"><bean:write name="referencias" property="primerApellido" />
						</logic:notEmpty><logic:notEmpty name="referencias" property="segundoApellido">&nbsp;<FONT
								color="#0000ff"><bean:write name="referencias" property="segundoApellido" /> </FONT>
						</logic:notEmpty></a>
					</display:column>
					<display:column property="telefonoReferenciaFijo" title="Tel&eacute;fono Fijo"
						headerClass="textoColumnaTabla" width="10%" align="center" />
					<display:column property="telefonoReferenciaMovil" title="Tel&eacute;fono M&oacute;vil"
						headerClass="textoColumnaTabla" width="10%" align="center" />
					<display:column title="" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
						width="15%" align="center">
						<a
							href="javascript:fncEliminarReferencia('<bean:write name="referencias" property="numReferencia"/>');"><FONT
							color="#0000ff">Eliminar</FONT></a>
					</display:column>
				</display:table></td>
			</tr>
			<tr>
				<td width="90%">
				<table width="100%">
					<tr>
						<td align="right" colspan="2"
							style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
						M&aacute;ximo&nbsp;<bean:write name="ReferenciasClienteForm" property="maximoReferencias" />&nbsp;referencias
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</logic:notEmpty>
	</table>
	<P>
	<P></p>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td align="left" width="50%"></td>
			<td width="25%" align="right"><html:button value="CANCELAR" style="width:120px;color:black"
				property="btnCancelar" styleId="btnCancelar" onclick="ocultarMensajeError();fncCancelar()" /></td>
			<td width="25%" align="right"><html:button value="ACEPTAR" style="width:120px;color:black"
				property="btnAceptar" styleId="btnAceptar" onclick="ocultarMensajeError();fncAceptar()" /></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
