<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String accionDireccion = (String)request.getAttribute("accionDireccion");
	String idDiv = null;
	String nameSelect = null;
	String onChange = null;
	com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[] provinciaDTOs = null;
	com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[] ciudadDTOs = null;
	com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO[] comunaSPNDTOs = null;
	String zip = null;
	if("cargarProvincias".equals(accionDireccion)){
		idDiv="dv-COD_PROVINCIA";
		nameSelect ="control_COD_PROVINCIA";
		provinciaDTOs =  (com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProvinciaDTO[]) request.getAttribute("provincias");		
		onChange="COD_PROVINCIA";
	}
	else if("cargarCiudades".equals(accionDireccion)){
		idDiv="dv-COD_CIUDAD";
		nameSelect ="control_COD_CIUDAD";
		ciudadDTOs =  (com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.CiudadDTO[]) request.getAttribute("ciudades");
		onChange="COD_CIUDAD";
	}
	else if("cargarComunas".equals(accionDireccion)){
		idDiv="dv-COD_COMUNA";
		nameSelect ="control_COD_COMUNA";
		comunaSPNDTOs =  (com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ComunaSPNDTO[]) request.getAttribute("comunas");
		//onChange="cargarZip";
		onChange="";
	}
	else if("cargarZip".equals(accionDireccion)){
		idDiv="dv-ZIP";
		nameSelect ="dv-ZIP";
		zip =  (String) request.getAttribute("zip");
		onChange="";
	}
%>
<html>
<head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
 	var html = document.getElementById('<%=idDiv%>').innerHTML;
 	parent.gifCargando('unload');
	parent.copiarDatos(html,'<%=idDiv%>'); 	   
}
</script>
</head>
<body>
<div id="<%=idDiv%>">
<%
if ("dv-ZIP".equals(idDiv)){
	if("cargarZip".equals(accionDireccion)){		
	    		%><input type="text" name="cboZip" id="cboZip" value="<%=zip%>">
	      <%}
}else {
	%><select name="<%=nameSelect%>" id="<%=nameSelect%>" onchange="fncOnChangeCMB('<%=onChange%>');">	
	<%
	if("cargarProvincias".equals(accionDireccion)){
		%><option value="seleccione">seleccione</option><%
		for(int i=0;i<=provinciaDTOs.length-1;i++){
    		%><option value="<%=provinciaDTOs[i].getCodigoProvincia()%>"><%=provinciaDTOs[i].getDescripcionProvincia()%></option>
      <%}
	}
	else if("cargarCiudades".equals(accionDireccion)){
		%><option value="seleccione">seleccione</option><%
		for(int i=0;i<=ciudadDTOs.length-1;i++){
    		%><option value="<%=ciudadDTOs[i].getCodigoCiudad()%>"><%=ciudadDTOs[i].getDescripcionCiudad()%></option>
      <%}
	}else if("cargarComunas".equals(accionDireccion)){
		%><option value="seleccione">seleccione</option><%
		for(int i=0;i<=comunaSPNDTOs.length-1;i++){
    		%><option value="<%=comunaSPNDTOs[i].getCodigoComuna()%>"><%=comunaSPNDTOs[i].getDescripcionComuna()%></option>
      <%}
	}
}
%>
</select>
</div>
</body>
</html>