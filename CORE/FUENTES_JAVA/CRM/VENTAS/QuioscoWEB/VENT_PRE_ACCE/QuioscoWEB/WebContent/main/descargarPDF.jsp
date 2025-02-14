<%@ page import="java.io.OutputStream" %><%@ page import="java.io.File" %><%


	byte[] bt = (byte[]) request.getAttribute("download-bytes");	

	

	String contentType = (String) request.getAttribute("download-contentType");
	response.setContentType(contentType);
	response.setContentLength(bt.length);


	String filename = (String) request.getAttribute("download-filename");	

	
	response.setHeader("Content-Disposition","inline; filename=\""+filename+"\"");	
	
	try
	{

		OutputStream ros = response.getOutputStream();

		ros.write(bt,0,bt.length);		

		ros.flush();

		ros.close();
	}
	catch ( Exception x) 
	{
	}
	%>