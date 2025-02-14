<%
	String contextPath = request.getContextPath();
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script language="JavaScript"> 
function mostrarPDF() 
{
document.getElementById('pdfForm').submit();
}
</script>
</HEAD>
<BODY OnLoad="javascript:mostrarPDF()"> 
<form action="<%=contextPath%>/action/PDFAction.do" onkeydown="javascript:return false" id="pdfForm" method="post">
	<input type="hidden" name="accionPDF" onkeydown="javascript:return false" id="accionPDF"value="generarPDF" />
</form>
</body>
</html>