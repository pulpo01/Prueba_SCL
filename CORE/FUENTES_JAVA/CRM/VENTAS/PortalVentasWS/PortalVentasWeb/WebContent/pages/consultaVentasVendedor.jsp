<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/calendar.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/calendar.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript'
	src='<%=request.getContextPath()%>/dwr/interface/JConsultaVentasVendedorAJAX.js'></script>
<script>
	window.history.forward(1);
	
	function fncInicio(){
		var rdVentaSel = document.getElementById("rdVentaSel");
		if (rdVentaSel != null ){
			document.getElementById("divResultadoBusqueda").style["display"] = "";
		}
		fncObtenerVendedores();
	}
	
	//(+)-- carga combo vendedor--
	function fncObtenerVendedores() {
		var codOficina = document.getElementById("codOficina");
		
		if (codOficina.value != "" ) {
			JConsultaVentasVendedorAJAX.obtenerVendedores(codOficina.value,fncResultadoObtenerVendedores);
		}else{
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});
	    }
	}
	
	function fncResultadoObtenerVendedores(data){
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
			var listaActualizada = data["lista"];
			var codVendedorSeleccionado = document.getElementById("codVendedorSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("codVendedor");
		    DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codVendedor",listaActualizada,"codigoVendedor","nombreVendedor");

		    if (codVendedorSeleccionado !=""){
			    var codVendedor = document.getElementById("codVendedor");
			    var encontrado = false;
			    for (index = 0; index< codVendedor.length; index++) {
			       	  if (codVendedor[index].value == codVendedorSeleccionado){
			        	codVendedor.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codVendedorSeleccionado").value = ""
		    }
		    
	    }//fin if (data!=null)
	}
	//(-)-- carga combo vendedor--

 	function fncBuscarCliente(){
		  	document.getElementById("opcion").value = "buscarCliente";
	    	document.forms[0].submit();
	 }
	 
 	//(+)-- obtiene lista de ventas segun filtros --
 	function fncBuscarVentas(){
			var numVenta = document.getElementById("numVenta").value;
			var codVendedor = document.getElementById("codVendedor").value;
			var codOficina = document.getElementById("codOficina").value;
			var codCliente = document.getElementById("codCliente").value;			
			var fechaDesde = document.getElementById("fechaDesde").value;		
			var fechaHasta = document.getElementById("fechaHasta").value;	
			var codEstadoVenta = document.getElementById("codEstadoVenta").value;
			
			var codTipoDocumento = document.getElementById("codTipoDocumento");
			if (codTipoDocumento != null && codTipoDocumento.value == "FUSU") {
				codEstadoVenta = "AC";
			}
			
			var indOrigenConsultaVTA = document.getElementById("indOrigenConsultaVTA").value;
				
			if (numVenta == "" && codVendedor == "" && codCliente == ""){
				alert("Debe ingresar al menos un filtro entre N\u00FAmero Venta, Vendedor, o Cliente");
				return false;
			}			
			if (numVenta == "" && (fechaDesde == "" || fechaHasta == "")){
				alert("Debe ingresar Rango de Fechas");
				return false;
			}
			
			if (numVenta != ""){
				//valida numero de venta
				numVenta = parseInt(numVenta);
		        if (isNaN(numVenta)) { 
			        alert("N\u00FAmero de Venta Inv\u00E1lido");
			        document.getElementById("numVenta").value = "";
		            return false; 
		        }
		        document.getElementById("numVenta").value = numVenta;
			}
			
			document.getElementById("divResultadoBusqueda").style["display"] = "none";
			
			JConsultaVentasVendedorAJAX.obtenerVentasxVendedor(numVenta, codVendedor, codOficina, 
				codCliente, fechaDesde, fechaHasta, codEstadoVenta, indOrigenConsultaVTA, fncResultadoObtenerVentasxVendedor);
	 }
	 
	 function fncResultadoObtenerVentasxVendedor(data) {
		if (data != null) {
	        var codError = data["codError"]; 
	        var mensajeError = data["msgError"]; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	if (codError == "200" || codError == "300"){
					document.getElementById("divResultados").style["display"] = "none";
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        else {
	        	document.getElementsByName("divResultados")[0].style["display"] = "";
	        }
	    }
		document.getElementById("numVentaSel").value = "";	    
		document.getElementById("opcion").value = "buscarVentas";
	   	document.forms[0].submit();
	}
	//(-)-- obtiene lista de ventas segun filtros --
	
	function fncSeleccionaVendedor(codVendedor){
		document.getElementById("codVendedorSeleccionado").value = codVendedor.value;	    
	}

	function fncSeleccionaVenta(numVenta){
		document.getElementById("numVentaSel").value = numVenta.value;	    
	}
	 
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncContinuar(){
		var numVentaSel = document.getElementById("numVentaSel");
		if (numVentaSel.value==""){
			alert("Debe seleccionar una venta");
			return false;
		}
		
	  	document.getElementById("opcion").value = "listarLineas";
    	document.forms[0].submit();
	}
	
	function fncContinuarAsociacionDocumentos() {
		var numVentaSel = document.getElementById("numVentaSel");
		if (numVentaSel.value == "")
		{
			alert("Debe seleccionar una venta");
			return false;
		}
		var url = 'AsocDocDigitalizadoVentaAction.do?opcion=inicio&numVentaSel='+ numVentaSel.value;
		window.location.assign(url);
	}
	
	function fncContinuarOverrideSolicitud() {
		var numVentaSel = document.getElementById("numVentaSel");
		if (numVentaSel.value == "") {
			alert("Debe seleccionar una venta");
			return false;
		}
		document.getElementById("opcion").value = "continuarOverrideSolicitud";
    	document.forms[0].submit();
	}
	
	function fncContinuarDocumentos() {
		var codTipoDocumento = document.getElementById("codTipoDocumento");
		var numVentaSel = document.getElementById("numVentaSel");
		if (codTipoDocumento.value == "") {
			alert("Debe seleccionar un tipo de documento");
			return false;
		}
				
		if (numVentaSel.value==""){
			alert("Debe seleccionar una venta");
			return false;
		}
		
	  	document.getElementById("opcion").value = "continuarDocumentos";
    	document.forms[0].submit();
	}
	
	function fncContinuarEvaluacion(){
		var numVentaSel = document.getElementById("numVentaSel");
		if (numVentaSel.value==""){
			alert("Debe seleccionar una venta");
			return false;
		}
		
	  	document.getElementById("opcion").value = "continuarEvaluacion";
    	document.forms[0].submit();	
	}
	
	function fncLimpiar(){
	  	document.getElementById("opcion").value = "limpiarConsulta";
    	document.forms[0].submit();
	}
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}	
</script>
</head>
<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/ConsultaVentasVendedorAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
	<html:hidden property="moduloOrigenVenta" styleId="moduloOrigenVenta"/>
	<html:hidden property="codVendedorSeleccionado" styleId="codVendedorSeleccionado"/>
	<html:hidden property="numVentaSel" styleId="numVentaSel"/>
	<html:hidden property="indOrigenConsultaVTA" styleId="indOrigenConsultaVTA"/>
	<!-- (+) Modulos desde los cuales se llama a esta JSP -->
	<bean:define id="codModuloConsultaPreVenta" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaPreVenta" type="java.lang.String" />
	<bean:define id="codModuloConsultaVenta" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaVenta" type="java.lang.String" />
	<bean:define id="codModuloAsociacionDocumentos" name="ConsultaVentasVendedorForm"
		property="codModuloAsociacionDocumentos" type="java.lang.String" />
	<bean:define id="codModuloOverrideSolicitud" name="ConsultaVentasVendedorForm"
		property="codModuloOverrideSolicitud" type="java.lang.String" />
	<bean:define id="codModuloConsultaDesbloqueo" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaDesbloqueo" type="java.lang.String" />
	<bean:define id="codModuloConsultaCargosInst" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaCargosInst" type="java.lang.String" />
	<bean:define id="codModuloConsultaDocumentos" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaDocumentos" type="java.lang.String" />
	<bean:define id="codModuloEvaluacion" name="ConsultaVentasVendedorForm"
		property="codModuloEvaluacion" type="java.lang.String" />
	<bean:define id="codModuloMisPendientesEval" name="ConsultaVentasVendedorForm"
		property="codModuloMisPendientesEval" type="java.lang.String" />
	<bean:define id="codModuloMisPendientesInst" name="ConsultaVentasVendedorForm"
		property="codModuloMisPendientesInst" type="java.lang.String" />
	<!-- (-) Modulos desde los cuales se llama a esta JSP -->
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Consulta Ventas por Vendedor&nbsp;-&nbsp;<bean:write
				name="ConsultaVentasVendedorForm" property="glsModulo" />
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="mensajeError">
				<bean:write name="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%">
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDocumentos %>">
			<tr>
				<td align="left"
					style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
				Tipo Documento:</td>
				<td align="left" colspan="4"><c:choose>
					<c:when test="${!empty requestScope.disableTipDoc && requestScope.disableTipDoc == 'true'}">
						<html:select name="ConsultaVentasVendedorForm" property="codTipoDocumento" styleId="codTipoDocumento"
							onchange="ocultarMensajeError();" style="width:300px;" disabled="true">
							<html:option value="">- Seleccione -</html:option>
							<html:option value="STER">Solicitud de Terminales</html:option>
							<html:option value="PSER">Contrato Prestaci&oacute;n de Servicios</html:option>
							<html:option value="FUSU">Ficha Usuario Prepago</html:option>
							<html:option value="PAGA">Pagar&eacute;</html:option>
							<!-- Inicio P-CSR-11002 JLGN 29-10-2011 -->
							<html:option value="FACT">Factura Venta</html:option>
							<!-- Fin P-CSR-11002 JLGN 29-10-2011 -->
							<!-- Inicio P-CSR-11002 JLGN 11-11-2011 -->
							<html:option value="CONT">Impresion Contrato</html:option>
							<!-- Fin P-CSR-11002 JLGN 11-11-2011 -->
						</html:select>
					</c:when>
					<c:otherwise>
						<html:select name="ConsultaVentasVendedorForm" property="codTipoDocumento" styleId="codTipoDocumento"
							onchange="ocultarMensajeError();" style="width:300px;">
							<html:option value="">- Seleccione -</html:option>
							<html:option value="STER">Solicitud de Terminales</html:option>
							<html:option value="PSER">Contrato Prestacion de Servicios</html:option>
							<html:option value="FUSU">Ficha Registro Usuario</html:option>
							<html:option value="PAGA">Pagar&eacute;</html:option>
							<!-- Inicio P-CSR-11002 JLGN 29-10-2011 -->
							<html:option value="FACT">Factura Venta</html:option>
							<!-- Fin P-CSR-11002 JLGN 29-10-2011 -->	
							<!-- Inicio P-CSR-11002 JLGN 11-11-2011 -->
							<html:option value="CONT">Impresion Contrato</html:option>
							<!-- Fin P-CSR-11002 JLGN 11-11-2011 -->						
						</html:select>
					</c:otherwise>
				</c:choose></td>
			</tr>
			<tr>
				<td colspan="5">
				<HR noshade>
				</td>
			</tr>
		</logic:equal>
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Datos Venta:</td>
		</tr>
		<tr>
			<td align="left">N&uacute;mero Venta</td>
			<td align="left" colspan="4"><c:choose>
				<c:when test="${!empty requestScope.disableDatVent && requestScope.disableDatVent == 'true'}">
					<html:text name="ConsultaVentasVendedorForm" property="numVenta" styleId="numVenta" onkeypress="onlyInteger();"
						size="30" maxlength="15" onchange="ocultarMensajeError();" disabled="true" />
				</c:when>
				<c:otherwise>
					<html:text name="ConsultaVentasVendedorForm" property="numVenta" styleId="numVenta" onkeypress="onlyInteger();"
						size="30" maxlength="15" onchange="ocultarMensajeError();" />
				</c:otherwise>
			</c:choose></td>
		</tr>
		<!--------------------  (+) combo de estados ----------------------->
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaPreVenta %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaVenta %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<html:option value="">- Seleccione -</html:option>
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloAsociacionDocumentos %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" styleId="codEstadoVenta" style="width:300px;" onchange="ocultarMensajeError();">
					<html:option value="">- Seleccione -</html:option>
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloOverrideSolicitud %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDesbloqueo %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaCargosInst %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloMisPendientesEval %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<html:option value="">- Seleccione -</html:option>
					<html:option value="IN">PENDIENTE DE REVISION</html:option>
					<html:option value="PR">PENDIENTE DE ANALISIS</html:option>
					<html:option value="AP">APROBADO PARCIAL</html:option>
					<html:option value="RZ">RECHAZADO</html:option>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloMisPendientesInst %>">
			<tr>
				<td align="left">Estado Venta</td>
				<td align="left" colspan="4"><html:select name="ConsultaVentasVendedorForm"
					property="codEstadoVenta" style="width:300px;" styleId="codEstadoVenta" onchange="ocultarMensajeError();">
					<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayEstadosVenta">
						<html:optionsCollection property="arrayEstadosVenta" value="codigoValor"
							label="descripcionValor" />
					</logic:notEmpty>
				</html:select></td>
			</tr>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDocumentos %>">
			<html:hidden property="codEstadoVenta" value="" styleId="codEstadoVenta" />
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloEvaluacion %>">
			<html:hidden property="codEstadoVenta" value="" styleId="codEstadoVenta" />
		</logic:equal>
		<!--------------------  (-) combo de estados ----------------------->
		<tr>
			<td colspan="5">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Datos Vendedor:</td>
		</tr>
		<tr>
			<td align="left">Oficina</td>
			<td align="left" colspan="3"><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:select name="ConsultaVentasVendedorForm" property="codOficina" style="width:300px;" styleId="codOficina"
						onchange="ocultarMensajeError();fncObtenerVendedores();" disabled="true">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayOficina">
							<html:optionsCollection property="arrayOficina" value="codigoOficina"
								label="descripcionOficina" />
						</logic:notEmpty>
					</html:select>
				</c:when>
				<c:otherwise>
					<html:select name="ConsultaVentasVendedorForm" property="codOficina" style="width:300px;" styleId="codOficina"
						onchange="ocultarMensajeError();fncObtenerVendedores();">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="ConsultaVentasVendedorForm" property="arrayOficina">
							<html:optionsCollection property="arrayOficina" value="codigoOficina"
								label="descripcionOficina" />
						</logic:notEmpty>
					</html:select>
				</c:otherwise>
			</c:choose></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td align="left">Vendedor</td>
			<td align="left" colspan="3"><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:select name="ConsultaVentasVendedorForm" property="codVendedor" style="width:300px;" styleId="codVendedor"
						onchange="ocultarMensajeError();fncSeleccionaVendedor(this);" disabled="true">
						<html:option value="">- Seleccione -</html:option>
					</html:select>
				</c:when>
				<c:otherwise>
					<html:select name="ConsultaVentasVendedorForm" property="codVendedor" style="width:300px;" styleId="codVendedor"
						onchange="ocultarMensajeError();fncSeleccionaVendedor(this);">
						<html:option value="">- Seleccione -</html:option>
					</html:select>
				</c:otherwise>
			</c:choose></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="5">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Datos Cliente:</td>
		</tr>
		<tr>
			<td align="left"><c:if
				test="${empty requestScope.disableComponente || requestScope.disableComponente == 'false'}">
				<a href="javascript:fncBuscarCliente();" onclick="ocultarMensajeError();"><FONT
					color="#0000ff">Buscar Cliente</FONT></a>
			</c:if></td>
		</tr>
		<tr>
			<td align="left" width="25%">Tipo Cliente</td>
			<td align="left" width="10%"><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:text name="ConsultaVentasVendedorForm" property="glsTipoCliente" styleId="glsTipoCliente"
						style="text-transform: uppercase;" size="30" readonly="true" disabled="true" />
				</c:when>
				<c:otherwise>
					<html:text name="ConsultaVentasVendedorForm" property="glsTipoCliente" styleId="glsTipoCliente"
						style="text-transform: uppercase;" size="30" readonly="true" />
				</c:otherwise>
			</c:choose></td>
			<td align="left" width="15%">C&oacute;digo Cliente</td>
			<td align="left" width="50%"><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:text name="ConsultaVentasVendedorForm" property="codCliente" size="30" readonly="true" styleId="codCliente"
						disabled="true" />
				</c:when>
				<c:otherwise>
					<html:text name="ConsultaVentasVendedorForm" property="codCliente" size="30" readonly="true" styleId="codCliente" />
				</c:otherwise>
			</c:choose></td>
			<td width="10%">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="5">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Rango Fechas:</td>
		</tr>
		<tr>
			<td align="left">(*) Desde</td>
			<td align="left" nowrap><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:text name="ConsultaVentasVendedorForm" property="fechaDesde" size="30" readonly="true" styleId="fechaDesde"
						tabindex="1" disabled="true" />
				</c:when>
				<c:otherwise>
					<html:text name="ConsultaVentasVendedorForm" property="fechaDesde" size="30" readonly="true" styleId="fechaDesde"
						tabindex="1" />
					<a href="#"><img name="fec1" src="<%=request.getContextPath()%>/img/calendar/calendar.gif"
						border="0" class="select"
						onClick="ocultarMensajeError();displayCalendar(fechaDesde,'dd-mm-yyyy',this)"></a>
				</c:otherwise>
			</c:choose></td>
			<td align="left">(*) Hasta</td>
			<td align="left"><c:choose>
				<c:when
					test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}">
					<html:text name="ConsultaVentasVendedorForm" property="fechaHasta" size="30" readonly="true" styleId="fechaHasta"
						tabindex="2" disabled="true" />
				</c:when>
				<c:otherwise>
					<html:text name="ConsultaVentasVendedorForm" property="fechaHasta" size="30" readonly="true" styleId="fechaHasta"
						tabindex="2" />
					<a href="#"><img name="fec2" src="<%=request.getContextPath()%>/img/calendar/calendar.gif"
						border="0" class="select"
						onClick="ocultarMensajeError();displayCalendar(fechaHasta,'dd-mm-yyyy',this)"></a>
				</c:otherwise>
			</c:choose></td>
		</tr>
		<tr>
			<td colspan="5">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="5">
			<table width="100%">
				<tr>
					<td width="55%">&nbsp;</td>
					<td width="10%"><html:button value="LIMPIAR" style="width:120px;color:black"
						property="btnLimpiar" onclick="ocultarMensajeError();fncLimpiar();" styleId="btnLimpiar" /></td>
					<td width="25%" align="right"><c:choose>
						<c:when test="${!empty requestScope.disableBuscar && requestScope.disableBuscar == 'true'}">
							<html:button value="BUSCAR" style="width:120px;color:black" property="btnBuscarVentas" styleId="btnBuscarVentas"
								onclick="ocultarMensajeError();fncBuscarVentas();" disabled="true" />
						</c:when>
						<c:otherwise>
							<html:button value="BUSCAR" style="width:120px;color:black" property="btnBuscarVentas" styleId="btnBuscarVentas"
								onclick="ocultarMensajeError();fncBuscarVentas();" />
						</c:otherwise>
					</c:choose></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td colspan="5">
			<HR noshade>
			</td>
		</tr>
	</table>
	<div id="divResultadoBusqueda" style="display:none">
	<h2 align="center">Coincidencias:<br>
	De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.</h2>
	</div>
	<P>
	<div id="divResultados" style="text-align: center;"><display:table id="ventas"
		name="listaPreVenta" scope="session" pagesize="10" requestURI="" width="90%">
		<logic:notEqual name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaVenta %>">
			<logic:notEqual name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloMisPendientesEval %>">
				<display:column title="Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
					width="4%">
					<input type="radio" name="rdVentaSel" onclick="ocultarMensajeError();fncSeleccionaVenta(this);"
						value="<bean:write name="ventas" property="nroVenta"/>">
				</display:column>
			</logic:notEqual>
		</logic:notEqual>
		<display:column property="nroVenta" title="Nro Venta" headerClass="textoColumnaTabla" width="10%" />
		<display:column property="fechaVenta" title="Fecha" headerClass="textoColumnaTabla" width="10%" />
		<display:column property="nombreCliente" title="Nombre Cliente" headerClass="textoColumnaTabla"
			width="23%" />
		<display:column property="nombreVendedor" title="Nombre Vendedor" headerClass="textoColumnaTabla"
			width="23%" />
		<display:column property="tipoVenta" title="Tipo Venta" headerClass="textoColumnaTabla"
			width="10%" />
		<display:column property="estado" title="Estado" headerClass="textoColumnaTabla" width="20%" />
	</display:table></div>
	<P>
	<P>
	<P>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td align="left" width="50%"></td>
			<td width="25%" align="right"></td>
			<td width="25%" align="right"><logic:equal name="ConsultaVentasVendedorForm"
				property="moduloOrigenVenta" value="<%= codModuloConsultaPreVenta %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuar();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloAsociacionDocumentos %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuarAsociacionDocumentos();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloOverrideSolicitud %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuarOverrideSolicitud();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloConsultaDesbloqueo %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuar();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloConsultaCargosInst %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuar();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloConsultaDocumentos %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuarDocumentos();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloEvaluacion %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuarEvaluacion();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloMisPendientesInst %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar"
					onclick="ocultarMensajeError();fncContinuar();" />
			</logic:equal></td>
		</tr>
	</TABLE>
	<P>
	<TABLE align="center" width="90%">
		<tr>
			<td align="left"><i>(*) : Dato es obligatorio</i></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
