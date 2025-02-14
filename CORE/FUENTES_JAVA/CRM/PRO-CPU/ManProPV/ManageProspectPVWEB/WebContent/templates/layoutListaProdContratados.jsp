<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/>  :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />


<!-- <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>  -->

</script>
<script language="javascript">

var controlesId=new Array();
var controlesHab=new Array();
var controlesVis=new Array();
var indice=0;
<logic:iterate id="control" name="controlesList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO">
	controlesId[indice]="<bean:write name='control' property='id'/>";
	controlesHab[indice]="<bean:write name='control' property='habilitado'/>";
	controlesVis[indice]="<bean:write name='control' property='visible'/>";
	indice++;
 </logic:iterate>


window.onload = function() {
	valoresDefaultCarga();
}



function valoresDefaultCarga()
{
    
    var condiciones=document.getElementById("condicionesCK");
    var valorCondicion=document.getElementById("condicH").value;
    
    if (valorCondicion=="SI"){
        condiciones.checked=true;
    }else{
        condiciones.checked=false;
        document.getElementById("condicH").value="NO";
    }
    	
	for(i=0;i<controlesId.length;i++)
	{
	   	seteaControl(controlesId[i], controlesHab[i], controlesVis[i]);
	} 

}


function seteaControl(control, habilitado, visible)
{ 
    if (visible=="NO"){
		document.getElementById(control).style["display"]="none";
	}else{
	    if(habilitado=="NO"){
	        document.getElementById(control).disabled=true;
	    }else{
	    	document.getElementById(control).disabled=false;
	    }
	}
	 
}


function asignaValorAControl()
{
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
       
}  


function descripcionTipo(cod){		
		
		if (cod=='PAFN'){
			document.write('Afines');
			return true;
		}
				
}

function descripcionIndCond(cod){

		if (cod=='O'){
			document.write('Opcional');
			return true;
		}
		if (cod=='D'){
			document.write('Default');
			return true;
		}
}



function enviarFormulario(){
    var pers = <c:out value="${sessionScope.ListaProdContratadosForm.personalizados}"/> ;  //PARA VALIDAR QUE AL MENOS HAYA PERSONALIZADO UN PRODUCTO CON NUMEROS
    if(!pers){
    	var confirmar = confirm(" No ha personalizado clientes afines. ¿Desea seguir con la orden de servicio?");
    	if(confirmar){
    		document.forms[0].action="<%=request.getContextPath()%>/productoAfin/FlujoProdContratados.do";
    		document.forms[0].submit();
    	}
    	
    }else{
    	document.forms[0].action="<%=request.getContextPath()%>/productoAfin/FlujoProdContratados.do";
    	document.forms[0].submit();
    }
    
}


function guardarParametros(idProd, codProd, nomProd, indAutoAfin, maxModif, cantModif){
    
	document.getElementById("idProductoContratado").value = idProd ;
	document.getElementById("codigoProducto").value = codProd ;
	document.getElementById("nombreProducto").value = nomProd;
	
	if (indAutoAfin != "S"){
		document.forms[0].action="<%=request.getContextPath()%>/productoAfin/PersonalizaClientesAfines.do";
    	document.forms[0].submit();
	}

}

function sobreElBoton(id,imagen){
	
 	document.getElementById(id).src=imagen;
 	//document.getElementById(id).style="cursor:pointer";
}

function esnumero(){

  if(event.keyCode<47 || event.keyCode>57)
	event.keyCode=0;
}

function salir(){
	window.close();
}

</script>

</head>

<body >

<html:form  method="POST" action="/ListaProdContratados.do">

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footerOS" /></td></tr>  
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>