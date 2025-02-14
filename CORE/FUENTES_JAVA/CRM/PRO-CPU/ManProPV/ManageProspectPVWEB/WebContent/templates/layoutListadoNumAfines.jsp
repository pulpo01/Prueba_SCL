<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .:  <c:out value="${clienteOS.nombOss}"/>:.</title>
<!-- <script type='text/javascript' src='dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>  -->

<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>

<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<c:set var="productoOS" value="${sessionScope.productoAfinSelec}"></c:set>
<c:set var="error" value="${requestScope.ERRORELIMINAR}"></c:set>


<script language="javascript">

var maximoNumeros="<c:out value="${productoOS.maximo}"/>";
//(+) EV 03/02/09
var cantidadModificaciones="<c:out value="${productoOS.cantModificaciones}"/>";
var maximoModificaciones="<c:out value="${productoOS.maxModificaciones}"/>";
var idProdContratado="<c:out value="${productoOS.idProdContratado}"/>";
var errorEliminar = "<c:out value="${error}"/>";

function inicio(){
	if(errorEliminar == "superaMaximo"){ //viene de eliminar
		document.getElementById("mensajes").innerHTML = "Ha superado el  m\u00E1ximo de modificaciones permitidas.";  
	}else{ //podria haber ingresado por buscador de clientes
		var clienteACargar="";
		 <logic:present name="clienteBuscado" scope="request">
		 	clienteACargar='<bean:write name="clienteBuscado"/>'
		 </logic:present>
		 
		 if(clienteACargar!="")
		 {
	       	  JClienAfinesDWR.validaModificaciones(idProdContratado,maximoModificaciones,cantidadModificaciones,"I",clienteACargar,validaModificacionesBuscadorAjaxReturn);
		 }	
	}//fin else
	
	 <logic:present name="clienteRepetido" scope="request">
    	document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente ingresado ya existe para este producto."; 
	</logic:present> 

	<logic:present name="clienRepetidoEnProducto" scope="request">
    	document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente ingresado ya existe para otro producto."; 
	</logic:present> 
}

function validaModificacionesBuscadorAjaxReturn(resultado){

		if (resultado=="OK"){
			 var clienteACargar="";
			 <logic:present name="clienteBuscado" scope="request">
			 	clienteACargar='<bean:write name="clienteBuscado"/>'
			 </logic:present>
		
		 	document.getElementById("codigoCliente").value=clienteACargar;
		 	enviarFormulario();	 	
		}else if (resultado=="superaMaximo"){
			  document.getElementById("mensajes").innerHTML = "Ha superado el  m\u00E1ximo de modificaciones permitidas.";       	  
		}else{
			  document.getElementById("mensajes").innerHTML = "Error al validar m\u00E1ximo de modificaciones.";       	  
		}
}
//(-) EV

function limpiaText()
{
document.getElementById("codigoCliente").value="";
}


function limpiaMensajeError()
{
  document.getElementById("mensajes").innerHTML = "";
}


function enviarFormulario()
  {
   var traenumeros = document.getElementById("codigoCliente").value;
   var ningunCodigo= true;
   var num=new Number(traenumeros);  
   limpiaMensajeError(); 
   
   if((traenumeros == null)  || (traenumeros == ""))
   {   
     document.getElementById("mensajes").innerHTML = "Debe ingresar c\u00F3digo de cliente."; 
     ningunCodigo= false;
   }
   else if(isNaN(num))
   {        
       document.getElementById("mensajes").innerHTML = "Debe ingresar s\u00F3lo números en Código Cliente."; 
       ningunCodigo= false;      
   }
   else  
   {
        document.getElementById("numeroAgregar").value = traenumeros;
        validaCodClienteAjax(traenumeros);        
	 
   }
}

function guardarAProducto()
{
    // document.getElementById("cancelarAfines").value="guardar"; 
    document.getElementById("guardarCancelar").value ="guardar";
    document.getElementById("estadoValidacion").value="";   //al pasar por la clase resetea si el cliente fue validado
    document.forms[0].action="<%=request.getContextPath()%>/productoAfin/PersonalizaClientesAfines.do";
    document.forms[0].submit();
}






function buscarFormulario()
{
  limpiaMensajeError();
  var maximoAfines = maximoNumeros;  // valor seteado en la cabecera proveniente del producto

  if(puedeSeguir(maximoAfines))
      {
       document.getElementById("buscar").value="1";
       document.forms[0].action="<%=request.getContextPath()%>/productoAfin/ClienBuscaAfinesAction.do";
       document.forms[0].submit();
	  }else{
	    document.getElementById("mensajes").innerHTML = "No puede ingresar m\u00E1s de "+maximoAfines+" clientes.";       
	  
	  }   

}



// revisar esta funcionar porque al parecer esta mala la forma de obtener los chequeados???
function puedeSeguir(maximoAfines)
  {
     var maxAfinesNum=new Number(maximoAfines);
     var totalClien = 0;
     var radios = document.ListaProdContratadosForm.itemChequeados;
     var retorno=true;
     
 
     if(radios == null){
        return retorno;
     } 
    
     if(radios.value != null){
         totalClien = 1 ;
   
     }else{

           totalClien = radios.length;  
           if(radios.length >= maxAfinesNum )
           {
             retorno=false;
           }
     }
      return retorno;
      

}


function eliminarRegistro(){
    document.getElementById("guardarCancelar").value ="eliminar";
    document.forms[0].action="<%=request.getContextPath()%>/productoAfin/ClienElimAfinesAction.do";
    document.forms[0].submit();

}


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DWR -- 
//---------------------------------------------------------------------------

function validaCodClienteAjax(codCliente)
{
    JClienAfinesDWR.validaClienAfinRepetido(codCliente,validaCodClienteAjaxReturn);
}
//----------------------------------------------------------------------------
// RETURN --
//----------------------------------------------------------------------------

function validaCodClienteAjaxReturn(data)
{
   var result=data;
   
   document.getElementById("estadoValidacion").value = result;
   
   if(result=="clienNoExiste")
   {
	  document.getElementById("mensajes").innerHTML = "Cliente ingresado no existe.";
   }
   else if(result=="clienRepetidoEnProducto")
   {   
      document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente ingresado ya existe para otro producto.";       
   }
   else if(result=="clienteSession")
   {   
      document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente ingresado debe ser distinto al propio.";       
   }
   else if(result=="clienRepetido")
   { 
     document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente ingresado ya existe para este producto.";
   }
   else
   {
      if(puedeSeguir(maximoNumeros))
      {
      	  //(+) EV 03/02/09 valida max modificaciones
      	  var numeroIngresado = document.getElementById("codigoCliente").value
       	  JClienAfinesDWR.validaModificaciones(idProdContratado,maximoModificaciones,cantidadModificaciones,"I",numeroIngresado,validaModificacionesAjaxReturn);
       	  //(-)
	  }
	  else
	  {
	     document.getElementById("mensajes").innerHTML = "Ha superado el m\u00E1ximo de clientes permitidos.";       	  
	  }    
   }   
}
//------------------------------------------------------------------------------
//(+) EV 03/02/09
function validaModificacionesAjaxReturn(resultado)
{
		if (resultado=="OK"){
	          document.forms[0].action="<%=request.getContextPath()%>/productoAfin/PersonalizaClientesAfines.do";
			  document.forms[0].submit();
		}else if (resultado=="superaMaximo"){
			  document.getElementById("mensajes").innerHTML = "Ha superado el m\u00E1ximo de modificaciones permitidas.";       	  
		}else{
			  document.getElementById("mensajes").innerHTML = "Error al validar m\u00E1ximo de modificaciones.";       	  
		}
}
//(-)

function salir(){
	window.close();
}

function esnumero(){

  if(event.keyCode<47 || event.keyCode>57)
	event.keyCode=0;
}

</script>   
</head>
<body onload="inicio();">

<html:form method="POST" action="/PersonalizaClientesAfines.do">

<table width="100%">
  
  <tr>
    <td colspan="2"><tiles:insert attribute="titleOS" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>    
  
</table>
</html:form>
</body>



</html:html>