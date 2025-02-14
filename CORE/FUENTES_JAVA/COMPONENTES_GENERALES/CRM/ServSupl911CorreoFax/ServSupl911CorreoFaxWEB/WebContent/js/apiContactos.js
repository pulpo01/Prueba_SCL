	// --------------------------------------------------------------------------------------------------------------

	function cuantasFilasSinEncabezado(tabla)	{
	
		return parseInt(document.getElementById(tabla).rows.length)-filasEncabezado;
		
	}	// cuantasFilasSinEncabezado

	// --------------------------------------------------------------------------------------------------------------
	
	function cuantasFilasConEncabezado(tabla)	{
	
		return parseInt(document.getElementById(tabla).rows.length);
		
	}	// cuantasFilasSinEncabezado
	
	// --------------------------------------------------------------------------------------------------------------

	function obtieneUltimaFilaTabla(tabla)	{
	
		var cantFilas = cuantasFilasConEncabezado(tabla)-1;
		return document.getElementById(tabla).rows[cantFilas];
		
	}	// cuantasFilasSinEncabezado
	
	// --------------------------------------------------------------------------------------------------------------

	function agregarFilaTabla(tabla)	{
	
		var tabla = document.getElementById(tabla).getElementsByTagName("TBODY")[0];
		var tr = document.createElement("TR"); 	//crea la nueva fila
		tabla.appendChild(tr); 					//agrega fila a la tabla
		
	}	// cuantasFilasSinEncabezado
	
	// --------------------------------------------------------------------------------------------------------------

	function agregarColumnaTexto(fila, texto)	{
	
		var td = document.createElement("TD");	//agrega td a la fila
		td.appendChild(document.createTextNode(texto)); 
		fila.appendChild(td);
		
	}	// agregarColumnaTexto
	
	// --------------------------------------------------------------------------------------------------------------

	function agregarColumnaEnlace(fila, texto, funcion, param)	{
		var td = document.createElement("TD");	//agrega td a la fila

		var url=document.createElement('A'); 
		url.href = "javascript:" + funcion + "('" + param + "')";
		url.appendChild(document.createTextNode(texto)); 
		td.appendChild(url);

		fila.appendChild(td);
							
	}	// agregarColumnaEnlace
	// --------------------------------------------------------------------------------------------------------------
