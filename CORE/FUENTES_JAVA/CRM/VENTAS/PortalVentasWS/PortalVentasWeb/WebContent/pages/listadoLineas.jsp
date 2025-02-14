<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JCargosAJAX.js'></script>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
 	window.history.forward(1);
 	
	function fncEliminarLinea(numAbonado){       
	        if (confirm("¿Esta seguro que desea eliminar la l\u00EDnea?"))
	        {
				document.getElementById("opcion").value = "eliminarAbonado";
			  	document.getElementById("numAbonadoSel").value = numAbonado;
		    	document.forms[0].submit();
			}
		  	
	} 	
	
	function fncDesbloquearLinea(numAbonado){       
	        if (confirm("¿Esta seguro que desea desbloquear el tel\u00E9fono?"))
	        {
	        	alert("Solicitud de desbloqueo realizada exitosamente");
				document.getElementById("opcion").value = "desbloquearAbonado";
			  	document.getElementById("numAbonadoSel").value = numAbonado;
		    	document.forms[0].submit();
			}
		  	
	} 	
	
	function fncCargosInst(cargos,indMacAddress,numAbonado){
		//TODO: SE MODIFICA PARA PRUEBAS WIMAX - SANTIAGO VENTURA		
		var url = "<%=request.getContextPath()%>/pages/cargosInstalacion.jsp?indMacAddress="+indMacAddress+"&cargos="+cargos;
		//alert('fncCargosInst:antes de abrir la ventana');		
		var  retorno = window.showModalDialog(url, "winCargos", "dialogHeight:250px; dialogWidth:550px; center:yes; menubar:no;help:no; status:no; resizable:no");
		//var  retorno = window.open(url, "winCargos", "dialogHeight:250px; dialogWidth:550px; center:yes; menubar:no;help:no; status:no; resizable:no");
		//alert('fncCargosInst:retorno '+retorno);	
		var splitRtn = retorno.split("|");
		var montoImporte = splitRtn[0];
		var macAddres = splitRtn[1];
		//alert('fncCargosInst:macAddres= '+macAddres);
		//alert('fncCargosInst:montoImporte= '+montoImporte);
		
		if (macAddres!=null) {
			//alert(macAddres);
			//numAbonado = document.getElementById(numAbonado).value;
			JCargosAJAX.registrarWimaxMacAddress(macAddres,numAbonado);
		}
		
		if (typeof montoImporte != "undefined"){
		    //document.getElementById(numAbonado).innerHTML="Instalado";
   		    document.getElementById(numAbonado).disabled=true;
		    //document.getElementById(numAbonado).href="#";
		    document.getElementById("e"+numAbonado).disabled=true;
		    //document.getElementById("e"+numAbonado).href="#";
		    JCargosAJAX.registrarCargosInstalacion(montoImporte,numAbonado);
		    
		    //actualizar estado abonado
			JCargosAJAX.actualizarEstadoAbonado(numAbonado,"AAA", fncResultadoCambiarEstadoAbonado);		    
		}else{
			document.getElementById(numAbonado).selectedIndex = 0;
			document.getElementById(numAbonado).value ="";
			
		}
				
		return;	
	} 
	

	 
	function fncAnterior(){
			document.getElementById("opcion").value = "anteriorMostrarLineas";
		   	document.forms[0].submit();
	}
	
	function fncSeleccionaAbonado(numAbonado){
			document.getElementById("numAbonadoSel").value = numAbonado.value;	
	}
	
	function fncContinuarDoc(){
			var numAbonadoSel = document.getElementById("numAbonadoSel");

			if (numAbonadoSel.value==""){
				alert("Debe seleccionar un abonado");
				return false;
			}
			document.getElementById("opcion").value = "continuarDocumentosAbonado";
		   	document.forms[0].submit();
	}
	
	function fncContinuarMisPendientesInst(){
			var numAbonadoSel = document.getElementById("numAbonadoSel");

			if (numAbonadoSel.value==""){
				alert("Debe seleccionar un abonado");
				return false;
			}
			document.getElementById("opcion").value = "continuarMisPendientesInst";
		   	document.forms[0].submit();
	}
	
	function fncCambiarEstadoAbonado(numAbonado, indMacAddress, codEstado){
		//TODO: SE MODIFICA PARA PRUEBAS WIMAX - SANTIAGO VENTURA
		var cargos = "0";
		if (codEstado == "AAA"){
			if (confirm("¿Desea agregar cargos de instalaci\u00F3n")) {
				//fncCargosInst(numAbonado);	
				cargos = "1";	
				fncCargosInst(cargos,indMacAddress,numAbonado);				 								
				return;
			}
			else {
				if (indMacAddress=='1') {//Si el indMacAddress se debe capturar la mac address, llamando al popup de cargos
					fncCargosInst(cargos,indMacAddress,numAbonado);
				} 									
			    document.getElementById("e"+numAbonado).disabled=true;
			    JCargosAJAX.registrarCargosInstalacion("0",numAbonado);
			}
		}
		
		//actualizar estado abonado
		//TODO: SE GRAGA PARA PRUEBAS WIMAX - SANTIAGO VENTURA
		JCargosAJAX.actualizarEstadoAbonado(numAbonado,codEstado, fncResultadoCambiarEstadoAbonado);
		document.getElementById(numAbonado).disabled=true;	    
	}	
	
	function fncResultadoCambiarEstadoAbonado(data) {

		if (data!=null) {
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	    }//fin if (data!=null)
	}
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}
	
	function fncFormalizarSolicitud() {
		document.getElementById("btnFormalizar").disabled = true;
		document.getElementById("btnAnterior").disabled = true;			
		
		//BLOQUEAR MENU
		var win = parent;
		win.fncBloqueaVenta();
	
	  	document.getElementById("opcion").value = "formalizarSolicitud";
    	document.forms[0].submit();
	}
	
	function continuarAOverrideFormalizacion() {
		if (window.confirm("¿Desea sobreescribir cargos?")) {
		  	document.getElementById("opcion").value = "continuarAOverrideFormalizacion";
	    	document.forms[0].submit();
    	}
    	else {
	    	fncFormalizarSolicitud();
    	}
	}
		
</script>
</head>
<body onload="history.go(+1);" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/ConsultaVentasVendedorAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="numAbonadoSel" styleId="numAbonadoSel"/>
	<!-- (+) Modulos desde los cuales se llama a esta JSP -->
	<bean:define id="codModuloConsultaPreVenta" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaPreVenta" type="java.lang.String" />
	<bean:define id="codModuloConsultaDesbloqueo" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaDesbloqueo" type="java.lang.String" />
	<bean:define id="codModuloConsultaCargosInst" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaCargosInst" type="java.lang.String" />
	<bean:define id="codModuloConsultaDocumentos" name="ConsultaVentasVendedorForm"
		property="codModuloConsultaDocumentos" type="java.lang.String" />
	<bean:define id="codModuloMisPendientesInst" name="ConsultaVentasVendedorForm"
		property="codModuloMisPendientesInst" type="java.lang.String" />
	<!-- (-) Modulos desde los cuales se llama a esta JSP -->
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">L&iacute;neas agregadas a la Solicitud&nbsp;
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%">
		<bean:define id="ventaSel" name="ventaSel" scope="session" />
		<tr>
			<td align="left" colspan="5"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
			Datos Venta:</td>
		</tr>
		<tr>
			<td align="left" width="15%">N&uacute;mero Venta</td>
			<td align="left" width="40%"><bean:write name="ventaSel" property="nroVenta" /></td>
			<td align="left" width="10%">Fecha</td>
			<td align="left" width="35%"><bean:write name="ventaSel" property="fechaVenta" /></td>
		</tr>
		<tr>
			<td align="left" width="15%">Vendedor</td>
			<td align="left" colspan="3"><bean:write name="ventaSel" property="nombreVendedor" /></td>
		</tr>
		<tr>
			<td align="left" width="15%">Cliente</td>
			<td align="left" colspan="3"><bean:write name="ventaSel" property="nombreCliente" /></td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	<P><display:table id="lineas" name="listaLineas" scope="session" pagesize="10" requestURI=""
		width="90%">
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDocumentos %>">
			<display:column title="Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
				width="4%">
				<input type="radio" name="rdAbonadoSel" onclick="fncSeleccionaAbonado(this);"
					value="<bean:write name="lineas" property="numAbonado"/>">
			</display:column>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloMisPendientesInst %>">
			<display:column title="Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
				width="4%">
				<logic:notEqual name="lineas" property="codSituacion" value="ARE">
					<input type="radio" name="rdAbonadoSel" onclick="fncSeleccionaAbonado(this);"
						value="<bean:write name="lineas" property="numAbonado"/>">
				</logic:notEqual>
			</display:column>
		</logic:equal>
		<display:column property="rowNum" title="Línea" headerClass="textoColumnaTabla" width="3%" />
		<display:column property="numAbonado" title="Nro Abonado" headerClass="textoColumnaTabla"
			width="10%" />
		<display:column property="codGrpPrestacion" title="Prestacion" headerClass="textoColumnaTabla"
			width="20%" />
		<display:column property="numCelular" title="Celular" headerClass="textoColumnaTabla" width="10%" />
		<display:column property="codPlanTarif" title="Plan Tarifario" headerClass="textoColumnaTabla"
			width="20%" />
		<display:column property="desSituacion" title="Estado" headerClass="textoColumnaTabla" width="10%" />
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDesbloqueo %>">
			<display:column title="" headerClass="textoColumnaTabla" width="17%">
				<a href="javascript:fncDesbloquearLinea('<bean:write name="lineas" property="numAbonado"/>');"><FONT
					color="#0000ff">Desbloquear</FONT></a>
			</display:column>
		</logic:equal>
		<logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaCargosInst %>">
			<display:column title="Estado Nuevo" headerClass="textoColumnaTabla" width="17%">
				<logic:notEqual name="lineas" property="codSituacion" value="ARE">
					<select name="codEstadoNuevo" id="<bean:write name="lineas" property="numAbonado"/>"
						onchange="ocultarMensajeError();fncCambiarEstadoAbonado('<bean:write name="lineas" property="numAbonado" />','<bean:write name="lineas" property="indMacAddress" />',this.value);"
						style="width:110px;">
						<option value="">- Seleccione -</option>
						<option value="AAA">INSTALADO</option>
						<option value="ARE">RECHAZADO</option>
					</select>
				</logic:notEqual>
				<!-- <a href="javascript:fncCargosInst('<bean:write name="lineas" property="numAbonado" />');" id="<bean:write name="lineas" property="numAbonado"/>"> <FONT color="#0000ff">Cargos de Instalaci&oacuten</FONT></a>
				 -->
				</td>
			</display:column>
		</logic:equal>
		<logic:notEqual name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
			value="<%= codModuloConsultaDocumentos %>">
			<logic:notEqual name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloMisPendientesInst %>">
				<logic:notEqual name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
					value="<%= codModuloConsultaDesbloqueo %>">
					<display:column title="" headerClass="textoColumnaTabla" width="10%">
						<a href="javascript:fncEliminarLinea('<bean:write name="lineas" property="numAbonado"/>');"
							id="e<bean:write name="lineas" property="numAbonado"/>"><FONT color="#0000ff">Eliminar</FONT></a>
					</display:column>
				</logic:notEqual>
			</logic:notEqual>
		</logic:notEqual>
	</display:table>
	<P>
	<P>
	<P>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td width="25%" align="left"><html:button style="width:120px; color:black"
				property="btnAnterior" styleId="btnAnterior" onclick="fncAnterior();"><<</html:button></td>
			<td width="75%" align="right"><logic:equal name="ConsultaVentasVendedorForm"
				property="moduloOrigenVenta" value="<%= codModuloConsultaPreVenta %>">
				<!-- Inicio P-CSR-11002 JLGN 12-05-2011 -->	
			    <logic:equal name="ConsultaVentasVendedorForm" property="defOverride" value="TRUE">							
					<logic:equal value="false" name="ConsultaVentasVendedorForm"
						property="activarOverrideFormalizacion">
						<html:button onclick="fncFormalizarSolicitud()" property="btnFormalizar" styleId="btnFormalizar"
							style="width:260px; color:black; text-align: center;" value="FORMALIZAR SOLICITUD DE VENTA" />
					</logic:equal>
					<logic:equal value="true" name="ConsultaVentasVendedorForm"
						property="activarOverrideFormalizacion">
						<html:button onclick="continuarAOverrideFormalizacion()" property="btnFormalizar" styleId="btnFormalizar"
							style="width:260px; color:black; text-align: center;" value="FORMALIZAR SOLICITUD DE VENTA" />
					</logic:equal>
				</logic:equal>	
				<logic:equal name="ConsultaVentasVendedorForm" property="defOverride" value="FALSE">
					<html:button onclick="fncFormalizarSolicitud()" property="btnFormalizar" styleId="btnFormalizar"
					style="width:260px; color:black; text-align: center;" value="FORMALIZAR SOLICITUD DE VENTA" />
				</logic:equal>
				<!-- Fin P-CSR-11002 JLGN 12-05-2011 -->
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloConsultaDocumentos %>">
				<html:button value=">>" style="width:120px;color:black" property="btnContinuarDoc" styleId="btnContinuarDoc"
					onclick="fncContinuarDoc();" />
			</logic:equal> <logic:equal name="ConsultaVentasVendedorForm" property="moduloOrigenVenta"
				value="<%= codModuloMisPendientesInst %>">
				<logic:notEmpty id="lineas" name="listaLineas" scope="session" >
				<html:button value=">>" style="width:120px;color:black" property="btnContinuarDoc" styleId="btnContinuarDoc"
					onclick="fncContinuarMisPendientesInst();" />
				</logic:notEmpty>
			</logic:equal></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
