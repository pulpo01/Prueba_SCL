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
<script>
window.history.forward(1); 	

	function fncAnterior(){
			document.getElementById("opcion").value = "anteriorDatosInstalacion";
		   	document.forms[0].submit();
	}	
</script>
</head>

<body onload="history.go(+1);" onkeydown="validarTeclas();">
<html:form method="POST" action="/ConsultaVentasVendedorAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>

      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Datos de Instalaci&oacute;n&nbsp;
         </td>            
        </tr>
      </table>
	  <P>

     <P>
     	<html:textarea cols="100" rows="32" name="ConsultaVentasVendedorForm" property="detalleInstalacionAbonado" readonly="true" styleId="detalleInstalacionAbonado"></html:textarea>
     <P>
     <P>
     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr>
        <td width="25%" align="left">
			<html:button  value="<<" style="width:120px;color:black" property="btnAnterior" styleId="btnAnterior" onclick="fncAnterior();"/>
        </td>      
        <td width="75%" align="right">
        </td>
      </tr>
    </TABLE> 
     
</html:form>

</body>
</html:html>