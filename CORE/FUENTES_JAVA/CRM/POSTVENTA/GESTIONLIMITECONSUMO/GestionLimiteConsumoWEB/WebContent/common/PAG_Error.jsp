<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link href="../css/mas.css" rel="stylesheet" type="text/css" />
<title>Error</title>
<script language="javascript">

function cancelarOperacion() {
	location.href="../common/Empty.html";
}

function crearCarpeta() {
	window.open("PAG_CrearCarpeta.html","_self");
}

function asignarSegmentos() {
	window.open("PAG_AsignarSegmentosCarpeta.html","_self");
}
</script>
</head>

<body>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="textoTitulo"><img src="../img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/> Error </td>
  </tr>
</table>

<form method="post" name="frmCopiarCarpeta" id="frmCopiarCarpeta" >
        <table width="80%" border="0" cellpadding="0" cellspacing="0" align="center">
          <tr>
            <td colspan="4">&nbsp;</td>
          </tr>
		  <tr><td colspan="4">&nbsp;</td></tr>
          <tr>
		  	<td width="6%">&nbsp;</td>
		  	<td colspan="3">
			<div style="padding:8px;border:2px solid #8EC135;margin:0px">
            <table border="0" width="80%">
				<tr>
            		<td align="center">
            		<logic:present name="strCodigoError">
            		<b>C&oacute;digo Error:</b> <bean:write name="strCodigoError"/><br/>
            		</logic:present>
            		<logic:present name="strDescripcionError">
            		<b>Descripci&oacute;n:</b> <bean:write name="strDescripcionError"/><br/>            		
            		</logic:present>
            		<logic:present name="strNumeroEvento">
            		<logic:notEqual name="strNumeroEvento" value="0">
            		<b>N&uacute;mero Evento:</b> <bean:write name="strNumeroEvento"/>
            		</logic:notEqual>
            		</logic:present>
            		<logic:notPresent name="strDescripcionError">
            		Se ha producido un error, intentelo mas tarde.            		
            		</logic:notPresent>

            		</td>
				</tr>
			</table>
			</div>
			</td>
          </tr>
          
          
          <tr>
            <td>&nbsp;</td>
            <td colspan="3">&nbsp;</td>
          </tr>
      	</table> 
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
    <td colspan="5" align="center">
    <a href="#"><img style="cursor: pointer;" src="../botones/btn_salir.gif" alt="Salir" border="0" id="Salir2" onmouseover="sobreElBoton('Salir2','../botones/btn_salir_roll.gif')"  
    onmouseout="sobreElBoton('Salir2','../botones/btn_salir.gif')" width="85" height="19" onclick="salir();" /></a>
    </td>
  </tr> 
	<tr>
		<td>&nbsp;</td>
	</tr>
  </table>        
</form>        

</body>
</html>
