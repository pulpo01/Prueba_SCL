<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Cambio de Plan Unificado :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='/ManReqWEB/dwr/interface/BusquedaAbonadosDWR.js'></script>
<script type='text/javascript' src='/ManReqWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManReqWEB/dwr/util.js'></script>
<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>
	
<script language="javascript">
var listaFiltrados = new Array();
var listaFiltradosSelAcum  = new Array();
  	 
function f_buscar(){

	var codCliente = document.getElementById("codCliente").value;
	var numAbonado = document.getElementById("numAbonado").value;
	var numCelular = document.getElementById("numCelular").value;
	var rutAbonado = document.getElementById("rutAbonado").value;
	var tipoPlanTarif = document.getElementById("radioTipoPlan").value;
	var prestacionCB = document.getElementById("prestacionCB").value;
	
	if (numAbonado =="")	numAbonado = "0";
	if (numCelular == "")	numCelular ="0";
	
	var mensajeBusqueda=document.getElementById("mensajeBusqueda");
    mensajeBusqueda.innerHTML="Buscando Abonados ...";
    
	BusquedaAbonadosDWR.obtenerAbonados(codCliente,numAbonado,numCelular,rutAbonado,tipoPlanTarif,prestacionCB, retornoBusquedaAbonados);
	
}


function f_cargaAbonadosSel(){
	var lista = window.filtrados.obtenerSeleccion();

	//obtiene valor de abonado
	if (lista != null && lista.length>0){
		var numAbonado = lista[0][1]; 
		if (numAbonado>0){
			//verificar si puede cargar abonados
			BusquedaAbonadosDWR.obtieneCantidadAbonadosSel( retornoObtieneCantidadAbonadosSel);
		}
	}
	
}

function f_obtieneAbonadosSel(){
	return listaFiltradosSelAcum;
}

function f_obtieneAbonadosFiltrados(){
	return listaFiltrados;
}

	
function f_cargaTipoPlan(codigo){
	var tipoPlanTarif = document.getElementById("radioTipoPlan").value;
	var flgAbonadosDistTipoPlan = document.getElementById("flgAbonadosDistTipoPlan").value;
	
	document.getElementById("radioTipoPlan").value = codigo;
	
	if (flgAbonadosDistTipoPlan != "S"){
		if (tipoPlanTarif != codigo){	
			f_limpiar();
		}
	}
	
}

function f_siguiente(){
 	document.forms[0].submit();
}	

function f_elimAbonadosSel(numAbonado){
	var numAbonado = window.seleccionados.obtenerSeleccion();
	if (numAbonado>0)
		BusquedaAbonadosDWR.eliminaAbonadosSel(numAbonado, retornoElimAbonadosSel);
}

function retornoBusquedaAbonados(retorno){

    var mensajes=document.getElementById("mensajes");
    mensajes.innerHTML="";
	if (retorno != null){
	 	var mensajes=document.getElementById("mensajes");
	  	mensajes.innerHTML=retorno;
	}else{
		window.filtrados.location.reload();
	}
	var mensajeBusqueda=document.getElementById("mensajeBusqueda");
    mensajeBusqueda.innerHTML="";

}

function retornoObtieneCantidadAbonadosSel(numSeleccionados){
	var lista = window.filtrados.obtenerSeleccion();
	var numAbonado = lista[0][1]; 

	var numMaxAbonados = document.getElementById("numMaxAbonados").value;
	
	if (numSeleccionados < numMaxAbonados){
		BusquedaAbonadosDWR.cargaAbonadosSel(numAbonado, retornoCargaAbonadosSel);	
	}else{
		alert("Solo puede seleccionar hasta "+numMaxAbonados+" abonados ");
	}
}



function retornoCargaAbonadosSel(mensaje){

	if ( mensaje != null){
		alert(mensaje);
	}else{
		//actualiza grillas de iframes
		window.seleccionados.location.reload();
		window.filtrados.location.reload();
	}
}

function retornoElimAbonadosSel(retorno){
   var mensajes=document.getElementById("mensajes");
   mensajes.innerHTML="";

	if (retorno != null){
	 	var mensajes=document.getElementById("mensajes");
	  	mensajes.innerHTML=retorno;
	}else{
		window.seleccionados.location.reload();
	}
}

function f_limpiar(){
		document.getElementById("numAbonado").value ="";
		document.getElementById("numCelular").value ="";
		document.getElementById("rutAbonado").value ="";
				
		BusquedaAbonadosDWR.limpia(retornoLimpia);
		
}

function retornoLimpia(){
	window.filtrados.location.reload();
	window.seleccionados.location.reload();
}

var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}


</script>
	 
</head>

<body >

<html:form  method="POST" action="/CambiarPlanAction.do">
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td>
  </tr>
</table>
</html:form>

</body>
</html:html>