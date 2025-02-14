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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JClienteFacturaAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var ultimoObjetoFoco;
	var flgSubmitAceptar = false;
	var validandoIdentificacion=false;
	var formatoNIT="<c:out value="${paramGlobal.formatoNIT}"/>";
	var codigoNIT="<c:out value="${paramGlobal.codigoIdentificadorNIT}"/>";
	
	//P-CSR-11002 12/04/2011
	var cedulaIdentidad = "<bean:write name="cedulaIdentidad"/>";
	var cedulaJuridica = "<bean:write name="cedulaJuridica"/>";
	var cedulaOtras = "<bean:write name="cedulaOtras"/>";
	
	function fncInicio(){
			var tipoIdentClienteFactura = document.getElementById("tipoIdentClienteFactura");
						
			if (tipoIdentClienteFactura.value == codigoNIT){
				document.getElementById("lbNumeroIdentClienteFactura").innerHTML = formatoNIT;
			}
	}
	
	function fncAceptar() {
	
		if (validandoIdentificacion){//validando nit
	  		flgSubmitAceptar = true;
	  		return;
	  	}
	  	
  		flgSubmitAceptar = false;
  		
	  	if (document.getElementById("nombreClienteFactura").value == "")
	  	{
	  	   alert("Debe ingresar nombres");
	  	   return false;
	  	}
	  	if (document.getElementById("apellido1ClienteFactura").value == "")
	  	{
	  	   alert("Debe ingresar primer apellido");
	  	   return false;
	  	}

	  	if (document.getElementById("apellido2ClienteFactura").value == "")
	  	{
	  	   alert("Debe ingresar segundo apellido");
	  	   return false;
	  	}
	  	
	  	if (document.getElementById("tipoIdentClienteFactura").value == "")
	  	{
	  	   alert("Debe seleccionar tipo de identificación");
	  	   return false;
	  	}

	  	if (document.getElementById("numeroIdentClienteFactura").value == "")
	  	{
	  	   alert("Debe seleccionar número de identificación");
	  	   return false;
	  	}
	  	
	  	document.getElementById("opcion").value = "aceptar";
  	   	document.forms[0].submit();
	}
	
 	//(+)-- CANCELAR --
 	function fncCancelar(){
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}
 	//(-)-- CANCELAR --
	
	function fncValidaTipoIdentificacion(tipoIdentSel,numIdentText) {
		if (!validandoIdentificacion){
			if (numIdentText.value != "") {
				ultimoObjetoFoco = numIdentText;
				validandoIdentificacion = true;
				JClienteFacturaAJAX.validarIdentificador(tipoIdentSel.value,numIdentText.value,fncResultadoValidacion);
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
				validandoIdentificacion = false;				
				if (flgSubmitAceptar) fncAceptar(); //valida  
			}
			
			validandoIdentificacion = false;				
		}
	}
	
	//Muestra formato NIT
	function fncCambiarLabelNIT(tipoIdent, label){
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
	
</script>
</head>

<body onload="history.go(+1);fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/ClienteFacturaAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="moduloOrigen" styleId="moduloOrigen"/>
<html:hidden property="codModuloSolicitudVenta" styleId="codModuloSolicitudVenta"/>


      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
			Datos Tercero
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr>
		     <td class="mensajeError"><div id="mensajes" ></div></td>
		  </tr> 
		</table>		  
	  <P>
      <table width="90%" align="center" border="0">      
        <tr>
           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Factura a nombre de tercero:
           </td>
	    </tr>
	    <tr >
          <td align="left" width="25%">
            Nombres(*)
          </td>
          <td align="left" width="75%">
          <html:text name="ClienteFacturaForm" property="nombreClienteFactura" style="text-transform: uppercase;" styleId="nombreClienteFactura" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="50" onchange="ocultarMensajeError();"/>
      	  </td>
        </tr>
        <tr>
          <td align="left" >
            Apellido1(*)
		  </td>
          <td align="left" >
          <html:text name="ClienteFacturaForm" property="apellido1ClienteFactura" style="text-transform: uppercase;" styleId="apellido1ClienteFactura" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="30" onchange="ocultarMensajeError();"/>
          </td>
        </tr>
        <tr>
          <td align="left" >
           Apellido2
		  (*)</td>
          <td align="left" >
          <html:text name="ClienteFacturaForm" property="apellido2ClienteFactura" style="text-transform: uppercase;" styleId="apellido2ClienteFactura" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="30" onchange="ocultarMensajeError();"/>
          </td>
        </tr>
        <tr>
          <td align="left" width="26%">
  			Tipo Identificaci&oacute;n(*)        
		  </td>
          <td align="left" width="32%">
			  <html:select name="ClienteFacturaForm" property="tipoIdentClienteFactura" style="width:200px;" styleId="tipoIdentClienteFactura" onchange="ocultarMensajeError();limpiaNumeroIdentificacion('numeroIdentClienteFactura');">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="ClienteFacturaForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td align="left" width="21%">
  			N&uacute;m. Identif.(*)        
		  </td>
          <td align="left" width="21%">
       		<html:text name="ClienteFacturaForm" property="numeroIdentClienteFactura" style="text-transform: uppercase;" size="37" maxlength="20" styleId="numeroIdentClienteFactura"
			onblur="upperCase(this);"  onchange="ocultarMensajeError();"
			onkeypress="soloCaracteresValidos();valNumeroIdentificacion('numeroIdentClienteFactura','tipoIdentClienteFactura');" />
			&nbsp;&nbsp;&nbsp;&nbsp;<label for="numeroIdentClienteFactura" id="lbNumeroIdentClienteFactura" class="textoAzul"></label>
		  </td>
        </tr>
	</table>

   	 <P>
     <P>
     <P>
     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="50%" >
        <bean:define id="codModuloSolicitudVenta" name="ClienteFacturaForm" property="codModuloSolicitudVenta" type="java.lang.String"/>
        
        <logic:equal name="ClienteFacturaForm" property="moduloOrigen" value="<%= codModuloSolicitudVenta %>"> 
			<input type="button" name="btnVolver" value="VOLVER AL MENU" onclick="ocultarMensajeError();fncVolver();" style="width:150px;color:black">
		</logic:equal>
			     	
        </td>
        <td width="25%" align="right">
			<html:button  value="CANCELAR" style="width:120px;color:black" styleId="btnCancelar" property="btnCancelar" onclick="ocultarMensajeError();fncCancelar()"/>        
        </td>
        <td width="25%" align="right">
			<html:button  value="ACEPTAR" style="width:120px;color:black" styleId="btnAceptar" property="btnAceptar" onclick="ocultarMensajeError();fncAceptar()"/>
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