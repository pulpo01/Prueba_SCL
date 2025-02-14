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
<script type='text/javascript' src='dwr/interface/JPlanesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>

<script language="JavaScript" src="pages/js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>
<script languaje="javascript">
var abonadoSeleccionado = "";

    //Es para habilitar el boton de portal de venta
    function habilitaBotonPortalVenta(){
    	this.parent.document.getElementById("btnContinuar").disabled = false;
    }

	function desplegarPorCliente()
	{
		var tiposComportamiento = obtenerTipoComportamiento();
		if (tiposComportamiento == "") {
	    	alert("Seleccione al menos un tipo de comportamiento")
	    	return false;
	    }
	    
		abonadoSeleccionado = "0";
		JPlanesDWR.obtenerPlanesAbonado("0",tiposComportamiento, fncResultadoObtenerPlanesAbonado);
	 	//abonado(document.forms[0],"0");	
	}
	
	function desplegarPorAbonado(idAbonado)
	{
		var tiposComportamiento = obtenerTipoComportamiento();
		if (tiposComportamiento == "") {
	    	alert("Seleccione al menos un tipo de comportamiento")
	    	return false;
	    }
	    
    	abonadoSeleccionado = idAbonado;
    	JPlanesDWR.obtenerPlanesAbonado(idAbonado,tiposComportamiento, fncResultadoObtenerPlanesAbonado);
	 	//abonado(document.forms[0],idAbonado);	
	}
	
	function fncResultadoObtenerPlanesAbonado(data){
		
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
			        abonado(document.forms[0],	abonadoSeleccionado, cadenaProductos);
			    }
		    }else{ // despliega todos los planes para abonado-prestacion
	            abonado(document.forms[0],	abonadoSeleccionado, "");
		    }
	        
	    }//fin if (data!=null)		
	}

	
	function sendContratarPorDefecto()
	{
		document.getElementById("contratarPorDefecto").value="1";
		var formulario=document.getElementById("contratarPorDefecto").form;
		
		//formulario.action="<%=request.getContextPath()%>/GenerarOfertaComercialAction.do";
		formulario.action= "<%=request.getContextPath()%>/GenerarVentaAction.do" // VM 18112010 INC 155400
		formulario.submit();
	}
	
	//(+) lista de comportamientos
	
	function validaCheck(opcion)
	{
	    var opcionChekeada=opcion.value;
		//activaBotonSiguiente(); //VALIDAR ACTIVACION DESACTIVACION DEL BOTON
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
		var tiposCompCheck = document.forms[0].listaTiposCom;
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
		var tiposCompCheck = document.forms[0].listaTiposCom;
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
	
	//(-) lista de comportamientos
	
	function validaTipoComportamiento(){
	
   		var itemSeleccionado = false;
   		var tiposCompCheck = document.forms[0].listaTiposCom;
	    if (tiposCompCheck.length == undefined){  //Solo hay un registro  
	        if (tiposCompCheck.checked)  	itemSeleccionado = true;
	    } 
	    else {
			for(var i=0;i<=tiposCompCheck.length-1;i++)	{
			  if (tiposCompCheck[i].checked){
				  itemSeleccionado = true;
				  break;
			  }
			}
	    }
	         
	    if (itemSeleccionado == 0) {
	    	alert("Seleccione al menos un tipo de comportamiento")
	    	return false;
	    }
	    
	    return true;
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
	
</script>

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Planes Adicionales del abonado :.</title>

</head>

<body onLoad="cargarRestricciones()">
<html:form action="/cliente">
<table width="100%">
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