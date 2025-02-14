<html>
<head>
<title>
Carpetas Comerciales
</title>


</head>
<script language="javascript">
document.onkeydown = filterF5;
function filterF5() {
  var key_f5 = 116; // 116 = F5  86 = R
  if (key_f5==event.keyCode ||(event.ctrlKey && event.keyCode == 82)) {
    event.keyCode=0;
    event.returnValue = false;
    return false
  }
}
</script>
<%
/*
se pasa un timestamp para burlar caches de browser, proxy, etc.

en modo desarrollo el frame oculto se puede levantar para ver qué pasa.
este parametero se configura en web.xml como un parametro de contexto:}
   - run.environnement = develop
*/
    long time = new java.util.Date().getTime();
    String header = "../main/top.jsp?timestamp=" + time;
//    String header = "../main/Menu.jsp?timestamp=" + time;
//    String display = "../main/Welcome.jsp?timestamp=" + time;
    String display = "../common/Empty.html?timestamp=" + time;
    String menu = "../main/Menu.jsp?timestamp=" + time;
    String ctrl = "../common/Empty.html?timestamp=" + time;
    String empty = "../common/Empty.html";

    if ( ctrl != null ) {
      if ( ctrl.indexOf("?") < 0 ) {
        ctrl = ctrl + "?timestamp=" + time;
      }
      display = empty;
    } else {
      ctrl = empty;
    }
//    System.out.println("");
//    System.out.println("display: " + display);
//    System.out.println("ctrl:    " + ctrl);
//    System.out.println("");
%>

<!--frameset rows="161,*,0" cols="*" frameborder="NO" border="0" framespacing="0"-->
  <!--frame src="top.html" name="arriba" scrolling="NO" noresize -->
  <frameset rows="*" cols="*,0" framespacing="0" frameborder="NO" border="0">
    <frame src="<%=response.encodeURL(display)%>" name="display" noresize>
    <frame src="<%=response.encodeURL(ctrl)%>" name="ctrl" noresize>
  </frameset>

</html>
