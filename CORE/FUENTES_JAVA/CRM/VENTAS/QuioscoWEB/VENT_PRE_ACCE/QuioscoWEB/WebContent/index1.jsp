<%
	String contextPath = request.getContextPath();
%>
<%
//response.setHeader("Cache-Control","no-store"); //HTTP 1.1
response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
response.setHeader("Pragma","no-cache"); //HTTP 1.0
response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>

<HTML>
<HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript"> 
function pantallacompleta (pagina) 
{
var opciones=("toolbar=no, location=no,  directories=no, status=no, menubar=no ,scrollbars=no, resizable=no, fullscreen=yes"); 
window.open(pagina,"",opciones); 
}
</script>
</HEAD>
<BODY OnLoad="javascript:pantallacompleta('<%=contextPath%>/index.jsp')"> 
</BODY>
</HTML>