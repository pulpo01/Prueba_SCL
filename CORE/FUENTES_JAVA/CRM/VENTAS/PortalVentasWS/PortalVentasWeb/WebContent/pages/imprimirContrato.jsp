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

 var envioProxRepor = "NO";

 function imprimirContrato(){
 	var mensaje = '<%=request.getAttribute("mensajeError")%>';
 	if("null"==mensaje||""==mensaje){
 		document.getElementById("opcion").value = "imprimirContrato";
		document.forms[0].submit();
		envioProxRepor = "NO";
 	}else{
 		alert(mensaje);
		envioProxRepor="SI";
		window.close();
 	}
 	

 }
 
 function imprimirAnexoTerminales(){
	 		if(envioProxRepor=="NO"){
		 	    var url = "<%=request.getContextPath()%>/pages/imprimirAnexoTerminales.jsp";
				window.open(url, "imprimirAnexoTerminales", "dialogHeight:10%; dialogWidth:20%; center:yes; menubar:no;help:no; status:no; resizable:no");
				envioProxRepor="SI";
			}
 }
</script>

</head>
<body onload="imprimirContrato();" onUnLoad="imprimirAnexoTerminales();" >
<center>Imprimiendo Contrato</center>
<html:form method="POST" action="/CargosAction.do" target="_self">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
</html:form>
</body>
</html>