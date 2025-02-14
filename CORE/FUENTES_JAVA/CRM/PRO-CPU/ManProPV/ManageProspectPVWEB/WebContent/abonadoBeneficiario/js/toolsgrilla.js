function agregarFilaATabla(initTabla,rw)
{
  initTabla.appendChild(rw);
}

function agregarColumnaAFila(rw,columna)
{
	rw.appendChild(columna);
}

function agregarHTMLAColumna(columna,varhtml)
{
	columna.innerHTML=varhtml;
}

function crearFila()
{	
	try
	{
		return document.createElement('tr'); 
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En crearFila()");
	}
}

function crearColumna()
{
	try
	{
		return document.createElement('td');
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En crearColumna()");
	}
}

function nuevaTabla()
{
	try
	{
		return document.createElement('tbody');
	}
	catch(e)
	{
		alert(e.name + " - "+e.message+" En nuevaTabla()");
	}
}

function borrarFilasDesde(cuerpoTabla,index)
{
	for(i=(cuerpoTabla.rows.length-1);i>index;i--)
	{
		cuerpoTabla.deleteRow(i);
	}
}

function quitarFilaDeTabla(cuerpoTabla,filaIndex)
{ 	
	 if(cuerpoTabla.rows.length>0)
	 {
		cuerpoTabla.deleteRow(filaIndex);
	 }
	 else
		alert("No existe fila a eliminar");
}

function buscarEnTabla(cuerpoTabla,texto,numColumnaBusqueda)
{	
	var fila;
	var columna;
	var item;
	
	texto=texto.toLowerCase();		

	if(numColumnaBusqueda!="")
	{
		for(i=0;i<cuerpoTabla.rows.length;i++)
		{
			fila=cuerpoTabla.getElementsByTagName("tr").item(i);				
			columna=fila.getElementsByTagName("td").item(new Number(numColumnaBusqueda));
			item=columna.innerHTML;
			item=item.toLowerCase();
			
			if(texto.length<=item.length && item.indexOf(texto)!="-1" && texto!="")		
			{
				fila.style["display"]="";
			}
			else
			{
				fila.style["display"]="none";
			}
		}
	}
	else
	{
		alert("Debe seleccionar un tipo de busqueda");
	}
}

function buscarEnTablaMultiplesColumnas(cuerpoTabla,texto,arrayNumColumnas)
{	
	var fila;
	var columna;
	var item;
	
	texto=texto.toLowerCase();		

	if(arrayNumColumnas.length && arrayNumColumnas.length>0)
	{
		for(i=0;i<cuerpoTabla.rows.length;i++)
		{
			fila=cuerpoTabla.getElementsByTagName("tr").item(i);	
			
			for(j=0;j<arrayNumColumnas.length;j++)
			{
				columna=fila.getElementsByTagName("td").item(new Number(arrayNumColumnas[j]));
				item=columna.innerHTML;
				item=item.toLowerCase();
			
				if(texto.length<=item.length && item.indexOf(texto)!="-1" && texto!="")		
				{
					fila.style["display"]="";
					break;
				}
				else
				{
					fila.style["display"]="none";
				}
			}
			
		}
	}
	else
	{
		alert("Debe seleccionar un tipo de busqueda");
	}
}
