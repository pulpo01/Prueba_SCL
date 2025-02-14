<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Abono a la venta</title>

<link href="/CambioDeSimCardWEB/cambioSimCard/css/mas.css" rel="stylesheet" type="text/css" />

<script>
	var maximo = window.dialogArguments;
	maximo = (maximo * .5);

	function cerrar()	{
		if (validar(document.formulario.montoAbono.value))	{
			window.returnValue = document.formulario.montoAbono.value;
			window.close();
		}
	} // cerrar
	
	function cargaMaximo()	{
		document.getElementById("textoMaximo").innerHTML ="&nbsp;"+maximo;	
	} // cargaMaximo
	
	function validar(monto)	{
		
		if (monto == "")	{
			alert("Debe ingresar un valor para el monto del abono.");
			return false;
		}
		
		if (!isNumber(monto)) 	{        	
			alert("El monto del abono debe ser un valor numérico.");
			return false;
		}
		
		if (!((parseFloat(monto) >= 0) && (parseFloat(monto) <= maximo)))	{        	
			alert("El monto del abono ingresado está fuera del rango permitido.");
			return false;
		}
		
		return true;

	} // validar
	
	    
     function isNumber(x) {
         var anum = /(^\d+$)|(^\d+\.\d+$)/;
     
         var testresult;
         if (anum.test(x))
             testresult=true;
         else
             testresult=false;
         
         return (testresult);
         
     }	// isNumber        
</script>	
</head>

<body class="body" onload="cargaMaximo();">

	<form name="formulario">
		<br>
		<table width="300">
		<tr class="textoSubTitulo">
			<td class="textoSubTitulo">Valor Mínimo = </td>
			<td class="textoSubTitulo">0</td>
			<td class="textoSubTitulo" width=10 rowspan=4></td>
			<td class="textoSubTitulo">Valor Máximo = </td>
			<td><div id="textoMaximo" class="textoSubTitulo">&nbsp;</div></td>
		</tr>		
		<tr class="textoSubTitulo">
			<td>Valor abono </td>
			<td colspan=5> 
				<input type=text name="montoAbono" size=15 maxlength="10" value="">
			</td>
		</tr>
		<tr height="30">
			<td colspan=5 align="center"><input type=button value="  Aceptar  " onclick="cerrar()";></td>	
		</tr>	
		</table>
	</form>

</body>
</html:html>
<!-- ---------------------------------------------------------------------------------------------- -->

