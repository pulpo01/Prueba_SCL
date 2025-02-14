<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<!-- Se realiza Llamado a DWR  -->
<script type='text/javascript' src='/ManReqWEB/dwr/interface/JOrdServAboBenef.js'></script>
<script type='text/javascript' src='/ManReqWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManReqWEB/dwr/util.js'></script>



<script language="javascript">

var controlesId=new Array();
var controlesHab=new Array();
var controlesVis=new Array();
var indice=0;
<logic:iterate id="control" name="controlesList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO">
	controlesId[indice]="<bean:write name='control' property='id'/>";
	controlesHab[indice]="<bean:write name='control' property='habilitado'/>";
	controlesVis[indice]="<bean:write name='control' property='visible'/>";
	indice++;
 </logic:iterate>
 
 


window.onload = function() {
	valoresDefaultCarga();
}

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

	
var nav4 = window.Event ? true : false;
function acceptNum(evt){     
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57     
      var tecla = nav4 ? evt.which : evt.keyCode;    
      return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}

function validaNumeroLetraVacio(arg){
	//retorna :
	//0 : vacio;
	//1 : letra
	//2 : ok es numero
	var isValid=2;
	var str=arg;
	if (str+"" == "undefined" || str+"" == "null" || str+"" == "") {
			return 0;
	}
	
	// convert to a string for performing string comparisons.
	str += ""; 
	// Loop through length of string and test for any alpha numeric 
	// characters
	for (i = 0; i < str.length; i++){
	  // Alphanumeric must be between "0"-"9", "A"-"Z", or "a"-"z"
	  if (!(((str.charAt(i) >= "0") && (str.charAt(i) <= "9")))){
		  isValid = 1;
		  break;
	   } 
    }
    return isValid;
}

function imp(a){
	alert(a)
}

  
function formularioAnterior()
  {
  try{
  	habilitarTodosTextos()
  	document.getElementById("botonSeleccionado").value = "anterior";
    document.forms[0].submit();
  }catch(e){
  alert(e.name + " - "+e.message+" en formularioAnterior");
  }
  }

 var errorModPago = "OK";

var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}


 function checkearDescheckear(valorCheck)
   {
	   	if (valorCheck.checked){
	   	   chequearTodos();
	   	}else{
	   	   desChequearTodos();
	   	}
   
   }
   function desChequearTodos()
{
 	
  	var abonadosCheck = eval("document.ManAboBeneForm.listaNumAbonados");
	if (abonadosCheck!=null){
	  	if (abonadosCheck.value != null){
	  		abonadosCheck.checked = false;
	  	}else{
	  		for(var i=0; i<abonadosCheck.length; i++){
	  			abonadosCheck[i].checked = false;
	  		}
	  	}
  	}
}


	function chequearTodos()
	{
	 	
	  	var abonadosCheck = eval("document.ManAboBeneForm.listaNumAbonados");
	  	if (abonadosCheck!=null){
		  	if (abonadosCheck.value != null){
		  		abonadosCheck.checked = true;
		  	}else{
		  		for(var i=0; i<abonadosCheck.length; i++){
		  			abonadosCheck[i].checked = true;
		  		}
		  	}
	  	}
	}
	
	
	function asignaValorAControl()
{
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
} 

	function enviarFormulario()
	{
		document.getElementById("btnSiguiente").value="SIGUIENTE";
		document.forms[0].submit();
	}
	




function valoresDefaultCarga()
{
    
    var condiciones=document.getElementById("condicionesCK");
    var valorCondicion=document.getElementById("condicH").value;
    
    if (valorCondicion=="SI"){
        condiciones.checked=true;
    }else{
        condiciones.checked=false;
        document.getElementById("condicH").value="NO";
    }
    	
	for(i=0;i<controlesId.length;i++)
	{
	   	seteaControl(controlesId[i], controlesHab[i], controlesVis[i]);
	} 

}


function seteaControl(control, habilitado, visible)
{ 
    if (visible=="NO"){
		document.getElementById(control).style["display"]="none";
	}else{
	    if(habilitado=="NO"){
	        document.getElementById(control).disabled=true;
	    }else{
	    	document.getElementById(control).disabled=false;
	    }
	}
	 
}



	
function salir(){
	window.close();
}
</script>
</head>

<body>


<html:form  method="POST" action="/MantencionAbonadosBeneficiarios.do">
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footerOS" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>    
</table>

</html:form>
</body>
</html:html>