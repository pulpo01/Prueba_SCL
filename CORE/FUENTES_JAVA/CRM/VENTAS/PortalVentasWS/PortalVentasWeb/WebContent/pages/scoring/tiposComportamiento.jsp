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

	var prefijoCheckBox = "checkBox";
	
	function checkBoxTodos_onclick(o) {
		var checkBoxes = document.getElementsByName("checkBoxes");
		for (var i = 0; i < checkBoxes.length; i++) {
			checkBoxes[i].checked = o.checked;
		}
	}

	function buttonContinuar_onclick() {
		var checkBoxes = document.getElementsByName("checkBoxes");
		var vv = "";
		for (var i = 0; i < checkBoxes.length; i++) {
			if (checkBoxes[i].checked) {
				var v = checkBoxes[i].id.replace(prefijoCheckBox, "");
				vv += v;
				vv += ",";
			}
		}
		if (vv.length > 0) {
			vv = vv.substring(0, vv.length - 1);
			document.getElementById("tiposSeleccionadosEnCSV").value = vv;
			document.getElementById("opcion").value = "irAPlanesAdicionalesScoring";
		    document.forms[0].submit();
		}
		else if (confirm("No hay planes adicionales seleccionados. ¿Desea continuar?")) {
			document.getElementById("opcion").value = "cancelarPAScoring";
			document.forms[0].submit();
		}
	}
	
	function buttonVolver_onclick() {
		document.getElementById("opcion").value = "volverPAScoring";
		document.forms[0].submit();
	}
	
	//Inicio P-CSR-11002 JLGN
	function buttonVolver2_onclick() {
		document.getElementById("opcion").value = "volverPAScoring2";
		document.forms[0].submit();
	}
	//Fin P-CSR-11002 JLGN
	
	function body_onload() {
		var csv = document.getElementById("tiposSeleccionadosEnCSV");
		var tipos = csv.value.split(",");
		var checkBoxes = document.getElementsByName("checkBoxes");
		if (tipos.length == 0) {
			return;
		}
		else if (tipos.length == checkBoxes.length) {
			document.getElementById("checkBoxTodos").click();
			return;
		}
		else {
			for (var i = 0; i < checkBoxes.length; i++) {
				var box = checkBoxes[i];
				for (var j = 0; j < tipos.length; j++) {
					var tipo = tipos[j];
					if (box.id.replace(prefijoCheckBox, "") == tipo) {
						box.checked = true;
						break;
					}
				}
			}
		}
	}

</script>
</head>
<body onload="body_onload()">
<html:form method="post" action="/TiposComportamientoAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden name="TiposComportamientoForm" property="tiposSeleccionadosEnCSV" styleId="tiposSeleccionadosEnCSV" />
	<table>
		<tr>
			<td class="amarillo">
			<!-- Inicio P-CSR-11002 19-04-2011 JLGN-->
			<logic:equal name="TiposComportamientoForm" property="numSolScoring" value="0">
				<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">Planes Adicionales
			</logic:equal>
			<logic:notEqual name="TiposComportamientoForm" property="numSolScoring" value="0">
				<h2><img src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
					hspace="2" align="left">Planes Adicionales - Solicitud Scoring N° <bean:write
					name="TiposComportamientoForm" property="numSolScoring" /> - <bean:write
					name="TiposComportamientoForm" property="desEstadoActual" />
			</logic:notEqual>		
			<!-- Fin P-CSR-11002 19-04-2011 JLGN-->
			</td>
		</tr>
	</table>
	<br />
	<div id="wrapper">
	<h3>Seleccione Tipos de Comportamiento:</h3>
	<br>
	<table style="width: 60%">
		<thead>
			<tr>
				<th style="width: 10%"><input type="checkbox" id="checkBoxTodos"
					onclick="checkBoxTodos_onclick(this)"></th>
				<th>Tipo de Comportamiento</th>
			</tr>
		</thead>
		<logic:iterate id="tipos" name="TiposComportamientoForm" property="tipos">
			<tr>
				<td style="width: 10%"><input name="checkBoxes" type="checkbox"
					id='checkBox<bean:write name='tipos' property='valor'/>' /></td>
				<td><bean:write name="tipos" property="valor" /> - <bean:write name="tipos"
					property="descripcionValor" /></td>
			</tr>
		</logic:iterate>
	</table>
	<br>
	<table style="width: 60%">
		<tr>
			<!-- Inicio P-CSR-11002 19-04-2011 JLGN-->
			<logic:equal name="TiposComportamientoForm" property="numSolScoring" value="0">
				<td style="width: 50%; text-align: left;"><html:button property="buttonVolver" styleId="buttonVolver"
				onclick="buttonVolver2_onclick()" style="width: 80px;"><<</html:button></td>
			</logic:equal>
			<logic:notEqual name="TiposComportamientoForm" property="numSolScoring" value="0">
				<td style="width: 50%; text-align: left;"><html:button property="buttonVolver" styleId="buttonVolver"
				onclick="buttonVolver_onclick()" style="width: 80px;"><<</html:button></td>
			</logic:notEqual>		
			<!-- Fin P-CSR-11002 19-04-2011 JLGN-->
			
			
			<td style="width: 50%; text-align: right;"><html:button property="buttonContinuar" styleId="buttonContinuar"
				onclick="buttonContinuar_onclick()" style="width: 80px;">>></html:button></td>
		</tr>
	</table>
	</div>
</html:form>
</body>
</html>
