<%@ taglib uri="/WEB-INF/tld/struts-tiles.tld" prefix="tiles" %>
<%@ taglib uri="/WEB-INF/tld/struts-nested.tld" prefix="nested" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="org.apache.struts.util.*"%>
<!-- <html xmlns="http://www.w3.org/1999/xhtml">-->
<html:html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>TM-mAs - Portal Ventas</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="js/flashobject.js"></script>
<style type="text/css">
<!--
body {
	background-color: #f7f8f3;

}
.style1 {color: #003366}
-->
</style>
</head>



<body><table width="98%" align="center"  bgcolor="#FFFFFF">
  <tr><td width="100%" valign="top">
  <table width="100%"  border="0" cellspacing="0">
  			<%
			MessageResources messages =	MessageResources.getMessageResources("com.tmmas.cl.scl.activacionmasiva.web.properties.web");
			String version = (String)(messages.getMessage("version"));
			String mensaje = (String) request.getAttribute("mensajeError");
			System.out.println(mensaje);
			%>
  <tr>
    <td colspan="2"  valign="bottom">
	<span class="style1"><!-- permite cargar un swf externo atraves de un js -->
	 
	</span>
	<div class="style1" id="flashcontent">	</div>
	<span class="style1">
	<script type="text/javascript">
	
	   var fo = new FlashObject("img/bars.swf", "menu", "950", "125", "7", "#ffffff");
	   fo.addParam("scale", "exactfit");
	   fo.addParam("menu", "false");
	   fo.write("flashcontent");
	   document.onkeydown = function(){
         if(window.event && window.event.keyCode == 8)
	     {
	       window.event.keyCode = 505;
         }
       }
	   
	</script>
	
	<img src="img/px_cafe.jpg" width="1" alt=" " height="2" /></span></td>
  </tr>
  <tr>
    <td height="14" bgcolor="#78B454" class="texto_intro_blanco"><img src="img/px_trans.jpg" alt="  " width="1" height="1" /></td>
    <td height="14" bgcolor="#78B454" class="textobarraverde"><strong>Usuario:</strong>XXX <strong> Operadora:</strong> TELEFONICA MOVILES CHILE <strong>Versi&oacute;n:</strong><%=version%></td>
  </tr>
  <tr>
    <td width="150" valign="top" bgcolor="#EBE9DC"><img src="img/px_trans.jpg" alt="  " width="1" height="4" /><br />
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
         <tr>
            <td  bgcolor="EBE9DC">
		         <ul>
		            <li>Inicio</li>
		            <li>Alta de Cliente</li>
		            <li>Alta de Linea</li>
		            <li>Consulta Ventas</li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li></li>
		            <li><a class="linkmenu" href="login.jsp">Regresar a Login</a></li>
		         </ul>
            </td>
         </tr>
    </table>
	<center>
 	<td>
		<center>
		  <h1>
		   La aplicación no puede ser ejecutada <br>
		   <logic:present name="mensajeError">
               <bean:write name="mensajeError"/>
           </logic:present>
          </h1> 
        </center>
	</td> 
	</center>
  
  </tr>
  </table>
  </td>
  </tr>
  <tr>
    <td  class="footer"> Optimizado para resoluci&oacute;n de 1024x768 / IE 5.0 + / Copyright &copy; 2006: TM-mAs. </td>
  </tr>
</table>
</body>
</html:html>