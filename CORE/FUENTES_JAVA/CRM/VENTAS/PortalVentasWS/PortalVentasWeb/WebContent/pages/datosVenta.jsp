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
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JDatosVentaAJAX.js'></script>

<script>
	window.history.forward(1);
	
	function fncInicio() {
		//Selecciona por defecto la opcion NO para factura a nombre de tercero
		/*P-CSR-11002 JLGN 20-06-2011
		var facturaTercero = document.getElementsByName("facturaTercero")[0];
		if (facturaTercero == null || facturaTercero.value=="") {
			for (index = 0; index < facturaTercero.length; index++) {
				if (facturaTercero[index].value == "N") {
			    	facturaTercero.selectedIndex = index;
			        break;
			    } 
			}
		}
		fncActivarDesacBtnDatosTercero(facturaTercero);
		*/
			
		document.getElementById("glsTipoCliente").style.background = "#e0e0e0";
		document.getElementById("codCliente").style.background = "#e0e0e0";	
		document.getElementById("codCrediticia").style.background = "#e0e0e0";
		document.getElementById("montoPreAutorizado").style.background = "#e0e0e0";				
		
		//actualizacion de listas y valores seleccionados
		fncActivarDesacControlesTipoComisionista();
		fncObtenerDistribuidores();
		var codDistribuidor = document.getElementById("codDistribuidorSeleccionado");
		fncObtenerVendedores(codDistribuidor);
		fncObtenerTiposContrato();
        //Consulta Estado Vendedor
           
        //Incidencia 144182 - Error al limpiar vendedor dealer
        var indBusquedaVendedor = document.getElementById("indBusquedaVendedor");
        if (indBusquedaVendedor != null && indBusquedaVendedor.value != "0") {              
           	document.getElementById("codOficina").disabled = true;
           	document.getElementById("codTipoComisionista").disabled = true;
           	document.getElementById("codDistribuidor").disabled = true;          	
        }
   
        if (document.getElementById("indBloqueoVendedor").value == "B") {
		   	document.getElementById("mensajes").innerHTML = "Vendedor bloqueado o no vigente"; 
		   	document.getElementById("codDistribuidor").value = "";
  		   	document.getElementById("codDistribuidorSeleccionado").value = "";
		}
		else if (document.getElementById("indBloqueoVendedor").value == "BS") {
			parent.fncCargaVendedorSolVenta(codDistribuidor.value);
		}
		
		//incializa filtros de busqueda de vendedor
		if (document.getElementById("codVendedorBusqueda") != null) {
	        document.getElementById("codVendedorBusqueda").value = "";
	        document.getElementById("tipoVendedor").value = "D";
			document.getElementById("tipoVendedor").selectedIndex = 1;
		}		
		
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
	}
	
	/*P-CSR-11002 JLGN 20-06-2011
	function fncActivarDesacBtnDatosTercero(facturaTercero){
		if (facturaTercero.value=="S"){
			document.getElementById("btnDatosTercero").disabled = false;
		}else{
			document.getElementById("btnDatosTercero").disabled = true;
			document.getElementById("flagFacturacionTercero").value = 0;
			JDatosVentaAJAX.limpiaClienteFacturable(fncDummy);
		}		
	}*/
		
	function fncDummy(){}
	
//(+) Carga de combos ----------------------------

	//(+)-- carga combo distribuidor--
	function fncObtenerDistribuidores() {
		var codOficina = document.getElementById("codOficina");
		var codTipoComisionista = document.getElementById("codTipoComisionista");
		
		if (codOficina.value != "" && codTipoComisionista.value != "") {
			JDatosVentaAJAX.obtenerDistribuidores(codOficina.value,codTipoComisionista.value,fncResultadoObtenerDistribuidores);
		}else{
			DWRUtil.removeAllOptions("codDistribuidor");
	    	DWRUtil.addOptions("codDistribuidor",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;	 
	    	
	    	var codigoDistribuidorAnterior = document.getElementById("codDistribuidorSeleccionado").value;
			if (codigoDistribuidorAnterior!=""){
				//desbloquea vendedor anterior seleccionado, debido a que se limpia combo
				JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codigoDistribuidorAnterior,"D",fncResDesBloqueaVendedor);
			}
	    }
	}
	
	function fncResultadoObtenerDistribuidores(data){
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
			var codDistribuidorSeleccionado = document.getElementById("codDistribuidorSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("codDistribuidor");
		    DWRUtil.addOptions("codDistribuidor",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codDistribuidor",listaActualizada,"codigoVendedor","nombreVendedor");

		    if (codDistribuidorSeleccionado !=""){
			    var codDistribuidor = document.getElementById("codDistribuidor");
			    var encontrado = false;
			    for (index = 0; index< codDistribuidor.length; index++) {
			       	  if (codDistribuidor[index].value == codDistribuidorSeleccionado){
			        	codDistribuidor.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado){
			 		//desbloquea vendedor anterior seleccionado
					JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codDistribuidorSeleccionado,"D",fncResDesBloqueaVendedor);
			    	document.getElementById("codDistribuidorSeleccionado").value = "";					
			    }
		    }
		    
		    //actualiza combo dependiente
		    var codDistribuidor = document.getElementById("codDistribuidor");
	    	fncObtenerModalidadVenta();
		    
	    }//fin if (data!=null)
	}
	//(-)-- carga combo distribuidor--
	
	//(+)-- carga combo tipos de contrato--
	function fncObtenerTiposContrato() {
		var codTipoCliente = document.getElementById("codTipoCliente");
		if (codTipoCliente.value != "") {
			JDatosVentaAJAX.obtenerTiposContrato(codTipoCliente.value,fncResultadoObtenerTiposContrato);
			
		}else{
			DWRUtil.removeAllOptions("codTipoContrato");
	    	DWRUtil.addOptions("codTipoContrato",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codPeriodo");
	    	DWRUtil.addOptions("codPeriodo",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});	
	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;	    	    	
	    }
	}
	
	function fncResultadoObtenerTiposContrato(data){
		var codTipoCliente = document.getElementById("codTipoCliente");
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
			var codTipoContratoSeleccionado = document.getElementById("codTipoContratoSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("codTipoContrato");
		    DWRUtil.addOptions("codTipoContrato",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codTipoContrato",listaActualizada,"codigoTipoContrato","descripcionTipoContrato");

		    if(codTipoCliente.value=="3")
			{
			 document.getElementById("codTipoContrato").value="73";
			 document.getElementById("codTipoContratoSeleccionado").value="73";
			}
		    
		    if (codTipoContratoSeleccionado !=""){
			    var codTipoContrato = document.getElementById("codTipoContrato");
			    var encontrado = false;
			    for (index = 0; index< codTipoContrato.length; index++) {
			       	  if (codTipoContrato[index].value == codTipoContratoSeleccionado){
			        	codTipoContrato.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codTipoContratoSeleccionado").value = ""
		    }
		    
		    //actualiza combo dependiente
			fncObtenerPeriodo();
		    
	    }//fin if (data!=null)
	}
	
	
	//(-)-- carga combo tipos de contrato--
		
	//(+)-- carga combo vendedor--
	function fncObtenerVendedores(codDistribuidor) {
		var indVtaExterna = document.getElementById("indVtaExterna").value;
		if (indVtaExterna == "0" || indVtaExterna == 0) {
			return;
		}
		if (codDistribuidor != null && codDistribuidor.value != "") {
			JDatosVentaAJAX.obtenerVendedores(codDistribuidor.value,fncResultadoObtenerVendedores);
		}
		else {
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});	 
	   		document.getElementById("divCuotas").style["display"] = "none";
	   		document.getElementById("numCuotas").selectedIndex = 0;		    	   	
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
	
	//(+)-- carga combo periodo--
	function fncObtenerPeriodo() {
		var codTipoContrato = document.getElementById("codTipoContrato");
		
		if (codTipoContrato.value != "") {
			JDatosVentaAJAX.obtenerPeriodo(codTipoContrato.value,fncResultadoObtenerPeriodo);
		}else{
			DWRUtil.removeAllOptions("codPeriodo");
	    	DWRUtil.addOptions("codPeriodo",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;
	    }
	}
	function fncResultadoObtenerPeriodo(data){
		var codTipoCliente = document.getElementById("codTipoCliente");
		var codPeriodo = document.getElementById("codPeriodo");
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
			
			var codPeriodoSeleccionado = document.getElementById("codPeriodoSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("codPeriodo");
		    DWRUtil.addOptions("codPeriodo",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codPeriodo",listaActualizada);

            //El primer periodo por defecto  
            codPeriodo.selectedIndex="1";
		    
		    //actualiza combo dependiente
		    fncObtenerModalidadVenta();
	    }//fin if (data!=null)
	}
	//(-)-- carga combo periodo--	
		
	//(+)-- carga combo modalidad venta --
	function fncObtenerModalidadVenta() {
		var codTipoContrato = document.getElementById("codTipoContrato");
		var codPeriodo = document.getElementById("codPeriodo");
		var codVendedor = document.getElementById("codDistribuidor");
		var codTipoCliente = document.getElementById("codTipoCliente");
		if (codTipoContrato.value != "" && codPeriodo.value != "" && codVendedor.value !="") {
			JDatosVentaAJAX.obtenerModalidadVenta(codTipoContrato.value,codPeriodo.value, codVendedor.value,codTipoCliente.value,fncResultadoObtenerModalidadVenta);
			
		}else{
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;	    	
	    	
	    }
	}
	
	function fncResultadoObtenerModalidadVenta(data){
		var codModalidadVenta = document.getElementById("codModalidadVenta");
		var codTipoCliente = document.getElementById("codTipoCliente");
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
			var codModalidadVentaSeleccionada = document.getElementById("codModalidadVentaSeleccionada").value;
					    		
		    DWRUtil.removeAllOptions("codModalidadVenta");
		    DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codModalidadVenta",listaActualizada,"codigoModalidadPago","descripcionModalidadPago");

		    if (codTipoCliente.value=="3"){
		       codModalidadVenta.selectedIndex ="1";
			}

			if (codModalidadVentaSeleccionada !=""){
			    var encontrado = false;
			    for (index = 0; index< codModalidadVenta.length; index++) {
			       	  if (codModalidadVenta[index].value == codModalidadVentaSeleccionada){
			        	codModalidadVenta.selectedIndex = index;
			        	encontrado = true;
			        	break;
			      	  } 
			    }
			    if (!encontrado) document.getElementById("codModalidadVentaSeleccionada").value = "";
		     }
		     
		     //actualiza combo dependiente, muestra combo de cuotas
		     fncObtenerCuotas();
		     
	    }//fin if (data!=null)
	}
	//(-)-- carga combo modalidad venta --	

	//(+)-- carga combo cuotas --
	function fncObtenerCuotas(){
		var codModalidadVenta = document.getElementById("codModalidadVenta");
 		if (codModalidadVenta.value!=""){
			JDatosVentaAJAX.obtenerIndCuotas(codModalidadVenta.value, fncResultadoObtenerIndCuotas);
        }else{
   	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;	  
        }
	}
		
	function fncResultadoObtenerIndCuotas(data){
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
			var resultado = data['resultado'];
			if (resultado == "1"){//Venta Cuotas
			    document.getElementById("divCuotas").style["display"] = "";

			   	var numCuotasSeleccionado = document.getElementById("numCuotasSeleccionado").value;
				if (numCuotasSeleccionado !=""){
					var numCuotas = document.getElementById("numCuotas");
				    var encontrado = false;
				    for (index = 0; index< numCuotas.length; index++) {
				       	  if (numCuotas[index].value == numCuotasSeleccionado){
				        	numCuotas.selectedIndex = index;
				        	encontrado = true;
				        	break;
				      	  } 
				    }
				    if (!encontrado) document.getElementById("numCuotasSeleccionado").value = ""
			     }
		     
			    
			}else{
				document.getElementById("divCuotas").style["display"] = "none";
			}
		}//fin if (data!=null)
	}
	//(-)-- carga combo cuotas --
				
//(-) Carga de combos ----------------------------

	function fncActivarDesacControlesTipoComisionista(){
		//busca si tipo comisionista es interno o externo
		var codTipoComisionista = document.getElementById("codTipoComisionista");
		if (codTipoComisionista.value !=""){
			JDatosVentaAJAX.obtenerIndVtaExterna(codTipoComisionista.value, fncResultadoObtenerIndVtaExterna);
		}else{
			DWRUtil.removeAllOptions("codDistribuidor");
	    	DWRUtil.addOptions("codDistribuidor",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
	    	document.getElementById("indVtaExterna").value = "";
	    	
	    	document.getElementById("divCuotas").style["display"] = "none";
	    	document.getElementById("numCuotas").selectedIndex = 0;
	    	
	    	var codigoDistribuidorAnterior = document.getElementById("codDistribuidorSeleccionado").value;
			if (codigoDistribuidorAnterior!=""){
				//desbloquea vendedor anterior seleccionado, debido a que se limpia combo
				JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codigoDistribuidorAnterior,"D",fncResDesBloqueaVendedor);
			}
	    					
	    }
          
	}
 
 	function fncResultadoObtenerIndVtaExterna(data) {
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "") {
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var resultado = data['resultado'];
			if (resultado == "1") {//vta externa
				document.getElementById("lbVendedor").innerHTML = "Distribuidor (*)";
				document.getElementById("divVendedorExterno").style["display"] = "";
			
			}
			else{
				document.getElementById("lbVendedor").innerHTML = "Vendedor (*)";
				document.getElementById("divVendedorExterno").style["display"] = "none";
			}
			
			//guarda resultado
			document.getElementById("indVtaExterna").value = resultado;
			fncObtenerDistribuidores();	
	    }//fin if (data!=null)
	}

	function fncResDesBloqueaVendedor(data){
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
	        
	        document.getElementById("indBloqueoVendedor").value = "D";
	        parent.fncCargaVendedorSolVenta("");
				        
	        if (document.getElementById("codDistribuidor").value!="" && document.getElementById("indVtaExterna").value=="0")
		    {
		    		var codDistribuidor = document.getElementById("codDistribuidor");
	                JDatosVentaAJAX.obtieneEstadoVendedor(codDistribuidor.value,fncResEstadoVendedor);    
			}

		}//fin if (data!=null)
	}
	
	function fncResEstadoVendedor(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		        
	       		mostrarMensajeError(mensajeError);
	        	if (codError == "4"){
		        	document.getElementById("indBloqueoVendedor").value = "B";
		        	document.getElementById("codDistribuidor").value="";
		        	document.getElementById("codDistribuidorSeleccionado").value="";
	        	}
	        }else
	        {
	         	/*P-CSR-11002 JLGN 14-10-2011
	         	JDatosVentaAJAX.bloqueaDesbloqueaVendedor(document.getElementById("codDistribuidor").value,"B",fncResBloqueaVendedor);
	         	*/
	        }
	    }
	}
	
	function fncResBloqueaVendedor(data){
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
	        
	        document.getElementById("indBloqueoVendedor").value = "BS"; 	//bloqueado por sesion actual
			parent.fncCargaVendedorSolVenta(document.getElementById("codDistribuidor").value);

		}//fin if (data!=null)
		

	}
	
	function fncSeleccionaTipoContrato(codTipoContrato){
		document.getElementById("codTipoContratoSeleccionado").value = codTipoContrato.value;
	}
	
 	function fncSeleccionaPeriodo(codPeriodo){
		document.getElementById("codPeriodoSeleccionado").value = codPeriodo.value;
	}
		
 	function fncSeleccionaModalidad(codModalidad){
		document.getElementById("codModalidadVentaSeleccionada").value = codModalidad.value;
	}
	
	function fncSeleccionaCuotas(numCuotas){
 	    document.getElementById("numCuotasSeleccionado").value = numCuotas.value;
	}
	
   	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncBuscarCliente(){
		  	document.getElementById("opcion").value = "buscarCliente";
	    	document.forms[0].submit();
	 }
	 	
	function fncAltaCliente(){
		  	document.getElementById("opcion").value = "altaCliente";
	    	document.forms[0].submit();
	 }
	 	 		
	function fncDatosTercero() {
	  	//document.getElementById("flagFacturacionTercero").value = "1";
	  	document.getElementById("opcion").value = "ingresarDatosTercero";
    	document.forms[0].submit();
	} 		
	
	function fncContinuar() {
	  	if (document.getElementById("codTipoSolicitud").value == "") {
			alert ("Debe seleccionar Tipo de Solicitud");
		  	return false;
		}
		if (document.getElementById("codOficina").value == "") {
	  		alert ("Debe seleccionar Oficina");
		  	return false;
		}
		if (document.getElementById("codTipoComisionista").value =="") {
			alert ("Debe seleccionar Tipo de Comisionista");
		  	return false;
		}
	  	if (document.getElementById("indVtaExterna").value == "1") {
	  	   if (document.getElementById("codVendedor").value == "") {
	  	      alert("Debe seleccionar Vendedor");
	  	      return false; 
	  	   }
	  	}
		if (document.getElementById("codDistribuidor").value == "") {
		    alert("Debe seleccionar un Vendedor");
	  	    return false; 
		}
	  	if (document.getElementById("codCliente").value == "") {
	  	     alert("Debe seleccionar un Cliente mediante la opción de Búsqueda");
		     return false; 
		}   
	  	if (document.getElementById("codTipoContrato").value == "") {
		    alert("Debe seleccionar un Tipo de Contrato");
		    return false; 
		}
		if (document.getElementById("codPeriodo").value == "") {
			alert("Debe seleccionar un Periodo para el contrato seleccionado");
		  	return false; 
		}
	  	if (document.getElementById("codModalidadVenta").value == "") {
			alert("Debe seleccionar una Modalidad de Venta");
		  	return false; 
		}
		  	
	  		/*P-CSR-11002 JLGN 20-06-2011
	  		var aplicaFacturaTercero = document.getElementsByName("aplicaFacturaTercero")[0];
		  	if (document.getElementById("facturaTercero").value == "" && aplicaFacturaTercero.value == "1") {
	  	       alert("Debe indicar si la factura puede ir a nombre de un Tercero");
	  	       return false; 
	  	    }
		  	
		  	if (document.getElementById("facturaTercero").value =="S" && document.getElementById("flagFacturacionTercero").value =="0" && document.getElementById("codTipoCliente").value !="3" )
	  	    {
	  	       alert("Debe ingresar los datos del cliente facturable");
	  	       return false;  
	  	    }   */
	  	    
	  	    if (document.getElementById("codModalidadVenta").value=="7")
		  	{	  	    	  	    
		  	    if (document.getElementById("numCuotas").value == "")
		  	    {
		  	       alert("Debe indicar n\u00FAmero de cuotas");
		  	       return false; 
		  	    }	  	    
		  	}
		  	
		  	if(document.getElementById("glsTipoCliente").value=="PREPAGO")  	
		  	{		  	
		  	   if (document.getElementById("codTipoSolicitud").value=="1")		
		  	   {
			  	   alert ("Para las ventas PREPAGO no corresponde tipo de solicitud NORMAL");
			  	   return false;
			   }
		  	}		  	
		  	
		  	
		  	if(document.getElementById("codTipoSolicitud").value == "4")
		  	{
 				document.getElementById("opcion").value = "ingresarDatosSolScoring";
		  	}else{
  			  	document.getElementById("opcion").value = "ingresarDatosLinea";
		  	}
	    	document.forms[0].submit();
	 }
	 
	//(+)---------------------- busqueda de vendedor ----------------------	 
	function fncBusquedaVendedor() 
	{
		var codVendedor = document.getElementById("codVendedorBusqueda").value;
		var tipoVendedor = document.getElementById("tipoVendedor").value;		
		if(codVendedor == "" )
		{
			alert("Debe ingresar c\u00F3digo de vendedor");	
			return;
		}
		
		if(tipoVendedor == "" )
		{
			alert("Debe ingresar tipo de vendedor");	
			return;
		}
		
		JDatosVentaAJAX.busquedaVendedor(codVendedor, tipoVendedor, fncResultadoBusquedaVendedor);
	} 	
	
	function fncResultadoBusquedaVendedor(data)
	{
		if (data!=null)
		{
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		        
	        	mostrarMensajeError(mensajeError);
	        	fncLimpiarVendedor();
	        	return;
	        }
	        //limpia filtro vendedor
	        document.getElementById("codVendedorBusqueda").value="";
		
		
	        //Oficina vendedor busqueda	        
			var codigoOficinaNuevo = data["codigoOficina"];		
		    //Tipo comisionista vendedor busqueda
			var codigoTipComisionistaNuevo = data["codigoTipComis"];
			//distribuidor busqueda
			var codigoDistribuidorNuevo = data["codigoDistribuidor"];
						
			if (codigoOficinaNuevo==null || codigoOficinaNuevo == "" 
				|| codigoTipComisionistaNuevo==null ||codigoTipComisionistaNuevo == ""
				|| codigoDistribuidorNuevo==null ||codigoDistribuidorNuevo==""){
				mostrarMensajeError("Falta informaci\u00F3n del vendedor");
	        	return;
			}
			
			var codOficina = document.getElementById("codOficina");
			for (index = 0; index< codOficina.length; index++) {
		       	  if (codOficina[index].value == codigoOficinaNuevo)
		       	  {
		        	codOficina.selectedIndex = index;
		        	break;
		      	  } 
		    }
		    
			var codTipoComisionista = document.getElementById("codTipoComisionista");
			
		    for (index = 0; index< codTipoComisionista.length; index++) {
		       	  if (codTipoComisionista[index].value == codigoTipComisionistaNuevo)
		       	  {
		        	codTipoComisionista.selectedIndex = index;
		        	break;
		      	  } 
		    }
		    
		    document.getElementById("codOficina").value = codigoOficinaNuevo;				
		    document.getElementById("codTipoComisionista").value = codigoTipComisionistaNuevo; 				    
		    
		    if (document.getElementById("tipoVendedor").value == "I"){//vta externa
			      document.getElementById("lbVendedor").innerHTML = "Distribuidor (*)";
			      document.getElementById("divVendedorExterno").style["display"] = "";
      			  document.getElementById("indVtaExterna").value = 1;
			}else{
				   document.getElementById("lbVendedor").innerHTML = "Vendedor (*)";
				   document.getElementById("divVendedorExterno").style["display"] = "none";
	   			   document.getElementById("indVtaExterna").value = 0;
			} 
			
			
			//Se verifica estado vendedor anteriormente seleccionado, y se selecciona nuevo vendedor
			var codigoDistribuidorAnterior = document.getElementById("codDistribuidorSeleccionado").value;
			
			var codigoVendedorNuevo = data["codigoVendedor"];			
			
		    document.getElementById("codDistribuidorSeleccionado").value = codigoDistribuidorNuevo;				
		    document.getElementById("codDistribuidor").value = codigoDistribuidorNuevo; 	
			//carga vendedor dealer
			if (document.getElementById("indVtaExterna").value =="1"){
					document.getElementById("codVendedorSeleccionado").value = codigoVendedorNuevo;
					document.getElementById("codVendedor").value = codigoVendedorNuevo;
			}		    	
			
			if (codigoDistribuidorAnterior!=""){
				//primero desbloquea vendedor anterior seleccionado, y luego obtiene lista de distribuidores
				JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codigoDistribuidorAnterior,"D",fncResDesBloqueaVendedorContinuar); 	
			}else{  
				//carga lista de distribuidores
				JDatosVentaAJAX.obtenerDistribuidores(codigoOficinaNuevo,codigoTipComisionistaNuevo,fncResultadoObtenerDistribuidoresBusqueda);		    
			}
			
	    }//fin if (data!=null)
	    fncCursorNormal();
	}
	//---(+) limpia combos de vendedor cuando la busqueda retorna error
	function fncLimpiarVendedor(){
			
			document.getElementById("codOficina").selectedIndex = 0;;
			document.getElementById("codOficina").valor = "";
		    
			document.getElementById("codTipoComisionista").selectedIndex = 0;
		    document.getElementById("codTipoComisionista").valor = "";
		    
		    DWRUtil.removeAllOptions("codDistribuidor");
	    	DWRUtil.addOptions("codDistribuidor",{'':'- Seleccione -'});
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});	
			DWRUtil.removeAllOptions("codModalidadVenta");
	    	DWRUtil.addOptions("codModalidadVenta",{'':'- Seleccione -'});
	    	document.getElementById("indVtaExterna").value = "";
	    	
			//Se verifica estado vendedor anteriormente seleccionado
			var codigoDistribuidorAnterior = document.getElementById("codDistribuidorSeleccionado").value;
			
		    document.getElementById("codDistribuidorSeleccionado").value = "";
		    document.getElementById("codDistribuidor").value = ""
			document.getElementById("codVendedorSeleccionado").value = "";
			document.getElementById("codVendedor").value = "";
			
			document.getElementById("lbVendedor").innerHTML = "Vendedor (*)";
			document.getElementById("divVendedorExterno").style["display"] = "none";
				
			if (codigoDistribuidorAnterior!=""){
				//desbloquea vendedor anterior seleccionado
				JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codigoDistribuidorAnterior,"D",fncResDesBloqueaVendedorLimpiar); 	
			}
	
	}
	
	function fncResDesBloqueaVendedorLimpiar(data){
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
	        
	        document.getElementById("indBloqueoVendedor").value = "D";
	        parent.fncCargaVendedorSolVenta("");
	        
		}//fin if (data!=null)	
	}
	//---(-) limpia combos de vendedor cuando la busqueda retorna error
	

	//--------------------------------
	
	function fncResultadoObtenerDistribuidoresBusqueda(data){
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
			var codDistribuidorSeleccionado = document.getElementById("codDistribuidorSeleccionado").value;
				
		    DWRUtil.removeAllOptions("codDistribuidor");
		    DWRUtil.addOptions("codDistribuidor",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codDistribuidor",listaActualizada,"codigoVendedor","nombreVendedor");

		    var codDistribuidor = document.getElementById("codDistribuidor");
		    var encontrado = false;
		    for (index = 0; index< codDistribuidor.length; index++) {
		       	  if (codDistribuidor[index].value == codDistribuidorSeleccionado){
		        	codDistribuidor.selectedIndex = index;
		        	encontrado = true;
		        	break;
		       	  } 
		    }
		    if (!encontrado) document.getElementById("codDistribuidorSeleccionado").value = ""
		    
		    //actualiza combo dependiente
	    	fncObtenerModalidadVenta();
	    	
	    	if (document.getElementById("indVtaExterna").value =="0")
		    {   //va a bloquear vendedor
				JDatosVentaAJAX.obtieneEstadoVendedor(codDistribuidor.value,fncResEstadoVendedor);    
		    }else{//obtiene vendealer
			    fncObtenerVendedores(codDistribuidor);
		    }
		} //fin if (data!=null)		    
	}
	 
	//(-)---------------------- busqueda de vendedor ----------------------	 
		 
	function fncVolver() {
		if (confirm("¿Desea volver al men\u00FA?")){
			var win = parent
			win.fncActDesacMenu(false);
		    document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}
	
 	function fncSeleccionaDistribuidor(codDistribuidor) {
		//1.-Verificar Estado del Vendedor
		//2.-Si el Vendedor no se encuentra bloqueado, se debe bloquear el actual y
		// desbloquear el anterior si aplica 
		//3.-Si el vendedor se encuentra Bloqueado se debe enviar mensaje informativo
		var codDistribuidorSeleccionado = document.getElementById("codDistribuidorSeleccionado");
		if (codDistribuidorSeleccionado != null && codDistribuidorSeleccionado.value != "") {
		    JDatosVentaAJAX.bloqueaDesbloqueaVendedor(codDistribuidorSeleccionado.value, "D", fncResDesBloqueaVendedor); 
		}
		else {
 		    if (codDistribuidor.value != "" && document.getElementById("indVtaExterna").value == "0") {
                JDatosVentaAJAX.obtieneEstadoVendedor(codDistribuidor.value, fncResEstadoVendedor);    
            }
		}
		codDistribuidorSeleccionado.value = codDistribuidor.value;
	}
	
	function fncResDesBloqueaVendedorContinuar(data) {
		if (data != null) {
	        var codError = data["codError"]; 
	        var mensajeError =  data["msgError"]; 
	        if (codError != "") {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}		        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        
	        document.getElementById("indBloqueoVendedor").value = "D";
	        parent.fncCargaVendedorSolVenta("");
	        
			//carga lista de distribuidores
			var codigoOficinaNuevo = document.getElementById("codOficina").value;
		    var codigoTipComisionistaNuevo = document.getElementById("codTipoComisionista").value;
			JDatosVentaAJAX.obtenerDistribuidores(codigoOficinaNuevo,codigoTipComisionistaNuevo,fncResultadoObtenerDistribuidoresBusqueda);		    
		}//fin if (data!=null)	
	}
	
	function fncSeleccionaVendedor(codVendedorDealer) {
		document.getElementById("codVendedorSeleccionado").value = codVendedorDealer.value;
 	    JDatosVentaAJAX.validaVendedorDealerLN(codVendedorDealer.value, resultadoValidaVendedorLNDealer);
	}
	
	function resultadoValidaVendedorLNDealer(data) {
	 	if (data != null) {
			var codError = data['codError']; 
		    var mensajeError = data['msgError']; 
		    if (codError == "") {
			    var codVendedorDealer = document.getElementById("codVendedor").value; 
		    	document.getElementById("codVendedorSeleccionado").value = codVendedorDealer;
		    }
		    else {
		    	if (codError == "-100") {
			      	fncInvocarPaginaExpiraSesion();
		        	return false;
		        }
		        document.getElementById("codVendedor").value = "";
		        document.getElementById("codVendedorSeleccionado").value = "";
		        mostrarMensajeError(mensajeError);
		        return false;
		    }
		}
	}
	
	/*P-CSR-11002 JLGN 20-06-2011
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
	}*/
	
	function codDistribuidor_onchange(o) {
		ocultarMensajeError();
		fncSeleccionaDistribuidor(o);
		fncObtenerVendedores(o);
		fncObtenerModalidadVenta();
	}
	
	function body_onload() {
		fncInicio();
		//P-CSR-11002 JLGN 20-06-2011
		//mostrarOcultarFacturaTercero();
		history.go(+1);
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

<body onload="body_onload()" onkeydown="validarTeclas();">
	<html:form method="POST" action="/DatosVentaAction.do">
		<html:hidden property="opcion" value="inicio" styleId="opcion"/>
		<html:hidden property="codTipoCliente" styleId="codTipoCliente"/>
		<html:hidden property="codDistribuidorSeleccionado" styleId="codDistribuidorSeleccionado"/>
		<html:hidden property="indVtaExterna" styleId="indVtaExterna"/>
		<html:hidden property="codVendedorSeleccionado" styleId="codVendedorSeleccionado"/>
		<html:hidden property="codTipoContratoSeleccionado" styleId="codTipoContratoSeleccionado"/>
		<html:hidden property="codModalidadVentaSeleccionada" styleId="codModalidadVentaSeleccionada"/>
		<html:hidden property="codPeriodoSeleccionado" styleId="codPeriodoSeleccionado"/>
		<html:hidden property="flagFacturacionTercero" styleId="flagFacturacionTercero"/>
		<html:hidden property="numCuotasSeleccionado" styleId="numCuotasSeleccionado"/>
		<html:hidden property="indBloqueoVendedor" styleId="indBloqueoVendedor"/>
		<html:hidden property="codTipoClientePrepago" styleId="codTipoClientePrepago"/>
		<html:hidden property="flagFacturacionTercero" styleId="flagFacturacionTercero"/>
		<html:hidden property="aplicaFacturaTercero" styleId="aplicaFacturaTercero"/>
		<html:hidden name="DatosVentaForm" property="indBusquedaVendedor" styleId="indBusquedaVendedor"/>

      	<table width="80%">
        	<tr>
         		<td class="amarillo" >
	       			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">DATOS VENTA
         		</td>            
        	</tr>
      	</table>
	  	<P>
		<table width="100%" border="0" >
		  <tr>
		     <!--  <td class="mensajeError"><div id="mensajes" class="mensajeError"></div></td>-->
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
        <table width="90%">
        <tr>
         <td width="25%" align="left" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            Tipo Solicitud (*):
         </td>
         <td align="left" >
         	<html:select name="DatosVentaForm" property="codTipoSolicitud" style="width: 90%;" styleId="codTipoSolicitud" onchange="ocultarMensajeError()">
				<html:option value="">- Seleccione -</html:option>
				<logic:notEmpty name="DatosVentaForm" property="arrayTipoSolicitud">
				<html:optionsCollection property="arrayTipoSolicitud" value="codTipoSolicitud" label="glsTipoSolicitud"/>
				</logic:notEmpty>	
			</html:select>
         </td>
         <td width="25%">
         </td>
         <td>
         </td>
        </tr>
		<tr>
		    <td colspan="4">
		    <HR noshade>
		  	</td>
		</tr>	        
        <c:if test="${paramGlobal.tipoEjecucion == '1'}">
       		<logic:equal name="DatosVentaForm" property="indBusquedaVendedor" value="0">
	         	<tr>
	           		<td align="left" colspan="4" style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
	            	Datos Vendedor:
	           		</td>
		      	</tr>
		      	<tr>
			    	<td colspan="4">
		          		<table width="100%">
		          			<tr>
		            			<td align="left" width="25%">C&oacute;digo Vendedor</td>
		            			<td align="left" >
	     							<html:text name="DatosVentaForm" property="codVendedorBusqueda" styleId="codVendedorBusqueda" size="37" />            
	                			</td>
		            			<td align="left">Tipo Vendedor</td>
		            			<td align="left" colspan="3">
									<html:select name="DatosVentaForm" property="tipoVendedor" style="width:100px;" styleId="tipoVendedor" onkeypress="onlyInteger();" onchange="ocultarMensajeError();" > 
						     			<html:option value="I">EXTERNO</html:option> 
						     			<html:option value="D">INTERNO</html:option>
			            			</html:select>	        
		            			</td>
		            			<td align="left" colspan="2">
			           				<html:button value="BUSCAR" style="width:100px; color:black;" property="btnBusquedaVendedor" styleId="btnBusquedaVendedor" onclick="fncCursorEspera();ocultarMensajeError();fncBusquedaVendedor();" />						    
			        			</td>	            
		          			</tr>
		          		</table>
		        	</td>
	     		</tr>
	     	</logic:equal>
		</c:if>
	     
	      <tr>
		      <td colspan="4"  >
	          <table width="100%">
	          <tr>
	            <td align="left" width="25%">Oficina (*)</td>
	            <td align="left" colspan="3">
					<html:select name="DatosVentaForm" property="codOficina" style="width:300px;" styleId="codOficina" onchange="ocultarMensajeError();fncObtenerDistribuidores();">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="DatosVentaForm" property="arrayOficina">
			              <html:optionsCollection property="arrayOficina" value="codigoOficina" label="descripcionOficina"/>
			          	</logic:notEmpty>					
					</html:select>            
	            </td>
	          </tr>      
	          <tr>
	            <td align="left" >Tipo de Comisionista (*)</td>
	            <td align="left" colspan="3">
					<html:select name="DatosVentaForm" property="codTipoComisionista" style="width:300px;" styleId="codTipoComisionista" onchange="ocultarMensajeError();fncActivarDesacControlesTipoComisionista();">
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="DatosVentaForm" property="arrayTipoComisionista">
			              <html:optionsCollection property="arrayTipoComisionista" value="codTipComisionista" label="desTipComisionista"/>
			          	</logic:notEmpty>						
					</html:select>            
	            </td>
	          </tr>
	         <tr>
	            <td align="left"><div id="lbVendedor">Vendedor (*)</div></td>
	            <td align="left" colspan="3">
					<html:select name="DatosVentaForm" property="codDistribuidor" style="width:300px;" styleId="codDistribuidor" onchange="codDistribuidor_onchange(this)">
						<html:option value="">- Seleccione -</html:option>
					</html:select>            
	            </td>
	         </tr>	          
	          </table>
	          </td>
	     </tr>
         	     
         <tr>
          <td colspan="4"  >
          <div id="divVendedorExterno" style="display:none">  
          <table width="100%">
          <tr>
            <td align="left" width="25%">Vendedor (*)</td>
            <td align="left" colspan="3">
				<html:select name="DatosVentaForm" property="codVendedor" style="width:300px;" styleId="codVendedor" onchange="ocultarMensajeError();fncSeleccionaVendedor(this);">
					<html:option value="">- Seleccione -</html:option>
				</html:select>            
            </td>
          </tr>
          </table>
          </div>
          
          </td>
          </tr>
                
          <tr>
		      <td colspan="4">
		      <HR noshade>
		    </td>
	      </tr>
	      <tr>
	           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
	            Datos Cliente:
	           </td>
		  </tr>
          <tr>
             <td align="left" width="25%">
				<a href="javascript:fncBuscarCliente();" onclick="ocultarMensajeError();"><FONT color="#0000ff">Buscar Cliente</FONT></a> (*) 
             </td>      
             <td align="left" >
             	<c:if test="${paramGlobal.tipoEjecucion == '1'}">
					<a href="javascript:fncAltaCliente();" onclick="ocultarMensajeError();"><FONT color="#0000ff">Alta Cliente</FONT></a> 
				</c:if>
             </td>               	                         
          </tr>
          <tr>
            <td align="left">Tipo Cliente</td>
            <td align="left">
     			<html:text name="DatosVentaForm" property="glsTipoCliente" style="text-transform: uppercase;" styleId="glsTipoCliente" size="37" readonly="true"/>
            </td>        
	        <td align="left">C&oacute;digo Cliente</td>
            <td align="left">
     			<html:text name="DatosVentaForm" property="codCliente" size="37" styleId="codCliente" readonly="true"/>            
            </td>
          </tr>
          <tr>
            <td align="left" >Clasificaci&oacute;n Crediticia</td>
            <td align="left" >
     			<html:text name="DatosVentaForm" property="codCrediticia" style="text-transform: uppercase;" styleId="codCrediticia"  size="37" readonly="true"/>
            </td>        
	        <td align="left" >Monto Preautorizado</td>
            <td align="left" >
     			<html:text name="DatosVentaForm" property="montoPreAutorizado" styleId="montoPreAutorizado" size="37" readonly="true"/>            
            </td>
          </tr>          
          <!-- P-CSR-11002 JLGN 20-06-2011 
          <tr id="filaFacturaTercero" style="display: none;">
            <td align="left">Factura a nombre de Tercero (*)</td>
			<td align="left">
			  <html:select name="DatosVentaForm" property="facturaTercero" style="width:180px;" styleId="facturaTercero" onchange="ocultarMensajeError();fncActivarDesacBtnDatosTercero(this);" > 
				<html:option value="">- Seleccione -</html:option>
				<html:option value="S">SI</html:option> 
				<html:option value="N">NO</html:option>
	          </html:select>
			</td>
			<td align="left" colspan="2">
           	<html:button  value="DATOS CLIENTE FACTURABLE" style="width:230px;color:black" property="btnDatosTercero" styleId="btnDatosTercero" onclick="fncCursorEspera();ocultarMensajeError();fncDatosTercero()" />				
		    </td>
	    </tr> -->
    
          <tr>
		      <td colspan="4">
		      <HR noshade>
		    </td>
	      </tr>
	      <tr>
	           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
	            Condiciones de Venta:
	           </td>
		  </tr>
		  
          <tr>
          <td colspan="4" >
            <table width="100%">
             <tr>
              <td align="left" width="25%">Tipo de contrato (*)</td>
               <td align="left" colspan="3">
				 <html:select name="DatosVentaForm" property="codTipoContrato" style="width:200px;" styleId="codTipoContrato" onchange="ocultarMensajeError();fncSeleccionaTipoContrato(this);fncObtenerPeriodo();" >
					<html:option value="">- Seleccione -</html:option>
				  </html:select>            
               </td>
             </tr>
	          <tr>
	            <td align="left" >Per&iacute;odo (*)</td>
	            <td align="left" colspan="3">
					<html:select name="DatosVentaForm" property="codPeriodo" style="width:200px;" styleId="codPeriodo" onchange="ocultarMensajeError();fncSeleccionaPeriodo(this);fncObtenerModalidadVenta();" >
						<html:option value="">- Seleccione -</html:option>
					</html:select>            
	            </td>             
	          </tr>
	          <tr>
	            <td align="left" >Modalidad de la venta (*)</td>
	            <td align="left" colspan="3">
					<html:select name="DatosVentaForm" property="codModalidadVenta" style="width:200px;" styleId="codModalidadVenta" onchange="ocultarMensajeError();fncSeleccionaModalidad(this);fncObtenerCuotas();" >
						<html:option value="">- Seleccione -</html:option>
					</html:select>            
	            </td>           
	          </tr>
	        </table>
	      </td>
	      </tr>  
	      
          <tr>
             <td colspan="4"  >
               <div id="divCuotas" style="display:none">  
                 <table width="100%">
                   <tr>
                    <td align="left" width="25%">N&uacute;mero de Cuotas (*)</td>
                    <td align="left" colspan="3" >
				       <html:select name="DatosVentaForm" property="numCuotas" style="width:200px;" styleId="numCuotas" onchange="ocultarMensajeError();fncSeleccionaCuotas(this);" >
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="DatosVentaForm" property="arrayCuotas">
			               <html:optionsCollection property="arrayCuotas" value="codigo" label="descripcion"/>
			          	</logic:notEmpty>					
					    </html:select>            
                   </td>
                  </tr>
                 </table>
               </div>  
              </td>
          <tr>
		    <td colspan="4">
		     <HR noshade>
		    </td>
	      </tr>	      	          
          </table>
        </td>
        </tr>
    
	    <table width="100%">
          
          	
          </table>
     <P>
     <P>
     <P>
     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="50%" >
       <input type="button" name="btnVolver" value="VOLVER AL MENU" onclick="ocultarMensajeError();fncVolver();" style="width:150px;color:black">        
        </td>
        <td width="25%" align="right">
        </td>
        <td width="25%" align="right">
			<html:button  value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="fncCursorEspera();ocultarMensajeError();fncContinuar();"/>        
        </td>
      </tr>
    </TABLE> 
     <P>    
   <TABLE align="center" width="90%">			
      <tr>
		  <td align="left"><i>(*):  Dato es obligatorio</i></td>
	  </tr>	   
   </TABLE>    
</html:form>

</body>
</html:html>