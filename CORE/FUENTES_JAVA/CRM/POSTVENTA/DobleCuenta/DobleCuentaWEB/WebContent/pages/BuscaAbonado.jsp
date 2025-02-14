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
<title>Busqueda Abonado</title>
<script type='text/javascript' src='dwr/interface/JClienDWR.js'></script>
<script type='text/javascript' src='dwr/engine.js'></script>    
<script type='text/javascript' src='dwr/util.js'></script>

<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/numerosFrec.js" type="text/javascript"></script>
<script language="JavaScript" src="<%=request.getContextPath()%>/pages/js/efectos.js" type="text/javascript"></script>
<script language="javascript">
function limpiaText(){

document.getElementById("numeroCelular").value="";
}

function limpiaMensajeError(){
  document.getElementById("mensajes").innerHTML = "";
}

function validaInpuText()
  {
   
   var traenumeros = document.getElementById("numeroCelular").value;
   var ningunCodigo= true;
   var num=new Number(traenumeros);
     
   
   
       if((traenumeros == null)  || (traenumeros == ""))
        {   
          document.getElementById("mensajes").innerHTML = "Ingreso un número vacio. Debe Ingresar nuevamente"; 
          ningunCodigo= false;
        }
       else if(isNaN(num))
        {        
          document.getElementById("mensajes").innerHTML = "Debe Ingresar solo Números en  N° Celular."; 
          ningunCodigo= false;      
        }else  
          {
	        validaNumAbonadoAjax(traenumeros);        
	 
          }
 
   return ningunCodigo;
     
     
}  

function enviarAbon()
  {
    var radios = eval('document.FacturacionDifForm.itemChequeados');
    var ningunockeckeado=true;
    var abonados = '';
    for(i=0;i<listIdAbonado.length;i++)
    {
    	abonados+="|"+listIdAbonado[i];
    }
    document.getElementById("idsAbonado").value = abonados;
    
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
    
      document.getElementById("mensajes").innerHTML = "Debe seleccionar un abonado antes de enviar";
    }     
    else if(ningunockeckeado == false){
          
      document.forms[0].action="<%=request.getContextPath()%>/CargaComboAction.do";
      document.forms[0].submit();
    }
 }  



//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
// DWR -- 
//---------------------------------------------------------------------------

function validaNumAbonadoAjax(traenumeros)
{
	JClienDWR.validaAbonRepetido(traenumeros,validaNumAbonadoAjaxReturn);
}
//----------------------------------------------------------------------------
// RETURN --
//----------------------------------------------------------------------------

function validaNumAbonadoAjaxReturn(data)
{
   var num_celular=data;
   
   if (num_celular=="numeroCelularRepetido"){
   
      document.getElementById("mensajes").innerHTML = "El numero de celular ingresado esta repetido."; 
      
    }else{
        document.getElementById("buscar").value="buscar";
        document.forms[0].action="<%=request.getContextPath()%>/BuscaAbonadoAction.do";
        document.forms[0].submit();
    
    }          
}

var listIdAbonado = Array();

function agregaAbonado(checkAbo)
{
	try
	{
		if(checkAbo.checked)
		{
			listIdAbonado[listIdAbonado.length] = checkAbo.value;
		}
		else
		{
			quitarIdAbonado(checkAbo.value);
		}
		
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En agregaAbonado()");
	}
}

function quitarIdAbonado(idAbo)
{
	try
	{
		var listIdAbonadoTmp = new Array;
		for(k=0;k<listIdAbonado.length-1;k++)
		{
			if(listIdAbonado[k] == idAbo)
			{
				for(l=k;l<listIdAbonado.length-1;l++)
				{
					listIdAbonadoTmp[l] = listIdAbonado[l+1];
				}
				break;
			}
			else
			{
				listIdAbonadoTmp[k] = listIdAbonado[k];
			}
		}
		listIdAbonado = listIdAbonadoTmp;
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En quitarIdAbonado()");
	}
}
//------------------------------------------------------------------------------

</script>

</head>
<body class="body">
<html:form action="/BuscaAbonadoAction.do">
<input name="idsAbonado" type="hidden" id="idsAbonado"  value="" />
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
		<td  colspan="3" class="textoSubTitulo">B&uacute;squeda de Abonado</td>
	</tr>
	<tr>
		<td width="10%"><b>N&uacute;mero de Celular</b></td>
		<td width="2%">:</td>		
		<td> <input name="numeroCelular" type="text" size="15" id="numeroCelular" maxlength="15" onblur="limpiaMensajeError();" onfocus="limpiaText();"/>
		</td>
	</tr>
	<tr>
		<td width="10%">&nbsp;</td>
		<td width="2%"></td>
	   <td><img src="<%=request.getContextPath()%>/botones/btn_buscar.gif" border="0" alt="Buscar" id="Buscar" onclick="validaInpuText();"></td>
	   <input name="buscar" type="hidden" id="buscar"  value="" />
	</tr>
</table>
<br>
<table border ="0" width="100%">
	<tr class="textoColumnaTabla">
		<td width="2%"><input  alt="Seleccionar Todos" name="checkbox523" type="checkbox" value="checkbox" onclick="MarcarCS(this.form,this)" /></td>	
		<td>Número de celular</td>
		<td>Usuario</td>		
	</tr>
	<logic:present name="listaAbonados" scope="session"> 
    <logic:iterate id="listAbon" name="listaAbonados"  type="com.tmmas.scl.doblecuenta.commonapp.dto.AbonadoDTO" scope="session">
	<tr bgcolor="#ffffff">
		<td width="2%" ><html:multibox name="FacturacionDifForm" property="itemChequeados" ><bean:write name="listAbon" property="numAbonado"/>|<bean:write name="listAbon" property="numCelular"/>|<bean:write name="listAbon" property="nomUsuario"/>|<bean:write name="listAbon" property="nomApellido1"/>|<bean:write name="listAbon" property="nomApellido2"/>|</html:multibox>
		<td width="20%"><font face="arial" size="2"><bean:write name="listAbon" property="numCelular"/></font></td>
		<td><font face="arial" size="1"><bean:write name="listAbon" property="nomUsuario"/> 
		<bean:write name="listAbon" property="nomApellido1"/> <bean:write name="listAbon" property="nomApellido2"/>
		<input name="enviaNumeroAbonado" type="hidden" id="enviaNumeroAbonado"  value="<bean:write name="listAbon" property="numAbonado"/>" />
	   	</font></td>		
	</tr>
    </logic:iterate>
    </logic:present>
    <logic:notPresent name="listaAbonados" scope="session">
    <tr bgcolor="#ffffff">
		<td colspan="3" align="center">No existen abonados</td>
	</tr>	
    </logic:notPresent>
</table>

<br>
<center>
<img src="<%=request.getContextPath()%>/botones/btn_guardar.gif" border="0" alt="enviar" id="enviar" onclick="enviarAbon();">
</center>
</html:form>
</body>
</html:html>