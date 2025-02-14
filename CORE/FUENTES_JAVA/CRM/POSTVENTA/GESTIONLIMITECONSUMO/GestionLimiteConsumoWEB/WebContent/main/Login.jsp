<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<html>
<head>
<title>Carpetas Comerciales</title>

<link href="../styles/mas.css" rel="stylesheet" type="text/css">

<%
//obtener la variable error si es que existe
String strError = request.getParameter("ERROR");
%>
<SCRIPT LANGUAGE=javascript type="">
document.onkeydown = filterF5;
function ClearValues()
{
  if (document.all)
  {
    document.onkeydown = function ()
    {
      //alert(event.keyCode);
      var key_f5 = 116; // 116 = F5
      if (key_f5==event.keyCode)
      {
        event.keyCode=0;
        var ctrl = document.txt
        return false
      }
    }
  }
}
function filterF5() {
  var key_f5 = 116; // 116 = F5  86 = R
  if (key_f5==event.keyCode ||(event.ctrlKey && event.keyCode == 82)) {
    event.keyCode=0;
    event.returnValue = false;
    return false
  }
}

function eventSend(){
  if(document.LoginForm.j_username.value == ""){
    document.LoginForm.j_username.focus();
    alert('Ingrese Nombre de Usuario');
    return false;
  }
  if(document.LoginForm.j_password.value == ""){
    document.LoginForm.j_password.focus();
    alert('Ingrese password');
    return false;
  }
  return true;
}


	function desFrame()
	{
  		top.document.getElementById('principal').cols='10,*';
		//parent('menu').document.cols='10';
		//parent('centro').document.style.width='100%';
	}

function doSend(){
  if ( eventSend() ) {
    document.LoginForm.submit();
  }
}

function claveIncorrecta(){
	
	var strHTML = "";
	strHTML = strHTML + "<table>";
	strHTML = strHTML + "<tr>";
	strHTML = strHTML + "<td align='center' class='texto_rojo'>Clave incorrecta</td>";
	strHTML = strHTML + "</tr>";
	strHTML = strHTML + "</table>";
	
	document.getElementById("mensaje").innerHTML = strHTML;
}

function usuarioNoExiste(){
	
	var strHTML = "";
	strHTML = strHTML + "<table>";
	strHTML = strHTML + "<tr>";
	strHTML = strHTML + "<td align='center' class='texto_rojo'>Usuario no existe</td>";
	strHTML = strHTML + "</tr>";
	strHTML = strHTML + "</table>";
	
	document.getElementById("mensaje").innerHTML = strHTML;
}

function toUpper(object){

	object.value = object.value.toUpperCase();
}
function pressEnter(ky)
{
   if(ky ==13){     
	doSend();
   }
}
</SCRIPT>

</head>
<body onload = "ClearValues();" valign="top" >

<!-- cambiar el method por POST -->
<!--  <form action="LoginAction.html" method="get" target="main" name="loginForm">-->
<html:form action="/action/LoginAction" target="main">
<!--table border="0" align="center" width="100%" cellpadding="0" valign="top">
<TR>
<TD >
<div align="center"><img src="../images/fondo_cabecera.gif"/></div></TD>
</TR>
</table-->
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td class="barraarriba">CARPETAS COMERCIALES </td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td class="textoTitulo"><img src="../images/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>LOGIN </td>
  </tr>
</table>
<table width="350" height="170" valign="top" align="center" border="0" style="margin-left:170px;">
<tr>
<td valign="top" align="center">
<p>&nbsp;</p>
<fieldset>
<Table Border="0" Cellspacing="0" Cellpadding="0" Width="300" Align="center" valign="top">
	<Tr>
		<Td align="right" valign="top">
			<Table Border="0" Cellspacing="0" Cellpadding="0" Width="100%">
				<Tr>
					<Td valign="top">
						<Table width="100%" cellSpacing="2" cellPadding="0" border="0" >
							<Tr>
								<td Class="textoColumnaTabla">Usuario:</td>
							  <td class="textoFilasColorTabla"><div align="center"><input class="tablas_nivel3_2" name="j_username" MAXLENGTH="30" Style="Text-Transform: none" value="" onblur="toUpper(this)"></div></td>
							</Tr>
							<Tr>
								<td Class="textoColumnaTabla">Password:</FONT></td>
							  <td class="textoFilasColorTabla" ><div align="center"><input type="password" onkeypress="pressEnter(event.keyCode);" class="tablas_nivel3_2" name="j_password" MAXLENGTH="30" Style="Text-Transform: none" value=""></div></td>
							</Tr>
						</table>
					</Td>
				</Tr>
			</Table>
		</Td>
	</Tr>
<Tr>
<Td Height="15"></Td>
</Tr>
<Tr>
<Td>
<Table border="0" cellpadding="0" cellspacing="0" Width="100%">
<Tr>
<td>
  <div align="center">
	<table border="0" align="center" cellpadding="0" cellspacing="0">
		<tr align="center">
			<td><input name="entrar" type="button" class="boton" onClick="javascript:doSend();" value="ENTRAR"/></td>	
        </tr>
    </table>
  </div>
  </td>
</Tr>
</Table>
</Td>
</Tr>
<Tr>
<Td Height="15">&nbsp;

</Td>
</Tr>
<Tr>
<Td>
<center>
	<%if(request.getAttribute("ERROR") != null && "USUARIO_INVALIDO".equals(request.getAttribute("ERROR")) ){%>
	<div class="mensajeError" id="mensaje">No se puede accesar a la Aplicación con ese USUARIO/PASSWORD</div>
	<%}else if(request.getAttribute("ERROR") != null && "USUARIO_SIN_PERMISO".equals(request.getAttribute("ERROR")) ){%>
	<div class="mensajeError" id="mensaje">El usuario no tiene permiso para ejecutar en la aplicaci&oacute;n</div>
	<%}%>
</center>
</Td>
</Tr>
</Table>
</fieldset>
</td>
</tr>

</table>

</html:form>
<!--  </form>-->

</body>
</html>
