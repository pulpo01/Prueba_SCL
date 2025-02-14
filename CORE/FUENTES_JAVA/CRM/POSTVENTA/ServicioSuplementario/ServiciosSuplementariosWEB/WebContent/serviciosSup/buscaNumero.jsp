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
<link href="<%=request.getContextPath()%>/serviciosSup/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/serviciosSup/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/serviciosSup/js/buscaNumero.js'></script>
<script>
	window.history.forward(1);
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/BuscaNumeroAction.do">
<html:hidden property="opcion" value="inicio"/>
<html:hidden property="tipoBusqueda"/>
<html:hidden property="numeroSel"/>
<html:hidden property="busquedaRangoInf"/>
<html:hidden property="busquedaRangoSup"/>
<html:hidden property="rangoInfSel"/>
<html:hidden property="rangoSupSel"/>
<html:hidden property="largoPrefijo"/>
<html:hidden property="largoNumCelular"/>
<html:hidden property="tablaNumeracionAut"/>
<html:hidden property="categoria"/>
<html:hidden property="fechaBaja"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">B&uacute;squeda Numeraci&oacute;n&nbsp;
         </h2></td>            
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
<tr><td width="100%">
      <table width="100%">	  
      <tr>
	      <td width="15%">&nbsp;</td>
          <td align="left" width="25%" >Tipo B&uacute;squeda</td>
 		  <td align="left" width="35%">
 		  	<html:radio onclick="ocultarMensajeError();fncSeleccionaTipoBusqueda(this);" name="BuscaNumeroForm" property="rdTipoBusqueda" value="M">MANUAL&nbsp;&nbsp;</html:radio>
 		  	<html:radio onclick="ocultarMensajeError();fncSeleccionaTipoBusqueda(this);" name="BuscaNumeroForm" property="rdTipoBusqueda" value="A">AUTOMATICA&nbsp;&nbsp;</html:radio>
		  </td>  	  
		  <td width="25%"></td>  	  
      </tr>
      <tr>
      	<td width="15%"></td>
      	<td align="left" width="25%">Buscar N&uacute;meros</td>
      	<td align="left" width="35%">
      		<html:select name="BuscaNumeroForm" property="codCriterioBusqueda" style="width:200px;" onchange="ocultarMensajeError();fncMostrarFiltros();"> 
      			<html:option value="">- Seleccione -</html:option>
      			<html:option value="RE">RESERVADOS</html:option>
      			<html:option value="RU">REUTILIZABLES</html:option>
      			<html:option value="RA">RANGO</html:option>				
      		</html:select>	
      	</td>
      	<td width="25%">&nbsp;</td>
      </tr>
      </table>
 </td></tr>
 
 <tr><td> 
    <div id="divFiltroRango" style="display:none">    
    <table width="100%">    
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%">L&iacute;mite Inferior Rango</td>   
          <td align="left" width="35%">
	          <input type="text" onchange="ocultarMensajeError();" id="busquedaRangoInfAux" size="35" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>" 
	          value="<bean:write name="BuscaNumeroForm" property="busquedaRangoInf"/>" onkeypress="onlyInteger();">
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
     <tr>  
	      <td>&nbsp;</td>
          <td>L&iacute;mite Superior Rango</td>   
          <td align="left">
	          <input type="text" onchange="ocultarMensajeError();" id="busquedaRangoSupAux" size="35" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>" 
	          value="<bean:write name="BuscaNumeroForm" property="busquedaRangoSup"/>" onkeypress="onlyInteger();">
          </td>             
          <td>&nbsp;</td>      
	 </tr>	
     <tr>  
	      <td colspan="2">&nbsp;</td>	<html:hidden property="largoPrefijo"/>
          <td align="left">Prefijo&nbsp;&nbsp;
	          <input type="text" onchange="ocultarMensajeError();" id="prefijo" size="10" maxlength="<bean:write name="BuscaNumeroForm" property="largoPrefijo"/>" 
	          value="" onkeyup="fncPrefijo(this);" onkeypress="onlyInteger();">
          </td>             
          <td>&nbsp;</td>      
	 </tr>	
	 </table> 
     </div>
 </td></tr>

 <tr><td> 
	<table width="100%">    
     <tr>
	      <td width="15%">&nbsp;</td>
          <td width="25%">&nbsp;</td>   
          <td width="35%">&nbsp;</td>             
          <td align="left" width="25%">
			<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscar" onclick="ocultarMensajeError();fncBuscar();"/>          
          </td>  
     </tr>     
     <tr>
	     <td colspan="4">
	      <HR noshade>
	    </td>
	 </tr>       
    </table> 
 </td></tr>    
 <tr><td> 
    <div id="divNumeroSelRango" style="display:none">    
    <table width="100%">    
     <tr>  
	      <td width="15%">&nbsp;</td>
          <td width="25%">N&uacute;mero</td>   
          <td align="left" width="35%">
              <input type="text" onchange="ocultarMensajeError();" id="numeroRango" size="20" maxlength="<bean:write name="BuscaNumeroForm" property="largoNumCelular"/>"  value="" onkeypress="onlyInteger();" onblur="fncValidarNumeroRango(this);">
          </td>             
          <td width="25%">&nbsp;</td>      
	 </tr>
	 </table> 
     </div>
 </td></tr>
 
 </table> 
     
<P>
     <div id="divResultadoBusqueda" style="display:none">
	  <h3 align="center">Coincidencias:<br>
	  	  De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.
	  </h3>
	  </div>
     <P>
     
    <div id="divResultadoNumero" style="display:none" align="center">
	<display:table  id="numeros" name="listaNumeros" scope="session" pagesize="10" requestURI=""  width="90%" >
		<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="8%">
			<input type="radio" name="rdNumeroSel" onclick="ocultarMensajeError();fncSeleccionaNumero(this);" value="<bean:write name="numeros" property="numCelular"/>">
		</display:column>
		<display:column property="numCelular" title = "N&uacute;mero Celular" headerClass="textoColumnaTabla" width="%"/>
	</display:table>    
	</div> 
	
	<div id="divResultadoRango" style="display:none" align="center">
	<display:table  id="numeros" name="listaNumerosRango" scope="session" pagesize="10" requestURI=""  width="90%" >
		<display:column title = "Sel" headerClass="textoColumnaTabla" class="textoFilasColorTabla" width="8%">
			<input type="radio" name="rdRangoSel" onclick="ocultarMensajeError();fncSeleccionaRango('<bean:write name="numeros" property="numDesde"/>','<bean:write name="numeros" property="numHasta"/>');" value="<bean:write name="numeros" property="numDesde"/>">
		</display:column>
		<display:column property="numDesde" title = "N&uacute;mero Celular" headerClass="textoColumnaTabla" width="46%"/>
		<display:column property="numHasta" title = "Fin Rango" headerClass="textoColumnaTabla" width="numHasta%"/>		
	</display:table>    
	</div> 
	
     <P>
     <P>
    </p><TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="50%" align="left">
        </td>
        <td align="right" width="25%">
        	<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" onclick="ocultarMensajeError();fncCancelar()"/>
        </td>
        <td align="right" width="25%">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" onclick="ocultarMensajeError();fncAceptar();"/>
        </td>
        
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>
