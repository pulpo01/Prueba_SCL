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
<meta http-equiv="P3P" content='CP="IDC DSP COR CURa ADMa OUR IND PHY ONL COM STA"' /> 
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
	window.history.forward(1);

	function fncAnterior(){
			document.getElementById("opcion").value = "anteriorVisualizarDocumento";
		   	document.forms[0].submit();
	}
	
</script>
</head>

<body onkeydown="validarTeclas();" >
<html:form method="POST" action="/ConsultaVentasVendedorAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>

<table width="100%">
<tr>
   	<td height="30%" width="100%" valign="top">

      <table width="100%" >
        <tr>
	         <td class="amarillo" colspan="7">
		       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">
		       Visualización de Documento: <bean:write name="documentoSel" property="glsTipoDocumento"/>
	         </td>            
        </tr>
		<tr>
			<td colspan="7">&nbsp;</td>
		</tr>		
		<tr>
			<td width="4%">&nbsp;</td>
			<td width="10%" class="campoInformativo">Cliente</td>
			<td width="2%">:</td>
			<td width="40%" class="valorCampoInformativo" ><bean:write name="ventaSel" property="nombreCliente"/> - <bean:write name="ventaSel" property="codCliente"/></td>
			<td width="10%" class="campoInformativo">Venta</td>
			<td width="2%">:</td>
			<td width="32%" class="valorCampoInformativo" ><bean:write name="ventaSel" property="nroVenta"/></td>
		</tr>
		<tr>
			<td colspan="6">&nbsp;</td>
			<td align="right">
			<html:button  value="<<" style="width:120px;color:black" property="btnAnterior" styleId="btnAnterior" onclick="fncAnterior();"/>
			</td>
		</tr>		
		<tr>
			<td colspan="7">&nbsp;</td>
		</tr>		
      </table>
    </td>  
</tr>

<!-- (+)CARGA DOCUMENTO -->
<tr>
	<td height="70%" width="100%" valign="top">
		<table width="100%" height="450" align="left" border="1">
		<tr>
	   		<td width="100%" height="100%" valign="top" >
	          <iframe  src='<%=request.getContextPath()%>/ImpresionAction.do?opcion=<bean:write name="documentoSel" property="accionAsocImpresion"/>' id="doc" name="doc" width="100%" height="100%" frameborder="0" style="overflow-x:false" scrolling="auto">	
	          </iframe>	
	   		</td>
   		</tr>  
   		</table> 		
   		</div>
	</td>
</tr>
<!-- (-)CARGA DOCUMENTO -->

</tr>
</table>
</html:form>

</body>
</html:html>
