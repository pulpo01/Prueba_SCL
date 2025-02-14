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
<title>Telefónica Móviles .: Doble Cuenta :.</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='pages/js/jsUtil.js'></script>
<script type='text/javascript' src='pages/js/net.js'></script>
<script type='text/javascript' src='pages/js/utils.js'></script>
<script type='text/javascript' src='pages/js/numeros.js'></script>
<script type='text/javascript' src='pages/js/validate2.js'></script>

<script>
var arrDetalle = new Array();
arrDetalle = null;
</script>
<script type='text/javascript'>
function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
  document.getElementById("identMsg").innerHTML = "";
    
}

function validarMensaje(){

<logic:present name="error" scope="request">
    document.getElementById("error").innerHTML = ""; 
</logic:present>

}
/*
Busca informacion por cliente contratante y carga los datos en listaAbo
*/ 

function buscar(){
	makeRequest('<%=request.getContextPath()%>/search.do');
	var url="<%=request.getContextPath()%>/search.do";
	var cf = new  net.ContentLoader(url,cargaAbonados,null,"get",null,null)
}	

function cargaAbonados(){  
  var  dato  = this.req.responseXML;
  var msjNodes =  dato.getElementsByTagName("abonados");  
  i = 0;
  j = 0;

  if (msjNodes!= null && msjNodes.length > 0 ){
	  var nodoCliente = msjNodes[0].getElementsByTagName("listaClientesRelacionados");	 
	  arrDetalle = new Array();	
       if(nodoCliente.length > 0){				
			for(i=0; i < nodoCliente.length; i++){						
				arrDetalle[i]=new Array(nodoCliente[i].getElementsByTagName("codigo_Abonado")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("numero_Celular")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("desc_Abonado")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("cod_Clien_Asociado")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("desc_Clien_Asociado")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("codigo_Concepto")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("desc_Concepto")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("valor_1")[0].childNodes[0].nodeValue,
										nodoCliente[i].getElementsByTagName("num_Secuencia_Detalle")[0].childNodes[0].nodeValue)
			}
		var lista = document.getElementById("trAbonado");
    	lista.style.visibility = "visible";
		}else{
			  document.getElementById("identMsg").innerHTML = "No existe informacion asociada a este Cliente."
		}
	}	
			
  loadFullDescription()
  if(document.getElementById("listaAbo").value != ""){
	 setDatos(document.getElementById("listaAbo"))
  }
}
function loadFullDescription(){
	
		var clientes = document.getElementById("listaAbo"); 
		var largo = arrDetalle.length;
		clientes.length = 0;
		clientes.length =  largo;
				
		for(i = 0; i < arrDetalle.length; i++){
			clientes.options[i] = new Option((arrDetalle[i][1])+"  "+(arrDetalle[i][2]), i);
		}
	}
	
function setDatos(obj){			
	document.getElementById("codigo_Abonado").value            = arrDetalle[obj.value][0]
	document.getElementById("numero_Celular").value	           = arrDetalle[obj.value][1]
	//document.getElementById("desc_Abonado").value	           = arrDetalle[obj.value][2]
	document.getElementById("cod_Clien_Asociado").value	       = arrDetalle[obj.value][3]	
	document.getElementById("desc_Clien_Asociado").innerHTML   = arrDetalle[obj.value][4]
	document.getElementById("codigo_Concepto").value           = arrDetalle[obj.value][5]
	document.getElementById("desc_Concepto").innerHTML	       = arrDetalle[obj.value][6]
	document.getElementById("valor_1").value	               = arrDetalle[obj.value][7]
	document.getElementById("num_Secuencia_Detalle").value     = arrDetalle[obj.value][8]

}
/*
Modifica monto
*/
function vacioRec(){

    var comboTipoValor = document.getElementById("tipValor").value;
   
		
			if(document.getElementById("valor_1").value == ""){
				document.getElementById("identMsg").innerHTML = "Debe ingresar un valor."
				return false
			}
					
			if((document.getElementById("valor_1").value > 9999999999)||(document.getElementById("valor_1").value < 1)){
				document.getElementById("identMsg").innerHTML = "Debe ingresar un monto valido. (0-9999999999) ."
				return false
			}
		
		if(comboTipoValor == 1){
			if(document.getElementById("valor_1").value > 100){
				document.getElementById("identMsg").innerHTML = "Debe ingresar un porcentaje valido. (0-100%) ."
				return false
			}			
		}	
		return true			
}

function update(){
	if (vacioRec()){
		document.forms[0].action="<%=request.getContextPath()%>/modifica.do";
        document.forms[0].submit(); 
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

<body class="body" onload="buscar();">
<html:form action="/search.do">

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