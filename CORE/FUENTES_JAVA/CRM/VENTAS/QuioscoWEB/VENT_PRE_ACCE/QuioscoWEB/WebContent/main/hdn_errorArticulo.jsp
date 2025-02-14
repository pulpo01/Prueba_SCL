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
 		var html = document.getElementById('error').innerHTML;
 		parent.copiarDatos(html,"dv-error-articulo"); 	
 		parent.gifCargando('unload');
 		parent.focoSerie();   
}
</script>
</head>
<body>
<div id="error">
<span class="error"><%=desError%></span>
</div>
</body>
</html>