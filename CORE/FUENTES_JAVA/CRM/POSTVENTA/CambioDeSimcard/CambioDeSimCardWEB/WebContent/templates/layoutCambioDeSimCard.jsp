<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

<%@ page import="com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Cambio de SimCard :.</title>
<script language="JavaScript" src="cambioSimCard/botones/presiona.js" type="text/javascript"></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/SesionDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/TipoDeContratoDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/CausaCamSerieDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/TipoTerminalDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/CuotaDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/MensajeRetornoDTO.js'></script>
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/interface/ModalidadPagoDTO.js'></script>

<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/CambioDeSimCardWEB/dwr/util.js'></script>

<script type='text/javascript' src='cambioSimCard/js/CambioDeSerie.js'></script>

<link href="cambioSimCard/css/mas.css" rel="stylesheet" type="text/css" />
<link href="css/mas.css" rel="stylesheet" type="text/css" />


<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    
<!--  **********************************  -->



<script language="javascript">
	// Flag para indicar si se ha vuelta esta pagina, se utiliza para la carga del combo 
	// de modalidad de pagos
	var isSerieBloqueda=false;
	var codModPago = "<c:out value="${ClienteOOSS.modalidad}"/>";
	if (codModPago != "")
		var flagPagRecargada = true;
	else
		var flagPagRecargada = false;
	

	function salir(){
		var ventana = window.self;
		ventana.opener = window.self;
		desReservaSerieP(document.getElementById("nroSerie").value);
		//ventana.close();
	}

	function enviarFormulario()	  {
		
		if (document.getElementById("flagBloqueo").value == 1)	{
		  	document.getElementById("btnSeleccionado").value = "grabar";
		  	// habilita los controles que estan disabled
		  	habilitaControles();
		    document.forms[0].submit();
		    deshabilitaControles();
		 } // if
		 else
		 	alert ("No se ha bloqueado ningún número de serie hasta el momento.");
		 	
	  }	// enviarFormulario
	  
	  // ------------------------------------------------------------------------------------
	  
	function formularioAnterior()
	  {
	  	document.getElementById("btnSeleccionado").value = "anterior";
	    document.forms[0].submit();
	  
	  }
	  
	  function asignaValorAControl()
	  {
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";   
	  }
  
	
// -------------------------------------------------------------------------------------	

	function cargaDefault()	{

		var flag = "<c:out value="${ClienteOOSS.modalidad}"/>";

		if (flag != "null" && flag != "")	{
			document.getElementById("causaCambio").onchange();
			document.getElementById("flagBloqueo").value=1;
			document.getElementById("flagT").value=0;
			
			deshabilitaControles();
		}	// if
		
		
		// Se debe deshabilitar tipo de terminal y dejar seleccionado SIMCARD
		if (document.getElementById("tipoTerminal").length > 1)	{
			document.getElementById("tipoTerminal").selectedIndex = 1;
			document.getElementById("tipoTerminal").disabled = true;
		}
		
	} // carga el combo de modalidad de pago cuando se vuelve desde una pagina de adelante
	
	function showVendedor()	{
		if (document.getElementById("showVendedor").value == "SI")	{
			var urlPath=document.getElementById("contextpathCS");
			var url = urlPath.value;//"${pageContext.request.contextPath}";
			url = url+"/switch.do?page=/vendedor.jsp&prefix=/cambioSimCard";
			var ReturnedValue = window.showModalDialog(url, "winVendedor", "dialogHeight:400px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
			//alert("ReturnedValue=["+ReturnedValue+"]");
			if(ReturnedValue ==null ||ReturnedValue=="" || ReturnedValue=="NO"){
				alert("No ha seleccionado un vendedor se cancelará \nla ejecución de la Orden de Servicio.\nSi continúa la información podría quedar inconsistente.");
				window.close();
			}
			if (ReturnedValue == "SI") return true; // RRG
			else return false;

		} // if
		
	} // showVendedor
		
// -------------------------------------------------------------------------------------	
 function fncBuscarSerie(url1){
 		var tecnologia = "GSM";
 		var tipoTerminal = document.getElementById("tipoTerminal").value;
 		var usoVentaEquip = document.getElementById("usoVenta").value;
 		var modalidadPago = document.getElementById("modalidadPago").value;
 		var  numSerie =document.getElementById("nroSerie").value;
 		
 		if (modalidadPago==null || modalidadPago=="" || modalidadPago=="0") {
 			alert('Debe seleccionar la Modalidad de Venta');
 			return;
 		} 		
 		
 		if (tecnologia==null || tecnologia=="") {
 			alert('Debe seleccionar la tecnología');
 			return;
 		}
 		if (tipoTerminal==null || tipoTerminal=="") {
 			alert('Debe seleccionar el tipo de terminal');
 			return; 			
 		}
 		if (usoVentaEquip==null || usoVentaEquip=="") {
 			alert('Debe seleccionar el uso');
 			return; 			
 		}	

 		var url = url1+"&tecnologia="+tecnologia+"&tipoTerminal="+tipoTerminal+"&usoVentaEquip="+usoVentaEquip+"&modalidadPago="+modalidadPago;
 		var ReturnedValue = window.showModalDialog(url, "Series", "dialogHeight:650px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
 		//var ReturnedValue = window.open(url, "Series", "dialogHeight:650px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
		if(ReturnedValue !=null && ReturnedValue!=""){
			numSerie = ReturnedValue;
		}
		document.getElementById("nroSerie").value = numSerie;
 }
// ------------------------------------------------------------------------------------  	
</script>
</head>

<body class="body" onload="javascript:cargaDefault();showVendedor();">

<html:form action="/CambioDeSimCardAction" method="POST">
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
