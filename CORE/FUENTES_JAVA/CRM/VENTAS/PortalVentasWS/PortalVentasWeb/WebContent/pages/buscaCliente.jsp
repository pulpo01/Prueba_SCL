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
	src='<%=request.getContextPath()%>/dwr/interface/JBuscaClienteAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ultimoObjetoFoco;
 	var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	var tipoEjecucion="<c:out value="${paramGlobal.tipoEjecucion}"/>";

	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";	
	
	function fncInicio(){
	
	   var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
 	   if (codCriterioBusqueda.value=="" || codCriterioBusqueda.value=="CC"){
		  	document.getElementById("divTipoIdentificacion").style["display"] = "none";
		  	document.getElementById("divFiltroCodCliente").style["display"] = "";
	  		document.getElementById("txtFiltro").value="";
	  		
		  	document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
			document.getElementById("divFiltroTelefono").style["display"] = "none";
			document.getElementById("divFiltroNombre").style["display"] = "none";
			document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";

	   }
	   else if (codCriterioBusqueda.value=="NI"){
	  		document.getElementById("divTipoIdentificacion").style["display"] = "";
		  	document.getElementById("divFiltroCodCliente").style["display"] = "";

		  	document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
			document.getElementById("divFiltroTelefono").style["display"] = "none";
			document.getElementById("divFiltroNombre").style["display"] = "none";
			document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";
	   }
	   else if (codCriterioBusqueda.value=="DC"){
	  		document.getElementById("divTipoIdentificacion").style["display"] = "";
		  	document.getElementById("divFiltroCodCliente").style["display"] = "none";
		  	document.getElementById("divFiltroDocumento").style["display"] = "";
			document.getElementById("divFiltroTelefono").style["display"] = "";
			
			var tipoCliente = document.getElementById("codTipoCliente").value;
			var tipoClienteEmpresa = document.getElementById("codTipoClienteEmpresa").value;
			
			if (tipoCliente == tipoClienteEmpresa){
				document.getElementById("divFiltroNombre").style["display"] = "none";
				document.getElementById("divFiltroNombreEmpresa").style["display"] = "";
			}else{
				document.getElementById("divFiltroNombre").style["display"] = "";
				document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";
			}
	   
	   }
	   	
		var codClienteSel = document.getElementById("codClienteSel").value;
		var codTipoClienteSel = document.getElementById("codTipoClienteSel").value;
		if (codClienteSel!=""){
			document.body.style.cursor="wait";
			JBuscaClienteAJAX.obtenerClientes(codClienteSel,null,null,codTipoClienteSel,null,null,null,null,null,fncResultadoObtenerClientes);			
		}else{
			var rdClienteSel = document.getElementById("rdClienteSel");
			if (rdClienteSel!=null){
				document.getElementById("divResultadoBusqueda").style["display"] = "";
			}
		}
		
		//carga formato NIT
		if (document.getElementById("divTipoIdentificacion").style["display"]==""){
			var codTipoIdentificacion = document.getElementById("codTipoIdentificacion");
			if (codTipoIdentificacion.value == codigoNIT){
				document.getElementById("lbTxtFiltro").innerHTML = formatoNIT;
				document.getElementById("lbNumeroDocumento").innerHTML = formatoNIT;				
			}
		}
		
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		document.getElementById("telefonoCliente").maxLength = largoNumCelular;
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
	}
	
	function fncMostrarFiltros(){
		  var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
 
		  if (codCriterioBusqueda.value=="" || codCriterioBusqueda.value=="CC"){
			  document.getElementById("divTipoIdentificacion").style["display"] = "none";
			  document.getElementById("divFiltroCodCliente").style["display"] = "";
  			  document.getElementById("codTipoIdentificacion").value="";
			  document.getElementById("txtFiltro").value="";
			  document.getElementById("lbTxtFiltro").innerHTML = "";

		  	  document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
			  document.getElementById("divFiltroTelefono").style["display"] = "none";
			  document.getElementById("divFiltroNombre").style["display"] = "none";
			  document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";
			
		  }
		  else if (codCriterioBusqueda.value=="NI"){
		  		document.getElementById("divTipoIdentificacion").style["display"] = "";
		  		document.getElementById("divFiltroCodCliente").style["display"] = "";

		  		document.getElementById("divFiltroDocumento").style["display"] = "none";	  		
				document.getElementById("divFiltroTelefono").style["display"] = "none";
				document.getElementById("divFiltroNombre").style["display"] = "none";
				document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";		  	
		  }
		  else if (codCriterioBusqueda.value=="DC"){
	  			document.getElementById("divTipoIdentificacion").style["display"] = "";
		  		document.getElementById("divFiltroCodCliente").style["display"] = "none";
		  		document.getElementById("divFiltroDocumento").style["display"] = "";
				document.getElementById("divFiltroTelefono").style["display"] = "";
				document.getElementById("numeroDocumento").value="";
			    document.getElementById("lbNumeroDocumento").innerHTML = "";
				document.getElementById("telefonoCliente").value="";
				document.getElementById("nombres").value="";			
				document.getElementById("primerApellido").value="";
				document.getElementById("segundoApellido").value="";
				document.getElementById("nombreEmpresa").value="";				
							
				var tipoCliente = document.getElementById("codTipoCliente").value;
				var tipoClienteEmpresa = document.getElementById("codTipoClienteEmpresa").value;
				
				if (tipoCliente == tipoClienteEmpresa){
					document.getElementById("divFiltroNombre").style["display"] = "none";
					document.getElementById("divFiltroNombreEmpresa").style["display"] = "";
				}else{
					document.getElementById("divFiltroNombre").style["display"] = "";
					document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";
				}
	   	 }
	}  
	
	
	function fncBuscar() {
		var codCliente = null;
		var codTipoIdentificacion = null;
		var numIdentificacion = null;
		var tipoCliente = document.getElementById("codTipoCliente").value;
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda").value;
		var telefonoCliente = null;
		var nombres = null;
		var primerApellido = null;
		var segundoApellido = null;
		var nombreEmpresa = null;
		var tipoClienteEmpresa = document.getElementById("codTipoClienteEmpresa").value;		
			
		var buscarFinal = true;
				
		if (codCriterioBusqueda == ""){
	  	     alert("Debe Ingresar Criterio de B\u00FAsqueda");
	  	     return false; 
		}
		
		if (codCriterioBusqueda == "CC"){
			codCliente = document.getElementById("txtFiltro").value; 
			 
			if (codCliente == ""){
		  	     alert("Debe Ingresar C\u00F3digo de Cliente");
		  	     return false; 
			}
			
			if ( !(parseInt(codCliente)>0) ){
		  	     alert("C\u00F3digo de Cliente Inv\u00E1lido");
		  	     return false; 
			}
			
		}else if (codCriterioBusqueda =="NI"){
				codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
			numIdentificacion = document.getElementById("txtFiltro").value;
			
			if (codTipoIdentificacion == ""){
		  	     alert("Debe Ingresar Tipo  de Identificaci\u00F3n");
		  	     return false; 
			}
			
			if (numIdentificacion == ""){
		  	     alert("Debe Ingresar N\u00FAmero de Identificaci\u00F3n");
		  	     return false; 
			}	
			
			buscarFinal=false;
			//valida identificador
			ultimoObjetoFoco = document.getElementById("txtFiltro");
			JBuscaClienteAJAX.validarIdentificador(codTipoIdentificacion,numIdentificacion,fncResultadoValidacionIdentBuscar);
			
		}else if (codCriterioBusqueda =="DC"){
		
			codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
			numIdentificacion = document.getElementById("numeroDocumento").value;
			telefonoCliente = document.getElementById("telefonoCliente").value;
			nombres = document.getElementById("nombres").value;			
			primerApellido = document.getElementById("primerApellido").value;				
			segundoApellido = document.getElementById("segundoApellido").value;	
			nombreEmpresa = document.getElementById("nombreEmpresa").value;			
			var flgIngresaDocumento = false;
			var flgIngresaTelefono = false;
			var cantidadFiltroNombresIngresados = 0; //{0-3}
			var minCaracteresFiltroNombre = 3;
			
			//----------------------
			if (codTipoIdentificacion != ""){
				if (numIdentificacion == ""){
			  	     alert("Si selecciona Tipo de Identificaci\u00F3n debe ingresar N\u00FAmero de Identificaci\u00F3n");
			  	     return false; 
				}else{
					flgIngresaDocumento = true;
				}
			}else{
				codTipoIdentificacion = null;
			}
			//----------------------
			if (numIdentificacion != ""){
				if (codTipoIdentificacion == ""){
			  	     alert("Debe ingresar Tipo de Identificaci\u00F3n");
			  	     return false; 
				}else{
					flgIngresaDocumento = true;
				}
			}else{
				numIdentificacion = null;
			}
			//----------------------
			if (telefonoCliente != ""){
				flgIngresaTelefono = true;
			}else{
				telefonoCliente = null;
			}
			//----------------------			
			if (tipoCliente == tipoClienteEmpresa){
				if (nombreEmpresa != ""){
					cantidadFiltroNombresIngresados++;
				}else{
					nombreEmpresa = null;
				}
			}else{//cliente particular
				if (nombres != ""){
					cantidadFiltroNombresIngresados++;
				}else{
					nombres = null;
				}
				if (primerApellido != ""){
					cantidadFiltroNombresIngresados++;
				}else{
					primerApellido = null;
				}
				if (segundoApellido != ""){
					cantidadFiltroNombresIngresados++;
				}else{
					segundoApellido = null;
				}
			}//fin else cliente particular
			//----------------------
			
			if (!flgIngresaDocumento && !flgIngresaTelefono){
				if (cantidadFiltroNombresIngresados == 0){
					alert("Debe Ingresar Criterio de B\u00FAsqueda");
					return false;
				}
				else if (cantidadFiltroNombresIngresados == 1){
					if (tipoCliente == tipoClienteEmpresa){
						if ( ((nombreEmpresa==null) || (nombreEmpresa.length < minCaracteresFiltroNombre))){
								alert("Debe Ingresar por lo menos "+minCaracteresFiltroNombre+" caracteres");
								return false;
						}
					}else{
						if ( ((nombres==null) || (nombres.length < minCaracteresFiltroNombre))
							&& ((primerApellido==null) || (primerApellido.length < minCaracteresFiltroNombre))
								&& ((segundoApellido==null) || (segundoApellido.length < minCaracteresFiltroNombre)) ){
								alert("Debe Ingresar por lo menos "+minCaracteresFiltroNombre+" caracteres");
								return false;
						}
					}
				}
			}

			if (flgIngresaDocumento){//valida identificador y luego busca por todos los filtros en fncResultadoValidacionIdentBuscarDatosCliente
				buscarFinal=false;
				//valida identificador
				ultimoObjetoFoco = document.getElementById("numeroDocumento");
				JBuscaClienteAJAX.validarIdentificador(codTipoIdentificacion,numIdentificacion,fncResultadoValidacionIdentBuscarDatosCliente);
			}
	
		}		

		if (buscarFinal){
			document.getElementById("divResultadoBusqueda").style["display"] = "none";			
			document.body.style.cursor="wait";
			JBuscaClienteAJAX.obtenerClientes(codCliente, codTipoIdentificacion, numIdentificacion, tipoCliente,
			telefonoCliente, nombres, primerApellido, segundoApellido, nombreEmpresa, fncResultadoObtenerClientes);			
		}
		
	}//fin fncObtenerClientes
	
	//busqueda antigua por Identificador (NI)
	function fncResultadoValidacionIdentBuscar(data){
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}else{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
				var codCliente = null;
				var codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
				var numIdentificacion = document.getElementById("txtFiltro").value;
				var tipoCliente = document.getElementById("codTipoCliente").value;
				var telefonoCliente = null;
				var nombres = null;
				var primerApellido = null;
				var segundoApellido = null;
				var nombreEmpresa = null;
						
				document.getElementById("divResultadoBusqueda").style["display"] = "none";
				//Realiza la busqueda una vez validado el identificar
				document.body.style.cursor="wait";				
				JBuscaClienteAJAX.obtenerClientes(codCliente, codTipoIdentificacion, numIdentificacion, tipoCliente,
				telefonoCliente, nombres, primerApellido, segundoApellido, nombreEmpresa, fncResultadoObtenerClientes);
							
			}
		}
	}
	
	function fncResultadoValidacionIdentBuscarDatosCliente(data){
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}			
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}else{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
				var codCliente = null;
				var codTipoIdentificacion = document.getElementById("codTipoIdentificacion").value;
				var numIdentificacion = document.getElementById("numeroDocumento").value;
				var tipoCliente = document.getElementById("codTipoCliente").value;
				var telefonoCliente = document.getElementById("telefonoCliente").value;
				var nombres = document.getElementById("nombres").value;			
				var primerApellido = document.getElementById("primerApellido").value;				
				var segundoApellido = document.getElementById("segundoApellido").value;	
				var nombreEmpresa = document.getElementById("nombreEmpresa").value;
						
				if (telefonoCliente == "")	telefonoCliente = null;
				if (nombres == "")			nombres = null;
				if (primerApellido == "")	primerApellido = null;
				if (segundoApellido == "")	segundoApellido = null;
				if (nombreEmpresa == "")	nombreEmpresa = null;	
				
				document.getElementById("divResultadoBusqueda").style["display"] = "none";
				//Realiza la busqueda una vez validado el identificar
				document.body.style.cursor="wait";
				JBuscaClienteAJAX.obtenerClientes(codCliente, codTipoIdentificacion, numIdentificacion, tipoCliente,
				telefonoCliente, nombres, primerApellido, segundoApellido, nombreEmpresa, fncResultadoObtenerClientes);		
					

			}
		}
	}
	function fncResultadoObtenerClientes(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	    }//fin if (data!=null)
	    
		document.getElementById("codClienteSel").value = "";	    
		document.getElementById("opcion").value = "buscarClientes";
	   	document.body.style.cursor = "auto";	
	   	document.forms[0].submit();
	}
	
	function fncSeleccionarTipoCliente(codTipoCliente){
		var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		var codTipoClienteEmpresa = document.getElementById("codTipoClienteEmpresa");
		if (codCriterioBusqueda.value=="DC"){  			  
			if (codTipoCliente.value == codTipoClienteEmpresa.value) {
			  	document.getElementById("divFiltroNombre").style["display"] = "none";
			  	document.getElementById("divFiltroNombreEmpresa").style["display"] = "";
			}
			else {
			  	document.getElementById("divFiltroNombreEmpresa").style["display"] = "none";
			  	document.getElementById("divFiltroNombre").style["display"] = "";
			}
		}
	}
	
	function fncSeleccionaCliente(codCliente){
		document.getElementById("codClienteSel").value = codCliente.value;
	}
	
	function fncValidaTipoIdentificacion(tipoIdentSel, numIdentText) {
		if (numIdentText.value != "") {
			ultimoObjetoFoco = numIdentText;
			JBuscaClienteAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
		}		
	}
	
	function fncResultadoValidacion(data) {
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value="";
			}
			else {
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
		}
	}
		
	//Muestra formato NIT
	function fncCambiarLabelNIT(tipoIdent) {
		if (tipoIdent.value==codigoNIT)	{
			document.getElementById("lbTxtFiltro").innerHTML = formatoNIT;
			document.getElementById("lbNumeroDocumento").innerHTML = formatoNIT;
		}
		else {
			document.getElementById("lbTxtFiltro").innerHTML = "";
			document.getElementById("lbNumeroDocumento").innerHTML = "";
		}
	}
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje;
	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = "";
	}
	
	//(+) ------------- Aceptar ---------------------------
	function fncAceptar() {
		var codClienteSel = document.getElementById("codClienteSel");
		if (codClienteSel == null || codClienteSel.value == "") {
			alert("Debe seleccionar un cliente");
			return false;
		}
		else {
			var moduloOrigen = document.getElementById("moduloOrigen");
			var codModuloSolicitudVenta = document.getElementById("codModuloSolicitudVenta");
			
			if (moduloOrigen.value == codModuloSolicitudVenta.value) {
		 		  //Validar Folio
	 			  JBuscaClienteAJAX.ValidaFolio(codClienteSel.value,fncResultadoValidacionFolio);
 			}
 			else {
				 //Continua Aceptar
	  	         document.getElementById("opcion").value = "aceptar";
	   	         document.forms[0].submit();
 			}
		}
	}
	
	function fncResultadoValidacionFolio(data) {
		if (data!=null) {
			var mensError = data["msgError"];
			var codError = data["codError"];
			if (codError != "") {
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert(mensError);
			}
			else {
		        var codCliente = document.getElementById("codClienteSel").value;
	    		JBuscaClienteAJAX.validaClienteLN(codCliente, resultadoValidaClienteLN);
			}
		}
	}
	
	function resultadoValidaClienteLN(data) {
	 	if (data != null) {
			var codError = data['codError']; 
		    var mensajeError = data['msgError']; 
		    if (codError != "") {
		    	if (codError == "-100") {
			      	fncInvocarPaginaExpiraSesion();
		        	return false;
		        }		        
		        alert(mensajeError);
		        return false;
		    }
		    else {
		    	var codCliente = document.getElementById("codClienteSel").value;
	    		JBuscaClienteAJAX.verificaClientePasilloLDI(codCliente, resultadoVerificaClientePasilloLDI);
		    }
		}
	}
	
	function resultadoVerificaClientePasilloLDI(data) {
	 	if (data != null) {
			var codError = data['codError']; 
		    var mensajeError = data['msgError']; 
		    if (codError != "") {
		    	if (codError == "-100") {
			      	fncInvocarPaginaExpiraSesion();
		        	return false;
		        }		        
		        alert(mensajeError);
		        return false;
		    }
		    else {
		    	document.getElementById("opcion").value = "aceptar";
	   	        document.forms[0].submit();
		    }
		}
	}
	//(-) ------------- Aceptar ---------------------------
	function fncCancelar(){
		document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
	}
 
	function fncVolver(){
		if (confirm("¿Desea volver al men\u00FA?")){
			var win = parent
			win.fncActDesacMenu(false);
		
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
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
<html:form method="POST" action="/BuscaClienteAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codTipoClienteSel" styleId="codTipoClienteSel"/>
	<html:hidden property="codClienteSel" styleId="codClienteSel"/>
	<html:hidden property="moduloOrigen" styleId="moduloOrigen"/>
	<html:hidden property="codModuloSolicitudVenta" styleId="codModuloSolicitudVenta"/>
	<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
	<html:hidden property="codTipoClienteEmpresa" styleId="codTipoClienteEmpresa"/>
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">B&uacute;squeda de Cliente&nbsp;
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"><bean:write name="BuscaClienteForm"
				property="mensajeError"></bean:write>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%">
		<tr>
			<td width="100%">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td align="left" width="25%">Tipo de Cliente</td>
					<td align="left" width="28%"><html:select name="BuscaClienteForm"
						property="codTipoCliente" style="width:200px;" styleId="codTipoCliente"
						onchange="ocultarMensajeError();fncSeleccionarTipoCliente(this);">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="BuscaClienteForm" property="arrayTipoCliente">
							<html:optionsCollection property="arrayTipoCliente" value="codigoValor"
								label="descripcionValor" />
						</logic:notEmpty>
					</html:select></td>
					<td width="7%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td align="left">Buscar un cliente por</td>
					<td align="left"><html:select name="BuscaClienteForm" property="codCriterioBusqueda"
						style="width:200px;" styleId="codCriterioBusqueda" onchange="ocultarMensajeError();fncMostrarFiltros();">
						<html:option value="">- Seleccione -</html:option>
						<html:option value="CC">CODIGO CLIENTE</html:option>
						<c:if test="${paramGlobal.tipoEjecucion != '1'}">
							<html:option value="NI">NUMERO DE IDENTIFICACION</html:option>
						</c:if>
						<c:if test="${paramGlobal.tipoEjecucion == '1'}">
							<html:option value="DC">DATOS CLIENTE</html:option>
						</c:if>
					</html:select></td>
					<td colspan="2">&nbsp;</td>
				</tr>
			</table>
			<div id="divTipoIdentificacion" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td align="left" width="25%">Cuyo tipo de identificaci&oacute;n es</td>
					<td align="left" width="28%" valign="top"><html:select name="BuscaClienteForm"
						property="codTipoIdentificacion" style="width:200px;" styleId="codTipoIdentificacion"
						onchange="ocultarMensajeError(); limpiaNumeroIdentificacion('numeroDocumento');">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="BuscaClienteForm" property="arrayIdentificadorCliente">
							<html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif"
								label="descripcionTipIdentif" />
						</logic:notEmpty>
					</html:select></td>
					<td width="32%" colspan="2" align="left" valign="top">
					<div id="divFiltroDocumento" style="display:none"><html:text name="BuscaClienteForm"
						property="numeroDocumento" styleId="numeroDocumento" maxlength="20" size="37" onkeypress="soloCaracteresValidos();"
						onchange="ocultarMensajeError();" onblur="upperCase(this);" style="text-transform: uppercase;" />
					&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroDocumento" id="lbNumeroDocumento" class="textoAzul"></label>
					</div>
					</td>
				</tr>
			</table>
			</div>
			<div id="divFiltroCodCliente">
			<table width="100%">
				<tr>
					<td colspan="5">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<td align="left" width="28%"><html:text name="BuscaClienteForm" property="txtFiltro" styleId="txtFiltro"
						style="text-transform: uppercase;" size="35" maxlength="20"
						onkeypress="soloCaracteresValidos();valNumeroIdentificacion('txtFiltro','codTipoIdentificacion');" onblur="upperCase(this);"
						onchange="ocultarMensajeError();" /> &nbsp;&nbsp;&nbsp;&nbsp;<label for="txtFiltro"
						id="lbTxtFiltro" class="textoAzul"></label></td>
					<td width="7%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
				</tr>
			</table>
			</div>
			<div id="divFiltroTelefono" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Tel&eacute;fono Cliente</td>
					<td align="left" width="60%"><html:text name="BuscaClienteForm"
						property="telefonoCliente" styleId="telefonoCliente" size="37" onkeypress="soloCaracteresValidos();"
						onkeypress="onlyInteger();" onchange="ocultarMensajeError();" /></td>
				</tr>
			</table>
			</div>
			<div id="divFiltroNombre" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Nombres</td>
					<td align="left" width="60%" colspan="2"><html:text name="BuscaClienteForm"
						property="nombres" style="text-transform: uppercase;" styleId="nombres" size="37" maxlength="40"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
						onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Apellidos</td>
					<td align="left" width="28%"><html:text name="BuscaClienteForm" property="primerApellido"
						style="text-transform: uppercase;" styleId="primerApellido" size="37" maxlength="20"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
						onchange="ocultarMensajeError();" /></td>
					<td align="left" width="32%"><html:text name="BuscaClienteForm"
						property="segundoApellido" style="text-transform: uppercase;" styleId="segundoApellido" size="37" maxlength="20"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
						onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
			</table>
			</div>
			<div id="divFiltroNombreEmpresa" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Nombre Empresa</td>
					<td align="left" width="60%"><html:text name="BuscaClienteForm" property="nombreEmpresa"
						style="text-transform: uppercase;" styleId="nombreEmpresa" size="37" maxlength="50"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);"
						onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td colspan="3">&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%">
				<tr>
					<td width="20%">&nbsp;</td>
					<td width="20%">&nbsp;</td>
					<td colspan="2" width="35%">&nbsp;</td>
					<td align="left" width="25%"><html:button value="BUSCAR" style="width:120px;color:black"
						property="btnBuscar" styleId="btnBuscar" onclick="fncCursorEspera();ocultarMensajeError();fncBuscar();" /></td>
				</tr>
				<tr>
					<td colspan="5">
					<HR noshade>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<div id="divResultadoBusqueda" style="display:none">
	<h2 align="center">Coincidencias:<br>
	De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.</h2>
	</div>
	<P><display:table id="clientes" name="listaClientes" scope="session" pagesize="10"
		requestURI="" width="90%">
		<display:column title="Sel" headerClass="textoColumnaTabla" align="center" class="textoFilasColorTabla"
			width="5%">
			<input type="radio" style="text-align: center" name="rdClienteSel" onclick="fncSeleccionaCliente(this);"
				value="<bean:write name="clientes" property="codigoCliente"/>">
		</display:column>
		<display:column property="codigoCliente" title="C&oacute;digo Cliente"
			headerClass="textoColumnaTabla" width="12%" align="center" />
		<display:column property="desTipoIdentificacion" title="Tipo de Identificaci&oacute;n" headerClass="textoColumnaTabla"
			width="10%" align="center" />
		<display:column property="numeroIdentificacion" title="No. de Identificacion"
			headerClass="textoColumnaTabla" width="13%" align="center" />
		<display:column property="nombreCompleto" title="Nombre Cliente" headerClass="textoColumnaTabla"
			width="30%" align="left" />
		<display:column property="glsTipoCliente" title="Tipo de Cliente" headerClass="textoColumnaTabla"
			width="10%" align="center" />
		<display:column property="codCrediticia" title="Clasificaci&oacute;n Crediticia"
			headerClass="textoColumnaTabla" width="10%" align="center" />
		<display:column property="montoPreAutorizado" title="Monto Preautorizado"
			headerClass="textoColumnaTabla" width="10%" align="right" />
	</display:table>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="50%" align="left"><bean:define id="codModuloSolicitudVenta"
				name="BuscaClienteForm" property="codModuloSolicitudVenta" type="java.lang.String" /> <logic:equal
				name="BuscaClienteForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>">
			</logic:equal></td>
			<td align="right" width="25%"><html:button value="CANCELAR" style="width:120px;color:black"
				property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();fncCancelar();" /></td>
			<td align="right" width="25%"><html:button value="ACEPTAR" style="width:120px;color:black"
				property="btnAceptar" styleId="btnAceptar" onclick="fncCursorEspera();fncAceptar();" /></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
