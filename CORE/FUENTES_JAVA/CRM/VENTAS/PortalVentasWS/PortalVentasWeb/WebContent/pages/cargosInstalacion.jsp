<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
	 	<% 
	 	
	 		String strCargos=(request.getParameter("cargos")==null?"0":(String)request.getParameter("cargos")); 
	 		String strIndMacAddr=(request.getParameter("indMacAddress")==null?"0":(String)request.getParameter("indMacAddress")); 
	 	%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/controlTimeOut.js' language='JavaScript'></script>
<script>
 
 	window.history.forward(1);
 	
 	function onlyFloatLocal(valorCampoTexto,numDecimales) {
		var keyASCII;
		var txt;
		var strNumber = new String(event.srcElement.value);
		keyASCII = window.event.keyCode;
		
		if (keyASCII == 47 || keyASCII == 13) {
		  window.event.keyCode = '';	 
		  return;
		}
		
			if(keyASCII != 13 && keyASCII != 75 && keyASCII != 8 && keyASCII != 46
		   && (keyASCII < 46 || keyASCII > 57)) 
		{
		   window.event.keyCode = '';
		} else {
			
			if (window.getSelection)
	    	{
	        	txt = window.getSelection();
	        }
	    	else if (document.getSelection)
	    	{
	        	txt = document.getSelection();
	        }
	    	else if (document.selection)
	    	{
	        	txt = document.selection.createRange().text;
	        }
			if (txt != valorCampoTexto){
				if (valorCampoTexto.indexOf('.') != -1){
					dectext = valorCampoTexto.substring(valorCampoTexto.indexOf('.')+1, valorCampoTexto.length);
					if (dectext.length >= numDecimales) {
				   		window.event.keyCode = '';
					}
				}
			}
		}
	}
	
	function fncValidaMontoDecimal(campoTexto){
  		if (campoTexto.value!=""){
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)){
	  	  		alert("Monto importe inv\u00E1lido");
	  	  		campoTexto.value="";
	  	  		campoTexto.focus();
	  	  	}
		}
	} 
	
	function fncAceptarCargoInst(){  
  		 var mensaje = "";
		 var importe; 
		 var wimaxMacAddress;
		 var cargos = "<%=strCargos%>";  
		 var indMacAddr = "<%=strIndMacAddr%>";  

		 if (cargos==1) {
		 	if (document.getElementById("importeCargosInst").value!=null && document.getElementById("importeCargosInst").value!=""){
		 		importe = document.getElementById("importeCargosInst").value;
		 		mensaje = "Cargo instalaci\u00F3n agregado exitosamente.";
		 		//alert(importe);
		 	} else {
	 		 	alert("Debe ingresar Importe");
			 	return;
		 	}
		 }

		 if (indMacAddr==1) {
		 	if (document.getElementById("wimaxMacAddress").value!=null && document.getElementById("wimaxMacAddress").value!=""){
		 		wimaxMacAddress = document.getElementById("wimaxMacAddress").value;
		 		//alert(wimaxMacAddress);
		 		mensaje = mensaje+" \nRegistro mac address realizado exitosamente";
		 		if (!fncValidaMacAddress(wimaxMacAddress)){
		 			return;
		 		}	 		
		 	}		  
		 }
		 
		 //window.parent.opener.fncCargarDatosInstalacion(importe, wimaxMacAddress);
		 var ret = importe+"|"+wimaxMacAddress;
		 //alert("antes de retornar "+ret);		 
		 window.returnValue = ret;  	 
		 
		 alert(mensaje);
	     window.close();
	}
	
	
	function fncBuscar(){
		//--valor para pruebas-----------------------------
		document.getElementById("nroIP").value = "12345678";
		//--------------------------------------------------
	}
	
	function fncValidaMacAddress(macAdd){
		 if (macAdd==null) {
			alert('La longitud de la IP Mac Address no es valida');
			return false;
		 }
		 
		 if (macAdd.length != 12) {
			alert('La longitud de la IP Mac Address no es valida');
			return false;
		 }
		 var hasta = 2;
		 var desde = 0;
		 var valida = "";
		 var patron = "";
		 var regex;
		 var patron="^([0-9a-f]{2}$";
		 var patron="";
		 var i=1;
		 for (i=1; i <= 6; i++) {
		 	valida = macAdd.substring(desde,hasta);
			regex = new RegExp(patron);
			if (!regex.test(valida)){
				alert('La mac address ingresada no es valida. Debe ingresar valores desde 0-9 y a-f');
				return false;
			} else {
				//alert(valida);
			}
		 	hasta = hasta+2;
		 	desde = desde+2;		 			 	
		 }
		 return true;
	}
	
 
</script>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
</head>

<body onkeydown="validarTeclas();">
<html:form method="POST" action="/ConsultaVentasVendedorAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
 <table style="width: 550px">
 <tr>
 <td>
 	<table width="100%">
		<tr>
			<td class="amarillo">
				<logic:equal value="1" scope="request" parameter="cargos">
					<logic:equal value="1" parameter="indMacAddress">
						<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2"
							align="left"> Cargos Adicionales de Instalaci&oacuten y Registro de Mac Address</h2>
						<p></p>
					</logic:equal>
					<logic:notEqual value="1" scope="request" parameter="indMacAddress">
						<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2"
							align="left"> Cargos Adicionales de Instalaci&oacuten</h2>
						<p></p>
					</logic:notEqual>
				</logic:equal> 
				<logic:notEqual value="1" scope="request"  parameter="cargos">
					<logic:equal value="1" scope="request"  parameter="indMacAddress">
						<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2"
							align="left"> Registro de Mac Address de Instalaci&oacuten</h2>
						<p></p>
					</logic:equal>
				</logic:notEqual>
			</td>
		</tr>
	</table>
	
	<table width="100%">
		<tr><td colspan="3"></td></tr>
		<logic:equal value="1" scope="request"  parameter="cargos">		
		<tr class="textoColumnaTabla">
			<td align="left" width="40%">Descripci&oacuten</td>
			<td align="left" width="25%">Importe</td>
			<td align="left" width="35%">Moneda</td>
		</tr>
		<tr>
			<td align="left" width="70%"><bean:write name="ConsultaVentasVendedorForm" property="desConcepCargoIns" /></td>
			<td align="left" width="15%"><html:text name="ConsultaVentasVendedorForm" property="importeCargosInst"
				style="width:100px;" styleId="importeCargosInst" value="" onkeypress="onlyFloatLocal(this.value,4)" onblur="fncValidaMontoDecimal(this);"
				maxlength="15">
			</html:text></td>
			<td align="left" width="15%"><bean:write name="ConsultaVentasVendedorForm" property="codMoneda" /></td>		
			<tr><td colspan="3"></td></tr>			
		</logic:equal>
		
		<logic:equal value="1" scope="request" parameter="indMacAddress">
			<tr class="textoColumnaTabla">
				<td align="left" width="40%">Descripci&oacuten</td>
				<td align="left" width="25%">IP</td>
				<td align="left" width="35%"></td>
			</tr>			
			<tr>
				<td align="left" width="40%">REGISTRO IP MAC ADDRESS</td>
				<td align="left" width="15%">
					<html:text name="ConsultaVentasVendedorForm" 
					property="wimaxMacAddress" 
					style="width:100px;" 
					styleId="wimaxMacAddress"
					value="" 					 					
					maxlength="12" >
					</html:text>
				</td>				
				<td align="left" width="35%"></td>
			</tr>			
		</logic:equal>
		<tr><td colspan="3"><html:button value="Aceptar" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="fncAceptarCargoInst();" /></td></tr>						
		<logic:equal value="1" scope="request" parameter="cargos">
		<tr><td colspan="3"><br><br><br><br><br><br></td></del></tr>
		<tr>
			<td colspan="3" width="100%" align="left">
			<p align="left"><font color="red" style="width: 100px;" face="Verdana, Tahoma" size="1">Cargo Adicional de
			Instalaci&oacute;n facturado a ciclo</font></p>
			</td>
		</tr>
		</logic:equal>
	</table>
 </td>
 </tr>
 </table>

 
</html:form>
</body>
</html:html>