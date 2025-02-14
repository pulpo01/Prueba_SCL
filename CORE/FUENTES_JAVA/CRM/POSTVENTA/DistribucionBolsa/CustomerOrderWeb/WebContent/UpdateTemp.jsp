<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>

<html:html>
<script src="JS/MyUtil.js" type="text/javascript"></script>

<script type="text/javascript">

function Limite()
{
	this.id = "";
	this.name = "";
	this.monto = 0;
}



function asigna()
{
	/*
	
	list = new Array();
	
	var e = 0;
	for( i = 0 ; i < document.forms[0].elements.length ; i++ )
	{
		if (document.forms[0].elements[i].name == "selected" && document.forms[0].elements[i].checked)
		{
			var obj = new Limite();
			obj.id = i;
			alert(obj.M1());
			
			list[e] = obj;
			e++;
		}
	}*/
	
	window.parent.frames["lib"].wz.next();
	window.parent.frames["lib"].wz.execute();
}

</script>


<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<title>Telefónica Móviles .: Customer Order :.</title>
<link href="css/CustomerOrder.css" rel="stylesheet" type="text/css">
</head>
<body>
<%!String colorFila = null;

	%>
<div align="center"><html:errors bundle="errors" /> 
<html:form action="/UpdateTempAction">
	<table border="0" cellspacing="1" cellpadding="20">
		<tr>
			<td>
			<table border="1" cellpadding="0" cellspacing="0" class="bordeTablas">
				<tr>
					<td colspan="8" class="fondoFilaAzul" align="center">Modificación de
					Servicios Suplementarios</td>
				</tr>
				<tr>
					<td align="center" class="fondoFilaBlanco"><html:button
						styleClass="fondoFilaPlomo" value="Guardar" property="nada"/></td>
					<td>
				</tr>
				<tr>
					<td>
					<table border="0" cellspacing="1" cellpadding="2">
						<tr class="fondoFilaAzul">
							<td><input type="checkbox" name="all" onclick="selectAll('selected')"/></td>
							<td class="tablaFondoAzul"><div align="center">Servicio</div></td>
							<td class="tablaFondoAzul"><div align="center">Nombre</div></td>
							<td class="tablaFondoAzul"><div align="center">Perfil LC</div></td>
						</tr>
						
<logic:iterate indexId="count" id="fila" name="UpdateTempList" 	property="toCollection" type="com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO">
							
								<%colorFila = null;
				if ((count.intValue() % 2) == 0) {
					colorFila = "fondoFilaBlanco";
				} else {
					colorFila = "fondoFilaPlomo";
				}%>
								<tr class="<%=colorFila%>">
									<td><html:multibox value="<%=String.valueOf(count.intValue())%>"  property="selected" /></td>
									<td><div align="center"><bean:write name="fila" property="id"/></div></td>
									<td><div align="center"><bean:write name="fila"	property="name" /></div>
									<!-- 
									<td><div align="center"><html:text property="montos" value="<%=String.valueOf(fila.getMonto())%>" indexed="true" size="12" maxlength="12" onkeyup="validNumericValue(this);" /></div></td>
									 -->
								</tr>
</logic:iterate>

					</table>
					</td>
				</tr>
				<tr>
					<td align="center" class="fondoFilaBlanco"><div align="center"><html:button
						styleClass="fondoFilaPlomo" value="Guardar" property="nada2"
						onclick="return guardar()" /></div>
					</td>
				</tr>				
			</table>
			</td>
		</tr>
	</table>
	<input type="button" name="prueba" value="Guardar" onclick="asigna();">
</html:form></div>

</body>
</html:html>

