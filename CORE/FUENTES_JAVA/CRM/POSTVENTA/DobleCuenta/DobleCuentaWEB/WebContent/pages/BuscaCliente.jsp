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
<title>Busqueda de Clientes</title>
<script type='text/javascript' src='dwr/interface/JClienDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/FCheck.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/efectos.js" type="text/javascript"></script>
<script language="javascript">
function limpiaText(){
   document.getElementById("codigoCliente").value="";
}

function limpiaText1(){
    document.getElementById("nombreCliente").value="";
}

function limpiaText2(){
  document.getElementById("apellidoPaterno").value="";
 }

function limpiaText3(){
  document.getElementById("apellidoMaterno").value="";
}

function limpiaText4(){
 document.getElementById("numeroIdentificacion").value="";
}


function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
}



function buscarCliente()
  {
     //if(validaInpuNombre()  &&  validaInpuApePat() && validaInpuApeMat() && validaInpuNumIden()){  
        validaInpuText(); 
      //}  
 }
 
function conMayusculas(field) {
    
        field.value = field.value.toUpperCase() 
} 



function validaInpuText()
{
  var traenumeros = document.getElementById("codigoCliente").value;
  var ningunCodigo= true;
  var num=new Number(traenumeros);
     
       if((traenumeros == null)  || (traenumeros == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un número vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
        }else if(isNaN(num))
          {        
             document.getElementById("mensajes").innerHTML = "Debe Ingresar solo Números en  codigo cliente."; 
             ningunCodigo= false;      
          }else
          {
	        validaCodClienteAjax(traenumeros);        
	 
          }
          
          
      
   return ningunCodigo;   
 
} 
/*
function validaInpuNombre()
{
  var traeNombre = document.getElementById("nombreCliente").value; 
  var ningunCodigo= true;
   
        
      if((traeNombre == null)  || (traeNombre == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un nombre vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
          
        }else if(!isAlphabetic(stripCharsInBag(traeNombre, whitespace)))
          {
           
    	    document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfabéticos"; 
    	    ningunCodigo= false;
    	  }
        
     return ningunCodigo;       
}    		      
	
function validaInpuApePat()
{	
  var traeApellidoPat = document.getElementById("apellidoPaterno").value;
  var ningunCodigo= true;	
		
		if((traeApellidoPat == null)  || (traeApellidoPat == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un apellido paterno vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
        }else if (!isAlphabetic(stripCharsInBag(traeApellidoPat,whitespace)))
           {
    	      ningunCodigo= false;
    	      document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfabéticos"; 
    	    }
         
     return ningunCodigo;       
}
		
function validaInpuApeMat()
{
 var traeApellidoMat = document.getElementById("apellidoMaterno").value;
 var ningunCodigo= true;
		
	
	if((traeApellidoMat == null)  || (traeApellidoMat == ""))
     {   
          document.getElementById("mensajes").innerHTML = "Ingreso un apellido materno vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
     }else if (!isAlphabetic(stripCharsInBag(traeApellidoMat,whitespace))){
    	      ningunCodigo= false;
    	      document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfabéticos"; 
    	    }
         
     return ningunCodigo;       
}    
			       
function validaInpuNumIden()
{
  var traeIdent = document.getElementById("numeroIdentificacion").value;
  var ningunCodigo= true;
  
		if((traeIdent == null)  || (traeIdent == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un número de identidad vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
        }else if (!isAlphanumeric2(traeIdent)){
		 	   document.getElementById("mensajes").innerHTML = "Debe Ingresar caracteres alfanúmericos";  
			   ningunCodigo= false;
		 }			   
    
   return ningunCodigo;
}
*/

function enviarClient (form)
  {
    var radios = eval('document.FacturacionDifForm.itemChequeadosCli');
    var ningunockeckeado=true;
    
    try {
        if(radios.value != null)
    {
    	if (radios.checked){
    	   ningunockeckeado=false;
    	}else{
    	   ningunockeckeado=true;
    	}
    }else{
    	for (i=0;i < radios.length;i++)
	    {
	       if(radios[i].checked)
	         { 
	            ningunockeckeado=false;
	            break;
	         }else{
	            ningunockeckeado=true;
             }
        }   
    }      
       } catch (e) {
    }
    
    
    
    if (ningunockeckeado == true)
    {
    
      document.getElementById("mensajes").innerHTML = "Debe seleccionar un cliente asociado antes de enviar";
    }     
    else if(ningunockeckeado == false){
          
      document.forms[0].action="<%=request.getContextPath()%>/CargaClienteComboAction.do";
      document.forms[0].submit();
    }
 }  


//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DWR -- 
//---------------------------------------------------------------------------

function validaCodClienteAjax(traenumeros)
{
	JClienDWR.validaClienRepetido(traenumeros,validaCodClienteAjaxReturn);
}
//----------------------------------------------------------------------------
// RETURN --
//----------------------------------------------------------------------------

function validaCodClienteAjaxReturn(data)
{
   var codigo_cliente=data;
   
   if (codigo_cliente=="codigoClienteRepetido"){
   
      document.getElementById("mensajes").innerHTML = "El codigo del cliente ingresado esta repetido."; 
      
    }else{
    
        document.forms[0].action="<%=request.getContextPath()%>/BuscaClienteAction.do";
        document.forms[0].submit();
    
    
    }        
     
   
}
//------------------------------------------------------------------------------


  
</script>
</head>
<body class="body">
<html:form action="/BuscaClienteAction.do" >
<table width="100%" border="0">
<tr>
	<td class="barraarriba" width="92%">
		<logic:present name="usuario" scope="session">Usuario: <bean:write name="usuario" scope="session"/></logic:present>&nbsp;
		<logic:present name="operadora">Operadora: <bean:write name="operadora"/></logic:present>
	</td>
</tr>
<tr>
   <td class="mensajeError" align="center"><div id="mensajes"></div></td>
</tr>
<tr height="10">
	<td width="4%" colspan="3" align="center">
		 <logic:present name="error" scope="request">
		   <span style="color:red;font-weight: bold;font-size: 11px;font-family: Verdana, Arial, Helvetica, sans-serif;"><bean:write name="error"/></span>
		 </logic:present>
	 </td>
</tr>
<tr height="10">
	<td width="4%" align="center">
	 	<table width="100%" border="0">
	  		<tr>
				<td align="left" class="textoTitulo">
					<img src="images/green_arrow.gif" width="15" height="15" hspace="2" align="left"/>Facturaci&oacute;n Diferenciada
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
<table border ="0" width="100%">
	<tr>
		<td  colspan="6" class="textoSubTitulo">B&uacute;squeda de Clientes</td>
	</tr>
	<tr>
		<td width="10%"><b>C&oacute;digo</b></td>
		<td width="2%">:</td>		
		<td><input type="Text" name="codigoCliente"   id="codigoCliente" size="10"    maxlength="8"      onblur="limpiaMensajeError();"   onfocus="limpiaText();"></td>
		<td width="10%"><b>N&uacute;mero de Identificaci&oacute;n</b></td>
		<td width="2%">:</td>
		<td><input type="Text" name="numeroIdentificacion"   id="numeroIdentificacion" maxlength="20"    size="20" onblur="limpiaMensajeError();" onfocus="limpiaText4();"></td>		
	</tr>
	<tr>
		<td width="10%"><b>Nombre</b></td>
		<td width="2%">:</td>		
		<td colspan="4"><input type="Text" name="nombreCliente"  id="nombreCliente" size="50"  maxlength="50"   onchange="conMayusculas(this)" onblur="limpiaMensajeError();"  onfocus="limpiaText1();" ></td>		
	</tr>
	<tr>
		<td width="10%"><b>Apellido Paterno</b></td>
		<td width="2%">:</td>		
		<td><input type="Text" name="apellidoPaterno"  id="apellidoPaterno" size="20" maxlength="20"  onchange="conMayusculas(this)" onblur="limpiaMensajeError();"   onfocus="limpiaText2();"></td>		
		<td width="10%"><b>Apellido Materno</b></td>
		<td width="2%">:</td>		
		<td><input type="Text" name="apellidoMaterno"  id="apellidoMaterno" size="20"  maxlength="20"  onchange="conMayusculas(this)" onblur="limpiaMensajeError();" onfocus="limpiaText3();"></td>		
	</tr>
	<tr>
	    <input name="buscaClien" type="hidden" id="buscaClien"  value="" />	
		<td width="10%">&nbsp;</td>
		<td width="2%"></td>		
		<td colspan="5"><img src="botones/btn_buscar.gif" border="0" alt="buscar" id="buscar"  onclick="buscarCliente();" ></td>
	</tr>
</table>
<br>
<table border ="0" width="100%">
	<tr class="textoColumnaTabla">
		<td><input type="Checkbox" name="todos" onclick="MarcarCS(this.form,this)"></td>	
		<td>C&oacute;digo</td>
		<td>Nombre</td>
		<td>N&uacute;mero de Identificaci&oacute;n</td>
		<td>Apellido Paterno</td>
		<td>Apellido Materno</td>
	</tr>
<logic:present name="listaClienteAsociados" scope="session">
            <logic:iterate id="listClient" name="listaClienteAsociados"  type="com.tmmas.scl.doblecuenta.commonapp.dto.ClienteDTO" scope="session">	
	<tr bgcolor="#ffffff">
		<td align="center"><html:multibox name="FacturacionDifForm" property="itemChequeadosCli" ><bean:write name="listClient" property="codCliente"/>|<bean:write name="listClient" property="nomCliente"/>|<bean:write name="listClient" property="numIdent"/>|<bean:write name="listClient" property="nomApeClien1"/>|<bean:write name="listClient" property="nomApeClien2"/>|</html:multibox>
		</td>
		<td><font face="arial" size="2"><bean:write name="listClient" property="codCliente"/></font></td>
		<td><font face="arial" size="2"><bean:write name="listClient" property="nomCliente"/></font></td>
		<td><font face="arial" size="2"><bean:write name="listClient" property="numIdent"/></font></td>
		<td><font face="arial" size="2"><bean:write name="listClient" property="nomApeClien1"/></font></td>
		<td><font face="arial" size="2"><bean:write name="listClient" property="nomApeClien2"/></font></td>
	</tr>
   </logic:iterate>
</logic:present>
<logic:notPresent name="listaClienteAsociados" scope="session">
	<tr bgcolor="#ffffff">
		<td align="center" colspan="6">No existen clientes con el criterio de b&uacute;squeda ingresado</td>
	</tr>
</logic:notPresent>
</table>
<br>
<center>
<img src="botones/btn_guardar.gif" border="0" alt="enviar" id="enviar" onclick="enviarClient();" >
</center>
</html:form>
</body>
</html:html>