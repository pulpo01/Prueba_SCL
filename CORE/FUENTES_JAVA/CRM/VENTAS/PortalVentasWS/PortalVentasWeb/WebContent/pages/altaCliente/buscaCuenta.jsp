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
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JBuscaCuentaAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ultimoObjetoFoco;
 	var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";
	
	function fncInicio()
	{
	   	var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
 	   	if (codCriterioBusqueda.value == "" || codCriterioBusqueda.value == "CC")
 	   	{
	  		document.getElementById("divTipoIdentificacion").style["display"] = "none";
		  	document.getElementById("divFiltroCodCuenta").style["display"] = "";
	  		document.getElementById("txtFiltro").value="";
		  	document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
			document.getElementById("divFiltros").style["display"] = "none";
	   	}
	   	else if (codCriterioBusqueda.value=="DC")
	   	{
	  		document.getElementById("divTipoIdentificacion").style["display"] = "";
		  	document.getElementById("divFiltroCodCuenta").style["display"] = "none";
		  	document.getElementById("divFiltroDocumento").style["display"] = "";
			document.getElementById("divFiltros").style["display"] = "";
		}
	   	
		var codCuentaSel = document.getElementById("codCuentaSel").value;
		var codTipoCuentaSel = document.getElementById("codTipoCuentaSel").value;
		if (codCuentaSel!="")
		{
			document.body.style.cursor="wait";
			JBuscaCuentaAJAX.obtenerCuentas(codCuentaSel,null,null,codTipoCuentaSel,null,null,null,null,null,fncResultadoObtenerCuentas);			
		}
		else
		{
			var rdCuentaSel = document.getElementById("rdCuentaSel");
			if (rdCuentaSel != null)
			{
				document.getElementById("divResultadoBusqueda").style["display"] = "";
			}
		}
		
		//carga formato NIT
		if (document.getElementById("divTipoIdentificacion").style["display"]=="")
		{
			var codTipoIdentificacion = document.getElementById("codTipoIdentificacion");
			if (codTipoIdentificacion.value == codigoNIT)
			{
				document.getElementById("lbTxtFiltro").innerHTML = formatoNIT;
				document.getElementById("lbNumeroDocumento").innerHTML = formatoNIT;				
			}
		}
		
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		document.getElementById("telefonoContacto").maxLength = largoNumCelular;
		
		if (document.getElementById("seleccionCuenta").value == "BUSCAR_CUENTA")
		{
			document.getElementById("divBuscarCuenta").style["display"] = "";
			document.BuscaCuentaForm.radioCuenta[1].checked = true;
		}
		//P-CSR-11002 JLGN 14-05-2011
		fncCursorNormal();
	}
	
	function fncMostrarFiltros()
	{
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		
		if (codCriterioBusqueda.value == "" || codCriterioBusqueda.value == "CC")
		{
			document.getElementById("divTipoIdentificacion").style["display"] = "none";
			document.getElementById("divFiltroCodCuenta").style["display"] = "";
  			document.getElementById("codTipoIdentificacion").value="";
			document.getElementById("txtFiltro").value="";
			document.getElementById("lbTxtFiltro").innerHTML = "";
		  	document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
			document.getElementById("divFiltros").style["display"] = "none";
		}
		else if (codCriterioBusqueda.value == "DC")
		{
	  		document.getElementById("divTipoIdentificacion").style["display"] = "";
		  	document.getElementById("divFiltroCodCuenta").style["display"] = "none";
		  	document.getElementById("divFiltroDocumento").style["display"] = "";
			document.getElementById("numeroDocumento").value="";
			document.getElementById("lbNumeroDocumento").innerHTML = "";
			document.getElementById("telefonoContacto").value="";
			document.getElementById("nombreResponsable").value="";			
			document.getElementById("nombreCuenta").value="";				
			document.getElementById("divFiltros").style["display"] = "";				
		}
	}
	
	function fncBuscar() 
	{
		var codCuenta = null;
		var codTipoIdentificacion = null;
		var numIdentificacion = null;
		var tipoCuenta = document.getElementById("codTipoCuenta").value;
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda").value;
		var telefonoContacto = null;
		var nombreCuenta = null;
		var nombreResponsable = null;
		var tipoCuentaEmpresa = document.getElementById("codTipoCuentaEmpresa").value;		
			
		var buscarFinal = true;
	
		if (codCriterioBusqueda == "")
		{
	  	     alert("Debe Ingresar Criterio de B\u00FAsqueda");
	  	     return false; 
		}
		
		if (codCriterioBusqueda == "CC")
		{
			codCuenta = document.getElementById("txtFiltro").value; 
			if (codCuenta == "")
			{
		  	     alert("Debe Ingresar C\u00F3digo de Cuenta");
		  	     return false; 
			}
			
			if ( !(parseInt(codCuenta)>0) )
			{
		  	     alert("C\u00F3digo de Cuenta Inv\u00E1lido");
		  	     return false; 
			}
			
		}
		else if (codCriterioBusqueda == "DC")
		{
			codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
			numIdentificacion = document.getElementById("numeroDocumento").value;
			telefonoContacto = document.getElementById("telefonoContacto").value;
			nombreResponsable = document.getElementById("nombreResponsable").value;			
			nombreCuenta = document.getElementById("nombreCuenta").value;			
			var flgIngresaDocumento = false;
			var flgIngresaTelefono = false;
			var cantidadFiltroNombresIngresados = 0; //{0-2}
			var minCaracteresFiltroNombre = 3;
			
			if (codTipoIdentificacion != "")
			{
				if (numIdentificacion == "")
				{
			  	     alert("Si selecciona Tipo de Identificaci\u00F3n debe ingresar N\u00FAmero de Identificaci\u00F3n");
			  	     return false; 
				}
				else
				{
					flgIngresaDocumento = true;
				}
			}
			else
			{
				codTipoIdentificacion = null;
			}

			if (numIdentificacion != "")
			{
				if (codTipoIdentificacion == "")
				{
			  	     alert("Debe ingresar Tipo de Identificaci\u00F3n");
			  	     return false; 
				}
				else
				{
					flgIngresaDocumento = true;
				}
			}
			else
			{
				numIdentificacion = null;
			}
			if (telefonoContacto != "")
			{
				flgIngresaTelefono = true;
			}
			else
			{
				telefonoContacto = null;
			}
				
			if (nombreCuenta != "")
			{
				cantidadFiltroNombresIngresados++;
			}
			else
			{
				nombreCuenta = null;
			}
			if (nombreResponsable != "")
			{
				cantidadFiltroNombresIngresados++;
			}
			else
			{
				nombreResponsable = null;
			}
			if (!flgIngresaDocumento && !flgIngresaTelefono)
			{
				if (cantidadFiltroNombresIngresados == 0)
				{
					alert("Debe Ingresar Criterio de B\u00FAsqueda");
					return false;
				}
				else if (cantidadFiltroNombresIngresados == 1)
				{
					if ((nombreCuenta == null || nombreCuenta.length < minCaracteresFiltroNombre) 
						&& (nombreResponsable == null || nombreResponsable.length < minCaracteresFiltroNombre))
					{
						alert("Debe Ingresar por lo menos " + minCaracteresFiltroNombre + " caracteres");
						return false;
					}
				}
			}

			if (flgIngresaDocumento) {
				buscarFinal = false;
				ultimoObjetoFoco = document.getElementById("numeroDocumento");
				JBuscaCuentaAJAX.validarIdentificador(codTipoIdentificacion,numIdentificacion,fncResultadoValidacionIdentBuscarDatosCuenta);
			}
		}		
		if (buscarFinal) {
			document.getElementById("divResultadoBusqueda").style["display"] = "none";			
			document.body.style.cursor = "wait";
			JBuscaCuentaAJAX.obtenerCuentas(codCuenta, codTipoIdentificacion, numIdentificacion, tipoCuenta,
			telefonoContacto, nombreCuenta, nombreResponsable, fncResultadoObtenerCuentas);			
		}
	}
	
	function fncResultadoValidacionIdentBuscar(data)
	{
		if (data != null)
		{
			var esValido = data["valido"];
			if (!esValido) 
			{
				var codError = data["codError"];
				if (codError == "-100")
				{
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}
			else
			{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
				var codCuenta = null;
				var codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
				var numIdentificacion = document.getElementById("txtFiltro").value;
				var tipoCuenta = document.getElementById("codTipoCuenta").value;
				var telefonoContacto = null;
				var nombreResponsable = null;
				var nombreCuenta = null;
				document.getElementById("divResultadoBusqueda").style["display"] = "none";
				document.body.style.cursor="wait";				
				JBuscaCuentaAJAX.obtenerCuentas(codCuenta, codTipoIdentificacion, numIdentificacion, tipoCuenta,
				telefonoContacto, nombreResponsable, nombreCuenta, fncResultadoObtenerCuentas);
			}
		}
	}
	
	function fncResultadoValidacionIdentBuscarDatosCuenta(data)
	{
		if (data != null)
		{
			var esValido = data["valido"];
			if (!esValido) 
			{
				var codError = data["codError"];
				if (codError == "-100")
				{
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}			
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}
			else
			{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
				var codCuenta = null;
				var codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
				var numIdentificacion = document.getElementById("numeroDocumento").value;
				var tipoCuenta = document.getElementById("codTipoCuenta").value;
				var telefonoContacto = document.getElementById("telefonoContacto").value;
				var nombreResponsable = document.getElementById("nombreResponsable").value;			
				var nombreCuenta = document.getElementById("nombreCuenta").value;
				if (telefonoContacto == "")	telefonoContacto = null;
				if (nombreResponsable == "") nombreResponsable = null;
				if (nombreCuenta == "")	nombreCuenta = null;	
				document.getElementById("divResultadoBusqueda").style["display"] = "none";
				document.body.style.cursor="wait";
				JBuscaCuentaAJAX.obtenerCuentas(codCuenta, codTipoIdentificacion, numIdentificacion, tipoCuenta,
				telefonoContacto, nombreResponsable, nombreCuenta, fncResultadoObtenerCuentas);		
			}
		}
	}
	
	function fncResultadoObtenerCuentas(data)
	{
		if (data != null)
		{
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "")
	        {
				if (codError == "-100")
				{
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	    }
		document.getElementById("codCuentaSel").value = "";	    
		document.getElementById("opcion").value = "buscarCuentas";
	   	document.forms[0].submit();
	   	document.body.style.cursor = "auto";	
	}
	
	function fncSeleccionaCuenta(codCuenta)
	{
		document.getElementById("codCuentaSel").value = codCuenta.value;
	}
	
	function fncValidaTipoIdentificacion(tipoIdentSel,numIdentText) 
	{
		if (numIdentText.value != "") 
		{
			ultimoObjetoFoco = numIdentText;
			JBuscaCuentaAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
		}		
	}
	
	function fncResultadoValidacion(data) 
	{
		if (data != null)
		{
			var esValido = data["valido"];
			if (!esValido) 
			{
				var codError = data["codError"];
				if (codError == "-100")
				{
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}
			else
			{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
		}
	}
		
	//Muestra formato NIT
	function fncCambiarLabelNIT(tipoIdent)
	{
		if (tipoIdent.value==codigoNIT)
		{
			document.getElementById("lbTxtFiltro").innerHTML = formatoNIT;
			document.getElementById("lbNumeroDocumento").innerHTML = formatoNIT;
		}
		else
		{
			document.getElementById("lbTxtFiltro").innerHTML = "";
			document.getElementById("lbNumeroDocumento").innerHTML = "";
		}
	}
	
	function mostrarMensajeError(mensaje)
	{
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError()
	{
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncAceptarVenta() {
		var codCuentaSel = document.getElementById("codCuentaSel");
		if (document.BuscaCuentaForm.radioCuenta[0].checked) {
			codCuentaSel.value = 0; //Crear Cuenta Nueva
		}
		else {
			if (codCuentaSel == null || codCuentaSel.value == "") {
				alert("Debe seleccionar una cuenta");
				return false;
			}
		}
		document.getElementById("opcion").value = "aceptarVenta";
		document.forms[0].submit();
	}
	
	function fncAceptarAlta() {
		var codCuentaSel = document.getElementById("codCuentaSel");
		if (document.BuscaCuentaForm.radioCuenta[0].checked) {
			codCuentaSel.value = 0; // Crear Cuenta Nueva
		}
		else {
			if (codCuentaSel == null || codCuentaSel.value == "") {
				alert("Debe seleccionar una cuenta");
				return false;
			}
		}
		document.getElementById("opcion").value = "aceptarAlta";
   	    document.forms[0].submit();
	}
	
	function fncResultadoValidacionFolio(data) 
	{
		if (data!=null)
		{
			var mensError = data["msgError"];
			var codError = data["codError"];
			if (codError!="") 
			{
				if (codError == "-100")
				{
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert(mensError);
			}
			else
			{
				 //Continua Aceptar
	  	         document.getElementById("opcion").value = "aceptar";
	   	         document.forms[0].submit();
			}
		}
	}
		
	function fncCancelar()
	{
		document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
	}
 
	function fncVolver()
	{
		if (confirm("¿Desea volver al men\u00FA?"))
		{
			var win = parent
			win.fncActDesacMenu(false);
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	
	function fncInvocarPaginaExpiraSesion()
	{
    	document.forms[0].submit();
	}
	
	function desplegarBusquedaCuenta()
	{
		var chosen = "";
		for (i = 0; i < document.BuscaCuentaForm.radioCuenta.length; i++) 
		{
			if (document.BuscaCuentaForm.radioCuenta[i].checked) 
			{
				chosen = document.BuscaCuentaForm.radioCuenta[i].value;
			}
		}
		if (chosen == "CUENTA_NUEVA") 
		{
			document.getElementById("divBuscarCuenta").style["display"] = "none";
			
		}
		else if (chosen == "BUSCAR_CUENTA") 
		{
			document.getElementById("divBuscarCuenta").style["display"] = "";
		}
		document.getElementById("seleccionCuenta").value = chosen;
	}
	
	//P-CSR-11002 07/04/2011
	function valNumeroIdentificacion (numIdent, tipoIdent){
		var e = window.event;		
		if (document.getElementById(tipoIdent).value == "01"){
			if(e.keyCode >= 48 && e.keyCode <= 57){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaIdentidad){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
		}else if (document.getElementById(tipoIdent).value == "02"){
			if(e.keyCode >= 48 && e.keyCode <= 57){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaJuridica){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
			
		}else{
			if(e.keyCode >= 48 && e.keyCode <= 57 || e.keyCode >= 65 && e.keyCode <= 90 || e.keyCode >= 97 && e.keyCode <= 122){
				largo = document.getElementById(numIdent).value.length+1;
				if(largo > cedulaOtras){
					e.keyCode = 0;
				} 
			}else{
				e.keyCode = 0;
			}
		}
	}
	
	function limpiaNumeroIdentificacion(numIdent){
		document.getElementById(numIdent).value = "";
	}
	
	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }
	
</script>
</head>
<body onload="history.go(+1);fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/BuscaCuentaAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codTipoCuentaSel" styleId="codTipoCuentaSel"/>
	<html:hidden property="codCuentaSel" styleId="codCuentaSel"/>
	<html:hidden property="seleccionCuenta" styleId="seleccionCuenta"/>
	<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
	<html:hidden property="codTipoCuentaEmpresa" styleId="codTipoCuentaEmpresa"/>
	<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
		hspace="2" align="left" />Selecci&oacute;n de Cuenta</h2>
	<div id="mensajes" class="mensajeError"></div>

<table width="90%">
	<tr><td>&nbsp;</td></tr>
	<tr>
		<td width="5%">&nbsp;</td>
		<td width="95%" align="left">&nbsp;<input value="CUENTA_NUEVA"
			onclick="desplegarBusquedaCuenta()" type="radio" name="radioCuenta" checked="checked">
			<b>Crear cuenta nueva</b>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>		
		<td align="left">&nbsp;<input value="BUSCAR_CUENTA"
			onclick="desplegarBusquedaCuenta()" type="radio" name="radioCuenta">
			<b>Buscar cuenta existente</b>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>

<div width="100%" id="divBuscarCuenta" style="display:none">
<table width="90%">
<tr>
	<td width="5%">&nbsp;</td>
	<td width="95%">
	<table width="100%">
		<tr>
			<td align="left" width="30%">Tipo de Cuenta</td>
			<td align="left" width="70%"><html:select style="width:200px;" name="BuscaCuentaForm"
				property="codTipoCuenta" onchange="ocultarMensajeError();" styleId="codTipoCuenta">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="BuscaCuentaForm" property="arrayTipoCuenta">
					<html:optionsCollection property="arrayTipoCuenta" value="codigoValor" label="descripcionValor" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
		<tr>
			<td align="left">Buscar una cuenta por</td>
			<td align="left"><html:select name="BuscaCuentaForm" property="codCriterioBusqueda" styleId="codCriterioBusqueda"
				style="width:200px;" onchange="ocultarMensajeError();fncMostrarFiltros();">
				<html:option value="">- Seleccione -</html:option>
				<html:option value="CC">CODIGO CUENTA</html:option>
				<html:option value="DC">DATOS CUENTA</html:option>
			</html:select></td>
		</tr>
	</table>
	<div id="divFiltroCodCuenta">
	<table width="100%">
		<tr>
			<td align="left" width="30%"></td>
			<td align="left" width="70%"><html:text name="BuscaCuentaForm" property="txtFiltro" styleId="txtFiltro"
				style="text-transform: uppercase;" size="30" maxlength="20"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
				onchange="ocultarMensajeError();" /><label for="txtFiltro" id="lbTxtFiltro" class="textoAzul"></label></td>
		</tr>
	</table>
	</div>
	<div id="divTipoIdentificacion" style="display:none">
	<table width="100%">
		<tr>
			<td align="left" width="30%">Cuyo tipo de identificaci&oacute;n es</td>
			<td align="left" width="35%" valign="top"><html:select name="BuscaCuentaForm"
				property="codTipoIdentificacion" style="width:200px;" styleId="codTipoIdentificacion"
				onchange="ocultarMensajeError(); limpiaNumeroIdentificacion('numeroDocumento');">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="BuscaCuentaForm" property="arrayIdentificadorCuenta">
					<html:optionsCollection property="arrayIdentificadorCuenta" value="codigoTipIdentif"
						label="descripcionTipIdentif" />
				</logic:notEmpty>
			</html:select></td>
			<td align="left">
			<div id="divFiltroDocumento" style="display:none"><html:text name="BuscaCuentaForm" styleId="numeroDocumento"
				property="numeroDocumento" maxlength="20" size="30" onkeypress="soloCaracteresValidos();valNumeroIdentificacion('numeroDocumento','codTipoIdentificacion');"
				onchange="ocultarMensajeError();" onblur="upperCase(this);" style="text-transform: uppercase;" />
			<label for="numeroDocumento" id="lbNumeroDocumento" class="textoAzul"></label></div>
			</td>
		</tr>
	</table>
	</div>
	<div id="divFiltros" style="display:none">
	<table width="100%">
		<tr>
			<td width="30%" align="left">Tel&eacute;fono de Contacto</td>
			<td align="left" width="70%"><html:text name="BuscaCuentaForm" property="telefonoContacto" styleId="telefonoContacto"
				size="37" onkeypress="soloCaracteresValidos();" onkeypress="onlyInteger();"
				onchange="ocultarMensajeError();" /></td>
		</tr>
		<tr>
			<td align="left">Nombre Responsable</td>
			<td align="left"><html:text name="BuscaCuentaForm" property="nombreResponsable" styleId="nombreResponsable"
				style="text-transform: uppercase;" size="37" maxlength="40"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
				onchange="ocultarMensajeError();" /></td>
		</tr>
		<tr>
			<td align="left">Nombre Cuenta</td>
			<td align="left"><html:text name="BuscaCuentaForm" property="nombreCuenta" styleId="nombreCuenta"
				style="text-transform: uppercase;" size="37" maxlength="50"
				onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
				onchange="ocultarMensajeError();" /></td>
		</tr>
	</table>
	</div>
	<div align="right" >
		<html:button value="BUSCAR" style="width:120px;color:black" property="btnBuscar" styleId="btnBuscar"
			onclick="fncCursorEspera();ocultarMensajeError();fncBuscar();" />
	</div>

	</td>
</tr>

</table>	
		
	<HR noshade width="90%">
	
	<div id="divResultadoBusqueda" style="display:none">
	<h2 align="center">Coincidencias:<br>
	De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.</h2>
	</div>
	<P><display:table id="clientes" name="listaCuentas" scope="session" pagesize="10" requestURI=""
		width="90%">
		<display:column title="Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
			width="5%">
			<input type="radio" name="rdCuentaSel" onclick="fncSeleccionaCuenta(this);" id="rdCuentaSel"
				value="<bean:write name="clientes" property="codigoCuenta"/>">
		</display:column>
		<display:column property="codigoCuenta" title="C&oacute;digo Cuenta"
			headerClass="textoColumnaTabla" width="12%" />
		<display:column property="codigoTipoIdentificacion" title="Tipo de Identificaci&oacute;n"
			headerClass="textoColumnaTabla" width="10%" />
		<display:column property="numeroIdentificacion" title="No. de Identificacion"
			headerClass="textoColumnaTabla" width="13%" />
		<display:column property="nombreCuenta" title="Nombre de Cuenta" headerClass="textoColumnaTabla"
			width="30%" />
		<display:column property="glsTipoCuenta" title="Tipo de Cuenta" headerClass="textoColumnaTabla"
			width="10%" />
	</display:table></P>
	</div>
	<table cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<bean:define id="codModuloSolicitudVenta" name="BuscaCuentaForm" property="codModuloSolicitudVenta" type="java.lang.String"/>	
		<tr>
			<td>
				<logic:equal name="BuscaCuentaForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>"> 
		           	<html:button value="CANCELAR" style="width:120px;color:black" styleId="btnCancelar" property="btnCancelar" onclick="fncCancelar();" />
	           	</logic:equal>
			</td>
			<td align="right" width="50%">
				<logic:equal name="BuscaCuentaForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>"> 
					<html:button value=">>" style="width:120px;color:black" styleId="btnAceptar" property="btnAceptar" onclick="fncCursorEspera();fncAceptarVenta();" />
				</logic:equal>
				<logic:notEqual name="BuscaCuentaForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>"> 
					<html:button value=">>" style="width:120px;color:black" styleId="btnAceptar" property="btnAceptar" onclick="fncCursorEspera();fncAceptarAlta();" />
				</logic:notEqual>
			</td>
		</tr>
	</table>
</html:form>
</body>
</html:html>
