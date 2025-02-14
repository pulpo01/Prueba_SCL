<%@ taglib uri="http://jakarta.apache.org/struts/tags-bean" prefix="bean" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-html" prefix="html" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-logic" prefix="logic" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-tiles" prefix="tiles" %>
<%@ taglib uri="http://jakarta.apache.org/struts/tags-nested" prefix="nested" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ingreso codigo</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/FCheck.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/efectos.js" type="text/javascript"></script>
<script language="javascript">

function limpiaText(){
   document.getElementById("codigo").value="";
}

function limpiaText1(){
    document.getElementById("codOOSS").value="";
}

function limpiaText2(){
  document.getElementById("nombreUsuario").value="";
 }

function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
}


function validaCodigo()
  {
   var traenumeros = document.getElementById("codigo").value;
   var ningunCodigo= true;
   var num=new Number(traenumeros);
     
       if((traenumeros == null)  || (traenumeros == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un codigo cliente contratante vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
        }
       else if(isNaN(num))
        {        
          document.getElementById("mensajes").innerHTML = "Debe Ingresar solo Números en el codigo."; 
          ningunCodigo= false;      
        }

         return ningunCodigo; 
 } 

function validaUsuario()
{
  var traeUsuario = document.getElementById("nombreUsuario").value; 
  var ningunCodigo= true;
   
        
      if((traeUsuario == null)  || (traeUsuario == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un usuario vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
          
        }
        
     return ningunCodigo;       
}  

function enviarDatosCliente(){

    if(validaCodigo() && validaUsuario())
    {  
       document.getElementById("ingresoCod").value="Cod";
       document.forms[0].action="<%=request.getContextPath()%>/BuscaCliContraAction.do";
       document.forms[0].submit();
    }

}


</script>

</head>
<body>
<html:form action="/CargaAction.do" >
<table border="0">
      <tr>
     <td class="mensajeError" align="center"><div id="mensajes"></div></td>
      </tr>
</table>
<table border ="0" width="100%">
	<tr>
		<td><font face="arial" size="2">Codigo Cliente</font></td>
		<td>:</td>
		<td><input type="Text" name="codigo"   id="codigo" size="50"    maxlength="50"  onblur="limpiaMensajeError();"   onfocus="limpiaText();"   ></td>
		<input name="ingresoCod" type="hidden" id="ingresoCod"  value="" />
	</tr>
	<tr>
		<td><font face="arial" size="2">Numero de OOSS</font></td>
		<td>:</td>
		<td><input type="Text" name="codOOSS"   id="codOOSS" size="50" maxlength="50"   onblur="limpiaMensajeError();"   onfocus="limpiaText1();" ></td>
		<input name="codOOSS" type="hidden" id="ingresoCodOS"  value="" />
	</tr>
	<tr>
		<td><font face="arial" size="2">Nombre Usuario</font></td>
		<td>:</td>
		<td><input type="Text" name="nombreUsuario"   id="nombreUsuario" size="50" maxlength="50"  onblur="limpiaMensajeError();"   onfocus="limpiaText2();" ></td>
		<input name="nombreUsuario" type="hidden" id="ingresoUser"  value="" />
	</tr>
</table>
<br>
<center>
<img src="<%=request.getContextPath()%>/images/bot_buscar.gif" border="0" alt="buscar" id="buscar" onclick="enviarDatosCliente();">
</center>
</html:form> 
</body>
</html:html>