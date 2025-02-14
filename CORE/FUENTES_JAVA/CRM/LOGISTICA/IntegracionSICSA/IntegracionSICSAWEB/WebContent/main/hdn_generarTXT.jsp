<%
	try
	{
		String nomArchivo = (String) request.getAttribute("nomTxt");
		response.setContentType("text/plain");
		response.setHeader("Content-Disposition","attachment; filename=\""+nomArchivo+"\"");
		byte[] datos = (byte[])request.getAttribute("array");
		ServletOutputStream ouputStream = response.getOutputStream();
		ouputStream.write(datos,0,datos.length);
		ouputStream.flush();
		ouputStream.close();
	}
	catch ( Exception x) 
	{
		x.getStackTrace();
	}
	%>