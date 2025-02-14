
<%

long time = new java.util.Date().getTime();

session.invalidate();
request.getSession().invalidate();

%>

<html>
<head>
<title>
Logout
</title>
<script language="JavaScript">
function pageClose() {

  //parent.location.href="../Index.jsp?timestamp=" + new Date().getTime();
  //parent.location.href="../Index.jsp?clearSession=true";
  location.href="../main/Login.jsp";

}
</script>

</head>
<body OnLoad="pageClose()" bgcolor="#ffffff">

</body>
</html>
