<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<html:html>

<html:form method="POST" action="SelectTipoComportamientoAction.do" >
<html:hidden property="opcion" value="inicio"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='dwr/interface/JPlanesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<script language="javascript">  
<bean:define id="cliente" name="ClienteOOSS" scope="session"/>
function validaCheck(opcion)
{
    var mensajes=document.getElementById("mensajes");
    var opcionChekeada=opcion.value;
    mensajes.innerHTML="";
	activaBotonSiguiente();
   	if (!opcion.checked) document.getElementById("checkTodos").checked = false;
}
function checkearDescheckear(valorCheck)
{
	if (valorCheck.checked){
		chequearTodos();
	}else{
		desChequearTodos();
	} 
}

function chequearTodos()
{
  	var tiposCompCheck = eval("document.SelectTipoComportamientoForm.listaTiposCom");
	if (tiposCompCheck != undefined){
	  	if (tiposCompCheck.value != null){
	  		tiposCompCheck.checked = true;
	  	}else{
	  		for(var i=0; i<tiposCompCheck.length; i++){
	  			tiposCompCheck[i].checked = true;
	  		}
	  	}
  	}
}

function desChequearTodos()
{
  	var tiposCompCheck = eval("document.SelectTipoComportamientoForm.listaTiposCom");
  	if (tiposCompCheck != undefined){
	  	if (tiposCompCheck.value != null){
	  		tiposCompCheck.checked = false;
	  	}else{
	  		for(var i=0; i<tiposCompCheck.length; i++){
	  			tiposCompCheck[i].checked = false;
	  		}
	  	}
	}  	
}

function hayCheckeados()
{
  	var tiposCompCheck = eval("document.SelectTipoComportamientoForm.listaTiposCom");
  	if (tiposCompCheck != undefined){
	  	if (tiposCompCheck.value != null){
	  		if(tiposCompCheck.checked)
	  		{
	  			return true;
	  		}
	  	}else{
	  		for(var i=0; i<tiposCompCheck.length; i++){
	  			if(tiposCompCheck[i].checked)
		  		{
		  			return true;
		  		}
	  		}
	  	}
	}
	return false;	
}

/*function enviarFormulario()  {
	//desactivaBotonSiguiente();
	if(!hayCheckeados())
	{
		alert("Seleccione al menos un tipo de comportamiento");
		return;
	}
	document.getElementById("opcion").value = "grabar";
	document.forms[0].submit();
}*/

function enviarFormulario()  {
	var tiposComportamiento = obtenerTipoComportamiento();
	if (tiposComportamiento == "") {
    	alert("Seleccione al menos un tipo de comportamiento")
    	return false;
    }
    
    document.getElementById("lbMensajePA").innerHTML = "Cargando Planes Adicionales ... ";
    JPlanesDWR.obtenerPlanesAbonado(tiposComportamiento, fncResultadoObtenerPlanesAbonado);
	//document.getElementById("opcion").value = "grabar";
	//document.forms[0].submit();
}

/*function desplegarPorAbonado(idAbonado)
{
	var tiposComportamiento = obtenerTipoComportamiento();
	if (tiposComportamiento == "") {
    	alert("Seleccione al menos un tipo de comportamiento")
    	return false;
    }
    
   	abonadoSeleccionado = idAbonado;
   	JPlanesDWR.obtenerPlanesAbonado(idAbonado,tiposComportamiento, fncResultadoObtenerPlanesAbonado);
 	//abonado(document.forms[0],idAbonado);	
}*/

function fncResultadoObtenerPlanesAbonado(data){
	document.getElementById("lbMensajePA").innerHTML = "";
	if (data!=null) {
        var codError = data['codError']; 
        var mensajeError =  data['msgError']; 
        if (codError != "" ) {
        	alert("Error: "+mensajeError);
        	return;
        }
        
        var abrirPopupFiltro = data['abrirPopupFiltro'];
        if (abrirPopupFiltro == 'S'){ //abre ventana con listado de planes  
	      	var url = "<%=request.getContextPath()%>/pages/listadoPlanes.jsp";
	        var cadenaProductos = window.showModalDialog(url, "winPlanes", "dialogHeight:550px; dialogWidth:550px; center:yes; menubar:no;help:no; status:no; resizable:no");

			if (cadenaProductos!=null && cadenaProductos!=""){//si no selecciona productos no puede continuar
				document.getElementById("lbMensajePA").innerHTML = "Cargando Planes Adicionales ... ";
				document.getElementById("cadenaProductosSeleccionados").value = cadenaProductos;
				document.getElementById("opcion").value = "grabar";
				document.forms[0].submit();
		    }
	    }else{ // despliega todos los planes para abonado-prestacion
			    document.getElementById("lbMensajePA").innerHTML = "Cargando Planes Adicionales ... ";
				document.getElementById("cadenaProductosSeleccionados").value = "";
				document.getElementById("opcion").value = "grabar";
				document.forms[0].submit();
	    }
        
    }//fin if (data!=null)		
}

function obtenerTipoComportamiento(){
	var tiposComportamiento = "";
 	var tiposCompCheck = document.forms[0].listaTiposCom;
   	if (tiposCompCheck.length == undefined){  //Solo hay un registro  
       	if (tiposCompCheck.checked)  	tiposComportamiento = tiposCompCheck.value;
   	} 
  		else {
		for(var i=0;i<=tiposCompCheck.length-1;i++)	{
		  if (tiposCompCheck[i].checked){
		  		if (tiposComportamiento=="") 	tiposComportamiento = tiposCompCheck[i].value;
		  		else					  		tiposComportamiento = tiposComportamiento+","+tiposCompCheck[i].value;
		  }
		}
	}
	return tiposComportamiento;
}
	


function activaBotonSiguiente()
{
   document.getElementById("Siguiente1").disabled=false;
   document.getElementById("Salir2").disabled=false;
}  

function desactivaBotonSiguiente()
{
   document.getElementById("Siguiente1").disabled=true;
   document.getElementById("Salir2").disabled=true;
}

function sobreElBoton(id,imagen){
	try{
	 	document.getElementById(id).src=imagen;
 	    document.getElementById(id).style="cursor:pointer";

	}catch(e){
		//impAlert(e.name + " - "+e.message+" En sobreElBoton() id "+id+" imagen "+imagen);
	}
}

function salir(){
	window.close();
}

function impAlert(ma)
{
	alert(ma);
}
</script>
</head>

<body>
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>   
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</body>
</html:form>
</html:html>