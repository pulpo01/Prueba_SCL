<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JAltaClienteFinalAJAX.js'></script>
<script>
	window.history.forward(1);

	var flgSubmitAceptar = false;
    var validandoTarjeta=false;
    var ultimoObjetoFoco;
	function fncInicio(){
		var modalidadCancel = document.getElementById("modalidadCancel");
		if (modalidadCancel!=null){
			fncActivarDesacControles(modalidadCancel);
			var banco = document.getElementById("banco");
			fncObtenerSucursales(banco);
			
			//Inicio Inc.179734 01-01-2012 JLGN
			if(modalidadCancel.value == "A"){
				document.getElementById("modalidadCancel").disabled = true;			
			}
			//Fin Inc.179734 01-01-2012 JLGN
		}
		//document.getElementById("modalidadCancel").disabled = <bean:write name="AltaClienteFinalForm" property="restriccionModalidadCancel"/> ;
		
		var flagClientePrepago = document.getElementById("flagClientePrepago");
		if (flagClientePrepago.value == "1"){
			//modalidadCancel.disabled = true;
			document.getElementById("sistemaPago").disabled = true;
		}		
		document.getElementById("banco").disabled = true;		
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
	}
	
	function fncActivarDesacControles(codModalCancel){
	
		if (codModalCancel.value == ""){
	  		DWRUtil.removeAllOptions("sistemaPago");
		    DWRUtil.addOptions("sistemaPago",{'':'- Seleccione -'});
   		    /*Inicio P-CSR-11002 JLGN 11-05-2011
   		    DWRUtil.removeAllOptions("sucursal");
		    DWRUtil.addOptions("sucursal",{'':'- Seleccione -'});		    
		    document.getElementById("sucursal").value = "";
		    Fin P-CSR-11002 JLGN 11-05-2011*/
		    document.getElementById("sistemaPago").value = "";
	   		document.getElementById("codSistemaPagoSeleccionado").value = "";
			document.getElementById("codSucursalSeleccionada").value = "";
		}else{
			fncObtenerSistemasDePago(codModalCancel);
		}
		
		if (codModalCancel.value !="A" ){//desactivar todo
  			document.getElementById("banco").disabled =  true;
  			//document.getElementById("banco").selectedIndex = 0; P-CSR-11002 JLGN 11-05-2011
  			document.getElementById("sucursal").disabled = true;
  			//document.getElementById("sucursal").selectedIndex = 0; P-CSR-11002 JLGN 11-05-2011
		 	document.getElementById("tipoTarjeta").disabled = true;	
			//document.getElementById("tipoTarjeta").selectedIndex = 0; P-CSR-11002 JLGN 11-05-2011
			document.getElementById("numeroCuenta").disabled = true;
			document.getElementById("numeroCuenta").value = '';
			document.getElementById("numeroTarjeta").disabled = true;
			document.getElementById("numeroTarjeta").value = '';			
			document.getElementById("tipoCuentaBanc").disabled = true;
			document.getElementById("tipoCuentaBanc").selectedIndex = 0;
			document.getElementById("mesVencimientoTarjeta").disabled = true;			
			document.getElementById("agnoVencimientoTarjeta").disabled = true;
			document.getElementById("mesVencimientoTarjeta").selectedIndex = 0;			
			document.getElementById("agnoVencimientoTarjeta").selectedIndex = 0;				
			document.getElementById("fechaVencimientoTarjeta").value = '';
			document.getElementById("numeroCuenta").style.background  = "#e0e0e0";
			document.getElementById("numeroTarjeta").style.background  = "#e0e0e0";
			document.getElementById("nombreTitularTarjeta").style.background  = "#e0e0e0";
			document.getElementById("observacionesTarjeta").style.background  = "#e0e0e0";
		}else{//inicio Inc.179734 01-01-2012 JLGN
			document.getElementById("banco").disabled =  true;
  			document.getElementById("sucursal").disabled = true;
		 	document.getElementById("tipoTarjeta").disabled = true;	
			document.getElementById("numeroCuenta").disabled = true;
			document.getElementById("numeroCuenta").value = '';
			document.getElementById("numeroTarjeta").disabled = true;
			document.getElementById("numeroTarjeta").value = '';			
			document.getElementById("tipoCuentaBanc").disabled = true;
			document.getElementById("tipoCuentaBanc").selectedIndex = 0;
			document.getElementById("mesVencimientoTarjeta").disabled = true;			
			document.getElementById("agnoVencimientoTarjeta").disabled = true;
			document.getElementById("mesVencimientoTarjeta").selectedIndex = 0;			
			document.getElementById("agnoVencimientoTarjeta").selectedIndex = 0;				
			document.getElementById("fechaVencimientoTarjeta").value = '';
			document.getElementById("numeroCuenta").style.background  = "#e0e0e0";
			document.getElementById("numeroTarjeta").style.background  = "#e0e0e0";
			document.getElementById("nombreTitularTarjeta").style.background  = "#e0e0e0";
			document.getElementById("observacionesTarjeta").style.background  = "#e0e0e0";			
		}	//fin Inc.179734 01-01-2012 JLGN
	}
	
	
	//(+)-- carga combo de sistema de pago--
	function fncObtenerSistemasDePago(codModalCancel) {
		if (codModalCancel.value != ""){
			JAltaClienteFinalAJAX.obtenerModalidadesPago(codModalCancel.value,fncResultadoObtenerSistemasDePago);
		}
	}
	
	function fncValidarTarjeta(numeroTarjeta,tipoTarjeta) {
		if (!validandoTarjeta){
			if (document.getElementById("tipoTarjeta").value!="" && document.getElementById("numeroTarjeta").value!="" ){
	            ultimoObjetoFoco=numeroTarjeta; 
   				validandoTarjeta = true; 
				JAltaClienteFinalAJAX.ValidaTarjeta(document.getElementById("numeroTarjeta").value,document.getElementById("tipoTarjeta").value,fncResultadoValidacion);
			}
		}
	}
	
	function fncResultadoValidacion(data) {
        if (data!=null)
		{
			var esValido = data["valido"];
			if (!esValido) 
			{
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Número de Tarjeta invalida");
				ultimoObjetoFoco.value="";
				ultimoObjetoFoco.focus();
			}else{
				validandoTarjeta = false;				
				if (flgSubmitAceptar) fncFinalizar(); //valida  	
			}
			validandoTarjeta = false;
		}
	}
	
	
	function fncResultadoObtenerSistemasDePago(data){
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
			
			var codSistemaPagoSeleccionado = document.getElementById("codSistemaPagoSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("sistemaPago");
		    DWRUtil.addOptions("sistemaPago",{'':'- Seleccione -'});
		    DWRUtil.addOptions("sistemaPago",listaActualizada,"codigoModalidadPago","descripcionModalidadPago");
		      
		    if (codSistemaPagoSeleccionado !=""){
			    var sistemaPago = document.getElementById("sistemaPago");
			    var encontrado = false;
			    for (index = 0; index< sistemaPago.length; index++) {
			       	  if (sistemaPago[index].value == codSistemaPagoSeleccionado){
			        	sistemaPago.selectedIndex = index;
			        	encontrado = true;
			        	fncActivarDesacControlesSistemaPago(sistemaPago);
			        	break;
			       	  } 
			    }
			    if (!encontrado){
				    document.getElementById("codSistemaPagoSeleccionado").value = ""
				    document.getElementById("sistemaPago").value = "";
				}
		    }
	    }
	    fncSeleccionarSistemaPago();//P-CSR-11002 JLGN 11-05-2011
	    //fin if (data!=null)
	}
	//(-)-- carga combo de sistema de pago--

	//(+)-- carga combo de sucursales--
	function fncObtenerSucursales(codBanco) {
		if (codBanco.value == ""){
			DWRUtil.removeAllOptions("sucursal");
		    DWRUtil.addOptions("sucursal",{'':'- Seleccione -'});
	   		document.getElementById("sucursal").value = "";
	   		document.getElementById("codSucursalSeleccionada").value = "";
		}else {
			JAltaClienteFinalAJAX.obtenerSucursales(codBanco.value,fncResultadoObtenerSucursales);
		}
	}
	
	function fncResultadoObtenerSucursales(data){
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
			
			var codSucursalSeleccionada = document.getElementById("codSucursalSeleccionada").value;
					    		
			DWRUtil.removeAllOptions("sucursal");
			DWRUtil.addOptions("sucursal",{'':'-Seleccione-'});
			DWRUtil.addOptions("sucursal",listaActualizada,"codigoSucursalBanco","descripcionSucursalBanco");
		  
		    if (codSucursalSeleccionada !=""){
			    var sucursal = document.getElementById("sucursal");
			    var encontrado = false;
			    for (index = 0; index< sucursal.length; index++) {
			       	  if (sucursal[index].value == codSucursalSeleccionada){
			        	sucursal.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) {
			    	document.getElementById("codSucursalSeleccionada").value = ""
			    	document.getElementById("sucursal").value = "";
			    }
		    }
	    }//fin if (data!=null)
	}
	
	//(-)-- carga combo de sucursales--
	
		
	function fncActivarDesacControlesSistemaPago(sistemaPago) {
			var modCancel = document.getElementById("modalidadCancel");
			if (modCancel.value == "A" && sistemaPago.value!=""){
				document.getElementById("banco").disabled = false;
				if (sistemaPago.value == "3"){//Cta Cte
					document.getElementById("sucursal").disabled = false;
					document.getElementById("numeroCuenta").disabled = false;
					document.getElementById("numeroCuenta").style.background  = "white";	
					document.getElementById("tipoCuentaBanc").disabled = false;						
					document.getElementById("tipoTarjeta").disabled = true;	
					//document.getElementById("tipoTarjeta").selectedIndex = 0; P-CSR-11002 JLGN 11-05-2011
					document.getElementById("numeroTarjeta").disabled = true;	
					document.getElementById("numeroTarjeta").style.background  = "#e0e0e0";
					document.getElementById("numeroTarjeta").value = "";
					document.getElementById("mesVencimientoTarjeta").disabled = true;			
					document.getElementById("agnoVencimientoTarjeta").disabled = true;		
					document.getElementById("mesVencimientoTarjeta").selectedIndex = 0;			
					document.getElementById("agnoVencimientoTarjeta").selectedIndex = 0;							
					document.getElementById("fechaVencimientoTarjeta").value = '';
					document.getElementById("nombreTitularTarjeta").disabled = true;
					document.getElementById("nombreTitularTarjeta").style.background  = "#e0e0e0";
					document.getElementById("nombreTitularTarjeta").value = "";
					document.getElementById("observacionesTarjeta").disabled = true;
					document.getElementById("observacionesTarjeta").style.background  = "#e0e0e0";
					document.getElementById("observacionesTarjeta").value = "";
				}else if (sistemaPago.value == "4"){//Tarjeta Debito
					document.getElementById("sucursal").disabled = true;				
					//document.getElementById("sucursal").selectedIndex = 0; P-CSR-11002 JLGN 11-05-2011
					document.getElementById("numeroCuenta").disabled = true;					
					document.getElementById("numeroCuenta").style.background  = "#e0e0e0";	
					document.getElementById("numeroCuenta").value = '';		
					document.getElementById("tipoCuentaBanc").disabled = true;															
					document.getElementById("tipoCuentaBanc").selectedIndex = 0;
					document.getElementById("tipoTarjeta").disabled = false;
					document.getElementById("numeroTarjeta").disabled = false;		
					document.getElementById("numeroTarjeta").style.background  = "white";
					document.getElementById("mesVencimientoTarjeta").disabled = false;			
					document.getElementById("agnoVencimientoTarjeta").disabled = false;			
					document.getElementById("nombreTitularTarjeta").disabled = false;		
					document.getElementById("nombreTitularTarjeta").style.background  = "white";
					document.getElementById("observacionesTarjeta").disabled = false;		
					document.getElementById("observacionesTarjeta").style.background  = "white";	
				}
			}//fin if (modCancel.value == "A" && sistemaPago.value!="")
	  }
	  
	function fncSeleccionaSistema(sistemaPago){
		document.getElementById("codSistemaPagoSeleccionado").value = sistemaPago.value;
	}
	
	function fncSeleccionaSucursal(sucursal){
		document.getElementById("codSucursalSeleccionada").value = sucursal.value;
	}
		  
	function fncAnterior() {
	  	document.getElementById("opcion").value = "anterior";
    	document.forms[0].submit();
	}
	
	function fncFinalizar() {
	  	
	  	if (validandoTarjeta){//validando tarjeta
	  		flgSubmitAceptar = true;
	  		return;
	  	}
	  	
  		flgSubmitAceptar = false;
  		
  		if (    !document.getElementById("modalidadCancel").disabled && (document.getElementById("modalidadCancel").value =="A") 
  			 && !document.getElementById("sistemaPago").disabled && (document.getElementById("sistemaPago").value == "")){
  			  alert("Debe seleccionar sistema de pago"); 
	  	      return false;
  		}

	  	if (document.getElementById("sistemaPago").value=="3")
	  	{
	  	   if (document.getElementById("banco").value=="")
	  	   {
	  	      alert("Debe seleccionar banco"); 
	  	      return false;
	  	   }
	  	   
	  	   if (document.getElementById("sucursal").value=="")
	  	   {
	  	      alert("Debe seleccionar sucursal asociada al banco"); 
	  	      return false;
	  	   }
	  	   
	  	   if (document.getElementById("numeroCuenta").value=="")
	  	   {
	  	      alert("Debe ingresar número de cuenta"); 
	  	      return false;
	  	   }
	  	   
	  	   if (document.getElementById("tipoCuentaBanc").value=="")
	  	   {
	  	      alert("Debe tipo de cuenta bancaria"); 
	  	      return false;
	  	   }
	  	}
	  	if (document.getElementById("sistemaPago").value=="4")
	  	{
	  	
	  	   if (document.getElementById("banco").value=="")
	  	   {
	  	      alert("Debe seleccionar banco"); 
	  	      return false;
	  	   }
	  	
	  	   if (document.getElementById("tipoTarjeta").value=="")
	  	   {
	  	      alert("Debe ingresar tipo de tarjeta"); 
	  	      return false;
	  	   }
	  	   
	  	   if (document.getElementById("numeroTarjeta").value=="")
	  	   {
	  	      alert("Debe ingresar número de tarjeta"); 
	  	      return false;
	  	   }

	  	   if (document.getElementById("fechaVencimientoTarjeta").value=="")
	  	   {
	  	      alert("Debe ingresar fecha de vencimiento de tarjeta"); 
	  	      return false;
	  	   }	  	   
	  	}
	  	
	  	document.getElementById("btnFinalizar").disabled =true;
	  	document.getElementById("btnAnterior").disabled =true;	  	
	  	document.getElementById("opcion").value = "finalizar";
    	document.forms[0].submit();
	}
	
	/* valida fecha en formato dd-mm-yyyy*/
	function validaFechaVencTarjeta(){
		var ctrlMes = document.getElementById("mesVencimientoTarjeta");
		var ctrlAgno = document.getElementById("agnoVencimientoTarjeta");		
	
		if (ctrlMes.value == "" || ctrlAgno.value=="") return;
		
		var diaSel = "01";
		var mesSel = ctrlMes.value;
		var anoSel = ctrlAgno.value;
		
		var fechaHoy = new Date();
		var dia = fechaHoy.getDate()+"";
		var mes = fechaHoy.getMonth() + 1+"";
		var ano = fechaHoy.getFullYear()+"";
		
		if (mes.length == 1) mes = "0"+mes;
		if (dia.length == 1) mes = "0"+dia;
		
		var fechaSelNum = parseInt(anoSel+mesSel+diaSel);
		var fechaHoyNum = parseInt(ano+mes+dia);
		
		if (fechaSelNum <= fechaHoyNum){
			alert("Fecha de Vencimiento de Tarjeta debe ser mayor a la fecha actual");
			ctrlMes.selectedIndex=0;
			ctrlAgno.selectedIndex=0;
			ctrlMes.focus();	
			document.getElementById("fechaVencimientoTarjeta").value = "";	
			return;
		}
		document.getElementById("fechaVencimientoTarjeta").value = diaSel+"-"+mesSel+"-"+anoSel;
	}	 	
	
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
	
	//P-CSR-11002 11-05-2011
	function fncSeleccionarSistemaPago(){
		var sistemaPago = document.getElementById("sistemaPago");
		var modalidadCancel = document.getElementById("modalidadCancel");  
		if (modalidadCancel.value == "M" ){
		    for (index = 0; index< sistemaPago.length; index++) {
		       	  if (sistemaPago[index].value == "1" ){		       	  
		        	sistemaPago.selectedIndex = index;
		        	//P-CSR-11002 JLGN 14-10-2011
		        	sistemaPago.disabled = true;
		        	break;
		       	  } 
		    }		
		}else{
			//P-CSR-11002 JLGN 14-10-2011
			sistemaPago.disabled = false;
		}    
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
<html:form method="POST" action="/AltaClienteFinalAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="codSistemaPagoSeleccionado" styleId="codSistemaPagoSeleccionado"/>
<html:hidden property="codSucursalSeleccionada" styleId="codSucursalSeleccionada"/>
<html:hidden property="flagClientePrepago" styleId="flagClientePrepago"/>
<html:hidden property="fechaVencimientoTarjeta" styleId="fechaVencimientoTarjeta"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Creación de Clientes&nbsp;
         </td>            
        </tr>
      </table>
	  <P>
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
     <TABLE align="center" width="90%">
       <tr>
           <td align="left" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Forma de pago:
           </td>
	    </tr>
        <tr>
          <td align="left" width="50%">
  			 La manera en que el cliente desea cancelar sus cuentas es 
  		  </td>
          <td align="left" width="50%">
			  <html:select name="AltaClienteFinalForm" property="modalidadCancel" style="width:400px;" styleId="modalidadCancel" onchange="ocultarMensajeError();fncActivarDesacControles(this);fncSeleccionarSistemaPago();" >
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayModalidadCancel">
	              <html:optionsCollection property="arrayModalidadCancel" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>			  	
	          </html:select>
          </td>
        </tr>
        
        <tr>
          <td align="left"">
  			 Sistema de pago
  		  </td>
          <td align="left" >
			  <html:select name="AltaClienteFinalForm" property="sistemaPago" style="width:400px;" styleId="sistemaPago" onchange="ocultarMensajeError();fncSeleccionaSistema(this);fncActivarDesacControlesSistemaPago(this);" >
	              <html:option value="">- Seleccione -</html:option>
	          </html:select>
          </td>
        </tr>
	</TABLE>

	<P><P>	
    <TABLE align="center" width="90%" border=0>
        <tr>
          <td align="left" width="20%">
  			Banco        
		  (*)</td>
          <td align="left" width="30%">
			  <html:select name="AltaClienteFinalForm" property="banco" style="width:200px;" styleId="banco" onchange="ocultarMensajeError();fncObtenerSucursales(this);">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayBanco">
	              <html:optionsCollection name="AltaClienteFinalForm" property="arrayBanco" value="codigoBanco" label="descripcionBanco"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td align="left" width="20%">
  			Tipo Tarjeta       
 		  (*)</td>
          <td align="left" width="30%">
			  <html:select name="AltaClienteFinalForm" property="tipoTarjeta" style="width:200px;" styleId="tipoTarjeta" onchange="ocultarMensajeError();fncValidarTarjeta(numeroTarjeta,this);">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayTiposTarjeta">
	              <html:optionsCollection property="arrayTiposTarjeta" value="codigoTarjeta" label="descripcionTarjeta"/>
	          	</logic:notEmpty>
	          </html:select>
		  </td>
        </tr>
        
        <tr>
          <td align="left" >
  			Sucursal        
		  (*)</td>
          <td align="left">
			 <html:select name="AltaClienteFinalForm" property="sucursal" style="width:200px;" styleId="sucursal" onchange="ocultarMensajeError();fncSeleccionaSucursal(this);">
	         	<html:option value="">- Seleccione -</html:option>
	         </html:select>
          </td>
          <td align="left" >
  			N&ordm; tarjeta 
		  (*)</td>
          <td align="left" >
          	<html:text name="AltaClienteFinalForm" property="numeroTarjeta" style="text-transform: uppercase;" styleId="numeroTarjeta" size="37" maxlength="16"
          	onblur="upperCase(this);fncValidarTarjeta(this,tipoTarjeta);" onchange="ocultarMensajeError();"
          	onkeypress="soloCaracteresValidos();if (window.event.keyCode == 13) fncValidarTarjeta(this,tipoTarjeta);"/>
		  </td>
        </tr>

        <tr>
          <td align="left">
  			N&ordm; cuenta        
		  (*)</td>
          <td align="left" >
          	<html:text name="AltaClienteFinalForm" property="numeroCuenta" style="text-transform: uppercase;" styleId="numeroCuenta" size="37" maxlength="17" onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" onchange="ocultarMensajeError();"/>
          </td>
          <td align="left" >
  			Fecha Venc.(mm/yyyy)(*)  
		  </td>
          <td align="left" nowrap>
          	 <html:select name="AltaClienteFinalForm" property="mesVencimientoTarjeta" style="width:45px;" styleId="mesVencimientoTarjeta" onchange="ocultarMensajeError();validaFechaVencTarjeta('MES');" >
				<html:option value="">&nbsp;</html:option>    
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayMeses">
	              <html:optionsCollection property="arrayMeses" value="codigoParametro" label="valorParametro"/>
	          	</logic:notEmpty>
	          </html:select>
	          
	          
			 &nbsp;/&nbsp;	          
          	 <html:select name="AltaClienteFinalForm" property="agnoVencimientoTarjeta" style="width:55px;" styleId="agnoVencimientoTarjeta" onchange="ocultarMensajeError();validaFechaVencTarjeta('AGNO');" >
				<html:option value="">&nbsp;</html:option>          	 
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayAgnos">
	              <html:optionsCollection property="arrayAgnos" value="codigoParametro" label="valorParametro"/>
	          	</logic:notEmpty>			  	
	          </html:select>
		  </td>
        </tr>

        <tr>
          <td align="left" >
  			Tipo de cuenta        
		  (*)</td>
          <td align="left" >
			  <html:select name="AltaClienteFinalForm" property="tipoCuentaBanc" style="width:200px;" styleId="tipoCuentaBanc" onchange="ocultarMensajeError();">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteFinalForm" property="arrayTipoCuentaBanc">
	              <html:optionsCollection property="arrayTipoCuentaBanc" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td align="left" >
  			Nombre Titular
		  </td>
          <td align="left" >
          	<html:text name="AltaClienteFinalForm" property="nombreTitularTarjeta" style="text-transform: uppercase;" styleId="nombreTitularTarjeta" size="37" maxlength="18"
          	onblur="upperCase(this);" onchange="ocultarMensajeError();"
          	onkeypress="soloCaracteresValidos();"/>
		  </td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
          <td align="left">
  			Observaciones
		  </td>
          <td align="left">
          	<html:text name="AltaClienteFinalForm" property="observacionesTarjeta" style="text-transform: uppercase;" styleId="observacionesTarjeta" size="37" maxlength="18"
          	onblur="upperCase(this);" onchange="ocultarMensajeError();"
          	onkeypress="soloCaracteresValidos();"/>
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
        </td>
        <td width="25%" align="right">
            <html:button  value="FINALIZAR" style="width:120px;color:black" property="btnFinalizar" styleId="btnFinalizar" onclick="fncCursorEspera();ocultarMensajeError();fncFinalizar();"/>
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