<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO"%>

<%AbonadoDTO[] listaAbonados = (AbonadoDTO[]) request.getSession().getAttribute("listaAbonados");%>
<html>
<head>    
<meta http-equiv="expires" content="0">
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
    parent.levantarPopUp();  
}
</script>
</html>