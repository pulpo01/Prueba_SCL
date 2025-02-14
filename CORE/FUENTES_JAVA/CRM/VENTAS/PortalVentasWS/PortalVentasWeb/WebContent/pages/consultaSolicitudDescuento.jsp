<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JCargosAJAX.js'></script>
<script>
	window.history.forward(1);
	
	document.onkeydown = function(){
     if(window.event && window.event.keyCode == 8)
	  {
	   window.event.keyCode = 505;
      }
    }
   
   function obtenerEstadoSolicitud() {
     var numeroSolicitudAutorizacion = $("numeroSolicitudAutorizacion"); 
     solicitud=JCargosAJAX.consultaEstadoSolicitud(numeroSolicitudAutorizacion.value,llenaCapa);
   }
   
   function llenaCapa(solicitud){
	if (solicitud.codigoEstado=="-100"){
		fncInvocarPaginaExpiraSesion();
		return;
	}
	
    document.getElementById("estado").value = solicitud.descripcionEstado;
   }
   
   function generaSolicitud(){
 	 solicitud=JCargosAJAX.generaSolicitud(resConsulta);
   }
   
   function resConsulta(solicitud){
    if (solicitud!=null){
    	if (solicitud.codigoEstado=="-100"){
			fncInvocarPaginaExpiraSesion();
			return;
		}	
      $("numeroSolicitudAutorizacion").value = solicitud.numeroAutorizacion;
       document.getElementById("numSol").value = solicitud.numeroAutorizacion;
    }
   } 	

	function fncInvocarPaginaExpiraSesion(){
    	window.close();
	}		
</script>
</head>

<body onLoad="history.go(+1);generaSolicitud();" onpaste="return false;" onkeydown="validarTeclas();">
<center>
<html:form method="POST" action="/CargosAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden id="numeroSolicitudAutorizacion" property="numeroSolicitudAutorizacion" styleId="numeroSolicitudAutorizacion"/>
	      <table width="100%">
	        <tr>
	         <td class="amarillo" >
		        <h2>
	              <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="center">
	              Solicitud de aprobaci&oacute;n de descuento adicional:
	              &nbsp;
	            </h2>
	         </td>   
	        </tr>
	      </table>
		  <p><p><p><p>	
	      <table width="90%">
	        <tr>
	          <td class="verde" align="center" style="font-size:11pt">
	          		 Para saber si ha sido aprobada su solicitud presione el bot&oacute;n<br>
	          		 "CONSULTAR".<br>
	          </td>   
	        </tr>
	       </table>   

		   <p><p><p><p><p><p><p><p><p> 	 		 
		   <table width="75%">
	         <tr>
		      <td class="verde" width="60%" align="left" style="font-size:12pt">
		      	<STRONG>N&uacute;mero de solicitud</STRONG>
			  </td>
		      <td width="40%" align="left">
               	<input type="text" readonly="true" name="numSol" id="numSol" size="37"/>
			  </td>
	         </tr>
	       </table> 
		   <p><p><p><p><p><p><p><p><p>	        
           <table width="75%">
	        <tr>
		      <td width="30%" align="center">
   				<html:button  value="CONSULTAR" style="width:120px;color:black" property="btnConsultar" styleId="btnConsultar" onclick="obtenerEstadoSolicitud();"/>
			  </td>
		      <td class="verde" width="30%" align="center" style="font-size:12pt">
		      	<STRONG>Estado</STRONG>
			  </td>
		      <td width="40%" align="left">
               	<input type="text" readonly="true" name="estado" id="estado" size="37"/>		      
			  </td>
	        </tr>
	       </table>
		   <p><p><p><p><p><p><p><p><p>	       
	       <table width="75%">
	        <tr>
		      <td width="30%"></td>
		      <td width="30%" align="center">
				<html:button  value="CONTINUAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="Javascript:window.close();"/>
			  </td>
			  <td width="40%"></td>
	        </tr>
	       </table> 

     
</html:form>
</center>

</body>
</html:html>