<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<%@ page import="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<form name="BitacoraForm" id="BitacoraForm">
<input type="hidden" name="bitac" id="bitac" value="" />
<input type="hidden" name="bita" id="bita" value="" />
<input type="hidden" name="cantidadesP" id="cantidadesP" value="" />
</form>
<html:html>

<html:form method="POST" action="ProductosAboLimiteConsumo.do" >

<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />


<c:set var="productoOS" value="${sessionScope.ProductoOOSS}"></c:set>
<script type='text/javascript' src='/ManageProspectPVWEB/dwr/interface/JValidacionesExclusion.js'></script>
<script type='text/javascript' src='/ManageProspectPVWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManageProspectPVWEB/dwr/util.js'></script>

<script language="JavaScript" src="js/productosCont.js" type="text/javascript"></script>
<script language="JavaScript" src="js/productosNav.js" type="text/javascript"></script>
<script language="JavaScript" src="js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="js/validador.js" type="text/javascript"></script>
<script language="JavaScript" src="img/botones/presiona.js" type="text/javascript"></script>

<script language="javascript">  
var controlesId=new Array();
var controlesHab=new Array();
var controlesVis=new Array();
var indice=0;
var codAct;
var codOSAnt;
var evento;
var controlCh;
var esvisible;
  	
 <logic:iterate id="control" name="controlesList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO">
	controlesId[indice]="<bean:write name='control' property='id'/>";
	controlesHab[indice]="<bean:write name='control' property='habilitado'/>";
	controlesVis[indice]="<bean:write name='control' property='visible'/>";
	indice++;
 </logic:iterate>
 
 
  <bean:define id="cliente" name="ClienteOOSS" scope="session"/>

  window.onload = function() {
	valoresDefaultCarga();
}

function f_inicio(){
	
	var prodCont = document.getElementById('listaProductosContrados').value;
	var prodContLista = prodCont.split("|");
	
	for(var i = 0; i < prodContLista.length; i++)		listProductosc[listProductosc.length] = prodContLista[i];
		
}

function seteaAction(formu)
{
	formu.action="<%=request.getContextPath()%>/abonoLimiteConsumo/ProductosAboLimiteConsumo.do";
} 
  

function valoresDefaultCarga()
{
    var hayproductos='<%=request.getAttribute("hayproductos")%>';
    if(hayproductos == 'NO' )
    {
    	enviado = true;
    	muestraMensajeErrorAfin("No existen productos, la orden de servicio no puede continuar");
    }
    var condiciones=document.getElementById("condicionesCK");
    var valorCondicion=document.getElementById("condicH").value;
    
	if (valorCondicion==""){
        valorCondicion="SI";
    }    
    
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
    esvisible = visible;
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
  
  function asignaEstado()
  {	  
     // var condic = document.getElementById("condicionesCK");
      //var coment = document.getElementById("comentariosCK");
      //var carta  = document.getElementById("cartaCK");
     
      //document.getElementById("condicH").value=condic.checked?"SI":"NO";
      //document.getElementById("comentH").value=coment.checked?"SI":"NO";
      //document.getElementById("cartaH").value=carta.checked?"SI":"NO";
  } 
  	function asignaValorAControl()
{
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
} 
  
  
  function checkValores()
  {
  	//document.getElementById("idControlCh");
    document.write('<input title="checkboxval" name="checkboxval" id=' +controlesId[0]+' type="checkbox" value="checkbox" />');
  }
 //------------------Funciones de respuesta OOSS------------------------
function salir(){
	window.close();
}
</script>
</head>

<body onload="f_inicio();">
	

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

</body>
</html:form>
</html:html>