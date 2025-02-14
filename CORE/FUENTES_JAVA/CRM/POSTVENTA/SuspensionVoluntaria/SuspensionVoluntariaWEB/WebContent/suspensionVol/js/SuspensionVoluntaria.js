
var flagOperacion = "programar";
var gifRolloverOn = "../suspensionVol/botones/btn_programar_roll.gif";
var gifRolloverOff = "../suspensionVol/botones/btn_programar.gif";

// En caso de modificacion, el nuevo numero de dias debe ser <= que el viejo.
var cantDiasAnterior = 0;
// Indice actual selecccionado de la grilla
var indexGrilla = 0;
var anularSuspensionMensaje = "Está seguro de anular esta suspensión?";

// -----------------------------------------------------------------------------------------------------------------------------     	
	
	function clickGrilla(index, operacion)	{
        
        try	{       
        	indexGrilla = index;             
	        var fecSolicitud,fecSuspension,fecRehabilitacion,causaSuspension = new String();
	        
	        document.getElementById("indiceAnular").value = parseInt(index)-1;
	        
	        fecSolicitud 	= getCellByRowCol("tablaSuspensiones", index, 1);
			fecSuspension 	= getCellByRowCol("tablaSuspensiones", index, 2);
	        fecRehabilitacion = getCellByRowCol("tablaSuspensiones", index, 3);
			causaSuspension	= getCellByRowCol("tablaSuspensiones", index, 4);
			cantDiasFila	= getCellByRowCol("tablaSuspensiones", index, 6);
			
	        document.forms[0].fecSolicitud.value = fecSolicitud;
			document.forms[0].fecRehabilitacion.value = fecRehabilitacion;	        
			
			buscaDescripcion(fecSuspension, document.forms[0].fecSuspension);
			buscaDescripcion(causaSuspension, document.forms[0].causaSuspension);
			
			// Lo muestro en el textbox
			document.forms[0].cantDias.value = cantDiasFila;
			
			// Se almacenan la cantidad de dias original para ver si han cambiando
        	document.getElementById("flagOOSSCambiada").value = document.forms[0].cantDias.value;
			
			cantDiasAnterior = parseInt(document.forms[0].cantDias.value);
			if (operacion == "modificar")	{
				// Cambio el boton
				document.getElementById("botonOperacion1").src = "../suspensionVol/botones/btn_modificar.gif";
				document.getElementById("botonOperacion2").src = "../suspensionVol/botones/btn_modificar.gif";

				gifRolloverOn = "../suspensionVol/botones/btn_modificar_roll.gif";
				gifRolloverOff = "../suspensionVol/botones/btn_modificar.gif";
				
				flagOperacion = "modificar";
				
				deshabilitaControles(flagOperacion);
			} // if
			else
				if (operacion == "anular")	{
					flagOperacion = "anular";
					if (!anulaSuspension())	
						limpiar("todo");
					else
						enviar();
				} // if
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función clickGrilla().");
		} // catch		
				
	}  // clickGrilla
	
// -----------------------------------------------------------------------------------------------------------------------------     	
	
	function calculaDias()	{

		try	{
			diasSusp = document.forms[0].cantDias.value;

			if (trim(diasSusp).length == 0) {
				limpiar("parte");
				return;			
			} // if

			
			var indice = document.forms[0].fecSuspension.selectedIndex;
			var fecha = document.forms[0].fecSuspension.options[indice].text;
			respuesta = new Array();
		
			// Validacion dias es numerico
			if (isNumber(diasSusp))	{

				// Debe estar seleccionada alguna fecha de suspension
				if (fecha == "" )	{
					alert("Debe seleccionar una fecha de suspensión. ");
					rollback();
					return;
				}  // if

				if ((parseInt(cantDiasAnterior) != 0) && (parseInt(diasSusp)>parseInt(cantDiasAnterior)))	{
					// Fecha de suspension en formato date
					anio = parseInt(fecha.substr(6,4));

					if (parseInt(fecha.substr(3,2)) > 0)
						mes = parseInt(fecha.substr(3,2))-1;
					else
						mes = parseInt(fecha.substr(4,1))-1;

					if (parseInt(fecha.substr(0,2)) > 0)
						dia = parseInt(fecha.substr(0,2));
					else
						dia = parseInt(fecha.substr(1,2));

					// Sumo los dias
					var fecRehaModificada=new Date(anio, mes, dia, 0 , 0, 0);
					var milisegundos=parseInt(parseInt(diasSusp)*24*60*60*1000);
					tiempo = fecRehaModificada.getTime();
					fecRehaModificada.setTime(parseFloat(tiempo+milisegundos));

					// Si esta seteado el horario de verano, le sumo una hora
					if (fecRehaModificada.getHours() == 23)
						fecRehaModificada.setTime(parseFloat(fecRehaModificada.getTime()+1*60*60*1000));
					
					if (!validaFechaRehabilitacion(true, formateaFecha(fecRehaModificada))) return false;
				}  // if

					
				// Validacion dias esta en el rango del parametro
				if ((parseInt(diasSusp) > 0) && (parseInt(diasSusp) <= maxDias))	{

					// Si se programa de deben comprar los dias acumulados
					if (flagOperacion == "programar")	{

						// Validacion dias+acumulados <= dias maximos de prorroga
						respuesta = getDatosPeriodo(fecha);
						if (respuesta.length>0)	
							var cantidadDias = parseInt(diasSusp) + parseInt(respuesta[0][3]);

						if (cantidadDias > maxDias) {
							alert("La cantidad de días solicitados más los días acumulados (" + respuesta[0][3] + ") de suspensión sobrepasan al máximo permitido (" + maxDias +  ").");
							rollback();
							return;
						}  // else
						
					} // if
										

					// Fecha de suspension en formato date
					anio = parseInt(fecha.substr(6,4));

					if (parseInt(fecha.substr(3,2)) > 0)
						mes = parseInt(fecha.substr(3,2))-1;
					else
						mes = parseInt(fecha.substr(4,1))-1;

					if (parseInt(fecha.substr(0,2)) > 0)
						dia = parseInt(fecha.substr(0,2));
					else
						dia = parseInt(fecha.substr(1,2));

					// Sumo los dias
					var fecSuspension=new Date(anio, mes, dia, 0 , 0, 0);
					var milisegundos=parseInt(parseInt(diasSusp)*24*60*60*1000);
					tiempo = fecSuspension.getTime();
					fecSuspension.setTime(parseFloat(tiempo+milisegundos));

					// Si esta seteado el horario de verano, le sumo una hora
					if (fecSuspension.getHours() == 23)
						fecSuspension.setTime(parseFloat(fecSuspension.getTime()+1*60*60*1000));
						
					document.forms[0].fecRehabilitacion.value =  formateaFecha(fecSuspension);

					// ---------------------------------------------------------						
					// Setear el flag de insercion de periodo
					// Si la fecha de rehabilitacion es mayor que el fin de periodo, hay que crear un periodo nuevo
					if (flagOperacion == "programar")	{							
						var difFechas = compararFechas(document.forms[0].fecRehabilitacion.value, respuesta[0][2]);
						if (difFechas == -1)
							document.forms[0].flagCrearPeriodo.value = 1;
						else
							document.forms[0].flagCrearPeriodo.value = 0;
					} // if								
					// ---------------------------------------------------------									
							
					
				} // if					
				else	{
					alert("La cantidad de días de suspensión debe ser un entero mayor que cero y menor o igual a " + maxDias + " días.");
					rollback();
				}  // else
			} // if
			else	{
				alert("La cantidad de días de suspensión debe ser un entero mayor que cero y menor o igual a " + maxDias + " días.");
				rollback();
			} // else
		
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función calculaDias().");
			alert(e.message);
		} // catch
		
				
	} // calculaDias
	
// -----------------------------------------------------------------------------------------------------------------------------

	function buscaDescripcion(texto, comboObj)	{
	
		try	{
			for (var i=0; i < comboObj.length; i++)
				if (texto == comboObj.options[i].text)	{
					comboObj.selectedIndex=i;
					return;
				} // if
					
			document.getElementById("fecSuspension").options[0].text = texto;
			comboObj.selectedIndex=0;
			
			return;
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función buscaDescripcion().");
		} // catch
				
	} // buscaDescripcion
		
// ----------------------------------------------------------------------------------------------------------------------------
	
	function limpiar(opcion)	{
	
		try	{
			var hoy=new Date();
		
			document.forms[0].fecSolicitud.value = formateaFecha(hoy);
	        document.forms[0].fecRehabilitacion.value = "";
			document.forms[0].cantDias.value = "";
			cantDiasAnterior = 0;
			indexGrilla = 0;
			if (opcion == "todo")	{
				document.forms[0].causaSuspension.selectedIndex = 0;
	        	document.forms[0].fecSuspension.value = "";							
	        			
				flagOperacion = "programar";
				gifRolloverOn = "../suspensionVol/botones/btn_programar_roll.gif";
				gifRolloverOff = "../suspensionVol/botones/btn_programar.gif";
		
				document.getElementById("botonOperacion1").src = "../suspensionVol/botones/btn_programar.gif";
				document.getElementById("botonOperacion2").src = "../suspensionVol/botones/btn_programar.gif";
				
				document.getElementById("fecSuspension").options[0].text = "";
				
				if (document.forms[0].radioSel != null)	{
					// Deschequeo los radio buttons
					for(var i=0; i < document.forms[0].radioSel.length; i++){
						document.forms[0].radioSel[i].checked = false;
					}
					if (document.forms[0].radioSel.value=="on"){
						document.forms[0].radioSel.checked = false;
						}
				} // if
								
				deshabilitaControles(flagOperacion);
			} // if			
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función limpiar().");
		} // catch		
		
	} // limpiar
	
// -----------------------------------------------------------------------------------------------------------------------------

	
	function restarFechas(dia1,mes1,ano1,dia2,mes2,ano2)	{
	
		try	{	
			fecha1=new Date(ano1,mes1-1,dia1);
			fecha2=new Date(ano2,mes2-1,dia2);
			 
			var resta=(fecha2-fecha1)/1000/3600/24; 
			return resta;
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función restarFechas().");
		} // catch			 

	} // restarFechas

// -----------------------------------------------------------------------------------------------------------------------------
				
	function formateaFecha(fecha)	{
	
		try	{
			var dia = fecha.getDate();
			if (parseInt(dia) < 10) dia="0"+dia;
			var mes = fecha.getMonth()+1;
			if (parseInt(mes) < 10) mes="0"+mes;
		
			return dia + "/" + mes + "/" + fecha.getYear() ;
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función formateaFecha().");
		} // catch			 
		
	}  // formateaFecha
	
// -----------------------------------------------------------------------------------------------------------------------------

     function isNumber(x) {
    
     	try	{
	         var anum = /(^\d+$)|(^\d+\d+$)/;
	     
	         var testresult;
	         if (anum.test(x))
	             testresult=true;
	         else
	             testresult=false;
	     
	         return (testresult);
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función isNumber().");
		} // catch			 
		         
     }   // isNumber 	
       
// -----------------------------------------------------------------------------------------------------------------------------     
		
	function salir()	{
	
		window.close();
		
	} // salir

// -----------------------------------------------------------------------------------------------------------------------------     	

	
	function submitForm( param )	{

		try	{
			document.getElementById("indexFecSuspension").value = document.getElementById("fecSuspension").selectedIndex;
			document.getElementById("btnSeleccionado").value = param;
			document.getElementById("fecSuspension").disabled = false;
			document.forms[0].fecSuspension.options[0].value = document.forms[0].fecSuspension.options[0].text;	
				
			document.getElementById("causaSuspension").disabled = false;
			
			document.forms[0].submit();		
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función submitForm().");
		} // catch		
			
	} // submitForm

// -----------------------------------------------------------------------------------------------------------------------------     	

	function enviar()	{
	
		try	{
			if (flagOperacion != "anular")	{
				if (validaRequeridos())	
					submitForm(flagOperacion);
			} // if
			else
				submitForm(flagOperacion);
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función enviar().");
		} // catch		
						
	} // enviar	
	
// -----------------------------------------------------------------------------------------------------------------------------     	

	function anulaSuspension()	{

		try	{
			flagOperacion="anular";
			document.getElementById("botonOperacion1").src = "../suspensionVol/botones/btn_anular_roll.gif";
			document.getElementById("botonOperacion2").src = "../suspensionVol/botones/btn_anular_roll.gif";

			var x = confirm(anularSuspensionMensaje);
			if (x) 
				return true;
			else
				return false;
		} // try
		catch(e)	{
			alert("Ha ocurrido un error en la función anulaSuspension().");
		} // catch		
				
	} // anulaSuspension
		
// -----------------------------------------------------------------------------------------------------------------------------     			

	function getCellByRowCol(tablaDatos, rowNum, colNum )	{

		var tableElem = document.getElementById(tablaDatos);
		var rowElem = tableElem.rows[rowNum];
		var tdValue = rowElem.cells[colNum].innerHTML;
		return tdValue;
		
	}  // getCellByRowCol

// -----------------------------------------------------------------------------------------------------------------------------     			

	function compararFechas(dateA, dateB)	{ 
	
		anioFecA = parseInt(dateA.substr(6,4));
		mesFecA = parseInt(dateA.substr(3,2)) < 10? parseInt(dateA.substr(4,1)):parseInt(dateA.substr(3,2));
		diaFecA = parseInt(dateA.substr(0,2)) < 10? parseInt(dateA.substr(1,1)):parseInt(dateA.substr(0,2));

		anioFecB = parseInt(dateB.substr(6,4));
		mesFecB = parseInt(dateB.substr(3,2)) < 10? parseInt(dateB.substr(4,1)):parseInt(dateB.substr(3,2));
		diaFecB = parseInt(dateB.substr(0,2)) < 10? parseInt(dateB.substr(1,1)):parseInt(dateB.substr(0,2));
	
		var fec1Date = new Date(anioFecA, mesFecA-1, diaFecA);
		var fec2Date = new Date(anioFecB, mesFecB-1, diaFecB);
		
		timeDifference = fec1Date - fec2Date; 
		
		// dateA > dateB
		if (timeDifference > 0) 
		  return -1; 
		else 
			// dateA < dateB
			if (timeDifference < 0) 
		  		return 1; 
			else 
				// dateA = dateB
			  	return 0; 

	}  // compararFechas
	
// -----------------------------------------------------------------------------------------------------------------------------     			

	// Devuelve la cantidad de dias acumulados buscando la fecha de 
	// suspension propuesta en los periodos de suspension existentes

	function getDatosPeriodo(fecSuspension)	{
	
		var salir = false;
		var fila = 0;
		var cantDias = -1; // error
		respuesta = new Array();
 		
		while (!salir)	{
			if (fila != tablaPeriodosSusp.length)	{
				fecIniPeriodo = tablaPeriodosSusp[fila][1];
				fecFinPeriodo = tablaPeriodosSusp[fila][2];
				
				comp1 = compararFechas(fecSuspension, fecIniPeriodo);
				comp2 = compararFechas(fecSuspension, fecFinPeriodo);
				
				// Si la fecha de suspension esta dentro de alguno de los periodos, hay que usar esa cantidad de dias acumulados
				if  (((comp1 == -1) || (comp1 == 0)) &&
					 ((comp2 == 1)  || (comp2 == 0)))	{
						cantDias = tablaPeriodosSusp[fila][3];
						respuesta.push([tablaPeriodosSusp[fila][0], fecIniPeriodo, fecFinPeriodo, tablaPeriodosSusp[fila][3]]);
						salir = true;
				} // if
			} // if
			else
				salir = true;
			
			fila++;	
		} // while
		
		return respuesta;
		
	}	// getDiasAcumulados
	
// -----------------------------------------------------------------------------------------------------------------------------     				

	function validaRequeridos()	{
		
		try	{
			// Si no se han cambiado la cantidad de dias de suspension, entonces no se puede hacer SUBMIT
			if 	((document.getElementById("flagOOSSCambiada").value == document.forms[0].cantDias.value) && 	
				(flagOperacion == "modificar"))
			{
				alert("No se ha efectuado cambios en la suspensión seleccionada.");
				return false;
			} // if
		
			// ----------------------------------------------------------------------------
			// -- HGG 27/01/09
			// -- La nueva fecha de rehabilitacion no puede ser anterior al dia de hoy
			if (flagOperacion == "modificar") {
				var fechaRehaTextbox = document.forms[0].fecRehabilitacion.value;
				var difFechas = compararFechas(fechaHoy, fechaRehaTextbox);

				if (difFechas == -1)        {
					alert("La fecha de rehabilitacion nueva no puede ser anterior a la fecha de hoy.");
					return false;                              
				} // if
			} // if                 
			// ---------------------------------------------------------------------------------------------
			
			var indiceFechaSusp = document.forms[0].fecSuspension.selectedIndex;
			var indiceCausaSusp = document.forms[0].causaSuspension.selectedIndex;		
			
			var fechaSusp = document.forms[0].fecSuspension.options[indiceFechaSusp].text;		
			
			var cantDias = document.forms[0].cantDias.value;
			var fechaRehab = document.forms[0].fecRehabilitacion.value;
			var fechaSol = document.forms[0].fecSolicitud.value;

			if (flagOperacion == "programar")
				if (!validaFechaRehabilitacion(false)) return false;

			if 	((fechaSusp != "") && (indiceCausaSusp > 0) && (cantDias != 0) && (fechaRehab != "") && (fechaSol != ""))
				return true;
			else	{
				alert("Verifique que haya ingresado todos los datos necesarios.");
				return false;
			} // else
		
		} // try
		catch (e)	{
			alert("Ha ocurrido un error en la función validaRequeridos().");
		}	
		
	} // validaRequeridos

// -----------------------------------------------------------------------------------------------------------------------------     				

function ltrim(s) {   return s.replace(/^\s+/, "");}
function rtrim(s) {   return s.replace(/\s+$/, "");}
function trim(s) {   return rtrim(ltrim(s));	}

// -----------------------------------------------------------------------------------------------------------------------------     				

function rollback()	{
	
	document.forms[0].fecRehabilitacion.value = "";
	document.forms[0].cantDias.value = "";	
	
} // rollback

// -----------------------------------------------------------------------------------------------------------------------------     				

function deshabilitaControles( flagOperacion )	{
	
	if (flagOperacion == "modificar") {
		document.forms[0].causaSuspension.disabled = true;
		document.forms[0].fecSuspension.disabled = true;		
	} // if

	if (flagOperacion == "programar") {
		document.forms[0].causaSuspension.disabled = false;
		document.forms[0].fecSuspension.disabled = false;
	} // if
	
} // deshabilitaControles

// -----------------------------------------------------------------------------------------------------------------------------     				

function validaFechaRehabilitacion(flagModif, fecRehabModificada)	{

	var flagContinuar=true;
	fechaRehaTextbox = document.forms[0].fecRehabilitacion.value;
	
	var indice = document.forms[0].fecSuspension.selectedIndex;
	var fechaSuspListBox = document.forms[0].fecSuspension.options[indice].text;
	
	var index=1;
	var mensajeError = "El total o parte del periodo de suspensión seleccionado ya se encuentra contemplado en otra programación, por favor modificar el período seleccionado.";
	
	
	// ---------------------------------------------------------------------------------------------
	// -- HGG 26/01/09
	// -- La nueva fecha de rehabilitacion no puede ser anterior al dia de hoy
	
	if (flagModif==true) {
		var difDias = restaDias(fechaHoy, fechaSuspListBox);
		if (difDias >= parseInt(document.forms[0].cantDias.value))	{
			alert("La fecha de rehabilitacion nueva no puede ser anterior a la fecha de hoy.");
			flagContinuar = false
		} // if
	} // if		
	// ---------------------------------------------------------------------------------------------
	
	while (flagContinuar && index <= parseInt(cantSuspensiones))	{
		fecSuspension		= getCellByRowCol("tablaSuspensiones", index, 2);			
		fecRehabilitacion 	= getCellByRowCol("tablaSuspensiones", index, 3);

		if (flagModif==true) {
			fechaRehaTextbox = fecRehabModificada;
			}

		var difFechas1 = compararFechas(fechaRehaTextbox, fecSuspension);
		var difFechas2 = compararFechas(fechaRehaTextbox, fecRehabilitacion);

		// Validar que la fecha de rehabilitacion cae dentro de una suspension => ERROR
		if	((difFechas1 <= 0) && (difFechas2 == 1))	{
			alert(mensajeError);
			if (flagModif==true) {
				limpiar('todo');
			}
			else {
				limpiar('parte');
			}
			flagContinuar = false;
		} // if

		// Validar que la fecha de suspension NO esté comprendida DENTRO de otra suspension.
		if (flagContinuar)	{
			
			var difFechas1 = compararFechas(fechaSuspListBox, fecSuspension);
			var difFechas2 = compararFechas(fecRehabilitacion, fechaSuspListBox);

			if 	((difFechas1 == -1) && (difFechas2 == -1))	{
				alert(mensajeError);
				if (flagModif==true) {
					limpiar('todo');
				}
				else {
					limpiar('parte');
				}
				flagContinuar = false;
			} // if

			//Valida que la fecha de suspensión no englobe a otra suspensión
			var difFechas1 = compararFechas(fechaSuspListBox, fecSuspension);
			var difFechas2 = compararFechas(fechaRehaTextbox, fecRehabilitacion);

			if 	((difFechas1 == 1) && (difFechas2 == -1))	{
				alert(mensajeError);
				if (flagModif==true) {
					limpiar('todo');
				}
				else {
					limpiar('parte');
				}
				flagContinuar = false;
			} // if

		} // if
		
		index++;
		
	} // for


	if (flagContinuar)
		return true;
	else
		return false;
	
} // validaFechaRehabilitacion

// -----------------------------------------------------------------------------------------------------------------------------     				

function validaFechaSuspension()	{
	
	var flag=false;
	fechaSuspTextbox = document.forms[0].fecSuspension.value;
	
	for (var index=1; index <= parseInt(cantSuspensiones); index++)	{
		fecSuspension 	= getCellByRowCol("tablaSuspensiones", index, 2);
		var difFechas 	= compararFechas(fechaSuspTextbox, fecSuspension);
	
		if 	(difFechas == 0) {
			alert("Ya existe una suspensión programada para la fecha seleccionada, por favor seleccionar otra o anular la existente.");
	        document.forms[0].fecSuspension.value = "";										
			limpiar("parte");
			return;
		} // if
	} // for

	
} // validaFechaSuspension

// ----------------------------------------------------------------------------------------------------------------------------- 	

function restaDias(fecha2, dias)	{

	try 	{
		var fecha = new String(fecha2);
		anioFec = parseInt(fecha.substr(6,4));
		mesFec = parseInt(fecha.substr(3,2)) < 10? parseInt(fecha.substr(4,1)):parseInt(fecha.substr(3,2));
		diaFec = parseInt(fecha.substr(0,2)) < 10? parseInt(fecha.substr(1,1)):parseInt(fecha.substr(0,2));
		
		fecha1=new Date(anioFec,mesFec-1,diaFec);	

		var resta = fecha1-((1000*3600*24)*dias); 
		fechaFin = new Date(resta);
		
		anioFec = fechaFin.getYear();
		mesFec = fechaFin.getMonth()+1;
		mesFec = parseInt(mesFec) < 10? "0"+mesFec: mesFec;
		diaFec = fechaFin.getDate();
		diaFec = parseInt(diaFec) < 10? "0"+diaFec: diaFec;
	
		return diaFec+"/"+mesFec+"/"+anioFec;
		
	} // try
	catch (e)	{
		alert("Ha ocurrido un error en la función restaDias().");
	} // catch	
	
} // restaDias 	

// ----------------------------------------------------------------------------------------------------------------------------- 	
	
