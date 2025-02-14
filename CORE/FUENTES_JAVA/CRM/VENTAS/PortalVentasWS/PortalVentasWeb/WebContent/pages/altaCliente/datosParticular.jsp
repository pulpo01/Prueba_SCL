<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
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
<script>
	window.history.forward(1);
	
	function fncInicio() {
		/*Inicio P-CSR-11002 JLGN 10-05-2011
		var largoNumCelular = document.getElementById("largoNumCelular").value;
		document.getElementById("telefonoOficina").maxLength = largoNumCelular;
		Fin P-CSR-11002 JLGN 10-05-2011*/
		
		//Inicio P-CSR-11002 10-05-2011 JLGN
		if(document.getElementById("flagTipCliente").value =="true"){
			document.getElementById("nombreCliente").disabled = true;
			document.getElementById("primerApellido").disabled = true;
			document.getElementById("segundoApellido").disabled = true;			
		}else{
			document.getElementById("nombreCliente").disabled = false;
			document.getElementById("primerApellido").disabled = false;
			document.getElementById("segundoApellido").disabled = false;
		}
		//Fin P-CSR-11002 10-05-2011 JLGN	
		fncCursorNormal();	
	}

	function fncAceptar() {
 	  	if (document.getElementById("nombreCliente").value == "") {
	  	   	alert("Debe ingresar nombre");
	  		return false;
	  	}
	  	if (document.getElementsByName("primerApellido")[0].value == "") {
	  		alert("Debe ingresar Apellido 1");
	  	   	return false;
	  	}
	  	
	  	var segundoApellidoMandatorio = document.getElementById("segundoApellidoMandatorio");
	  	if (segundoApellidoMandatorio.value == "SI") {
	  		var segundoApellido = document.getElementById("segundoApellido");
	  		if (segundoApellido == null || segundoApellido.value == "") {
		  		alert("Debe ingresar Apellido 2");
	  	   		return false; 
	  		}
	  	}

	  	/*Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	if (document.getElementById("fechaNacimiento").value == "") {
	  	   alert("Debe ingresar Fecha de Nacimiento");
	  	   return false;
	  	}
	  	if (document.getElementById("sexo").value=="") {
	  	   alert("Debe ingresar Sexo.");
	  	   return false;
	  	}
	  	if (document.getElementById("estadoCivil").value == "") {
	  	   alert("Debe ingresar Estado Civil.");
	  	   return false;
	  	} Fin P-CSR-11002 JLGN 26-04-2011*/
	  	
	  	var nomConyugeCasadoMandatorio = '<bean:write name="DatosParticularForm" property="nomConyugeCasadoMandatorio"></bean:write>';
	  	var estadoCivilCasado = '<bean:write name="DatosParticularForm" property="estadoCivilCasado"></bean:write>';
	  	if (
	  		(nomConyugeCasadoMandatorio != null) && 
	  		(nomConyugeCasadoMandatorio == "SI") && 
	  		(estadoCivilCasado == document.getElementsByName("estadoCivil")[0].value) && 
	  		(document.getElementsByName("nombreConyuge")[0].value == "")
	  		) {
	  		alert("Debe ingresar Nombre Cónyuge");
	  	   	return false;
	  	}
	  	
	  	/* Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	var nomEmpresaMandatorio = '<bean:write name="DatosParticularForm" property="nomEmpresaMandatorio"></bean:write>';
	  	if (nomEmpresaMandatorio != null && nomEmpresaMandatorio == "SI" && document.getElementsByName("empresaTrabaja")[0].value == "") {
	  		alert("Debe ingresar Empresa Trabaja");
	  	   	return false;
	  	}
	  	
	  	var nomJefeMandatorio = '<bean:write name="DatosParticularForm" property="nomJefeMandatorio"></bean:write>';
	  	if (nomJefeMandatorio != null && nomJefeMandatorio == "SI" && document.getElementsByName("jefeInmediato")[0].value == "") {
	  		alert("Debe ingresar Jefe Inmediato.");
	  	   	return false;
	  	}
	  	
	  	if (document.getElementById("ingresosMensuales").value == "" || document.getElementById("ingresosMensuales").value == 0 ) {
	  	   	alert("Debe agregar Ingresos Mensuales");
	  		return false;
	  	}Fin P-CSR-11002 JLGN 26-04-2011*/
	  	
	  	document.getElementById("opcion").value = "aceptar";
    	document.forms[0].submit();
	}
  	
  	 	//(+)-- CANCELAR --
 	function fncCancelar() {
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}
 	//(-)-- CANCELAR --
 	
	function fncValidaMontoDecimal(campoTexto) {
  		if (campoTexto.value!=""){
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)){
	  	  		alert("Monto inv\u00E1lido");
	  	  		campoTexto.value="";
	  	  		campoTexto.focus();
	  	  	}
		}
	} 
	/* valida fecha en formato dd-mm-yyyy*/
	function validaFechaNac(ctrlFecha) {
	
		if (ctrlFecha.value == "") return;
		
		var fechaSel = ctrlFecha.value;
		var diaSel = fechaSel.substring(0,2);
		var mesSel = fechaSel.substring(3,5);
		var anoSel = fechaSel.substring(6);
		
		var fechaHoy = new Date();
		var dia = fechaHoy.getDate()+"";
		var mes = fechaHoy.getMonth() + 1+"";
		var ano = fechaHoy.getFullYear()+"";
		
		if (mes.length == 1) mes = "0"+mes;
		if (dia.length == 1) dia = "0"+dia;
		
		//Se valida el Formato
		if (!/^\d{2}\-\d{2}\-\d{4}$/.test(ctrlFecha.value)){
            alert("formato de fecha no valido (DD-MM-AAAA)");
            ctrlFecha.value="";
			ctrlFecha.focus();
            return false;
        }
		
		//Inicio P-CSR-11002 JLGN 04-08-2011
		//Valido el año  
	    if (anoSel.length<4 || parseFloat(anoSel)<1900){  
            alert("Año inválido");
            ctrlFecha.value="";
			ctrlFecha.focus();
	        return false; 
	    }  
	    //Valido el Mes  
	    if (parseFloat(mesSel)<1 || parseFloat(mesSel)>12){  
	        alert("Mes inválido");
	        ctrlFecha.value="";
			ctrlFecha.focus();
	        return false;
	    }  
	    //Valido el Dia  
	    if (parseInt(diaSel, 10)<1 || parseInt(diaSel, 10)>31){  
	        alert("Día inválido");
	        ctrlFecha.value="";
			ctrlFecha.focus();
	        return false;
	    }  
	    if (diaSel==4 || diaSel==6 || diaSel==9 || diaSel==11 || diaSel==2) {  
	        if (diaSel==2 && diaSel > 28 || diaSel>30) {  
	            alert("Día inválido");
	            ctrlFecha.value="";
				ctrlFecha.focus();
	            return false;
	        }  
	    }  
		//Fin P-CSR-11002 JLGN 04-08-2011
		
		var fechaSelNum = parseInt(anoSel+mesSel+diaSel);
		var fechaHoyNum = parseInt(ano+mes+dia);
		
		if (fechaSelNum >= fechaHoyNum){
			alert("Fecha de Nacimiento debe ser menor a la fecha actual");
			ctrlFecha.value="";
			ctrlFecha.focus();
		}
		
	}	 
	
	//Inicio P-CSR-11002 JLGN 04-08-2011
	function soloNumeros(evt){
	
	//asignamos el valor de la tecla a keynum
		if(window.event){// IE
			keynum = evt.keyCode;
		}else{
			keynum = evt.which;
		}
		//comprobamos si se encuentra en el rango
		if((keynum>47 && keynum<58) || keynum == 45 || keynum == 8 || keynum == 127){
			return true;
		}else{
			return false;
		}
	}
	//Fin P-CSR-11002 JLGN 04-08-2011

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
<html:form method="POST" action="/DatosParticularAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="largoNumCelular" styleId="largoNumCelular"/>
	<html:hidden property="segundoApellidoMandatorio" styleId="segundoApellidoMandatorio"/>
	<html:hidden property="flagTipCliente" styleId="flagTipCliente"/>
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Creación de Clientes - Datos Cliente Particular
			</td>
		</tr>
	</table>
	<P>
	<P>
	<table width="90%" align="center" border="0">
		<tr>
			<td align="left" colspan="4"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
			Datos Personales:</td>
		</tr>
		<tr>
			<td align="left" width="25%">Nombres (*)</td>
			<td align="left" width="75%"><html:text name="DatosParticularForm" property="nombreCliente"
				style="text-transform: uppercase;" styleId="nombreCliente" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="50" /></td>
		</tr>
		<tr>
			<td align="left">Apellido 1 (*)</td>
			<td align="left"><html:text name="DatosParticularForm" property="primerApellido"
				style="text-transform: uppercase;" styleId="primerApellido" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="20" /></td>
		</tr>
		<tr>
			<td align="left"><logic:equal name="DatosParticularForm"
				property="segundoApellidoMandatorio" value="SI">
				Apellido 2 (*)
			</logic:equal> <logic:equal name="DatosParticularForm" property="segundoApellidoMandatorio" value="NO">
				Apellido 2
			</logic:equal></td>
			<td align="left"><html:text name="DatosParticularForm" property="segundoApellido"
				style="text-transform: uppercase;" styleId="segundoApellido" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="20" /></td>
		</tr>
		<tr>
			<td align="left">Nacionalidad</td>
			<td align="left"><html:select name="DatosParticularForm" property="codNacionalidad"
				style="width:200px;" styleId="codNacionalidad" >
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosParticularForm" property="arrayNacionalidad">
					<html:optionsCollection property="arrayNacionalidad" value="codigoValor"
						label="descripcionValor" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
		<tr>
			<td align="left">Fecha de Nacimiento</td>
			<td align="left"><bean:define id="hoyMenosVeinte" name="DatosParticularForm"
				type="java.lang.String" property="hoyMenosVeinte" /> 
				<html:text name="DatosParticularForm"
				property="fechaNacimiento" maxlength="10" styleId="fechaNacimiento" onkeypress="return soloNumeros(event);" size="30" value="<%= hoyMenosVeinte %>" readonly="false" 
				onchange="validaFechaNac(this);"/> 
				<!--  
				<a href="#"><img name="fec1"
				src="<%=request.getContextPath()%>/img/calendar/calendar.gif" border="0" class="select"
				onClick="displayCalendar(fechaNacimiento,'dd-mm-yyyy',this)"></a></td>-->
		</tr>
		<tr>
			<td align="left" width="26%">Sexo</td>
			<td align="left" width="32%"><html:select name="DatosParticularForm" property="sexo"
				style="width:200px;" styleId="sexo" >
				<html:option value="">- Seleccione -</html:option>
				<html:option value="M">MASCULINO</html:option>
				<html:option value="F">FEMENINO</html:option>
			</html:select></td>
		</tr>
		<tr>
			<td align="left" width="26%">Estado Civil</td>
			<td align="left" width="32%"><html:select name="DatosParticularForm" property="estadoCivil"
				style="width:200px;" styleId="estadoCivil" >
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosParticularForm" property="arrayEstadoCivil">
					<html:optionsCollection property="arrayEstadoCivil" value="codigoValor"
						label="descripcionValor" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
		<tr>
			<td align="left">Nombre C&oacute;nyuge</td>
			<td align="left"><html:text name="DatosParticularForm" property="nombreConyuge"
				style="text-transform: uppercase;" styleId="nombreConyuge" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="50" /></td>
		</tr>
		<!-- Inicio P-CSR-11002 JLGN 26-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
		<tr>
			<td align="left" colspan="4">
			<HR noshade>
			</td>
		</tr>
		<tr>
			<td align="left" colspan="4"
				style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
			Datos Profesionales:</td>
		</tr>
		<tr>
			<td align="left" width="25%"><logic:equal value="SI" name="DatosParticularForm"
				property="nomEmpresaMandatorio">
          		Empresa Trabaja (*)
          	</logic:equal> <logic:equal value="NO" name="DatosParticularForm" property="nomEmpresaMandatorio">
          		Empresa Trabaja
          	</logic:equal></td>
			<td align="left" width="75%"><html:text name="DatosParticularForm" property="empresaTrabaja"
				style="text-transform: uppercase;" styleId="empresaTrabaja" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="50" /></td>
		</tr>
		<tr>
			<td align="left">Profesi&oacute;n</td>
			<td align="left"><html:select name="DatosParticularForm" property="codProfesion"
				style="width:200px;" styleId="codProfesion" >
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosParticularForm" property="arrayProfesion">
					<html:optionsCollection property="arrayProfesion" value="codigoActividad"
						label="descripcionActividad" />
				</logic:notEmpty>
			</html:select></td>
		</tr>
		<tr>
			<td align="left">Tel&eacute;fono Oficina</td>
			<td align="left"><html:text name="DatosParticularForm" property="telefonoOficina"
				style="text-transform: uppercase;" styleId="telefonoOficina" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="15" /></td>
		</tr>
		<tr>
			<td align="left">Cargo</td>
			<td align="left"><html:select name="DatosParticularForm" property="codCargo"
				style="width:200px;" styleId="codCargo">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosParticularForm" property="arrayCargo">
					<html:optionsCollection property="arrayCargo" value="codigoOcupacion"
						label="descripcionOcupacion" />
				</logic:notEmpty>
			</html:select>
			<td>
		</tr>
		<tr>
			<td align="left">Ingresos Mensuales (*)</td>
			<td align="left"><html:text name="DatosParticularForm" property="ingresosMensuales"
				style="text-transform: uppercase;" styleId="ingresosMensuales" onkeypress="onlyFloat(this.value,4)"
				onblur="fncValidaMontoDecimal(this);" size="60" maxlength="15" /></td>
		</tr>
		<tr>
			<td align="left" width="25%"><logic:equal value="SI" name="DatosParticularForm"
				property="nomJefeMandatorio">
	          		Jefe Inmediato (*)
				</logic:equal> <logic:equal value="NO" name="DatosParticularForm" property="nomJefeMandatorio">
					Jefe Inmediato
				</logic:equal></td>
			<td align="left"><html:text name="DatosParticularForm" property="jefeInmediato"
				style="text-transform: uppercase;" styleId="jefeInmediato" onkeypress="soloCaracteresValidos();"
				onblur="upperCase(this);" size="60" maxlength="50" /></td>
		</tr>
		<tr>
			<td align="left">A&ntilde;os Laborando</td>
			<td align="left"><html:text name="DatosParticularForm" property="anosLaborando"
				style="text-transform: uppercase;" styleId="anosLaborando" size="20" maxlength="2" onkeypress="onlyInteger();" /></td>
		</tr>
		 Fin P-CSR-11002 JLGN 26-04-2011-->
	</table>
	<P>
	<P>
	<P>
	<P>
	<P>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td align="left" width="50%"></td>
			<td width="25%" align="right"><html:button value="CANCELAR" style="width:120px;color:black"
				property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();fncCancelar();" /></td>
			<td width="25%" align="right"><html:button value="ACEPTAR" style="width:120px;color:black"
				property="btnAceptar" styleId="btnAceptar" onclick="fncCursorEspera();fncAceptar();" /></td>
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
