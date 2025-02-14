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
<c:set var="listaAbo" value="${sessionScope.AbonadosFiltrados}"></c:set> 

	<style> body, html {margin:0px; padding: 0px; overflow: hidden;} </style>
	<link href="../css/mas.css" rel="stylesheet" type="text/css" />
	<!-- ActiveWidgets stylesheet and scripts -->

	<script src="../runtime/lib/grid.js"></script>
	<link href="../runtime/styles/xp/grid.css" rel="stylesheet" type="text/css" ></link>
	<script language="JavaScript" src="../js/paging1.js" type="text/javascript"></script>
	
		<!-- grid format -->
	<style>
		.active-controls-grid {height: 340px; font: menu;}
		
		.active-column-0 {width: 90px;}
		.active-column-1 {width: 90px;}
		.active-column-2 {width: 110px; background-color: threedlightshadow;}
		.active-column-3 {text-align: left;}

		
		.active-grid-column {border-right: 1px solid threedshadow;}
		.active-grid-row {border-bottom: 1px solid threedlightshadow;}
	</style>
	
<script language="javascript">
<!-- grid data -->
 var matrizAbonados = new Array(); 
 var abonadosSel = new Array(); 
 var matrizSeleccionados = new Array();
 var indiceSel = -1;

 <logic:notEmpty name="listaAbo">

     i=0;
     <logic:iterate id="abonado" name="listaAbo"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       filaAbonados = new Array();
       filaAbonados[0] = "<bean:write name='abonado' property='codTecnologia'/>";  
       filaAbonados[1] = "<bean:write name='abonado' property='numAbonado'/>";
       filaAbonados[2] = "<bean:write name='abonado' property='nombreCompleto'/>";
       filaAbonados[3] = "<bean:write name='abonado' property='numCelular'/>";
     
       matrizAbonados[i] = filaAbonados;
       
       filaAbonadoSel = new Array();
       filaAbonadoSel[0] = 0;
       filaAbonadoSel[1] = "<bean:write name='abonado' property='codTecnologia'/>";
       filaAbonadoSel[2] = "<bean:write name='abonado' property='numAbonado'/>"; 
       filaAbonadoSel[3] = "<bean:write name='abonado' property='nombreCompleto'/>";
       filaAbonadoSel[4] = "<bean:write name='abonado' property='numCelular'/>";

       abonadosSel[i]  = filaAbonadoSel;
              
       i++;
     </logic:iterate>
 </logic:notEmpty>

 
var columnas = ["Tecnología","Numero Abonado", "Nombre", "Celular" ];
			
function obtieneData(i,j){
	   var fila = matrizAbonados[i];
	   var data = fila[j];
	   return data;
} 

<!-- abonados seleccionados -->
function seleccionaAbonado(i){
		var aboSel = abonadosSel[i];
		
		if (aboSel[0] == 0)	aboSel[0] = 1;
		else aboSel[0] = 0;
		
		indiceSel = i;
}

function obtenerSeleccion(){
	var matrizSeleccionados = new Array();
		
	if (indiceSel != -1){
		var fila =abonadosSel[indiceSel];
		var filaNueva = new Array();
		filaNueva[0] = fila[1];
		filaNueva[1] = fila[2];
		filaNueva[2] = fila[3];
		filaNueva[3] = fila[4];		
	 	matrizSeleccionados[0] = filaNueva;
	 }
	 
	return matrizSeleccionados;	
}


</script>

</head>
<body>

 <logic:notEmpty name="listaAbo">
	<script>

	//	create the grid object
	var obj = new Active.Controls.Grid;
	var cantidad = matrizAbonados.length;
	var numMaxPaginas = parent.document.getElementById("numMaxPaginas").value;
	
if (matrizAbonados.length > 0) {	
	//	replace the built-in row model with the new one (defined in the patch)
	obj.setModel("row", new Active.Rows.Page);
	obj.setRowProperty("count", cantidad);
    obj.setColumnProperty("count", 3);
	obj.setProperty("data/text", function(i, j){return obtieneData(i,j)});
	obj.setProperty("column/texts", columnas);

	//	set page size
	obj.setProperty("row/pageSize", 17);

    obj.setAction("click",    function(src){
                                           seleccionaAbonado(src.getItemProperty("index"));
                               }
                  );  
                      
	//	write grid html to the page
	document.write(obj);
}

	</script>
	
	<!-- bottom page control buttons -->
	<div>
		<button onclick='goToPage(-Infinity)' class="titformularios">&lt;&lt;</button>
		<button onclick='goToPage(-1)' class="titformularios">&lt;</button>
		<span id='pageLabel' class="textoFilasTabla"></span>
		<button onclick='goToPage(1)' class="titformularios">&gt;</button>
		<button  onclick='goToPage(Infinity)' class="titformularios">&gt;&gt;</button>
	</div>

	<!-- button click handler -->
	<script>
	if (matrizAbonados.length > 0) {	
		function goToPage(delta){
			var count = obj.getProperty("row/pageCount");
			var number = obj.getProperty("row/pageNumber");
			number += delta;
			if (number < 0) {number = 0}
			if (number > count-1) {number = count-1}
			document.getElementById('pageLabel').innerHTML = "Page " + (number + 1) + " of " + count + " ";
	
			obj.setProperty("row/pageNumber", number);
			obj.refresh();
		}
	
		goToPage(0);
	}		
	</script>
 </logic:notEmpty>
 
</body>
</html:html>