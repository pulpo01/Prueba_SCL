<%@ page language="java" isErrorPage="true" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean"%>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html"%>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<html:base/>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>ERROR</title>
<link href="../css/mas.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
	font-size: 12px;
}
-->
</style>
<script type="text/javascript">
function mostrarOcultarDetalle()
{
	if(document.getElementById("linkMostrar").innerHTML=="ver detalle")
	{
		document.getElementById("linkMostrar").innerHTML="ocultar detalle";
		document.getElementById("filaDetalle").style["display"]="";
	}
	else
	{
		document.getElementById("linkMostrar").innerHTML="ver detalle";
		document.getElementById("filaDetalle").style["display"]="none";
	}
}

</script>

</head>

<body>
<table width="50%" border="0" align="center" class="textoColumnaTabla">
  <tr>
    <td><div align="left" class="style1">Error Inesperado </div></td>
  </tr>
  <tr>
    <td class="valorCampoInformativo">
	<p align="left" class="valorCampoInformativo">
		Ha ocurrido un error interno. Intente nuevamente.<br/> 
		De persistir el error contacte a su proveedor de software<br/><br/>
		<span id="linkMostrar" class="verde" onclick="mostrarOcultarDetalle();" style="cursor:pointer">ver detalle</span> 
	</p>
    </td>
  </tr>
  <tr id="filaDetalle" style="display: none">
    <td class="valorCampoInformativo">
	<div class="valorCampoInformativo" style="overflow: scroll; height:200px" >
      <p align="left">	   	
	   	<logic:present name="exception" scope="request">
	   		<bean:write name="exception" scope="request"/>
	   	</logic:present> 			
	  </p>
    </div>
  </td>
  </tr>
</table>
</body>
</html>