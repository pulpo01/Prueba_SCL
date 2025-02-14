<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/WEB-INF/tld/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/tld/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tld/struts-html.tld" prefix="html" %>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
<!--
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	window.history.forward(1);
	
	document.onkeydown = function(){
      if(window.event && window.event.keyCode == 8)
	  {
	    window.event.keyCode = 505;
      }
    }
  
</script>
</head>
<body onload="history.go(+1);">

<table width="100%" border="0">
  <tr>
    <td width="22%" class="amarillo"><h2><img src="img/green_arrow.gif" width="15" height="15" hspace="2" align="left" /> Bienvenidos </h2></td>
    <td width="78%">&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2"  class="textcaminohormigas"><img src="img/px_trans.jpg" alt="  " width="20" height="1" /></td>
  </tr>
  <tr>
    <td height="21" colspan="2"  class="amarillo"><img src="img/foto_portada.jpg" alt="Foto portada" width="132" height="122" hspace="2" vspace="2" align="left" /><br />
<br/>
Ventas <bean:write name="nomOperador"/><br/>
</td>
  </tr>
</table>
<p>&nbsp;</p>
</body>
</html>