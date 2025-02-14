<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="idbotonBuscar" value="${sessionScope.idBoton}"></c:set>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<c:set var="error" value="${requestScope.ERRORBUSCAR}"></c:set>

<script type='text/javascript' src='dwr/interface/JClienAfinesDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/js/FCheck.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/img/botones/presiona.js" type="text/javascript"></script>
<script language="javascript">

  var tipoBusqueda;
  var botonBuscar = "<c:out value="${idbotonBuscar}"/>" ;
  var errorBuscar = "<c:out value="${error}"/>";
  
function f_inicio(){
	if(errorBuscar == "clienNoExiste"){ 
		document.getElementById("mensajes").innerHTML = "Cliente ingresado no existe.";  
	}else if(errorBuscar=="clienRepetido") { 
	    document.getElementById("mensajes").innerHTML = "C\u00F3digo de cliente se encuentra repetido.";
   }
}

function limpiaText(){

	document.getElementById("numeroCelular").value="";
	document.getElementById("mensajes").innerHTML = "";
}

function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
}

function validaIdentificador(){

var valorClic=select1.value;

}

function habilitaCombo(combo)
  {
    var valorClic=combo.value;
    
  	if(valorClic=="ident")
  	{
  		document.getElementById("select2").style["display"]=""
  		document.getElementById("vieneCelular").value="id";
  		tipoBusqueda = document.getElementById("vieneCelular").value;
  		
  	}else{
  		document.getElementById("select2").style["display"]="none"
  		document.getElementById("vieneCelular").value="cel";
  		tipoBusqueda = document.getElementById("vieneCelular").value;
  	}
    
 }


function validaInpuText()
  {
   var tipoBusq = tipoBusqueda;
   var traenumeros = document.getElementById("numeroCelular").value;
   var ningunCodigo= true;
   var num=new Number(traenumeros);
     
   
   if (tipoBusq  == "cel"){
   
       if((traenumeros == null)  || (traenumeros == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Debe ingresar código de cliente"; 
          ningunCodigo= false;
        }
       else if(isNaN(num))
        {        
          document.getElementById("mensajes").innerHTML = "Debe ingresar solo números en  N° Celular."; 
          ningunCodigo= false;      
        }
    
    }
   
   
   if (tipoBusq == "id"){
      
       if((traenumeros == null)  || (traenumeros == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Debe ingresar código de Cliente"; 
          ningunCodigo= false;
        }
      
       /*if(traenumeros.value != null)
        {
    	    if (!isAlphanumeric2(traenumeros)){
    	      ningunCodigo= false;
    	      document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfanumericos"; 
    	    }
        }else{   
    		      
			       if (!isAlphanumeric2(traenumeros))
					 {
				        document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfanumericos";  
				        ningunCodigo= false;
				     }			   
	          }*/
   }
    
   return ningunCodigo;
     
     
}      

function buscarCliente()
  {
      
      if(validaInpuText()){
        document.forms[0].action="<%=request.getContextPath()%>/ClienBuscaAfinesAction.do";
        document.forms[0].submit();
 
     }
 } 
 
 
  
function volverAfines()
  {
    var radios=eval('document.ClienAfinesForm.itemRadioChequeados');
    var ningunockeckeado=true;
    var isNullList=false;
    if (radios+""=="undefined"){
       isNullList=true;
    }
  if (!isNullList) { 
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
    }
    if (ningunockeckeado == true)
    {
    
      document.getElementById("mensajes").innerHTML = "Debe seleccionar un cliente antes de aceptar";
    }     
    else if(ningunockeckeado == false){
          
      document.forms[0].action="<%=request.getContextPath()%>/ClienAgregaAfinesAction.do";
      document.forms[0].submit();
    }
 }  

function volverAClientes()
  {
    document.getElementById("volverAlistado").value="vol"; 
    document.forms[0].action="<%=request.getContextPath()%>/ClienBuscaAfinesAction.do";
    document.forms[0].submit();
  }
  
  function validaListaClientes(){
	var lista=eval('document.ClienAfinesForm.listDTO');
	var isNulllista=false;
	
	
	if (botonBuscar+""=="BUSCAR"){
		if (lista+""=="undefined"){
		   document.getElementById("mensajes").innerHTML = "No existen clientes asociados";
		}
	}
}
  
</script>


<link href="css/mas.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Busqueda de Clientes</title>
</head>
<body  onload="habilitaCombo(this);validaListaClientes();f_inicio();">
<html:form  action="/ClienBuscaAfinesAction.do">
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
</table>
</html:form>
</body>
</html:html>
