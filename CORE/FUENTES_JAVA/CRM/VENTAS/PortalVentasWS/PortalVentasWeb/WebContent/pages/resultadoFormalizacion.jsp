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

//P-CSR-11002 JLGN 11-11-2011
var flagContrato = "<bean:write name="flagBtnContrato"/>"; 	
 	
function fncInicio(){
	//habilita menus
	var win = parent
	win.fncActDesacMenu(false);
	if (flagContrato == "true"){
		document.getElementById("btnDocumento").disabled=true;		
	}
}
 	
function fncVolver(){
  	document.getElementById("opcion").value = "irAMenu";
   	document.forms[0].submit();

}

//P-CSR-11002 JLGN 26-05-2011
function fncImprimirContrato() {
		document.getElementById("btnDocumento").disabled=false;
 		document.getElementById("opcion").value = "imprimirContrato";
	   	document.forms[0].submit();
  	}
  	
//MA-180654 HOM	
function imprimirDctos() {
		var url = "<%=request.getContextPath()%>/pages/imprimirContrato.jsp";
		window.open(url, "imprimirContrato", "dialogHeight:10%; dialogWidth:20%; center:yes; menubar:no;help:no; status:no; resizable:no");
}  	
 
//P-CSR-11002 JLGN 11-11-2011
function fncIrDocumentos() {	
	document.getElementById("opcion").value = "irConsultaDocumento";
   	document.forms[0].submit();
}  	
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/CargosAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<table  width="80%">
<tr><td width="100%">
      <table width="100%" >
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Formalizaci&oacute;n de Venta&nbsp;
         </td>            
        </tr>
      </table>
</td></tr>
<tr><td>&nbsp;</td></tr>

<logic:present name="mensajeError">
<tr><td>&nbsp;
	  <table>
	    <tr>
	        <td class="mensajeError">&nbsp;<bean:write name="mensajeError"/></td>
	    </tr>
	  </table>
</td></tr>	  
</logic:present>

<tr><td>&nbsp;</td></tr>

<logic:notPresent name="mensajeError">
<bean:define id="resultado" name="resultadoVenta" scope="request" type="com.tmmas.cl.scl.portalventas.web.dto.ResultadoVentaDTO"/>
<tr><td>	 
	  <table align="center" width="80%">
	    <tr>
          <td align="left" class="amarillo" colspan="2">
          <h2>Se ha realizado con &eacute;xito la formalizaci&oacute;n de la venta.</h2>
          </td>
	    </tr>
		<tr><td>&nbsp;</td></tr>	    
	    <tr>
	    <td align="left" width="30%" style="font-size: 11px"><b>N&uacute;mero de Venta:</td>
	    <td align="left" width="70%">
		    <bean:write name="resultado" property="nroVenta" />
		</td>
	    </tr>
	    <tr>
	    <td align="left" width="30%" style="font-size: 11px"><b>Cliente:</td>
	    <td align="left" width="70%">
   	    <bean:write name="resultado" property="codCliente" />-<bean:write name="resultado" property="nombreCliente" />
	    
		</td>
	    </tr>	   
	    <tr>
	    <td align="left" style="font-size: 11px"><b>Vendedor:</td>
	    <td align="left" >
	     <bean:write name="resultado" property="codVendedor" />-<bean:write name="resultado" property="nombreVendedor" />
	    </td>
	    </tr>	  
	    <tr>
	    <td align="left" style="font-size: 11px"><b>Tipo Documento:</td>
	    <td align="left" >
	    <bean:write name="resultado" property="descripcionTipoDocumento" />
	    </td>
	    </tr>	    
	    <tr>
	    <td align="left" style="font-size: 11px"><b>Nro L&iacute;neas:</td>
	    <td align="left" >
	     <bean:write name="resultado" property="cantidadLineas" />
	    </td>
	    </tr>	       
	  </table>
</td></tr>
</logic:notPresent> 
 
<tr><td>&nbsp;</td></tr>
<tr><td align="center" >
	  <table width="80%" >
	  <tr>
	    <td  colspan="4" style ="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 12px;font-weight: bold;">
            L&iacute;neas
           </td>
	  
	  </tr>
	</table>
	
</td></tr>
<tr><td align="center">

	<display:table  id="lineas" name="listaLineas" scope="session" pagesize="10" requestURI=""  width="80%" >
		<display:column property="numAbonado" title = "Nro Abonado" headerClass="textoColumnaTabla" width="15%"/>		
		<display:column property="codGrpPrestacion" title = "Prestacion" headerClass="textoColumnaTabla" width="40%"/>
		<display:column property="numCelular" title = "Celular" headerClass="textoColumnaTabla" width="15%"/>		
		<display:column property="codPlanTarif" title = "Plan Tarifario" headerClass="textoColumnaTabla" width="30%"/>	
	</display:table>   
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>

<tr>
<table>
<td align="center" style="width:33%">
       <input type="button" id="btnVolver" name="btnVolver" value="VOLVER AL MENU" onclick="fncVolver();" style="width:180px;color:black">
</td>
<!-- Inicio P-CSR-11002 JLGN 08-08-2011 -->
<logic:equal name="flagBtnContrato" value="true">
<td align="center" style="width:33%">
       <!--MA-180654 HOM <input type="button" id="btnImprimir" name="btnImprimir" value="IMPRIMIR CONTRATO" onclick="fncImprimirContrato();" style="width:180px;color:black"> -->
       <input type="button" id="btnImprimir" name="btnImprimir" value="IMPRIMIR DOCUMENTOS" onclick="imprimirDctos();" style="width:180px;color:black">
</td>
<!-- Inicio P-CSR-11002 JLGN 11-11-2011 -->
<td align="center" style="width:33%">
       <input type="button" id="btnDocumento" name="btnDocumento" value="BUSCAR DOCUMENTO" onclick="fncIrDocumentos();" style="width:180px;color:black">       
</td>
<!-- Fin P-CSR-11002 JLGN 11-11-2011 -->
</logic:equal>
<logic:equal name="flagBtnContrato" value="false">
<td align="center" style="width:33%">
</td>
<td align="center" style="width:33%">
</td>
</logic:equal>
<!-- Fin P-CSR-11002 JLGN 08-08-2011 -->
</table>
</tr>
</table>
</html:form>
</body>
</html:html>