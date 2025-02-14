<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[] errores  = (com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO[]) request.getAttribute("errores");
	
%>
<html>
<head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
 	var html = document.getElementById('dv-error').innerHTML;
	parent.copiarDatos(html,'dv-datos'); 	   
	parent.gifCargando('unload');
}
</script>
</head>
<body>
<div id="dv-error">
<h1>Se han producido errores al realizar el alta de linea</h1>
<%
    if(null!=errores&&errores.length>0){
	for(int i=0; i<=errores.length-1;i++){
		int numError= i+1;
		out.print(numError + ".- "+errores[i].getMensajseError()+"<br>");
	}
    }
%>

</div>
</body>
</html>