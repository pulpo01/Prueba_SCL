<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<script>
function muestraAbonado(idAbo,nomAbo)
{
	if(idAbo != 0)
	{
		document.write("<td class=\"campoInformativo\">L&iacute;nea</td>");
		document.write("<td >:</td>");
		document.write("<td class=\"valorCampoInformativo\">");
		document.write(nomAbo+"-"+idAbo);
		document.write("</td>");
	}
	else
	{
		document.write("<td class=\"campoInformativo\"></td>");
		document.write("<td ></td>");
		document.write("<td class=\"valorCampoInformativo\">");
	}
}
</script>
<html:html>
<head>
<script language="JavaScript" src="pages/js/navegaAction.js" type="text/javascript"></script>
<script language="JavaScript" src="pages/js/efectos.js" type="text/javascript"></script>
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .: Planes Adicionales del abonado :.</title>
<script language="javascript">
</script>
</head>

<body >

<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</body>
</html:html>
