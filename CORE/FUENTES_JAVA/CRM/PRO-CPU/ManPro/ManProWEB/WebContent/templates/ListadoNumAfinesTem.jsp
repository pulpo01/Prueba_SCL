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
<script type='text/javascript' src='dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>

<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/numerosFrec.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<c:set var="numeroMax" value="${sessionScope.numeroMax}"></c:set>

<title>Personalización Lista de Afines</title>
<script language="javascript">

var maximoAfines="<c:out value="${numeroMax}"/>";

var isActivoBotonAgregar=true;
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

function limpiaText(){

document.getElementById("codigoCliente").value="";
}

function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
}

function enviarFormulario(maxClientes)
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
   else if(!puedeSeguir(maxClientes))
   {
   	   document.getElementById("mensajes").innerHTML = "No puede ingresar más de "+maxClientes+" clientes."; 
       ningunCodigo= false;   
   }
   else  
   {
	  if (isActivoBotonAgregar){
		  isActivoBotonAgregar=false;
	  	  validaCodClienteAjax(traenumeros);  
	   }
   }
  }
function buscarFormulario(maximoAfines)
{
	limpiaMensajeError();

  if(puedeSeguir(maximoAfines))
      {
       document.getElementById("buscar").value="1";
       document.forms[0].action="<%=request.getContextPath()%>/ClienBuscaAfinesAction.do";
       document.forms[0].submit();
	  }else{
	    document.getElementById("mensajes").innerHTML = "No puede ingresar más de "+maximoAfines+" clientes.";       
	  
	  }   

}


function volverAProducto()
  {
    document.getElementById("cancelarAfines").value="cancel"; 
    document.forms[0].action="<%=request.getContextPath()%>/producto.do";
    document.forms[0].submit();
  }

function guardarAProducto()
  {
    document.getElementById("cancelarAfines").value="guardar"; 
    document.forms[0].action="<%=request.getContextPath()%>/ClienAfinesAction.do";
    document.forms[0].submit();
  }



function puedeSeguir(maximoAfines)
  {
     var maxAfinesNum=new Number(maximoAfines);
     var totalClien = 0;
     var radios = document.ClienAfinesForm.itemChequeados;
     var retorno=true;

     if(radios == null){
        return retorno;
     } 
     
     
     if(radios.value != null){
         totalClien = 1 ;
     }else{
         totalClien = radios.length; 
     }
     
     if (totalClien >= maxAfinesNum){
	     retorno=false;	
     }
     
     return retorno;

}

function validarMensaje(){
 
 <logic:present name="clienteRepetido" scope="request">
    document.getElementById("mensajes").innerHTML = "El cliente seleccionado ya se encuentra en la lista de clientes"; 
</logic:present> 

<logic:present name="clienRepetidoEnProducto" scope="request">
    document.getElementById("mensajes").innerHTML = "El numero de cliente ingresado ya se existe para otro producto"; 
</logic:present> 

}



//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DWR -- 
//---------------------------------------------------------------------------

function validaCodClienteAjax(codCliente)
{
	JClienAfinesDWR.validaClienAfinRepetido(codCliente,validaCodClienteAjaxReturn);
	isActivoBotonAgregar=true;
}
//----------------------------------------------------------------------------
// RETURN --
//----------------------------------------------------------------------------

function validaCodClienteAjaxReturn(data)
{
   var result=data;
   
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
      if(puedeSeguir(maximoAfines))
      {
	      document.forms[0].action="<%=request.getContextPath()%>/ClienAfinesAction.do";
		  document.forms[0].submit();
	  }
	  else
	  {
	     document.getElementById("mensajes").innerHTML = "Ha superado el m\u00E1ximo de clientes permitidos.";       	  
	  }    
   }   
}
//------------------------------------------------------------------------------

</script>   
</head>
<body >

<html:form  action="/ClienAfinesAction.do">
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