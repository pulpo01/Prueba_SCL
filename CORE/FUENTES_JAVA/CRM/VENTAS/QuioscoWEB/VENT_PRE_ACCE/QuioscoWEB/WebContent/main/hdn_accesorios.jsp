<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
org.apache.commons.configuration.CompositeConfiguration config2;
config2 = com.tmmas.cl.framework20.util.UtilProperty
		.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.AccesorioVO> listaAccesorios =  (java.util.ArrayList<com.tmmas.scl.quiosco.web.VO.AccesorioVO>)session.getAttribute("listaAccesorios");

%>
<html>
<head>    
<meta http-equiv="expires" content="0">
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    var html = document.getElementById("accesorio").innerHTML;
    var htmlTotal = document.getElementById("total").innerHTML;
    parent.copiarDatos(htmlTotal,"grilla-totales");  
    parent.copiarDatos(html,"grilla-accesorios");  	 
    parent.gifCargando('unload');		
    parent.calcularVuelto();   
    parent.focoSerie();
}
</script>
<div id="accesorio">
<fieldset style="height:80px;"><legend>Accesorios</legend>
<%if(listaAccesorios.size()>0){ %>
<div  style="height:80px; overflow: auto;">
<table width="100%">
	<tr align="center" valign="top">
		<th width="auto" height="16">C&oacute;digo</th>
		<th width="auto" height="16"> serie	</th>		
		<th width="auto" height="16">Descripci&oacute;n </th>
		<th width="auto" height="16">cantidad</th>
		<th width="auto" height="16">Precio Unitario</th>
		<th width="auto" height="16">Total</th>
		<th width="auto" height="16"></th>
	</tr>
	<logic:iterate id="accesorios" name="listaAccesorios">
		<tr align="center" valign="top">
			<td><bean:write name="accesorios" property="codigo"/></td>
			<td><bean:write name="accesorios" property="serie"/></td>
			<td><bean:write name="accesorios" property="descripcion"/></td>
			<td><bean:write name="accesorios" property="cantidad"/></td>
			<td><bean:write name="accesorios" property="precioUnitario"/></td>
			<td><bean:write name="accesorios" property="total"/></td>
			<td><input type="hidden" name="idAcc" id="idAcc" value="<bean:write name='accesorios' property='idAccesorio'/>" />
			<img src="<%=contextPath%>/imagenes/btnCancel.gif" onclick="quitarAccesorio('<bean:write name='accesorios' property='idAccesorio'/>');">
		</tr>
    </logic:iterate>
</table>	
</div>
<%}else{
		out.print("No ha ingresado accesorios");
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
						<td align="left"  valign="top" class="totales">I.T.B.M</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="itbmRound" /></td>
					</tr>
					<tr style='display:none;'>
						<td align="left"  valign="top" class="totales">I.S.C</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="iscRound" /></td>
					</tr >
					<tr style='display:none;'>
						<td align="left" valign="top" class="totales">TOTAL</td>
						<td align="right" valign="top" class="totales">:</td>
						<td align="right" valign="top"><bean:write name="totalVO" property="totalRound" /> <input type="hidden"
							name="hdnTotal" id="hdnTotal" value="<bean:write name="totalVO" property="totalRound" />"></td>
					</tr>
 				
			</table>
		</div>
</html>