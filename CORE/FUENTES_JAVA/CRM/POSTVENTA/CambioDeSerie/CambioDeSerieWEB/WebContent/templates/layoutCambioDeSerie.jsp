<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>

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
<title>Telefónica Móviles .: Cambio de Serie :.</title>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>

<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CusIntManDWRController.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/engine.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/util.js'></script>


<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/SesionDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TipoDeContratoDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CausaCamSerieDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TipoTerminalDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/TecnologiaDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/CuotaDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/dwr/interface/MensajeRetornoDTO.js'></script>
<script type='text/javascript' src='/CambioDeSerieWEB/cambioSerie/js/CambioDeSerie.js'></script>
<script type='text/javascript' src='cambioSerie/js/CambioDeSerie.js'></script>

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="cambioSerie/css/mas.css" rel="stylesheet" type="text/css" />

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
		
var listaMesesContrato=new Array();
var listaCodTipContrato=new Array();
var indice=0;

var listaArticulos=new Array();
// -------------------------------------------------------------------------------------

	function showLayer(layerName)	{

		capa = document.getElementById(layerName);
		if (capa.style.display=="none")
			capa.style.display="inline";
		else
			capa.style.display="none";

	}	// showLayer

// -------------------------------------------------------------------------------------
	function salir(){
		var ventana = window.self;
		ventana.opener = window.self;
		var bloqueoEquipo = document.getElementById("flagBloqueoEquipo").value==1?true:false;
		if (bloqueoEquipo){ 	/* RRG COL 95414 25-06-2009 */
		desReservaSerieP(document.getElementById("nroSerieSim").value,document.getElementById("nroSerieEquip").value);
		}else{
			try{
				//window.close();/* RRG COL 95414 25-06-2009 */
				// INICIO RRG 114707 COL 18-03-2010
				//window.close();
				w=window;
				v=(w.self.opener=w.self);
				v.close();
			}catch (e){}
		}
		// FIN RRG 114707 COL 18-03-2010
		//ventana.close();
	}

// -------------------------------------------------------------------------------------

	function enviarFormulario()	  {
	
	var bloqueoSerie = document.getElementById("flagBloqueo").value==1?true:false;
	var bloqueoEquipo = document.getElementById("flagBloqueoEquipo").value==1?true:false;
	var bloqueoEquipoEx = document.getElementById("flagBloqueoEquipoEx").value==1?true:false;
	var proceEquipo = document.getElementById("procedNuevoEquipo").value;
	 var grupoTecnoGSM =document.getElementById("grupoTecnoGSM").value;
	  var tecnoAbonado=document.getElementById("cod_tecnologia").value;
	
	if ("I"==proceEquipo)
	{
		if (!bloqueoEquipo)
		{
			aplicaval=false;
			alert("Debe bloquear una serie para el equipo");
			return false;	// RRG  100947 25-08-09 COL
		}
		
	}
	else
	{
		if ("E"==proceEquipo) {
			validaSerieExterna('bloquearEx', 'nroSerieEquip', 'usoVentaEquip', 'equipo');
		}
		if (!bloqueoEquipoEx)
		{
			aplicaval=false;
			alert("Debe ingresar una serie para el terminal");
			return false;	
			
		}
		
		if (!bloqueoSerie&&(grupoTecnoGSM!=tecnoAbonado))
		{
			alert("Debe bloquear una serie para la simcard");
			return false;
		}
	}
	

	if (((document.getElementById("flagBloqueo").value == 1||document.getElementById("flagBloqueoEquipo").value == 1)&&document.getElementById("procedNuevoEquipo").value=="I")
	  ||document.getElementById("flagBloqueoEquipoEx").value == 1)	{
	  	document.getElementById("btnSeleccionado").value = "grabar";
	  	
	  	// habilita los controles que estan disabled
	  	document.getElementById("btnSeleccionado").value = "grabar";
	  	habilitaControles();
		//INI COL-100947; 11-08-2009; AVC
	  	document.getElementById("Siguiente1").style.cursor ="";
	    document.getElementById("Siguiente2").style.cursor ="";
    	document.getElementById("Siguiente1").disabled=true;
        document.getElementById("Siguiente2").disabled=true;
		document.getElementById("habilitado").value=1;
		//FIN COL-100947; 11-08-2009; AVC	  	
	    document.forms[0].submit();
	    deshabilitaControles();
	 } // if
	 else
	 	alert ("No se ha bloqueado ningún número de serie hasta el momento.");
	 
  }	// enviarFormulario

// ------------------------------------------------------------------------------------

  function asignaValorAControl()
  {
     var condiciones = document.getElementById("condicionesCK");
     document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
     alert (condiciones);
     
     alert(condiciones.visible);
    
  }

// ------------------------------------------------------------------------------------

	function cargaDefault()	{
		try{
			var flag = "<c:out value="${ClienteOOSS.modalidad}"/>";
			var equipoProc="<c:out value="${Equipo}"/>";
			equipoProc=equipoProc==null||equipoProc==""? "I":equipoProc;
			if (flag != "null" && flag != "")	{
				document.getElementById("causaCambio").onchange();
				document.getElementById("flagBloqueo").value=1;
				document.getElementById("flagT").value=0;
				//deshabilitaControles();
			}	// if

			cargaComboTiposContrato(equipoProc);
			valoresDefectoTipoContratoCliente();
			valoresDefectoMesesProrrogaCliente(document.getElementById("codTipContrato").value);
			valoresDefectoGrupoTecnologico();
			evaluaEquipo(equipoProc);
		}
		catch(e){
			alert(e.name + " - "+e.message+" En cargaDefault()");
			//alert("Error en cargaDefault: "+e);
		}
		//valoresDefectoTerminal();

	} // carga el combo de modalidad de pago cuando se vuelve desde una pagina de adelante

// -------------------------------------------------------------------------------------

		function valoresDefectoTipoContratoCliente(){

			var tiposContrato=document.getElementById("tipoContrato");
			var codContrato=document.getElementById("codTipContrato").value;
			var tmpCodTipCont='';
			codContrato=codContrato==''||codContrato==null?'0':codContrato;
			
			if (tiposContrato.length>1){
				for (i=0;i<tiposContrato.length;i++){
					tmpCodTipCont=tiposContrato[i].value
					tmpCodTipCont=tmpCodTipCont==''||tmpCodTipCont==null?'0':tmpCodTipCont;
					if (parseInt(codContrato)==parseInt(tmpCodTipCont)){
						document.getElementById("tipoContrato").selectedIndex=i;
						break;
					}
				}
			}

		}

		function valoresDefectoMesesProrrogaCliente(codContrato){
			/*var codContClie='';//document.getElementById("numMeses").value;
			codContClie=codContClie==''||codContClie==null?'0':codContClie;*/
			var mesContCliente=0;
			var codMes=document.getElementById("mesesProrroga");
			var tmpMesCont='';
			var codTipContrato=0;
			
			//Recorro la lista de contratos para obtener el mes correspondiente al cliente;
			for (j=0;j<listaCodTipContrato.length;j++){
				codTipContrato=listaCodTipContrato[j].cod_tipcontrato;
				if (codTipContrato==parseInt(codContrato))
				{
					mesContCliente=listaCodTipContrato[j].num_meses;
					break;
				}
			}
			
			if (codMes.length>1){
				for (i=0;i<codMes.length;i++){
					tmpMesCont=codMes[i].value
					tmpMesCont=tmpMesCont==''||tmpMesCont==null?'0':tmpMesCont;
					if (parseInt(mesContCliente)==parseInt(tmpMesCont)){
						document.getElementById("mesesProrroga").selectedIndex=i;
						break;
					}
				}
			}

		}

		function valoresDefectoGrupoTecnologico(){
			try
			{
				
				var grupoTecnoGSM =document.getElementById("grupoTecnoGSM").value;
				var tecnoAbonado='GSM';//document.getElementById("cod_tecnologia").value;
				var tecnologia=document.getElementById("tecnologia");
				//alert("tecnologia "+tecnologia);
				if (tecnologia.length>0){
					for (i=0;i<tecnologia.length;i++){
						if (tecnoAbonado==tecnologia[i].value){
							document.getElementById("tecnologia").selectedIndex=i;
							break;
						}
					}
				}
				//validaCambioTecnologia(tecnoAbonado)
				habilitaBloqueoSerie();
				valoresComboTipoTerminal(document.getElementById("tecnologia").value);
				
				if (grupoTecnoGSM==tecnoAbonado)
				{
					document.getElementById("tecnologia").disabled=true;
				}
				else{
					document.getElementByID("nuevoPlan").style.display="inline";
				}
				
				habilitaBloqueoSerie();
			}
			catch(e){
				alert(e.name + " - "+e.message+" En valoresDefectoGrupoTecnologico()");
			}

			
		}

		function validaCambioTecnologia(tecnoAbonado){
		var grupoTecnoGSM =document.getElementById("grupoTecnoGSM").value;
			if (grupoTecnoGSM!=tecnoAbonado){
				//document.getElementById("tecnologia").disabled=true;
				habilitaBloqueoSerie();
			}
			

		}

	function habilitaBloqueoSerie(){
		try
		{
		  var grupoTecnoGSM =document.getElementById("grupoTecnoGSM").value;
		  var tecnoAbonado=document.getElementById("cod_tecnologia").value;
		  if (grupoTecnoGSM!=tecnoAbonado)
		  {
			document.getElementById("selSimcard").style.display="inline";
			document.getElementById("titSimcard").style.display="inline";
			
		  }
		  else
		  {
		  	document.getElementById("selSimcard").style.display="none";
		  	document.getElementById("titSimcard").style.display="none";
		  }
		}
		catch(e){
			alert(e.name + " - "+e.message+" En habilitaBloqueoSerie()");
		}

	}


	function cargaValorHlr(codCentral){
	  var  codCentralSeleccionado=0;
	   for(i=0;i<arryCentral.length;i++){
	   codCentralSeleccionado=arryCentral[i].cod_central
	   	if (codCentralSeleccionado== codCentral){
	   		document.getElementById("hlr").value=arryCentral[i].cod_hlr;
	   		break;
	   	}
	   }


	}
	
	function limpiarCajasBoqueoSerieSimcard(){
		document.getElementById("hlr").value="";
	}
	
	function showVendedor()	{
		var shwVend=document.getElementById("showVendedor");
		
		if ( shwVend.value == "SI")	{
		    var urlPath=document.getElementById("contextpathCSerie");
			var url = urlPath.value;//"${pageContext.request.contextPath}";
			url = url+"/switch.do?page=/vendedor.jsp&prefix=/cambioSerie";
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
	
	function evaluaEquipo(valor){
	
		/*document.getElementById("nroSerieEquip").value ="";
		document.getElementById("usoVentaEquip").value ="";
		document.getElementById("articulos").value ="";
		document.getElementById("desFabricante").value ="";
		document.getElementById("modelo").value ="";*/
		//document.getElementById("procedNuevoEquipo").value=valor;
		try
		{
			if (valor=='E'){
				document.getElementById('selEquipo').style.display="none";
				document.getElementById('selEquipoExterno').style.display="inline";
				cargaComboArticulos("T");
				document.getElementById("flagBloqueoEquipo").value=0;
				document.getElementById("flagBloqueo").value = 0;
				// INCLUIDO POR SANTIAGO
				document.getElementById("divLnkSelSerie").style["display"] = "none";
			}
			else{
				document.getElementById('selEquipoExterno').style.display="none";
				document.getElementById('selEquipo').style.display="inline";
				cargaComboArticulos("T");
				document.getElementById("desFabricante").value="";
				document.getElementById("modelo").value="";
				document.getElementById("flagBloqueoEquipoEx").value=0;
				// INCLUIDO POR SANTIAGO
				document.getElementById("divLnkSelSerie").style["display"] = "inline";
			}
		}
		catch(e){
			alert(e.name + " - "+e.message+" En evaluaEquipo() valor:"+valor);
		}

	}
	
	function valoresDefectoTerminal()
	{
			
		for (var k=0;k<listaTiposTerminal.length;k++)
		{
		  if (listaTiposTerminal[k].tip_terminal=='T')
		  {
		   	document.getElementById('tipoTerminal').disabled=true;
		   	document.getElementById('tipoTerminal').selectedIndex=k;
		   }
		}
		
		//alert(document.getElementById('tipoTerminal').length);
		
	}
	function valoresComboTipoTerminal(tipTerminal)
	{
		cargaComboTipoTerminal(tipTerminal);
		
	}
	
	function recargaArticulo(){
	
		var codArticulo=document.getElementById("codArticulo").value;
		codArticulo=codArticulo==null||codArticulo==""?"0":codArticulo;
		// Hay que dejar seleccionado el que correspondia cuando se vuelve atras la pagina
			if (flagPagRecargada == true)	{
				var cod="";
				for (var i=0; i < document.getElementById("articulos").length; i++)	{
					cod=document.getElementById("articulos").options[i].value;
					if (cod==parseInt(codArticulo))	{
						document.getElementById("articulos").selectedIndex = i;
						break;
					} // if
				} // for
			} // if
	
	
	}

</script>
</head>

<body class="body"  onload="cargaDefault();showVendedor();">

<html:form action="/CambioDeSerieAction" method="POST">
<input type="hidden" id="habilitado" name="habilitado" value="0"/>
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
