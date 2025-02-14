function openwindowDireccion(){
	var urlPath=document.getElementById("contextPathSS911CorreoFax");
			var url = urlPath.value;
			  url = url+"/switch.do?page=/pages/direccion/direccion.jsp&prefix=/direcciones";
			  //url = url+"/switch.do?page=/DireccionesAction.do&amp;prefix=/direcciones" />
			//<!--forward name=OOSS-0005-1 path=/switch.do?page=/ServiciosSuplementariosAction.do&amp;prefix=/serviciosSup -->
			
			alert("::::::"+url);
			var ReturnedValue = window.showModalDialog(url, "winDireccion", "dialogHeight:400px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
			if(ReturnedValue ==null ||ReturnedValue=="" || ReturnedValue=="NO"){
				alert("No ha ingresado ninguna direcci&oacuten \nSi continúa la información podría quedar inconsistente.");
				window.close();
			}
}

	function display()
	{
		var show911=document.getElementById("div911");
		var codSevSS=new String(document.getElementById("codServicioSS").value);
		var v911=new String("911");
		
		if (codSevSS.toString()==v911.toString())
		{
			show911.style.display="inline";
		}
		else
		{
			alert ("ocultar estilo");
		}
	}
	
	function cleanCampos()
	{
		document.getElementById("nombreContacto").value="";
		document.getElementById("apellido1Contacto").value="";
		document.getElementById("apellido2Contacto").value="";
		document.getElementById("numContacto").value="";
		document.getElementById("parentesco").value="";
		//document.getElementById("codTipDireccion").index="-1";
		document.getElementById("codDireccion").value="";
		document.getElementById("placaVehicular").value="";
		document.getElementById("anioVehiculo").value="";
		document.getElementById("colorVehiculo").value="";
		document.getElementById("observacion").value="";
	}
	
	
	
	function disabledCampos()
	{
		document.getElementById("nombreContacto").disabled=!document.getElementById("nombreContacto").disabled;
		document.getElementById("apellido1Contacto").disabled=!document.getElementById("apellido1Contacto").disabled;
		document.getElementById("apellido2Contacto").disabled=!document.getElementById("apellido2Contacto").disabled;
		document.getElementById("numContacto").disabled=!document.getElementById("numContacto").disabled;
		document.getElementById("parentesco").disabled=!document.getElementById("parentesco").disabled;
		//document.getElementById("codTipDireccion").index="-1";
		document.getElementById("codDireccion").disabled=!document.getElementById("codDireccion").disabled;
		document.getElementById("placaVehicular").disabled=!document.getElementById("placaVehicular").disabled;
		document.getElementById("anioVehiculo").disabled=!document.getElementById("anioVehiculo").disabled;
		document.getElementById("colorVehiculo").disabled=!document.getElementById("colorVehiculo").disabled;
		document.getElementById("observacion").disabled=!document.getElementById("observacion").disabled;
	}
	
	function eventsBotones(presiono){
		
		
		var btnPresiono=presiono.id;
	
		
		if (btnPresiono=="Ingresar")
		{
			if (existeInfo())
			{
				agregarFila();
			}
		}
		
		if (btnPresiono=="Eliminar")
		{
			eliminarFila();
		}
	
	}
	
	
	function agregarFila(){
		var tHeadListar=document.getElementById("idTHeadListar")
		var tBodyListar=document.getElementById("idTBodyListar");
		var indexUltimo= tBodyListar.rows.length ;
		var row = tBodyListar.insertRow(indexUltimo);  
		// insert table cells to the new row  

		
		try
		{	
			
			for (var i=0; i<tHeadListar.rows[0].cells.length; i++)  
			{
				row.insertCell(i); 			
			}
			contContactos=contContactos++;
			pintarRegistro(row,contContactos);
		}
		catch(e)
		{
			alert("método agregarFila [" + e.name + " - "+e.message + "]");
		}
		
	}
	
	function existeInfo()
	{
		var retValue=true;
		try
		{
			var object=document.getElementById("nombreContacto");
			
			var nombreContacto=object==null?"":object.value;
			
			object=document.getElementById("apellido1Contacto");
			var apellido1Contacto=object==null?"":object.value;
			
			object=document.getElementById("apellido2Contacto");
			var apellido2Contacto=object==null?"":object.value;
			
			object=document.getElementById("parentesco");
			var parentesco=object==null?"":object.value;
			
			object=document.getElementById("numContacto");
			var numContacto=object==null?"":object.value;
			
			object=document.getElementById("codTipDireccion");
			var codTipDireccion=object==null?"":object.value;
			
			object=document.getElementById("codDireccion");
			var codDireccion=object==null?"":object.value;
			
			object=document.getElementById("placaVehicular");
			var placaVehicular=object==null?"":object.value;
			
			object=document.getElementById("colorVehiculo");
			var colorVehiculo=object==null?"":object.value;
			
			object=document.getElementById("anioVehiculo");
			var anioVehiculo=object==null?"":object.value;
			
			object=document.getElementById("observacion");
			var observacion=object==null?"":object.value;
			
			if (nombreContacto==""&&apellido1Contacto==""&&apellido2Contacto==""&&parentesco==""&&
				numContacto==""&&codTipDireccion==""&&codDireccion==""&&placaVehicular==""&&
				colorVehiculo==""&&anioVehiculo==""&&observacion=="")
				{
					retValue=false;
					alert("Debe ingresar información en algún campo");
					
				}
		}
		catch(e)
		{
			alert("método existeInfo [" + e.name + " - "+e.message + "]");
		}
		return retValue;
	}
	
	
	
	function pintarRegistro(row,indexUltimo)
	{
	  try
	  {	
		var tBodyListar=document.getElementById("idTBodyListar");
		row.cells[0].innerHTML="<input type=checkbox id="+indexUltimo+" align=middle onclick=checkFila();>";
		row.cells[1].innerHTML=document.getElementById("nombreContacto").value;
		row.cells[2].innerHTML=document.getElementById("apellido1Contacto").value +" "+document.getElementById("apellido2Contacto").value;
		row.cells[3].innerHTML=document.getElementById("parentesco").value;
		row.cells[4].innerHTML=document.getElementById("numContacto").value;
		row.cells[5].innerHTML=document.getElementById("codTipDireccion").value;
		row.cells[6].innerHTML=document.getElementById("codDireccion").value;
		row.cells[7].innerHTML=document.getElementById("placaVehicular").value;
		row.cells[8].innerHTML=document.getElementById("colorVehiculo").value;
		row.cells[9].innerHTML=document.getElementById("anioVehiculo").value;
		row.cells[10].innerHTML=document.getElementById("observacion").value;
		
		cleanCampos();
		setBackgroundFilas(tBodyListar);
	  }
	  catch(e)
	  {
	  	alert("método pintarRegistro [" + e.name + " - "+e.message + "]");
	  }
	}
	
	function checkFila()
	{
		var tBodyListar=document.getElementById("idTBodyListar");
		var rows=tBodyListar.rows;
		try
		{
		
			for (var i=2;i<rows.length;i++)
			{
				if (rows[i].cells[0].childNodes[0].checked)
				{
					rows[i].style.backgroundColor="#EBE9DC";
					rows[i].style.fontColor="#000000";
				}
				else
				{
					rows[i].style.backgroundColor="";
					rows[i].style.fontColor="#EBE9DC";
				}	
			
			}
			 setDataEnForm();
		}
		catch(e)
		{
			alert("método checkFila [" + e.name + " - "+e.message + "]");
		}
	}
	
	function eliminarFila()
	{
	  try
	  {	
	 var tBodyListar=document.getElementById("idTBodyListar");
		var rows=tBodyListar.rows;
		
		if (rows.length!=null&&rows.length>0)
		{
			for(var i=2;i<rows.length;i++)
			{	
					if (rows[i].cells[0].childNodes[0].type=="checkbox")
					{
						if(rows[i].cells[0].childNodes[0].checked)
						{
							tBodyListar.deleteRow(i);
							eliminarFila();
						} 
					}	
			}
			
			setBackgroundFilas(tBodyListar);
		}
	  }
	  catch(e)
	  {
	  		alert("método eliminarFila [" + e.name + " - "+e.message + "]");
	  }	
	}
	
	function setDataEnForm(){
		 var tBodyListar=document.getElementById("idTBodyListar");
		 var rows=tBodyListar.rows;
		 var cells;
		 
		try{
			if (rows.length!=null&&rows.length>0)
			{
				for(var i=2;i<rows.length;i++)
				{	
					cells = rows[i].cells;
					for (var j=1;j<cells.length;j++)
					{
						//alert(":"+j+"::"+cells[j].innerHTML);
					}	
				}
			}
		}
		catch(e)
		{
			alert("método setDataEnForm [" + e.name + " - "+e.message + "]");
		}
	}
	
	function setBackgroundFilas(table)
	{
	 try
		{
			for(k=1;k<table.rows.length;k++)
			{
				if(k%2==0)
					{
						table.rows[k].className = 'textoFilasColorTabla';
					}
					else
					{
						table.rows[k].className = 'textoFilasTabla';
					}
				}
			}
			catch(e)
			{
				impAlert(e.name + " - "+e.message+" En setBackgroundFilas()");
			}
	}
	
	function onlyInteger()
	{
		var keyASCII;
		var strNumber = new String(event.srcElement.value);
		keyASCII = window.event.keyCode;
		if( keyASCII != 13 && keyASCII != 75 && keyASCII < 48 || keyASCII > 57 ) //  And Not IsNumeric(Chr(CodAsc)) )
		{
		   window.event.keyCode = '';
		}
	}
	function showFax()
	{
		var urlPath=document.getElementById("contextPathSS911CorreoFax");
			var url = urlPath.value;
			  url = url+"/switch.do?page=/pages/direccion/direccion.jsp&prefix=/direcciones";
			 
			var ReturnedValue = window.showModalDialog(url, "winDireccion", "dialogHeight:400px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
			if(ReturnedValue ==null ||ReturnedValue=="" || ReturnedValue=="NO"){
				alert("No ha ingresado ninguna direcci&oacuten \nSi continúa la información podría quedar inconsistente.");
				window.close();
			}
	}
	