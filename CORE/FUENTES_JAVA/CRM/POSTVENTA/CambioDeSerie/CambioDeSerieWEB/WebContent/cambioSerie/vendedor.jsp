<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<base target="_self">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: <c:out value="${nombreOOSS}"/> :.</title>

<link href="cambioSerie/css/mas.css" rel="stylesheet" type="text/css" />

<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="javascript">


	var strFormaSalir = ""; // RRG

	function buscarVendedor() {
		var forma = document.forms[0];
		
      	var resp = isNotEmpty(forma.codVendedor)
      	if (resp == false) {
      		alert('El campo codigo de vendedor no puede ser vacío')
      		return false;
      	}
      	
     	resp = IsNumeric(forma.codVendedor.value)
     	
      	if (resp == false) {
      		alert('El campo codigo de vendedor no es un numero')
      		return false;
      	} 		
		forma.submit();
		return true;
	}

	function fncValidaSalir() {
		if (strFormaSalir !="SALIR"	) {
			returnValue="NO";
		} else	{
			seteaRetorno();
		}
	}
	
	function salir() {

		var flag = new String(document.forms[0].flag.value);
		returnValue = flag.substr(0,2);

		strFormaSalir="SALIR";

		if ( flag.substr(0,2)=="NO") {
			   var x = confirm("No se ha seleccionado un vendedor. No podrá continuar ejecutando la OOSS.\nDesea finalizar?");
			   if (x)	{
				close();
				return true;
				}
		}
		else	{
			close();
			return true;
		}
	} // salir
	
	function seteaRetorno(){
		var flag = new String(document.forms[0].flag.value);
		returnValue = flag.substr(0,2);	
		return;
	}
	
//Elimina caracteres  al comienzo y al final
function trim(inputString) {
   var retValue = inputString;
   var ch = retValue.substring(0, 1);
   while (ch == " ") { // chequea por espacios al comienzo del string
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length-1, retValue.length);
   while (ch == " ") { // chequea por espacios al final del string
      retValue = retValue.substring(0, retValue.length-1);
      ch = retValue.substring(retValue.length-1, retValue.length);
   }
   while (retValue.indexOf("  ") != -1) { // Hay 2 espacios en el string - mira para multipes espacios dentro del string
      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // De nuevo, hay 2 espacios en el string
   }
   return retValue; 
}



// Valida que el campo tiene uno o mas caracteres
function isNotEmpty(elem) {
    var str = elem.value;
    str = trim(str)
    if(str == null || str.length == 0) {
        return false;
    } else {
        return true;
    }
}
   
// valida que la entrada es un numero positivo o negativo
function isNumber(elem) {
    var str = elem.value;
    var oneDecimal = false;
    var oneChar = 0;
    // Se asegura que el valor no se ha casteado a tipo de dato numero
    str = str.toString( );
    for (var i = 0; i < str.length; i++) {
        oneChar = str.charAt(i).charCodeAt(0);
        // OK para signo menos, solo la primera vez
        if (oneChar == 45) {
            if (i == 0) {
                continue;
            } else {
                //S?lo el primer car?cter puede ser signo menos.
                return 1;
            }
        }
        // OK para un punto decimal
        if (oneChar == 46) {
            if (!oneDecimal) {
                oneDecimal = true;
                continue;
            } else {
                //S?lo un decimal es permitido en un n?mero
                return 2;
            }
        }
        // Caracteres de 0 a 9 OK
        if (oneChar < 48 || oneChar > 57) {
            //Introduzca solo n?meros en el campo
            return 3;
        }
    }
    return 0;
}


  function IsNumeric(sText)      {
     var ValidChars = "0123456789";
     var IsNumber=true;
     var Char; 
     for (i = 0; i < sText.length && IsNumber == true; i++){ 
        Char = sText.charAt(i); 
        if (ValidChars.indexOf(Char) == -1){
           IsNumber = false;
        }
     }         
     if(sText==""){
        IsNumber = false;
     }                  
     return IsNumber;
  } 	
</script>
</head>

<body  class="body" onload="seteaRetorno()" onunload='fncValidaSalir()'>
<c:set var="vendedor" value="${sessionScope.Vendedor}"></c:set>
<html:form action="/VendedorAction.do">

<!--  este flag documenta si ha encontrado los datos del vendedor -->
<input type=hidden name="flag" value="<% if (request.getAttribute("flagVendedor") == null) out.println("NO"); else out.println(request.getAttribute("flagVendedor"));%>">
<table width="100%">


  <tr>
    <td colspan="2">
<!-- Title Inicio -->
<!--  
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<c:set var="titulo" value="${sessionScope.nombreOOSS}"></c:set>
-->

<table width="100%">
 <tr>
	<!-- Operadora -->
    <td class="barraarriba">Usuario: <c:out value="${clienteOS.usuario}"/>  &nbsp;Operadora: <c:out value="${sessionScope.operadora}"/>
  </td>
 </tr>
 
 <tr>
    <td width="4%" colspan="3">
      <table width="100%" border="0">
		  <tr>
		   <td align="left" class="textoTitulo"><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>
		   <!--<c:out value="${titulo}"/></td>-->
		    Cambio Serie</td>
		  </tr>
		  <tr>
		    <td class="textcaminohormigas">Ingreso de información</td>
		  </tr>
	  </table>
    </td>
  </tr>  
  
   <tr>
    <td colspan="3">
	 <table width="100%" border="0">
     <tr>
       <td class="mensajeError" width="70%" align="center" ><html:errors />
			<html:messages message="true" id="msg">
    				<c:out value="${msg}"/><br />
			</html:messages></td>
       </tr>
     </table>
    </td>
  </tr>
  
</table>
<!-- Title Fin -->    
    </td></tr>




    <td colspan="2">
<!-- Body Inicio -->    
<table width="100%" border="0">
  <tr>
    <td colspan="4" class="textoSubTitulo">Informaci&oacute;n de Vendedor</td>
  </tr>
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="20%" class="campoInformativo">C&oacute;digo de Vendedor</td>
    <td width="30%">
    	<html:text property="codVendedor" tabindex="1" maxlength="6"/>
    	&nbsp;&nbsp;
    	<html:radio property="ind_interno" value="1"  /> Directo <!-- Se cambia 0 por 1, ya que estaban invertidos RRG 71913 COL -->
		&nbsp;&nbsp;
    	<html:radio property="ind_interno" value="0"  /> Indirecto		
		&nbsp;&nbsp;		
		<a href="#"><img style="cursor: pointer;" src="botones/btn_buscar.gif" name="buscar" border="0" id="buscar"  alt="buscar" 
		onclick="return buscarVendedor();" /></a>
		
    </td>
    <td width="40%" align="left">
    	&nbsp;
    </td>
  </tr>
<c:if test="${not empty vendedor.nom_oficina}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Oficina</td>
    <td width="70%"><c:out value="${vendedor.nom_oficina}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>  
<c:if test="${(empty vendedor) or (empty vendedor.nom_oficina)}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Oficina</td>
    <td width="70%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if> 


<c:if test="${not empty vendedor.nom_tipcomis}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Tipo Comisionista</td>
    <td width="70%"><c:out value="${vendedor.nom_tipcomis}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>  
<c:if test="${(empty vendedor) or (empty vendedor.nom_tipcomis)}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Tipo Comisionista</td>
    <td width="70%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if> 


<c:if test="${not empty vendedor.nom_vendealer}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Dealer</td>
    <td width="70%"><c:out value="${vendedor.nom_vendealer}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if> 
<c:if test="${(empty vendedor) or (empty vendedor.nom_vendealer)}">  
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Dealer</td>
    <td width="70%">&nbsp;</td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if> 


 <c:if test="${not empty vendedor.nom_vendedor}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Vendedor </td>
    <td width="70%"><c:out value="${vendedor.nom_vendedor}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>
 <c:if test="${(empty vendedor) or (empty vendedor.nom_vendedor)}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Vendedor </td>
    <td width="70%"><c:out value="${vendedor.nom_vendedor}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>

 <c:if test="${not empty vendedor.des_region}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Regional </td>
    <td width="70%"><c:out value="${vendedor.des_region}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>
 <c:if test="${(empty vendedor) or (empty vendedor.des_region)}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Regional </td>
    <td width="70%"><c:out value="${vendedor.des_region}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>

 <c:if test="${not empty vendedor.des_ciudad}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Depto </td>
    <td width="70%"><c:out value="${vendedor.des_ciudad}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>
 <c:if test="${(empty vendedor) or (empty vendedor.des_ciudad)}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Depto </td>
    <td width="70%"><c:out value="${vendedor.des_ciudad}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>

 <c:if test="${not empty vendedor.des_provincia}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo"> Distrito </td>
    <td width="70%"><c:out value="${vendedor.des_provincia}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>
 <c:if test="${(empty vendedor) or (empty vendedor.des_provincia)}">   
  <tr>
    <td width="10%">&nbsp;</td>
    <td width="17%" class="campoInformativo">Distrito</td>
    <td width="70%"><c:out value="${vendedor.des_ciudad}"/></td>
    <td width="3%">&nbsp;</td>
  </tr>
</c:if>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>
		<a href="#"><img style="cursor: pointer;" src="botones/btn_aceptar.gif" name="buscar" border="0" id="buscar"  alt="buscar" 
		onclick="return salir();" /></a>    
    </td>
    <td>&nbsp;</td>
  </tr>
 
  </table>

<!-- Body Fin -->    
    </td></tr>
    
    
    
    
  <tr>
    <td colspan="2">
<!-- Footer Inicio -->    
<table width="100%" border="0">
  <tr>
    <td width="25%">&nbsp;</td>
    <td width="25%">&nbsp;</td>
    <td width="50%" align="right">&nbsp;</td>
  </tr>
</table>
<!-- Footer Fin -->    
    </td></tr>  
</table>


</html:form>
</body>
</html:html>