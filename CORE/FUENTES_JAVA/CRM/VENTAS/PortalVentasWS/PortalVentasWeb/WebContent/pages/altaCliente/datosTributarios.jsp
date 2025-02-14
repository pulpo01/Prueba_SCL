<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JDatosTributariosAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ejecutandoAjax = false;
		
	var ultimoObjetoFoco;
	var validandoIdentificacion=false;
	//P-CSR-11002 JLGN 06-06-2011
	//var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";
	//P-CSR-11002 28-04-2011
	var esPrepago = "<bean:write name="DatosTributariosForm" property="flagClientePrepago"/>"
			
	function fncInicio() {
		//P-CSR-11002 JLGN P-CSR-11002 28-04-2011
	 	//document.getElementById("tipoIdentificacionTrib").disabled = <bean:write name="DatosTributariosForm" property="restriccionIdentTrib"/> ;
	 	document.getElementById("tipoIdentificacionTrib").disabled = true;
	 	var restricccionTrib = <bean:write name="DatosTributariosForm" property="restriccionIdentTrib"/>;
	 	
	 	//P-CSR-11002 JLGN P-CSR-11002 28-04-2011
	 	//document.getElementById("numeroIdentificacionTrib").disabled = restricccionTrib;
	 	document.getElementById("numeroIdentificacionTrib").disabled = true;
	 	
		var colorNumeroIdent =  restricccionTrib?'#e0e0e0':'white';
		document.getElementById("tipoIdentificacionTrib").style.background = colorNumeroIdent;
		
		//Selecciona por defecto la opcion NO
		/* Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
		var facturaTercero = document.getElementById("facturaTercero");
		if (facturaTercero == null || facturaTercero.value==""){
			    for (index = 0; index< facturaTercero.length; index++) {
			       	  if (facturaTercero[index].value == "N"){
			        	facturaTercero.selectedIndex = index;
			        	break;
			       	  } 
			    }
		}
		fncActivarDesacBtnDatosTercero(facturaTercero);
		Fin P-CSR-11002 JLGN 27-04-2011*/
		
		var tipoIdentificacionTrib = document.getElementById("tipoIdentificacionTrib");
						
		/*P-CSR-11002 JLGN 06-06-2011
		if (tipoIdentificacionTrib.value == codigoNIT){
			document.getElementById("lbNumeroIdentificacionTrib").innerHTML = formatoNIT;
		}*/
		//P-CSR.11002 JLGN 14-06-2011
		fncCursorNormal();			 	
	}

	/* Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	function fncActivarDesacBtnDatosTercero(facturaTercero){
		if (facturaTercero.value=="S"){
			document.getElementById("btnDatosTercero").disabled = false;
		}else{
			document.getElementById("btnDatosTercero").disabled = true;
		}
		
	}Fin P-CSR-11002 JLGN 27-04-2011*/
	
	function fncAnterior() {
		if (ejecutandoAjax) return;
			
	  	document.getElementById("opcion").value = "anterior";
    	document.forms[0].submit();
	} 
	
	function fncDatosTercero() {
		if (ejecutandoAjax) return;
		
	  	document.getElementById("opcion").value = "ingresarDatosTercero";
    	document.forms[0].submit();
	} 	
	
	function fncDatosPago() {
		if (ejecutandoAjax) return;
		
	  	if (document.getElementById("oficina").value == "") {
	  	   alert("Debe ingresar oficina");
	  	   return false; 
	  	}
	  	if (document.getElementById("categoriaCambio").value == "") {
	  	   	alert("Debe ingresar categoria de cambio");
	  	   	return false; 
	  	}
	  	
	  	if (document.getElementById("categoriaImpositiva").value == "")
	  	{
	  	   alert("Debe ingresar categoria impositiva");
	  	   return false; 
	  	}
	  	
	  	if (document.getElementById("categoriaTributaria").value == "")
	  	{
	  	   alert("Debe ingresar categoria tributaria");
	  	   return false; 
	  	}
	  	
		//Inicio P-CSR-11002 JLGN 28-04-2011 
		if (esPrepago == 0){ // valida direccion cuando no es prepago
		  	//Inicio P-CSR-11002 JLGN 10-05-2011 Se copia direccion personal y correspondencia
		  	JDatosTributariosAJAX.copiarDireccion("FACT","PERS",fncDummy);
		  	JDatosTributariosAJAX.copiarDireccion("FACT","CORR",fncDummy);
		}//Fin P-CSR-11002 JLGN 10-05-2011
		  	
		  	/*Inicio P-CSR-11002 JLGN 10-05-2011
		  	if (document.getElementById("direcionPersonal").value == "")
		  	{
		  	   alert("Debe ingresar direccion Personal");
		  	   return false; 
		  	}
		  	
		  	if (document.getElementById("direccionFacturacion").value == "")
		  	{
		  	   alert("Debe ingresar direccion de Facturación");
		  	   return false; 
		  	}
		  	
		  	if (document.getElementById("direccionCorrespondencia").value == "")
		  	{
		  	   alert("Debe ingresar direccion de Correspondencia");
		  	   return false; 
		  	}
		}Fin P-CSR-11002 JLGN 10-05-2011*/
		//Fin P-CSR-11002 JLGN 28-04-2011
			  	
	  	/* Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	var aplicaFacturaTercero = document.getElementsByName("aplicaFacturaTercero")[0];
	  	
	  	if (document.getElementById("facturaTercero").value == "" && aplicaFacturaTercero.value == "1") {
	  	   	alert("Debe indicar si la factura puede ir a nombre de un Tercero");
			return false;
	  	} Fin P-CSR-11002 JLGN 27-04-2011 */
	  	
	  	if (document.getElementById("oficina").value == "")
	  	{
	  	   alert("Debe seleccionar una oficina ");
	  	   return false; 
	  	}
	  	
	  	if (document.getElementById("categoriaImpositiva").value == "")
	  	{
	  	   alert("Debe seleccionar categoría impositiva ");
	  	   return false; 
	  	}
	  	
	  	if (document.getElementById("categoriaTributaria").value == "")
	  	{
	  	   alert("Debe seleccionar categoría tributaria");
	  	   return false; 
	  	}
	  	
	  	if (document.getElementById("tipoIdentificacionTrib").value !="" && document.getElementById("numeroIdentificacionTrib").value=="")
	  	{
	  	   alert("Si selecciona un tipo de identificación tributaria, debe ingresar un número de identificación");
	  	   return false; 
	  	}
	  	
	  	if (document.getElementById("tipoIdentificacionTrib").value =="" && document.getElementById("numeroIdentificacionTrib").value!="")
	  	{
	  	   alert("Si selecciona un número de identificación tributaria, debe seleccionar un tipo de identificación");
	  	   return false; 
	  	}
	  	/* Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	  	if (document.getElementById("facturaTercero").value =="S" && document.getElementById("flagFacturacionTercero").value =="0" )
	  	{
	  	   alert("Debe ingresar los datos del cliente facturable");
	  	   return false;  
	  	} Fin P-CSR-11002 JLGN 27-04-2011 */
	  	
	  	document.getElementById("opcion").value = "ingresarDatosPago";
    	document.forms[0].submit();
	} 	

	/*carga de pagina de direcciones*/
	/* Inicio P-CSR-11002 JLGN 10-05-2011
	function fncIngresarDireccionPersonal() {
		var direcionPersonal = document.getElementById("direcionPersonal");
		var irADirecciones = true;
				
		if (direcionPersonal.value == ""){
			var direccionFacturacion = document.getElementById("direccionFacturacion");
			if (direccionFacturacion.value!=""){
				var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Facturaci\u00F3n como Personal?");
				if (confirmar){
					//copiar FACT en PERS
					JDatosTributariosAJAX.copiarDireccion("FACT","PERS",fncDummy);
					document.getElementById("direcionPersonal").value = document.getElementById("direccionFacturacion").value;
					irADirecciones = false;
				}else{
					var direccionCorrespondencia = document.getElementById("direccionCorrespondencia");			
					if (direccionCorrespondencia.value!=""){
						var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como Personal?");
						if (confirmar){
							//copiar CORR en PERS
							JDatosTributariosAJAX.copiarDireccion("CORR","PERS",fncDummy);
							document.getElementById("direcionPersonal").value = document.getElementById("direccionCorrespondencia").value;
							irADirecciones = false;
						}
					}						
				}
			}
		}//fin if (direcionPersonal.value == "")
				
		if (irADirecciones){
		  	document.getElementById("opcion").value = "ingresarDireccionPersonal";
	    	document.forms[0].submit();
	    }
	} Fin P-CSR-11002 JLGN 10-05-2011*/

	/* Inicio P-CSR-11002 JLGN 10-05-2011
	function fncIngresarDireccionFacturacion() {
		
		var direccionFacturacion = document.getElementById("direccionFacturacion");
		var irADirecciones = true;
				
		if (direccionFacturacion.value == ""){
			var direcionPersonal = document.getElementById("direcionPersonal");
			if (direcionPersonal.value!=""){
				var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Facturaci\u00F3n?");
				if (confirmar){
					//copiar PERS en FACT
					JDatosTributariosAJAX.copiarDireccion("PERS","FACT",fncDummy);
					document.getElementById("direccionFacturacion").value = document.getElementById("direcionPersonal").value;
					irADirecciones = false;
				}else{
					var direccionCorrespondencia = document.getElementById("direccionCorrespondencia");			
					if (direccionCorrespondencia.value!=""){
						var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como de Facturaci\u00F3n?");
						if (confirmar){
							//copiar CORR en FACT
							JDatosTributariosAJAX.copiarDireccion("CORR","FACT",fncDummy);
							document.getElementById("direccionFacturacion").value = document.getElementById("direccionCorrespondencia").value;
							irADirecciones = false;
						}
					}						
				}
			}
		}//fin if (direccionFacturacion.value == "")
				
		if (irADirecciones){
		  	document.getElementById("opcion").value = "ingresarDireccionFacturacion";
	    	document.forms[0].submit();
	    }
	}Fin P-CSR-11002 JLGN 10-05-2011*/
	
	// Inicio P-CSR-11002 JLGN 10-05-2011
	function fncIngresarDireccionFacturacion() {
		document.getElementById("opcion").value = "ingresarDireccionFacturacion";
	    document.forms[0].submit();	    
	}//Fin P-CSR-11002 JLGN 10-05-2011
	
	/*Inicio P-CSR-11002 JLGN 10-05-2011
	function fncIngresarDireccionCorrespondencia() {
		var direccionCorrespondencia = document.getElementById("direccionCorrespondencia");
		var irADirecciones = true;
				
		if (direccionCorrespondencia.value == ""){
			var direcionPersonal = document.getElementById("direcionPersonal");
			if (direcionPersonal.value!=""){
				var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Correspondencia?");
				if (confirmar){
					//copiar PERS en CORR
					JDatosTributariosAJAX.copiarDireccion("PERS","CORR",fncDummy);
					document.getElementById("direccionCorrespondencia").value = document.getElementById("direcionPersonal").value;
					irADirecciones = false;
				}else{
					var direccionFacturacion = document.getElementById("direccionFacturacion");			
					if (direccionFacturacion.value!=""){
						var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Facturaci\u00F3n como de Correspondencia?");
						if (confirmar){
							//copiar FACT en CORR
							JDatosTributariosAJAX.copiarDireccion("FACT","CORR",fncDummy);
							document.getElementById("direccionCorrespondencia").value = document.getElementById("direccionFacturacion").value;
							irADirecciones = false;
						}
					}						
				}
			}
		}//fin if (direccionCorrespondencia.value == "")
		
		if (irADirecciones){	
	  		document.getElementById("opcion").value = "ingresarDireccionCorrespondencia";
	    	document.forms[0].submit();
	    }
	}	
	Fin P-CSR-11002 JLGN 10-05-2011*/
	/*********************************/
		
	function fncValidaTipoIdentificacion(tipoIdentSel,numIdentText) {
		if (!validandoIdentificacion){
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				ejecutandoAjax = true;
				JDatosTributariosAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
			}
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
				ultimoObjetoFoco.focus();
			}else{
				ultimoObjetoFoco.value = data["identificadorFormateado"];
			}
			validandoIdentificacion = false;
		}
		ejecutandoAjax = false;
	}
	
  	
	//Muestra formato NIT
	/*P-CSR-11002 JLGN 06-06-2011 
	function fncCambiarLabelNIT(tipoIdent, label){
		if (tipoIdent.value==codigoNIT)	label.innerHTML = formatoNIT;
		else							label.innerHTML = "";
	}*/
	  	
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
	
	/* Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	function mostrarOcultarFacturaTercero()	{
		var aplicaFacturaTercero = document.getElementsByName("aplicaFacturaTercero")[0];
		var filaFacturaTercero = document.getElementById("filaFacturaTercero");
		//1=aplica, 0=no aplica
		if (aplicaFacturaTercero.value == "1") {
			filaFacturaTercero.style["display"] = "";
		}
		else {
			filaFacturaTercero.style["display"] = "none";
		}
	}Fin P-CSR-11002 JLGN 27-04-2011*/
	
	function mostrarOcultarCategoriaCambio() {
		var aplicaCategoriaCambio = document.getElementsByName("aplicaCategoriaCambio")[0];
		var tdLabelCategoriaCambio = document.getElementById("tdLabelCategoriaCambio");
		var tdComboCategoriaCambio = document.getElementById("tdComboCategoriaCambio");
		//1=aplica, 0=no aplica
		if (aplicaCategoriaCambio.value == "1") {
			tdLabelCategoriaCambio.style["display"] = "";
			tdComboCategoriaCambio.style["display"] = "";
		}
		else {
			tdLabelCategoriaCambio.style["display"] = "none";
			tdComboCategoriaCambio.style["display"] = "none";
		}
	}
	
	//Inicio P-CSR-11002 07/04/2011
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
	//Fin P-CSR-11002 07/04/2011	

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

<!-- <body onload="history.go(+1);fncInicio();mostrarOcultarFacturaTercero();mostrarOcultarCategoriaCambio();" onpaste="return false;" onkeydown="validarTeclas();"> -->
<body onload="history.go(+1);fncInicio();mostrarOcultarCategoriaCambio();" onpaste="return false;" onkeydown="validarTeclas();">
	<html:form method="POST" action="/DatosTributariosAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion"/>
	<html:hidden property="flagFacturacionTercero" styleId="flagFacturacionTercero"/>
	<html:hidden property="flagClientePrepago" styleId="flagClientePrepago"/>
	<html:hidden property="aplicaFacturaTercero" styleId="aplicaFacturaTercero"/>
	<html:hidden property="aplicaCategoriaCambio" styleId="aplicaCategoriaCambio"/>
      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Creación de Clientes&nbsp;
         </td>            
        </tr>
      </table>
	  <P>
		<!--  <table width="100%" border="0" >
		  <tr>
		     <td class="mensajeError"><div id="mensajes" ></div></td>
		  </tr> 
		</table>	  
		-->
		<table width="100%" border="0" >
		  <tr>
		     <td class="mensajeError">
		     	<div id="mensajes" >
		     		<logic:present name="mensajeError">
				     	  <bean:write name="mensajeError"/>
			     	</logic:present>
		     	</div>
		     </td>
		  </tr> 
		</table>
	  <P>
	  <!-- Inicio P-CSR-11002 JLGN 27-04-2011 -->
	  <bean:define id="esPrepago" name="DatosTributariosForm" property="flagClientePrepago"/>
	  <logic:equal name="esPrepago" value="0">       
	     <TABLE align="center" width="90%" border="0" >
	        <tr>
	           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
	            Direcciones:
	           </td>
		    </tr>
	        <!-- Inicio P-CSR-11002 JLGN 10-05-2011
	        <tr>
	          <td align="left" width="26%">
	          <a href="javascript:fncIngresarDireccionPersonal();" onclick="ocultarMensajeError();"><FONT color="#0000ff">Direcci&oacute;n Personal</FONT></a>
	  		  (*)</td>
	          <td align="left" colspan="3" width="74%">
	            <html:text name="DatosTributariosForm" property="direcionPersonal" styleId="direcionPersonal" style="text-transform:uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" readonly="true" size="80" maxlength="80" />
	          </td>
	        </tr>
	        Fin P-CSR-11002 JLGN 10-05-2011 -->
	        
	        <!-- Inicio P-CSR-11002 JLGN 27-04-2011 RMS-003 Despliegue de parámetros en la Creación del Cliente
	        <tr id="filaFacturaTercero" style="display: none;" >
	        <td align="left" width="10%">Factura a nombre de Tercero(*)</td>
		    <td align="left" width="60%" nowrap>
		    	<bean:define id="esPrepago" name="DatosTributariosForm" property="flagClientePrepago"/>
				<logic:equal name="esPrepago" value="0"> 
				  <html:select name="DatosTributariosForm" property="facturaTercero" styleId="facturaTercero" style="width:180px;" onchange="ocultarMensajeError();fncActivarDesacBtnDatosTercero(this);" > 
					<html:option value="">- Seleccione -</html:option>
					<html:option value="S">SI</html:option> 
					<html:option value="N">NO</html:option>
		          </html:select>	
				</logic:equal>
				<logic:equal name="esPrepago" value="1"> 
				  <html:select name="DatosTributariosForm" property="facturaTercero" styleId="facturaTercero" style="width:180px;" onchange="ocultarMensajeError();fncActivarDesacBtnDatosTercero(this);" > 
					<html:option value="N">NO</html:option>
		          </html:select>	
				</logic:equal>
	           <html:button  value="DATOS CLIENTE FACTURABLE" style="width:230px;color:black" property="btnDatosTercero" styleId="btnDatosTercero" onclick="ocultarMensajeError();fncDatosTercero()" />				
		    </td>
		    </tr> 
		    Fin P-CSR-11002 JLGN 27-04-2011-->      
	        <tr>
	          <td align="left" width="26%">
	            <a href="javascript:fncIngresarDireccionFacturacion();" onclick="fncCursorEspera();ocultarMensajeError();"><FONT color="#0000ff">Direcci&oacute;n de Facturacion</FONT></a>(*) 
	          	</td>
	          <td align="left" colspan="3" width="74%">
	           <html:text name="DatosTributariosForm" property="direccionFacturacion" styleId="direccionFacturacion" style="text-transform: uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="80" readonly="true" maxlength="80" />
	          </td>
	        <!-- Inicio P-CSR-11002 JLGN 10-05-2011
	        </tr>
	        
	          <td align="left" width="26%">
	  		    <a href="javascript:fncIngresarDireccionCorrespondencia();" onclick="ocultarMensajeError();"><FONT color="#0000ff">Direcci&oacute;n de Correspondencia</FONT></a>(*)
	  		  </td>
	          <td align="left" colspan="3" width="74%">
	          	<html:text name="DatosTributariosForm" property="direccionCorrespondencia" styleId="direccionCorrespondencia" style="text-transform: uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="80" readonly="true" maxlength="80" />
	          </td>
	        </tr>
			Fin P-CSR-11002 JLGN 10-05-2011 -->
		</TABLE>
	</logic:equal>
	<!-- Fin P-CSR-11002 JLGN 27-04-2011 -->
	<TABLE align="center" width="90%" border="0" >
     	<tr>
	      <td colspan="4">
	      <HR noshade>
	    </td>
        </tr>
        <tr>
           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Datos Adicionales:
           </td>
	    </tr>
         <tr>
	          <td align="left" width="10%">
	  			Oficina(*)</td>
	          <td align="left" width="40%">
				  <html:select name="DatosTributariosForm" property="oficina" styleId="oficina" style="width:260px;" onchange="ocultarMensajeError();">
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="DatosTributariosForm" property="arrayOficina">
		              <html:optionsCollection property="arrayOficina" value="codigoOficina" label="descripcionOficina"/>
		          	</logic:notEmpty>
		          </html:select>
	          </td>
	          <td align="left" id="tdLabelCategoriaCambio" >
				Categor&iacute;a de  Cambio(*)
			  </td>
	          <td align="left" id="tdComboCategoriaCambio" >
				  <html:select name="DatosTributariosForm" property="categoriaCambio" style="width:260px;" styleId="categoriaCambio" onchange="ocultarMensajeError();">
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="DatosTributariosForm" property="arrayCategoriaCambio">
		              <html:optionsCollection property="arrayCategoriaCambio" value="codCategoria" label="desCategoria"/>
		          	</logic:notEmpty>				  	
		          </html:select>
			  </td>
			 		  
	     </tr>
	        
	     <tr>
	          <td align="left" >  
	          Tipo de identificación Tributaria
	          </td>
	          <td align="left" >
				 <html:select name="DatosTributariosForm" property="tipoIdentificacionTrib" styleId="tipoIdentificacionTrib" style="width:260px;" onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentificacionTrib');"  > 
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="DatosTributariosForm" property="arrayIdentificadorCliente">
		              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
		          	</logic:notEmpty>
	             </html:select>
	          </td>
	          <td align="left" >
				No. de identificación Tributaria 
			  </td>
	          <td align="left" >
				<html:text name="DatosTributariosForm" property="numeroIdentificacionTrib" styleId="numeroIdentificacionTrib" style="text-transform: uppercase;"  
				onclick="ocultarMensajeError();" size="40" maxlength="40" 
				onblur="upperCase(this);"  onchange="ocultarMensajeError();"
				onkeypress="soloCaracteresValidos(); valNumeroIdentificacion('numeroIdentificacionTrib','tipoIdentificacionTrib'); "/>
				&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentificacionTrib" id="lbNumeroIdentificacionTrib" class="textoAzul"></label>				
	          </td>
	   </tr>
       
       <tr>
          <td align="left" >  
          Categor&iacute;a Impositiva(*)</td>
          <td align="left" colspan="3">
			  <html:select name="DatosTributariosForm" property="categoriaImpositiva" styleId="categoriaImpositiva" style="width:260px;" onchange="ocultarMensajeError();">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosTributariosForm" property="arrayCategImpos">
	              <html:optionsCollection property="arrayCategImpos" value="codigoCategImpos" label="descripcionCategImpos"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
       </tr>
       <tr>
          <td align="left" >
  			Categor&iacute;a Tributaria(*)
		  </td>

          <td align="left" >
			  <html:select name="DatosTributariosForm" property="categoriaTributaria" styleId="categoriaTributaria" style="width:260px;" onchange="ocultarMensajeError();">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="DatosTributariosForm" property="arrayCategTrib">
	              <html:optionsCollection property="arrayCategTrib" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>         
	    </tr>	 
     </TABLE>
     <P>
     <P>
     <P>
     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="50%" >
            <html:button  value="<<" style="width:120px;color:black" property="btnAnterior" styleId="btnAnterior" onclick="fncCursorEspera();ocultarMensajeError();fncAnterior();"/>
        </td>
        <td width="25%" align="right">
           &nbsp;
        </td>
        <td width="25%" align="right">
           <html:button  value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="fncCursorEspera();ocultarMensajeError();fncDatosPago();"/>
        </td>
      </tr>
    </TABLE> 
    
     <P>    
   <TABLE align="center" width="90%">			
      <tr>
		  <td align="left"><i>(*) :  Dato es obligatorio</i></td>
	  </tr>	   
   </TABLE>    
</html:form>

</body>
</html:html>