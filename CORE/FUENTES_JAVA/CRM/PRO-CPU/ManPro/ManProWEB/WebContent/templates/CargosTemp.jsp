<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="/tags/struts-nested" prefix="nested"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<title>Telefónica Móviles .: Cargos :.</title>

<script type='text/javascript' src='dwr/interface/JCargosDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>

<script language="javascript" src="js/toolsgrilla.js" type="text/javascript"></script>
<script language="javascript" src="img/botones/presiona.js" type="text/javascript"></script>
<script language="javascript">
var listaCodConceptos=new Array();
var listaImportes=new Array();
var listaCantidades=new Array();
var numeroDecimales = 4;
function levantarCargosAutomaticos(event,codConcepto)
{
	try
	{
		var lay=document.getElementById("descuentosAutomaticos");	
		document.getElementById("textoDescAuto").innerHTML="Cargando ...."; 		
		obtenerDescuentosAjax(codConcepto);
		lay.style["display"]="";
		lay.style["top"]=event.clientY;	
		lay.style["left"]=event.clientX;	
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En levantarCargosAutomaticos()");
	}
	
}
//------------------------------------------------------------------------
function ocultarObjeto(objetoId)
{
	try
	{
		document.getElementById(objetoId).style["display"]="none";	
	}
	catch(e)
	{
		//alert(e.name + " - "+e.message+" En ocultarObjeto()");
	}
	
}
//------------------------------------------------------------------------
function getTotalCargo(importe,descuento1)
{
	var imp=new Number(importe);
	var desc=new Number(descuento1);
	var tipDescuento=document.getElementById("tipoDescuento").value;
	
	if(tipDescuento=='porcentaje')
	{
		descuento1=(descuento1/100)*importe;
	}		
	return (imp-desc);
}
//------------------------------------------------------------------------
function setTipoDescuento(combo,codConcepto,tipoCobro)
{
	var nombreObjetoConcepto="tipoDesc_"+codConcepto;
	var identificadorDescuento=document.getElementById(nombreObjetoConcepto);
	var idTextDescuentoManual="valorDescuento_"+codConcepto;
	var textFieldDesc=document.getElementById(idTextDescuentoManual);
	if (tipoCobro!="A"){
		if(combo.value=="monto")
		{
			identificadorDescuento.innerHTML="$";
			textFieldDesc.disabled=false;
			textFieldDesc.focus();
		}
		else if(combo.value!='-1')
		{
			identificadorDescuento.innerHTML="%";
			textFieldDesc.disabled=false;
			textFieldDesc.focus();
		}
		else
		{
			identificadorDescuento.innerHTML="";
			textFieldDesc.value=0;		
			refreshSaldoTotal(textFieldDesc,codConcepto);
			textFieldDesc.disabled=true;
		}
	}
	else{
		combo.value='-1'
		combo.disabled="true"; 	
		alert("No es posible asignar descuentos a cargos recurrentes prorrateados con tipo de cobro adelantado");
		return false;
	}
}
//---------------------------------------------------------------------------
var primerDigito = true;
function refreshSaldoTotal(inputMontoDesc,codConcepto)
{
  
	idCombo="tipoDescuento_"+codConcepto;
	var comboTipDes=document.getElementById(idCombo);
	var idSpanSaldoTotal="span_saldoTotal_"+codConcepto;

	

	var saldoActual=new Number(document.getElementById("saldoTotal_"+codConcepto).value);
	var saldoActualTxt=saldoActual.toFixed(numeroDecimales);
	saldoActual=new Number(saldoActualTxt);

	var importeActual=new Number(document.getElementById("importe_"+codConcepto).value);

	var montoDescuento=new Number(inputMontoDesc.value);

	//alert(importeActual);
	

	var idTextDescuentoManual="valorDescuento_"+codConcepto;


	var textFieldDesc=document.getElementById(idTextDescuentoManual);

	if(!validaTextoIngresoDecimales(textFieldDesc))//inputMontoDesc
	{
		alert('Debe ingresar un descuento válido');
		document.getElementById("valorDescuento_"+codConcepto).value="0";
		primerDigito = true;
		return;
	}

	var resultado=0;

	var isExistError=false;

	// VALORES CORRESPONDEN A PORCENTAJES
	var minimo = document.getElementById("rangoInfPorcDescuento").value;
	var maximo = document.getElementById("rangoSupPorcDescuento").value;

	var indCreadesc = document.getElementById("indCreaDescuento").value;

	/**
		@author : rlozano
		@description : validacion vendedor para realizar descuentos manuales
		@param : indCreadesc-->1 Puede realizar descuentos

	**/

	if (indCreadesc=="0"){
		alert('No dispone de privilegios para modificar los Descuentos');
		document.getElementById("valorDescuento_"+codConcepto).value="0";
		document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
		document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
		comboTipDes.value='-1';
		resultado=saldoActual;
		idTextDescuentoManual=0;
		return;
	
	}
	else{
		montoDescuento
		var montoenPorcentaje=0;

		if(comboTipDes.value=="monto"){
				montoenPorcentaje=((montoDescuento*100)/saldoActual);	;		
		}
		else if(comboTipDes.value!='-1')	
		{
			if(montoDescuento<=100 && montoDescuento>=0)		
				montoenPorcentaje=montoDescuento;
			
			else{
				alert("El porcentaje debe estar entre 0 y 100%");
				inputMontoDesc.focus();
				isExistError=true;
				document.getElementById("valorDescuento_"+codConcepto).value="0";
				document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
				document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
				comboTipDes.value='-1';
				resultado=saldoActual;
				idTextDescuentoManual=0;
				return;
			}
		}
		
		if(comboTipDes.value!='-1'){
			if (montoenPorcentaje<minimo){
				alert('Usted no debe aplicar un descuento inferior a '+minimo+'% de $'+saldoActual);
				document.getElementById("valorDescuento_"+codConcepto).value="0";
				document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
				document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
				comboTipDes.value='-1';
				resultado=saldoActual;
				idTextDescuentoManual=0;
				return;
			
			}

			if (montoenPorcentaje>maximo){
				alert('Usted no debe aplicar un descuento mayor al '+maximo+'% de $'+saldoActual);
				document.getElementById("valorDescuento_"+codConcepto).value="0";
				document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
				document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
				comboTipDes.value='-1';
				resultado=saldoActual;
				idTextDescuentoManual=0;
				return;
			}
		}
	}



	
	if(comboTipDes.value=="monto")
	{
		resultado=saldoActual-montoDescuento;		
		
	}
	else if(comboTipDes.value!='-1')	
	{
		if(montoDescuento<=100 && montoDescuento>=0)		
			resultado=saldoActual-((montoDescuento/100)*saldoActual);
		else
		{
			alert("El porcentaje debe estar entre 0 y 100%");
			inputMontoDesc.focus();
			isExistError=true;
		}
	}
	else
	{
		resultado=saldoActual;
	}
	
	if (resultado>=0){
		document.getElementById(idSpanSaldoTotal).innerHTML=resultado.toFixed(numeroDecimales);
		
	}
	else{
		//document.getElementById("valorDescuento_"+codConcepto).value="";
		if(!IsNumeric(document.getElementById("valorDescuento_"+codConcepto).value))
		{
			alert('Debe ingresar un descuento válido');
		}
		else
		{
			alert("El monto correspondiente al descuento es mayor al permitido");		
		}

		document.getElementById("valorDescuento_"+codConcepto).value="0";
		document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
		document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
		comboTipDes.value='-1';
		resultado=saldoActual
		idTextDescuentoManual=0;
		isExistError=true;

	}
	if (montoDescuento<0){
		alert("corrija el monto del descuento");
		document.getElementById("valorDescuento_"+codConcepto).value="0";
		document.getElementById("tipoDesc_"+codConcepto).innerHTML="";
		document.getElementById("span_saldoTotal_"+codConcepto).innerHTML=saldoActual;
		comboTipDes.value='-1';
		isExistError=true;
	}
	if(document.getElementById("valorDescuento_"+codConcepto).value=="0")
	{
		primerDigito = true;
	}
	

	calcularTotalAPagar();
}

function validaTextoIngresoDecimales (campoTexto) { 
	//alert("campoTexto "+campoTexto);

	var texto = '';
	if (!campoTexto.disabled){
		//alert("campoTexto.value "+campoTexto.value);
		texto = campoTexto.value;
		/*if(primerDigito)
		{
			primerDigito = false;
			campoTexto.value="";
		}*/
		//numDecimales = 4;//document.getElementById("numDecimalesForm");
		//alert("texto.length "+texto.length);
		for(i=0;i<texto.length;i++)
		{
			if(!onlyFloat(texto.substring(i,i+1),numeroDecimales))
			{
				//alert("i "+i+" char "+texto.substring(i,i+1));
				return false;
			}
		}
		return true;
	}
} 

function validaIngresoDecimales (campoTexto) { 
	//alert("campoTexto "+campoTexto);

	if (!campoTexto.disabled){
		if(primerDigito || campoTexto == '0')
		{
			primerDigito = false;
			campoTexto.value="";
		}
		//numDecimales = 4;//document.getElementById("numDecimalesForm");
		if(onlyFloat(campoTexto.value,numeroDecimales))
		{
			return true;
		}
		return false;
	}
} 

function IsNumeric(textval){

	var ValidChars = ".0123456789"; 
	var IsNumber=true;
	var Char;
	
	if(textval == ""){
		IsNumber = false;
	}
	for (i = 0; i < textval.length; i++){
	
		Char = textval.charAt(i);
		if (ValidChars.indexOf(Char) == -1)
		{
			IsNumber = false;
			//input.value = '';
			return false;
		}
	}
	return true;
}

function onlyFloat(valorCampoTexto,numDecimales) {
	var valido = true;
	var keyASCII;
	var txt;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	if(keyASCII == 0) 
	{
		return true;
	}
	//alert("keyASCII "+keyASCII);
	if (keyASCII == 47) {
	  window.event.keyCode = '';	 
	  valido = false;
	  return valido;
	}
	
	if(keyASCII != 75 && keyASCII != 8 && keyASCII != 46
	   && (keyASCII < 46 || keyASCII > 57)) 
	{
	   window.event.keyCode = '';
		valido = false;
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
					valido = false;
				}
			}
		}
	}
	return valido;
}
//-------------------------------------------------------------------------------------
function calcularTotalAPagar()
{
	var divTotalPagar=document.getElementById("totalAPagar");
	var subTotalCargo;
	var total=new Number(0);

	for (i=0;i<listaCodConceptos.length;i++)
	{
	    subTotalCargo=document.getElementById("span_saldoTotal_"+listaCodConceptos[i]);
		total=total+new Number(subTotalCargo.innerHTML);
	}
	
	divTotalPagar.innerHTML="$"+total.toFixed(numeroDecimales);	
}
//-------------------------------------------------------------------------------------
function finalizarVenta()
{
	

	var form=document.forms[0];
	var listaTotalDescuentos=new Array();
	var totalCargo;
	var importeActual;
	var descuentoActual;

	listaTotalDescuentos=form.totalDescuentos;	
	var isArreglo=false;
	
	if(listaTotalDescuentos.length && listaTotalDescuentos.length>0)	
		isArreglo=true;	

	if(listaCodConceptos.length && listaCodConceptos.length>0)
	{	    
		for(i=0;i<listaCodConceptos.length;i++)
		{		
			totalCargo=new Number(document.getElementById("span_saldoTotal_"+listaCodConceptos[i]).innerHTML);					
			importeActual=new Number(listaImportes[i]);		
			descuentoActual=""+(importeActual-totalCargo);			
		   if(isArreglo)
			 listaTotalDescuentos[i].value=descuentoActual;
		   else
		   	 listaTotalDescuentos.value=descuentoActual;
		}
	}
	else
	{		
		totalCargo=new Number(document.getElementById("span_saldoTotal_"+listaCodConceptos).innerHTML);
		importeActual=new Number(listaImportes[0]);
		descuentoActual=""+(importeActual-totalCargo);	
		listaTotalDescuentos.value=descuentoActual;
	}	
	form.action="<%=request.getContextPath()%>/AplicarCargosAction.do";	
	form.submit();
	document.getElementById("Aceptar").disabled=true;
	
}
//------------------------------------------------------------------------------------
function cancelarVenta()
{
	var form=document.forms[0];
	form.action="<%=request.getContextPath()%>/buscaClientexVenta.do";	
	form.submit();
}
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DWR -- 
//---------------------------------------------------------------------------

function obtenerDescuentosAjax(codConcepto)
{
	JCargosDWR.getDescuentos(codConcepto,obtenerDescuentosAjaxReturn);
}
//----------------------------------------------------------------------------
// RETURN --
//----------------------------------------------------------------------------

function obtenerDescuentosAjaxReturn(data)
{
   document.getElementById("textoDescAuto").innerHTML="Descuento Autom&aacute;tico";
   var descuentos=new Array();
   descuentos=data;  
   var tablaBody=document.getElementById("bodyTablaDescuentos");
   var fila;
   var columna;  
   
   borrarFilasDesde(tablaBody,1);
   var colorFila="#F8F8F3"
   
   for(i=0;i<descuentos.length;i++)
   {
     colorFila=(i%2==0)?"#FFFFFF":"#F8F8F3";
     fila=crearFila();   
     fila.bgColor=colorFila;  
		     columna=crearColumna();
		     columna.bgColor=colorFila;
		     columna.align="left";
		     if(descuentos[i]['tipDescuento']=='P')
		     	columna.innerHTML="Porcentaje";     
		     else
		     	columna.innerHTML="Monto";
	     agregarColumnaAFila(fila,columna);     
		     columna=crearColumna();
		     columna.bgColor=colorFila;
		     columna.align="left";
		     if(descuentos[i]['tipDescuento']=='P')
		     	columna.innerHTML=descuentos[i]['valDescuento']+"%";     
		     else
		     	columna.innerHTML="$"+descuentos[i]['valDescuento'];
	     agregarColumnaAFila(fila,columna);
     agregarFilaATabla(tablaBody,fila);     
     
   }
}

/*function calculaDescuentosManuales(){
	var minimo = document.getElementById("rangoInfPorcDescuento").value;
	var maximo = document.getElementById("rangoSupPorcDescuento").value;
	var indCreadesc = document.getElementById("indCreaDescuento").value;
	if (indCreadesc=='1'){
		alert('No dispone de privilegios para modificar los Descuentos');
		return;
	}
	alert("minimo::"+minimo);
	alert("maximo::"+maximo);
		
}*/

//------------------------------------------------------------------------------
</script>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
</head>

<body onLoad="calcularTotalAPagar();">
<html:form  action="/DesplegarCargosAction">
<table id="test" width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>
</html:form>
</body>
</html:html>