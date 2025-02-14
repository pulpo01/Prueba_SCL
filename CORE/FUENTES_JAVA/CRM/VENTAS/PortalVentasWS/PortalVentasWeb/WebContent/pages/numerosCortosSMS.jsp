<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JBuscaNumeroAJAX.js'></script>
<script>
	window.history.forward(1);
	var colorResaltado = "#CCCCCC";
	var colorNormal = "#F8F8F3";
	
	function fncInicio()
	{
		var largoNumero = document.getElementById("largoNumero").value;
		document.getElementById("numeroCortoValor").maxLength = largoNumero; //OK.
			
		if (document.getElementById("numeros") != null)
		{
			var totalFilas = document.getElementById("numeros").rows.length;
			var maximoNumeros = document.getElementById("maximoNumeros").value;
			if (parseInt(totalFilas)>parseInt(maximoNumeros))
			{
					document.getElementById("divBtnAgregar").style["display"] = "none";
			}
		}
	}
	
	function fncResultadoExisteNro(data){
		if (data!=null){
			var esValido = data["valido"];
			if (!esValido) {
				var codError = data["codError"];
				if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				alert("Numero SMS ya se encuentra asociado");
			} else {
			  	document.getElementById("opcion").value = "actualizarListaNumeros";		
				document.forms[0].submit();	  		  			
			}
		}
	}
	
	function fncActualizar() 
	{
	  	if (document.getElementById("numeroCortoValor").value == "")
	  	{
	  	  	alert("Debe ingresar Numero.");
			return false;
	  	}
	  	
	  	//Valida si ya existe el nro a nivel de pantalla	  	
	  	var cod = document.getElementById("numeroCortoValor").value;
		if (document.getElementById("numeros") != null)
		{		
		       var tabla = document.getElementById("numeros");
		       var bodyTabla = tabla.getElementsByTagName("tbody")[0];
    	  	   for (var i = 0; i < bodyTabla.rows.length; i++) 
    	  	   {
			        var fila = bodyTabla.rows[i];				
					var celda = fila.cells[1];
					var numSMS = celda.getElementsByTagName("FONT")[0];
					if(numSMS.innerHTML == cod)
					{
						alert("Numero ya se encuentra en la lista");	
						return false;			
					}
				}
		
		}// if
	  	
	  	//Valida si existe nro a nivel de BD
	  	JBuscaNumeroAJAX.existeNumeroSMS(document.getElementById("numeroCortoValor").value,fncResultadoExisteNro);
	}
	
	function fncAceptar()
	{
	  	document.getElementById("opcion").value = "aceptar";
    	document.forms[0].submit();
	}
	
	// Muestra mensajes de error
	function mostrarMensajeError(mensaje)
	{
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError()
	{
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	
	function fncCancelar()
 	{
	  	document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
 	}	
	
	function fncMostrarNumeros(numCortoPos, numeroCortoValor)
	{
		document.getElementById("divBtnAgregar").style["display"] = "none";
		document.getElementById("divBtnModificar").style["display"] = "";
		document.getElementById("numCortoPos").value = numCortoPos;
		document.getElementById("numeroCortoValor").value = numeroCortoValor;
		var tablaRef = document.getElementById("numeros").getElementsByTagName("TBODY")[0];
		var indiceFilaSel = parseInt(numCortoPos) - 1;
		for (var i = 0; tr = tablaRef.getElementsByTagName('tr')[i]; i++)
		{
			if (i == indiceFilaSel)
			{
				var td = tr.getElementsByTagName('td')[0];
				td.style.backgroundColor=colorResaltado;
			}
		}//fin for
	}
		
	
	function fncEliminarNumeros(numCortoPos)
	{
		var tablaRef = document.getElementById("numeros").getElementsByTagName("TBODY")[0];
		var indiceFilaSel = parseInt(numCortoPos) - 1;
		for (var i=0; tr=tablaRef.getElementsByTagName('tr')[i]; i++)
		{
			if (i==indiceFilaSel)
			{
				var td = tr.getElementsByTagName('td')[0];
				td.style.backgroundColor=colorResaltado;
			}
		}//fin for
		
		//si estaba modificando, cancela la acción
		if (document.getElementById("divBtnModificar").style["display"] == "")
		{
			document.getElementById("divBtnModificar").style["display"] = "none";
			var totalFilas = document.getElementById("numeros").rows.length;
			var maximoNumeros = document.getElementById("maximoNumeros").value;
			if (parseInt(totalFilas)>parseInt(maximoNumeros))
			{
				document.getElementById("divBtnAgregar").style["display"] = "none";
			}
			else
			{
				document.getElementById("divBtnAgregar").style["display"] = "";
			}
			
			var numAntSel = document.getElementById("numCortoPos").value;
			if (numCortoPos != numAntSel){//cambia color td anterior seleccionado
				var indiceFilaSelAnt = parseInt(numAntSel) - 1;
				for (var i = 0; trAnt=tablaRef.getElementsByTagName('tr')[i]; i++)
				{
					if (i == indiceFilaSelAnt)
					{
						var tdAnt = trAnt.getElementsByTagName('td')[0];
						tdAnt.style.backgroundColor=colorNormal;
					}
				}//fin for
			}
			
			document.getElementById("numCortoPos").value = "0";
			document.getElementById("numeroCortoValor").value = "";
		}
		
		if (confirm("¿Esta seguro que desea eliminar el numero SMS?"))
		{
			document.getElementById("numCortoPos").value = numCortoPos;
		  	document.getElementById("opcion").value = "eliminarNumero";
	    	document.forms[0].submit();
		}
		else
		{
			for (var i = 0; tr=tablaRef.getElementsByTagName('tr')[i]; i++)
			{
				if (i == indiceFilaSel)
				{
					var td = tr.getElementsByTagName('td')[0];
					td.style.backgroundColor=colorNormal;
				}
			}//fin for
		}
	}
	
	
</script>
</head>
<body onload="history.go(+1);fncInicio();" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/NumerosCortosSMSAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion"/>	
	<html:hidden property="numCortoPos" styleId="numCortoPos"/>
	<html:hidden property="largoNumero" styleId="largoNumero" />
	<html:hidden property="maximoNumeros" styleId="maximoNumeros" />
	
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Asociación de n&uacute;meros cortos a n&uacute;mero piloto
				</h2>
			</td>
		</tr>
	</table>
	<P></p>
	<table width="90%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes"></div>
			</td>
		</tr>
	</table>
	<table width="90%" align="center">
		<tr>
			<td width="100%">
			<table width="100%">
				<tr>
					<td align="left" colspan="2"
						style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
						N&uacute;meros cortos a asociar:
						</td>
				</tr>
				<tr>
					<td align="left" width="25%">N&uacute;mero corto (*)</td>
					<td align="left" width="75%" colspan="2"><html:text name="NumerosCortosSMSForm"
						property="numeroCortoValor" style="text-transform: uppercase;" styleId="numeroCortoValor"
						onkeypress="soloCaracteresValidos();" onblur="upperCase(this);" size="60" maxlength="50"
						onchange="ocultarMensajeError();" /></td>
				</tr>
				<tr>
					<td colspan="2" align="left"><i>(*): Datos obligatorios.
					</i></td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divBtnAgregar">
			<table width="100%">
				<tr>
					<td align="left"></td>
					<td align="right" width="25%"><html:button value="AGREGAR" style="width:120px;color:black" styleId="btnAgregar"
						property="btnAgregar" onclick="ocultarMensajeError();fncActualizar()" /></td>
				</tr>
			</TABLE>
			</div>
	</TABLE>
	<div id="divBtnModificar" style="display:none">
	<table width="100%">
		<tr>
			<td align="left"><html:button value="LIMPIAR" style="width:120px;color:black" styleId="btnAgregar"
				property="btnLimpiar" onclick="ocultarMensajeError();fncLimpiar()" /></td>
			<td align="right" width="25%"><html:button value="MODIFICAR" style="width:120px;color:black" styleId="btnModificar"
				property="btnModificar" onclick="ocultarMensajeError();fncActualizar()" /></td>
		</tr>
	</TABLE>
	</div>
	<table width="100%">
		<tr>
			<td colspan="2">
			<HR noshade>
			</td>
		</tr>
		</td>
		</tr>
		<logic:notEmpty name="NumerosCortosSMSForm" property="arrayNumeros">
			<tr>
				<td width="90%" align="center">
				<h2 align="left">N&uacute;meros cortos asociados:</h2>
				<display:table id="numeros" name="NumerosCortosSMSForm" property="arrayNumeros"
					scope="session" pagesize="10" requestURI="" width="100%">
					<display:column property="numCortoPos" title="N&uacute;mero" headerClass="textoColumnaTabla"
						width="10%" align="center" />
					<display:column title="Numero" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
						width="55%">
						<a href="javascript:fncMostrarNumeros('<bean:write name="numeros" property="numCortoPos"/>','<bean:write name="numeros" property="numeroCortoValor"/>');">
						<FONT color="#0000ff"> <bean:write name="numeros" property="numeroCortoValor" /></FONT></a>
					</display:column>
					<display:column title="" headerClass="textoColumnaTabla" class="textoFilasColorTabla"
						width="15%">
						<a
							href="javascript:fncEliminarNumeros('<bean:write name="numeros" property="numCortoPos"/>');"><FONT
							color="#0000ff">Eliminar</FONT></a>
					</display:column>
				</display:table></td>
			</tr>
			<tr>
				<td width="90%">
				<table width="100%">
					<tr>
						<td align="right" colspan="2"
							style="font-family: Verdana, Arial, Helvetica, sans-serif;font-size: 10px;font-weight: bold;">
						M&aacute;ximo&nbsp;<bean:write name="NumerosCortosSMSForm" property="maximoNumeros" />&nbsp;numeros
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</logic:notEmpty>
	</table>
	<P>
	<P></p>
	<TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
		<tr>
			<td align="left" width="50%"></td>
			<td width="25%" align="right"><html:button value="CANCELAR" style="width:120px;color:black" styleId="btnCancelar"
				property="btnCancelar" onclick="ocultarMensajeError();fncCancelar()" /></td>
			<td width="25%" align="right"><html:button value="ACEPTAR" style="width:120px;color:black" styleId="btnAceptar"
				property="btnAceptar" onclick="ocultarMensajeError();fncAceptar()" /></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
