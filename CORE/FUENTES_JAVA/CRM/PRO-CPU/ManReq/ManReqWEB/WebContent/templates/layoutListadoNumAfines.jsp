<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<html:html>
<head>
<!-- <script type='text/javascript' src='dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>  -->

<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>

<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<c:set var="productoOS" value="${sessionScope.productoAfinSelec}"></c:set>

<script language="javascript">

var maximoNumeros="<c:out value="${productoOS.maximo}"/>";

function cargarClienteBuscado()
{
	var clienteACargar="";
 
	 <logic:present name="clienteBuscado" scope="request">
	 	clienteACargar='<bean:write name="clienteBuscado"/>'
	 </logic:present>
	 
	 if(clienteACargar!="")
	 {
	 	document.getElementById("codigoCliente").value=clienteACargar;
	 	enviarFormulario();	 	
	 }	
}


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
     document.getElementById("mensajes").innerHTML = "Ingresó Un Código Vacio. Debe Ingresar Nuevamente"; 
     ningunCodigo= false;
   }
   else if(isNaN(num))
   {        
       document.getElementById("mensajes").innerHTML = "Debe Ingresar Sólo Números en Código Cliente."; 
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
	    document.getElementById("mensajes").innerHTML = "No Puede Ingresar Más de "+maximoAfines+" Clientes.";       
	  
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



function validarMensaje(){
 
 <logic:present name="clienteRepetido" scope="request">
    document.getElementById("mensajes").innerHTML = "El Cliente Seleccionado Ya Se Encuentra en la Lista de Clientes"; 
</logic:present> 

<logic:present name="clienRepetidoEnProducto" scope="request">
    document.getElementById("mensajes").innerHTML = "El Número de Cliente Ingresado Ya Existe Para Otro Producto"; 
</logic:present> 

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
	  document.getElementById("mensajes").innerHTML = "El Cliente Seleccionado No Existe.";
   }
   else if(result=="clienRepetidoEnProducto")
   {   
      document.getElementById("mensajes").innerHTML = "El Número de Cliente Ingresado Ya Existe Para Otro Producto.";       
   }
   else if(result=="clienteSession")
   {   
      document.getElementById("mensajes").innerHTML = "El Código de Cliente Ingresado Debe ser Distinto al Propio Usuario.";       
   }
   else if(result=="clienRepetido")
   { 
     document.getElementById("mensajes").innerHTML = "El Código de Cliente se Encuentra Repetido.";
   }
   else
   {
      if(puedeSeguir(maximoNumeros))
      {
          document.forms[0].action="<%=request.getContextPath()%>/productoAfin/PersonalizaClientesAfines.do";
		  document.forms[0].submit();
	  }
	  else
	  {
	     document.getElementById("mensajes").innerHTML = "Número Máximo de Clientes Permitidos. Si Desea Ingresar Otro Cliente, Debe Eliminar a Uno.";       	  
	  }    
   }   
}
//------------------------------------------------------------------------------


function salir(){
	window.close();
}


</script>   
</head>
<body >

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