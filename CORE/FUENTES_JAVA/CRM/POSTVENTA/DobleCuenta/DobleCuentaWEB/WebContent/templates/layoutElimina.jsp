<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Eliminar Registros Facturación Doble Cuenta</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='pages/js/validate2.js'></script>
<script language="JavaScript">

var idesEliminar = Array();

function agregar(idFactura){
	
	idesEliminar[idesEliminar.length]=idFactura;
	obtenerChecks();		
}
		
function obtenerChecks(){
	var checkeados = '';
	for(i=0; i<idesEliminar.length; i++){
		checkeados+= idesEliminar[i]+'|';
	}		
}

function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
  document.getElementById("identMsg").innerHTML = "";
}

function eliminarDatosGrilla(){
	
	var radios = eval('document.FacturacionDifForm.listaCheckGrilla');
    var ningunockeckeado=true;
    
    if(radios.value != null)
    {
    	if (radios.checked){
    	   ningunockeckeado=false;
    	}else{
    	   ningunockeckeado=true;
    	}
    }else{
    	
    	for (i=0;i < radios.length;i++)
	    {
	       if(radios[i].checked)
	         { 
	            ningunockeckeado=false;
	            break;
	         }else{
	            ningunockeckeado=true;
             }
        }   
    }
    
    if (ningunockeckeado == true)
    {
      document.getElementById("mensajes").innerHTML = "Debe seleccionar un registro de la tabla antes de eliminar";
    }     
    else if(ningunockeckeado == false){
       	
       	document.getElementById("eliminarDatGrilla").value="";
		document.forms[0].action="<%=request.getContextPath()%>/EliminaDobleFacturaAction.do";
		document.forms[0].submit();
    }
 } 

function validarMensaje(){

<logic:present name="eliminado" scope="request">
    document.getElementById("mensajes").innerHTML = "Los datos asociados fueron dados de baja con exito"; 
</logic:present>

}

function MarcarCheckAll( formulario ,valor ) {
	var i
	for (i=0; i < formulario.elements.length; i++) {
            if(!formulario.elements[i].disabled){
				formulario.elements[i].checked =valor.checked	//lo marca
			}	
		}
}
function buscarAbonado(){
	document.getElementById("mensajes").innerHTML = "Debe hacer clic en Alta Doble Cuenta para realizar la Busqueda por Abonados.";      
 }
 function buscarCliente(){
 	document.getElementById("mensajes").innerHTML = "Debe hacer clic en Alta Doble Cuenta para realizar la Busqueda por Cliente Asociado.";      
 }
function asociarDatos(){
	document.getElementById("mensajes").innerHTML = "Debe hacer clic en Alta Doble Cuenta para realizar la Asociación";      
 }
 
</script>
</head>
<body class="body">
<html:form action="/EliminaDobleFacturaAction.do">

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

</html:form>
</body>
</html:html>