<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
org.apache.commons.configuration.CompositeConfiguration config2;
config2 = com.tmmas.cl.framework20.util.UtilProperty
		.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.KitVO> listaKit =  (java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.KitVO>)session.getAttribute("listaKit");
%>
<html>
<head>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("kit").innerHTML;
    var htmlTotal = document.getElementById("total").innerHTML;
    parent.copiarDatos(htmlTotal,"grilla-totales");  	  
    parent.copiarDatos(html,"grilla-kit");  
    parent.gifCargando('unload');
    parent.calcularVuelto();
    parent.focoSerie();		    
}
</script>
<div id="kit">
<fieldset style="height:80px;"><legend>kit</legend>
<%if(listaKit.size()>0){ %>
<div style="height: 80px; overflow: auto;">
<table width="50%">
	<tr align="center" valign="top">
		<th width="auto" height="16">N&uacute;mero Kit</th>
		<th width="auto" height="16">Descripci&oacute;n</th>
		<th width="auto" height="16">Precio</th>
		<th width="auto" height="16"></th>
	</tr>
	<logic:iterate id="kit" name="listaKit">
		<tr align="center" valign="top">
			<td><bean:write name="kit" property="numeroKit" /></td>
			<td><bean:write name="kit" property="descripcionKit" /></td>
			<td><bean:write name="kit" property="precioKit" /></td>
			<td><img src="<%=contextPath%>/imagenes/btnCancel.gif" onclick="quitarKitVenta('<bean:write name='kit' property='idKit'/>');" />
		</tr>
	</logic:iterate>
</table>
</div>
<%}else{
	out.print("No ha ingresado kit");
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
				 			
					<tr style='display:none;'>
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