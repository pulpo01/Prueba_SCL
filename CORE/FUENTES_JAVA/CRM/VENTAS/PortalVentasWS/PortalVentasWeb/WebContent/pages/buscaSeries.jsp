<jsp:include page="/nocache.jsp" flush="true"></jsp:include>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/displaytag" prefix="display"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html:html>
<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="/css/mas.css" rel="stylesheet" type="text/css" />
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JBuscaSeriesAJAX.js'></script>
<script>
	
	window.history.forward(1);
	
	function fncInicio() {
		var numeroSerieSel = document.getElementById("numeroSerieSel");
		var codProcedencia = document.getElementById("codProcedencia");
		
		if (numeroSerieSel.value != "" && codProcedencia.value != "") {
			if (codProcedencia.value == "1") {//EXTERNA
				document.getElementById("txtFiltro").value  = numeroSerieSel.value;
			}
		}
		var rdSerieSel = document.getElementById("rdSerieSel");
		if (rdSerieSel != null) {
			document.getElementById("divResultadoBusqueda").style["display"] = "";
		}
		var codProcedencia = document.getElementById("codProcedencia");
		if (codProcedencia.value == "") { //opcion Seleccione
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "none";			
		  	document.getElementById("divFiltroNumero").style["display"] = "none";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;		  	
		    document.getElementById("codCriterioBusqueda").disabled = true;		
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    	
		}
		else if (codProcedencia.value == "1") {//EXTERNA
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "";			
		  	document.getElementById("divFiltroNumero").style["display"] = "";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;
		    document.getElementById("codCriterioBusqueda").disabled = true;
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    			    
		    if (document.getElementById("flgEquipoFijo").value == "1") {
   			    document.getElementById("txtFiltro").value="0";
			    document.getElementById("txtFiltro").disabled = true;
			    document.getElementById("codProcedencia").disabled=true;
		    }	    
		}
		else {
		    document.getElementById("codCriterioBusqueda").disabled = false;
		}
		//limpia serie seleccionada	anteriormente por pantalla
		document.getElementById("numeroSerieSel").value = "";
		fncMostrarFiltros();
		if(document.getElementById("codBodega").value != ""){
			fncObtieneArticulos();
		}
		//document.forms[0].txtFiltro.onpaste = function() { return fncOnPasteValidaNumero();}; 
		//P-CSR-11002 JLGN 14-06-2011
		fncCursorNormal();
	}

	function txtFiltro_onchange(o) {
		ocultarMensajeError();
	}
	
	function fncActDesacControlesProcedencia() {
		//limpia serie seleccionada	anteriormente
		document.getElementById("numeroSerieSel").value ="";
		document.getElementById("txtFiltro").value = "";
			
		var codProcedencia = document.getElementById("codProcedencia");
		if (codProcedencia.value == "") { //opcion Seleccione
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "none";			
		  	document.getElementById("divFiltroNumero").style["display"] = "none";
  			document.getElementById("codCriterioBusqueda").selectedIndex = 0;		  	
		    document.getElementById("codCriterioBusqueda").disabled = true;		
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    
		}
		else if (codProcedencia.value == "1") {//EXTERNA
			document.getElementById("divFiltroBodega").style["display"] = "none";
			document.getElementById("divFiltroArticulo").style["display"] = "";			
		  	document.getElementById("divFiltroNumero").style["display"] = "";
		  	document.getElementById("divResultadoBusqueda").style["display"] = "none";
			document.getElementById("codCriterioBusqueda").selectedIndex = 0;
		    document.getElementById("codCriterioBusqueda").disabled = true;
   			document.getElementById("codArticulo").selectedIndex = 0;
			document.getElementById("divBtnBusqueda").style["display"] = "none";		    			    
		}
		else {
			document.getElementById("divFiltroArticulo").style["display"] = "none";	
			document.getElementById("divFiltroNumero").style["display"] = "none";
		    document.getElementById("codCriterioBusqueda").disabled = false;
		}
	}
	
	function fncMostrarFiltros() {
		 var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
		 
 		 if (!document.getElementById("codCriterioBusqueda").disabled) {
			if (codCriterioBusqueda.value == "" ) {
				document.getElementById("divFiltroBodega").style["display"] = "none";
				document.getElementById("divFiltroArticulo").style["display"] = "none";					  
	  			document.getElementById("divFiltroNumero").style["display"] = "none";
				document.getElementById("divBtnBusqueda").style["display"] = "none";
			}
			else if (codCriterioBusqueda.value == "TE" || codCriterioBusqueda.value == "SE") {
			  	document.getElementById("divFiltroBodega").style["display"] = "none";
				document.getElementById("divFiltroArticulo").style["display"] = "none";				  	
			  	document.getElementById("divFiltroNumero").style["display"] = "";
			  	document.getElementById("txtFiltro").value = "";
  				document.getElementById("divBtnBusqueda").style["display"] = "";
			}
			else if (codCriterioBusqueda.value == "BO") {
				document.getElementById("divFiltroNumero").style["display"] = "none";		  
				document.getElementById("divFiltroBodega").style["display"] = "";
				document.getElementById("divFiltroArticulo").style["display"] = "";
				document.getElementById("divBtnBusqueda").style["display"] = "none";
			}
		}
	}  
	
	function fncBuscar() {
		var codProcedencia = document.getElementById("codProcedencia");
		if (codProcedencia.value == "") {
				alert("Debe Ingresar Procedencia");
				return false;
		}
		if (codProcedencia.value == "0") {
			var codCriterioBusqueda = document.getElementById("codCriterioBusqueda");
			var linkOrigen = document.getElementById("linkOrigen");
			if (codCriterioBusqueda.value == "") {
				alert("Debe Ingresar Criterio de B\u00FAsqueda");
				return false;
			}
			if (codCriterioBusqueda.value == "BO") { //Búsqueda por bodega
				var codBodega = document.getElementById("codBodega");
				var codArticulo = document.getElementById("codArticulo");
				if (codBodega.value == "") {
					//alert("Debe Ingresar Bodega");
					return false;
				}
				if (codArticulo.value == "") {
					//alert("Debe Ingresar Articulo")
					return false;
				}
				var codTipoArticulo = "";
				if (linkOrigen.value == "SIMCARD") {
					codTipoArticulo = "S";
				}
				else {
				 	codTipoArticulo = "E";
				}
				document.body.style.cursor = "wait";	
				//alert("Se obtiene series de bodega");			
				JBuscaSeriesAJAX.obtenerSeriesBodega(codProcedencia.value,codBodega.value,codArticulo.value,codTipoArticulo, fncResultadoObtenerSeries);
			}
			else {
				var txtFiltro = document.getElementById("txtFiltro"); 
				var telefono = null;
				var serie = null;
				var criterio = "";
				if (codCriterioBusqueda.value == "TE") { //Búsqueda por teléfono
					criterio = "Tel\u00E9fono";
					telefono = txtFiltro.value;
					if (isNaN(telefono)) {
						alert("N° de Tel\u00E9fono no válido");
						return false;
					}
				}
				else {
					criterio = "Serie";
					serie = txtFiltro.value;
					if (isNaN(serie)) {
						alert("N° de Serie no válido");
						return false;
					}
				}
				if (txtFiltro.value == "") {
					alert("Debe ingresar " + criterio);
					return false;
				}
				var codTipoArticulo = "";
				if (linkOrigen.value == "SIMCARD") {
					codTipoArticulo = "S";
				}
				else {
				 	codTipoArticulo = "E";
				}
				document.body.style.cursor = "wait";
				document.getElementById("divResultadoBusqueda").style["display"] = "none";
				JBuscaSeriesAJAX.obtenerSeries(codProcedencia.value, telefono, serie, codTipoArticulo, fncResultadoObtenerSeries);			
			}
		}
	}
	
	function fncResultadoObtenerSeries(data) {
		document.body.style.cursor = "auto";
		if (data != null) {
	        var codError = data["codError"];
	        var mensajeError =  data["msgError"];
	        if (codError != "") {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
	        	else {
	        		mostrarMensajeError(mensajeError);
	        		return;
	        	}
	        }
	    	else {
		    	document.getElementById("divResultadoBusqueda").style["display"] = "";
				document.getElementById("numeroSerieSel").value = "";
				document.getElementById("opcion").value = "buscarSerie";
	   			document.forms[0].submit();
	   		}
	    }
	}
	
	function fncValidaSerieExterna(numSerie) {
	  	var tipoProcedencia = document.getElementById("codProcedencia").value;
	  	var serie = document.getElementById("txtFiltro").value;
	  	if (tipoProcedencia == "1") {
			JBuscaSeriesAJAX.validaSerieExterna(serie, fncResultadoValidaSerieExterna);			  
	  	}
	  	else {
	      	var linkOrigen = document.getElementById("linkOrigen");
	    	if (linkOrigen.value == "SIMCARD") {
				document.getElementById("opcion").value = "aceptarSimcard";
			}
			else {
				document.getElementById("opcion").value = "aceptarEquipo";
			}
			document.getElementById("codProcedencia").disabled=false;
	   		document.forms[0].submit();     
	  	}
	}
	
	function fncResultadoValidaSerieExterna(data) {
		if (data != null) {
	        var codError = data['codError']; 
	        var mensajeError = data['msgError']; 
	        if (codError != "" ) {
	        	if (codError == "-100") {
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}
				window.alert(mensajeError);
	        	return;
	        }
	        else {
	        	var linkOrigen = document.getElementById("linkOrigen");
	         	if (linkOrigen.value == "SIMCARD") {
		   	    	document.getElementById("opcion").value = "aceptarSimcard";
		     	}
		     	else {
		  	    	document.getElementById("opcion").value = "aceptarEquipo";
 		     	}
 		     	document.getElementById("codProcedencia").disabled=false;
	   	     	document.forms[0].submit();
	        } 
	    }
	}
	
	function fncSeleccionaSerie(numSerie) {
		document.getElementById("numeroSerieSel").value = numSerie.value;
	}
	
	function fncAceptar() {
		var codProcedencia = document.getElementById("codProcedencia");
		if (codProcedencia!=null && codProcedencia.value == "1") {//externa
			var codArticulo = document.getElementById("codArticulo");
			var filtro = document.getElementById("txtFiltro");
			if (codArticulo.value == "") {
				alert("Debe ingresar Articulo")
				return false;
			}
			var flgEquipoFijo = document.getElementById("flgEquipoFijo");
			if (flgEquipoFijo.value == "1") {
				document.getElementById("numeroSerieSel").value = "0";
			}
			else {
				if (filtro.value == "") {
					alert("Debe ingresar N\u00FAmero de Equipo")
					return false;
				}
				document.getElementById("numeroSerieSel").value = filtro.value;
			}			
		}	
		else {
			var numeroSerieSel = document.getElementById("numeroSerieSel");
			if (numeroSerieSel == null || numeroSerieSel.value == "") {
				alert("Debe seleccionar una serie");
				return false;
			}
		}
		fncValidaSerieExterna(numeroSerieSel);
	} 	
	
	function fncCancelar() {
		document.getElementById("opcion").value = "cancelar";
    	document.forms[0].submit();
	}
	
	function fncVolver() {
		if (confirm("¿Desea volver al men\u00FA?")) {
			var win = parent;
			win.fncActDesacMenu(false);
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	
	function mostrarMensajeError(mensaje) {
	    document.getElementById("mensajes").innerHTML = mensaje; 
	}
	
	function ocultarMensajeError() {
	    document.getElementById("mensajes").innerHTML = ""; 
	}	
	
	function fncInvocarPaginaExpiraSesion() {
    	document.forms[0].submit();
	}
	
	function rdSerieSel_onclick(obj) {
		ocultarMensajeError(); 
		fncSeleccionaSerie(obj);
	}

	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }
    
    //Inicio P-CSR-11002 JLGN 27-06-2011		
    function fncObtieneArticulos(){
    	var linkOrigen = document.getElementById("linkOrigen");
    	if (linkOrigen.value == "SIMCARD") {
    		//Es Simcard
    		var codBodega = document.getElementById("codBodega");		    	
			if (codBodega.value == "") {
				//alert("Debe Ingresar Bodega");
				return false;
			}
	    	JBuscaSeriesAJAX.obtenerArticulos(codBodega.value , fncResultadoObtieneArticulos);    	
    	}else{
    		//Es Terminal
    		var codProcedencia =  document.getElementById("codProcedencia");
	    	if (codProcedencia.value == "1") {//EXTERNA
				JBuscaSeriesAJAX.obtenerArticulos("0" , fncResultadoObtieneArticulos);
			}else{
		    	var codBodega = document.getElementById("codBodega");		    	
				if (codBodega.value == "") {
					//alert("Debe Ingresar Bodega");
					return false;
				}
		    	JBuscaSeriesAJAX.obtenerArticulos(codBodega.value , fncResultadoObtieneArticulos);			
		    }
		}    
    }
    
    function articuloSeleccionado(){
    	document.getElementById("codArticuloSeleccionado").value = document.getElementById("codArticulo").value;
    }
    
    function fncResultadoObtieneArticulos(data){
		if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	if (codError == "-100"){
		        	fncInvocarPaginaExpiraSesion();
	        		return;
	        	}	        
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
			var listaActualizada = data["lista"];
		    DWRUtil.removeAllOptions("codArticulo");
		    DWRUtil.addOptions("codArticulo",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codArticulo",listaActualizada,"codigoArticulo","desArticulo");
		    
		    var codArticuloSelec = document.getElementById("codArticuloSeleccionado").value;
		    
		    if (codArticuloSelec !=""){
			    var codArticulo = document.getElementById("codArticulo");
			    var encontrado = false;
			    for (index = 0; index< codArticulo.length; index++) {
			       	  if (codArticulo[index].value == codArticuloSelec){
			        	codArticulo.selectedIndex = index;
			        	encontrado = true;
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codArticuloSeleccionado").value = ""
		    }
	    }
	}
	
</script>
</head>
<body onload="history.go(+1);fncInicio();" onkeydown="validarTeclas();">
<html:form method="POST" action="/BuscaSeriesAction.do">
	<html:hidden property="opcion" value="inicio" styleId="opcion" />
	<html:hidden property="linkOrigen" styleId="linkOrigen" />
	<html:hidden property="numeroSerieSel" styleId="numeroSerieSel" />
	<html:hidden property="flgEquipoFijo" styleId="flgEquipoFijo" />
	<html:hidden property="codArticuloKIT" styleId="codArticuloKIT" />
	<html:hidden property="codArticuloSeleccionado" styleId="codArticuloSeleccionado" />
	<table width="80%">
		<tr>
			<td class="amarillo">
			<h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15"
				hspace="2" align="left">B&uacute;squeda Series&nbsp;
			</td>
		</tr>
	</table>
	<P>
	<table width="100%" border="0">
		<tr>
			<td class="mensajeError">
			<div id="mensajes" class="mensajeError"><bean:write name="BuscaSeriesForm"
				property="mensajeError" /></div>
			</td>
		</tr>
	</table>
	<P>
	<table width="90%">
		<bean:define id="origen" name="BuscaSeriesForm" property="linkOrigen" />
		<logic:equal name="origen" value="EQUIPO">
			<tr>
				<td width="100%">
				<table width="100%">
					<tr>
						<td width="15%">&nbsp;</td>
						<td align="left" width="25%">Procedencia:</td>
						<td align="left" width="35%"><html:select name="BuscaSeriesForm"
							property="codProcedencia" style="width:200px;" styleId="codProcedencia"
							onchange="ocultarMensajeError();fncActDesacControlesProcedencia();fncObtieneArticulos();">
							<html:option value="">- Seleccione -</html:option>
							<logic:notEmpty name="BuscaSeriesForm" property="arrayProcedencia">
								<html:optionsCollection property="arrayProcedencia" value="codigoParametro"
									label="valorParametro" />
							</logic:notEmpty>
						</html:select></td>
						<td width="25%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</logic:equal>
		<logic:equal name="origen" value="SIMCARD">
			<html:hidden property="codProcedencia" styleId="codProcedencia" />
		</logic:equal>
		<tr>
			<td width="100%">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td align="left" width="25%">Buscar una serie por:</td>
					<td align="left" width="50%"><html:select name="BuscaSeriesForm"
						property="codCriterioBusqueda" style="width:300px;" styleId="codCriterioBusqueda"
						onchange="ocultarMensajeError();fncMostrarFiltros();">
						<html:option value="">- Seleccione -</html:option>
						<html:option value="TE">TELEFONO</html:option>
						<html:option value="SE">SERIE</html:option>
						<html:option value="BO">BODEGA</html:option>
					</html:select></td>
					<td width="25%">&nbsp;</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divFiltroBodega" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Bodega:</td>
					<td align="left" width="50%"><html:select name="BuscaSeriesForm" property="codBodega"
						style="width:300px;" styleId="codBodega" onchange="ocultarMensajeError();fncObtieneArticulos();">	
						<html:option value="">- Seleccione -</html:option>
						<logic:notEmpty name="BuscaSeriesForm" property="arrayBodegas">
							<html:optionsCollection property="arrayBodegas" value="codBodega" label="descBodega" />
						</logic:notEmpty>
					</html:select></td>
					<td width="25%">&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divFiltroArticulo" style="display:none">
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%" align="left">Art&iacute;culo:</td>
					<td align="left" width="50%">
						<html:select name="BuscaSeriesForm" property="codArticulo" style="width:300px;" styleId="codArticulo" onchange="ocultarMensajeError();articuloSeleccionado();fncBuscar();">
						<html:option value="">- Seleccione -</html:option>
						<!--<logic:notEmpty name="BuscaSeriesForm" property="arrayArticulos">
							<html:optionsCollection property="arrayArticulos" value="codArticulo" label="desArticulo" />
						</logic:notEmpty>-->
					</html:select></td>
					<td width="25%">&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<div id="divFiltroNumero" style="display:none">
			<table width="100%">
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<td align="left" width="35%"><html:text name="BuscaSeriesForm" property="txtFiltro"
						size="35" maxlength="25" styleId="txtFiltro" onkeypress="onlyInteger();if(event.keyCode == 13) event.returnValue = false;" onchange="txtFiltro_onchange(this)" /></td>
					<td width="25%">&nbsp;</td>
				</tr>
			</table>
			</div>
			</td>
		</tr>
		<tr>
			<td>
			<table width="100%">
				<tr>
					<td width="15%">&nbsp;</td>
					<td width="25%">&nbsp;</td>
					<td width="35%">&nbsp;</td>
					<td align="left" width="25%">
					<div id="divBtnBusqueda" style="display:none"><html:button value="BUSCAR"
						style="width:120px;color:black" styleId="btnBuscar" property="btnBuscar"
						onclick="fncCursorEspera();ocultarMensajeError();fncBuscar();" /></div>
					</td>
				</tr>
			</table>
			</td>
		</tr>
		<tr>
			<td colspan="4">
			<HR noshade>
			</td>
		</tr>
	</table>
	<P>
	<P>
	<div id="divResultadoBusqueda" style="display: none">
	<h2 align="center">Coincidencias:<br>
	De un click con el puntero del mouse posicionado sobre la fila que desea seleccionar.</h2>
	<br />
	<div style="text-align: center;"><display:table id="series" name="listaSeries"
		scope="session" pagesize="10" requestURI="" width="90%">
		<display:column title="Sel." headerClass="textoColumnaTabla" class="textoFilasColorTabla"
			width="5%">
			<input type="radio" name="rdSerieSel" id="rdSerieSel" onclick="rdSerieSel_onclick(this)"
				value="<bean:write name="series" property="numSerie"/>">
		</display:column>
		<display:column align="center" headerClass="textoColumnaTabla" property="numSerie"
			title="N° de Serie" width="25%" />
		<display:column align="center" property="tipoStock" title="Tipo Stock"
			headerClass="textoColumnaTabla" width="20%" />
		<display:column align="center" property="desUso" title="Uso" headerClass="textoColumnaTabla"
			width="10%" />
		<display:column align="center" property="numTelefono" title="N&uacute;mero Celular"
			headerClass="textoColumnaTabla" width="20%" />
		<display:column align="center" property="fecha" title="Fecha" headerClass="textoColumnaTabla"
			width="20%" />
	</display:table></div>
	</div>
	<br />
	<br />
	<TABLE cellSpacing="0" cellPadding="0" width="80%" border="0" align="center">
		<tr>
			<td width="50%"></td>
			<td align="right" width="25%"><html:button value="CANCELAR" style="width:120px; color:black" styleId="btnCancelar"
				property="btnCancelar" onclick="fncCursorEspera();ocultarMensajeError(); fncCancelar()" /></td>
			<td align="right" width="25%"><html:button value="ACEPTAR" style="width:120px; color:black" styleId="btnAceptar"
				property="btnAceptar" onclick="fncCursorEspera();ocultarMensajeError(); fncAceptar();" /></td>
		</tr>
	</TABLE>
</html:form>
</body>
</html:html>
