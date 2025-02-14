<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/calendar.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/js/calendar.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JConsultaVentasVendedorAJAX.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JSolicitudScoringAJAX.js'></script>

<style type="text/css">

div#scoreCliente {
	width: 100%;
	
}

div#scoreCliente table {
	width: 100%;
	font-family: Verdana;	
	font-size: 8pt;
}

div#scoreCliente table tr {
	width: 100%;
}

h4 {
	font-size: 10pt;
}

.col1 {
	width: 20%;
	
}

.col2 {
	width: 30%;
	
}

select {
	width: 90%;
}

INPUT[type=text], TEXTAREA {
	width: 100%;
}

button {
	width: 150px;
	font-family: Verdana;
	font-size: 8pt;
	text-transform: uppercase;
}

</style>

<script>
	window.history.forward(1);
	
	function fncInicio() {
		var rdSolicitudSel = document.getElementById("rdSolicitudSel");
		if (rdSolicitudSel != null ) {
			document.getElementById("divResultadoBusqueda").style["display"] = "";
			document.getElementById("divBotones").style["display"] = "";
		}
		fncObtenerVendedores();
	}
	
	function fncObtenerVendedores() {
	    var codOficina = document.getElementById("codOficina");
		
		if (codOficina.value != "" ) {
			JConsultaVentasVendedorAJAX.obtenerVendedores(codOficina.value,fncResultadoObtenerVendedores);
		}
		else {
			DWRUtil.removeAllOptions("codVendedor");
	    	DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});
	    }	   	    
	}
	
	function fncResultadoObtenerVendedores(data)
	{
		if (data!=null)
		{
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];       		
			var codVendedorSeleccionado = document.getElementById("codVendedorSeleccionado").value;
					    		
		    DWRUtil.removeAllOptions("codVendedor");
		    DWRUtil.addOptions("codVendedor",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codVendedor",listaActualizada,"codigoVendedor","nombreVendedor");

		    if (codVendedorSeleccionado !=""){
			    var codVendedor = document.getElementById("codVendedor");
			    var encontrado = false;
			    for (index = 0; index< codVendedor.length; index++) {
			       	  if (codVendedor[index].value == codVendedorSeleccionado){
			        	codVendedor.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codVendedorSeleccionado").value = ""
		    }
		    
	    }//fin if (data!=null)
	}
	
	function fncSeleccionaVendedor(codVendedor){
		document.getElementById("codVendedorSeleccionado").value = codVendedor.value;	    
	}
	
	function fncBuscarCliente()
	{
	  	document.getElementById("opcion").value = "buscarCliente";
	  	document.forms[0].submit();
	}
	
	function fncLimpiar(){
		document.getElementById("opcion").value = "limpiarConsulta";
    	document.forms[0].submit();
	}
	
	function fncBuscarSolicitudes()
	{
	        var numSolScoring = document.getElementById("numSolScoring").value;
			var codVendedor = document.getElementById("codVendedor").value;
			var codOficina = document.getElementById("codOficina").value;
			var codCliente = document.getElementById("codCliente").value;			
			var fechaDesde = document.getElementById("fechaDesde").value;		
			var fechaHasta = document.getElementById("fechaHasta").value;	
			var codEstadoSol = document.getElementById("codEstadoSol").value;
				
			//if (numSolScoring == "" && codVendedor == "" && codCliente == ""){
				//alert("Debe ingresar al menos un filtro entre N\u00FAmero Solicitud, Vendedor, o Cliente");
				//return false;
			//}			            
			if (numSolScoring == "" && (fechaDesde == "" || fechaHasta == "")){
				alert("Debe ingresar Rango de Fechas");
				return false;
			}
			
			if(fechaDesde != "" && fechaHasta != "")
			{					   
		       var miFecha1 = new Date( fechaDesde.substring(6), fechaDesde.substring(3,5), fechaDesde.substring(0,2) );		     
			   var miFecha2 = new Date( fechaHasta.substring(6), fechaHasta.substring(3,5), fechaHasta.substring(0,2));   		  	
			   var diferencia =  miFecha2.getTime() - miFecha1.getTime();						   
			   var dias = Math.floor(diferencia / (1000 * 60 * 60 * 24));   
			   var segundos = Math.floor(diferencia / 1000);
			   if(dias < 0){
				   alert ("Rango de fechas no corresponde");
				   return false;
			   }else  if(dias > 31){
				   alert ("Rango de fechas no puede superar los 31 dias");
				   return false;				   
			   }
			}
            
			if (numSolScoring != ""){
				//valida numero de solicitud
				numSolScoring = parseInt(numSolScoring);
		        if (isNaN(numSolScoring)) { 
			        alert("N\u00FAmero de Solicitud Inv\u00E1lido");
			        document.getElementById("numSolScoring").value = "";
		            return false; 
		        }                 
		        document.getElementById("numSolScoring").value = numSolScoring;
			}
			     
			document.getElementById("divResultadoBusqueda").style["display"] = "none";
			document.getElementById("divBotones").style["display"] = "none";
			
			JSolicitudScoringAJAX.obtenerSolicitudesScoring(numSolScoring, codVendedor, codOficina, 
				codCliente, fechaDesde, fechaHasta, codEstadoSol, fncResultadoObtenerSolicitudes);			
	}
	
	function fncResultadoObtenerSolicitudes(data)
	{
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	    }//fin if (data!=null)
	    
		document.getElementById("numSolScoringSel").value = "";	    
		document.getElementById("opcion").value = "buscarSolicitudes";
	   	document.forms[0].submit();
	}
	
	function fncSeleccionaSolicitud(numSolScoring){
			document.getElementById("numSolScoringSel").value = numSolScoring.value;	    
	}	
	
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
	function fncInvocarPaginaExpiraSesion(){
    	document.forms[0].submit();
	}	
	
	function fncContinuar(){
		var numSolScoringSel = document.getElementById("numSolScoringSel");
		if (numSolScoringSel.value==""){
			alert("Debe seleccionar una solicitud");
			return false;
		}
		
	  	document.getElementById("opcion").value = "continuar";
    	document.forms[0].submit();
	}
	
	function irAReporteScoring() {
	  	var numSolScoringSel = document.getElementById("numSolScoringSel");
		if (numSolScoringSel.value == "") {
			alert("Debe seleccionar una solicitud");
			return false;
		}
	  	document.getElementById("opcion").value = "irAReporteScoring";
	  	document.forms[0].submit();
	}
	
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/GestionScoringAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="codVendedorSeleccionado" styleId="codVendedorSeleccionado"/>
<html:hidden property="numSolScoringSel" styleId="numSolScoringSel"/>
<bean:define id="codFormularioOrigen" name="GestionScoringForm" property="codFormularioOrigen" type="java.lang.String" />
	
      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2>
	       <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">&nbsp;
	       <bean:write name="GestionScoringForm" property="titulo" />
	       </h2>
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr >
		  	<td class="mensajeError">
			     <div id="mensajes" >
			     	  <logic:present name="mensajeError">
				     	  <bean:write name="mensajeError"/>
			     	  </logic:present>
		     	</div>
		     </td>
		  </tr> 
		</table>		  
	  <P>
	  
	<table width="90%">	  
		<tr>
		    <td  align="left" colspan="5" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
		     Datos Scoring:
		    </td>
		</tr>	
		<tr>
		    <td align="left" >N&uacute;mero Scoring</td>
		    <td align="left" colspan="4">
			<c:choose> 
			  <c:when test="${!empty requestScope.disableDatVent && requestScope.disableDatVent == 'true'}" > 
				<html:text name="GestionScoringForm" property="numSolScoring" styleId="numSolScoring" onkeypress="onlyInteger();" size="30" maxlength="15" onchange="ocultarMensajeError();" disabled="true"/>
			  </c:when> 
			  <c:otherwise> 
		    	<html:text name="GestionScoringForm" property="numSolScoring" styleId="numSolScoring" onkeypress="onlyInteger();" size="30" maxlength="15" onchange="ocultarMensajeError();"/> 
			  </c:otherwise> 
			</c:choose> 		    
		    </td>		    
		</tr>

		<!--------------------  (+) combo de estados ----------------------->
		<tr>
			    <td align="left" >Estado Scoring</td>
			    <td align="left" colspan="4">
					<html:select name="GestionScoringForm" property="codEstadoSol" styleId="codEstadoSol" style="width:300px;" onchange="ocultarMensajeError();">
				  	<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="GestionScoringForm" property="arrayEstadosSol">
							<html:optionsCollection property="arrayEstadosSol" value="codigoValor" label="descripcionValor"/>
						</logic:notEmpty>					
					</html:select>   
			    </td>
			</tr>		
			
		<!--------------------  (-) combo de estados ----------------------->	
																
		<tr>
		    <td colspan="5">
		    <HR noshade>
		  	</td>
		</tr>				
		<tr>
		    <td  align="left" colspan="5" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
		     Datos Vendedor:
		    </td>
		</tr>

		<tr>
		  <td align="left" >Oficina</td>
		  <td align="left" colspan="3">
			<c:choose> 
			  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
				<html:select name="GestionScoringForm" property="codOficina" styleId="codOficina" style="width:300px;" onchange="ocultarMensajeError();fncObtenerVendedores();" disabled="true">
		  			<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="GestionScoringForm" property="arrayOficina">
							<html:optionsCollection property="arrayOficina" value="codigoOficina" label="descripcionOficina"/>
						</logic:notEmpty>					
				</html:select>    
			  </c:when> 
			  <c:otherwise> 
				<html:select name="GestionScoringForm" property="codOficina" styleId="codOficina" style="width:300px;" onchange="ocultarMensajeError();fncObtenerVendedores();">
		  			<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="GestionScoringForm" property="arrayOficina">
							<html:optionsCollection property="arrayOficina" value="codigoOficina" label="descripcionOficina"/>
						</logic:notEmpty>					
				</html:select> 
			  </c:otherwise> 
			</c:choose>		         
		  </td>
		  <td>&nbsp;</td>
		</tr>      
		<tr>
		  <td align="left" >Vendedor</td>
		  <td align="left" colspan="3">
			<c:choose>
			  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
		  		<html:select name="GestionScoringForm" property="codVendedor" styleId="codVendedor" style="width:300px;" onchange="ocultarMensajeError();fncSeleccionaVendedor(this);" disabled="true">
					<html:option value="">- Seleccione -</html:option>
				</html:select>  
			  </c:when> 
			  <c:otherwise> 
		  		<html:select name="GestionScoringForm" property="codVendedor" styleId="codVendedor" style="width:300px;" onchange="ocultarMensajeError();fncSeleccionaVendedor(this);">
					<html:option value="">- Seleccione -</html:option>
				</html:select>  
			  </c:otherwise>
			</c:choose>			   		  
		   </td>
			<td>&nbsp;</td>		   
		</tr>
		<tr>
		    <td colspan="5">
		    <HR noshade>
		  	</td>
		</tr>
		<tr>
		        <td align="left" colspan="5" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
		         Datos Cliente:
		        </td>
		</tr>
		<tr>
		        <td align="left" >
				  <c:if test="${empty requestScope.disableComponente || requestScope.disableComponente == 'false'}" > 
					<a href="javascript:fncBuscarCliente();" onclick="ocultarMensajeError();"><FONT color="#0000ff">Buscar Cliente</FONT></a>
				  </c:if> 
		        </td>                               
		</tr>
		<tr>
		        <td align="left" width="25%">Tipo Cliente</td>
		        <td align="left" width="10%" >
				<c:choose>
				  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
					<html:text name="GestionScoringForm" property="glsTipoCliente" styleId="glsTipoCliente" style="text-transform: uppercase;"  size="30" readonly="true" disabled="true"/>
				  </c:when> 
				  <c:otherwise> 
					<html:text name="GestionScoringForm" property="glsTipoCliente" styleId="glsTipoCliente" style="text-transform: uppercase;"  size="30" readonly="true"/> 
				  </c:otherwise>
				</c:choose>				        
		 		</td>        
				<td align="left" width="15%">C&oacute;digo Cliente</td>
			   <td align="left" width="50%">
				<c:choose>
				  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
					<html:text name="GestionScoringForm" property="codCliente" styleId="codCliente" size="30" readonly="true" disabled="true"/>
				  </c:when> 
				  <c:otherwise> 
					<html:text name="GestionScoringForm" property="codCliente" styleId="codCliente" size="30" readonly="true"/> 
				  </c:otherwise>
				</c:choose>				             
		        </td>
		        <td width="10%">&nbsp;</td>
        </tr>
        <tr>
		    <td colspan="5">
		    <HR noshade>
		</td>
		</tr>        
		<tr>
		        <td align="left" colspan="5" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
		         Rango Fechas:
		        </td>
		</tr>
		<tr>        
		   <td align="left">(*) Desde</td>
		   <td align="left" nowrap> 
				<c:choose>
				  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
					<html:text name="GestionScoringForm" property="fechaDesde" styleId="fechaDesde" size="30" readonly="true" tabindex="1" disabled="true"/>
				  </c:when> 
				  <c:otherwise> 
					<html:text name="GestionScoringForm" property="fechaDesde" styleId="fechaDesde" size="30" readonly="true" tabindex="1"/> 
					<a href="#" ><img name="fec1" src="<%=request.getContextPath()%>/img/calendar/calendar.gif" border="0" class="select" onClick="ocultarMensajeError();displayCalendar(fechaDesde,'dd-mm-yyyy',this)"></a>
				  </c:otherwise>
				</c:choose>				   			   	                                        
			</td>
			<td align="left">(*) Hasta </td>
			<td align="left" >
				<c:choose>
				  <c:when test="${!empty requestScope.disableComponente && requestScope.disableComponente == 'true'}" > 
					<html:text name="GestionScoringForm" property="fechaHasta" styleId="fechaHasta" size="30" readonly="true" tabindex="2" disabled="true"/>
				  </c:when> 
				  <c:otherwise> 
					<html:text name="GestionScoringForm" property="fechaHasta" styleId="fechaHasta" size="30" readonly="true" tabindex="2"/>
					<a href="#" ><img name="fec2" src="<%=request.getContextPath()%>/img/calendar/calendar.gif" border="0" class="select" onClick="ocultarMensajeError();displayCalendar(fechaHasta,'dd-mm-yyyy',this)"></a>
				  </c:otherwise>
				</c:choose>							   				   	
			</td>			
		 </tr>   
		 <tr><td colspan="5">&nbsp;</td></tr>
	     <tr>
	     <td colspan="5">
	     <table width="100%">
	     	<tr>
	          <td width="55%">&nbsp;</td>   
	          <td width="10%">
   				<html:button  value="LIMPIAR" style="width:120px;color:black" property="btnLimpiar" styleId="btnLimpiar" onclick="ocultarMensajeError();fncLimpiar();"/>
	          </td>             
	          <td width="25%" align="right" >
				<c:choose>
				  <c:when test="${!empty requestScope.disableBuscar && requestScope.disableBuscar == 'true'}" > 
					<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscarSolicitudes" styleId="btnBuscarSolicitudes" onclick="ocultarMensajeError();fncBuscarSolicitudes();" disabled="true"/>
				  </c:when> 
				  <c:otherwise> 
					<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscarSolicitudes" styleId="btnBuscarSolicitudes" onclick="ocultarMensajeError();fncBuscarSolicitudes();"/> 
				  </c:otherwise>
				</c:choose>	          				          
	          </td>  
	         </tr>
	     </table>
		 </td>	     
	     </tr>   
	     <tr>
		     <td colspan="5">
		      <HR noshade>
		    </td>
		 </tr>       		    
 	</table> 
 	  
   	<div id="divResultadoBusqueda" style="display:none">
	  <h2 align="center">Coincidencias:<br>
	  	  De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.
	 </h2>
	</div>
	<P>

	<display:table id="solicitudes" name="listaSolicitudes" scope="session" pagesize="10" requestURI=""  width="90%" >
		<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="3%">
			<input type="radio" name="rdSolicitudSel" onclick="ocultarMensajeError();fncSeleccionaSolicitud(this);" value="<bean:write name="solicitudes" property="nroSolScoring"/>">
		</display:column>
		<display:column property="nroSolScoring" title="N° Solicitud" headerClass="textoColumnaTabla" width="8%"  align="right"/>		
		<display:column title="Fecha Creación" headerClass="textoColumnaTabla" width="15%" align="center">
			<logic:notEmpty name="solicitudes" property="fechaCreacion">
				<bean:write name="solicitudes" property="fechaCreacion" locale="Locale-PortalVentas" format="dd-MM-yyyy HH:mm:ss" />
			</logic:notEmpty>
		</display:column>
		<display:column property="nombreCliente" title = "Nombre Cliente" headerClass="textoColumnaTabla" width="23%"/>		
		<display:column property="nombreVendedor" title = "Nombre Vendedor" headerClass="textoColumnaTabla" width="23%"/>			
		<display:column property="nit" title ="NIT" headerClass="textoColumnaTabla" width="10%" align="center"/>	
		<display:column property="desEstado" title="Estado Actual" headerClass="textoColumnaTabla" width="18%" align="center" />			
	</display:table>    
		  
     <P>
     <P>
     <P>
     <P>
     <P>
   	    <TABLE cellSpacing="0" cellPadding="0" width="80%" border="0" align="center">
	      <tr>
	        <td align="left" width="50%" >
	        </td>
	        <td width="25%" align="right">
	        </td>
	        <td width="25%" align="right">
	        	<div id="divBotones" style="display:none">
		        	<logic:equal name="GestionScoringForm" property="codFormularioGestionScoring" value="<%= codFormularioOrigen %>">
		       			<html:button value=">>" style="width:120px;color:black" property="btnContinuar" styleId="btnContinuar" onclick="ocultarMensajeError();fncContinuar();"/>	        
		       		</logic:equal>
		       		<logic:equal name="GestionScoringForm" property="codFormularioReportesScoring" value="<%= codFormularioOrigen %>">
		       			<html:button value="VER REPORTE" style="width:120px;color:black" property="btnReporte" styleId="btnReporte" onclick="ocultarMensajeError();irAReporteScoring();"/>	        
		       		</logic:equal>
	       		</div>
	        </td>
	      </tr>
	    </TABLE>
	
     <P>    
   <TABLE align="center" width="90%">			
      <tr>
		  <td align="left"><i>(*) :  Dato es obligatorio</i></td>
	  </tr>	   
   </TABLE>    
</html:form>
</body>


</html:html>
