<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IntegracionSICSA</title>
<script type="text/javascript">
 onload = function() {
    var html = document.getElementById("dv-series").innerHTML;
    parent.copiarDatos(html,"dv-series");  
    parent.tablaScrollSeries('95%','100px');
 }
</script>
</head>
<body>
<div id="dv-series"><logic:present
	name="serieDTO">
		<div id="tableContainerSeries" class="tableContainerSeries">
		<table border=0 class="scrollTableSeries" width="50%">
			<tbody class="scrollContentSeries">
			<logic:iterate name="serieDTO" id="grilla">
				<tr>
					<td class=detalleSerie><bean:write name="grilla"
					property="numSerie" /></td>
				</tr>
			</logic:iterate>
			</tbody>
		</table>
		</div>
		<label onclick="exportarTXT();" style="cursor: pointer;" class="txtInfo" >Exportar a TXT</label>
</logic:present> 
<logic:notPresent name="serieDTO">
	<label class="error">No se encontraron Series, o bien aun no se finaliza el pedido.</label>
</logic:notPresent>
</div>
</body>
</html>