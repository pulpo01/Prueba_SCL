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
<title>Facturacion Diferenciada</title>
<script type='text/javascript' src='dwr/interface/JClienDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<script type='text/javascript' src='pages/js/validate2.js'></script>

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/numerosFrec.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/efectos.js" type="text/javascript"></script>
<script language="JavaScript">
var valorCheck='';
function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
  document.getElementById("identMsg").innerHTML = "";
}
function validaVacio(){

	if(document.getElementById("valor").value == ""){
		document.getElementById("identMsg").innerHTML = "Debe ingresar un valor."
		return false
	}else{
		 document.getElementById("identMsg").innerHTML = ""
	}
	return true		
}

function validaMonto(){
	 var comboTipoValor = document.getElementById("tipoValor").value;	
			if((document.getElementById("valor").value > 9999999999)||(document.getElementById("valor").value < 1)){
				document.getElementById("identMsg").innerHTML = "Debe ingresar un monto valido. (0-9999999999) ."
				return false
			}
		if(comboTipoValor == 1){
			if(document.getElementById("valor").value > 100){
				document.getElementById("identMsg").innerHTML = "Debe ingresar un porcentaje valido. (0-100%) ."
				return false
			}			
		}	
		return true		
}

function buscarCliente()  {
		
	// HGG 04-02-2010
	var cantClientes = document.getElementById("clienteAsociado").options.length;
  	if (cantClientes == 0)	{
        document.forms[0].action="<%=request.getContextPath()%>/BuscaClienteAction.do";
   	    document.forms[0].submit();
   	}
   	else 
    	document.getElementById("mensajes").innerHTML = "<BR>No pueden asociarse abonados a más de un cliente."; 
     
 } 

function buscarAbonado()
  {
        document.forms[0].action="<%=request.getContextPath()%>/BuscaAbonadoAction.do";
        document.forms[0].submit();
 
     
 }

function paginaElimina(){
	
	    document.forms[0].action="<%=request.getContextPath()%>/pages/EliminaFacturacion.jsp";
        document.forms[0].submit();
	
} 

// --------------------------------------------------------------------
// HGG 04-02-2010
function validaAbonados()	{

	var resultado = new Object();
	resultado.existeError = false;
	resultado.mensajeError = "";
	
	var cantAbonados = document.getElementById("abonado").options.length;
	var indiceAbonados = document.getElementById("abonado").options.selectedIndex;

	if (cantAbonados ==0) {
		resultado.mensajeError = "Debe buscar abonados para realizar la asociación.";
		resultado.existeError = true;
		return resultado;
	} // if

	if (indiceAbonados <0) {
		resultado.mensajeError = "Debe seleccionar al menos un abonado.";
		resultado.existeError = true;
		return resultado;
	} // if
	
	return resultado;
	
} // validaAbonados
// --------------------------------------------------------------------
// HGG 04-02-2010
function validaClienteAsociado()	{

	var resultado = new Object();
	resultado.existeError = false;
	resultado.mensajeError = "";
	
	var cantClientes = document.getElementById("clienteAsociado").options.length;
	var indiceClientes = document.getElementById("clienteAsociado").options.selectedIndex;

	if (cantClientes ==0) {
		resultado.mensajeError = "Debe buscar un cliente para realizar la asociación.";
		resultado.existeError = true;
		return resultado;
	} // if

	if (indiceClientes <0) {
		resultado.mensajeError = "Debe seleccionar un cliente.";
		resultado.existeError = true;
		return resultado;
	} // if


	return resultado;

} // validaClienteAsociado
// --------------------------------------------------------------------


function  asociarDatos()
  {
   var traenumeros = document.getElementById("valor").value;
   var ningunCodigo= true;
   var num=new Number(traenumeros);
   var comboModalidad = document.getElementById("modalidad");
   var comboOperacion = document.getElementById("operacion");
   var comboTipoValor = document.getElementById("tipoValor");
   var comboConcepto = document.getElementById("concepto");
   var comboAbonado = document.getElementById("abonado");
   var comboClienteAsociado = document.getElementById("clienteAsociado"); 
   var mensajeError = "";
  
       if((traenumeros == null)  || (traenumeros == ""))
        {   
           mensajeError = mensajeError + "<br>" + "Ingreso un valor vacio. Debe Ingresar nuevamente.";
           document.getElementById("mensajes").innerHTML = mensajeError; 
           ningunCodigo= false;
        }
        
        if(isNaN(num))
        {        
            if (mensajeError == ""){
   	     		mensajeError = "Debe Ingresar solo Números en  Valor."; 
        	 }else{
        		mensajeError = mensajeError + "<br>" + "Debe Ingresar solo Números en  Valor.";
        		document.getElementById("mensajes").innerHTML = mensajeError; 
        	 }
            ningunCodigo= false;
                
        }
        
        if(comboModalidad.value == "modalidad"){
        		if (mensajeError ==""){
   	     			mensajeError = "Debe Seleccionar una modalidad."; 
        		}else{
        			mensajeError = mensajeError + "<br>" + "Debe Seleccionar una modalidad.";
        			document.getElementById("mensajes").innerHTML = mensajeError; 
        		}
                 
               ningunCodigo= false;
         }
        
        if(comboOperacion.value =="operacion"){
        		if (mensajeError ==""){
                 	mensajeError = "Debe Seleccionar una operación."; 
                 }else{
 	                mensajeError = mensajeError + "<br>" + "Debe Seleccionar una operación.";
 	                document.getElementById("mensajes").innerHTML = mensajeError;  
 	             }
       		ningunCodigo= false;  
        }
        
        if(comboTipoValor.value =="tipoValor"){
                 
                 if (mensajeError ==""){
                 	mensajeError = "Debe Seleccionar un tipo valor."; 
                 }else{
 	                mensajeError = mensajeError + "<br>" + "Debe Seleccionar un tipo valor.";
 	                document.getElementById("mensajes").innerHTML = mensajeError;  
 	             }
             ningunCodigo= false; 
        
        }
        
        if (comboConcepto.value =="0"){
                 if (mensajeError ==""){
                 	mensajeError = "Debe Seleccionar un concepto."; 
                 }else{
 	                mensajeError = mensajeError + "<br>" + "Debe Seleccionar un concepto.";
 	                document.getElementById("mensajes").innerHTML = mensajeError ;  
 	             }
            ningunCodigo= false; 
              
        } 
        
        
        if(ningunCodigo== true){    
        	if(validaMonto()){     
				// ---------------------------------------------------------------------------------------------
        		// HGG 04-02-2010
        		var condicionError = false;
        		var resultvalidaAbonados = validaAbonados();
				var resultvalidaClienteAsociado = validaClienteAsociado();
        		
       			if (resultvalidaAbonados.existeError) 
	       			 mensajeError = "<br>" + resultvalidaAbonados.mensajeError;

       			if (resultvalidaClienteAsociado.existeError) 
	       			 mensajeError = mensajeError + "<br>" + resultvalidaClienteAsociado.mensajeError;
		       	
		       	if (resultvalidaAbonados.existeError || resultvalidaClienteAsociado.existeError)	{
		       		document.getElementById("mensajes").innerHTML = mensajeError; 
 	                return;
		       	} // if
		       	
				// ---------------------------------------------------------------------------------------------
				
                document.getElementById("descripOperacion").value=comboOperacion.options[comboOperacion.selectedIndex].text;
                document.getElementById("descModalidad").value=comboModalidad.options[comboModalidad.selectedIndex].text;
                document.getElementById("descConcepto").value=comboConcepto.options[comboConcepto.selectedIndex].text;
                document.getElementById("descTipoValor").value=comboTipoValor.options[comboTipoValor.selectedIndex].text;
                document.getElementById("descAbonado").value=comboAbonado.options[comboAbonado.selectedIndex].text;
                document.getElementById("descClienAsociado").value=comboClienteAsociado.options[comboClienteAsociado.selectedIndex].text;
        
		        document.getElementById("asociarDat").value="asoc";
		        document.getElementById("activarChec").value="activar"; 
		        var countTipoValor = 1;
		        document.forms[0].action="<%=request.getContextPath()%>/AsociarDatosFactAction.do?count=" + countTipoValor;
		        document.forms[0].submit();
        }
       } 
  
     
 }
 
function guardarDatosGrilla()
{

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
    
      document.getElementById("mensajes").innerHTML = "Debe seleccionar una lista de la tabla antes de guardar";
    }     
    else if(ningunockeckeado == false){
          
        document.getElementById("guardarDatGrilla").value="grilla";
        document.forms[0].action="<%=request.getContextPath()%>/FacturacionDifAction.do";
        document.forms[0].submit();
    }
 } 



function validarMensaje(){

 <logic:present name="repetido" scope="request">
    document.getElementById("mensajes").innerHTML = "El número de abonado buscado ya existe en la lista de abonados"; 
</logic:present> 

<logic:present name="repetidoCli" scope="request">
    document.getElementById("mensajes").innerHTML = "El número de cliente ingresado ya existe en la lista de clientes"; 
</logic:present> 

<logic:present name="guardado" scope="request">
    document.getElementById("mensajes").innerHTML = "Los datos asociados fueron guardados con exito"; 
</logic:present> 

<logic:present name="abonadoRep" scope="request">
    document.getElementById("mensajes").innerHTML = "La asociación abonado-cliente-concepto  se encuentra repetida en la tabla"; 
</logic:present> 


}

function habilitaCheck(){
//(multibox!= null && multibox.length > 0 )

 var multibox = eval('document.FacturacionDifForm.listaCheckGrilla');
 var arregloHidden=eval('document.FacturacionDifForm.estadoLista');
    
    if(multibox != null){
	    if(!multibox.length)
	    { 
	    	if (arregloHidden.value == "listaNueva"){
	    	    multibox.disabled = false;
	    	}
	    }else{
	    	for (var i=0;i < multibox.length;i++) 
		    {
		      if(arregloHidden[i].value == "listaNueva")
		         { 
		            multibox[i].disabled = false;
		         }
	        }   
	    } 
    }
}

function MarcarChecAll( formulario ,valor ) {
	var i
	for (i=0; i < formulario.elements.length; i++) {
            if(!formulario.elements[i].disabled){
              	
				formulario.elements[i].checked =valor.checked	//lo marca
			}	
		}
}
</script>
</head>

<body class="body" onload="validarMensaje();habilitaCheck();"  >
<html:form action="/FacturacionDifAction.do" >

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