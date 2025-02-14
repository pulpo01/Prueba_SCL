<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String desError = (String)request.getParameter("desError");
	if(null==desError){
		desError = (String)request.getAttribute("desError");
	}
%>
<html>
<head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
 	var html = document.getElementById('dv-error').innerHTML;
	parent.copiarDatos(html,'dv-datos'); 	
	parent.gifCargando('unload');   
}
</script>
</head>
<body>
<div id="dv-error">
<h1><%=desError%></h1>
</div>
</body>
</html>