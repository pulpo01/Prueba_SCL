	// --------------------------------------------------------------------------------------------------------------
	
	function limpiarFormulario() {
		
		document.forms[0].apellido.value = "";
		document.forms[0].apellido2.value = "";		
		document.forms[0].nombre.value = "";
		document.forms[0].parentesco.value = "";
		document.forms[0].telefono.value = "";
		document.forms[0].placa.value = "";
		document.forms[0].color.value = "";
		document.forms[0].anio.value = "";
		document.forms[0].direccion.value = "";
		document.forms[0].telefono.value = "";
		
		document.getElementById("btnAgregar").disabled=false;
		document.getElementById("btnModificar").disabled=true;

	} // limpiarFormulario
	
	// --------------------------------------------------------------------------------------------------------------
	
	function existeContacto()	{
	
		for (var filaArray=0; filaArray < arrayContactos.length; filaArray++)
			if (arrayContactos[filaArray].placa == document.forms[0].placa.value) return true;

		return false;
					
	} // existeContacto
	
	// --------------------------------------------------------------------------------------------------------------
	
	function validarRequeridos()	{
		
		var tel = "";
		tel = document.forms[0].telefono.value;
		
		if ((document.forms[0].apellido.value == "" || document.forms[0].nombre.value == "")) return "Deben el nombre y apellido del contacto.";
		if (isNaN(parseInt(document.forms[0].anio.value))) return "El año del vehículo debe ser un número mayor de 1900.";

		if (tel.length > 0)	{
			if (isNaN(parseInt(tel))) return "El teléfono debe ser un valor numérico.";
			if (tel.length > icgLargoNumTelefono) return "El teléfono no puede contener mas de " + icgLargoNumTelefono + " números.";
		} // if
		
		if (existeContacto()) return "Ya existe un contacto con la misma placa de vehículo.";
		if (document.forms[0].direccion.value == "") return "Deben ingresarse la dirección del contacto.";
		
		return "";
		
	} // validarRequeridos
	
	// --------------------------------------------------------------------------------------------------------------
	
	function agregarContacto()	{
		
		if (flgModificar != "SI")	
			if (parseInt(window.dialogArguments.cantidad) < parseInt(arrayContactos.length)+1)	{
				alert("No puede ingresarse mas contactos.");
				return;
			} // if
		
		var mensaje = validarRequeridos();
		if (mensaje == "")	{
			var tabla = document.getElementById("listaContactos").getElementsByTagName("TBODY")[0];
			var td = document.createElement("TD");	//agrega td a la fila

			// Total de filas menos el encabezado
			agregarFilaTabla("listaContactos");
			var fila = obtieneUltimaFilaTabla("listaContactos");
			
			var contacto = new Object();
			contacto.apellido = document.forms[0].apellido.value.toUpperCase();
			contacto.apellido2 = document.forms[0].apellido2.value.toUpperCase();
			contacto.nombre = document.forms[0].nombre.value.toUpperCase();
			contacto.parentesco = document.forms[0].parentesco.value.toUpperCase();
			contacto.telefono = document.forms[0].telefono.value.toUpperCase();
			contacto.placa = document.forms[0].placa.value.toUpperCase();
			contacto.color = document.forms[0].color.value.toUpperCase();
			contacto.anio = document.forms[0].anio.value.toUpperCase();
            contacto.direccion = document.forms[0].direccion.value.toUpperCase();
            contacto.codServicio = this.codServicio;
            contacto.numcontacto = parseInt(arrayContactos.length)+1;
           

            // Si se ha elegido alguna direccion nueva
            if (arrayCodigos != null)	{
				contacto.codProvincia  = obtieneCodigoAtributo("COD_PROVINCIA");
				contacto.codRegion  = obtieneCodigoAtributo("COD_REGION");
				contacto.codCiudad  = obtieneCodigoAtributo("COD_CIUDAD");
				contacto.codComuna  = obtieneCodigoAtributo("COD_COMUNA");
				contacto.nomCalle  = obtieneCodigoAtributo("NOM_CALLE");
				contacto.numCalle = obtieneCodigoAtributo("NUM_CALLE");
				contacto.obsDireccion  = obtieneCodigoAtributo("OBS_DIRECCION");
				contacto.desDirec1  = obtieneCodigoAtributo("DES_DIREC1");
				contacto.desDirec2  = obtieneCodigoAtributo("DES_DIREC2");				
				contacto.numPiso  = obtieneCodigoAtributo("NUM_PISO");
				contacto.numCasilla = obtieneCodigoAtributo("NUM_CASILLA");
				contacto.codPueblo = obtieneCodigoAtributo("COD_PUEBLO");
				contacto.codEstado = obtieneCodigoAtributo("COD_ESTADO");
				contacto.zip  = obtieneCodigoAtributo("ZIP");
				contacto.codTipoCalle  = obtieneCodigoAtributo("COD_TIPOCALLE");             
				contacto.codDireccion  = 0;
            } // if
            
			this.arrayContactos.push(contacto);
			agregarColumnaEnlace(	fila, 
									contacto.apellido + " " + contacto.nombre, 
									"cargaContacto", cuantasFilasSinEncabezado("listaContactos")
								);
			agregarColumnaTexto(fila, contacto.telefono);
			agregarColumnaTexto(fila, contacto.placa);
			agregarColumnaEnlace(	fila, 
									"[borrar]", 
									"eliminaContacto", cuantasFilasSinEncabezado("listaContactos")
								);
			limpiarFormulario();									
		} // if
		else
			alert(mensaje);
			
	} // agregarContacto

	// --------------------------------------------------------------------------------------------------------------

	function cargaContacto(fila)	{ 


		document.forms[0].apellido.value = arrayContactos[fila].apellido;
		document.forms[0].apellido2.value = arrayContactos[fila].apellido2;
		document.forms[0].nombre.value = arrayContactos[fila].nombre;
		document.forms[0].telefono.value = arrayContactos[fila].telefono;
		document.forms[0].placa.value = arrayContactos[fila].placa;
		document.forms[0].color.value = arrayContactos[fila].color;
		document.forms[0].anio.value = arrayContactos[fila].anio;
		document.forms[0].direccion.value = arrayContactos[fila].direccion;
		

		// selecciona el parentesco en el listbox
		selectListParentesco(arrayContactos[fila].parentesco);

		document.getElementById("btnAgregar").disabled=true;
		document.getElementById("btnModificar").disabled=false;
		
		filaAModificar = fila;
		
	} // cargaContacto

	// --------------------------------------------------------------------------------------------------------------


	function modificarContacto()	{
	
		arrayContactos[filaAModificar].apellido = document.forms[0].apellido.value;
		arrayContactos[filaAModificar].apellido2 = document.forms[0].apellido2.value;		
		arrayContactos[filaAModificar].nombre = document.forms[0].nombre.value;
		var indice = document.forms[0].parentesco.selectedIndex;
		arrayContactos[filaAModificar].parentesco = document.forms[0].parentesco.options[indice].value;
		arrayContactos[filaAModificar].telefono = document.forms[0].telefono.value;
		arrayContactos[filaAModificar].placa = document.forms[0].placa.value;
		arrayContactos[filaAModificar].color = document.forms[0].color.value;
		arrayContactos[filaAModificar].anio = document.forms[0].anio.value;
		arrayContactos[filaAModificar].telefono = document.forms[0].telefono.value;
		arrayContactos[filaAModificar].direccion = document.forms[0].direccion.value;
		
		if (arrayCodigos != null)
			if (arrayCodigos.length > 0)	{ 
				arrayContactos[filaAModificar].codProvincia = obtieneCodigoAtributo("COD_PROVINCIA");			
				arrayContactos[filaAModificar].codRegion = obtieneCodigoAtributo("COD_REGION");		
				arrayContactos[filaAModificar].codCiudad = obtieneCodigoAtributo("COD_CIUDAD");		
				arrayContactos[filaAModificar].codComuna = obtieneCodigoAtributo("COD_COMUNA");	
				arrayContactos[filaAModificar].nomCalle  = obtieneCodigoAtributo("NOM_CALLE");
				arrayContactos[filaAModificar].numCalle = obtieneCodigoAtributo("NUM_CALLE");
				arrayContactos[filaAModificar].obsDireccion  = obtieneCodigoAtributo("OBS_DIRECCION");
				arrayContactos[filaAModificar].desDirec1  = obtieneCodigoAtributo("DES_DIREC1");
				arrayContactos[filaAModificar].desDirec2  = obtieneCodigoAtributo("DES_DIREC2");				
				arrayContactos[filaAModificar].numPiso  = obtieneCodigoAtributo("NUM_PISO");
				arrayContactos[filaAModificar].numCasilla = obtieneCodigoAtributo("NUM_CASILLA");
				arrayContactos[filaAModificar].codPueblo = obtieneCodigoAtributo("COD_PUEBLO");
				arrayContactos[filaAModificar].codEstado = obtieneCodigoAtributo("COD_ESTADO");
				arrayContactos[filaAModificar].zip  = obtieneCodigoAtributo("ZIP");
				arrayContactos[filaAModificar].codTipoCalle  = obtieneCodigoAtributo("COD_TIPOCALLE");  
				
			} // if
			
		filaAModificar = -1;
	
		limpiarFormulario();
		mostrarContactosTabla();
		
	} // modificarContacto
	
	// --------------------------------------------------------------------------------------------------------------
	
	function obtieneCodigoAtributo(nomAtributo)	{

		for (var fila=0; fila < arrayCodigos.length; fila++)	
			if (arrayCodigos[fila].atributo == nomAtributo) return arrayCodigos[fila].codigo
			
		return "";
		
	} // obtieneValorAtributo
	
	// --------------------------------------------------------------------------------------------------------------
		
	function eliminaContacto(fila)	{ 

		
		if (fila > 0) 
		//--fila;
		
		arrayContactos.splice(fila, 1);
		mostrarContactosTabla();
		limpiarFormulario();
		
	} // eliminaContacto


	// --------------------------------------------------------------------------------------------------------------

	function borraContactosTabla()	{ 

		
		var tabla = document.getElementById("listaContactos").getElementsByTagName("TBODY")[0];			
		try	{
			while (true)	{
				var tr = document.getElementById("listaContactos").rows[1];
				tabla.removeChild(tr);
			} // while
		} // try
		catch(e)	{}
		
	} // borraContactosTabla


	// --------------------------------------------------------------------------------------------------------------

	function mostrarContactosTabla()	{ 

		borraContactosTabla();
		
		if(arrayContactos.length > 0) {
			for (var filaArray=0; filaArray < arrayContactos.length; filaArray++)	{
				var tabla = document.getElementById("listaContactos").getElementsByTagName("TBODY")[0];
				var td = document.createElement("TD");	//agrega td a la fila

				// Total de filas menos el encabezado
				agregarFilaTabla("listaContactos");
				var fila = obtieneUltimaFilaTabla("listaContactos");
				var apellidos = arrayContactos[filaArray].apellido + " " + arrayContactos[filaArray].apellido2;
				
				agregarColumnaEnlace(	fila, 
										apellidos + " " + arrayContactos[filaArray].nombre, 
										"cargaContacto", cuantasFilasSinEncabezado("listaContactos")
									);
				agregarColumnaTexto(fila, arrayContactos[filaArray].telefono);
				agregarColumnaTexto(fila, arrayContactos[filaArray].placa);
				agregarColumnaEnlace(	fila, 
										"[borrar]", 
										"eliminaContacto", cuantasFilasSinEncabezado("listaContactos")
									);
									
									
			} // for
		}//fin if
		
	} // mostrarContactosTabla
	
	// --------------------------------------------------------------------------------------------------------------	

	function fncIngresarDireccionPersonal()	{
		
		arrayCodigos = showModalDialog(urlComponenteDirecciones, '', "dialogWidth:500px,dialogHeight:400px");	
		muestraStringDireccionPersonal(arrayCodigos);

	} // fncIngresarDireccionPersonal
	
	// --------------------------------------------------------------------------------------------------------------	

	function muestraStringDireccionPersonal(arrayCodigos)	{
		
		if (arrayCodigos != null)	{
			var tmp = "";
			for (var fila=0; fila < arrayCodigos.length; fila++)
				tmp = tmp + arrayCodigos[fila].descripcion + " ";
				
			document.getElementById("direccion").value = tmp;
		} // if
				
	} // muestraStringDireccionPersonal
	
	// --------------------------------------------------------------------------------------------------------------	

	function aceptar()	{
		
		if (flgModificar != "SI")	{
			window.returnValue = arrayContactos; 
			cerrarVentana();
		}
		else	{
			document.getElementById("opcion").value = "grabar";
			array2String();
			document.forms[0].submit();
		}
		
	} // cancelar

	// --------------------------------------------------------------------------------------------------------------	

	function cancelar()	{
		var ok = window.confirm("Está seguro ?");
		if (ok)	cerrarVentana();
	} // cancelar

	// --------------------------------------------------------------------------------------------------------------	

	function cerrarVentana()	{
		window.close();
	} // cerrarVentana
		
	// --------------------------------------------------------------------------------------------------------------	
		
		
	 function inicio() { 
	 	if (flgModificar != "SI")
	  		this.arrayContactos = convertir(window.dialogArguments);
	  	else
	  		this.arrayContactos = cargaContactos();
	  		
	  mostrarContactosTabla();	  
	 } // inicio()

 	
	// --------------------------------------------------------------------------------------------------------------		
	
	 function saveContacts()  {
	   
	   
	    if (window.dialogArguments.cantidad < arrayContactos.length) {
		    var item = new Object();
		    item.nombre = document.formu.contactos.value;
		    arrayContactos.push(item);
 
	      window.returnValue = arrayContactos; 
    	  window.close();
	     }
	     else
    	  alert("No se pueden ingresar mas contactos.");
 
	  } // saveContacts	
	
    // --------------------------------------------------------------------------------------------------------------		
    
     function mostrar()  {
     
	   for (var i=0; i < arrayContactos.length; i++)
	    alert("arrayContactos["+i+"]="+arrayContactos[i].nombre);
	    
	  } // mostrar    
    
	// --------------------------------------------------------------------------------------------------------------		
    
	 function convertir() {

	   var tmp = new Array();
	   if(window.dialogArguments.contactos != null )
	   {
		   for (var i=0; i < window.dialogArguments.contactos.length; i++) 
	    	 tmp.push(window.dialogArguments.contactos[i]);
	   }
	   return tmp;
	   
    } // convertir
    
	// --------------------------------------------------------------------------------------------------------------	
	
	function cargaContactos()	{

	   var tmp = new Array();
	   
	   for (var i=0; i < arrayContactos.length; i++) 	{
		   	var obj = new Object();

			 obj.apellido = arrayContactos[i][0];      
			 obj.nombre = arrayContactos[i][1];        
			 obj.parentesco = arrayContactos[i][2];    
			 obj.telefono = arrayContactos[i][3];	
			 obj.placa = arrayContactos[i][4];         
			 obj.color = arrayContactos[i][5];	        
			 obj.anio = arrayContactos[i][6]; 
			 obj.direccion = arrayContactos[i][7];	
			 obj.codServicio = arrayContactos[i][8];	
			 obj.numcontacto = arrayContactos[i][9];	
			 obj.apellido2 = arrayContactos[i][10];     
			 obj.codDireccion = arrayContactos[i][11]; 
			 obj.codProvincia = arrayContactos[i][12];  
			 obj.codRegion = arrayContactos[i][13];	
			 obj.codCiudad = arrayContactos[i][14];	
			 obj.codComuna = arrayContactos[i][15];     
			 obj.nomCalle = arrayContactos[i][16];      
			 obj.numCalle = arrayContactos[i][17];      
			 obj.numPiso = arrayContactos[i][18];	
			 obj.numCasilla = arrayContactos[i][19];	
			 obj.obsDireccion = arrayContactos[i][20];  
			 obj.desDirec1 = arrayContactos[i][21];     
			 obj.desDirec2 = arrayContactos[i][22];     
			 obj.codPueblo = arrayContactos[i][23];	
			 obj.codEstado = arrayContactos[i][24];     
			 obj.zip = arrayContactos[i][25];		
			 obj.codTipoCalle = arrayContactos[i][26];  			

    	 	tmp.push(obj);
			
			obj=null;
    	} // for

	   return tmp;
		
	} // cargaContactos
	
	
	// --------------------------------------------------------------------------------------------------------------
	
	function selectListParentesco(codParentesco)	{
		for (var indice=0; indice < document.forms[0].parentesco.options.length; indice++)
			if (document.forms[0].parentesco.options[indice].value == codParentesco)	{
				document.forms[0].parentesco.selectedIndex = indice;
				return;
			} // if
		
	} // selectListParentesco()
			
	// --------------------------------------------------------------------------------------------------------------		

	// Convierte el array de contactos en un string para ser parseado luego en el action
	// HGG 22/02/2010
	
	function array200String()	{
		
		var strArray = "";
		//var separadorAtributo =  "|";
		var separadorAtributo =  "','";
		//var separadorObjecto =  "###";
		var separadorIzquierdo =  "['";
		var separadorDerecho =  "']";
		var separadorObjeto =  ",";
			
		if (arrayContactos != null)	{
			var numContacto = 0;
			for (var filaContactos=0; filaContactos < this.arrayContactos.length; filaContactos++)	{
			
				var contacto = new Object();
				numContacto  = 	filaContactos + 1;		
				strArray = strArray + separadorIzquierdo;
				contacto = arrayContactos[filaContactos];	
				strArray = strArray + contacto.apellido + separadorAtributo;
				strArray = strArray + contacto.nombre + separadorAtributo;
				strArray = strArray + contacto.parentesco + separadorAtributo;
				strArray = strArray + contacto.telefono + separadorAtributo;
				strArray = strArray + contacto.placa + separadorAtributo;
				strArray = strArray + contacto.color + separadorAtributo;	
				strArray = strArray + contacto.anio + separadorAtributo;
				strArray = strArray + contacto.codDireccion + separadorAtributo;
				strArray = strArray + contacto.codProvincia + separadorAtributo;
				strArray = strArray + contacto.codRegion + separadorAtributo;
				strArray = strArray + contacto.codCiudad + separadorAtributo;
				strArray = strArray + contacto.codComuna + separadorAtributo;
				strArray = strArray + contacto.nomCalle + separadorAtributo;
				strArray = strArray + contacto.numCalle + separadorAtributo;
				strArray = strArray + contacto.numPiso + separadorAtributo;
				strArray = strArray + contacto.numCasilla + separadorAtributo;
				strArray = strArray + contacto.obsDireccion + separadorAtributo;
				strArray = strArray + contacto.desDirec1 + separadorAtributo;
				strArray = strArray + contacto.codPueblo + separadorAtributo;
				strArray = strArray + contacto.codEstado + separadorAtributo;
				strArray = strArray + contacto.zip + separadorAtributo;
				strArray = strArray + contacto.codTipoCalle + separadorAtributo;
				strArray = strArray + contacto.nomUsuaora + separadorAtributo;
				strArray = strArray + contacto.codServicio + separadorAtributo;
				strArray = strArray + contacto.apellido2 + separadorAtributo;				
				strArray = strArray + separadorDerecho;
				if (filaContactos < this.arrayContactos.length - 1) {
					strArray = strArray + separadorObjeto;
				}
				contacto = 	null;
			} // for
		}
					
		document.getElementById("contactosTabla").value = strArray;
	
	} // str2Array
	
	
	function array2String()	{
	
	var strArray = "";
	var separadorAtributo =  "|";
	var separadorObjecto =  "¬";


	var correlativoContacto = 0;
	//for(var fila=0; fila < arrayContactos.length; fila++)	{
		var contacto = new Object();		
		//contacto = arrayContactos[fila];
		var filaArray = new Array();		
		filaArray = arrayContactos;
		
		if (filaArray)	{
			for (var filaContactos=0; filaContactos < filaArray.length; filaContactos++)	{
				var obj = new Object();	
				obj = filaArray[filaContactos]
				if (obj.apellido && obj.apellido!="")
					strArray = strArray + obj.apellido + separadorAtributo;
				else				
					strArray = strArray + " " + separadorAtributo;

				if (obj.nombre && obj.nombre!="")
					strArray = strArray + obj.nombre + separadorAtributo;
				else				
					strArray = strArray + " " + separadorAtributo;
					
				if (obj.parentesco && obj.parentesco!="")
					strArray = strArray + obj.parentesco + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;

				if (obj.telefono && obj.telefono!="")
					strArray = strArray + obj.telefono + separadorAtributo;				
				else				
					strArray = strArray + " "+ separadorAtributo;
									
				if (obj.placa && obj.placa!="")
					strArray = strArray + obj.placa + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;
				
				if (obj.color && obj.color!="")
					strArray = strArray + obj.color + separadorAtributo;	
				else				
					strArray = strArray + " "+ separadorAtributo;

					
				if (obj.anio && obj.anio!="")
					strArray = strArray + obj.anio + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				

					
				if (obj.direccion && obj.direccion!="")
					strArray = strArray + obj.direccion + separadorAtributo;			
				else				
					strArray = strArray + " "+ separadorAtributo;				

				
				strArray = strArray + obj.codServicio + separadorAtributo;		

				strArray = strArray + obj.numcontacto + separadorAtributo;					
				
				if (obj.apellido2 && obj.apellido2!="")
					strArray = strArray + obj.apellido2 + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;								
				
					strArray = strArray + obj.codDireccion + separadorAtributo;
				
				if (obj.codProvincia && obj.codProvincia!="")
					strArray = strArray + obj.codProvincia + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				

				if (obj.codRegion && obj.codRegion!="")
					strArray = strArray + obj.codRegion + separadorAtributo;				
				else				
					strArray = strArray + " "+ separadorAtributo;		
					
				if (obj.codCiudad && obj.codCiudad!="")
					strArray = strArray + obj.codCiudad + separadorAtributo;				
				else				
					strArray = strArray + " "+ separadorAtributo;

				if (obj.codComuna && obj.codComuna!="")
					strArray = strArray + obj.codComuna + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				

				if (obj.nomCalle && obj.nomCalle!="")
					strArray = strArray + obj.nomCalle + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				
			
				if (obj.numCalle && obj.numCalle!="")
					strArray = strArray + obj.numCalle + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				
				
				if (obj.numPiso && obj.numPiso!="")
					strArray = strArray + obj.numPiso + separadorAtributo;				
				else
					strArray = strArray + " " + separadorAtributo;				

				if (obj.numCasilla && obj.numCasilla!="")
					strArray = strArray + obj.numCasilla + separadorAtributo;				
				else
					strArray = strArray + " " + separadorAtributo;				
				
				if (obj.obsDireccion && obj.obsDireccion!="")
					strArray = strArray + obj.obsDireccion + separadorAtributo;
				else
					strArray = strArray + " " + separadorAtributo;				
					
					
				if (obj.desDirec1 && obj.desDirec1!="")
					strArray = strArray + obj.desDirec1 + separadorAtributo;
				else
					strArray = strArray + " "+ separadorAtributo;

				if (obj.desDirec2 && obj.desDirec2!="")
					strArray = strArray + obj.desDirec2 + separadorAtributo;
				else
					strArray = strArray + " "+ separadorAtributo;					

				if (obj.codPueblo && obj.codPueblo!="")
					strArray = strArray + obj.codPueblo + separadorAtributo;								
				else
					strArray = strArray + " " + separadorAtributo;

				if (obj.codEstado && obj.codEstado!="")
					strArray = strArray + obj.codEstado + separadorAtributo;
				else
					strArray = strArray + " " + separadorAtributo;

				if (obj.zip && obj.zip!="")
					strArray = strArray + obj.zip + separadorAtributo;				
				else
					strArray = strArray + " "+ separadorAtributo;

				if (obj.codTipoCalle && obj.codTipoCalle!="")
					strArray = strArray + obj.codTipoCalle + separadorAtributo;
				else
					strArray = strArray + " "+ separadorAtributo
					
					strArray = strArray +separadorObjecto;				

				correlativoContacto++;
			} // for
		} // if
	//} // for
	document.getElementById("contactosTabla").value = strArray;
} // str2Array
	
	// -----------------------------------------------------------------------------------------------------------------	
	
	