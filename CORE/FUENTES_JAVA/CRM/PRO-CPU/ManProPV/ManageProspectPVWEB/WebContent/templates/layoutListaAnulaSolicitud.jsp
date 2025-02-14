<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%// <script type='text/javascript' src='/ManReqWEB/dwr/engine.js'></script>
//<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />


<!-- <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>  -->

<script language="javascript">

var controlesId=new Array();
var controlesHab=new Array();
var controlesVis=new Array();

var checksSolicitud=new Array();
var indice=0;

<logic:iterate id="control" name="controlesList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO">
	controlesId[indice]="<bean:write name='control' property='id'/>";
	controlesHab[indice]="<bean:write name='control' property='habilitado'/>";
	controlesVis[indice]="<bean:write name='control' property='visible'/>";
	indice++;
 </logic:iterate>
indice=0;
<logic:iterate id="checkSol" name="checksSolicitud"  type="java.lang.String">
	checksSolicitud[indice]="<bean:write name='checkSol'/>";
	indice++;
</logic:iterate>

window.onload = function() {
	valoresDefaultCarga();
	chequearSolicitudes();
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


function asignaValorAControl()
{
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
       
}  


function descripcionTipo(cod){		
		
		if (cod=='PAFN'){
			document.write('Afines');
			return true;
		}
				
}

function descripcionIndCond(cod){

		if (cod=='O'){
			document.write('Opcional');
			return true;
		}
		if (cod=='D'){
			document.write('Default');
			return true;
		}
}


function enviarFormulario(){

	document.forms[0].action="<%=request.getContextPath()%>/anulaSolicitud/FlujoAnulaSolicitud.do";
    document.forms[0].submit();
}

function enviarFormulario1(){
    var pers = <c:out value="${sessionScope.ListaAnulaSolicitudForm.personalizados}"/> ;  //PARA VALIDAR QUE AL MENOS HAYA PERSONALIZADO UN PRODUCTO CON NUMEROS
    
    if(!pers){
    	var confirmar = confirm(" No ha personalizado clientes afines. ¿Desea seguir con la orden de servicio?");
    	if(confirmar){
    		document.forms[0].action="<%=request.getContextPath()%>/productoAfin/FlujoProdContratados.do";
    		document.forms[0].submit();
    	}	
    }
    document.forms[0].action="<%=request.getContextPath()%>/productoAfin/FlujoProdContratados.do";
    document.forms[0].submit();
}


function guardarParametros(idProd, codProd, nomProd, indAutoAfin, maxModif, cantModif){
    
	document.getElementById("idProductoContratado").value = idProd ;
	document.getElementById("codigoProducto").value = codProd ;
	document.getElementById("nombreProducto").value = nomProd;
	
	if (indAutoAfin != "S"){
		document.forms[0].action="<%=request.getContextPath()%>/productoAfin/PersonalizaClientesAfines.do";
    	document.forms[0].submit();
	}

}

function sobreElBoton(id,imagen){
	
 	document.getElementById(id).src=imagen;
 	//document.getElementById(id).style="cursor:pointer";
}

function checkearDescheckear(valorCheck)
{
	try
	{
		if (valorCheck.checked){
		   chequearTodos();
		}else{
		   desChequearTodos();
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En checkearDescheckear()");
	}
}


function chequearSolicitudes()
{
 	
  	var abonadosCheck = eval("document.ListaAnulaSolicitudForm.listaAbonados");
  	try
	{
		if (abonadosCheck.value != null){
			abonadosCheck.checked = true;
		}else{
			for(var i=0; i<abonadosCheck.length; i++){
				//alert("checksSolicitud["+i+"] "+checksSolicitud[i]);
				if(checksSolicitud[i] == 'true')
				{
					abonadosCheck[i].checked = true;
					abonadosCheck[i].disabled= true;
				}	
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En chequearTodos()");
	}
}
function chequearTodos()
{
 	
  	var abonadosCheck = eval("document.ListaAnulaSolicitudForm.listaAbonados");
  	try
	{
		if (abonadosCheck.value != null){
			abonadosCheck.checked = true;
		}else{
			for(var i=0; i<abonadosCheck.length; i++){
				abonadosCheck[i].checked = true;
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En chequearTodos()");
	}
}

function desChequearTodos()
{
  	try
	{
		var abonadosCheck = eval("document.ListaAnulaSolicitudForm.listaAbonados");
		if (abonadosCheck.value != null){
			abonadosCheck.checked = false;
		}else{
			for(var i=0; i<abonadosCheck.length; i++){
				if(abonadosCheck[i].disabled == false)
				{
					abonadosCheck[i].checked = false;
				}
				
			}
		}
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En desChequearTodos()");
	}

}
function validaCheck(opcion)
{
    var mensajes=document.getElementById("mensajes");
    var opcionChekeada=opcion.value;
    mensajes.innerHTML="";
    activaBotonSiguiente();
} 

function activaBotonSiguiente()
{
	document.getElementById("Siguiente1").disabled=false;
	document.getElementById("Siguiente2").disabled=false;
}  
  
function desactivaBotonSiguiente()
{
	document.getElementById("Siguiente1").disabled=true;
	document.getElementById("Siguiente2").disabled=true;
}
function impAlert(ma)
{
	alert(ma);
}
function salir(){
	window.close();
}
</script>

</head>

<body >

<html:form  method="POST" action="/ListAnulaSolicitudAction.do">

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