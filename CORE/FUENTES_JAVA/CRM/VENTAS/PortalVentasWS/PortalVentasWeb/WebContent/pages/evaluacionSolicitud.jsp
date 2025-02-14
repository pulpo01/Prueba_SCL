<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
 	window.history.forward(1);
 	
 	function fncCancelar(){
	 	document.getElementById("opcion").value = "cancelar";
		document.forms[0].submit();	 	
 	}
 	
	function fncAceptar(){
		var flagPermiteCambioEstado = document.getElementById("flagPermiteCambioEstado");
		if (flagPermiteCambioEstado.value == "1"){
			var codEstadoNuevo = document.getElementById("codEstadoNuevo");
			if (codEstadoNuevo.value == ""){
				alert("Debe seleccionar Estado Nuevo");
				return false;
			}
		  	document.getElementById("desEstadoNuevo").value = codEstadoNuevo.options[codEstadoNuevo.selectedIndex].text;
		  	document.getElementById("opcion").value = "aceptar";
		}else{
		  	document.getElementById("opcion").value = "cancelar";
		}
	
    	document.forms[0].submit();
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
	
</script>
</head>

<body onload="history.go(+1);" onkeydown="validarTeclas();">
<html:form method="POST" action="/EvaluacionSolicitudAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<html:hidden property="flagPermiteCambioEstado" styleId="flagPermiteCambioEstado"/>
<html:hidden property="desEstadoNuevo" styleId="desEstadoNuevo"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2>
	       <IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
	       Evaluaci&oacute;n Solicitud de Venta N° <bean:write name="EvaluacionSolicitudForm" property="numVenta"/>
         </td>            
        </tr>
      </table>
      
	  <table width="90%" border="0" >
		  <tr>
		     <td class="mensajeError">
			     <div id="mensajes" >
			     	  <logic:present name="mensajeError">
				     	  <bean:write name="mensajeError"/>
			     	  </logic:present>
		     	</div>
		     </td>
		  </tr> 
	  </table>	
	  
<table width="100%" align="center">
<tr><td width="100%">
      <table width="100%">
        <tr>
           <td align="left" colspan="6" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
                Informaci&oacute;n de Cliente
           </td>
	    </tr>  
	    <tr>
          <td align="left">
            <bean:write name="EvaluacionSolicitudForm" property="desTipoIdentificacion"/></td>
          <td align="right" >:</td>
          <td align="left" colspan="4">
          	<bean:write name="EvaluacionSolicitudForm" property="numIdentificacion"/>          	
          </td>
        </tr>
        <logic:equal name="EvaluacionSolicitudForm" property="flagClienteEmpresa" value="0">  
        <tr>
          <td align="left">Nombre y apellido</td>   
		  <td align="right" >:</td>          
          <td align="left" colspan="4" >
          	<bean:write name="EvaluacionSolicitudForm" property="nombreCompleto"/>
          </td>
        </tr>   
        </logic:equal>
		<logic:equal name="EvaluacionSolicitudForm" property="flagClienteEmpresa" value="1">                
        <tr>
          <td align="left">Nombres empresa</td>
		  <td align="right" >:</td>
          <td align="left" colspan="4" >
	        <bean:write name="EvaluacionSolicitudForm" property="nombreCompleto"/>
          </td>
        </tr>          
		</logic:equal>        
		
        <tr>
          <td align="left" width="27%">Calificaci&oacute;n </td>
		  <td align="right" width="3%">:</td>          
          <td align="left" width="20%">
	        <bean:write name="EvaluacionSolicitudForm" property="calificacion"/>
          </td>
          <td align="left" width="17%">Clasificaci&oacute;n</td>
		  <td align="right" width="3%">:</td>          
          <td align="left" width="30%">
			<bean:write name="EvaluacionSolicitudForm" property="clasificacion"/>
          </td>
        </tr>
        <tr>
          <td align="left">Color</td>
		  <td align="right" >:</td>
          <td align="left">
	          <bean:write name="EvaluacionSolicitudForm" property="color"/>
          </td>
          <td align="left">Segmento</td>
		  <td align="right" >:</td>           
          <td align="left">
  	          <bean:write name="EvaluacionSolicitudForm" property="segmento"/>
          </td>
        </tr>
        <tr>
          <td align="left" >Monto preautorizado</td>
		  <td align="right" >:</td>          
          <td align="left" colspan="4">
	        <bean:write name="EvaluacionSolicitudForm" property="montoPreautorizado"/>
          </td>
        </tr>
        
        <tr><td colspan="6"><HR noshade></td></tr>
        <tr>
           <td align="left" colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
                Informaci&oacute;n de L&iacute;neas Solicitadas</td>
	    </tr> 
        <tr>
          <td align="left" width="27%">Modalidad Venta</td>
		  <td align="right" width="3%">:</td>          
          <td align="left" width="20%"><bean:write name="EvaluacionSolicitudForm" property="desModalidadVenta"/></td>
          <td align="left" width="17%">Tipo Contrato</td>
		  <td align="right" width="3%">:</td>          
          <td align="left" width="30%"><bean:write name="EvaluacionSolicitudForm" property="desTipoContrato"/></td>
        </tr>	         
	</table>
</td></tr>

 <tr><td width="100%" align="center">

 	<display:table  id="lineas" name="EvaluacionSolicitudForm" property="arrayLineasSol" scope="session" pagesize="10" requestURI=""  width="100%" >
		<display:column  width="100%" >
			<table width="100%" >
			<tr>
			<td width="30%"><b>N&uacute;mero Abonado :<bean:write name="lineas" property="numAbonado"/></td>
			<td width="30%"><b>Plan :<bean:write name="lineas" property="planTarifario"/></td>
			<td width="40%"><b>Descripci&oacute;n del Equipo :<bean:write name="lineas" property="desEquipo"/></td>
			</tr>
			<tr>
			<td colspan="3">
			<table width="100%">
			<tr>
				<td width="50%" align="center" class="textoColumnaTabla">Detalle
					Cargos Inmediatos</td>
				<td width="50%" align="center" class="textoColumnaTabla">Detalle Cargos Recurrentes</td>
			</tr>
			<tr>
				<td>
					<table width="100%">
					<tr>
						<td width="40%" align="center"><u>Concepto</u></td>
						<td width="30%" align="center"><u>Cargos</u></td>
						<td width="30%" align="center"><u>Descuentos</u></td>
					</tr>	
					<logic:iterate id="cargo" name="lineas"  property="cargos">									
					<tr>
						<td><bean:write name="cargo" property="desConcepto"/></td>
						<td align="right"><bean:write name="cargo" property="cargos" locale="Locale-PortalVentas" format="###,##0.0000"/></td>
						<td align="right"><bean:write name="cargo" property="descuentos" locale="Locale-PortalVentas" format="###,##0.0000" /></td>					
					</tr>
					</logic:iterate>
					<tr>
						<td colspan="4"><b>Monto Total :<bean:write name="lineas" property="montoTotal" locale="Locale-PortalVentas" format="###,##0.0000"/></td>					
					</tr>
					</table>
				</td>
				<td valign="top">
					<table width="100%">
					<tr>
						<td width="70%" align="center"><u>Concepto</u></td>
						<td width="30%" align="center"><u>Precio</u></td>
					</tr>
					<logic:iterate id="cargosRecurrentes" name="lineas"  property="cargosRecurrentes">									
					<tr>
						<td><bean:write name="cargosRecurrentes" property="desConcepto"/></td>
						<td align="right"><bean:write name="cargosRecurrentes" property="cargos" locale="Locale-PortalVentas" format="###,##0.0000"/></td>
					</tr>
					</logic:iterate>
					</table>
				</td>
			</tr>
						
			</table>
			</td>
			</tr>
			</table>
		</display:column>
	</display:table>   
 
</td></tr>
<tr><td ><HR noshade></td></tr>
 <tr><td width="100%" align="center">
	<table width="100%">
		<tr>
		<td width="27%" align="left"><b>Estado Actual</td>
		<td align="right" width="3%"><b>:</td>
		<td width="20%" align="left"><bean:write name="EvaluacionSolicitudForm" property="desEstadoActual"/></td>
		
		<logic:equal name="EvaluacionSolicitudForm" property="flagPermiteCambioEstado" value="1">   
		<td align="left" width="17%"><b>Estado Nuevo</td>
		<td align="right" width="3%"><b>:</td>  		
		<td width="30%" align="left">
				<html:select name="EvaluacionSolicitudForm" property="codEstadoNuevo" styleId="desEstadoNuevo" style="width: 250px;" onchange="ocultarMensajeError();">
					<html:option value="">- Seleccione -</html:option>				
					<logic:notEmpty name="EvaluacionSolicitudForm" property="arrayEstadosSol">
						<html:optionsCollection property="arrayEstadosSol" value="codEstado" label="desEstado"/>
					</logic:notEmpty>					
				</html:select> 
		</td>
		</logic:equal>
		<logic:equal name="EvaluacionSolicitudForm" property="flagPermiteCambioEstado" value="0">
		<td colspan="3">&nbsp;</td>
		</logic:equal>
		
		</tr>
	</table>
</td></tr>
</table>    
 
     <P>
     <P>

    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td width="50%" align="left">
        </td>      
        <td width="25%" align="right">
			<logic:equal name="EvaluacionSolicitudForm" property="flagPermiteCambioEstado" value="1">           
				<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="ocultarMensajeError();fncCancelar()"/>
			</logic:equal>				
        </td>
        <td width="25%" align="right">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="ocultarMensajeError();fncAceptar();"/>        
        </td>
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>