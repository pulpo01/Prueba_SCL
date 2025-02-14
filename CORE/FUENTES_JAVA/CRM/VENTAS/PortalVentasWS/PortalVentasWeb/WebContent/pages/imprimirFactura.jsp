<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>    
<meta http-equiv="expires" content="0">

<script language="JavaScript" type="text/javascript">

 function imprimirFactura(){
     var mensaje = '<%=request.getAttribute("mensajeError")%>';
	 if("null"==mensaje||""==mensaje){
		 	document.getElementById("opcion").value = "imprimirFactura";
		   	document.forms[0].submit();
	 }else{
 		alert(mensaje);
 		window.close();
 	}
 }

</script>

</head>
<body onload="imprimirFactura();"  onUnload="return false;">
<center>Imprimiendo Factura</center>
<html:form method="POST" action="/CargosAction.do" target="_self">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
</html:form>
</body>
</html>