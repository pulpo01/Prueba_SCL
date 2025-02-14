<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<title>Facturacion Diferenciada - Error</title>
<script language="javascript">
  function fncCerrar(){
     window.close();
  }
</script>
</head>
<body class="body">
<br>
<table width="100%" border="0">
</table>
	<table width=100% align="center">
	<tr>
		<td width="100" rowspan="5"></td>
		<td>
			<br><br>
			<font style="font-family:verdana; font-size: 12pt; color: #dd0000"><b>
			Se ha producido el siguiente error en el sistema : 	<br><br>
		</td>
	</tr>
	<tr>
		<td>
			<logic:present name="error" scope="request">
			<!-- <span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;">-->
			<bean:write name="error"/>
			<!-- </span>--></logic:present>
			<logic:notPresent name="error" scope="request">
			Error inesperado
			</logic:notPresent>
		</td>
	</tr>

	<tr height=30>
		<td>
			<br> 
			<a href="#" onClick="document.getElementById('stacktrace').style.display = 'inline';">Mostrar Detalle</a>
			<br><br>
			<div id="stacktrace" style="display:none">
				<font style="font-family:verdana; font-size: 8pt">
				<%	
				if (request.getAttribute("descripcionError") != null)				
					out.println(request.getAttribute("descripcionError"));	
				 else
			    	out.println("Verifique el log para hallar la causa del problema.");					
				%>
				</font>
			</div>

		</td>
	</tr>
	<tr>
		<td><IMG SRC="botones/btn_salir.gif" onclick="fncCerrar()"></img></td>
	</tr>
	</table>
</body>
</html>