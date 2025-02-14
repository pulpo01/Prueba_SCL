<%
    int i = 0;
    int k = 0;
    int maxLength = request.getContentLength();
    
    byte[] bytes = new byte[maxLength];
    
    String method = request.getParameter("method");
    String name = request.getParameter("name");
    ServletInputStream si = request.getInputStream();
    while (true)    {
        k = si.read(bytes,i,maxLength);
        i += k;
        if (k <= 0)
        break;
    }

    if (bytes != null)
    {
        ServletOutputStream stream = response.getOutputStream();
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
        response.setHeader("Content-Disposition",method + ";filename=" + name);
        stream.write(bytes);
        stream.flush();
        stream.close();
    }
    else
    {
        response.setContentType("text");
        response.getWriter().write("bytes is null");
    }
%>