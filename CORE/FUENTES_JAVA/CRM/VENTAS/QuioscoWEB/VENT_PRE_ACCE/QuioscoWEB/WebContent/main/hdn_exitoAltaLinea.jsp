<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO tiendaVendedorOutDTO =(com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendaVendedorOutDTO) session.getAttribute("tiendaVendedor");
String sinFactura=(String) request.getAttribute("sinFactura");
%>
<html>
<head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
 	var sinFac = "<%=sinFactura%>";
 	var html = document.getElementById('dv-msg').innerHTML;
	parent.copiarDatos(html,'dv-datos');
	
	if("no"==sinFac){
		parent.generarPDF("<%=tiendaVendedorOutDTO.getIndApliPAgo().trim()%>"); 	   
	}
	
	parent.gifCargando('unload');
}
</script>
</head>
<body>
<div id="dv-msg">
<h1>Venta Exitosa</h1> <br>

<center>
Nro de venta: <bean:write name="ventaNumVenta"/> <br>
<%if("si".equals(sinFactura)&&"1".equals(tiendaVendedorOutDTO.getIndApliPAgo().trim())){
		out.print("Se ha vencido el tiempo para esperar la factura, el pago se ha cargado al cliente.<br> El documento se generar&aacute; en pocos minutos m&aacute;s");
  }else{
  %>
  <logic:notEqual name="ventaNumVenta" value="No es posible mostrar el número de venta en estos momentos">
		<br><br><label onclick="generarPDF(1);" style="cursor: pointer;">VOLVER A IMPRIMIR FACTURA</label>
  </logic:notEqual>
  <%
  }
%>


</center>
</div>
</body>
</html>