<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="javascript">
	var objNewWindow;
	
	function abrir()
	{
		var strFeatures = "left=200,top=100,width=650,height=550,fullscreen=no" 
		var Pagina = "${pageContext.request.contextPath}/VendedorInit.do"; 
		objNewWindow = window.open(Pagina,"newWin", strFeatures); 
		objNewWindow.focus(); 
 		return false;
	}
</script>
</head>
<body>
Inicio Vendedor...
<form  method="POST" action="/index.jsp">
<input type="submit" onclick="return abrir();">
</form>
</body>
</html>