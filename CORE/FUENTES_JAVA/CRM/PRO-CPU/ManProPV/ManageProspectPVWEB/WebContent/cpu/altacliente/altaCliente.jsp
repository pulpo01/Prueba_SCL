<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>

<html>
	<head>
	<base target="_self"></base>
	<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
	<title>Telefónica Móviles</title>
	<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/AltaClienteAJAX.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/DireccionesAJAX.js'></script>
	<script type='text/javascript' src='<%=request.getContextPath()%>/js/controlTimeOut.js' language='JavaScript'></script>
	
	<script>
		
		var listaPlanesTarifarios=new Array();
		var planTarifarioSeleccionado = null;
		
		function raw_popup(src) {
    		var _POPUP_FEATURES = " dialogTop=100px; dialogLeft=100px; dialogWidth=600px;" +
					  		  " dialogHeight=600px; center=yes; status:off; scroll:off "; 
		    var theWindow = window.showModalDialog(src.getAttribute('href'), '_blank', _POPUP_FEATURES);
		}

		function importarProspecto(campoSelect,campoText){
		  if(checkField(campoText,isNotWhitespace,false,"Se requiere ingresar n\u00FAmero de identificaci\u00F3n") ){
		  	prospecto = AltaClienteAJAX.importarProspecto(campoSelect.value,campoText.value,llenarCampos);
		  }
		}
		
		function llenarCampos(prospecto){
		  if (prospecto != null){
		   	var confirmar = confirm(" Se encontro prospecto. ¿Desea importar los datos?")
			if (confirmar){
				$("codigoProspecto").value = prospecto.codigoProspecto;

				if ($("pagina").value == 'pagina1'){ 
					$("primerApellido").value = prospecto.apellido1;
					$("segundoApellido").value = prospecto.apellido2;
					$("nombreCuenta").value = prospecto.nombre;
				}
				else if ($("pagina").value == 'pagina2'){ 
					$("nombreCuenta").value = prospecto.nombre;
				} 
				else if ($("pagina").value == 'pagina3'){ 
					$("banco").value = prospecto.codigoBanco;
					$("tipoTarjeta").value = prospecto.codigoTipotarjeta; 
					$("numeroCuenta").value = prospecto.numeroCuenta;
					$("numeroTarjeta").value = prospecto.numeroTarjeta; 
				}				
			}
		  }
		}
		
		function validarIdentificacionCuenta(){
		  tipoIdent = $("tipoIdentificacionCuenta");
		  numeroIdent = $("numeroIdentificacionCuenta");
		  cuenta = AltaClienteAJAX.getCuentaNumIdent(tipoIdent.value,numeroIdent.value,advertenciaCuenta);
		}
		
		function advertenciaCuenta(cuenta){
			if (cuenta != null){
				alert ("Identificaci\u00F3n ya existe. Debe ingresar otro tipo y n\u00FAmero de identificaci\u00F3n");
				$("numeroIdentificacionCuenta").value = "";
			} else {
			    AltaClienteActionForm.submit();
			}
		}
		

  	    /*function obtieneListaLimitesConsumo() {
  	      var plan = $("planTarifario"); 
  	      if (plan.selectedIndex != 0){
	       arrayLimitesConsumo = AltaClienteAJAX.getListadoLimitesConsumo(plan.value,displayLimitesConsumo);
	      } 
	  	}*/

	  	/*function displayLimitesConsumo(arrayLimitesConsumo){
		  DWRUtil.removeAllOptions("limiteConsumo");
		  DWRUtil.addOptions("limiteConsumo",{'':'-Seleccione-'});
		  DWRUtil.addOptions("limiteConsumo",arrayLimitesConsumo,"codigoLimiteConsumo","descripcionLimiteConsumo");
	  	}*/

  	    function obtieneListaModalidadesPago() {
  	      var modoCancel = $("modalidadCancel");
  	      if (modoCancel.selectedIndex != 0){ 
	       arrayModalidadesPago = AltaClienteAJAX.getListadoModalidadesPago(modoCancel.value,displayModalidadesPago);
	      }else{
		   DWRUtil.removeAllOptions("sistemaPago");
		   DWRUtil.addOptions("sistemaPago",{'':'-Seleccione-'});
	      }
	  	}

	  	function displayModalidadesPago(arrayModalidadesPago){
		  DWRUtil.removeAllOptions("sistemaPago");
		  DWRUtil.addOptions("sistemaPago",{'':'-Seleccione-'});
		  DWRUtil.addOptions("sistemaPago",arrayModalidadesPago,"codigoModalidadPago","descripcionModalidadPago");
	  	  var sistemaPago = $("sistemaPago");
          var valor = $("sistemaPagoSel").value;
	  	  if (valor!=''){
		  	for(index = 0; index<sistemaPago.length; index++) {
	           if(sistemaPago[index].value == valor){
	             sistemaPago.selectedIndex = index;
	             manejarElementosFormasPago();
	           }  
	        }
	  	  }
	  	}
	  	
  	    function obtieneListaSucursales() {
  	      var banco = $("banco");
  	      var sucursal= $("sucursal");
  	      if (banco.selectedIndex != 0 && !sucursal.disabled ){ 
	        arraySucursales = AltaClienteAJAX.getListadoSucursales(banco.value,displaySucursales);
	      }
	  	}

	  	function displaySucursales(arraySucursales){
		  DWRUtil.removeAllOptions("sucursal");
		  DWRUtil.addOptions("sucursal",{'':'-Seleccione-'});
		  DWRUtil.addOptions("sucursal",arraySucursales,"codigoSucursalBanco","descripcionSucursalBanco");
	  	  var sucursal= $("sucursal");
          var valor = $("sucursalSel").value;
	  	  if (valor!=''){
		  	for(index = 0; index<sucursal.length; index++) {
	           if(sucursal[index].value == valor)
	             sucursal.selectedIndex = index;
	        }
	  	  }
	  	}
	  	
  	    function obtieneListaSubCategoriaImpositiva() {
  	      var categoriaImpositiva = $("categoriaImpositiva");
  	      var subCategoriaImpositiva = $("subCategoriaImpositiva");
  	      //if (categoriaImpositiva.selectedIndex != 0 ){
	         arraySubcategorias = AltaClienteAJAX.getSubCategoriasImpositivas(categoriaImpositiva.value,displaySubcategorias);
		  //}		  	
	  	}

	  	function displaySubcategorias(arraySubcategorias){
		  DWRUtil.removeAllOptions("subCategoriaImpositiva");
		  DWRUtil.addOptions("subCategoriaImpositiva",{'':'-Seleccione-'});
		  DWRUtil.addOptions("subCategoriaImpositiva",arraySubcategorias,"codigoSubCategImpos","descripcionSubCategImpos");
	  	  var subcategoria= $("subCategoriaImpositiva");
          var valor = $("subCategoriaImpositivaSel").value;
	  	  if (valor!=''){
		  	for(index = 0; index<subcategoria.length; index++) {
	           if(subcategoria[index].value == valor)
	             subcategoria.selectedIndex = index;
	        }
	  	  }
	  	}

  	    function obtieneListaPlanesTarifarios() {
  	      var tipoPlan = $("tipoPlanTarif");
  	      var planTarifario = $("planTarifario");
  	      var tipoIdent = '<bean:write name="AltaClienteActionForm" property="tipoIdentificacionCliente"/>';
  	      var numIdent  = '<bean:write name="AltaClienteActionForm" property="numeroIdentificacionCliente"/>';
  	      
  	      var activaBolsaDinamica = <bean:write name="AltaClienteActionForm" property="activaBolsaDinamica" />;
  	      
  	      if (activaBolsaDinamica){
  	      	  if (tipoPlan.selectedIndex != 0 && tipoPlan.value=='E'){ 
				  var valorSeleccion = $("seleccionPlanORangoSel").value;
	  	      	  if (valorSeleccion!=''){
	  	      	    if (valorSeleccion == 'P'){
	  	      	      $("capaLabelRango").style.visibility = "hidden";	
				      $("capaValorRango").style.visibility = "hidden";
			        }
			        else {
	  	      	      $("capaLabelRango").style.visibility = "visible";	
				      $("capaValorRango").style.visibility = "visible";	
				      
				      if ( $("planTarifarioSel").value!=''){
				        $("valorRango").disabled = false;
				        $("valorRango").style.background  = "white";
				      } else {
				        $("valorRango").disabled = true;
				        $("valorRango").style.background  = "#e0e0e0";
				      }
				      
			        }
	  	      	    arrayPlanesTarifarios = AltaClienteAJAX.getPlanesTarifariosPorPlanORango(tipoPlan.value,valorSeleccion,tipoIdent,numIdent,displayPlanesTarifarios);
	  	      	  }
  	      	  }
  	      	  else if (tipoPlan.selectedIndex != 0 && tipoPlan.value=='F' ) {
  	      	  		arrayPlanesTarifarios = AltaClienteAJAX.getPlanesTarifariosPorPlanORango(tipoPlan.value,'',tipoIdent,numIdent,displayPlanesTarifarios);
  	      	  }
  	      }
  	      else {
	  	      if (tipoPlan.selectedIndex != 0 && tipoPlan.value!='I' ){
		        arrayPlanesTarifarios = AltaClienteAJAX.getPlanesTarifarios(tipoPlan.value,tipoIdent,numIdent,displayPlanesTarifarios);
			  }
		  }
		  
		  if (tipoPlan.selectedIndex != 0 && tipoPlan.value =='I' ){
		    DWRUtil.removeAllOptions("planTarifario");
	        DWRUtil.addOptions("planTarifario",{'':'-Seleccione-'});
		  }
		  
	  	}


	  	function displayPlanesTarifarios(arrayPlanesTarifarios){
		  listaPlanesTarifarios = arrayPlanesTarifarios;
		  DWRUtil.removeAllOptions("planTarifario");
		  DWRUtil.addOptions("planTarifario",{'':'-Seleccione-'});
		  DWRUtil.addOptions("planTarifario",arrayPlanesTarifarios,"codigoPlanTarifario","descripcionPlanTarifario");
	  	  var plantarif = $("planTarifario");
          
          var valor = $("planTarifarioSel").value;
	  	  if (valor!=''){
		  	for(index = 0; index<plantarif.length; index++) {
	           if(plantarif[index].value == valor){
	             plantarif.selectedIndex = index;
	             setearPlanSeleccionado(valor);
	           }  
	        }
	  	  }
	  	}

     function setearPlanSeleccionado(codigoPlanSelec){
		 var activaBolsaDinamica = <bean:write name="AltaClienteActionForm" property="activaBolsaDinamica" />;
        
		 if (activaBolsaDinamica){        
	        planTarifarioSeleccionado = null;
	        
	        if (listaPlanesTarifarios!=null && listaPlanesTarifarios.length > 0 ) {
	          for(i=0;i<listaPlanesTarifarios.length;i++) {
	 		    if(listaPlanesTarifarios[i].codigoPlanTarifario == codigoPlanSelec){
	 		   	  planTarifarioSeleccionado = listaPlanesTarifarios[i];
	 		   	  $("descripcionPlanTarifario").value = listaPlanesTarifarios[i].descripcionPlanTarifario;
	 		   	  $("tipoPlanTarifSel").value = listaPlanesTarifarios[i].tipoPlanTarifario;
	 		   	  $("codigoCargoBasicoSel").value = listaPlanesTarifarios[i].codigoCargoBasico;
				  $("descripcionCargoBasicoSel").value = listaPlanesTarifarios[i].descripcionCargoBasico;
				  $("importeCargoBasicoSel").value = listaPlanesTarifarios[i].importeCargoBasico;
				  $("importeLimiteSel").value = listaPlanesTarifarios[i].importeLimite;
				  $("importeFinalSel").value = listaPlanesTarifarios[i].impFinal;
	 		   	  $("codigoLimiteConsumoSel").value = listaPlanesTarifarios[i].codigoLimiteConsumo;
	 		   	  $("descripcionLimiteConsumoSel").value = listaPlanesTarifarios[i].descripcionLimiteConsumo;
	 		   	  $("numDiasSel").value = listaPlanesTarifarios[i].numDias;
	 		   	  
	 		   	  $("valorRango").disabled = false;
	 		   	  $("valorRango").style.background  = "white";
	 		    }
	          }
	        }
	     }     
     }
      
      
     function validaMontoCargo(monto) {
		var retorno = false;
	    if (monto!=""){
		  var rangoIni = planTarifarioSeleccionado.importeCargoBasico;
		  var rangoFin = planTarifarioSeleccionado.impFinal;
		  if ( !(monto>=rangoIni && monto<=rangoFin) ){
     		alert("Monto ingresado no corresponde al rango seleccionado");
     		document.getElementById("valorRango").value = "";
     		//$("valorRango").focus();
	        //$("valorRango").select();
		  }
		  else{
		    $("importeCargoBasicoSel").value = monto;
		    retorno = true;
		  }
	    } else {
	      alert("Debe ingresar el monto del cargo");
	      $("valorRango").focus();
	    }
	    return retorno;
     }


	  	function manejoElementosFormClientePantalla1() {
	  		var tipoCliente =  $("tipoCliente");
	  		var segundoApellidoCliente = $("segundoApellido");
	  		
			if (tipoCliente.value!=null){
				if (tipoCliente.value == 'E'){
				 	segundoApellidoCliente.disabled = true;
				 	segundoApellidoCliente.style.background = "#e0e0e0";
				}else if (tipoCliente.value == 'P'){
				 	segundoApellidoCliente.disabled = false;
				 	segundoApellidoCliente.style.background = "white"
				}
			}	  		
	  	}

	  	function manejoElementosFormClientePantalla2 () {
	  		var tipoPlan = $("tipoPlanTarif");
	  		var plan =  $("planTarifario");
	  		var visibilidadCampana = <bean:write name="AltaClienteActionForm" property="visibilidadCampanaVigente" />;
	  		var campana = $("campanaVigente");
	  		var activaBolsaDinamica = <bean:write name="AltaClienteActionForm" property="activaBolsaDinamica" />;
	  		
			if (tipoPlan.value!=null){
				if (tipoPlan.value == 'I'){
				 	plan.disabled =  true;
				 	if  (visibilidadCampana) campana.disabled = true;
				}else {
				 	plan.disabled =  false;
				 	if  (visibilidadCampana) campana.disabled = false;
				}
				
				if ( activaBolsaDinamica ){
					if (tipoPlan.value == 'E'){
					  $("capaLabelSeleccionPlanRango").style.visibility = "visible";	
					  $("capaSeleccionPlanRango").style.visibility = "visible";	
					}else{
					  $("capaLabelSeleccionPlanRango").style.visibility = "hidden";
					  $("capaSeleccionPlanRango").style.visibility = "hidden";
					  $("capaLabelRango").style.visibility = "hidden";
					  $("capaValorRango").style.visibility = "hidden";
					}
					
				   if ($("seleccionPlanORangoSel").value=='' ){
					  $("valorRango").value = '';
					  var seleccionPlanORango = eval('document.AltaClienteActionForm.seleccionPlanORango');
					  seleccionPlanORango[0].checked = false;
					  seleccionPlanORango[1].checked = false;
					}//if
				}//if				    
			}//if	  		
	  	}


	  	function manejoElementosFormClientePantalla3 () {
			var modoCancel = $("modalidadCancel");
			var banco = $("banco");
			var sucursal = $("sucursal");
			var tipoTarjeta = $("tipoTarjeta");
			var numeroCuenta = $("numeroCuenta");
			var numeroTarjeta = $("numeroTarjeta");
			var tipoCuentaBanc = $("tipoCuentaBanc");
			var fechaVencTarjeta = $("fechaVencimientoTarjeta");
			var desactivar =  true;
			
			if ($("sistemaPagoSel").value!='' && modoCancel.value == 'A' ){
			  desactivar = false;
			}
			
            if ( desactivar ){
			 	banco.disabled =  true;
	            banco.selectedIndex = 0;
			 	sucursal.disabled = true;
			 	sucursal.selectedIndex = 0;
			 	tipoTarjeta.disabled = true;
			 	tipoTarjeta.selectedIndex = 0;
			 	numeroCuenta.disabled = true;
			 	numeroCuenta.value = '';
			 	numeroTarjeta.disabled = true;
			 	numeroTarjeta.value = '';
			 	tipoCuentaBanc.disabled = true;
			 	tipoCuentaBanc.selectedIndex = 0;
			 	fechaVencTarjeta.disabled = true;
			 	fechaVencTarjeta.value = '';
			 	numeroCuenta.style.background  = "#e0e0e0";
			 	numeroTarjeta.style.background  = "#e0e0e0";
			 	fechaVencTarjeta.style.background  = "#e0e0e0";
		 	}
	  	}
		
	  	function manejarElementosFormasPago() {
			var modoCancel = $("modalidadCancel");
			var sistemaPago = $("sistemaPago");
			var banco = $("banco");
			var sucursal = $("sucursal");
			var tipoTarjeta = $("tipoTarjeta");
			var numeroCuenta = $("numeroCuenta");
			var numeroTarjeta = $("numeroTarjeta");
			var tipoCuentaBanc = $("tipoCuentaBanc");
			var fechaVencTarjeta = $("fechaVencimientoTarjeta");
			
			if (sistemaPago.value!=null && modoCancel.value!=null && modoCancel.value == 'A' ){
				banco.disabled = false;
				
				if (sistemaPago.value == '3'){ // Cta Cte
				 	sucursal.disabled = false;
				 	numeroCuenta.disabled = false;
				 	numeroCuenta.style.background  = "white";
				 	tipoCuentaBanc.disabled = false;
				 	tipoTarjeta.disabled = true;
				 	tipoTarjeta.selectedIndex = 0
				 	numeroTarjeta.disabled = true;
				 	numeroTarjeta.style.background  = "#e0e0e0";
					numeroTarjeta.value = '';
				 	fechaVencTarjeta.disabled = true;
				 	fechaVencTarjeta.style.background  = "#e0e0e0";
				 	fechaVencTarjeta.value = '';
				}else if (sistemaPago.value == '4') { // Tarjeta Debito
				 	sucursal.disabled = true;
				 	sucursal.selectedIndex = 0;
				 	numeroCuenta.disabled = true;
				 	numeroCuenta.style.background  = "#e0e0e0";
				 	numeroCuenta.value = '';
				 	tipoCuentaBanc.disabled = true;
				 	tipoCuentaBanc.selectedIndex = 0;
				 	tipoTarjeta.disabled = false;
				 	numeroTarjeta.disabled = false;
				 	fechaVencTarjeta.disabled = false;
				 	fechaVencTarjeta.style.background  = "white";
				 	numeroTarjeta.style.background  = "white";
				}
			}	  		
	  }

	   function validarDatosOpcionalesCliente() {
		  var tipoIdentResp2 = $("tipoIdentificacionResponsable2"); 
		  var numIdentResp2 = $("numeroIdentificacionResponsable2");
		  var tipoIdentResp3 = $("tipoIdentificacionResponsable3");
		  var numIdentResp3 = $("numeroIdentificacionResponsable3");
          
          if (  validarIdentificacion(tipoIdentResp2,numIdentResp2) &&
				validarIdentificacion(tipoIdentResp3,numIdentResp3)              
             )  {
            if ($("fechaNacimiento").value!='' && $("fechaNacimiento").value.length!=10  ){
	          alert("La fecha esta incompleta,termine el ingreso");
            } else {
		      AltaClienteActionForm.submit();
		    }   
	      }
	   }
	   
	   function validarDatosObligatoriosCliente() {
		  var pagina =  $("pagina");
		  if( 
		      pagina.value == 'pagina1' &&
		      checkField($("nombreCliente"),isNotWhitespace,false,"Debe ingresar nombre del cliente") &&
		      checkField($("primerApellido"),isNotWhitespace,false,"Debe ingresar primer apellido del cliente") &&
		      checkSelect($("tipoIdentificacionCliente"),"Debe seleccionar tipo de identificacion") &&   
		      checkField($("numeroIdentificacionCliente"),isNotWhitespace,false,"Debe ingresar número de identificacion") &&
		      validarIdentificacion($("tipoIdentificacionApoderado"),$("numeroIdentificacionApoderado"))
	        )
	      { 
			// if ($("tipoCliente").value!=null && $("tipoCliente").value == 'E'){
			   if ( checkField($("cicloFact"),isNotWhitespace,false,"Debe ingresar ciclo de facturación") )
			   {
			      AltaClienteActionForm.submit();
			   } 
			 //}
			 //else {
		       //AltaClienteActionForm.submit();
		    // } 
		  } 
		  else if 
		    (
		  	  pagina.value == 'pagina2'  &&
		  	  checkField($("direccionFacturacion"),isNotWhitespace,false,"Debe ingresar dirección de facturación") &&
		  	  checkField($("direcionPersonal"),isNotWhitespace,false,"Debe ingresar direcci\u00F3n personal") &&
		  	  checkField($("direccionCorrespondencia"),isNotWhitespace,false,"Debe ingresar direcci\u00F3n de correspondencia") &&
		  	  checkSelect($("oficina"),"Debe seleccionar oficina") &&
		  	  checkSelect($("planComercial"),"Debe seleccionar plan comercial") &&
		  	  //checkSelect($("categoriaImpositiva"),"Debe seleccionar categor\u00EDa impositiva") &&
		  	  checkSelect($("categoriaTributaria"),"Debe seleccionar categor\u00EDa tributaria")
		    )
		  {
		     var siguiente = true;
		     var tipoCliente = '<bean:write name="AltaClienteActionForm" property="tipoCliente"/>';

			 if (tipoCliente!='null' && tipoCliente == 'E'){
				   if (!validarIdentificacion($("tipoIdentificacionTrib"),$("numeroIdentificacionTrib")) )  { 
			   		   siguiente = false;
			       }
			 }
			 
			 if (siguiente){ 
			     var tipoPlan = $("tipoPlanTarif");
				 var cicloFacturacion = '<bean:write name="AltaClienteActionForm" property="cicloFact"/>';
				 var selPlanORango  = document.getElementById("seleccionPlanORangoSel").value;
				 
				 //if (!tipoPlan.disabled &&  tipoPlan.selectedIndex != 0 && (tipoPlan.value=='F' || tipoPlan.value=='E')   ){
					 //if ( checkField($("seleccionPlanORangoSel"),isNotWhitespace,false,"Debe ingresar plan o rango")  )
					 if ( tipoPlan.value=='F' || tipoPlan.value=='E'){
					 	if (selPlanORango==''){
					 		alert("Debe seleccionar plan o rango");
					   		siguiente = false;
					   	}else{
							   if ( checkField($("planTarifario"),isNotWhitespace,false,"Debe ingresar plan tarifario")  )
						   	   { 
						   		 if (cicloFacturacion==''){
						   		   alert("Debe ingresar Ciclo de Facturación en la primera pantalla \n pues su tipo de plan seleccionado es Empresa o Familiar");
						   		   siguiente = false;
						   		 }
						   		 if (siguiente){
						   		   var activaBolsaDinamica = <bean:write name="AltaClienteActionForm" property="activaBolsaDinamica" />;
						   		   if ( tipoPlan.value=='E' && activaBolsaDinamica && $("seleccionPlanORangoSel").value=='R'  ){
								   	 if (validaMontoCargo($("valorRango").value) ) AltaClienteActionForm.submit();
						   		   }
						   		   else {
							   		 document.getElementById("categoriaImpositiva").disabled=false ;
						   		     AltaClienteActionForm.submit();
						   		   }  
						   		 }
						       }
					     }//fin else (selPlanORango=='')
				     }
				     else{
					     document.getElementById("categoriaImpositiva").disabled=false ;
					     AltaClienteActionForm.submit();
				     }
			     /*}
			     else{
			         AltaClienteActionForm.submit();
			     }*/
	         }	       
		  }   
		  else if  ( pagina.value == 'pagina3' )
		  {
			 var continuar = true;
			 if ($("modalidadCancel").value!=null && $("modalidadCancel").value == 'A'){
			   if (!checkSelect($("sistemaPago"),"Debe seleccionar sistema de pago") || !checkSelect($("banco"),"Debe seleccionar banco") )
			   {
			      continuar = false;
			   }
			   if ($("fechaVencimientoTarjeta").value!='' && $("fechaVencimientoTarjeta").value.length!=10  ){
			      alert("La fecha esta incompleta,termine el ingreso");
			      continuar = false; 
			   }
			 }

			 if 
			    (
			  	  continuar   &&
			  	  checkSelect($("tipoIdentificacionResponsable1"),"Debe seleccionar tipo de identificación del responsable") &&
			      checkField($("numeroIdentificacionResponsable1"),isNotWhitespace,false,"Debe ingresar número de identificacion del responsable") && 
			      checkField($("nombreResponsable1"),isNotWhitespace,false,"Debe ingresar nombre de responsable") 
			      
			    )
			  {
			  	 var codigoCuenta = '<bean:write name="AltaClienteActionForm" property="codigoCuenta"/>';
			  	 var descripcionCuenta = '<bean:write name="AltaClienteActionForm" property="descripcionCuenta"/>';
			  	 if (codigoCuenta=='null'){
			  	 	if ( isNotWhitespace(descripcionCuenta) ){
			  	 	  AltaClienteActionForm.submit();
			  	 	}
			  	 	else{
			  	 	  alert ('Debe ingresar datos de cuenta'); 
			  	 	  window.status = 'Debe ingresar datos de cuenta';
			  	 	}
			  	 }
			  	 else{
			  	 	AltaClienteActionForm.submit();
			  	 }
			  }   

		  }   
	   }
	   
	   
	   function validarDatosObligatoriosCuenta() {
		  if( 
		     checkField($("descripcionCuenta"),isNotWhitespace,false,"Debe ingresar descripción de la cuenta") &&
		     checkField($("nombreCuenta"),isNotWhitespace,false,"Debe ingresar nombre de la cuenta") &&
		     checkSelect($("tipoIdentificacionCuenta"),"Debe seleccionar tipo de identificacion") &&   
		     checkField($("numeroIdentificacionCuenta"),isNotWhitespace,false,"Debe ingresar número de identificacion") &&
		     checkField($("direccionCuenta"),isNotWhitespace,false,"Debe ingresar direccion de la cuenta") 
	        )
	      { 
	        if ($("fechaNacimientoCuenta").value!='' && $("fechaNacimientoCuenta").value.length!=10  ){
	          alert("La fecha esta incompleta,termine el ingreso");
            } else {
		      validarIdentificacionCuenta();
		    }  
		  }    
	   }
	   
	   function validarIdentificacion(tipoIdent,numIdent){
		  var retorno =  true;
		  if ( tipoIdent.selectedIndex != 0 && checkField(numIdent,isWhitespace,true) ){ 
		  	alert ("Debe ingresar "+numIdent.title);
		  	retorno = false;
		  } else if ( checkField(numIdent,isNotWhitespace,false) && tipoIdent.selectedIndex == 0 ) {
		  	alert ("Debe ingresar "+tipoIdent.title);
		  	retorno = false;
	      }
	   	 return retorno;
	   }

	   function submitDirecciones(tipoDir)
	   {
		  $("accion").value = 'direcciones';
		  $("tipoDireccion").value = tipoDir;
		  if (tipoDir == '1'){
			$("codigoDireccion").value = $("codigoDirFacturacion").value;
		  }
		  if (tipoDir == '2'){
			$("codigoDireccion").value = $("codigoDirPersonal").value;
		  }
		  if (tipoDir == '3'){
			$("codigoDireccion").value = $("codigoDirCorrespondencia").value;
		  }
		  if (tipoDir == '4'){
			$("codigoDireccion").value = $("codigoDirCuenta").value;
		  }
		  var sw = '1';
		  var vdireccionFacturacion = $("codigoDirFacturacion").value;
  		  var vdireccionPersonal = $("codigoDirPersonal").value;
		  var vdireccionCorrespondencia = $("codigoDirCorrespondencia").value;
		  var vdireccionCuenta = $("codigoDirCuenta").value;
		  if (tipoDir == 1 && (vdireccionFacturacion == '' || vdireccionFacturacion == 'null')){
		  	if (vdireccionPersonal != '' && vdireccionPersonal != 'null'){
		  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Facturaci\u00F3n?");
				if (confirmar){
					$("direccionFacturacion").value = $("direcionPersonal").value;
					sw = '0';
					setDireccion(vdireccionPersonal,1,$("direccionFacturacion").value);
				}
				else{
					if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
				  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como de Facturaci\u00F3n?");
						if (confirmar){
							$("direccionFacturacion").value = $("direccionCorrespondencia").value;
							sw = '0';
							setDireccion(vdireccionCorrespondencia,1,$("direccionFacturacion").value);
							
						}
			  		}
				}
		  	}
		  	else{
		  		if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
		  			var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como de Facturaci\u00F3n?")
					if (confirmar){
						$("direccionFacturacion").value = $("direccionCorrespondencia").value;		
						sw = '0';	
						setDireccion(vdireccionCorrespondencia,1,$("direccionFacturacion").value);
					}
		  		}
		  	}
		  }
		  
		  else if (tipoDir == 2 && (vdireccionPersonal == '' || vdireccionPersonal == 'null')){
		  	if (vdireccionFacturacion != '' && vdireccionFacturacion != 'null'){
		  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Facturaci\u00F3n como Personal?")
				if (confirmar){
				    $("direcionPersonal").value = $("direccionFacturacion").value;
				    sw = '0';
					setDireccion(vdireccionFacturacion,2,$("direcionPersonal").value);
				}
				else{
					if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
				  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como Personal?")
						if (confirmar){
						 	$("direcionPersonal").value = $("direccionCorrespondencia").value;
						 	sw = '0';
						    setDireccion(vdireccionCorrespondencia,2,$("direcionPersonal").value);
						}
			  		}
				}
		  	}
		  	else{
		  		if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
		  			var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia como Personal?")
					if (confirmar){
						$("direcionPersonal").value = $("direccionCorrespondencia").value;
						sw = '0';
						setDireccion(vdireccionCorrespondencia,2,$("direcionPersonal").value);
					}
		  		}
		  	}
		  }	
		  else if (tipoDir == 3 && (vdireccionCorrespondencia == '' || vdireccionCorrespondencia == 'null')){
		  	if (vdireccionFacturacion != '' && vdireccionFacturacion != 'null'){
		  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Facturaci\u00F3n como de Correspondencia?");
				if (confirmar){
					$("direccionCorrespondencia").value = $("direccionFacturacion").value;
					sw = '0';
					setDireccion(vdireccionFacturacion,3,$("direccionCorrespondencia").value);
				}
				else{
					if (vdireccionPersonal != '' && vdireccionPersonal != 'null'){
				  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Correspondencia?");
						if (confirmar){
							$("direccionCorrespondencia").value = $("direcionPersonal").value;
							sw = '0';
							setDireccion(vdireccionPersonal,3,$("direccionCorrespondencia").value);
						}
			  		}
				}
		  	}
		  	else{
		  		if (vdireccionPersonal != '' && vdireccionPersonal != 'null'){
		  			var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal como de Correspondencia?")
					if (confirmar){
						$("direccionCorrespondencia").value = $("direcionPersonal").value;
						sw = '0';
						setDireccion(vdireccionPersonal,3,$("direccionCorrespondencia").value);
					}
		  		}
		  	}
		  }
		  
		   else if (tipoDir == 4 && (vdireccionCuenta == '' || vdireccionCuenta == 'null')){
		  	if (vdireccionFacturacion != '' && vdireccionFacturacion != 'null'){
		  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Facturaci\u00F3n del Cliente como de la Cuenta?");
				if (confirmar){
					$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direccionFacturacion"/>';
					sw = '0';
					setDireccion(vdireccionFacturacion,4,$("direccionCuenta").value);
				}
				else{
					if (vdireccionPersonal != '' && vdireccionPersonal != 'null'){
				  		var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal del Cliente como de la Cuenta?");
						if (confirmar){
							$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direcionPersonal"/>';
							sw = '0';
							setDireccion(vdireccionPersonal,4,$("direccionCuenta").value);
						}
						else{
							if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
			  					var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia del Cliente como de la Cuenta?")
								if (confirmar){
									$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direccionCorrespondencia"/>'; 
									sw = '0';
									setDireccion(vdireccionCorrespondencia,4,$("direccionCuenta").value);
								}
			  				}
						}
			  		}
			  		
				}
		  	}
		  	else{
		  		if (vdireccionPersonal != '' && vdireccionPersonal != 'null'){
		  			var confirmar = confirm("Desea ingresar la Direcci\u00F3n Personal del Cliente como de la Cuenta?")
					if (confirmar){
						$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direcionPersonal"/>';
						sw = '0';
						setDireccion(vdireccionPersonal,4,$("direccionCuenta").value);
					}
					else{
						if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
		  					var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia del Cliente como de la Cuenta?")
							if (confirmar){
								$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direccionCorrespondencia"/>';
								sw = '0';
								setDireccion(vdireccionCorrespondencia,4,$("direccionCuenta").value);
							}
		  				}
					}
		  		}
		  		else{
		  			if (vdireccionCorrespondencia != '' && vdireccionCorrespondencia != 'null'){
	  					var confirmar = confirm("Desea ingresar la Direcci\u00F3n de Correspondencia del Cliente como de la Cuenta?")
						if (confirmar){
							$("direccionCuenta").value = '<bean:write name="AltaClienteActionForm" property="direccionCorrespondencia"/>';
							sw = '0';
							setDireccion(vdireccionCorrespondencia,4,$("direccionCuenta").value);
						}
	  				}
		  		}
		  	}
		  }
		  if (sw == '1'){
		  	AltaClienteActionForm.submit();
		  }
	   }
		function setDireccion(codigoDireccion,tipo,descripcionDir){
		  direccion = DireccionesAJAX.setDireccionCopia(codigoDireccion,tipo,descripcionDir,setNuevaDireccion);
		}
		
		function setNuevaDireccion(direccion){
			if (direccion != null){
				if (direccion.tipoDireccion == '1'){
					$("codigoDirFacturacion").value = direccion.codigo;
				}
				if (direccion.tipoDireccion == '2'){
					$("codigoDirPersonal").value = direccion.codigo;
				}
				if (direccion.tipoDireccion == '3'){
					$("codigoDirCorrespondencia").value = direccion.codigo;
				}
				if (direccion.tipoDireccion == '4'){
					$("codigoDirCuenta").value = direccion.codigo;
				}

			}
		}
		function submitCuentas()
		{
			$("accion").value = 'cuentas';
			AltaClienteActionForm.submit();
		}
	   
	   function enviarDatosOpener(){
		 var arrayResultado =new Array();
         
         // Objeto Cliente
	     cliente = new Object();
	     cliente.codigoCliente = $("codigoClienteCreado").value;   
	     cliente.nombreCliente = '<bean:write name="AltaClienteActionForm" property="nombreCliente"/>';
	     cliente.primerApellido = '<bean:write name="AltaClienteActionForm" property="primerApellido"/>';
	     cliente.segundoApellido = '<bean:write name="AltaClienteActionForm" property="segundoApellido"/>';	     
	  	 cliente.codigoTipoIdentificacion = '<bean:write name="AltaClienteActionForm" property="tipoIdentificacionCliente"/>';
	  	 cliente.numeroIdentificacion = '<bean:write name="AltaClienteActionForm" property="numeroIdentificacionCliente"/>';
	  	 cliente.cicloFacturacion = '<bean:write name="AltaClienteActionForm" property="cicloFact"/>';
	  	 cliente.tipoPlanTarifario = $("tipoPlanTarifSel").value;
	  	 cliente.codigoPlanTarifario = '<bean:write name="AltaClienteActionForm" property="planTarifario"/>';
	  	 cliente.codigoEmpresa = $("codigoEmpresaCreado").value; 
	  	 arrayResultado[0]= cliente;
	  	 
	  	 //opener.actualizarClienteDestino(codigoCliente,nombreCliente,primerApellido,segundoApellido,codigoTipoIdentificacion,numeroIdentificacion,cicloFacturacion,tipoPlanTarifario,codigoPlanTarifario,codigoEmpresa);	  	 
		
		 // Objeto PlanTarifario
		 if (cliente.tipoPlanTarifario == 'E'){
		  	 planTarifario = new Object();
		  	 planTarifario.montoCargo = '<bean:write name="AltaClienteActionForm" property="valorRango"/>' ;
		  	 planTarifario.descripcionPlanTarifario = $("descripcionPlanTarifario").value;
		  	 planTarifario.codigoCargoBasico = $("codigoCargoBasicoSel").value; 
		  	 planTarifario.descripcionCargoBasico = $("descripcionCargoBasicoSel").value; 
			 planTarifario.importeCargoBasico = $("importeCargoBasicoSel").value;
			 planTarifario.importeLimite = $("importeLimiteSel").value; 
			 planTarifario.importeFinal =  $("importeFinalSel").value; 
			 planTarifario.codigoLimiteConsumo = $("codigoLimiteConsumoSel").value; 
			 planTarifario.descripcionLimiteConsumo = $("descripcionLimiteConsumoSel").value; 
			 planTarifario.numDias = $("numDiasSel").value; 
		     arrayResultado[1]= planTarifario;	 
		  	 //opener.actualizarPlanTarifario(codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias);
		 }	
		 	  	 
		 
		 
		 window.returnValue = arrayResultado;  	  	 
	     window.close();
	   }
	      
	</script>
	</head>


<body>
    <html:form action="AltaClienteAction.do">
    <html:hidden property="accion"/>
    <html:hidden property="pagina"/>
    <html:hidden property="codigoProspecto" />
    <html:hidden property="codigoDirFacturacion" />
    <html:hidden property="codigoDirPersonal" />
    <html:hidden property="codigoDirCorrespondencia" />
    <html:hidden property="codigoDirCuenta" />
	
	<input type="hidden" name="tipoDireccion" />
	<input type="hidden" name="codigoDireccion" />	
	<input type="hidden" name="nombreClienteDir" />	
	<input type="hidden" name="numIdentClienteDir" />
	<input type="hidden" name="primerApellidoClienteDir" />	
	
	<input type="hidden" name="segundoApellidoClienteDir" />	
	
	<input type="hidden" name="sistemaPagoSel" value="<bean:write name="AltaClienteActionForm" property="sistemaPago"/>" />
	<input type="hidden" name="sucursalSel" value="<bean:write name="AltaClienteActionForm" property="sucursal"/>" />
    <input type="hidden" name="subCategoriaImpositivaSel" value="<bean:write name="AltaClienteActionForm" property="subCategoriaImpositiva"/>" />
    <input type="hidden" name="planTarifarioSel" value="<bean:write name="AltaClienteActionForm" property="planTarifario"/>" />
    <input type="hidden" name="seleccionPlanORangoSel" value="<bean:write name="AltaClienteActionForm" property="seleccionPlanORango"/>" />
        
    <!--Valores devueltos a la pagina de CPU -->
    <html:hidden property="descripcionPlanTarifario"/>
	<html:hidden property="codigoLimiteConsumoSel"/>
	<html:hidden property="tipoPlanTarifSel" />
	<html:hidden property="codigoCargoBasicoSel"/>
	<html:hidden property="descripcionCargoBasicoSel"/>
	<html:hidden property="importeCargoBasicoSel"/>
	<html:hidden property="descripcionLimiteConsumoSel"/>
	<html:hidden property="importeLimiteSel"/>
   	<html:hidden property="importeFinalSel"/>
    <html:hidden property="numDiasSel"/>

    
      <table width="80%">
        <tr>
         <td class="textoTitulo">
              <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
              <div id="divTitulo" >Creación de Clientes&nbsp;</div> 
         </td>   
        </tr>
      </table>
	  <P>
	  <P>
	 <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina1">     
		<logic:equal name="AltaClienteActionForm" property="visibilidadCobranza" value="true">    
		      <TABLE align="center" width="90%" border=0>
		        <tr>
		          <td width="26%">
		  			Nivel de Facturaci&oacute;n        
				  </td>
		          <td width="24%">
		          	<html:text name="AltaClienteActionForm" property="nivelFact" style="text-transform: uppercase;"  onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="20" maxlength="20"/>
		          </td>
		          <td width="25%">
		  			Indicador Morosidad       
				  </td>
		          <td width="25%">
		          	<html:text name="AltaClienteActionForm" property="morosidad" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="20" maxlength="20"/>
				  </td>
		        </tr>
			  </TABLE>	
		  </logic:equal>

     <TABLE align="center" width="90%">
        <tr>
          <td width="26%">
  			 Tipo de Cliente 
  		  </td>
          <td colspan="3" width="74%">
			  <html:select name="AltaClienteActionForm" property="tipoCliente" style="width:200px;" onchange="manejoElementosFormClientePantalla1()">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTipoCliente">
	              <html:optionsCollection property="arrayTipoCliente" value="codigoTipoCliente" label="tipoCliente"/>
	          	</logic:notEmpty>
	          </html:select>
	          <script>
			 	   $("tipoCliente").disabled = <bean:write name="AltaClienteActionForm" property="desactivarTipoCliente"/> ;
              </script>
          </td>
        </tr>
        <tr>
          <td  width="26%">
  			Nombre* 
		  </td>
          <td colspan="3" width="74%">
          	<html:text name="AltaClienteActionForm" property="nombreCliente" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td width="26%">
  			 Primer Apellido* 
  		  </td>
          <td colspan="3" width="74%">
          	<html:text name="AltaClienteActionForm" property="primerApellido" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td width="26%">
  			Segundo Apellido        
		  </td>
          <td colspan="3" width="74%">
          	<html:text name="AltaClienteActionForm" property="segundoApellido" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
     
        <tr>
          <td width="26%">
  			 Tipo Identificación*        
		  </td>
          <td width="32%">
			  <html:select name="AltaClienteActionForm" property="tipoIdentificacionCliente" style="width:200px;" >
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          	  <script>
				$("tipoIdentificacionCliente").disabled = <bean:write name="AltaClienteActionForm" property="restriccionIdentCliente"/> ;
	          </script>
          </td>
          
          <td width="21%">
  			 N&uacute;m. Identif.*        
		  </td>
          <td width="21%">
         	  <html:text name="AltaClienteActionForm" property="numeroIdentificacionCliente" size="37" maxlength="20" onkeyup="upperCase(this);"  />
          	  <script>
				$("numeroIdentificacionCliente").disabled = <bean:write name="AltaClienteActionForm" property="restriccionIdentCliente"/> ;
				$("numeroIdentificacionCliente").style.background = "#e0e0e0";
	          </script>
		  </td>
        </tr>
        <tr>
          <td width="26%">
  			Ciclo de Facturaci&oacute;n        
		  </td>
          <td width="32%">
			  <html:select name="AltaClienteActionForm" property="cicloFact" style="width:200px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCicloFact">
	              <html:optionsCollection property="arrayCicloFact" value="codigoCicloFacturacion" label="descripcionCiclo"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td width="21%">
  			Categor&iacute;a del Cliente        
		  </td>
          <td width="21%">
			  <html:select name="AltaClienteActionForm" property="categoriaCliente" style="width:200px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCategoriaCliente">
	              <html:optionsCollection property="arrayCategoriaCliente" value="codigoCategoria" label="descripcionCategoria"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
        </tr>
        <tr>
          <td width="26%">
  			Tel&eacute;fono
		  </td>
          <td width="32%">
			<html:text name="AltaClienteActionForm" property="telefono" style="text-transform: uppercase;" onkeyup="upperCase(this);" size="37" maxlength="15" onkeypress="onlyInteger();"/>
          </td>
          <td colspan="2" width="42%">
	      </td>
        </tr>
        <tr>
          <td width="26%">  
          Idioma
          </td>
          <td width="32%">
			  <html:select disabled="true" name="AltaClienteActionForm" property="idioma" style="width:200px;" >
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdioma">
	              <html:optionsCollection property="arrayIdioma" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td colspan="2" width="42%">
	      </td>
        </tr>
	    <tr>
	      <td colspan="4">
	      <HR noshade>
	    </td>
        </tr>
	    <tr>
           <td colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
            Apoderado del Cliente:
           </td>
	    </tr>
        <tr>
          <td width="26%">
  			Tipo Identificaci&oacute;n        
		  </td>
          <td width="32%">
			  <html:select name="AltaClienteActionForm" property="tipoIdentificacionApoderado" style="width:200px;" title="Tipo de Identificación del Apoderado">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td width="21%">
  			N&uacute;m. Identif.        
		  </td>
          <td width="21%">
       		<html:text name="AltaClienteActionForm" property="numeroIdentificacionApoderado" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="37" maxlength="20" title="Numero de Identificacion del Apoderado" />
		  </td>
        </tr>
        <tr>
          <td width="26%">
               Nombre
          </td>
          <td colspan="3" width="74%">
         	    <html:text name="AltaClienteActionForm" property="nombreApoderado"  style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
	</table>
	<script>
		manejoElementosFormClientePantalla1();	
	</script>
     <P>
     <P>
     <P>
     <P>
     <P>
   </logic:equal> 
    <!--Fin pagina 1-->	
   
    <!--Inicio pagina 2-->  
   <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina2">
   <input type="hidden" name="tipoCliente" value="<bean:write name="AltaClienteActionForm" property="tipoCliente"/>"/>	
     
     <TABLE align="center" width="90%" border="0" >
        <tr>
          <td width="26%">
          <a href="javascript:submitDirecciones('1')"><FONT color="#0000ff">Direcci&oacute;n de Facturaci&oacute;n</FONT></a>
  		  </td>
          <td colspan="3" width="74%">
            <html:text name="AltaClienteActionForm" property="direccionFacturacion" style="text-transform:uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" readonly="true" size="80" maxlength="80"/>
          </td>
        </tr>
        
        <tr>
          <td width="26%">
            <a href="javascript:submitDirecciones('2')"><FONT color="#0000ff">Direcci&oacute;n Personal</FONT></a>
 		  </td>
          <td colspan="3" width="74%">
           <html:text name="AltaClienteActionForm" property="direcionPersonal" style="text-transform: uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="80" readonly="true" maxlength="80" />
          </td>
        </tr>
        
        <tr>
          <td width="26%">
  		    <a href="javascript:submitDirecciones('3')"><FONT color="#0000ff">Direcci&oacute;n de Correspondencia</FONT></a>
  		  </td>
          <td colspan="3" width="74%">
          	<html:text name="AltaClienteActionForm" property="direccionCorrespondencia" style="text-transform: uppercase;background-color:#e0e0e0" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="80" readonly="true" maxlength="80" />
          </td>
        </tr>
	
	</TABLE>
	
	<TABLE align="center" width="90%" border="0" >
         <tr>
	          <td width="10%">
	  			Oficina
			  </td>
	          <td width="40%">
				  <html:select name="AltaClienteActionForm" property="oficina" style="width:260px;">
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="AltaClienteActionForm" property="arrayOficina">
		              <html:optionsCollection property="arrayOficina" value="codigoOficina" label="descripcionOficina"/>
		          	</logic:notEmpty>
		          </html:select>
	          </td>
	          <td width="10%">
	  			 Plan Comercial*        
			  </td>
	          <td width="40%">
				  <html:select name="AltaClienteActionForm" property="planComercial" style="width:260px;">
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="AltaClienteActionForm" property="arrayPlanComercial">
		              <html:optionsCollection property="arrayPlanComercial" value="codigoPlanComercial" label="descripcionPlanComercial"/>
		          	</logic:notEmpty>
		          </html:select>
	          </td>
	     </tr>
	        
	     <tr>
	          <td>  
	          Tipo de identificación Tributaria
	          </td>
	          <td>
				 <html:select name="AltaClienteActionForm" property="tipoIdentificacionTrib" style="width:260px;"  title="Tipo de Identificación Tributaria" > 
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
		              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
		          	</logic:notEmpty>
	             </html:select>
				 <script>
				 	$("tipoIdentificacionTrib").disabled = <bean:write name="AltaClienteActionForm" property="restriccionIdentTrib"/> ;
	             </script>
	          </td>
	          <td>
				No. de identificación Tributaria 
			  </td>
	          <td>
				<html:text name="AltaClienteActionForm" property="numeroIdentificacionTrib" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="40" maxlength="40" title="Número de Identificación Tributaria"  />	      	
				<script>
				 	var restricccionTrib = <bean:write name="AltaClienteActionForm" property="restriccionIdentTrib"/>;
				 	$("numeroIdentificacionTrib").disabled = restricccionTrib;
				 	var colorNumeroIdent =  restricccionTrib?'#e0e0e0':'white';
				 	$("numeroIdentificacionTrib").style.background = colorNumeroIdent;
	            </script>
	          </td>
	   </tr>
       
       <tr>
          <td>  
          Categoría Impositiva
          </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="categoriaImpositiva" style="width:260px;" onchange="subCategoriaImpositivaSel.value='';obtieneListaSubCategoriaImpositiva();" disabled="true">
			    <!--<html:option value="">- Seleccione -</html:option>-->
			    <html:option value ="1" >GRAVADO</html:option>	
			   <!--  
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCategImpos">
	              <html:optionsCollection property="arrayCategImpos" value="codigoCategImpos" label="descripcionCategImpos"/>
	          	</logic:notEmpty>
	          	-->
	          </html:select>
          </td>
          <td> 
            Subcategoría Impositiva
          </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="subCategoriaImpositiva" style="width:260px;">
    	          <html:option value="">- Seleccione -</html:option>
    	      </html:select>
          </td>
       </tr>

       <tr>
          <td>
  			Categor&iacute;a Tributaria
		  </td>

          <td>
			  <html:select name="AltaClienteActionForm" property="categoriaTributaria" style="width:260px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCategTrib">
	              <html:optionsCollection property="arrayCategTrib" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td>
  			Con Facturaci&oacute;n        
		  </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="registroFacturacion" style="width:260px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayRegFact">
	              <html:optionsCollection property="arrayRegFact" value="codigoIndicadorFacturable" label="descripcionIndicadorFacturable"/>
	          	</logic:notEmpty>
	          </html:select>
	          <script>
			 	   $("registroFacturacion").disabled = <bean:write name="AltaClienteActionForm" property="desactivarRegistroFacturacion"/> ;
              </script>
          </td>
	    </tr>
	    
	    <tr>
	        <td>
	            Tipo de Plan
			</td>
	        <td>
				  <html:select name="AltaClienteActionForm" property="tipoPlanTarif" style="width:260px;" onchange="manejoElementosFormClientePantalla2();planTarifarioSel.value='';seleccionPlanORangoSel.value='';obtieneListaPlanesTarifarios()">
				  	<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTipoPlanTarif">
		              <html:optionsCollection property="arrayTipoPlanTarif" value="codigoPlanTarifario" label="descripcionPlanTarifario"/>
		          	</logic:notEmpty>
		          </html:select>
		          <script>
			 	   $("tipoPlanTarif").disabled = <bean:write name="AltaClienteActionForm" property="desactivarTipoPlan"/> ;
                  </script>
	        </td>
	          
	        <td id="capaLabelSeleccionPlanRango" style="visibility:hidden" align="left">
	  			Seleccion        
			</td>
	        <td id="capaSeleccionPlanRango" style="visibility:hidden" align="left">
	           <label>
	             <html:radio onclick="seleccionPlanORangoSel.value='P';planTarifarioSel.value='';valorRango.value='';obtieneListaPlanesTarifarios();" name="AltaClienteActionForm" property="seleccionPlanORango" value="P"/>Plan
	           </label>
	             <html:radio onclick="seleccionPlanORangoSel.value='R';planTarifarioSel.value='';valorRango.value='';obtieneListaPlanesTarifarios();" name="AltaClienteActionForm" property="seleccionPlanORango" value="R"/>Rango
	           <label>
	           </label>
	        </td>
	  </tr>
	  <tr>
	    <td>
	        Plan tarifario
		</td>
		<td>
		    <html:select name="AltaClienteActionForm" property="planTarifario" style="width:260px;" onchange="setearPlanSeleccionado(this.value)">
		  	  <html:option value="">- Seleccione -</html:option>
            </html:select>
            <script>
			   $("planTarifario").disabled = <bean:write name="AltaClienteActionForm" property="desactivarPlanTarifario"/> ;
            </script>
            
		</td>
        <td id="capaLabelRango" style="visibility:hidden"  align="left">
        Monto	Cargo</td>
        <td id="capaValorRango" style="visibility:hidden"  align="left">
            <html:text name="AltaClienteActionForm" property="valorRango" size="40" maxlength="40" onkeypress="onlyInteger();" onblur="validaMontoCargo(this.value);"/>
        </td>
        <script>
          var activaBolsaDinamica = <bean:write name="AltaClienteActionForm" property="activaBolsaDinamica" />;
          if ( !($("tipoPlanTarif").disabled) &&  
                $("tipoPlanTarif").value == 'E' &&
  	            activaBolsaDinamica
             ){
           	  $("capaLabelSeleccionPlanRango").style.visibility = "visible";	
			  $("capaSeleccionPlanRango").style.visibility = "visible";	
			  $("capaLabelRango").style.visibility = "visible";	
			  $("capaValorRango").style.visibility = "visible";	
          }
          
        </script>
	  </tr>
	  
      <logic:equal name="AltaClienteActionForm" property="visibilidadCampanaVigente" value="true">
        <tr>
          <td>
	            Campa&ntilde;as vigentes 
		  </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="campanaVigente" style="width:200px;">
			   	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCampanaVigente">
	              <html:optionsCollection property="arrayCampanaVigente" value="codigoCampanasVigentes" label="descripcionCampanasVigentes"/>
	          	</logic:notEmpty>
	          </html:select>
			  <!-- <html:select name="AltaClienteActionForm" property="limiteConsumo" style="width:200px;">
	          	<html:option value="">- Seleccione -</html:option>
	          </html:select>-->
          </td>
          <td>
		  </td>
          <td>
          </td>
        </tr>
      </logic:equal>  
     </TABLE>
     <script>
        obtieneListaSubCategoriaImpositiva();
		var desactivarPlanTarif = <bean:write name="AltaClienteActionForm" property="desactivarPlanTarifario"/> ;
		if (!desactivarPlanTarif){
		    obtieneListaPlanesTarifarios(); 
		    manejoElementosFormClientePantalla2();
		}        
     </script>
     <P>
     <P>
     <P>
     </logic:equal>
	 
	 <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina3">
     <TABLE align="center" width="90%">
        <tr>
          <td width="58%">
  			 La manera en que el cliente desea cancelar sus cuentas es 
  		  </td>
          <td width="42%">
			  <html:select name="AltaClienteActionForm" property="modalidadCancel" style="width:400px;" onchange="sistemaPagoSel.value='';manejoElementosFormClientePantalla3();obtieneListaModalidadesPago();" >
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayModalidadCancel">
	              <html:optionsCollection property="arrayModalidadCancel" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
	          </html:select>
			 <script>
			 	$("modalidadCancel").disabled = <bean:write name="AltaClienteActionForm" property="restriccionModalidadCancel"/> ;
              </script>
          </td>
        </tr>
        
        <tr>
          <td width="58%">
  			 Sistema de pago
  		  </td>
          <td width="42%">
			  <html:select name="AltaClienteActionForm" property="sistemaPago" style="width:400px;" onchange="manejarElementosFormasPago();" >
	              <html:option value="">- Seleccione -</html:option>
	          </html:select>
          </td>
        </tr>
	</TABLE>

	<P><P>	
    <TABLE align="center" width="90%" border=0>
        <tr>
          <td width="26%">
  			Banco        
		  </td>
          <td width="32%">
			  <html:select name="AltaClienteActionForm" property="banco" style="width:200px;" onchange="sucursalSel.value='';obtieneListaSucursales();">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayBanco">
	              <html:optionsCollection property="arrayBanco" value="codigoBanco" label="descripcionBanco"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td colspan ="2" width="42%">
		  </td>
        </tr>
        
        <tr>
          <td width="26%">
  			Sucursal        
		  </td>
          <td width="32%">
			 <html:select name="AltaClienteActionForm" property="sucursal" style="width:200px;">
	         	<html:option value="">- Seleccione -</html:option>
	         </html:select>
          </td>
          <td width="21%">
  			Tipo Tarjeta       
 		  </td>
          <td width="21%">
			  <html:select name="AltaClienteActionForm" property="tipoTarjeta" style="width:200px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTiposTarjeta">
	              <html:optionsCollection property="arrayTiposTarjeta" value="codigoTarjeta" label="descripcionTarjeta"/>
	          	</logic:notEmpty>
	          </html:select>
		  </td>
        </tr>

        <tr>
          <td width="26%">
  			N&ordm; cuenta        
		  </td>
          <td width="32%">
          	<html:text name="AltaClienteActionForm" property="numeroCuenta" size="37" maxlength="18" />
          </td>
          <td width="21%">
  			N&ordm; tarjeta 
		  </td>
          <td width="21%">
          	<html:text name="AltaClienteActionForm" property="numeroTarjeta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="37" maxlength="18" />
		  </td>
        </tr>

        <tr>
          <td width="26%">
  			Tipo de cuenta        
		  </td>
          <td width="32%">
			  <html:select name="AltaClienteActionForm" property="tipoCuentaBanc" style="width:200px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTipoCuentaBanc">
	              <html:optionsCollection property="arrayTipoCuentaBanc" value="codigo" label="descripcion"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td width="21%">
  			Fecha Venc.(dd/mm/yyyy)  
		  </td>
          <td width="21%">
          	<html:text name="AltaClienteActionForm" property="fechaVencimientoTarjeta" style="text-transform: uppercase;" onkeypress="onlyInteger();validDate(this);" size="37" maxlength="10" onblur = "check_date(this,'0')"/>
		  </td>
        </tr>
	    <tr>
          <td colspan="4">
		     <HR noshade>
	      </td>
        </tr>        
	    	<tr>
		        <td colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
		        Responsable legal del Cliente:
		        </td>
	        </tr>

	        <tr>
	          <td width="26%">
	  			 Tipo Identificaci&oacute;n*        
			  </td>
	          <td width="32%">
				  <html:select name="AltaClienteActionForm" property="tipoIdentificacionResponsable1" style="width:200px;" > 
			  		<html:option value="">- Seleccione -</html:option>
				  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
		              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
		          	</logic:notEmpty>
		          </html:select>
	          </td>
	          <td width="21%">
	  			 N&uacute;m. Identificaci&oacute;n* </td>
	          <td width="21%">
	          <html:text name="AltaClienteActionForm" property="numeroIdentificacionResponsable1" size="37" maxlength="15" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" />
			  </td>
	        </tr>
        <tr>
          <td width="26%">
          Nombre*
          </td>
          <td colspan="3">
			<html:text name="AltaClienteActionForm" property="nombreResponsable1" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td width="26%">
	          <logic:equal name="AltaClienteActionForm" property="codigoCuenta" value="null">   
				<a href="javascript:submitCuentas()">
					<font color="#0000ff">Cuenta asociada</font>
				</a>              
              </logic:equal>    
              <logic:notEqual name="AltaClienteActionForm" property="codigoCuenta" value="null">
                  Cuenta asociada
              </logic:notEqual>
          </td>
          <td colspan="3">
          	<input type="text" name="desCuenta" readonly="true" style="background-color:#e0e0e0" size="60" maxlength="50" value="<bean:write name="AltaClienteActionForm" property="codigoCuenta"/> - <bean:write name="AltaClienteActionForm" property="descripcionCuenta"/>"/>
          </td>
        </tr>
	</TABLE>
	<script>
		manejoElementosFormClientePantalla3();	
		obtieneListaModalidadesPago();
		obtieneListaSucursales();
	</script>
     <P>
     <P>
     <P>
     </logic:equal>
     <!-- Pagina 4 -->
     <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina4">
      <TABLE align="center" width="90%" border="0">
        <tr>  
          <td colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
		   Segundo responsable legal del cliente
		  </td>
        </tr>
        <tr>
          <td width="20%">
  			Tipo Identificaci&oacute;n        
		  </td>
          <td width="30%">
			  <html:select name="AltaClienteActionForm" property="tipoIdentificacionResponsable2" style="width:180px;" title="Tipo de Identificación del Segundo Responsable" >
		  		<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td width="20%">
  			N&uacute;mero Identificaci&oacute;n
		  </td>
          <td width="30%">
            <html:text name="AltaClienteActionForm" property="numeroIdentificacionResponsable2" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="20" maxlength="20" title="Numero de Identificacion del Segundo Responsable" />
		  </td>
        </tr>
        <tr>  
          <td width="20%">
  			Nombre
		  </td>
          <td colspan="3" width="80%">
			<html:text name="AltaClienteActionForm" property="nombreResponsable2" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />          
		  </td>
        </tr>
        <tr>
	      <td colspan="4"><HR noshade></td>
        </tr>
        <tr>  
          <td colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">  
            Tercer&nbsp; responsable legal del cliente 
          </td>
        </tr>
        <tr>
          <td>
  			 Tipo Identificaci&oacute;n </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="tipoIdentificacionResponsable3" style="width:180px;" title="Tipo de Identificación del Tercer Responsable"  >
		  		<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
	              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td>
  			 N&uacute;mero Identificaci&oacute;n </td>
          <td>
            <html:text name="AltaClienteActionForm" property="numeroIdentificacionResponsable3" size="20" maxlength="20"  title="Número de Identificación del Tercer Responsable" onkeyup="upperCase(this);" />          
		  </td>
        </tr>
        <tr>  
          <td width="20%">
  			Nombre
		  </td>
          <td colspan="3" width="80%">
			<html:text name="AltaClienteActionForm" property="nombreResponsable3" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />          
		  </td>
        </tr>
        <tr>
	      <td colspan="4"><HR noshade></td>
        </tr>
        <tr>
          <td>Actividad </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="actividad" style="width:180px;">
  	  		  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayActividad">
	              <html:optionsCollection property="arrayActividad" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
          <td>
  			Pa&iacute;s
		  </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="pais" style="width:180px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayPais">
	              <html:optionsCollection property="arrayPais" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
		  </td>
     </tr>
	 </TABLE>
	 
	 <TABLE align="center" width="90%" border="0">	
      <tr>
          <td width="20%">
          	Tel&eacute;fono1
          </td>
          <td width="16">
			<html:text name="AltaClienteActionForm" property="telefono1Opcional" size="15" maxlength="15" onkeypress="onlyInteger();" />          
          </td>
          <td width="14%">
  			Tel&eacute;fono2
		  </td>
          <td width="16%">
			<html:text name="AltaClienteActionForm" property="telefono2Opcional" style="text-transform: uppercase;" onkeyup="upperCase(this);" size="15" maxlength="15" onkeypress="onlyInteger();" />          
		  </td>
		  <td width="4%">
  			Fax
		  </td>
          <td width="30%" align="left">
			<html:text name="AltaClienteActionForm" property="fax" style="text-transform: uppercase;" onkeyup="upperCase(this);" size="15" maxlength="15" onkeypress="onlyInteger();" />
	      </td>
      </tr>
     </TABLE>

	 <TABLE align="center" width="90%" border="0">	
        <tr>
          <td width="20%">
           E-mail
          </td>
          <td width="30%">
			<html:text name="AltaClienteActionForm" property="email" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="20" maxlength="20"/>          
          </td>
          <td width="20%">
  			PIN
		  </td>
          <td width="30%">
		   <html:text name="AltaClienteActionForm" property="pin" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="20" maxlength="20"/>		  
		  </td>
        </tr>
        <tr>
	      <td colspan="4"><HR noshade></td>
        </tr>
        <tr>
          <td>
          Estado Civil
          </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="estadoCivil" style="width:180px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayEstadoCivil">
	              <html:optionsCollection property="arrayEstadoCivil" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
		  </td>
          <td>
  			F.Nacimiento(dd/mm/yyyy)
		  </td>
          <td>
		   <html:text name="AltaClienteActionForm" property="fechaNacimiento" style="text-transform: uppercase;" onkeypress="onlyInteger();validDate(this);" size="20" maxlength="10" onblur="check_date(this,'1');"/>		  
		  </td>
        </tr>
        <tr>
          <td>
          Sexo
          </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="sexo" style="width:180px;"> 
				<html:option value="">- Seleccione -</html:option>
				<html:option value="M">MASCULINO</html:option> 
				<html:option value="F">FEMENINO</html:option>
	          </html:select>
          </td>
          <td>
  			N&ordm;. Integr. Familiar
		  </td>
          <td>
		   <html:text name="AltaClienteActionForm" property="numeroIntegranteFamiliar" style="text-transform: uppercase;" onkeyup="upperCase(this);" size="20" maxlength="2" onkeypress="onlyInteger();" />		  
		  </td>
        </tr>
	</TABLE>
	<P>
	<P>
	<P>
	<P>
	<P>
    </logic:equal>
    <!-- Pagina 5 -->

    <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina5">
    <script>
	  DWRUtil.setValue(document.getElementById("divTitulo"),'Creacion de cuentas');      
	</script>
      <TABLE align="center" width="90%" border="0">
        <tr >
          <td width="25%">
          	Descripci&oacute;n de la Cuenta
          </td>
          <td width="75%">
          <html:text name="AltaClienteActionForm" property="descripcionCuenta" style="text-transform: uppercase;" onkeyup="upperCase(this);" size="60" maxlength="50" />
      	  </td>
        </tr>
        <tr>
          <td>
  			Tipo de Cuenta        
		  </td>
          <td>
			  <html:select name="AltaClienteActionForm" property="tipoCuenta" style="width:215px;" >
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTipoCliente">
	              <html:optionsCollection property="arrayTipoCliente" value="codigoTipoCliente" label="tipoCliente"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
        </tr>
        <tr>
          <td>
  			Nombre        
		  </td>
          <td>
          <html:text name="AltaClienteActionForm" property="nombreCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td>
  			Primer Apellido        
		  </td>
          <td>
          <html:text name="AltaClienteActionForm" property="primerApellidoCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td>
  			Segundo Apellido        
		  </td>
          <td>
			<html:text name="AltaClienteActionForm" property="segundoApellidoCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
        <tr>
          <td>
  			Fec. Nacimiento(dd/mm/yyyy)        
		  </td>
          <td>
			<html:text name="AltaClienteActionForm" property="fechaNacimientoCuenta" style="text-transform: uppercase;" size="20" maxlength="20" onkeypress="onlyInteger();validDate(this);" onblur="check_date(this,'1');"/> 
          </td>
        </tr>
     </table>   

	<table width="90%" align="center" border="0">
    <tr>
      <td width="25%">
			Tipo Identificaci&oacute;n        
	  </td>
      <td width="35%">
		  <html:select name="AltaClienteActionForm" property="tipoIdentificacionCuenta" style="width:215px;" >
	  		<html:option value="">- Seleccione -</html:option>
		  	<logic:notEmpty name="AltaClienteActionForm" property="arrayIdentificadorCliente">
              <html:optionsCollection property="arrayIdentificadorCliente" value="codigoTipIdentif" label="descripcionTipIdentif"/>
          	</logic:notEmpty>
          </html:select>
      </td>
      <td width="20%">
			Num. Identificaci&oacute;n        
	  </td>
      <td width="20%">
		<html:text name="AltaClienteActionForm" property="numeroIdentificacionCuenta" size="15" maxlength="15" onkeyup="upperCase(this);" />          
	  </td>
    </tr>
	</table>

	<table width="90%" border="0" align="center">
        <tr>
          <td width="25%">
            <!--<logic:notEmpty name="AltaClienteActionForm" property="codigoDirCuenta">
              <bean:define name="AltaClienteActionForm" id="codigoDirCuenta" property="codigoDirCuenta"/>
          	  <a href="javascript:submitDirecciones('4','<=codigoDirCuenta>')"><FONT color="#0000ff">Direcci&oacute;n</FONT></a>
  		    </logic:notEmpty>
  		    <logic:empty name="AltaClienteActionForm" property="codigoDirCuenta">
    		  <a href="javascript:submitDirecciones('4','')"><FONT color="#0000ff">Direcci&oacute;n</FONT></a>
  		    </logic:empty>-->
  		     <a href="javascript:submitDirecciones('4')"><FONT color="#0000ff">Direcci&oacute;n</FONT></a>
		  </td>
          <td width="75%">
            <html:text name="AltaClienteActionForm" readonly="true" property="direccionCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="60" maxlength="50" />
          </td>
        </tr>
	</table>	
        
	<table width="90%" align="center" border="0">
	    <tr>
	      <td width="25%">
				Tel&eacute;fono
		  </td>
	      <td width="10%">
			 <html:text name="AltaClienteActionForm" property="areaTelefonoCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="5" maxlength="5" />	          
	      </td>
	      <td width="65%">
			 <html:text name="AltaClienteActionForm" property="telefonoCuenta" style="text-transform: uppercase;" onkeypress="soloCaracteresValidos();" onkeyup="upperCase(this);" size="30" maxlength="30" />	          
	      </td>
	    </tr>
	</table>

	<table width="90%" align="center" border="0">
        <tr>
          <td width="25%">
  			Categor&iacute;a Tributaria
		  </td>
          <td width="75%">
			  <html:select name="AltaClienteActionForm" property="categTribCuenta" style="width:215px;">
			  	<html:option value="">- Seleccione -</html:option>
			  	<logic:notEmpty name="AltaClienteActionForm" property="arrayCategTrib">
	              <html:optionsCollection property="arrayCategTrib" value="codigoValor" label="descripcionValor"/>
	          	</logic:notEmpty>
	          </html:select>
          </td>
        </tr>
        <tr>
          <td>
  			Clasificaci&oacute;n de la Cuenta
		  </td>
          <td>
		  <html:select name="AltaClienteActionForm" property="clasificacionCuenta" style="width:215px;">
	  		<html:option value="">- Seleccione -</html:option>
		  	<logic:notEmpty name="AltaClienteActionForm" property="arrayClasificacionCuenta">
              <html:optionsCollection property="arrayClasificacionCuenta" value="codigoClasificacion" label="descripcionClasificacion"/>
          	</logic:notEmpty>
          </html:select>
          </td>
        </tr>
        <tr>
          <td>
  			Tipo Comisionista
		  </td>
          <td>
		  <html:select name="AltaClienteActionForm" property="tipoComisionistaCuenta" style="width:215px;">
	  		<html:option value="">- Seleccione -</html:option>
		  	<logic:notEmpty name="AltaClienteActionForm" property="arrayTipoComisionistaCuenta">
              <html:optionsCollection property="arrayTipoComisionistaCuenta" value="codTipComisionista" label="desTipComisionista"/>
          	</logic:notEmpty>
          </html:select>
          </td>
        </tr>
     </table>
    </logic:equal>
	<P>
	<P>
	<P>
	<P>
	<P>
    <!-- Pagina 6 -->
    <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina6">
     <input type="hidden" name="codigoEmpresaCreado" />
     
     <logic:present name="mensajeError">
	  <table class ="textoTitulo">
	    <tr><td><bean:write name="mensajeError"/></td></tr>
	  </table>
	 </logic:present>

     <logic:notPresent name="mensajeError">
	  <table align="center" width="60%" border="0" >
	    <tr>
          <td align="center" class="textoTitulo">
          	Se ha realizado con &eacute;xito la creaci&oacute;n de cliente.<br>
          	Para su gesti&oacute;n anote los siguientes valores.<br>
          </td>
	    </tr>
	  </table>
	  <P>
	  <P>
	  <P>
      <table align="center" width="60%" border="0">
        <tr>
          <bean:define id="cuenta" name="cuentaCreada" scope="request"/>
          <bean:define id="cliente" name="cuenta" property="clienteComDTO"/>
          <td width="30%"><strong>C&oacute;digo de Cuenta</strong></td>
          <td width="70%">
			 <input type="text" name="txtCodigoCuenta" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="cuenta" property="codigoCuenta"/>" 
			/>
		  </td>
		  <script>
				$("codigoEmpresaCreado").value = "<bean:write name="cliente" property="codigoEmpresa"/>" ;
	      </script>
        </tr>
        <tr>
          <td><strong>C&oacute;digo de Cliente</strong></td>
          <td>
			<input type="text" name="codigoClienteCreado" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="cliente" property="codigoCliente"/>" 
			/>
          </td>
        </tr>
        <tr>
          <td><strong>Nombre del Cliente</strong></td>
          <td>
			<input type="text" name="nombreClienteCreado" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="cliente" property="nombreCliente"/> <bean:write name="cliente" property="nombreApellido1"/> <bean:write name="cliente" property="nombreApellido2"/>" 
			/>
          </td>
        </tr>
     </table>
     </logic:notPresent> 
    </logic:equal>
    
	<P>
	<P>
	<P>
	<P>
	<P>

	
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td align="left" width="50%" >
          <logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina1">
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina4">
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina5">
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina6">
          	<html:button  value="ANTERIOR" style="width:120px;color:black" property="nada" onclick="accion.value='anterior';submit();"/>
          	</logic:notEqual>
          	</logic:notEqual>
          	</logic:notEqual>
          </logic:notEqual> 	
        </td>
        <td width="25%" align="right"> 
          <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina3">
            <html:button  value="DATOS OPCIONALES" style="width:120px;color:black" property="nada" onclick="accion.value='siguiente';submit();"/>
          </logic:equal>
          <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina4">
            <html:button  value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="accion.value='anterior';validarDatosOpcionalesCliente();"/>
          </logic:equal>
          <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina5">
            <html:button  value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="accion.value='anterior';validarDatosObligatoriosCuenta();"/>
          </logic:equal>
        </td>
        <td width="25%" align="right">
          <logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina3">
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina4">
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina5">	
          	<logic:notEqual name="AltaClienteActionForm" property="pagina" value="pagina6">	
              <html:button  value="SIGUIENTE" style="width:120px;color:black" property="nada" onclick="accion.value='siguiente';validarDatosObligatoriosCliente();"/>
	        </logic:notEqual>
	        </logic:notEqual>
	        </logic:notEqual>
          </logic:notEqual> 	
          <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina3">
            <html:button  value="FINALIZAR" style="width:120px;color:black" property="nada" onclick="accion.value='finalizar';validarDatosObligatoriosCliente();"/>
          </logic:equal>
          <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina5">
            <html:button  value="CANCELAR" style="width:120px;color:black" property="nada" onclick="accion.value='anterior';descripcionCuenta.value='';submit();"/>
          </logic:equal>
        </td>
      </tr>
     </TABLE>
 
     <logic:equal name="AltaClienteActionForm" property="ventanaPopup" value="true">
       <logic:equal name="AltaClienteActionForm" property="pagina" value="pagina6">
       <logic:notPresent name="mensajeError">	
        <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
         <tr> 
          <td align="center">
            <html:button  value="ACEPTAR" style="width:120px;color:black" property="nada" onclick="enviarDatosOpener();"/>
          </td>
         </tr>
        </TABLE>
       </logic:notPresent> 
     </logic:equal>
     </logic:equal> 

    </html:form>
</body>

</html>
