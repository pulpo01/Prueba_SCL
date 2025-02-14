
//---------------------------------------------------------------------------------------------------

function cargaComboModalidadPago(tipoContrato)  {
	
	var pos = document.getElementById("comboTipoContrato").selectedIndex;
	
	var userName = document.getElementById("nombreUsuario").value;
	var numAbonado = document.getElementById("numeroAbonado").value;
	
	RestitucionEquipoDWR.obtenerModalidadPago(	tipoContrato, 
												userName,
												numAbonado,
												callbackModalidadPago);
													
													
}	// cargaEquipos()

function callbackModalidadPago(data)	{
	
	if(data != null){
		
		if (data.length > 0)	{
		
			DWRUtil.removeAllOptions("comboModalidadPago");
			DWRUtil.addOptions("comboModalidadPago",{'':'Seleccione Modalidad de Pago'});
			DWRUtil.addOptions("comboModalidadPago", data, "shoCodModVenta", "strDesModVenta");
		}else{
			DWRUtil.removeAllOptions("comboModalidadPago");
			DWRUtil.addOptions("comboModalidadPago",{'':'Seleccione Modalidad de Pago'});
			alert("No existe modalidad de pago para las condiciones de venta indicadas.");
		}
	}
	
	
} // callbackTiposContrato

//---------------------------------------------------------------------------------------------------


function cargaComboCuota(codModPago)  {
	
	var pos = document.getElementById("comboCoutas").selectedIndex;
	
	var userName = document.getElementById("nombreUsuario").value;
	
	RestitucionEquipoDWR.obtenerCuota(	codModPago, 
										userName,
										callbackCuotas);
													
													
}	// cargaEquipos()

function callbackCuotas(data)	{

	if(data != null){
		if(data.length > 0)	{
			document.getElementById("comboCoutas").disabled="false";
			DWRUtil.removeAllOptions("comboCoutas");
			DWRUtil.addOptions("comboModalidadPago",{'':'Seleccione Cuota'});
			DWRUtil.addOptions("comboModalidadPago", data, "shoCodCuota", "strDesCuota");
		}else{
			DWRUtil.removeAllOptions("comboCoutas");
			document.getElementById("comboCoutas").disabled="true";
		}
	}else{
		DWRUtil.removeAllOptions("comboCoutas");
		document.getElementById("comboCoutas").disabled="true";

	}
	
	
} // callbackTiposContrato

//---------------------------------------------------------------------------------------------------

function cargaGrillaEquipos(){
	
	generarDivPrincipalDeCarga('#000000',25,1366,450);
	localizarImagenCargando(350, 650);
	
	var userName = document.getElementById("nombreUsuario").value;
	var numAbonado = document.getElementById("numeroAbonado").value;
	var codModVenta = document.getElementById("codModVenta").value;
	var codTipContrato = document.getElementById("codTipContrato").value;
	var numSiniestro = document.getElementById("numSiniestro").value;
	
	miSelectUso = document.getElementById("comboUso");
	miSeleccionUso = miSelectUso.selectedIndex;
	var uso = miSelectUso.options[miSeleccionUso].value;
	
	miSelectArticulo = document.getElementById("comboArticulo");
	miSeleccionArticulo = miSelectArticulo.selectedIndex;
	var articulo = miSelectArticulo.options[miSeleccionArticulo].value;
	
	miSelectBodega = document.getElementById("comboBodega");
	miSeleccionBodega = miSelectBodega.selectedIndex;
	var bodega = miSelectBodega.options[miSeleccionBodega].value;
	
	miSelectEstado = document.getElementById("comboEstado");
	miSeleccionEstado = miSelectEstado.selectedIndex;
	var estado = miSelectEstado.options[miSeleccionEstado].value;	
	
	RestitucionEquipoDWR.obtenerEquipos(	userName, 
											numAbonado,
											numSiniestro,
											codModVenta,
											codTipContrato,
											uso,
											articulo,
											bodega,
											estado,
											callbackListaEquipos);
	
}

function callbackListaEquipos(jsonData){
	
	var myJSONObject = eval("(" + jsonData + ")");
	equiposdiv = document.getElementById('listaEquipos');
	var salida = "<table width='650px' border='0' Style='margin-left:340px'>";
	
	jsonData = jsonData.replace(/^\s*|\s*$/g,"");

	if(jsonData == '{"listaEquipos": [\r\n]}'){
		
		alert("No Existen Series para los parámetros seleccionados");
		ocultarDivPrincipalDeCarga();
		
	}else{
			
		for(i=0;i<myJSONObject.listaEquipos.length;i++){
				
			//si es valor es nulo es reempladado po "-"
			if(myJSONObject.listaEquipos[i].desStock == "null")
				myJSONObject.listaEquipos[i].desStock = "-";
				
//			if(myJSONObject.listaEquipos[i].numSerie == "null")
//				myJSONObject.listaEquipos[i].desStock = "-";
				
			if(myJSONObject.listaEquipos[i].numSerieMec == "null")
				myJSONObject.listaEquipos[i].numSerieMec = "-";
				
			if(myJSONObject.listaEquipos[i].tipTerminal == "null")
				myJSONObject.listaEquipos[i].tipTerminal = "-";
					
			salida += "<tr>";
			salida += "<td width='28px'><input type='radio' name='strNumSerie' value='"+myJSONObject.listaEquipos[i].numSerie+"' onclick='cargaNumSerie(this.value)'></td>";
			salida += "<td width='128px'>"+myJSONObject.listaEquipos[i].desStock+"</td>";
			salida += "<td width='153px'>"+myJSONObject.listaEquipos[i].numSerie+"</td>";
			salida += "<td width='190px'>"+myJSONObject.listaEquipos[i].numSerieMec+"</td>";
			salida += "<td width='100px'>"+myJSONObject.listaEquipos[i].tipTerminal+"</td>";
			salida += "</tr>";
					
		}
			
		ocultarDivPrincipalDeCarga();
	}
		
	salida += "</tr></table>";
	//alert(salida);
	equiposdiv.innerHTML = salida;
	
	
}

//---------------------------------------------------------------------------------------------------

function desbloqueaVendedor(){
	
	RestitucionEquipoDWR.desbloqueaVendedor(callbackDesbloqueaVendedor);
	
}
