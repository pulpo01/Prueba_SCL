<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
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
<script>

    var ejecutandoAjax = false;
    var ultimoObjetoFoco;
    var validandoIdentificacion = false;
    var formatoNIT = "<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT = "<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";

	function fncInicio() {
		fncConfigPantallaSegunTipoPrestacion();
	}
	
	//(+) -- configuracion de pantalla segun tipo prestacion --
	function fncConfigPantallaSegunTipoPrestacion() {
			var codTelefoniaMovil = document.getElementById("codTelefoniaMovil").value;			
			var codTelefoniaFija = document.getElementById("codTelefoniaFija").value;	
			var codInternet = document.getElementById("codInternet").value;	
			var codCarrier = document.getElementById("codCarrier").value;	
									
			var codGrpPrestacion = document.getElementById("codGrpPrestacion").value;	
			var indInvFijo = document.getElementById("indInvFijo").value;
			var indNumero = document.getElementById("indNumero").value;
			var indDirInstalacion = document.getElementById("indDirInstalacion").value;			
			var indNumeroPiloto = document.getElementById("indNumeroPiloto").value;
			var codTecnologia = document.getElementById("codTecnologia").value;
			
			//(+) ------------- Simcard y Equipo --------------------
			//inventario fijo				
			if((indInvFijo == "1") && (codGrpPrestacion == codTelefoniaMovil || codGrpPrestacion == codTelefoniaFija) )
			{
				if (codGrpPrestacion == codTelefoniaMovil) { //TM
					if (codTecnologia == "GSM") {
						//mostrar seccion simcard y equipo
						document.getElementById("divSimcardTitulo").style["display"] = "";
						document.getElementById("divSimcardLink").style["display"] = "";
						document.getElementById("divSimcard").style["display"] = "";						
						document.getElementById("divEquipoTitulo").style["display"] = "";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "";
						document.getElementById("divEquipoLink").style["display"] = "";						
						document.getElementById("divEquipo").style["display"] = "";						
					}else if (codTecnologia == "CDMA"){
						//mostrar seccion equipo, y ocultar simcard
						document.getElementById("divSimcardTitulo").style["display"] = "none";
						document.getElementById("divSimcardLink").style["display"] = "none";						
						document.getElementById("divSimcard").style["display"] = "none";						
						document.getElementById("divEquipoTitulo").style["display"] = "";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "";						
						document.getElementById("divEquipoLink").style["display"] = "";						
						document.getElementById("divEquipo").style["display"] = "";						
					}else{
						//ocultar seccion simcard y equipo
						document.getElementById("divSimcardTitulo").style["display"] = "none";
						document.getElementById("divSimcardLink").style["display"] = "none";
						document.getElementById("divSimcard").style["display"] = "none";						
						document.getElementById("divEquipoTitulo").style["display"] = "none";
						document.getElementById("divEquipoLinkSeguro").style["display"] = "none";
						document.getElementById("divEquipoLink").style["display"] = "none";						
						document.getElementById("divEquipo").style["display"] = "none";
						
					}
					
				}
				if (codGrpPrestacion == codTelefoniaFija){ //TF				    
					//mostrar seccon equipo externo, ocultar simcard
					document.getElementById("divSimcardTitulo").style["display"] = "none";
					document.getElementById("divSimcardLink").style["display"] = "none";
					document.getElementById("divSimcard").style["display"] = "none";					
					document.getElementById("divEquipoTitulo").style["display"] = "";
					document.getElementById("divEquipoLinkSeguro").style["display"] = "";
					document.getElementById("divEquipoLink").style["display"] = "";					
					document.getElementById("divEquipo").style["display"] = "";					
				}
				
			}else{
				//ocultar seccion simcard y equipo
				document.getElementById("divSimcardTitulo").style["display"] = "none";
				document.getElementById("divSimcardLink").style["display"] = "none";
				document.getElementById("divSimcard").style["display"] = "none";
				document.getElementById("divEquipoTitulo").style["display"] = "none";
				document.getElementById("divEquipoLinkSeguro").style["display"] = "none";
				document.getElementById("divEquipoLink").style["display"] = "none";				
				document.getElementById("divEquipo").style["display"] = "none";				
			}
			//(-)  ------------- Simcard y Equipo --------------------
			
			//(+) --------------- numeracion -------------------------
			if (indNumero == "1") {
				//mostrar seccion numero
				//deshabilitar texto ingreso numero						
				document.getElementById("divNumeracionTitulo").style["display"] = "";
				document.getElementById("divNumeracionLink").style["display"] = "";				
				document.getElementById("divNumeracion").style["display"] = "";
				document.getElementById("divNumeracionInternet").style["display"] = "none";
			}
			else {
				if (codGrpPrestacion == codInternet) { //IE
					//Incidencia 134176. Se elimina la numeracion en el caso del grupo de prestaciones internet
					//document.getElementById("divNumeracionTitulo").style["display"] = "";
					document.getElementById("divNumeracionTitulo").style["display"] = "none";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					//document.getElementById("divNumeracionInternet").style["display"] = "";		
					document.getElementById("divNumeracionInternet").style["display"] = "none";
					//document.forms[0].rdProcedenciaNumero[0].disabled = false;
				}
				else if (codGrpPrestacion == codCarrier) { //CA
					//habilitar texto ingreso numero y ocultar link numero
					document.getElementById("divNumeracionTitulo").style["display"] = "";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					document.getElementById("divNumeracionInternet").style["display"] = "";		
					document.getElementById("procedenciaNumero").value = "E";
					document.forms[0].rdProcedenciaNumero[0].disabled = true;
					document.forms[0].rdProcedenciaNumero[1].checked = true;											
				}
				else {
					//ocultar seccion numero
					document.getElementById("divNumeracionTitulo").style["display"] = "none";
					document.getElementById("divNumeracionLink").style["display"] = "none";					
					document.getElementById("divNumeracion").style["display"] = "none";
					document.getElementById("divNumeracionInternet").style["display"] = "none";	
				}
			}
			//(-) --------------- numeracion -------------------------
			
			document.getElementById("divDireccionPersonal").style["display"] = "";
			//Direccion de instalacion
			if (indDirInstalacion=="1"){
				document.getElementById("divDireccionInstalacion").style["display"] = "";
			}else{
				document.getElementById("divDireccionInstalacion").style["display"] = "none";
			}

			var flgSerieKit = document.getElementById("flgSerieKit");
			if (flgSerieKit.value =="1"){//oculta links de ingreso de series y numero
				document.getElementById("divEquipoTitulo").style["display"] = "";
				document.getElementById("divEquipoLinkSeguro").style["display"] = "";
				document.getElementById("divEquipoLink").style["display"] = "none";
				document.getElementById("divEquipo").style["display"] = "";
				document.getElementById("divNumeracionTitulo").style["display"] = "";				
				document.getElementById("divNumeracionLink").style["display"] = "none";
				document.getElementById("divNumeracion").style["display"] = "";		
				document.getElementById("divNumeracionInternet").style["display"] = "none";				
			}
			
			var flgSerieNumerada = document.getElementById("flgSerieNumerada");			
			if (flgSerieNumerada.value =="1"){//oculta link de ingreso de numero
				document.getElementById("divNumeracionTitulo").style["display"] = "";				
				document.getElementById("divNumeracionLink").style["display"] = "none";
				document.getElementById("divNumeracion").style["display"] = "";		
				document.getElementById("divNumeracionInternet").style["display"] = "none";	
			}			
	}//fin fncConfigPantallaSegunTipoPrestacion
	
	//(-) -- configuracion de pantalla segun tipo prestacion --
	
	 function fncBuscarSimcard(){
	 	 	if (ejecutandoAjax) return;
	 	 	
	 		if (fncVerificaParametrosSeries()){
	 		  	document.getElementById("opcion").value = "buscarSimcard";
	 		   	document.forms[0].submit();
	 		}
	 }
	 	
	 function fncBuscarEquipo(){
	 	 	if (ejecutandoAjax) return;
	 	 	
			if (fncVerificaParametrosSeries()){
	 	  		document.getElementById("opcion").value = "buscarEquipo";
	    		document.forms[0].submit();
	    	}
	 }
	 
	 function fncVerificaParametrosSeries(){
		var codTecnologia = document.getElementById("codTecnologia");
		var codTipoTerminal = document.getElementById("codTipoTerminal");
		var codUso = document.getElementById("codUsoLinea");
	
		if (codTecnologia.value ==""){
			alert("Debe Seleccionar Central");
			return false;
		}					
		if (codTipoTerminal.value == ""){
			alert("Debe Seleccionar Tipo Terminal");
			return false;
		}
		if (codUso.value == ""){
			alert("Debe Seleccionar Uso");
			return false;
		}
		
		return true;
	}
	
	function fncBuscarNumero(){
	
		if (ejecutandoAjax) return;
 	  	document.getElementById("opcion").value = "buscarNumero";
    	document.forms[0].submit();
    		    
	}	
	
	function fncIngresarDireccionPersonal(){
	 
	 	if (ejecutandoAjax) return;
	 	
		 var direccionPersonal = document.getElementById("direccionPersonal");
		 var irADirecciones = true;
		 
		 if (direccionPersonal.value == ""){
			 var direccionInstalacion = document.getElementById("direccionInstalacion");
			 if (direccionInstalacion.value!=""){
				 var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Instalaci\u00F3n como Personal?");
				 if (confirmar){
					//copiar INST en PERS
					JDatosLineaAJAX.copiarDireccion("INST_USU","PERS_USU",fncDummy);
					document.getElementById("direccionPersonal").value = document.getElementById("direccionInstalacion").value;
					irADirecciones = false;
				}
			 }
		 }//fin if (direccionPersonal.value == "")
		 
 		if (irADirecciones){
		  	document.getElementById("opcion").value = "ingresarDireccionPersonal";
	    	document.forms[0].submit();
	    }
	 }	
	
	 function fncIngresarDireccionInstalacion(){
	 
	 	if (ejecutandoAjax) return;
	 
		 var direccionInstalacion = document.getElementById("direccionInstalacion");
		 var irADirecciones = true;
		 
		 if (direccionInstalacion.value == ""){
			 var direccionPersonal = document.getElementById("direccionPersonal");
			 if (direccionPersonal.value!=""){
				 var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Instalaci\u00F3n ?");
				 if (confirmar){
					//copiar PERS en INST
					JDatosLineaAJAX.copiarDireccion("PERS_USU","INST_USU",fncDummy);
					document.getElementById("direccionInstalacion").value = document.getElementById("direccionPersonal").value;
					irADirecciones = false;
				}
			 }
		 }//fin if (direccionPersonal.value == "")	 
		 
 		if (irADirecciones){	 
		  	document.getElementById("opcion").value = "ingresarDireccionInstalacion";
	    	document.forms[0].submit();
	    }
	 }	
	 
	 
	 function fncValidaCampos() {

		var divSimcard  = document.getElementById("divSimcard").style["display"];
		if (divSimcard == ""){
		  	if (document.getElementById("numSerie").value=="")
		  	{
		  	    alert("Debe ingresar Simcard");
		  	    return false;
		  	} 				
		}
		
		var divEquipo  = document.getElementById("divEquipo").style["display"];
		if (divEquipo == ""){
		  	if (document.getElementById("numEquipo").value=="")
		  	{
		  	    alert("Debe ingresar Equipo");
		  	    return false;
		  	} 				
		}
						
		var divNumeracion = document.getElementById("divNumeracion").style["display"]
		
		if (divNumeracion == "") {
		  	if (document.getElementById("numCelular").value=="") {
		  	    alert("Debe ingresar Numeraci\u00F3n");
		  	    return false;
		  	} 				
		}
		
		var divNumeracion = document.getElementById("divNumeracionInternet").style["display"];
		
		if (divNumeracion == "") {
		  	if (document.getElementById("numCelularInternet").value=="") {
		  	    alert("Debe ingresar Numeraci\u00F3n");
		  	    return false;
		  	} 				

		  	if (document.getElementById("procedenciaNumero").value=="") {
		  		//verificar si radio tiene valor
				var chekRDInterno  = document.forms[0].rdProcedenciaNumero[0].checked;
				var chekRDExterno  = document.forms[0].rdProcedenciaNumero[1].checked;
				if(chekRDInterno) {
					document.getElementById("procedenciaNumero").value = "I";
				}
				else if(chekRDExterno) {
					document.getElementById("procedenciaNumero").value = "E";
				}
				else {
			  	    alert("Debe indicar si N\u00FAmero es Interno o Externo");
			  	    return false;
			  	}
		  	} 
		}
		
		if (document.getElementById("nomUsuario").value=="") {
	  	   alert ("Debe ingresar Nombre de Usuario");
	  	   return false;
		}
		
		if (document.getElementById("tipoIdentificacionUsuario").value=="") {
	  	   alert ("Debe ingresar Tipo Identificaci\u00F3n del Usuario");
	  	   return false;
		}
		
		if (document.getElementById("apellido1").value=="") {
	  	    alert("Debe ingresar Primer Apellido del Usuario");
	  	    return false;
	  	}
	  	
  	 	if (document.getElementById("apellido2").value=="") {
	  	    alert("Debe ingresar Segundo Apellido del Usuario");
	  	    return false;
	  	}
	  	 
	  	if (document.getElementById("tipoIdentificacionUsuario").value=="") {
	  	    alert("Debe ingresar Tipo de Identificaci\u00F3n del Usuario");
	  	    return false;
	  	}
	  	 
	  	if (document.getElementById("telefono").value=="") {
	  	    alert("Debe ingresar Tel\u00E9fono del Usuario");
	  	    return false;
		}
	  	 	  	
		var divDireccionPersonal = document.getElementById("divDireccionPersonal").style["display"];	
		
		if (divDireccionPersonal == "") {	  	 	  	
		  	 if (document.getElementById("direccionPersonal").value=="")
		  	 {
		  	    alert("Debe ingresar Direcci\u00F3n Personal");
		  	    return false;
		  	 } 
	  	}	
		
		var divDireccionInstalacion = document.getElementById("divDireccionInstalacion").style["display"];				

		if (divDireccionInstalacion == "") {
		  	if (document.getElementById("direccionInstalacion").value=="")
		  	{
		  	    alert("Debe ingresar Direcci\u00F3n de Instalaci\u00F3n");
		  	    return false;
		  	} 				
		}
		return true;
	}
	
	//(+)-- valida tipo identificacion --		
	function fncValidaTipoIdentificacion(tipoIdentSel, numIdentText) {
		/*if (!validandoIdentificacion) {
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				ejecutandoAjax = true;
				JDatosLineaAJAX.validarIdentificador(tipoIdentSel.value, numIdentText.value, fncResultadoValidacion);
			}
		}*/
	}
	
	function fncResultadoValidacion(data) {
		if (data != null) {
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}			
				alert("Valor de Identificaci\u00F3n no V\u00E1lido");
				ultimoObjetoFoco.value = "";
				ultimoObjetoFoco.focus();
			}
			else {
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
			validandoIdentificacion = false;
		}
		ejecutandoAjax = false;
	}
	//(-)-- valida tipo identificacion --	
	 
	function fncAgregarSolicitud() {
	 	if (fncValidaCampos()) {
	 		var divNumeracion = document.getElementById("divNumeracionInternet").style["display"]
			if (divNumeracion == "") {
				document.getElementById("numCelular").value = document.getElementById("numCelularInternet").value;
			}
		 	document.getElementById("btnAgregar").disabled =true;
	 	  	document.getElementById("opcion").value = "agregarSolicitudScoring";
	    	document.forms[0].submit();
	    }
	}
	
	// Muestra formato NIT
	function fncCambiarLabelNIT(tipoIdent, label) {
		if (tipoIdent.value==codigoNIT)	label.innerHTML = formatoNIT;
		else							label.innerHTML = "";
	}
		
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}	  
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncDummy(){}	
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}	
	
	function fncAnterior(){
		document.getElementById("opcion").value = "anterior";
    	document.forms[0].submit();
	}
		
</script>
</head>
<body onload="fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/DatosAdicLineaScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="codTelefoniaMovil" styleId="codTelefoniaMovil"/>
	<html:hidden property="codTelefoniaFija" styleId="codTelefoniaFija"/>
	<html:hidden property="codInternet" styleId="codInternet"/>
	<html:hidden property="codGrpPrestacion" styleId="codGrpPrestacion"/>
	<html:hidden property="codCarrier" styleId="codCarrier"/>
	<html:hidden property="indInvFijo" styleId="indInvFijo"/>
	<html:hidden property="indNumero" styleId="indNumero"/>
	<html:hidden property="indDirInstalacion" styleId="indDirInstalacion"/>
	<html:hidden property="indNumeroPiloto" styleId="indNumeroPiloto"/>
	<html:hidden property="codTelefoniaMovil" styleId="codTelefoniaMovil"/>
	<html:hidden property="codTecnologia" styleId="codTecnologia"/>
	<html:hidden property="flgSerieKit" styleId="flgSerieKit"/>
	<html:hidden property="flgSerieNumerada" styleId="flgSerieNumerada"/>
	<html:hidden property="codTipoTerminal" styleId="codTipoTerminal"/>
	<html:hidden property="codUsoLinea" styleId="codUsoLinea"/>
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">DATOS ADICIONALES LINEA SCORING
			</td>
		</tr>
	</table>
	<P>
	<div id="wrapper">
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"><logic:present name="mensajeError">
				<bean:write name="mensajeError" />
			</logic:present></div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divSimcardTitulo" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" colspan="4"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Datos Simcard:</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divSimcardLink" style="display:none">
			<table width="100%">
				<tr>
					<td align="left"><a href="javascript:fncBuscarSimcard();" onclick="ocultarMensajeError();"><FONT
						color="#0000ff">Buscar Simcard</FONT></a></td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divSimcard" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="18%">N&uacute;mero de Serie (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm" style="width: 92%"
						property="numSerie" styleId="numSerie" size="37" readonly="true" /></td>
					<td width="18%"></td>
					<td width="32%"></td>
				</tr>
				<tr>
					<td colspan="4">
					<HR noshade>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divEquipoTitulo" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" colspan="4"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Datos Equipo:</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divEquipoLinkSeguro" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="50%" colspan="2">
					<div id="divEquipoLink" style="display: none;">
					<table width="100%">
						<tr>
							<td><a href="javascript:fncBuscarEquipo();" onclick="ocultarMensajeError();"><FONT
								color="#0000ff">Buscar Equipo</FONT></a></td>
						</tr>
					</table>
					</div>
					</td>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divEquipo" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="18%">N&uacute;mero del Equipo (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm" property="numEquipo" styleId="numEquipo"
						size="37" style="width: 92%" readonly="true" /></td>
					<td width="18%"></td>
					<td width="32%"></td>
				</tr>
				<tr>
					<td colspan="4">
					<HR noshade>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divNumeracionTitulo" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" colspan="4"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Numeraci&oacute;n:</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divNumeracionLink" style="display:none">
			<table width="100%">
				<tr>
					<td align="left"><a href="javascript:fncBuscarNumero();" onclick="ocultarMensajeError();"><FONT
						color="#0000ff">Buscar N&uacute;mero</FONT></a></td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divNumeracion" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="18%">N&uacute;mero de Celular (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm" property="numCelular" styleId="numCelular"
						size="37" maxlength="20" style="width: 92%" readonly="true" /></td>
					<td align="left" width="18%"></td>
					<td align="left" width="32%">
				</tr>
				<tr>
					<td colspan="4">
					<HR noshade>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divNumeracionInternet" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="18%">N&uacute;mero de Tel&eacute;fono (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm"
						property="numCelularInternet" styleId="numCelularInternet" style="width: 92%" size="37" maxlength="20"
						onkeypress="onlyInteger();" onblur="fncValidarNumeroInternet();"
						onchange="ocultarMensajeError();" /></td>
					<td width="18%" align="left"><html:radio name="DatosLineaForm"
						property="rdProcedenciaNumero" value="I" styleId="rdProcedenciaNumero"
						onclick="ocultarMensajeError();fncSeleccionaProcedenciaNumero(this);fncValidarNumeroInternet();">Interno&nbsp;&nbsp;</html:radio>
					<html:radio name="DatosLineaForm" property="rdProcedenciaNumero" value="E" styleId="rdProcedenciaNumero"
						onclick="ocultarMensajeError();fncSeleccionaProcedenciaNumero(this);fncValidarNumeroInternet();">Externo</html:radio>
					</td>
					<td width="32%">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">
					<HR noshade>
					</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%">
				<tr>
					<td align="left" colspan="4"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
					Datos Usuario:</td>
				</tr>
				<tr>
					<td align="left" width="18%">Nombre Usuario (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm" property="nomUsuario" styleId="nomUsuario"
						style="text-transform: uppercase; width: 92%;" onkeypress="soloCaracteresValidos();"
						onblur="upperCase(this);" size="37" maxlength="50" onchange="ocultarMensajeError();" /></td>
					<td align="left" width="18%">Tipo Identificación (*)</td>
					<td align="left" width="32%"><html:select name="DatosLineaForm"
						property="tipoIdentificacionUsuario" style="width: 92%;" styleId="tipoIdentificacionUsuario"
						onchange="ocultarMensajeError();fncValidaTipoIdentificacion(this,numeroIdentificacionUsuario);fncCambiarLabelNIT(this, lbNumeroIdentificacionUsuario);">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="DatosLineaForm" property="arrayIdentificadorUsuario">
							<html:optionsCollection property="arrayIdentificadorUsuario" value="codigoTipIdentif"
								label="descripcionTipIdentif" />
						</logic:notEmpty>
					</html:select></td>
				</tr>
				<tr>
					<td align="left" width="18%">Apellido1 (*)</TD>
					<td align="left" width="32%"><html:text name="DatosLineaForm"
						style="text-transform: uppercase; width: 92%;" property="apellido1" styleId="apellido1"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="37" maxlength="20"
						onchange="ocultarMensajeError();" /></td>
					<td align="left" width="18%">N&uacute;m. Identif. (*)</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm"
						property="numeroIdentificacionUsuario" styleId="numeroIdentificacionUsuario" size="37" maxlength="20"
						style="text-transform: uppercase; width: 92%;"
						onblur="upperCase(this);fncValidaTipoIdentificacion(tipoIdentificacionUsuario,this);"
						onchange="ocultarMensajeError();"
						onkeypress="soloCaracteresValidos();if (window.event.keyCode == 13) fncValidaTipoIdentificacion(tipoIdentificacionUsuario,this); " />
					&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionUsuario"
						id="lbNumeroIdentificacionUsuario" class="textoAzul"></label></td>
				</tr>
				<tr>
					<td align="left">Apellido2 (*)</TD>
					<td align="left"><html:text name="DatosLineaForm"
						style="text-transform: uppercase; width: 92%;" property="apellido2" styleId="apellido2"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="37" maxlength="20"
						onchange="ocultarMensajeError();" /></td>
					<td align="left">Tel&eacute;fono (*)</td>
					<td align="left"><html:text name="DatosLineaForm" property="telefono" styleId="telefono"
						style="text-transform: uppercase; width: 92%" onkeypress="onlyInteger();" size="37"
						maxlength="15" onchange="ocultarMensajeError();" /></td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divDireccionPersonal" style="display:none">
			<table width="100%">
				<tr>
					<td align="left" width="18%"><a href="javascript:fncIngresarDireccionPersonal();"
						onclick="ocultarMensajeError();"><FONT color="#0000ff">Direcci&oacute;n Personal
					(*)</FONT></a></td>
					<td align="left" width="82%" colspan="3"><html:text name="DatosLineaForm"
						property="direccionPersonal" styleId="direccionPersonal" size="80" readonly="true" maxlength="80" /></td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divDireccionInstalacion" style="display: none">
			<table width="100%">
				<tr>
					<td align="left" width="18%"><a href="javascript:fncIngresarDireccionInstalacion();"
						onclick="ocultarMensajeError();"><FONT color="#0000ff">Direcci&oacute;n de
					Instalaci&oacute;n (*)</FONT></a></td>
					<td align="left" width="82%" colspan="3"><html:text name="DatosLineaForm"
						property="direccionInstalacion" styleId="direccionInstalacion" size="80" readonly="true" maxlength="80" /></td>
				</tr>º
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%">
				<tr>
					<td align="left" width="18%">Instancia</td>
					<td align="left" width="32%"><html:text name="DatosLineaForm" property="observacion" styleId="observacion"
						size="37" style="text-transform: uppercase; width=92%;" onkeypress="soloCaracteresValidos();"
						onblur="upperCase(this);" onchange="ocultarMensajeError();" /></td>
					<td width="18%"></td>
					<td width="32%"></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<TABLE cellSpacing="0" cellPadding="0" width="100%" border="0" align="center">
				<tr>
					<td align="left" width="50%"><html:button property="btnAnterior" styleId="btnAnterior"
						style="width:120px;color:black" onclick="ocultarMensajeError();fncAnterior();"> <<</html:button>
					</td>
					<td align="right" width="50%"><html:button value="ACEPTAR" property="btnAgregar" styleId="btnAgregar"
						style="width:170px;color:black" onclick="ocultarMensajeError();fncAgregarSolicitud()" /></td>
				</tr>
			</TABLE>
		</td>
		</tr>
	</table>
	</div>
	<P>
	<TABLE align="center" width="92%">
		<tr>
			<td align="left"><i>(*): Dato es obligatorio</i></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
