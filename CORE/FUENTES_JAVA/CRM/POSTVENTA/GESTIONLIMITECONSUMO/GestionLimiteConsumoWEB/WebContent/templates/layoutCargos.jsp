<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/struts-nested.tld" prefix="nested" %>

<%
	long time = new java.util.Date().getTime();
	String cerrarAction = "../modificacionLimiteConsumo/CerrarAction.do?timestamp=" + time;
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Modificacion Limite Consumo :.</title>

<link href="../css/mas.css" rel="stylesheet" type="text/css" />

<script language="JavaScript" src="../botones/presiona.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/GestionLimiteConsumo.js" type="text/javascript"></script>
<script language="JavaScript" src="../js/RestitucionEquipo.js?timestamp=<%=time %>" type="text/javascript"></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/interface/RestitucionEquipoDWR.js'></script>
<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/engine.js'></script>

<script type='text/javascript' src='/GestionLimiteConsumoWEB/dwr/util.js'></script>

<script language="javascript">

function doSubmitBotones(accion){

	if(accion == "SIGUIENTE"){
	
		enviarFormulario();
		
	}
}

function convierte(numero)	{
	
	partes = numero.split(".");

	texto = "";
	cont = 0;
	for (var i=partes[0].length-1; i>=0; i--)	{
		cont++;
		texto = texto + partes[0].charAt(i);
		if ((cont==3) && (i != 0))	{
			texto = texto + ","
			cont = 0;
		} // if
	} // for

	textoFinal = "";

	for (var i=texto.length-1; i>=0; i--)
		textoFinal= textoFinal + texto.charAt(i);

	return textoFinal+"."+partes[1];	
	
} // convierte
	
// ------------------------------------------------------------------------------------------	
function limpiaFormateo( textoCelda )	{

	var texto = new String(textoCelda);
	return texto.replace(/,/g, '');
	
} // limpiaFormateo
// ------------------------------------------------------------------------------------------
function getCellByRowCol(rowNum, colNum, tablaDatos)
{
	var tableElem = document.getElementById(tablaDatos);
	var rowElem = tableElem.rows[rowNum];
	var tdValue = rowElem.cells[colNum].innerHTML;
	return tdValue;
}

function obtenerValor(cadena,valorABuscar){
	var returnFunc;
	var inicio = cadena.indexOf(valorABuscar);
	if(inicio!=-1){
		inicio += valorABuscar.length;
		final = cadena.substring(inicio).indexOf(" ");
		final += inicio;
		returnFunc = cadena.substring(final,inicio);
	}else{
		returnFunc=0;
	}
    return returnFunc;
}

function buscarSeleccion(cadena){
var returnFunc;
var inicio = cadena.indexOf(' selected');
if(inicio==-1){
	return inicio;
}else{
		returnFunc = cadena.charAt(inicio-1);
		if (returnFunc==2){
			return -1;
		}else{
			return returnFunc;
		}
	}
}

var contGlobal;
var contMax;
var contMin;

function setearTotal(fil, valor,minimo,maximo,cienPorciento,tipDesc, descuentoManual){
	/*alert ("fil:"+fil+" valor:"+valor+" minimo:"+minimo+" maximo:"+maximo+"cienPorciento:"+cienPorciento+"tipDesc:"+tipDesc+"descuentoManual:"+descuentoManual);*/

	try{
		var unidad = cienPorciento/100;
		maximo = maximo * unidad;
		minimo = minimo * unidad;
		maximo = cienPorciento - maximo;
		minimo = cienPorciento - minimo;
		
		var tableElem = document.getElementById("tablaDatos");
		var rowElem = tableElem.rows[fil];
		
		if(tipDesc!=-1) {
			if (valor == cienPorciento || (valor>=maximo && valor<=minimo) ){
				rowElem.cells[9].innerHTML = valor;
			}
			else if(valor<0){
				rowElem.cells[9].innerHTML =rowElem.cells[4].innerHTML;
				contGlobal +=1;
				//valor = 0;
			}
			else if(valor>maximo && descuentoManual!="" ){
				contMax+=1;
				// valor = 0;
			}
			else{
				rowElem.cells[9].innerHTML =valor;
				contMin+=1;
			}
		}
		else {
			//rowElem.cells[9].innerHTML =valor;
		}
		rowElem.cells[9].innerHTML =valor;

		
		nroDecimales = document.getElementById("numDecimalesForm").value;
		formatCellByRowCol(fil,9,nroDecimales);
		document.getElementById(fil-2+"Totales").value = valor;
	
  	} 
  	catch(e){
		alert(e.name + " - "+e.message+"En Setear Total");
  	}

}

function imp(a){
	alert(a)
}

function calcular(posicion){
	var inCheck = eval("document.CargosForm.selectedValorCheck");
	var isArray=(inCheck.value==null||inCheck.value=='undefined'||inCheck.value=='')?true:false;
	 var j=0; 
	 var k=0;
	if(document.getElementById("tablaDatos").rows.length>3){
		document.getElementById("cumpleDescuento").value = "NO";
		validaHaceDescuentos();
		var minimo = document.getElementById("rangoInfPorcDescuento").value;
		var maximo = document.getElementById("rangoSupPorcDescuento").value;
		//try{
			document.getElementById("mensajesDescMax").innerHTML = "";
			document.getElementById("mensajesDescMin").innerHTML = "";
			var totalCompleto = 0;
			contGlobal= 0;
			contMax=0;
			contMin=0;
			 
			for(i=2; i<document.getElementById("tablaDatos").rows.length-1;i++){
				var asd=getCellByRowCol(i,8,"tablaDatos");
				var descuentoManual = parseFloat(obtenerValor(asd,"value="));
				var saldoTotal = parseFloat(limpiaFormateo(getCellByRowCol(i,4,"tabladatos")));//columna de importe
			
//				var saldoTotal = parseFloat(getCellByRowCol(i,4,"tabladatos"));//columna de importe
				var tipoDesc = getCellByRowCol(i,7,"tabladatos"); // tipo descuento manual
				
				var tableElem = document.getElementById("tablaDatos");
				var rowElem = tableElem.rows[i];
				var valTipDesc = buscarSeleccion(tipoDesc);
				
				var total = saldoTotal;
				
				var tipDescAut = getCellByRowCol(i,5,"tablaDatos"); //tipo descuento automatico
				var cantDescAut = 0;
				if(tipDescAut=="Porcentaje"){
//					cantDescAut = parseFloat (getCellByRowCol(i,6,"tablaDatos"));
					cantDescAut = parseFloat (limpiaFormateo(getCellByRowCol(i,6,"tablaDatos")));
					var porcentajeAut = saldoTotal/100;
					cantDescAut = cantDescAut * porcentajeAut;
				}
				if(tipDescAut=="Monto"){
//					cantDescAut = parseFloat (getCellByRowCol(i,6,"tablaDatos"));
					cantDescAut = parseFloat (limpiaFormateo(getCellByRowCol(i,6,"tablaDatos")));
				}
		
			     saldoTotal = saldoTotal-cantDescAut;
				var cienPorciento = saldoTotal;
				
				total = saldoTotal;
				
				if(valTipDesc==-1){
					
					var inText=eval('document.CargosForm.descuentoUnitarioMan');
				
					if(inText.length==null){
						inText.disabled = true;
					}
					else{
						inText[i-2].disabled = true;
						
					}
				}else{	
					/*
					@author rlozano
					@description se verifica los montos a descontar por medio manual cuando se encuentre checkado
					*/
						var isAplicaDesMan=false;
						if (isArray){
							isAplicaDesMan=inCheck[j].checked;
						}
						else{
							isAplicaDesMan=inCheck.checked;

						}
							
						if(valTipDesc==0){
							if (isAplicaDesMan){
								total= saldoTotal-descuentoManual; 
							}
						}else{
							var porc = saldoTotal/100;
							porc = porc*descuentoManual;
							if (isAplicaDesMan){
								total = saldoTotal - porc;
							}
						}


					var inText=eval('document.CargosForm.descuentoUnitarioMan');
					if(inText.length==null){
						inText.disabled = true;
					}else{
						inText[i-2].disabled = true;
					}
				}
				
				
				setearTotal(i,total,minimo,maximo,cienPorciento,valTipDesc,descuentoManual);
				

				
				// Si ocurrio alguno de los errores por maximo o minimo lo mismo se debe sumar al total general, por eso se desactiva esto
				// if (contMin!=0 || contMax!=0 || contGlobal!=0){ 
				//		total = saldoTotal; 
				 //}

				/**************************************************************************************************/
				/**
				@author : rlozano 
				@description : colocar validacion para verificar si corresponde la suma :: verificar check 
				@description : en caso contrario desabilitar combo y monto de descuento manual
				*/
				
				var deshabilitarDescManual=false;
				if (isArray){
					if (inCheck[j].checked){
						totalCompleto +=total;
						
					}
					else{
						deshabilitarDescManual=true;
					}
				}
				else{
				
					if (inCheck.checked){
						totalCompleto +=total;
						
					}
					else{
						deshabilitarDescManual=true;
					}
				
				}

				/****************************************************************************************************/
				
				
				
			j++;

			}



			var tableElem = document.getElementById("tablaDatos");
			var totalFilas = document.getElementById("tablaDatos").rows.length;
			var rowElem = tableElem.rows[totalFilas-1];
			rowElem.cells[2].innerHTML = totalCompleto;
			nroDecimales = document.getElementById("numDecimalesForm").value;
			formatCellByRowCol(totalFilas-1,2,nroDecimales);

			document.getElementById("total").value = rowElem.cells[2].innerHTML;
			document.getElementById("mensajesDescMax").innerHTML = "";
						
			if(contMin!=0){
				document.getElementById("cumpleDescuento").value = "SI";
				document.getElementById("mensajesDescMax").innerHTML = document.getElementById("mensajesDescMax").innerHTML + "El descuento ingresado es mayor que el máximo permitido, se generará una solicitud de descuento, corrija el valor ingresado.<br>";
				document.getElementById("ConsultarCargoBT").disabled = true;

				// No aplica para este caso
				// activarDesactivarTextSelect(true);
			}
			
			if(contMax!=0){
				document.getElementById("mensajesDescMax").innerHTML = document.getElementById("mensajesDescMax").innerHTML + "El descuento ingresado es menor que el minimo permitido, corrija el valor ingresado.<br>";
				document.getElementById("ConsultarCargoBT").disabled = true;
				document.getElementById("Siguiente2").disabled = true;
				document.getElementById("Siguiente1").disabled = true;
				activarDesactivarTextSelect(true);
			} 
			
			if(contGlobal!=0){
				document.getElementById("mensajesDescMax").innerHTML = document.getElementById("mensajesDescMax").innerHTML +  "Valor de Descuento NO puede superar el 100%.";
				document.getElementById("Siguiente2").disabled = true;
				document.getElementById("Siguiente1").disabled = true;
				document.getElementById("ConsultarCargoBT").disabled = true;
				activarDesactivarTextSelect(true);
			}
			
			// if ((contGlobal==0) && (contMax==0) && (contMin==0)) {

			// Si se cumple el primer error lo mismo deberia pasar a la siguiente pagina
			if ((contGlobal==0) && (contMax==0)) {			
				activarDesactivarTextSelect(false);
				document.getElementById("mensajesDesc").innerHTML = "";
				document.getElementById("ConsultarCargoBT").disabled = false;
				if(errorModPago == "OK")	{
					document.getElementById("Siguiente2").disabled = false;
					document.getElementById("Siguiente1").disabled = false;
				}
			} // if
			
			var elemento = event.srcElement;
			
			if (elemento != null && elemento.type == "text" ) {
			  elemento.disabled = false;
		    }	
			var valor=inCheck.value==null||inCheck.value=='undefined'?inCheck[k].checked:inCheck.checked;
			deshabilitaTipoDescuentoManual(k,!valor);
			deshabilitaTextodescuentoManual(k,!valor)
			k++;
	
		//}
		//catch(e){
		//	alert(e.name + " - "+e.message+" EN CALCULAR");
		//}
	}
}

function validaHaceDescuentos(){
	try{
	if(document.getElementById("indCreaDescuento").value == 0){
		var inText=eval('document.CargosForm.tipoDescuentoManual');
		for(i=0; i<inText.length;i++){
			inText[i].disabled = true;
		}
	}else{
		var inText=eval('document.CargosForm.tipoDescuentoManual');
		for(i=0; i<inText.length;i++){
			inText[i].disabled = false;
		}
	}
	}catch(e){
		alert(e.name + " - "+e.message+" validahHaceDescuentos");
	}
}

function deshabilitaTipoDescuentoManual(indice,valor){
	try{
		
		var inText=eval('document.CargosForm.tipoDescuentoManual');
			if (valor==true){
				inText[indice].value="2";
			}
			inText[indice].disabled = valor;
	
	}catch(e){
		alert(e.name + " - "+e.message+" deshabilitaTipoDescuentoManual");
	}

}

function deshabilitaTextodescuentoManual(indice,valor){
	try{
			var inText=eval('document.CargosForm.descuentoUnitarioMan');
			var inCheck = eval("document.CargosForm.selectedValorCheck");
			var isArray=(inCheck.value==null||inCheck.value=='undefined'||inCheck.value=='')?true:false;
			if (isArray){
				if (valor==true){
					inText[indice].value="";
				}
				inText[indice].disabled = valor;
			}
			else{
				if (valor==true){
					inText.value="";
				}
				inText.disabled = valor;
			}
		
	
	}catch(e){
		alert(e.name + " - "+e.message+" deshabilitaTextodescuentoManual");
	}

}

function limpiacaja(indice){
	var inText=eval('document.CargosForm.descuentoUnitarioMan');
	var isArray=inText.value==null?true:false;
	if (isArray){
		inText[indice].value="";
	}
	else{
		inText.value="";
	}
}


function habilitarDeshabilitarTodosTexto(valor){
	try{
	if(document.getElementById("tablaDatos").rows.length>3){
	var inText=eval('document.CargosForm.descuentoUnitarioMan');
	for(i=0; i<inText.length;i++){
		if (inText[i].value==""&&valor==true){
		  inText[i].value="";
		}
		inText[i].disabled = valor;
		
	}
	}
	}catch(e){
		alert(e.name + " - "+e.message+" habilitarDeshabilitarTodosTexto");
	}
}

function habilitarDeshabilitarTodosSelect(valor){
	try{
	if(document.getElementById("tablaDatos").rows.length>3){
	var inSelect=eval('document.CargosForm.tipoDescuentoManual');
	for(i=0; i<inSelect.length;i++){
		inSelect[i].disabled = valor;
	}
	}
	}catch(e){
		alert(e.name + " - "+e.message+" habilitarTodosSelect");
	}
}

function habilitarDeshabilitarSelectTipoDescuentoManual(valor){
	try{
	if(document.getElementById("tablaDatos").rows.length>3){
	var inSelect=eval('document.CargosForm.tipoDescuentoManual');
	for(i=0; i<inSelect.length;i++){
		inSelect[i].disabled = valor;
	}
	}
	}catch(e){
		alert(e.name + " - "+e.message+" habilitarDeshabilitarSelectTipoDescuentoManual");
	}
}

function calcularCargos(){
	try{
	habilitarDeshabilitarTodosTexto(true);
	document.getElementById("botonSeleccionado").value = "recalcular";
	document.forms[0].submit();
	}catch(e){
		alert(e.name + " - "+e.message+" EN calcularCargos");
	}
}  
function enviarFormulario()
{
  	//try{
		
		
		document.getElementById("botonSeleccionado").value = "siguiente";
	  	buscarCheckados();
	    reCalcular(-1);
		habilitarDeshabilitarTodosTexto(false);
		habilitarDeshabilitarSelectTipoDescuentoManual(false);

		// INICIO RRG 100790 COL 03/08/2009
		document.getElementById("Siguiente1").style.cursor ="";
		document.getElementById("Siguiente2").style.cursor ="";
		document.getElementById("Siguiente1").disabled=true;
	    document.getElementById("Siguiente2").disabled=true;
		// FIN RRG 100790 COL 03/08/2009

		// INICIO RRG COL 14/08/2009
		/*document.getElementById("Anterior").style.cursor ="";
		document.getElementById("Anterior2").style.cursor ="";
		document.getElementById("Anterior").disabled=true;
	    document.getElementById("Anterior2").disabled=true;*/
		// FIN RRG COL 14/08/2009
		document.forms[0].submit();

		habilitarDeshabilitarTodosTexto(true);
		habilitarDeshabilitarSelectTipoDescuentoManual(true);
		//buscarCheckados(false);
    //}
    //catch(e){
    //	alert(e.name + " - "+e.message+" En enviarFormulario()");
    //}
}

function formularioAnterior()
  {
  try{
  	habilitarDeshabilitarTodosTexto(true);
  	document.getElementById("botonSeleccionado").value = "anterior";
	// INICIO RRG 100790 COL 03/08/2009
		document.getElementById("Siguiente1").style.cursor ="";
		document.getElementById("Siguiente2").style.cursor ="";
		document.getElementById("Siguiente1").disabled=true;
	    document.getElementById("Siguiente2").disabled=true;
	// FIN RRG 100790 COL 03/08/2009
		
		
	// INICIO RRG COL 14/08/2009
		/*document.getElementById("Anterior").style.cursor ="";
		document.getElementById("Anterior2").style.cursor ="";
		document.getElementById("Anterior").disabled=true;
	    document.getElementById("Anterior2").disabled=true;*/
	// FIN RRG COL 14/08/2009
    document.forms[0].submit();
  }catch(e){
  alert(e.name + " - "+e.message+" en formularioAnterior");
  }
  }

 var errorModPago = "OK";
function cambioModPago(){
	try{
	document.getElementById("Siguiente2").disabled = true;
	document.getElementById("Siguiente1").disabled = true;
	errorModPago="NO";
	document.getElementById("mensajes").innerHTML = "Modalidad de pago alterada, debe recalcular los cargos";
	}catch(e){
	alert(e.name + " - "+e.message+" cambioModPago");
	}
}

var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 12 || (tecla >= 48 && tecla <= 57));
}

function formatCellByRowCol(rowNum,colNum,nroDecimales)
{
	try
	{
		
		var tableElem = document.getElementById("tablaDatos");
		var rowElem = tableElem.rows[rowNum];
		var tdValue = rowElem.cells[colNum].innerHTML;
		tdValue = parseFloat (tdValue);
		tdValue = Math.round(tdValue * Math.pow(10,nroDecimales)) / Math.pow(10, nroDecimales)
		rowElem.cells[colNum].innerHTML = tdValue.toFixed(nroDecimales);
		// HGG 02/04
		rowElem.cells[colNum].innerHTML = convierte(rowElem.cells[colNum].innerHTML);
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En formatCellByRowCol()");
	}	
}


function formatoDecimales(){
	try
	{
		nroDecimales = document.getElementById("numDecimalesForm").value;
		var tableElem = document.getElementById("tablaDatos");
		var totalFilas = tableElem.rows.length;
		
		if( totalFilas>3 ){
			for(i=2; i<tableElem.rows.length-1;i++){
				formatCellByRowCol(i,4,nroDecimales);// importe total
				formatCellByRowCol(i,6,nroDecimales);// descuento 
				formatCellByRowCol(i,9,nroDecimales);// saldo total
			}
			formatCellByRowCol(totalFilas-1,2,nroDecimales); // total
		}
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En formatoDecimales()");
	}
}


function validaIngresoDecimales (campoTexto) { 
	numDecimales = document.getElementById("numDecimalesForm");
	onlyFloat(campoTexto.value,numDecimales.value);
} 

function onlyFloat(valorCampoTexto,numDecimales) {
	var keyASCII;
	var txt;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	
	if (keyASCII == 47) {
	  window.event.keyCode = '';	 
	  return;
	}
	
	if(keyASCII != 75 && keyASCII != 8 && keyASCII != 46
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

var arregloTipDesc =new Array();
function reCalcular(posicion){
	var inText=eval('document.CargosForm.tipoDescuentoManual');
	
	if(arregloTipDesc==null||arregloTipDesc=='undefined'||arregloTipDesc.length==0){
		for(i=0; i<inText.length;i++){
			arregloTipDesc[i]=inText[i].value;
		}
	}else{
		for(i=0; i<arregloTipDesc.length;i++){
			if(arregloTipDesc[i]==inText[i].value){

			}else{
				var arrDesc=eval('document.CargosForm.descuentoUnitarioMan');
				arrDesc[i].value = "";
				arregloTipDesc[i]=inText[i].value;
			}
		}
	}
	
	calcular(posicion);
}

function salir(){
	RestitucionEquipoDWR.rollbackReservaSerie(callbackDesreserva);
}

function callbackDesreserva(){

	desbloqueaVendedor();
	
}

function callbackDesbloqueaVendedor(){
	
	location.href="<%=response.encodeRedirectURL(cerrarAction)%>";
}

function activarDesactivarTextSelect(valor){
	habilitarDeshabilitarTodosTexto(valor);
    habilitarDeshabilitarTodosSelect(valor);
}    

function activaDesactivaBotonSiguiente(valor)
  {
     document.getElementById("Siguiente1").disabled=valor;
     document.getElementById("Siguiente2").disabled=valor;
  }  
  
  
function activaDesactivaBotonAnterior(valor)
  {
     /*document.getElementById("Anterior").disabled=valor;
     document.getElementById("Anterior2").disabled=valor;*/
  }  
  
function activaDesactivaBotonConsultarCargo(valor)
  {
     document.getElementById("ConsultarCargoBT").disabled=valor;
  }   

function activarCheckCargo(){

	  /*var  todosChk=eval("document.CargosForm.selectedValorCheck");
	 alert(todosChk);
  if (todosChk.value != null){
	alert("A::"+todosChk[0]);
	alert("B::"+vetadosBD[0]);
     if (todosChk[0]==vetadosBD[0]) {
          todosChk.checked = true;
      }
   }
   else{
       
   		for(var i=0;i<todosChk.length;i++){
   				if (buscaCheck(todosChk[i].value)){
   				    	todosChk[i].checked = true;
   				}
   		}
   }*/

	var inCheck = eval("document.CargosForm.selectedValorCheck");
	var retValue=inCheck.value; 
	var isArray=(inCheck.value==null||inCheck.value=='undefined'||inCheck.value=='')?true:false;
	 var j=0;
	for(i=2; i<document.getElementById("tablaDatos").rows.length-1;i++){
	
			    var asd=getCellByRowCol(i,0,"tablaDatos");
				var valor1 = obtenerValor(asd,"value=");
				var tipoCargo = getCellByRowCol(i,1,"tabladatos");
				
				if (tipoCargo=="M"){
						
						if (!isArray){ 
								inCheck.disabled=false;
					}
					else{
							inCheck[j].disabled=false;
					}
				}
				if (tipoCargo=="A"){
						var retValue=inCheck.value; 
						if (!isArray){
						    inCheck.disabled=false;
						    inCheck.checked=true;
						   	inCheck.disabled=true;
								
						}
						else{
						
								inCheck[j].checked=true;
						}
				}
				j++;
	}
	calcular(-1);
}
 
function buscarCheckados(){

  var inCheck = eval("document.CargosForm.selectedValorCheck");
	 
  	for (i=0;i<inCheck.length;i++){
		 	inCheck[i].disabled=false;

	}	
}

function buscaCheck(listaVet){
  
  for(var i=0;i<listCargosForm.length;i++){
     if (listaVet==listCargosForm[i]){
  		    return true;
  		 }
  }
  
  return false;

}

</script>

</head>

<body class="body"  onload="calcular();formatoDecimales();activarCheckCargo();">

<html:form action="/CargosAction" method="POST">

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <!-- tr>
    <td colspan="2"--><!-- tiles:insert attribute="footerOS" /--><!-- /td></tr-->
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>
</table>

</html:form>
</body>
</html:html>
