<%@ taglib uri="/tags/struts-html" prefix="html" %>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    response.setHeader("Cache-Control","no-cache"); //HTTP 1.1
    response.setHeader("Pragma","no-cache"); //HTTP 1.0
    response.setDateHeader ("Expires", 0); //prevents caching at the proxy server
%>
<html:html>
<head>
<title>Insert title here</title>
<c:set var="listaAboSel" value="${sessionScope.AbonadosSeleccionados}"></c:set> 

	<style> body, html {margin:0px; padding: 0px; overflow: hidden;} </style>

	<!-- ActiveWidgets stylesheet and scripts -->

	<script src="../runtime/lib/grid.js"></script>
	<link href="../runtime/styles/xp/grid.css" rel="stylesheet" type="text/css" ></link>
	<script language="JavaScript" src="../js/paging1.js" type="text/javascript"></script>
	
		<!-- grid format -->
	<style>
		.active-controls-grid {height: 340px; font: menu;}
		
		.active-column-1 {width: 90px;}
		.active-column-2 {width: 90px;}
		.active-column-3 {width: 110px; background-color: threedlightshadow;}
		.active-column-4 {text-align: left;}
		
		.active-grid-column {border-right: 1px solid threedshadow;}
		.active-grid-row {border-bottom: 1px solid threedlightshadow;}
	</style>
<script language="javascript">
   	 
<!-- grid data -->
 var matrizAbonados = new Array(); 
 var indiceSel = -1;
 
  <logic:notEmpty name="listaAboSel">

     i=0;
     <logic:iterate id="abonado" name="listaAboSel"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       filaAbonados = new Array();
       filaAbonados[0] = "<bean:write name='abonado' property='codTecnologia'/>";
       filaAbonados[1] = "<bean:write name='abonado' property='numAbonado'/>";
       filaAbonados[2] = "<bean:write name='abonado' property='nombreCompleto'/>";
       filaAbonados[3] = "<bean:write name='abonado' property='numCelular'/>";

       matrizAbonados[i] = filaAbonados;
       
       i++;
     </logic:iterate>
 </logic:notEmpty>
 
var columnas = ["Tecnología","Numero Abonado", "Nombre", "Celular"];
			
function obtieneData(i,j){
	   var fila = matrizAbonados[i];
	   var data = fila[j];
	   return data;
} 

<!-- abonados seleccionados -->
function seleccionaAbonado(i){
		indiceSel = i;
}

function obtenerSeleccion(){
	var numAbonado = 0;
		
	if (indiceSel != -1){
		var fila =matrizAbonados[indiceSel];
		
		numAbonado = fila[1];
		
	 }
	 
	return numAbonado;	
}

</script>

</head>
<body>
	<script>
	
	//matrizAbonados = window.parent.f_obtieneAbonadosSel();
	
if (matrizAbonados.length > 0) {
	//	create the grid object
	var obj = new Active.Controls.Grid;
	var cantidad = matrizAbonados.length;
	
	//	replace the built-in row model with the new one (defined in the patch)
	obj.setModel("row", new Active.Rows.Page);
	obj.setRowProperty("count", cantidad);
    obj.setColumnProperty("count", 3);
	obj.setProperty("data/text", function(i, j){return obtieneData(i,j)});
	obj.setProperty("column/texts", columnas);

	//	set page size
	obj.setProperty("row/pageSize", matrizAbonados.length);
	
    obj.setAction("click",    function(src){
                                           seleccionaAbonado(src.getItemProperty("index"));
                               }
                  ); 
                                       
	//	write grid html to the page
	document.write(obj);
}
	</script>
	


</body>
</html:html>