<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page import="com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Utilidades" %>

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
<title>Telefónica Móviles .: Activación y Desactivación de Servicios Suplementarios :.</title>
<script type='text/javascript' src='/ServiciosSuplementariosWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/ServiciosSuplementariosWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/ServiciosSuplementariosWEB/dwr/util.js'></script>
<script language="JavaScript" src= 'serviciosSup/botones/presiona.js' type="text/javascript"></script>
<script type='text/javascript' src='serviciosSup/js/Calendar.js'></script>
<script type='text/javascript' src='serviciosSup/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='serviciosSup/js/serviciosSup.js'></script>
<script type='text/javascript' src='/js/serviciosSup.js'></script>


<link href="serviciosSup/css/mas.css" rel="stylesheet" type="text/css" />
<link href="serviciosSup/css/calendar.css" type="text/css" rel="stylesheet" />    

<!--  **********************************  -->
      <script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
      <script type='text/javascript' src='js/Calendar.js'></script>
      <script type='text/javascript' src='js/CambioDeSerie.js'></script>
      <link href="css/mas.css" rel="stylesheet" type="text/css" />
      <link href="css/calendar.css" type="text/css" rel="stylesheet" />    
<!--  **********************************  -->


<script language="javascript">

// flag global para saber si existen servicios blackberry definidos
var flagBlackBerryActivado = "<%=request.getAttribute("tieneServBBContratados").toString()%>";	// HGG 20/06/208
arrayOptimizadoServBB = new Array(); 

//--- HGG 
//--- Variables globales para la integracion de los componentes de asistencia 911 y fax
//--- ini -----------------------------------------
var oContactos = new Array(); 
var oArgumentos = new Object();
oArgumentos.contactos = new Array();

// Codigo de grupo asistencia 911
var icgServicioAsistencia911 = "<%= session.getAttribute("icgServicioAsistencia911") %>";

// Codigo de grupo correo movistar
var icgServicioCorreoMovistar = "<%= session.getAttribute("icgServicioCorreoMovistar") %>";

// Codigo de grupo servicio de fax
var icgServicioFax = "<%= session.getAttribute("icgServicioFax") %>";

// Maxima cantidad de contactos
var maxContactos911 = "<%= session.getAttribute("maxContactos911") %>";

// Url a los contactos de asistencia movil 911
var urlContactos911 = "<%= session.getAttribute("urlContactos911") %>";

var colorResaltado = "#E7E7D6";
var colorNormal = "#FFFFFF";

// ------------------------------------------------------------------------------------------------		
// Donde se guardan los contactos de cada SS de asistencia 911
	var arrayContactos911 = new Array();
// ------------------------------------------------------------------------------------------------		

//--- end -----------------------------------------

<%
	//HGG 26/06/08
	// Creo on the fly el array de los servicios BB que tiene contratatos el abonado
	try {
		String html1 = null;
        html1 = Utilidades.generaTablaservBBContratados(request);
      	out.println(html1);
	}
	catch (Exception ex)	{
		ex.printStackTrace();
	}	
%>

function salir(){
	window.close();
}

	function enviarFormulario()	  {

		// ------------------------------------------------------------------------------------------------------------------------------------
		// Genero los string para grabar luego	  	
		// ------------------------------------------------------------------------------------------------------------------------------------

		if (listaServiciosAct.length > 0)	{
			var	txtServicios = "";

			// Armo el string con todos los productos que se han DESELECCIONADO, para que se descontraten
			var texto = "";		
			for (var indice=0; indice < listaServiciosAct.length; indice++)	
				if (!document.getElementById("idSelAct"+indice).checked)	{
					if (txtServicios == "") txtServicios = "|";
					
					txtServicios = txtServicios + listaServiciosAct[indice][0]  + "|";
					// Busco la descripcion
					texto = texto + buscarDescripcion(listaServiciosAct[indice][0]);
				} // if

			document.getElementById("textoNoContratados").value = texto;
			document.getElementById("nocontratadosTabla").value = txtServicios;
	    } // if


		if (listaServiciosDisp.length > 0)	{
			var txtServicios = "";
			texto = "";


			var grpServicio = "";
			var nivelServicio = "";
			var txtSSAdelantados = "";
		
			// Armo el string con todos los productos que se han seleccionado para su contratacion
			var texto = "";		
			for (var indice=0; indice < listaServiciosDisp.length; indice++)	
				if (document.getElementById("idSelDisp"+indice).checked)	{
					if (txtServicios == "") txtServicios = "|";
					
					txtServicios = txtServicios + listaServiciosDisp[indice][0]  + "|";
					
					// HGG 18-05-10 : para enviar al frmk de cargos y detectar si son ss adelantados.
					grpServicio = listaServiciosDisp[indice][1];
					nivelServicio = listaServiciosDisp[indice][2];					
					
					txtSSAdelantados = txtSSAdelantados + grpServicio + "*" + nivelServicio + "|";
					
					// Busco la descripcion
					texto =  texto + buscarDescripcion(listaServiciosDisp[indice][0]);
					// Si el SS es de grupo FAX
					if (icgServicioFax == listaServiciosDisp[indice][1])				
						document.getElementById("grabarFax").value = "true";
					
				} // if
			
			// recorto el ultimo pipe		
			txtSSAdelantados = txtSSAdelantados.substring(0, txtSSAdelantados.length-1);
			
			document.getElementById("textoContratados").value = texto;
			document.getElementById("contratadosTabla").value = txtServicios;
			document.getElementById("adelantadosTabla").value = txtSSAdelantados;

			// Formateo los contactos de asistencia 911
			array2String();
		} // if	

		if ((document.getElementById("nocontratadosTabla").value == "") && (document.getElementById("contratadosTabla").value == ""))	{
			alert("Debe seleccionar al menos un servicio para contratar/descontratar.");
		}
		else	{
		  	document.getElementById("btnSeleccionado").value = "grabar";
		    document.forms[0].submit();
		} // else

	  } // enviarFormulario()	
	  
	  
	  
	// ------------------------------------------------------------------------------------------------------------------------
	
	function buscarDescripcion(cadena)	{
		
		var desc = "";
		// Busco la descripcion
		for (var k=0; k < listaTodosServicios.length; k++)	
			if (listaTodosServicios[k][0] == cadena)
				desc = "\n(" + listaTodosServicios[k][0] + ") " + listaTodosServicios[k][3];
	
		return desc;
	
	} // buscarDescripcion
	
	// ------------------------------------------------------------------------------------------------------------------------	
	
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
  
	
	function showVendedor()	{
		if (document.getElementById("showVendedor").value == "SI")	{
			var urlPath=document.getElementById("contextpathSS");
			var url = urlPath.value;
			url = url+"/switch.do?page=/vendedor.jsp&prefix=/serviciosSup";
			var ReturnedValue = window.showModalDialog(url, "winVendedor", "dialogHeight:400px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
			//alert("ReturnedValue=["+ReturnedValue+"]");
			if(ReturnedValue ==null ||ReturnedValue=="" || ReturnedValue=="NO"){
				alert("No ha seleccionado un vendedor se cancelará \nla ejecución de la Orden de Servicio.\nSi continúa la información podría quedar inconsistente.");
				window.close();
			}

		} // if
		
	} // showVendedor

// ------------------------------------------------------------------------------------------------------------------------------------------------	
// HGG 23/06/08

	function creaArrayServBlackBerry()	{

		// Este array se lo utiliza para cruzar la info de los servicios BB para realizar mas rapido el proceso	
		if (flagBlackBerryActivado == "SI")	{
			for (var i=0; i < servBBContratados.length; i++)	{
				for (var j=0; j < reglas.length; j++)
					if (servBBContratados[i] == reglas[j][0]) arrayOptimizadoServBB.push([ reglas[j][0],reglas[j][1],reglas[j][2] ] );
			} // for
		} // if

	} // creaArrayServBlackBerry
	
// ------------------------------------------------------------------------------------------------------------------------------------------------
</script>
</head>

<body class="body" onload="javascript:showVendedor();creaArrayServBlackBerry();">

<html:form action="/ServiciosSuplementariosAction" method="POST">
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
