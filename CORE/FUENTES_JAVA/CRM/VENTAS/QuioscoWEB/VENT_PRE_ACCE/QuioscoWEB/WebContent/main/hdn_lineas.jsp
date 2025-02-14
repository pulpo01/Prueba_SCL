<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
	org.apache.commons.configuration.CompositeConfiguration config2;
	config2 = com.tmmas.cl.framework20.util.UtilProperty
			.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
	java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.LineaVO> listalineas = (java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.LineaVO>) session
			.getAttribute("listaLineas");
%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("linea").innerHTML;
    var htmlTotal = document.getElementById("total").innerHTML;
    parent.copiarDatos(htmlTotal,"grilla-totales");  	  
    parent.copiarDatos(html,"grilla-lineas");     
    parent.calcularVuelto();
    parent.focoSerie();
    parent.gifCargando('unload');	
    
    
}
</script>
<div id="linea">
<fieldset style="height:80px;"><legend>Lineas</legend>
<%
	if (listalineas.size() > 0) {
%>

<div style="height: 80px; overflow: auto;">
<table width="100%" border="0">
	<tr align="center" valign="top">
		<th width="auto" height="16">Simcard</th>
		<th width="auto" height="16">Celular</th>
		<th width="auto" height="16">Descripci&oacute;n Sim</th>
		<th width="auto" height="16">Precio Sim</th>
		<th width="auto" height="16">IMEI</th>
		<th width="auto" height="16">Descripci&oacute;n IMEI</th>
		<th width="auto" height="16">Precio IMEI</th>
		<th width="auto" height="16">TOTAL (IMEI+SIM)</th>
		<th width="auto" height="16"></th>
	</tr>
	<%
		for (int i = 0; i <= listalineas.size() - 1; i++) {
				if (null == listalineas.get(i).getNumKit()
						|| "".equals(listalineas.get(i).getNumKit())) {
	%>
	<tr align="center" valign="top">
		<td><%=listalineas.get(i).getSimcard()%></td>
		<td><%=listalineas.get(i).getCelular()%></td>
		<td><%=listalineas.get(i).getDescripcionSim()%></td>
		<td><%=listalineas.get(i).getPrecioSim()%></td>
		<td><%=listalineas.get(i).getImei()%></td>
		<td><%=listalineas.get(i).getDescripcionImei()%></td>
		<td><%=listalineas.get(i).getPrecioImei()%></td>
		<td><%=listalineas.get(i).getTotal()%></td>
		<td><input type="hidden" name="idLin" id="idLin" value="<%=listalineas.get(i).getIdLinea()%>" /> 
			<img src="<%=contextPath%>/imagenes/btnCancel.gif" onclick="quitarLineaVenta('<%=listalineas.get(i).getIdLinea()%>');"/></td>
	</tr>

	<%
		}
			}
	%>
</table>
</div>
<%
	}
	else{
		out.print("No ha ingresado lineas");
	}
%>
</fieldset>
</div>
<div id="total">
<table width="288" border="0" bordercolor="#848484">
					<tr>
						<td width="103" align="left" valign="top" class="totales">TOTAL NETO</td>
						<td align="right" valign="top" class="totales">:</td>
						<td width="70" align="right" valign="top"><bean:write name="totalVO" property="subTotalRound" /></td>
					</tr>
				 	
					<tr style='display:none;' >
						<td align="left" valign="top" class="totales">I.T.B.M</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="itbmRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">I.S.C</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="iscRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">TOTAL</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="totalRound" /> <input type="hidden"
							name="hdnTotal" id="hdnTotal" value="<bean:write name="totalVO" property="totalRound" />"></td>
					</tr>
				
			</table>
</div>

</html>