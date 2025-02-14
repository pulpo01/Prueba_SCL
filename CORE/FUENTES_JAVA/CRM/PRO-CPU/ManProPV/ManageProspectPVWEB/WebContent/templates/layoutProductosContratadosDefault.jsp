<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<%@ page import="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${clienteOS.nombOss}"/> :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />

<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<c:set var="productoOS" value="${sessionScope.ProductoOOSS}"></c:set>

<script type='text/javascript' src='/ManageProspectPVWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManageProspectPVWEB/dwr/util.js'></script>

<script language="JavaScript" src="js/productosCont.js" type="text/javascript"></script>
<script language="JavaScript" src="js/productosNav.js" type="text/javascript"></script>
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

  
  
  function seteaAction(formu)
  {
	formu.action="<%=request.getContextPath()%>/producto/producto.do";
  } 
  
  function valoresDefaultCarga()
  {
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
      var condic = document.getElementById("condicionesCK");
      //var coment = document.getElementById("comentariosCK");
      //var carta  = document.getElementById("cartaCK");
     
      document.getElementById("condicH").value=condic.checked?"SI":"NO";
      //document.getElementById("comentH").value=coment.checked?"SI":"NO";
      //document.getElementById("cartaH").value=carta.checked?"SI":"NO";
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

<body onload="valoresDefaultCarga();">
	<html:form  method="POST" action="/ContDesPlanAdicionalAction.do">
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