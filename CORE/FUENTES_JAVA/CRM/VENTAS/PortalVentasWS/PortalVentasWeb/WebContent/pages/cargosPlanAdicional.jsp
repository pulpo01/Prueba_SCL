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
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JCargosAJAX.js'></script>
<script>
	window.history.forward(1);
	
	var estadoSolic = "";
	
	document.onkeydown = function(){
    if(window.event && window.event.keyCode == 8)
	  {
	   window.event.keyCode = 505;
      }
    }
    
    function fncInicio(){
    	history.go(+1);
    	//parent.fncBloqueaVenta();
	    formatoDecimales($("txtParamDecForm").value);
	    fncChequeaSolicitudDescuento();
    }
    
    function fncValidaTipoDescuento(indice,field){

    	if ($("tipoDescM" + indice).value == '-1'){
	    	field.value = 0;
    	}else{
	    	field.disabled = false;
    	}
    	
    	fncValidaDescuento(field);
    	
    	if ($("tipoDescM" + indice).value == '-1'){
	    	field.value = 0;
	    	/*$("motivoDesc" + indice).value = '-1';
			$("centroCosto" + indice).value = '-1';
			$("motivoDesc" + indice).disabled = true;
			$("centroCosto" + indice).disabled = true;*/
			field.disabled= true;
			$("txtInfringeRangoDescuento" + indice).value = 'false';
    	}else{
	    	field.disabled = false;
    	}
    	fncChequeaSolicitud();
    	
    }
    
   function fncValidaDescuento(field) 	{
        var dctoManualAux = field.value;
		var montoDescAutomaticoAux;
		var montoDescManualPorcAux;
		var swValidacion = 0;
		var swConsultaDescuento = 0;
		montoDescAutomaticoAux = 0;
		nombre = field.name;
		indice = nombre.substr(9,nombre.length);
		impTotal = eval($("txtImpTotal" + indice));
		cantidad = eval($("txtCantidad" + indice));
		montoDescAutomatico = eval($("txtMontoDA" + indice));
		tipoDescuentoAutomatico = eval($("tipoDescA" + indice));
		tipoDescuentoManual = eval($("tipoDescM" + indice));
 		montoDescManual = eval($("txtMontoM" + indice));
		saldoTotal = eval($("txtSaldoTotal" + indice));
		saldoTotal.value = transformaraNumero(saldoTotal.value);
		codigoConceptoPrecio = eval($("txtCodPrec" + indice));
		infringeRangoDescuento =  eval($("txtInfringeRangoDescuento" + indice));
		//motivoDescuento =  eval($("motivoDesc" + indice));
		//centroCosto = eval($("centroCosto" + indice));
		//maximoDescuento = $("txtMaximoDcto").value /100;
		//minimoDescuento = $("txtMinimoDcto").value / 100;
		porcMaximoDescuento = $("txtPorcMaximoDcto").value;
		porcMinimoDescuento = $("txtPorcMinimoDcto").value;
		
		if (tipoDescuentoAutomatico.value == '1') {
		   montoDescAutomaticoAux = parseFloat(impTotal.value) * (parseFloat(montoDescAutomatico.value)/ 100);
		}
		else {
		   montoDescAutomaticoAux = parseFloat(montoDescAutomatico.value);
		}
		
		if (tipoDescuentoManual.value == '0') { //monto
			montoDescManualPorcAux = ((parseFloat(dctoManualAux)/parseInt(cantidad.value)) * 100)/parseFloat(impTotal.value)
		}
		
		if (parseFloat(montoDescManual.value) == 0) {
		   //motivoDescuento.value = "-1";
      	   //centroCosto.value = "-1";
		}
		
		if (tipoDescuentoManual.options[tipoDescuentoManual.selectedIndex].value == "1") { //Porcentaje
			if (parseFloat(dctoManualAux) <= porcMaximoDescuento && parseFloat(dctoManualAux) >= porcMinimoDescuento) {
			    var importe = parseFloat(impTotal.value);
			    var descAuto = parseFloat(montoDescAutomaticoAux);
			    var descManual = parseFloat(dctoManualAux);
			    var saldo = importe - descAuto;
				saldo = saldo - (saldo * descManual / 100);
			    // if ((parseFloat(dctoManualAux) + parseFloat(montoDescAutomaticoAux)) <= parseFloat(impTotal.value)) {			    
				// JIB - Se reemplaza validación por defecto en paso a produccion
			    if (saldo >= 0) {
				    saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
					dctoManualAux = (parseFloat(montoDescManual.value) * parseFloat(saldoTotal.value)) / 100;
					saldoTotal.value = parseFloat(impTotal.value) - (parseFloat(montoDescAutomaticoAux) + parseFloat(dctoManualAux));
					saldoTotal.value = Math.round(parseFloat(saldoTotal.value) * Math.pow(10, $("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
		     	    swValidacion = 2;
				}
				else {
					alert("Valor del descuento sobrepasa el valor del cargo");
					saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
	              	saldoTotal.value = Math.round(parseFloat(saldoTotal.value) * Math.pow(10, $("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
	              	montoDescManual.value = dctoManualAux.toFixed($("txtParamDecForm").value);
             	  	swValidacion = 1;
				}
            }
            else if (parseFloat(dctoManualAux) > 0) {
            	if (parseFloat(dctoManualAux) > 100) {
	            	alert('Valor porcentaje debe ser menor que 100%');
		     	    swValidacion = 1;
            	}
            	else if (parseFloat(saldoTotal.value) > 0) {
					infringeRangoDescuento.value = 'true';
					dctoManualAux = (parseFloat(montoDescManual.value) * parseFloat(saldoTotal.value)) / 100;
					saldoTotal.value = parseFloat(impTotal.value) - (parseFloat(montoDescAutomaticoAux) + parseFloat(dctoManualAux));
					saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
					montoDescManual.focus();
					montoDescManual.select(); 
					//motivoDescuento.disabled = false;
             	    //centroCosto.disabled = false;
		     	    //motivoDescuento.style.background= "#FFFFFF";
		     	    //centroCosto.style.background= "#FFFFFF";
		     	    
					document.getElementById("btnSolicitar").disabled=false;
					document.getElementById("btnContinuar").disabled=true;	
					var strFeatures = " dialogTop=200px; dialogLeft=250px; dialogWidth=600px;" +
							  		  " dialogHeight=250px; center=yes; status:off; scroll:off "; 
					var url = "<%=request.getContextPath()%>/pages/advertenciaCargo.jsp";							  		  
					abrirPopup (url,'Advertencia',strFeatures); 
				}
				else {
					alert('Valor del descuento sobrepasa el valor del cargo');
					saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
	              	saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
	              	swValidacion = 1;
				}
			}
			else if (dctoManualAux == '' || parseFloat(dctoManualAux) <= 0) {
				saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
             	saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
             	swValidacion = 1;
			}
		}  
		else { // Si el option seleccionado es 1 (Monto) -1 nada
 		    if (tipoDescuentoManual.options[tipoDescuentoManual.selectedIndex].value == "-1") {
 		    	montoDescManual.value = '0';
 		    	dctoManualAux = '0';
 		    }

 		    /*(+) EV -------------------------------------------------*/
 		    //Se cambia esta implementacion de modo de usar solo las variables que indican porcentaje maximo
 		    //y minimo para validar los descuentos
			/****Codigo antiguo
			if (parseFloat(dctoManualAux) <= (maximoDescuento * parseFloat(saldoTotal.value)) 
			&&  parseFloat(dctoManualAux) >= (minimoDescuento * parseFloat(saldoTotal.value))
			&& parseFloat(saldoTotal.value) > 0){


				saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
				saldoTotal.value = parseFloat(impTotal.value) - (parseFloat(montoDescAutomaticoAux) + parseFloat(dctoManualAux));
				saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
				swValidacion = 2;
			****/
				
			//montoDescManualPorcAux  monto manual en porcentaje
			//dctoManualAux    		  campo monto manual
			if (parseFloat(montoDescManualPorcAux) <= porcMaximoDescuento && 
			  parseFloat(montoDescManualPorcAux) >= porcMinimoDescuento) {
			    if ((parseFloat(dctoManualAux) + parseFloat(montoDescAutomaticoAux)) <= parseFloat(impTotal.value)){
			    	//es valido
					saldoTotal.value = parseFloat(impTotal.value) - (parseFloat(montoDescAutomaticoAux) + parseFloat(dctoManualAux));
					saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
		     	    swValidacion = 2;
				}
				else {
					alert('Valor del descuento sobrepasa el valor del cargo');
					saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
	              	saldoTotal.value = Math.round(parseFloat(saldoTotal.value) * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
	              	var dctoManualAuxNumber = new Number(dctoManualAux);
	              	montoDescManual.value = dctoManualAuxNumber.toFixed($("txtParamDecForm").value);
             	  	swValidacion = 1;
				}	
			/*(-)----------------------------------------------------*/
			}
			else if (dctoManualAux == '' || parseFloat(dctoManualAux) <= 0 || parseFloat(saldoTotal.value) <= 0 ) {
				saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
             	saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
             	if (parseFloat(saldoTotal.value) <=0 && parseFloat(dctoManualAux) > 0) {
             		alert('Valor del descuento sobrepasa el valor del cargo');
             	}
	     		swValidacion = 1;
			}
			else {
				var saldoImporte = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
				if (parseFloat(dctoManualAux) > 0 && parseFloat(saldoImporte) > 0) {
					if (parseFloat(dctoManualAux) > parseFloat(saldoImporte)) {
						alert('Valor del descuento sobrepasa el valor del cargo');
						saldoTotal.value = parseFloat(impTotal.value) - parseFloat(montoDescAutomaticoAux);
		              	saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
						swValidacion = 1;
					}
					else {
						saldoTotal.value = parseFloat(impTotal.value) - (parseFloat(montoDescAutomaticoAux) + parseFloat(dctoManualAux));
	             		saldoTotal.value = Math.round(saldoTotal.value * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
	             	    infringeRangoDescuento.value = 'true';
		               // motivoDescuento.disabled = false;
	             	    //centroCosto.disabled = false;
						//motivoDescuento.style.background= "#FFFFFF";
			     	    //centroCosto.style.background= "#FFFFFF";
			     	    
	             	    montoDescManual.focus();
						montoDescManual.select();
						document.getElementById("btnSolicitar").disabled=false;
						document.getElementById("btnContinuar").disabled=true;
						var strFeatures = " dialogTop=200px; dialogLeft=250px; dialogWidth=600px;" +
								  		  " dialogHeight=250px; center=yes; status:off; scroll:off "; 					
						var url = "<%=request.getContextPath()%>/pages/advertenciaCargo.jsp";							  		  
						abrirPopup (url,'Advertencia',strFeatures); 							  		  
					}
				}
			}
		} //fin descuento monto
		
		if (swValidacion != 0){
           	infringeRangoDescuento.value = 'false';		
			if (swValidacion == 1){
	     	   // motivoDescuento.value = "-1";
	     	    //centroCosto.value = "-1";
				dctoManualAux = 0;
	           	montoDescManual.value = dctoManualAux.toFixed($("txtParamDecForm").value);
			}else if (swValidacion == 2){
				//motivoDescuento.disabled = false;
				//centroCosto.disabled = false;
				//motivoDescuento.style.background= "#FFFFFF";
	     	    //centroCosto.style.background= "#FFFFFF";
			}
			fncChequeaSolicitud();
		}		
		if (parseFloat(saldoTotal.value) > 0){
			//saldoTotal.value = formatCurrency(saldoTotal.value,$("txtParamDecForm").value);
			var num = new Number(saldoTotal.value);
			saldoTotal.value = num.toFixed($("txtParamDecForm").value);			
		} 
		totalPagar=0;
		for(var i=0;i<$("numeroCargos").value;i++){
			saldoTotal = eval($("txtSaldoTotal"+ i));
			saldoAuxiliar = transformaraNumero(saldoTotal.value);
			totalPagar = parseFloat(totalPagar) + parseFloat(saldoAuxiliar);
		}
		totalPagar = Math.round(totalPagar * Math.pow(10,$("txtParamDecForm").value)) / Math.pow(10, $("txtParamDecForm").value);
		//$("total").value=formatCurrency(totalPagar,$("txtParamDecForm").value);
		$("total").value =totalPagar.toFixed($("txtParamDecForm").value);
	}
    
    function validaIngresoDecimales (campoTexto) { 
		numDecimales = $("txtParamDecForm").value;
		onlyFloat(campoTexto.value,numDecimales);
	} 
	
     //(+) ----------- Solicitud de descuento ----------------------
     function fncChequeaSolicitudDescuento(){
    	if ($("btnContinuar").disabled == true){
    	    fncEstadoSolicitud();
    	}
     } 
    
     function fncChequeaSolicitud(){
    	var sw = 0;
	    for(var i=0;i<$("numeroCargos").value;i++){
        	if ($("txtInfringeRangoDescuento" + i).value == 'true'){
        		sw = 1;
        	}
    	}
    	
    	if (sw==0){
    		$("btnSolicitar").disabled = true;
			$("btnContinuar").disabled = false;	
    	}else{
    		$("btnSolicitar").disabled = false;
			$("btnContinuar").disabled = true;	
    	}
    }
    
    function fncEstadoSolicitud(){
	  	estadoSolic = JCargosAJAX.consultaResultadoSolicitud(fncResEstSolicitud);
	}
	
	function fncResEstSolicitud(estadoSolic){
	   if (estadoSolic !=null){
	   
	   		if (estadoSolic == "-100"){
	   			fncInvocarPaginaExpiraSesion();
	        	return;
	   		}
	   		
			if (estadoSolic == "OK"){
				for(i=0;i<$("numeroCargos").value;i++){
					
		        	$("txtInfringeRangoDescuento" + i).value = 'false';
		    	}
				$("btnSolicitar").disabled = true;
				$("btnContinuar").disabled = false;	
			}
			else{
				$("btnSolicitar").disabled = false;
				$("btnContinuar").disabled = true;	
			}
		}
	}
	
    function fncSolicitar(){
   	  	document.getElementById("opcion").value = "solicitarDescuento";
    	verifica ();
    }
    
    function verifica () { 
		generaListadoDescuento();
		grabaListadoDescuento();
	} 
	
	function generaListadoDescuento(){
		texto = eval($("textoXMLDescuento"));
		for(i=0;i<$("numeroCargos").value;i++){
			if (i==0){
				texto.value = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
				texto.value =texto.value + "<listadoCargos>\n"
			}
			texto.value = texto.value + "<cargo>\n";		
			texto.value = texto.value + "<montoDescuentoManual>" + $("txtmontoM"+i).value + "</montoDescuentoManual>\n";
			tipoDescuentoM = eval($("tipoDescM"+ i));
			if(tipoDescuentoM.type=="select-one"){
			    if (tipoDescuentoM.options[tipoDescuentoM.selectedIndex].value != "-1")
   			        texto.value = texto.value + "<tipoDescuentoManual>" + tipoDescuentoM.options[tipoDescuentoM.selectedIndex].value + "</tipoDescuentoManual>\n";
			    else
			   	    texto.value = texto.value + "<tipoDescuentoManual>" + "0" + "</tipoDescuentoManual>\n";
			}
			else{
 			    texto.value = texto.value + "<tipoDescuentoManual>" + "0" + "</tipoDescuentoManual>\n";
 			}    
			texto.value = texto.value + "<infringeRangoDescuento>" + $("txtInfringeRangoDescuento" + i).value + "</infringeRangoDescuento>\n";    
 			texto.value =texto.value + "</cargo>\n";	
			
		}
		texto.value =texto.value + "</listadoCargos>";	
	}
	
	function grabaListadoDescuento(){
		listado = JCargosAJAX.grabaListadoDescuento($("textoXMLDescuento").value,grabaListRes);
	}
	
	function grabaListRes(listado){
		if (listado != null){
		
			if (listado =="-100"){
				fncInvocarPaginaExpiraSesion();
				return;
			}
			
			$("btnSolicitar").disabled = false;
	    	$("btnContinuar").disabled = true;	
	    	var strFeatures = "dialogTop=200px; dialogLeft=250px; dialogWidth=600px;" +
							  "dialogHeight=285px; center=yes; help=no;  font-family:Arial;" +
							  "font-size:12px; status:off; scroll:off" ;
							  
			accion = document.getElementById("opcion").value;				  
			if (accion== "solicitarDescuento"){
				var url = "<%=request.getContextPath()%>/pages/consultaSolicitudDescuento.jsp";							  		  
				abrirPopup (url,'solicitud',strFeatures); 		
			} else {
	          // Mostrar el total a pagar
	          numeroCargos = eval(document.getElementById("numeroCargos"));
		      totalPagar=0;
		      for(i=0;i<numeroCargos.value;i++){
		         saldoTotal = eval(document.getElementById("txtSaldoTotal"+ i));
		         saldoAuxiliar = transformaraNumero(saldoTotal.value);
		         totalPagar = parseFloat(totalPagar) + parseFloat(saldoAuxiliar);
		      }
		      
		      document.getElementById("total").value=totalPagar;
			}
		}
	}
	
	
	//(-) ----------- Solicitud de descuento ----------------------
	function transformaraNumero(num1) { 
		num2 = ""; 
		// Por cada digito 
	    for (i=0; i < num1.length; i++) { 
			// Comprobamos si es una coma 
	        char1 = num1.charAt(i); 
			// Si es una coma, lo quitamos 
	        if(char1 == ",") {
	        	char1 = "";
	        }
	    	num2 += char1; 
	    } 
		// Y retornamos el n?mero 
	    return parseFloat(num2); 
	}

	function formatoDecimales(nroDecimales){
		for (i=0; i<document.forms.length; i++){
			for (j = 0; j < document.forms[i].elements.length; j++){
				if (document.forms[i].elements[j].type == "text" 
			  		&& !isNaN(document.forms[i].elements[j].value)
		          	) { 
		           num = parseFloat(document.forms[i].elements[j].value);
		           num =Math.round(num * Math.pow(10,nroDecimales)) / Math.pow(10, nroDecimales);
		           document.forms[i].elements[j].value = num.toFixed(nroDecimales);
		        }
			}
		}
	}
	
	function abrirPopup (URLtoOpen, windowName, windowFeatures) { 
	  newWindow=window.showModalDialog(URLtoOpen, windowName, windowFeatures);
	} 
	
	function fncDeshabilitarControles() {
    	for(var i=0;i<$("numeroCargos").value;i++){
			$("tipoDescM" + i).disabled = true;
			$("txtMontoM" + i).disabled = true;
			//$("centroCosto" + i).disabled = true;
			//$("motivoDesc" + i).disabled = true;
		}
		$("btnContinuar").disabled = true;
		$("btnAnterior").disabled = true;
		
    }
    
    function fncContinuar(){

	    document.getElementById("btnContinuar").disabled = true;
		document.getElementById("btnSolicitar").disabled = true;
		document.getElementById("btnAnterior").disabled = true;		
		
     	//var sw=0;
		texto = eval(document.getElementById("textoXML"));
		/*for(var j=0;j<$("numeroCargos").value;j++){
			montoDescManual = eval($("txtMontoM" + j));
			if (montoDescManual.value > 0){
				motivoDescuento =  eval($("motivoDesc" + j));
		      	centroCosto = eval($("centroCosto" + j));
			  	if (motivoDescuento.value == "-1"){
			     	alert ('Debe seleccionar motivo de descuento');
			     	sw=1;
			     	continue;
			  	}else{
			  		txtOblCC =  eval($("txtOblCC" + j));
			  		if (txtOblCC.value == "1" && centroCosto.value == "-1"){
			  			alert ('Debe seleccionar centro de costo');
                    	sw=1;
                    	continue;	  		
			  		}
			  	}
			}
		}*/
		
		
		//if (sw==0){
			for(var i=0;i<$("numeroCargos").value;i++){
				if (i==0){
					texto.value = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n";
					texto.value =texto.value + "<listadoCargos>\n"
				}
				texto.value = texto.value + "<cargo>\n";		
					
	    		//texto.value = texto.value + "<codigoArticuloServicio>" + document.getElementById("txtCodArtServ"+i).value + "</codigoArticuloServicio>\n";			
				//texto.value = texto.value + "<tipoProducto>" + document.getElementById("txtTipProd"+i).value + "</tipoProducto>\n";			
				texto.value = texto.value + "<codigoPrecio>" + document.getElementById("txtCodPrec"+i).value + "</codigoPrecio>\n";
				texto.value = texto.value + "<montoPrecio>" + document.getElementById("txtImpTotal"+i).value + "</montoPrecio>\n";
				texto.value = texto.value + "<codigoMoneda>" + document.getElementById("txtMoneda"+i).value + "</codigoMoneda>\n";
				texto.value = texto.value + "<codigoDescuento>" + document.getElementById("txtCodDesc"+i).value + "</codigoDescuento>\n";
				texto.value = texto.value + "<tipoDescuentoAutomatico>" + document.getElementById("tipoDescA"+i).value + "</tipoDescuentoAutomatico>\n";
				texto.value = texto.value + "<montoDescuentoAutomatico>" + document.getElementById("txtmontoDA"+i).value + "</montoDescuentoAutomatico>\n";
				texto.value = texto.value + "<montoDescuentoManual>" + document.getElementById("txtmontoM"+i).value + "</montoDescuentoManual>\n";
				tipoDescuentoM = eval(document.getElementById("tipoDescM"+ i));
				if(tipoDescuentoM.type=="select-one")
				    if (tipoDescuentoM.options[tipoDescuentoM.selectedIndex].value != "-1")
	   			        texto.value = texto.value + "<tipoDescuentoManual>" + tipoDescuentoM.options[tipoDescuentoM.selectedIndex].value + "</tipoDescuentoManual>\n";
				    else
				   	    texto.value = texto.value + "<tipoDescuentoManual>" + "0" + "</tipoDescuentoManual>\n";
				else
	 			    texto.value = texto.value + "<tipoDescuentoManual>" + "0" + "</tipoDescuentoManual>\n";
	
				texto.value = texto.value + "<cantidad>" + parseInt(document.getElementById("txtCantidad"+i).value) + "</cantidad>\n";
				texto.value = texto.value + "<numCargo>" + parseInt(document.getElementById("txtNumCargo"+i).value) + "</numCargo>\n";
				texto.value = texto.value + "<montoDescuentoSinImpuesto>" + parseFloat(document.getElementById("txtMontoDescuentoSinImpuesto"+i).value) + "</montoDescuentoSinImpuesto>\n";
				
				//texto.value = texto.value + "<ind_Equipo>" + document.getElementById("txtInd_Equipo"+i).value + "</ind_Equipo>\n";
				//texto.value = texto.value + "<ind_Paquete>" + document.getElementById("txtInd_Paquete"+i).value + "</ind_Paquete>\n";
				//texto.value = texto.value + "<motivoDescuento>" + document.getElementById("motivoDesc"+i).value + "</motivoDescuento>\n";
				//texto.value = texto.value + "<centroCosto>" + document.getElementById("centroCosto"+i).value + "</centroCosto>\n";								
				texto.value =texto.value + "</cargo>\n";	
			}
			
			texto.value =texto.value + "</listadoCargos>";	
			//alert("texto2="+texto.value);
			
		    document.getElementById("opcion").value = "grabarCargos";
			document.forms[0].submit();
			fncDeshabilitarControles();			


		//}
			    
    }
 	 	
 	function fncAnterior(){
	 		//habilita menus
	 		var win = parent;
			win.fncActDesacMenu(false);
			
		  	document.getElementById("opcion").value = "reversarCargos";
		   	document.forms[0].submit();
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
	
</script>
</head>

<body onload="fncInicio();" onfocus="fncChequeaSolicitudDescuento();" onpaste="return false;" onkeydown="validarTeclas();" >
<html:form method="POST" action="/CargosAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="txtMaximoDcto" styleId="txtMaximoDcto"/>
<html:hidden property="txtMinimoDcto" styleId="txtMinimoDcto"/>
<html:hidden property="txtPorcMaximoDcto" styleId="txtPorcMaximoDcto"/>
<html:hidden property="txtPorcMinimoDcto" styleId="txtPorcMinimoDcto"/>
<html:hidden property="txtParamDecForm" styleId="txtParamDecForm"/>
<html:hidden property="txtParamDecBD" styleId="txtParamDecBD"/>
<html:hidden property="cargoSeleccionado" styleId="cargoSeleccionado"/>
<html:hidden property="numeroCargos" styleId="numeroCargos"/>
<html:hidden property="textoXMLDescuento" styleId="textoXMLDescuento"/>
<html:hidden property="textoXML" styleId="textoXML"/>
<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
<html:hidden property="codTipoClientePrepago" styleId="codTipoClientePrepago"/>

<table width="100%">
<tr>
   	<td height="10%" width="100%" valign="top">

      <table width="100%" >
        <tr>
	         <td class="amarillo" colspan="5">
		       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
		       Detalle de cargos Comercializaci&oacute;n de Productos
	         </td>            
        </tr>
		<tr>
			<td width="4%">&nbsp;</td>
			<td width="10%" class="campoInformativo">Cliente</td>
			<td width="2%">:</td>
			<td width="41%" class="valorCampoInformativo" colspan="2">
			<bean:write name="ventaSel" property="nombreCliente"/> - <bean:write name="ventaSel" property="codCliente"/></td>
		</tr>
		<tr>
			<td colspan="5" align="center">&nbsp;</td>
		</tr>
		<tr>
			<td colspan="5"><HR noshade></td>
		</tr>		
      </table>
    </td>  
</tr>
<!-- (+)CARGOS -->
<tr>
	<td height="90%" width="100%" valign="top">
	
<div id="divCargos" >
<table width="100%" height="580" align="left">
<tr><td width="100%" height="3%" valign="top">

	  <table width="100%" >
		  <tr>
		     <td class="mensajeError">
			     <div id="mensajes" >
			     	  <logic:present name="mensajeError"> <bean:write name="mensajeError"/> </logic:present>
		     	</div>
		     </td>
		  </tr> 
	  </table>	
</td></tr>

<tr><td width="100%" height="97%" valign="top">
	<table valign="top">
		<tr>
		    <td  align="left" colspan="5" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
		     Cargos
		    </td>
		</tr>
		<tr bgcolor="#F8F8F3">
			<td>
				<table width="100%">
					<tr class="textoColumnaTabla">
						<td colspan="3">&nbsp;</td>
						<td colspan="2">Descuento Automatico</td>						
						<td colspan="2">Descuento Manual</td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<tr class="textoColumnaTabla">
						<td width="18%">Descripci&oacute;n Cargo</td>
						<td width="8%">Cantidad</td>
						<td width="12%">Importe Total</td>
						<td width="10%">Tipo Descuento</td>
						<td width="10%">Valor Descuento</td>
						<td width="10%">Tipo Descuento</td>
						<td width="10%">Valor Descuento</td>
						<td width="12%">Saldo Total</td>
						<td width="10%">Moneda</td>
					</tr>
					
      	<logic:present name="Cargos">
	    <logic:iterate indexId="count" id="cargos" name="Cargos"  scope="session" type="com.tmmas.cl.scl.commonbusinessentities.dto.CargoXMLDTO">
		          	<input type="hidden" id="txtCodPrec<%=String.valueOf(count) %>" name="txtCodPrec<%=String.valueOf(count) %>" value="<bean:write name="cargos" property="codigoConceptoPrecio"/>" />
		          	<input type="hidden" id="txtCodDesc<%=String.valueOf(count) %>" name="txtCodDesc<%=String.valueOf(count) %>" value="<bean:write name="cargos" property="codigoDescuento"/>" />
		          	<input type="hidden" id="txtNumCargo<%=String.valueOf(count) %>" name="txtNumCargo<%=String.valueOf(count) %>" value="<bean:write name="cargos" property="numCargo"/>" />		          	
		          	<input type="hidden" id="txtInfringeRangoDescuento<%=String.valueOf(count)%>" name="txtInfringeRangoDescuento<%=String.valueOf(count)%>" value="false" />
	          		<input type="hidden" id="txtMontoDescuentoSinImpuesto<%=String.valueOf(count)%>" name="txtMontoDescuentoSinImpuesto<%=String.valueOf(count)%>" value="<bean:write name="cargos" property="montoDescuentoSinImpuesto"/>" />
	          	
					<tr bgcolor="#FFFFFF">
							<td>
								<bean:write name="cargos" property="descripcionConceptoPrecio" />
							</td>
							
			                <!-- Cantidad -->
			                <td align="center">
			                 	<input type="text" style="text-align: right"  readonly="true" id="txtCantidad<%=String.valueOf(count) %>" name="txtCantidad<%=String.valueOf(count) %>" 
			                 		maxlength = "4" size = "4" 
			                   		value="<bean:write name="cargos" property="cantidad"/>" />
			                </td>
			                
							<!-- Importe Total -->
							<td align="right">
			                  	<input style="text-align: right" id="txtImpTotal<%=String.valueOf(count)%>" name="txtImpTotal<%=String.valueOf(count)%>"  
					                 value="<bean:write name="cargos" property="montoConceptoTotal"/>" 
			                  		 type="text" readonly="true" 
			                  		 maxlength = "10" size = "12" />
							</td>
							
							<!-- Tipo aplicacion descuento automatico -->							
							<td>
					            <logic:equal name="cargos" property="tipoDescuento" value="1">
					                 <input type="hidden" style="font-size: 9px" id="tipoDescA<%=String.valueOf(count) %>" name="tipoDescA<%=String.valueOf(count) %>" value="1"/>
					                 <input type="text"   style="font-size: 9px" id="tipoDescAD<%=String.valueOf(count) %>" name="tipoDescAD<%=String.valueOf(count) %>" size = "14" readonly="true"
					                  value="PORCENTAJE"/>
					            </logic:equal>
					            <logic:notEqual name="cargos" property="tipoDescuento" value="1">
					                  <input type="hidden" style="font-size: 9px" id="tipoDescA<%=String.valueOf(count) %>" name="tipoDescA<%=String.valueOf(count) %>" value="0"/>
					                  <input type="text"   style="font-size: 9px" id="tipoDescAD<%=String.valueOf(count) %>" name="tipoDescAD<%=String.valueOf(count) %>" size = "14" readonly="true"
					                  value="MONTO"/>
					            </logic:notEqual>
				            </td>
				            
				           <!-- Monto Descuento Automatico -->
				            <td>
				                  <input class="<bean:write name="cargos" property="clase"/>" type="text" readonly="true" id="txtmontoDA<%=String.valueOf(count)%>" name="txtmontoDA<%=String.valueOf(count)%>" maxlength = "10" size = "12" 
				                  value="<bean:write name="cargos" property="montoDescuento"/>" />
				            </td>
              
							<!-- Tipo aplicacion descuento manual -->								
							<td align="right">
				                  <select id="tipoDescM<%=String.valueOf(count) %>" name="tipoDescM<%=String.valueOf(count) %>" size="1" 
				                  		  <logic:equal name="cargos" property="habilitaDescuento" value="false">
											disabled="disabled" style="background-color:#e0e0e0"    
										  </logic:equal>
				                  		  onchange="ocultarMensajeError();fncValidaTipoDescuento('<%=String.valueOf(count) %>',txtmontoM<%=String.valueOf(count)%>)"
				                  >  
				                    <option value="-1"></option> 
				                    <option value="0">MONTO</option> 
				                    <option value="1">PORCENTAJE</option> 
				                  </select> 
							</td>
							
						 	<!-- Monto Descuento Manual -->								
							<td align="left">
				                  <input  type="text" style="text-align:right" 
				                  		 name="txtmontoM<%=String.valueOf(count) %>"
				                  		 id="txtmontoM<%=String.valueOf(count) %>"
				                  		 maxlength = "10" size = "12" 
				                  		 <logic:equal name="cargos" property="habilitaDescuento" value="false">
											readonly style="background-color:#e0e0e0"    
										 </logic:equal>
				                   		 value="<bean:write name="cargos" property="montoDescuentoManual"/>" 
				                  		 onchange="ocultarMensajeError();fncValidaDescuento(this);" 
				                  		 onkeypress="validaIngresoDecimales(this);" />
      						</td>
      						
							<!-- Saldo Total -->   
			                <td align="right">
			                  	<input type="text" style="text-align: right" readonly="true" name="txtSaldoTotal<%=String.valueOf(count) %>" maxlength = "10" size = "12" 
			                  	value="<bean:write name="cargos" property="saldoTotal"/>" />
			                </td>
			                <td align="left">
			                 	<input type="hidden" readonly="true" id="txtMoneda<%=String.valueOf(count) %>" name="txtMoneda<%=String.valueOf(count) %>" value="<bean:write name="cargos" property="codigoMoneda"/>" />
			                 	<bean:write name="cargos" property="descripcionMoneda"/>
			                </td>
					</tr>
				</logic:iterate>
				</logic:present>
				
			      <TABLE cellSpacing=1 cellPadding=1 width="60%" border="0" align=center>
			           <TR><td></td><td></td></TR>
			           <TR>
			            <td width="50%" align=right>
			              Total a pagar
			            </td>
			            <td  width="50%" align=left>   
			              <html:text style="text-align:right"  id="total" property="total" styleId="total" maxlength = "16" size = "16" readonly = "true"/>
			            </td>
			           </TR>
			      </TABLE>
		      	<tr><td width="100%" valign="top">
				    <table cellSpacing=0 cellPadding=0 width="80%" align="center">
					  <tr><td align="right" colspan="3"><label for="total" id="lbMensajePA" class="textoAzul11"></td></tr>				    				    
				      <tr><td>&nbsp;</td></tr>				    
				      <tr>
				        <td align="left" width="50%" >
					       <input type="button" id="btnAnterior" name="btnAnterior" value="<<" onclick="ocultarMensajeError();fncAnterior();" style="width:150px; color:black"/>
				        </td>
				        <td width="25%" align="right">
				        	<html:button value="SOLICITAR DESCUENTO" style="width:150px;color:black;" property="btnSolicitar" styleId="btnSolicitar" onclick="ocultarMensajeError();fncSolicitar();" disabled="true"/>
				        </td>
				        <td width="25%" align="right">
				            <html:button  value=">>" style="width:150px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="ocultarMensajeError();fncContinuar();"/>
				        </td>
				      </tr>
				    <table>
				</td></tr>		
				</table>
				
		</td></tr>
		</table>
 
</td></tr>
</table>	
</div>

	</td>
</tr>
<!-- (-)CARGOS -->

</tr>
</table>
</html:form>

</body>
</html:html>
