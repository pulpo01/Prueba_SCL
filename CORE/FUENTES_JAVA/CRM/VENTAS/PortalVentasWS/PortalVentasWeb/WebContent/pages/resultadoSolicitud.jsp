<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script>
window.history.forward(1); 	

function fncInicio(){
		var win = parent
		win.fncActDesacMenu(false);
		win.fncCargaVendedorSolVenta("");
}

function fncVolver(){
	if (confirm("¿Desea volver al men\u00FA?")){
	  	document.getElementById("opcion").value = "irAMenuFinal";
	   	document.forms[0].submit();
	}
}	

	/*if (confirm("¿Desea volver al men\u00FA?")){
		var win = parent
		win.fncActDesacMenu(false);
	
	  	document.getElementById("opcion").value = "irAMenu";
	   	document.forms[0].submit();
	}*/

//Inicio P-CSR-11002 JLGN 10-10-2011
function fncFormalizar(){
	if (confirm("¿Desea Formalizar Venta?")){
	  	document.getElementById("opcion").value = "formalizaSolicitud";
	   	document.forms[0].submit();
	}
}	
//Fin P-CSR-11002 JLGN 10-10-2011	
	
</script>
</head>

<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/DatosLineaAction.do">
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<bean:define id="menuInicio" name="menuInicioDTO" scope="session" type="com.tmmas.cl.scl.portalventas.web.dto.MenuInicioDTO" />
<table  width="80%">
<tr><td width="100%">
      <table width="100%" >
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Creaci&oacute;n de Venta&nbsp;
         </td>            
        </tr>
      </table>
</td></tr>
<tr><td>&nbsp;</td></tr>

<logic:present name="mensajeError">
<tr><td>&nbsp;
	  <table>
	    <tr>
	        <td class="mensajeError">&nbsp;<bean:write name="mensajeError"/></td>
	    </tr>
	  </table>
</td></tr>	  
</logic:present>

<tr><td>&nbsp;</td></tr>

<logic:notPresent name="mensajeError">
<bean:define id="resultado" name="resultadoSolVenta" scope="session" type="com.tmmas.cl.scl.portalventas.web.dto.ResultadoSolicitudVentaDTO"/>
<tr><td>	 
	  <table align="center" width="80%">
	    <tr>
          <td align="left" class="amarillo" colspan="2">
          <h2>Se ha realizado con &eacute;xito la creaci&oacute;n de la venta.</h2>
          </td>
	    </tr>
	    <tr>
	    <td align="left" width="30%"><h2>N&uacute;mero de Solicitud:</h2></td>
	    <td align="left" width="70%"><h2>
	    <bean:write name="resultado" property="numeroVenta" />
	    </h2>
		</td>
	    </tr>
	    <tr>
	    <td align="left" width="30%"><h2>N&uacute;mero de Cliente:</h2></td>
	    <td align="left" width="70%"><h2>
   	    <bean:write name="resultado" property="codCliente" />
	    </h2>
		</td>
	    </tr>	    
	  </table>
</td></tr>
</logic:notPresent> 
     
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
</table>
<table>
<tr><td align="center" style="width:40%">
       <input type="button" id ="btnVolver" name="btnVolver" value="VOLVER AL MENU" onclick="fncVolver();" style="width:180px;color:black">
</td>
	<logic:iterate id="menuUsuario" name="menuInicio" property="listaAreaVentas" type="java.lang.String">
		<logic:equal name="menuUsuario" value="FORMVTA">
			<td align="center" style="width:40%">       
       			<input type="button" id= "btnFormalizar" name="btnFormalizar" value="FORMALIZAR SOLICITUD" onclick="fncFormalizar();" style="width:190px;color:black"> 
			</td>
		</logic:equal>
	</logic:iterate>
</tr>
</table>
     
</html:form>

</body>
</html:html>