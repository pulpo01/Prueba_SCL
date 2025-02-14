<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<c:set var="retornoAlta" value="${sessionScope.retornoAltaDTO}"/>

<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"   pageEncoding="ISO-8859-1"%>
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
	
	function fncAceptar() {
    	document.forms[0].submit();
	}
</script>
</head>
<body onload="history.go(+1);" onkeydown="validarTeclas();">
<html:form method="POST" action="/AltaClienteFinalAction.do">
<html:hidden property="opcion" value="irAMenu"/>
<table width="80%">
  <tr>
   <td class="amarillo" >
  <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Creación de Clientes&nbsp;
       </td>            
      </tr>
    </table>
 <P>
     <logic:present name="mensajeError">
	  <table>
	    <tr>
	        <td class="mensajeError">&nbsp;<bean:write name="mensajeError"/></td>
	    </tr>
	  </table>
	  <P>
	  <P>
	  <P>
	  <P>
	  <P>
	  <P>	  
	 </logic:present>

     <logic:notPresent name="mensajeError">
	  <table align="center" width="60%" border="0" >
	    <tr>
          <td align="center" class="amarillo"><h2>
          	Se ha realizado con &eacute;xito la creaci&oacute;n de cliente.<br>
          	Para su gesti&oacute;n anote los siguientes valores.<br>
          </td>
	    </tr>
	  </table>
	  <P>
	  <P>
	  <P>
      <table align="center" width="60%" border="0">
        <tr>
          <td width="30%"><strong>C&oacute;digo de Cuenta</strong></td>
          <td width="70%">
			 <input type="text" name="txtCodigoCuenta" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="retornoAlta" property="codigoCuenta"/>" />
		  </td>
        </tr>
        <tr>
          <td><strong>C&oacute;digo de Cliente</strong></td>
          <td>
			<input type="text" name="codigoClienteCreado" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="retornoAlta" property="codigoCliente"/>" 
			/>
          </td>
        </tr>
        <tr>
          <td><strong>Nombre del Cliente</strong></td>
          <td>
			<input type="text" name="nombreClienteCreado" 
				   size="40" maxlength="20" disabled="disabled" style="text-align:center"
				   value="<bean:write name="retornoAlta" property="nombreCliente"/>"	/>
          </td>
        </tr>
        <tr>
          <td colspan="2">&nbsp;</td>
        </tr>
     </table>
     </logic:notPresent> 

     <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr> 
       <td align="center">
         <html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="fncAceptar();"/>
       </td>
      </tr>
     </TABLE>
</html:form>

</body>
</html:html>

