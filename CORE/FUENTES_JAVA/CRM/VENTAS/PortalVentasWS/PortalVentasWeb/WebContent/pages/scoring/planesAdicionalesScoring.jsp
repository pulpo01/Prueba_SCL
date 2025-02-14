<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c"%>
<c:set var="paramGlobal" value="${sessionScope.paramGlobal}" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link rel="stylesheet" type="text/css" href="/css/mas.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/mas.css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type="text/javascript">
	
	var prefijoCheckBox = "checkBoxContratar";
	
	var prefijoTextBoxCantidad = "textBoxCantidad";
	
	var prefijoLabelMaximo1 = "labelMaximo1";
	
	var prefijoLabelMaximo2 = "labelMaximo2";
	
	function cantidad_onblur(o, cant) {
		var v = parseInt(o.value);
		if (v == 0) {
			alert ("El mínimo de contrataciones de este producto es: 1");
			o.value = 1; 
		}
		else if (v > cant) {
			alert ("El máximo de contrataciones de este producto es: " +  cant);
			o.value = cant; 
		}
	}
	
	function activarDesactivarProducto(o) {
		var codProductoOfertado = o.id.replace(prefijoCheckBox, "");
		var textBoxCantidad = document.getElementById(prefijoTextBoxCantidad + codProductoOfertado);
		var labelMaximo1 = document.getElementById(prefijoLabelMaximo1 + codProductoOfertado);
		var labelMaximo2 = document.getElementById(prefijoLabelMaximo2 + codProductoOfertado);
		var max = parseInt(labelMaximo2.innerText);
		if (o.checked) {
			textBoxCantidad.value = "1";
			if (max == 1) {
				textBoxCantidad.readOnly = true;
			}
			else {
				textBoxCantidad.maxLength = (max + "").length;
			}
			textBoxCantidad.style["display"] = "";
			labelMaximo1.style["display"] = "";
			labelMaximo2.style["display"] = "";
		}
		else {
			textBoxCantidad.value = "";
			textBoxCantidad.style["display"] = "none";
			labelMaximo1.style["display"] = "none";
			labelMaximo2.style["display"] = "none";
		}
	}
		
	function contratar_onclick(o) {
		activarDesactivarProducto(o);
	}
	
	function buttonAceptar_onclick() {
		var checkBoxes = document.getElementsByName("contratar");
		var vv = "";
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				var codProductoOfertado = checkBoxes[i].id.replace(prefijoCheckBox, "");
				vv += codProductoOfertado;
				var textBoxCantidad = document.getElementById(prefijoTextBoxCantidad + codProductoOfertado);
				vv += "=";
				vv += textBoxCantidad.value;
				vv += ",";
			}
		}
		if (vv.length > 0) {
			vv = vv.substring(0, vv.length - 1);
			document.getElementById("productosSeleccionadosEnCSV").value = vv;
			document.getElementById("opcion").value = "aceptarPAScoring";
		    document.forms[0].submit();
		}//P-CSR-11002 JLGN 10-08-2011
		else{
			alert("No hay planes adicionales seleccionados.");
			fncCursorNormal();
		}
		/*P-CSR-11002 JLGN 10-08-2011
		else if (confirm("No hay planes adicionales seleccionados. ¿Desea continuar?")) {
			document.getElementById("opcion").value = "cancelarPAScoring";
		    document.forms[0].submit();
		}*/
	}
	
	function buttonVolver_onclick() {
		document.getElementById("opcion").value = "irATiposComportamiento";
	    document.forms[0].submit();
	}
	
	function body_onload() {
		var csv = document.getElementById("productosSeleccionadosEnCSV");
		var productos = csv.value.split(",");
		var contratar = document.getElementsByName("contratar");
		if (productos.length == 0) {
			return;
		}
		else {
			for (var i = 0; i < contratar.length; i++) {
				var checkBox = contratar[i];
				for (var j = 0; j < productos.length; j++) {
					var splitted = productos[j].split("=");
					var codProductoOfertado = splitted[0];
					if (checkBox.id.replace(prefijoCheckBox, "") == codProductoOfertado) {
						checkBox.click();
						var textBoxCantidad = document.getElementById(prefijoTextBoxCantidad + codProductoOfertado);
						textBoxCantidad.value = parseInt(splitted[1]);
					}
				}
			}
		}
	}
	
	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }
	
</script>
</head>
<body onload="body_onload()">
<html:form method="post" action="/PlanesAdicionalesScoringAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden name="PlanesAdicionalesScoringForm" property="productosSeleccionadosEnCSV" styleId="productosSeleccionadosEnCSV" />
	<table>
		<tr>
			<td class="amarillo">
			<!-- Inicio P-CSR-11002 19-04-2011 -->
			<logic:equal name="PlanesAdicionalesScoringForm" property="numSolScoring" value="0">
				<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Planes Adicionales
			</logic:equal>
			<logic:notEqual name="PlanesAdicionalesScoringForm" property="numSolScoring" value="0">
				<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
					hspace="2" align="left">Planes Adicionales - Solicitud Scoring N° <bean:write
					name="PlanesAdicionalesScoringForm" property="numSolScoring" /> - <bean:write
					name="PlanesAdicionalesScoringForm" property="desEstadoActual" />
			</logic:notEqual>		
			<!-- Fin P-CSR-11002 19-04-2011 -->
			</td>
		</tr>
	</table>
	<br />
	<div id="wrapper">
	<h3>Productos a Contratar:</h3>
	<br>
	<logic:present name="PlanesAdicionalesScoringForm" property="mensajeError">
		<table style="border: 0; width: 82%">
			<tr>
				<td class="mensajeError">
				<div id="mensajes"><bean:write name="PlanesAdicionalesScoringForm" property="mensajeError" />
				</div>
				</td>
			</tr>
		</table>
	</logic:present> <logic:notEmpty name="PlanesAdicionalesScoringForm" property="productos">
		<div style="height: 480px; max-height: 480px; min-height: 240px;  width: 82%; overflow: auto;">
		<table style="width: 96%;">
			<thead>
				<tr>
					<th style="text-align: center; width: 40%">Producto</th>
					<th style="text-align: center; width: 10%">Moneda</th> <!-- P-CSR-11002 JLGN 26-10-2011 -->
					<th style="text-align: center; width: 10%">Cargo Producto</th> <!-- P-CSR-11002 JLGN 01-07-2011 -->
					<th style="text-align: center; width: 20%">Modo Contrataci&oacute;n</th>					
					<th style="text-align: center; width: 20%">Contratar</th>
				</tr>
			</thead>
			<logic:iterate id="productos" name="PlanesAdicionalesScoringForm" property="productos">
				<logic:greaterThan name="productos" property="maxContrataciones" value="0">
					<tr>
						<td><bean:write name="productos" property="tipoComportamiento" /> - <bean:write
							name="productos" property="idProdOfertado" /> - <bean:write name="productos"
							property="desProdOfertado" />
						</td>
						<!-- Inicio P-CSR-11002 JLGN 26-10-2011 -->
						<td style="text-align: center;"><bean:write name="productos" property="desMoneda" />
						</td>
						<!-- Fin P-CSR-11002 JLGN 26-10-2011 -->
						<!-- Inicio P-CSR-11002 JLGN 01-07-2011 -->
						<td style="text-align: center;"><bean:write name="productos" property="montoImporte" />
						</td>
						<!-- Fin P-CSR-11002 JLGN 01-07-2011 -->
						<td>
						<logic:equal name="productos" property="tipoRelacionPA" value="2"> 
							<label id='labelObligatorio' style="width: 40px;"> Opcional Obligatorio </label>
						</logic:equal>
						<logic:equal name="productos" property="tipoRelacionPA" value="3"> 
							<label id='labelOpcional'style="width: 40px;"> Opcional </label>
						</logic:equal>	
						</td>
						<td style="text-align: left;">
						<logic:equal name="productos" property="tipoRelacionPA" value="2">
							<input style="width: 20px" name="contratar" type="checkbox" checked="true" disabled="true"
							id='checkBoxContratar<bean:write name='productos' property='codProductoOfertado'/>' /> 
							<input
							maxlength="6"
							disabled="true"
							onblur="cantidad_onblur(this, <bean:write name='productos' property='maxContrataciones' />)"
							style="text-align: right; width: 40px;" name="cantidad" type="text" value="1"
							id='textBoxCantidad<bean:write name='productos' property='codProductoOfertado'/>' /> 
							<label
							id='labelMaximo1<bean:write name='productos' property='codProductoOfertado'/>'
							style="width: 40px;"> máximo </label>
							<label
							id='labelMaximo2<bean:write name='productos' property='codProductoOfertado'/>'
							style="width: 20px;"><bean:write name='productos'
							property='maxContrataciones' /></label>
						</logic:equal>
						<logic:equal name="productos" property="tipoRelacionPA" value="3">
							<input style="width: 20px" name="contratar" type="checkbox"
							onclick="contratar_onclick(this)"
							id='checkBoxContratar<bean:write name='productos' property='codProductoOfertado'/>' /> 
							<input
							maxlength="6"
							onblur="cantidad_onblur(this, <bean:write name='productos' property='maxContrataciones' />)"
							style="text-align: right; width: 40px; display: none;" name="cantidad" type="text"
							id='textBoxCantidad<bean:write name='productos' property='codProductoOfertado'/>' /> 
							<label
							id='labelMaximo1<bean:write name='productos' property='codProductoOfertado'/>'
							style="width: 40px; display: none;"> máximo </label>
							<label
							id='labelMaximo2<bean:write name='productos' property='codProductoOfertado'/>'
							style="width: 20px; display: none;"><bean:write name='productos'
							property='maxContrataciones' /></label>
						</logic:equal>
						</td>			
					</tr>
				</logic:greaterThan>
			</logic:iterate>
		</table>
		</div>
	</logic:notEmpty> <br>
	<table style="border: 0; width: 82%">
		<tr>
			<td style="width: 50%; text-align: left;"><html:button property="buttonVolver" styleId="buttonVolver"
				onclick="buttonVolver_onclick()" style="width: 80px;"><<</html:button></td>
			<td style="width: 50%; text-align: right;"><logic:notPresent
				name="PlanesAdicionalesScoringForm" property="mensajeError">
				<html:button property="buttonAceptar" styleId="buttonAceptar" onclick="fncCursorEspera();buttonAceptar_onclick()" style="width: 80px">ACEPTAR
			</html:button>
			</logic:notPresent></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
