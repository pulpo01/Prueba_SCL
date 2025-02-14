<%
	// -- HGG 19/06/09
	// Logout y redireccion al portalSAC
	 
	session.invalidate();
	String path = new String();
	path = "http://" + request.getServerName() + ":" + request.getServerPort() + "/PortalSAC/jsp/login.jsp";
	response.sendRedirect(path);
%>