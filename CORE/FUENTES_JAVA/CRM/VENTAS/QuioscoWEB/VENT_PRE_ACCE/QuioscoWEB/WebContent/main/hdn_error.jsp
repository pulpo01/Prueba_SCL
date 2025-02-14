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
    alert("<%=desError%>");

  		parent.gifCargando('unload');

  
}
</script>
</head>
<body>
<input type="image" name="agregarAccesorio"/>
</body>
</html>