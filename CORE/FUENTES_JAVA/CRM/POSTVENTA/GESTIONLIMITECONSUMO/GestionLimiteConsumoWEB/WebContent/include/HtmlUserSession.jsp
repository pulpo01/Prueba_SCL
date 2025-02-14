<%@page import="com.tmmas.scl.gestionlc.common.dto.common.ServiceContextDTO"%>

<%
ServiceContextDTO context = (ServiceContextDTO)request.getSession().getAttribute("login");

String username = "";

if(context != null){
	
	username = context.getUsername();
	
}
%>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="1%" class="barraarriba">&nbsp;</td>
    <td width="99%" class="barraarriba">Usuario: <%=username%></td>
  </tr>
</table>  