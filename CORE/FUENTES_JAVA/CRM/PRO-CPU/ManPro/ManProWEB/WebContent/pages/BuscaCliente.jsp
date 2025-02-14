<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>

<html>
<head>
<title>Emulador de Visual Basic</title>
</head>
<body>
<html:form action="/Contratar" >
<p><h3><bean:message key="Version"/></h3> </p>
<table>
<tr>
<td align="right">NumVenta:</td>
<td><html:text property="numVenta" value="19645300"/> </td>
</tr>
<tr>
<tr>
<td align="right">CodCliente:</td>
<td><html:text property="codCliente" value="5526015"/> </td>
</tr>
<tr>
<td align="right">Num transaccion:</td>
<td><input type="text" name="num_transaccion" value="265633256"/> </td>
</tr>
<tr>
<td align="right">Num Evento:</td>
<td><input type="text" name="num_evento" value="0"/> </td>
</tr>
<tr>
<td align="right">Cod Vendedor:</td>
<td><input type="text" name="cod_vendedor" value="447"/> </td>
</tr>
<tr>
<td align="right">Flag Ciclo:</td>
<td><input type="text" name="flag_ciclo" value="0"/> </td>
</tr>
<tr>
<td>
</td>
</tr>
</table>
<hr>
<html:submit/>
</html:form>
</body>
</html>
