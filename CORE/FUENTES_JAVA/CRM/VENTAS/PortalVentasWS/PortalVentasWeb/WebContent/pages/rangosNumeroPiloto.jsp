<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display" %>
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
<script>
 	window.history.forward(1);
 	
 	function fncValidaLongitud(texto)
	{
			var valor = texto.value;
  		    if(valor.length > 500) {
		     	alert("Texto no puede superar los 500 caracteres");
  		    }
	}
	
	function moveOption(destiny, source)
	{
		if (source.options.length > 0)
			while(areThereSelectedOnes(source))
				for(i = 0; i < source.options.length; i++)
					if (source.options[i].selected)
					{
						addSelectOption(destiny, source.options[i].text, source.options[i].value, false);
						source.options[i] = null;
					}
	}
	
	function areThereSelectedOnes(selectObj)
	{
		for(i = 0; i < selectObj.options.length; i++)
			if (selectObj.options[i].selected)
				return true;
				
		return false;
	}
	
	function addSelectOption(selectObj, text, value, isSelected) 
	{
	    if (selectObj != null && selectObj.options != null)
	        selectObj.options[selectObj.options.length] = new Option(text, value, false, isSelected);
	}

	function fncAsociar(){
		moveOption(document.getElementById("rangosAsociadosSelectId"), document.getElementById("rangosDisponiblesSelectId"));
	}

	function fncDesAsociar(){
		moveOption(document.getElementById("rangosDisponiblesSelectId"), document.getElementById("rangosAsociadosSelectId"));
	}
	
	function selectAll(target)
	{	 
		for(i = 0; i < target.options.length; i++)
		{    
			target.options[i].selected = true;	
		}
	}	

	function init()
	{
		unselectAll(document.getElementById("rangosAsociadosSelectId"));
		unselectAll(document.getElementById("rangosDisponiblesSelectId"));
	}
	
	function unselectAll(target)
	{
		for(i = 0; i < target.options.length; i++)
			target.options[i].selected = false;
	}

	function fncCancelar(){
		document.getElementById("opcion").value = "cancelarRangosPiloto";
		document.forms[0].submit();
	}
	
	function fncAceptar(){	
	    
	    if(document.getElementById("rangosAsociadosSelectId").options.length > 0)
	    {
			selectAll(document.getElementById("rangosAsociadosSelectId"));
			selectAll(document.getElementById("rangosDisponiblesSelectId"));
	
		  	document.getElementById("opcion").value = "aceptarRangosPiloto";
		   	document.forms[0].submit();	
		} else alert("Se debe seleccionar al menos un rango de numeros");				
	}
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje){
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError(){
	    document.getElementById("mensajes").innerHTML = ""; 
	}
</script>
</head>

<body onload="history.go(+1);init();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/BuscaNumeroAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Asociación de Rangos a n&uacute;mero piloto
         </td>            
        </tr>
      </table>
	  <P>
		<table width="100%" border="0" >
		  <tr >
		     <td class="mensajeError"><div id="mensajes" class="mensajeError"></div></td>
		  </tr> 
		</table>		  
	  <P>
	  
	<table width="90%">	  
		
		<tr>
		    <td align="left" >Nombre Cliente :</td>
		    <td align="left" ><bean:write name="BuscaNumeroForm" property="nombreCliente"/></td>
		</tr>	
		<tr>
		    <td align="left" >N&uacute;mero Piloto :</td>
		    <td align="left" ><bean:write name="BuscaNumeroForm" property="numeroSel"/></td>
		</tr>	
								
		<tr>
		    <td colspan="2">
		    <HR noshade>
		  	</td>
		</tr>				
	</table>
	  <P>
	<table cellspacing="10" width="90%" align="center">
				<tr>
					<td align="center" width="40%"><b>Disponibles</td>
					<td width="20%">&nbsp;</td>
					<td align="center" width="40%"><b>Asociados</td>
				</tr>
				
				<tr>
					<td align="center">
						<html:select name="BuscaNumeroForm" property="rangosDisponiblesSeleccionados" multiple="multiple" size="15" style="width: 210px" styleId="rangosDisponiblesSelectId" >
						<logic:present name="BuscaNumeroForm"
							property="rangosDisponibles">
							<html:optionsCollection property="rangosDisponibles" value="value" label="label" />
						</logic:present>						
						</html:select>
					</td>
					
					<td>
					<table >
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<html:button  value="ASOCIAR >>" style="width:120px;color:black" property="btnAsociar" styleId="btnAsociar" onclick="ocultarMensajeError();fncAsociar()"/>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>
								<html:button  value="<< DESASOCIAR" style="width:120px;color:black" property="btnDesAsociar" styleId="btnDesAsociar" onclick="ocultarMensajeError();fncDesAsociar()"/>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
						</tr>
					</table>
					</td>
					
					<td align="center">
						<html:select name="BuscaNumeroForm" property="rangosAsociadosSeleccionados" multiple="multiple" size="15" style="width: 210px" styleId="rangosAsociadosSelectId">
						<logic:present name="BuscaNumeroForm"
							property="rangosAsociados">
							<html:optionsCollection property="rangosAsociados" value="value" label="label" />
						</logic:present>						
						</html:select>
					</td>

				</tr>
	</table>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="50%" align="left">
        </td>
        <td align="right" width="25%">
        	<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="ocultarMensajeError();fncCancelar()"/>
        </td>
        <td align="right" width="25%">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="ocultarMensajeError();fncAceptar();"/>
        </td>
        
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>