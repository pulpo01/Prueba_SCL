<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <script type='text/javascript' src='/CustomerOrderWeb/dwr/interface/JDate.js'></script>
  <script type='text/javascript' src='/CustomerOrderWeb/dwr/interface/Delegate.js'></script>
  <script type='text/javascript' src='/CustomerOrderWeb/dwr/engine.js'></script>
  <script type='text/javascript' src='/CustomerOrderWeb/dwr/util.js'></script>
  <script type='text/javascript'>
  function showdate() {
  	JDate.toGMTString(callback)
  }
  
  function showdatos() {
  	Delegate.getData(callback2)
  }  
  var callback = function (data) {
  	alert(data)
  }
  
  var callback2 = function (data) {
  	alert(data)
  }  
  </script>  

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<input type= "button" name = "id" onclick= "showdate()"> 
	<input type= "button" name = "id2" onclick= "showdatos()"> 

</body>
</html>