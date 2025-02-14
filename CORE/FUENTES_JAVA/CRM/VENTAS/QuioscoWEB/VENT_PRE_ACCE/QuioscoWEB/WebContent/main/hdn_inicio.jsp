<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
	String rolUsuario = (String)request.getAttribute("rolUsuario");
	org.apache.commons.configuration.CompositeConfiguration config2;
	config2 = com.tmmas.cl.framework20.util.UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
	String superUsuarios =config2.getString("rol.super.usuarios").trim();
	String mantenedorUsuarios =config2.getString("rol.mantenedor.usuarios").trim();
	String vendedorUsuarios =config2.getString("rol.vendedor.usuarios").trim();
%>
<html>
<head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
	var rolUsuario2 = "<%=rolUsuario%>";
	
 	var html1 = document.getElementById("dv-datos-vendedor").innerHTML;
	var html2 = "";
 	var html3 = document.getElementById("dv-datos").innerHTML;
 	
 	
   	if("<%=superUsuarios%>"==rolUsuario2){
    	 html2 = document.getElementById("dv-datos-link-superUsuarios").innerHTML;
    }
    else if("<%=mantenedorUsuarios%>"==rolUsuario2){
    	 html2 = document.getElementById("dv-datos-link-mantenedorUsuarios").innerHTML;
    }
    else if("<%=vendedorUsuarios%>"==rolUsuario2){
    	 html2 = document.getElementById("dv-datos-link-vendedorUsuarios").innerHTML;
    }
    parent.gifCargando('unload');    
	parent.copiarDatos(html1,"dv-datos-vendedor"); 
    parent.copiarDatos(html2,"dv-datos-link");	 	    
    parent.copiarDatos(html3,"dv-datos");
      	  
	}
</script>
</head>
<body>
<div id="dv-datos-vendedor">
		<table width="100%"  valign="top">
			<tr>
				<td width="auto"><span class="campoInf">LOCAL:</span><span class="resultInf"><bean:write name="tiendaVendedor" property="desTienda"/></span></td>
				<td width="auto"><span class="campoInf">RUC:</span><span class="resultInf"><bean:write name="tiendaVendedor" property="numIdentCli"/></span></td>
				<td width="auto"><span class="campoInf">BODEGA:</span><span class="resultInf"><bean:write name="tiendaVendedor" property="desBodega"/></span></td>
				<td width="auto"><span class="campoInf">VENDEDOR:</span> <span class="resultInf"><bean:write name="tiendaVendedor" property="nomVendedor"/></span></td>
				<td width="auto"><span class="campoInf">CAJA:</span> <span class="resultInf"><bean:write name="tiendaVendedor" property="desCaja"/></span></td>
			</tr>
		</table>
</div>
<div id="dv-datos-link-superUsuarios">
	<a href="javaScript:llamarVenta()">Venta</a>&nbsp;<a href="javaScript:cargarMantenedorTienda()">Mantenedor de Tiendas</a>&nbsp;<a href="javaScript:javaScript:cargarMantenedorClientizar()">Mantenedor Clientizar</a>&nbsp;<a href="javaScript:salir()">Salir</a>
</div>
<div id="dv-datos-link-mantenedorUsuarios">
	<a href="javaScript:cargarMantenedorTienda()">Mantenedor de Tiendas</a>&nbsp;<a href="javaScript:javaScript:cargarMantenedorClientizar()">Mantenedor Clientizar</a>&nbsp;<a href="javaScript:salir()">Salir</a>
</div>
<div id="dv-datos-link-vendedorUsuarios">
	<a href="javaScript:llamarVenta()">Venta</a>&nbsp;<a href="javaScript:salir()">Salir</a>
</div>
<div id="dv-datos">
	<img src="<%=contextPath%>/imagenes/logoGrande.jpg">
</div>
</body>
</html>