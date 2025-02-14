<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/c.tld" prefix="c" %>
<%@ page isErrorPage="true" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Error de Sistema :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<link href="anulacionSiniestro/css/mas.css" rel="stylesheet" type="text/css" />
</head>
<script language="javascript">
  function fncCerrar(){
     window.close();
  }
</script>
<!-- 91925 RRG 23-10-2008 , se agregar boton cerrar y funcion javascript-->
<body class="body">
	
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
		<%	
	    if (request.getAttribute("tituloError") != null)
			out.println(request.getAttribute("tituloError"));	
	    else
	    	out.println("Se ha producido un error desconocido.");	
		%>
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
</html:html>
