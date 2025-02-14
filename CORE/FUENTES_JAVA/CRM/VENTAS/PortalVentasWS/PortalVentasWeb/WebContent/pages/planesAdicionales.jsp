<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display" %>

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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JPlanesAdicionalesAJAX.js'></script>
<script>
	window.history.forward(1);
  	
    function fncInicio(){
    	history.go(+1);
    }
    
    function desabilitaBoton(){
    	document.getElementById("btnContinuar").disabled = true;
    }
  
  
    
 	//Verifica si se contrato PA, si no se contrato, o si se contrato con error, se llama a metodo que contratara
 	//planes por defecto
 	//-----------------------(+) PA------------------------
 	
 	function fncContinuarVenta(){ //funcion principal
		document.getElementById("btnContinuar").disabled = false;
		
		var codUsuario = document.getElementById("codUsuario").value;
		var codOperadora = document.getElementById("codOperadora").value;
		var versionSistema = document.getElementById("versionSistema").value;
		var tipoEjecucion = document.getElementById("tipoEjecucion").value;
		var formatoNIT = document.getElementById("formatoNIT").value;
		var codigoIdentificadorNIT = document.getElementById("codigoIdentificadorNIT").value;
		var numeroVenta = document.getElementById("numeroVenta").value;
		var codigoCliente = document.getElementById("codCliente").value;
		var numeroTransaccionVenta = document.getElementById("numeroTransaccionVenta").value;

		JPlanesAdicionalesAJAX.recuperaSesionAnterior(
		codUsuario,codOperadora,versionSistema,tipoEjecucion,formatoNIT,
		codigoIdentificadorNIT,numeroVenta,codigoCliente,numeroTransaccionVenta,fncResultadoContinuarVenta);
	}
	
	function fncResultadoContinuarVenta(data){
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
	        //------- inicializa timer para consultar estado de PA
		 	if (document.getElementById("codTipoCliente").value!=document.getElementById("codTipoClientePrepago").value){
		 	    InitializeTimer();
	 		}
		 	else{
 		 	    fncContinuar();
		 	}
		 	//-----------------------------------------------------
		 	
		 }//fin if (data!=null)
	}
	
	 function fncContinuar(){
		document.getElementById("opcion").value = "continuar";
		document.forms[0].submit();	 
	}
	
	//funcion llamada desde Timer
 	function fncContinuarPA(){
	 	 JPlanesAdicionalesAJAX.obtenerEstadoContratacionPA(fncResultadoContinuarPA);
	}
	
	function fncResultadoContinuarPA(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
		        StopTheClock(); //detener timer
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
				document.getElementById("btnContinuar").disabled = false;
	        	return;
	        }
	        
	        var resultado = data['resultado']; 
	        if (resultado != "ENCOLADO" && resultado!="EN PROCESO" ){
		        StopTheClock(); //detener timer
		        
		        if (resultado == "0" || resultado == "INSCRITO"){//No hay proceso PA
					//alert("Se enviar\u00E1 a contratar planes por defecto");		        
			        fncContratarPlanesDefecto();
		        }else if (resultado == "ERROR"){//PA con error
		        	alert("Error al registrar planes adicionales, se realizar\u00E1 la contrataci\u00F3n de planes por defecto");
			        fncContratarPlanesDefecto();
		        }else if (resultado == "PROCESADO"){//PA grabado correctamente
			        fncContinuar();
		        }else{
		        	mensajeError = "Error: Estado PA "+resultado+" No identificado";
		        	mostrarMensajeError(mensajeError);
		        	document.getElementById("btnContinuar").disabled = false;
		        }
	        }
	        else{//Si el resultado == ENCOLADO , continuara consultandose el estado por un tiempo maximo de 60 segundos, cada 15 segundos
		        document.getElementById("lbMensajePA").innerHTML = "Registrando contrataci\u00F3n de planes adicionales ... ";
	        }
	        
	        
	    }//fin if (data!=null)
	}
	
	function fncContratarPlanesDefecto(){
		JPlanesAdicionalesAJAX.contratarPlanesDefecto(fncResultadoContratarPlanesDefecto);
	}
	
	function fncResultadoContratarPlanesDefecto(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
				document.getElementById("btnContinuar").disabled = false;
	        	return;
	        }
	        
	        fncContinuar();
	        
	   	}//fin if (data!=null)
	}	        
	
	//-----------(+) Timer -----------------------------	
	var secs;
	var timerID = null;
	var timerRunning = false;
	var delay = 15000;//cada 15 segundos

	function InitializeTimer()
	{
	    // largo del timer, en segundos
	    secs = 60;
	    StopTheClock();
	    StartTheTimer();
	}

	function StopTheClock()
	{
	    if(timerRunning)	clearTimeout(timerID);
	    self.status = "";
	    document.getElementById("lbMensajePA").innerHTML ="";
	    timerRunning = false;
	}

	function StartTheTimer()
	{
	    if (secs==0)
	    {
    	    StopTheClock();
			alert("Se realizar\u00E1 la contrataci\u00F3n de planes por defecto");
			fncContratarPlanesDefecto();
    	}
    	else
    	{
        	self.status = "Registrando contrataci\u00F3n de planes adicionales ... "+secs+" segundos ...";
        	secs = secs - 15;
        	timerRunning = true;
        	timerID = self.setTimeout("StartTheTimer()", delay);
        	fncContinuarPA();
    	}
	}
	//-----------(-) Timer -----------------------------
	
	
 	//-----------------------(-) PA------------------------
 	 	
 	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}	
	
</script>
</head>

<body onload="fncInicio();" onpaste="return false;" onkeydown="validarTeclas();" >
<html:form method="POST" action="/PlanesAdicionalesAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="urlPlanesAdicionales" styleId="urlPlanesAdicionales"/>
<html:hidden property="codCliente" styleId="codCliente"/>
<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
<html:hidden property="codTipoClientePrepago" styleId="codTipoClientePrepago"/>
<html:hidden property="codUsuario" styleId="codUsuario"/>
<html:hidden property="codOperadora" styleId="codOperadora"/>
<html:hidden property="versionSistema" styleId="versionSistema"/>
<html:hidden property="tipoEjecucion" styleId="tipoEjecucion"/>
<html:hidden property="formatoNIT" styleId="formatoNIT"/>
<html:hidden property="codigoIdentificadorNIT" styleId="codigoIdentificadorNIT"/>
<html:hidden property="numeroVenta" styleId="numeroVenta"/>
<html:hidden property="numeroTransaccionVenta" styleId="numeroTransaccionVenta"/>
	
<table width="100%">
<tr>
   	<td height="10%" width="100%" valign="top">

      <table width="100%" >
        <tr>
	         <td class="amarillo" colspan="4">
		       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
		       Solicitud de Venta
	         </td>            
        </tr>
		<tr>
			<td width="4%">&nbsp;</td>
			<td width="10%" class="campoInformativo">Cliente</td>
			<td width="2%">:</td>
			<td width="41%" class="valorCampoInformativo" colspan="2">
			<bean:write name="PlanesAdicionalesForm" property="nombreCliente"/> - <bean:write name="PlanesAdicionalesForm" property="codCliente"/></td>
		</tr>
		<tr>
			<td width="100%" colspan="4">
		    <table cellSpacing=0 cellPadding=0 width="90%" align="center">
			      <tr><td class="mensajeError" colspan="3">
					<div id="mensajes" >
			     	  <logic:present name="mensajeError"> <bean:write name="mensajeError"/> </logic:present>
		     		</div>			      
				  </td></tr>		
				  <tr>
				        <td align="left" width="50%" >
				        </td>
				        <td width="25%" align="right">
				        </td>
				        <td width="25%" align="right">
				            <html:button  value=">>" disabled="true" style="width:150px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="ocultarMensajeError();fncContinuarVenta();"/>
				        </td>
				   </tr>
			</table>
			</td>
		</tr>     		
		<tr>
			<td colspan="4"><HR noshade></td>
		</tr>		
      </table>
    </td>  
</tr>
<!-- (+)PLANES ADICIONALES -->
<bean:define id="prepago" name="PlanesAdicionalesForm" property="codTipoClientePrepago" type="java.lang.String"/>
<logic:notEqual name="PlanesAdicionalesForm" property="codTipoCliente" value="<%= prepago %>"> 
<tr>
	<td height="90%" width="100%" valign="top">
	    <div id="divPlanesAdicionales">
		<table width="100%" height="580" align="left">
		<tr>
			<td>
			  <label for="total" id="lbMensajePA" class="textoAzul11">Cargando Planes Adicionales ... </label>
			</td>
		</tr>				    				    
		
		<tr>
	   		<td width="100%" height="100%" valign="top" >
	          <iframe onload = "document.getElementById('lbMensajePA').innerHTML='';" src='<bean:write name="PlanesAdicionalesForm" property="urlPlanesAdicionales"/>' id="cargosPA" name="cargosPA" width="100%" height="100%" frameborder="0" style="overflow-x:false" scrolling="auto">	
	          </iframe>	
	          
	          <!--<iframe  src='' id="cargosPA" name="cargosPA" width="100%" height="100%" frameborder="0" style="overflow-x:false" scrolling="auto">	
	          </iframe>	-->
	          
	   		</td>
   		</tr>  
   		</table> 		
   		</div>
	</td>
</tr>
</logic:notEqual>
<!-- (-)PLANES ADICIONALES -->

</tr>
</table>
</html:form>

</body>
</html:html>
