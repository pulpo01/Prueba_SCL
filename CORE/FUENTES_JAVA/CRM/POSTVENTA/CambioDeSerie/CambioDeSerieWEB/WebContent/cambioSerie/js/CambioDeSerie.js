// Se guardan los flags de indicadores de cuotas;
var indicadorCuotasArray = new Array();

// Arreglo de tipos de terminal
var listaTiposTerminal = new Array();

// Para saber si se hizo el callback de un bloqueo o desbloqueo de equipo o simcard
var flagCallback = "";
var arryCentral=new Array();
document.oncontextmenu=new Function("return false")

function clickIE4(){
if (event.button==2){
alert(message);
return false;
}
}

function clickNS4(e){
if (document.layers||document.getElementById&&!document.all){
if (e.which==2||e.which==3){
alert(message);
return false;
}
}
}

if (document.layers){
document.captureEvents(Event.MOUSEDOWN);
document.onmousedown=clickNS4;
}
else if (document.all&&!document.getElementById){
document.onmousedown=clickIE4;
}


function mostrarError(mensaje)	{

	document.getElementById("textoerror").innerHTML = "<img src='img/black_arrow.gif'> " + mensaje;	
	document.getElementById("textoerror").style.display = 'inline';
	document.getElementById("mensajes").style.display = 'inline';

}

// ------------------------------------------------------------------------------------  

function borrarError()	{

	document.getElementById("textoerror").innerHTML = "";	
	document.getElementById("textoerror").style.display = 'none';
	document.getElementById("mensajes").style.display = 'none';
}

// ------------------------------------------------------------------------------------  

function enviarFormulario()
  {
  	document.getElementById("btnSeleccionado").value = "siguiente";
    document.forms[0].submit();
  }

// ------------------------------------------------------------------------------------    

function formularioAnterior()
  {
  	document.getElementById("btnSeleccionado").value = "anterior";
    document.forms[0].submit();
  
  }

// ------------------------------------------------------------------------------------    

function cargaComboTiposContrato(tipProcedencia)  {

	var cod = document.getElementById("codTipContrato").value;
	var des = document.getElementById("des_tipcontrato").value;
	var num_abonado = document.getElementById("num_abonado").value;
	var nom_usuario = document.getElementById("nom_usuario").value;
	
	var TipoDeContratoDTO = {
		cod_tipcontrato: cod,
		des_tipcontrato: des
	};

	var UsuarioSistemaDTO =	{
		nom_usuario: nom_usuario
	};
	
	var SesionDTO =	{
		numAbonado: num_abonado, 
		usuario: UsuarioSistemaDTO
	};
	
	CusIntManDWRController.obtenerTiposDeContrato(	tipProcedencia, 
													TipoDeContratoDTO,
													SesionDTO, 
													callbackTiposContrato);
													
													
}	// cargaComboTiposContrato()

// ------------------------------------------------------------------------------------    

function cargaComboModalidadPago(valorModalilidadPago, pagina, indProcEquipo)  {

	var pos = document.getElementById("causaCambio").selectedIndex;
	// Si selecciono una opcion distinta de la primera que esta en blanco
	if (pos > 0)	{
		var num_abonado = document.getElementById("num_abonado").value;
		var nom_usuario = document.getElementById("nom_usuario").value;
		
		var CausaCamSerieDTO = {
			cod_caucaser:valorModalilidadPago
		};
		
		var UsuarioSistemaDTO =	{
			nom_usuario: nom_usuario
		};
		
		var SesionDTO =	{
			numAbonado: num_abonado, 
			usuario: UsuarioSistemaDTO
		};
	
		CusIntManDWRController.obtenerModalidadPago(SesionDTO, 
													CausaCamSerieDTO,
													pagina,
													indProcEquipo, 
													callbackModalidadPago);
	} // if
	else	{
		DWRUtil.removeAllOptions("cuotas");		
		DWRUtil.removeAllOptions("modalidadPago");			
				
		document.getElementById("comboCuotas").style.display = 'none';
		document.getElementById("radioabonoDiferido").style.display = 'none';
	} // else
	
}	// cargaComboModalidadPago()

// ------------------------------------------------------------------------------------  

function cargaComboTipoTerminal(valorTipoTecnologia)	{

	var TecnologiaDTO =	{
		cod_tecnologia: valorTipoTecnologia 
	};
	
	CusIntManDWRController.cargaComboTipoTerminal(TecnologiaDTO, callbackTipoTerminal); 

}  // cargaComboTipoTerminal

// ------------------------------------------------------------------------------------  

function cargaComboArticulos(valorTipoTerminal)	{

	try
	{
		var ArticuloDTO =	{
			cod_producto: 1,
			tip_terminal:  valorTipoTerminal
		};
		CusIntManDWRController.obtenerListaArticulo(ArticuloDTO, callbackListaArticulos); 
	}
	catch(e){
		alert(e.name + " - "+e.message+" En cargaComboArticulos()");
	}


}  // cargaComboArticulos

// ------------------------------------------------------------------------------------  
function validaSeleccionCausa(valorCausa)	{

	var ParametrosCambioSerieDTO =	{
		codCausa: valorCausa
	};
	
	
	
	CusIntManDWRController.validaSeleccionCausa(ParametrosCambioSerieDTO, callbackValidaSeleccionCausa); 
	

}  // cargaComboArticulos

// ------------------------------------------------------------------------------------  
function cargaComboCuotas(codVenta)	{

	var pos = document.getElementById("modalidadPago").selectedIndex;
	if ((pos > 0) && (indicadorCuotasArray[pos] == 1)) 	{	
		var num_abonado = document.getElementById("num_abonado").value;
		var nom_usuario = document.getElementById("nom_usuario").value;
		
		var UsuarioSistemaDTO =	{
			nom_usuario: nom_usuario
		};
		
		var SesionDTO =	{
			numAbonado: num_abonado, 
			usuario: UsuarioSistemaDTO
		};
		
	
		var ModalidadPagoDTO =	{
			cod_modventa: codVenta
		};
		
		CusIntManDWRController.cargaComboCuotas(SesionDTO, ModalidadPagoDTO, callbackCuotas); 
	}
	else	{
		// Si no selecciono nada, se elimina la info que habia
		DWRUtil.removeAllOptions("cuotas");	

		document.getElementById("comboCuotas").style.display = 'none';
		document.getElementById("radioabonoDiferido").style.display = 'none';
	} // else
	
}  // cargaComboCuotas
// ------------------------------------------------------------------------------------
 function fncBuscarSerie(url1){
 		var tecnologia = document.getElementById("tecnologia").value;
 		var tipoTerminal = document.getElementById("tipoTerminal").value;
 		var usoVentaEquip = document.getElementById("usoVentaEquip").value;
 		var modalidadPago = document.getElementById("modalidadPago").value;
 		var  numSerie =document.getElementById("nroSerieEquip").value;
 		
 		if (modalidadPago==null || modalidadPago=="" || modalidadPago=="0") {
 			alert('Debe seleccionar la Modalidad de Venta');
 			return;
 		} 		
 		if (tecnologia==null || tecnologia=="") {
 			alert('Debe seleccionar la tecnología');
 			return;
 		}
 		if (tipoTerminal==null || tipoTerminal=="") {
 			alert('Debe seleccionar el tipo de terminal');
 			return; 			
 		}
 		//Incio Inc. 177697 FADL
// 		if (usoVentaEquip==null || usoVentaEquip=="") {
// 			alert('Debe seleccionar el uso');
// 			return; 			
// 		}	
 		//Fin Inc. 177697 FADL

 		var url = url1+"&tecnologia="+tecnologia+"&tipoTerminal="+tipoTerminal+"&usoVentaEquip="+usoVentaEquip+"&modalidadPago="+modalidadPago;
 		var ReturnedValue = window.showModalDialog(url, "Series", "dialogHeight:650px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
 		//var ReturnedValue = window.open(url, "Series", "dialogHeight:650px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
		if(ReturnedValue !=null && ReturnedValue!=""){
			numSerie = ReturnedValue;
		}
		document.getElementById("nroSerieEquip").value = numSerie;
 }
	 
// ------------------------------------------------------------------------------------
function cargaComboSeries()	{
	try {
		//Se muestra el combo de series
		document.getElementById("divComboSeries").style["display"] = "inline";
		//Se deshabilita el campo de texto que permite modificar serie
		document.getElementById("nroSerieEquip").value = "";
		document.getElementById("nroSerieEquip").disabled = true;	
		
		//CusIntManDWRController.cargaComboSeries(SerieDTO, TecnologiaDTO, callbackComboSeries); 	
	} catch(e) {
		alert("Ocurrió un error en cargaComboSeries: 3"+e);
	}

	
}//cargaComboSeries
// ------------------------------------------------------------------------------------
function callbackComboSeries(data) {

	DWRUtil.removeAllOptions("nroSerie");
	DWRUtil.addOptions("nroSerie", data, "cod_central", "nom_central");
	
	if (sePuedeBorrarMensaje()) borrarMensaje();
	if (data.cod_central==""||data.cod_central=="undefined"){
		document.getElementById('mensajeError').value ="Serie no existente en inventario, ingrese serie correcta";
	}
} /// callbackCentralHlr

// ------------------------------------------------------------------------------------  
function seleccionarSerie(seleccion)	{
		try {		
			//Se oculta en como de series
			document.getElementById("divComboSeries").style["display"] = "none";
		
			// Se habilita el campo de texto que permite modificar serie
			document.getElementById("nroSerieEquip").disabled = false;
		
			// Se asigna la serie al campo de texto que permite modificar serie
			document.getElementById("nroSerieEquip").value = seleccion;
		
			//Se hace de solo lectura el campo de texto que permite modificar serie
			document.getElementById("nroSerieEquip").readOnly = true;

			//Se oculta el link que carga el combo de series
			document.getElementById("divLnkSelSerie").style["display"] = "none";

			//Se muestra el link que habilita el campo de texto que permite modificar serie
			document.getElementById("divLnkModSerie").style["display"] = "inline";			
			//CusIntManDWRController.cargaComboSeries(SerieDTO, TecnologiaDTO, callbackComboSeries); 	
		} catch(e) {
			alert("Ocurrió un error en seleccionarSerie: 7"+e);
		}
}//seleccionarSerie
// ------------------------------------------------------------------------------------
function mofificarSeries()	{
	try {
		document.getElementById("nroSerieEquip").readOnly = false;
		document.getElementById("divLnkModSerie").style["display"] = "none";	
		document.getElementById("divLnkSelSerie").style["display"] = "inline";
		//Se oculta en como de series
		document.getElementById("divComboSeries").style["display"] = "none";		
	} catch(e) {
		alert("Ocurrió un error en mofificarSeries:"+e);
	}	
} //mofificarSeries
// ------------------------------------------------------------------------------------  

function cargaComboCentralHlr(numSerie)	{

	var tecnologia = document.getElementById("tecnologia").value;

	var SerieDTO  =	{
		num_serie: numSerie
	};
		
	var TecnologiaDTO =	{
		cod_tecnologia: tecnologia 
	};
	
	CusIntManDWRController.cargaComboCentralHlr(SerieDTO, TecnologiaDTO, callbackCentralHlr); 

}  // cargaComboCentralHlr

// ------------------------------------------------------------------------------------  

function callbackCentralHlr1(data) {

	DWRUtil.removeAllOptions("centralHlr");
	DWRUtil.addOptions("centralHlr", data, "cod_central", "nom_central");
	
	if (sePuedeBorrarMensaje()) borrarMensaje();
	if (data.cod_central==""||data.cod_central=="undefined"){
		document.getElementById('mensajeError').value ="Serie no existente en inventario, ingrese serie correcta";
	}
} /// callbackCentralHlr

// ------------------------------------------------------------------------------------  
function callbackCentralHlr(data) {
	
	DWRUtil.removeAllOptions("central");
	DWRUtil.addOptions("central", data, "cod_central", "nom_central");
		
	if (sePuedeBorrarMensaje()) borrarMensaje();
	
	var codCentral=data.cod_central;
	
	var codCentral=document.getElementById("central").length;
	
	if (codCentral<2){
		alert("Serie["+document.getElementById("nroSerieSim").value+"] no existente en inventario, ingrese serie correcta");
		document.getElementById("nroSerieSim").value="";
	}
	callbackCodCentralHlr(data);
	
} // callbackCentralHlr
// ------------------------------------------------------------------------------------  

function callbackCodCentralHlr(data) {
	arryCentral=null;
	arryCentral=data;
		
} // callbackCodCentralHlr
// ------------------------------------------------------------------------------------  


function callbackCuotas(data)	{

	DWRUtil.removeAllOptions("cuotas");
	DWRUtil.addOptions("cuotas", data, "cod_cuota", "des_cuota");

	if (document.getElementById("cuotas").length > 1)	{
		document.getElementById("comboCuotas").style.display = 'inline';
		document.getElementById("radioabonoDiferido").style.display = 'inline';
		
		document.forms[0].abonoDiferido[1].checked=true;
		if (sePuedeBorrarMensaje()) borrarMensaje();
	}
	else
		document.getElementById("comboCuotas").style.display = 'none';
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function callbackTipoTerminal(data)		{

	listaTiposTerminal = data;
	
	DWRUtil.removeAllOptions("tipoTerminal");
	DWRUtil.addOptions("tipoTerminal", data, "tip_terminal", "des_terminal");

	if (sePuedeBorrarMensaje()) borrarMensaje();
	
	valoresDefectoTerminal();
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  
function callbackListaArticulos(data)		{
	
	try
	{
		listaArticulos=data;
		DWRUtil.removeAllOptions("articulos");
		DWRUtil.addOptions("articulos", data, "cod_articulo", "des_articulo");
		recargaArticulo();
		if (sePuedeBorrarMensaje()) borrarMensaje();
	}
	catch(e){
		alert("Ocurrió un error en callback Articulos:"+e);
	}
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function callbackTiposContrato(data)	{
	listaCodTipContrato=data;
	DWRUtil.removeAllOptions("tipoContrato");
	DWRUtil.addOptions("tipoContrato", data, "cod_tipcontrato", "des_tipcontrato");

	if (sePuedeBorrarMensaje()) {
		borrarMensaje();
	}
	valoresDefectoCliente();
	
} // callbackTiposContrato
// ------------------------------------------------------------------------------------  

function callbackValidaSeleccionCausa(data)	{
	
	/*DWRUtil.removeAllOptions("tipoContrato");
	DWRUtil.addOptions("tipoContrato", data, "cod_tipcontrato", "des_tipcontrato");*/
	
	var aplica=data.isResultado;
	
	//alert(aplica);

	if (sePuedeBorrarMensaje()) {
		borrarMensaje();
	}
	
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function callbackModalidadPago(data)	{

	if (data != null)	{
		// Tomo el primero elemento y verifico errores
		DWRUtil.removeAllOptions("modalidadPago");
		DWRUtil.addOptions("modalidadPago", data, "cod_modventa", "des_modventa");
		
		// --------------------------------------------------------------------------------
		// Hay que dejar seleccionado el que correspondia cuando se vuelve atras la pagina
		if (flagPagRecargada == true)	{
			var cod="";
			for (var i=0; i < document.getElementById("causaCambio").length; i++)	{
				cod=document.getElementById("modalidadPago").options[i].value;
				if (cod==codModPago)	{
					document.getElementById("modalidadPago").selectedIndex = i;
					break;
				} // if
			} // for
		} // if
		// --------------------------------------------------------------------------------
		
		// Lleno el array con los indicadores de cuotas 
		var ind=0;
		var cont=0;
		var flag=0;
		for (var item in data)	{
			indicadorCuotasArray[ind]=data[item].ind_cuotas;
			ind++;
			if (cont==0)	{
				MensajeRetornoDTO = data[item].mensajeRetorno;
				switch(MensajeRetornoDTO.codigo)	{
					case 1:
						// Muestro mensaje de error
						mostrarError(MensajeRetornoDTO.mensaje);
						// Selecciono la opcion en blanco
						document.getElementById('causaCambio').selectedIndex = 0;
						flag=1;
						break;
						
					case 2:
						var stack = "";
						var mensaje = "";
						var pos = 0;
						
						document.getElementById('condicionError').value = "ERROR";

						// Separador del mensaje y la stackstrace
						pos = MensajeRetornoDTO.mensaje.indexOf("&&&");
						mensaje = MensajeRetornoDTO.mensaje.substr(0, pos-3);
						stack = MensajeRetornoDTO.mensaje.substr(pos+3);
						document.getElementById('mensajeError').value = mensaje;
						document.getElementById('mensajeStackTrace').value = stack;						

						document.forms[0].submit();
				} // case	
			} // if
			
			if (flag!=1&&parseInt(data.length)==parseInt(1))
			{
				mostrarError('No existen modalidades de pago para la selecci&oacute;n realizada');
				flag=1;
			}
			
			cont++;
		} // for


		document.getElementById("comboCuotas").style.display = 'none';
		document.getElementById("radioabonoDiferido").style.display = 'none';
		
		if (!flag) borrarError();

		// ------------------------------------------------------------------------------------------------------------------------------------
		// Si no trae nada entonces hay que deshabilitar el objeto, por defecto solo trae un elemento con espacio en blanco
		// ------------------------------------------------------------------------------------------------------------------------------------
		if (document.getElementById("modalidadPago").length > 1)	{
			document.getElementById("modalidadPago").disabled = false;
		} // else
		else	{
			document.getElementById("modalidadPago").disabled = true;	
		} // else
		// ------------------------------------------------------------------------------------------------------------------------------------
			
	} // if
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function abono()	{

	document.getElementById("cuotas").selectedIndex = 0;	

} // abono

// ------------------------------------------------------------------------------------  

function mostrarVentana()	{

	var codigo = document.getElementById('tecnologia').options[document.getElementById('tecnologia').selectedIndex].value;
	var uso = document.getElementById('usoVenta').options[document.getElementById('usoVenta').selectedIndex].text;
	var url = "/CusIntManWEB/CambioNumYSimAction.do?tecnologia=" + codigo + "&uso=" + uso;

	window.showModalDialog(url, "", "dialogHeight:180px; dialogWidth:500px; center:yes; help:no; status:no; resizable:no");
	
} // mostrarVentana

// ------------------------------------------------------------------------------------  

// Solo para CAMBIO DE SERIE esta funcion queda parametrizable
// tipoSerie y tipUsoVenta , traen el nombre del textbox y select de equipo o simcard
function bloquearSerie(accion, tipoSerie, tipUsoVenta, tipoAccion)	{
	try	{
		// Dependiendo si es equipo o simcard
		var num_serie = document.getElementById(tipoSerie).value;
		
		//Inicio Inc. 177607 - FADL 
		var cod_uso = document.getElementById(tipUsoVenta).value;	
		//Fin Inc. 177607 - FADL
		
		var num_abonado = document.getElementById("num_abonado").value;
		var cod_cliente = document.getElementById("cod_cliente").value;
		var cod_ooss 	= document.getElementById("cod_ooss").value;
		var cod_vendedor = document.getElementById("cod_vendedor").value;
		var nom_usuario	= document.getElementById("nom_usuario").value;
		var cod_tipcomis = document.getElementById("cod_tipcomis").value;
		// var ind_causa = document.getElementById("causaCambio").options[document.getElementById("tipoTerminal").selectedIndex].value; // COL 88022|08-05-2009|SAQL
      var ind_causa = document.getElementById("causaCambio").options[document.getElementById("causaCambio").selectedIndex].value; // COL 88022|08-05-2009|SAQL
		var hlrId = document.getElementById("hlr").value;
		
		var strInterna = document.getElementById("procEquipoNuevo").value; // INC-70904; RRG
	
		var tip_terminal = "";
		if (tipoAccion == "simcard")
			tip_terminal = "G";
		else
			if (document.getElementById("tipoTerminal").length > 0)
				tip_terminal = document.getElementById("tipoTerminal").options[document.getElementById("tipoTerminal").selectedIndex].value;
	
		var mod_pago = "";
		if (document.getElementById("modalidadPago").length > 0)
			mod_pago = document.getElementById("modalidadPago").options[document.getElementById("modalidadPago").selectedIndex].value;
	
		var cod_tecnologia = document.getElementById("cod_tecnologia").value;
		var flagT = document.getElementById("flagT").value;
		var flagValidacion = false;
		
		//Daniel Sagredo(+)
		var causaCambio = document.getElementById("causaCambio").value;
		var tipoContrato = document.getElementById("tipoContrato").value;
		var modalidadPago = document.getElementById("modalidadPago").value;
		var tipoTerminal = document.getElementById("tipoTerminal").value;
		//Daniel Sagredo(-)
		
		/***
			@author rlozano
			@description se duplica variable para obtencion de codigo tipo contrato , se realiza esto
			para comprension del codigo, ya que se obtiene por pagina es el codigo del tipo no el tipo.
		**/
		tipoContrato=tipoContrato.replace(/\s+/g,'');
		var codTipContrato=tipoContrato;
		//&& (flagPagRecargada==true)
		if ((accion == "bloquear")  && (
		 	(tipoAccion=="simcard")&&(document.getElementById("flagBloqueo").value==1)||
			(tipoAccion=="equipo") &&(document.getElementById("flagBloqueoEquipo").value==1)))
		{
			alert("La serie ["+num_serie+"] ya se encuentra reservada. Sólo puede efectuar su .");
			return;
		}
		
		
		
		
		// ----------------------------------------------------------------------------------------
		// Efectuamos las validaciones basicas
		// ----------------------------------------------------------------------------------------	
		//Esto Permite la eliminación de espacios
		
		tipoTerminal = tipoTerminal.replace(/^\s*|\s*$/g,"");
		tipoContrato = tipoContrato.replace(/^\s*|\s*$/g,"");
		if(causaCambio ==""||tipoContrato  ==""||modalidadPago  ==""||tipoTerminal =="" ||modalidadPago=="0"){
			alert("Debe seleccionar valores en todas las opciones ");
			flagValidacion = true;
		}
		
		if (num_serie == "")	{
			alert("Debe ingresar un número de serie.");
			flagValidacion = true;
		}
		else
			if (isNaN(num_serie)) 	{
					alert("El número de serie debe ser númerico.");
					flagValidacion = true;
				}
			else{
				//INICIO PAH 177697
				//if (cod_uso == "")			{
				//	alert("Debe seleccionar un uso.");
				//	flagValidacion = true;
				//}
				//FIN PAH 177697	
				if (hlrId == ""&&tipoAccion!="equipo")			{
					alert("Debe seleccionar una central para la Simcard.");
					flagValidacion = true;
				}
	
				
			}
					
		// ----------------------------------------------------------------------------------------
		if (flagValidacion == false)	{
			
			// No se encuentra bloqueada la serie
			//alert("flagPagRecargada:" + flagPagRecargada);

			var blockEquipo=document.getElementById("flagBloqueoEquipo").value ;
			var blockSimcard=document.getElementById("flagBloqueo").value;

			/*alert("blockEquipo:" + blockEquipo );
			alert("blockSimcard:" + blockSimcard );
			alert("accion:" + accion);
			alert("tipoAccion:" +  tipoAccion);*/

			if (flagPagRecargada==false)
			{

				//alert("Entra flagPagRecargada");

				if ((tipoAccion=="simcard"&&blockSimcard!= 1||(tipoAccion=="equipo"&&blockEquipo!= 1)) && accion == "desbloquear")	
				{
					alert("Debe bloquear un número de serie antes de intentar el desbloqueo.");
					return;
				}
			}	
			
			if (flagT == 1) 
				alert("Hay una operación en proceso, espere por favor antes de ejecutar otra solicitud. ");
			else	{
				flagCallback = tipoAccion;
				if (accion == "bloquear")	{
					document.getElementById("flagT").value = "1";
					document.body.style.cursor="wait";
					CusIntManDWRController.bloquearSerie(num_abonado, 
														 cod_cliente, 
														 cod_ooss, 
														 cod_vendedor, 
														 nom_usuario, 
														 cod_tipcomis, 
														 num_serie,
														 cod_uso,
														 ind_causa,
														 tip_terminal,
														 mod_pago,
														 cod_tecnologia,
														 "bloquear",
														 codTipContrato,
														 tipoAccion,
														 strInterna, // INC-70904; RRG
														 callbackBloquearSerie);
				} // if
				else	{
					document.getElementById("flagT").value = "1";
					document.body.style.cursor="wait";
					CusIntManDWRController.bloquearSerie(num_abonado, 
														 cod_cliente, 
														 cod_ooss, 
														 cod_vendedor, 
														 nom_usuario, 
														 cod_tipcomis, 
														 num_serie,
														 cod_uso,
														 ind_causa,
														 tip_terminal,
														 mod_pago,
														 cod_tecnologia,
														 "desbloquear",
														 codTipContrato,
														 tipoAccion,
														 strInterna, // INC-70904; RRG
														 callbackDesbloquearSerie);	
													 
				} // else
			} // if flagT
		} // if validacion
				
	} // try
	catch(e)	{
		alert("Se ha producido el siguiente error bloquearSerie: \n(" + e.name + "). " + e.message );
	} // catch
	
} // bloquearSerie

// ------------------------------------------------------------------------------------  

function callbackDesbloquearSerie(data)	{
	
	try	{
		// Muestro mensaje de error
		
		MensajeRetornoDTO = data;
		mostrarError(MensajeRetornoDTO.mensaje);
		
		//alert("callbackDesbloquearSerie:MensajeRetornoDTO.codigo:" + MensajeRetornoDTO.codigo);

		// No hubo error
		if (MensajeRetornoDTO.codigo != 1)	{
			// Hay que desbloquear todos los controles
			habilitaControles();
			if (flagCallback == "simcard") 
			{	
				
				document.getElementById("flagBloqueo").value = 0;		
			}
			else
			{
				document.getElementById("flagBloqueoEquipo").value = 0;		
			}	
			document.getElementById("divLnkSelSerie").style["display"] = "inline";
				
		}
		/*else { // inicio 09-03-2009 col 78629 RRG
			if (flagCallback == "simcard") 
			{	
				document.getElementById("flagBloqueo").value = 1;		
			}
			else
			{
				document.getElementById("flagBloqueoEquipo").value = 1;		
			} // fin 09-03-2009 col 78629 RRG
			
		}*/
	
		deshabilitaSimcardEquipoBloqueo();
		document.getElementById("flagT").value = 0;
		document.body.style.cursor="default";
		flagPagRecargada=false;
	}
	catch(e)	{
		alert("Se ha producido el siguiente error callbackDesbloquearSerie: \n(" + e.name + "). " + e.message );
	} // catch
														 	
}	// callbackDesbloquearSerie

// ------------------------------------------------------------------------------------  

function callbackBloquearSerie(data)	{

	try	{	
		// Muestro mensaje de error
		MensajeRetornoDTO = data;
		msjError = new String();
		msjError=MensajeRetornoDTO.mensaje;
		
		var aplicaArray = false;
		if (msjError.indexOf("|") > 0)	aplicaArray = true;
		
		
		vecMensajes = new Array();
		vecMensajes = msjError.split("|");
		var msj="";

		if (aplicaArray){
			mostrarError(vecMensajes[0]);
			for (i=1;i<vecMensajes.length;i++){
				msj=msj + "\n" + vecMensajes[i];
			}
			alert(msj);
		}
		else{
			mostrarError(msjError);
		}
		
		//mostrarError(MensajeRetornoDTO.mensaje);
		//alert(mostrar);
		
		//alert("callbackBloquearSerie:MensajeRetornoDTO.codigo:" + MensajeRetornoDTO.codigo);

		// No hubo error
		if (MensajeRetornoDTO.codigo != 1)	{
			// Hay que bloquear todos los controles
			deshabilitaControles();
			
			// flagCallback = flag global
			if (flagCallback == "simcard") 	{
				document.getElementById("flagBloqueo").value = 1;	
				document.getElementById("numTransBloqDesSerie").value=data.numMovimientoBloqDesb;
					
			}
			else{
				document.getElementById("flagBloqueoEquipo").value = 1;		
				document.getElementById("numTransBloqDesEquipo").value=data.numMovimientoBloqDesb;
			}
			flagPagRecargada=true;
			document.getElementById("divLnkSelSerie").style["display"] = "none";
			
		}  else { // inicio  09-03-2009 col 78629 RRG
			if (flagCallback == "simcard") 
			{	
				document.getElementById("flagBloqueo").value = 0;		
			}
			else
			{
				document.getElementById("flagBloqueoEquipo").value = 0;		
			} // fin 09-03-2009 col 78629 RRG
			flagPagRecargada=false;
			document.getElementById("divLnkSelSerie").style["display"] = "inline";
		}
		
		// if
		//solo se deshabilita equipo o simcard (correspondiente)
		deshabilitaSimcardEquipoBloqueo();
		document.getElementById("flagT").value = 0;
		document.body.style.cursor="default";
		document.getElementById("cod_bodega").value = data.cod_bodega;
		document.getElementById("cod_articulo").value = data.cod_articulo;	
		document.getElementById("tip_stock").value = data.tip_stock;
		document.getElementById("numTransaccionBloqDes").value =data.numMovimientoBloqDesb;	
		//flagPagRecargada=true;
		
	}
	catch(e)	{
		alert("Se ha producido el siguiente error en callbackBloquearSerie: \n(" + e.name + "). " + e.message );
	} // catch
	
}	// callbackBloquearSerie

// ------------------------------------------------------------------------------------  

// Solo para CAMBIO DE SERIE esta funcion queda parametrizable
// tipoSerie y tipUsoVenta , traen el nombre del textbox y select de equipo o simcard
function bloquearSerieExterna(accion, tipoSerie, tipUsoVenta, tipoAccion)	{
	
	try	{
		// Dependiendo si es equipo o simcard
		var num_serie = document.getElementById(tipoSerie).value;
		var cod_uso = document.getElementById(tipUsoVenta).value;
		var num_abonado = document.getElementById("num_abonado").value;
		var cod_cliente = document.getElementById("cod_cliente").value;
		var cod_ooss 	= document.getElementById("cod_ooss").value;
		var cod_vendedor = document.getElementById("cod_vendedor").value;
		var nom_usuario	= document.getElementById("nom_usuario").value;
		var cod_tipcomis = document.getElementById("cod_tipcomis").value;
		var cod_articulo = document.getElementById("articulos").value;
		var codTecCliente= document.getElementById("cod_tecnologia").value;
		var ind_causa = document.getElementById("causaCambio").options[document.getElementById("tipoTerminal").selectedIndex].value;
		var hlrId = document.getElementById("hlr").value;
	
		var tip_terminal = "";
		if (tipoAccion == "simcard")
			tip_terminal = "G";
		else
			if (document.getElementById("tipoTerminal").length > 0)
				tip_terminal = document.getElementById("tipoTerminal").options[document.getElementById("tipoTerminal").selectedIndex].value;
	
		var mod_pago = "";
		if (document.getElementById("modalidadPago").length > 0)
			mod_pago = document.getElementById("modalidadPago").options[document.getElementById("modalidadPago").selectedIndex].value;
	
		var cod_tecnologia = document.getElementById("cod_tecnologia").value;
		var flagT = document.getElementById("flagT").value;
		var flagValidacion = false;
		
		//Daniel Sagredo(+)
		var causaCambio = document.getElementById("causaCambio").value;
		var tipoContrato = document.getElementById("tipoContrato").value;
		var modalidadPago = document.getElementById("modalidadPago").value;
		var tipoTerminal = document.getElementById("tipoTerminal").value;
		//Daniel Sagredo(-)
		
		/***
			@author rlozano
			@description se duplica variable para obtencion de codigo tipo contrato , se realiza esto
			para comprension del codigo, ya que se obtiene por pagina es el codigo del tipo no el tipo.
		**/
		var codTipContrato=tipoContrato;
		//&& (flagPagRecargada==true)
		if ((accion == "bloquear")  && (
		 	(tipoAccion=="simcard")&&(document.getElementById("flagBloqueo").value==1)||
			(tipoAccion=="equipo") &&(document.getElementById("flagBloqueoEquipo").value==1)))
		{
			alert("La serie ["+num_serie+"] ya se encuentra reservada. Sólo puede efectuar su desreserva.");
			return false;
		}
		
		
		
		
		// ----------------------------------------------------------------------------------------
		// Efectuamos las validaciones basicas
		// ----------------------------------------------------------------------------------------	
		//Esto Permite la eliminación de espacios
		
		tipoTerminal = tipoTerminal.replace(/^\s*|\s*$/g,"");
		tipoContrato = tipoContrato.replace(/^\s*|\s*$/g,"");
		cod_articulo = cod_articulo.replace(/^\s*|\s*$/g,"");
		codTecCliente== codTecCliente.replace(/^\s*|\s*$/g,"");
		if(causaCambio ==""||tipoContrato  ==""||modalidadPago  ==""||tipoTerminal =="" ||modalidadPago=="0"){
			alert("Debe seleccionar valores en todas las opciones ");
			flagValidacion = true;
		}
		
		if (cod_articulo==""||cod_articulo=="0")
		{
			alert("Debe seleccionar un artículo para la serie.");
			flagValidacion = true;
		}
		else
		if (num_serie == "")	{
			alert("Debe ingresar un número de serie.");
			flagValidacion = true;
		}
		else
			if (isNaN(num_serie)) 	{
					alert("El número de serie debe ser númerico.");
					flagValidacion = true;
				}
			else{
				
				if (num_serie.length!=15)
				{
					alert("La serie ingresada no es del largo adecuado");
					return false;
				}
				
				/*if (codTecCliente!="GSM"&&num_serie.length!=11)
				{
					alert("La serie ingresada no es del largo adecuado");
					return false;
				}*/
				document.getElementById("procedNuevoEquipo").value='E';
				var procdEq=document.getElementById("procedNuevoEquipo").value;
				
				//alert(procdEq);
				var parte1=0;
				var parte2=0;
				if ("E"==procdEq)
				{
					parte1=num_serie.substring(1,3);
					parte2=num_serie.substring(4,8);
					
					if (parte1>255||parte2>16777215)
					{
						alert("La serie ingresada no tiene corresponde al formato");
						flagValidacion = true;
						return false;
					}
					
				}
		
				//INICIO 177697 PAH
				//if (cod_uso == "")			{
				//	alert("Debe seleccionar un uso.");
				//	flagValidacion = true;
				//}
				//FIN 177697 PAH
				if (hlrId == ""&&tipoAccion!="equipo")			{
					alert("Debe seleccionar una central para la Simcard.");
					flagValidacion = true;
				}
	
				
				// inicio RRG 70904 24-09-2008 COL

				var strInterna = document.getElementById("procEquipoNuevo").value; // INC-70904; RRG

				document.getElementById("flagT").value = "1";
					//document.body.style.cursor="wait";			
					//CusIntManDWRController.bloquearSerie(num_abonado,cod_cliente,cod_ooss,cod_vendedor,nom_usuario,cod_tipcomis,num_serie,cod_uso,ind_causa,tip_terminal,mod_pago,cod_tecnologia,"bloquear",codTipContrato,tipoAccion,strInterna, // INC-70904; RRG callbackBloquearSerie);														 
			if (accion == "bloquearEx")	{			
					//document.body.style.cursor="wait";
					document.getElementById("flagT").value = 0;
					flagPagRecargada=true;
					document.getElementById("flagBloqueoEquipoEx").value = 1;
				}
				// fin RRG 70904 24-09-2008 COL
			}

		// ----------------------------------------------------------------------------------------
		if (flagValidacion == false)	{
			
			// No se encuentra bloqueada la serie
			//alert(flagPagRecargada);
			var blockEquipo=document.getElementById("flagBloqueoEquipo").value ;
			var blockSimcard=document.getElementById("flagBloqueo").value;
			if (flagPagRecargada==false)
			{
				if ((tipoAccion=="simcard"&&blockSimcard!= 1||(tipoAccion=="equipo"&&blockEquipo!= 1)) && accion == "desbloquear")	
				{
					alert("Debe bloquear un número de serie antes de intentar el desbloqueo.");
					return false;
				}
			}
			
			if (flagT == 1){ 
				alert("Hay una operación en proceso, espere por favor antes de ejecutar otra solicitud. ");
				return false
			} else	{
				flagCallback = tipoAccion;
				deshabilitaControlesExterno();
				flagPagRecargada==false;
				
				if (accion == "bloquearEx")	{
					//document.body.style.cursor="wait";
					document.getElementById("flagT").value = 0;
					flagPagRecargada=true;
					document.getElementById("flagBloqueoEquipoEx").value = 1;	
				} // if				
				
			} // if flagT
			

		} // if validacion
		return true;
				
	} // try
	catch(e)	{
		alert("Se ha producido el siguiente error bloquearSerieExterna: \n(" + e.name + "). " + e.message );
	} // catch
	
} // bloquearSerie

//-----------------------------------------------------------------------------------------------------------------------------
function validaAvisoSiniestro()	{

	if (document.getElementById("tipoSuspencion").selectedIndex == 0)	{
		alert("Debe seleccionar un Tipo de Suspención antes de continuar.");
		return false;	
	}
	
	if (document.getElementById("causaSiniestro").selectedIndex == 0)	{
		alert("Debe seleccionar una Causa de Siniestro antes de continuar.");
		return false;	
	}

	if (document.getElementById("tipoSiniestro").selectedIndex == 0)	{
		alert("Debe seleccionar un Tipo de Siniestro antes de continuar.");
		return false;	
	}

	if (document.getElementById("fecSiniestro").value == "")	{
		alert("Debe seleccionar una Fecha de Siniestro antes de continuar.");
		return false;	
	}
	
	var fecSiniestro = document.getElementById("fecSiniestro").value;
    var fecSiniestroArray = new Array();
    fecSiniestroArray = fecSiniestro.split("/");

    fecSiniestro = "";
    fecSiniestro = fecSiniestroArray[2].concat(fecSiniestroArray[1]);
    fecSiniestro = fecSiniestro.concat(fecSiniestroArray[0]);
   
    var fecHoy = new Date()
    var dia = new String();
    var anio = new String();;
	var fecTermino = new String();;

    anio = fecHoy.getYear().toString();
	var mesInt = fecHoy.getMonth()+1;
	mes = mesInt.toString();
    dia = fecHoy.getDate().toString();
    
    if (parseInt(dia) < 10) dia="0"+dia;
    
	fecTermino = anio.concat(mes);
	fecTermino = fecTermino.concat(dia);
	
    if (parseInt(fecSiniestro) > parseInt(fecTermino) ) {
        alert("La Fecha de Siniestro no debe ser superior a la fecha de hoy.");
        return false;
    }
    
	return true;
		
}	// validaAvisoSiniestro

// ------------------------------------------------------------------------------------  

function sePuedeBorrarMensaje()	{
	var retValue=false;
	if (document.getElementById("textoerror").innerHTML != ""){
		retValue=true;
	}
	return retValue;
	
}	// sePuedeBorrarMensaje
// ------------------------------------------------------------------------------------  

function validaAnulacionSiniestro()	{

	var num = document.getElementById("numSiniestro").value;
	
	if (num.length < 1)	{
		alert("Debe seleccionar un Nro.de Siniestro antes de continuar.");
		return false;	
	}

	return true;
		
}	// validaAvisoSiniestro

// ------------------------------------------------------------------------------------  

	String.prototype.trim = function() {
		return this.replace(/^\s+|\s+$/g,"");
	}

// ------------------------------------------------------------------------------------  
// Empleado en la busqueda de codigos de la ooss de servicios sumplentarios
// ------------------------------------------------------------------------------------  	

	function buscarCodigo() {

			var flag = false;
			var colorResaltado = "#F4F4F4";
			var colorNormal = "#FFFFFF";
			
			var cod = document.getElementById("codSearch").value;
			cod = cod.trim();

			// Hago la busqueda y si lo encuentro, la resalto y pongo hago el scroll
			for (var indice=0; indice < listaServiciosDisp.length; indice++)
				if (listaServiciosDisp[indice] == cod)	{
					var obj = document.getElementById("idSelDisp"+indice);
					obj.focus();

					for (var col=1; col <= 3; col++)	{
						// Limpio la seleccion anterior
						document.getElementById("col" + col + "fila"+filaSel+"TblServDisp").style.backgroundColor=colorNormal;
						// Resalto la nueva
						document.getElementById("col" + col + "fila"+indice+"TblServDisp").style.backgroundColor=colorResaltado;
					} // for

					// Guardo la fila que se resalto
					filaSel = indice;	
					flag = true;
					
					return;
				}	// if 
			
			if (!flag) alert("No se ha encontrado el código solicitado.");
			
		} // cargaFormulario

	// ------------------------------------------------------------------------------------------		
	
	function habilitaControles()	{
	
		document.getElementById("causaCambio").disabled = false;
		document.getElementById("tipoContrato").disabled = false;
		document.getElementById("modalidadPago").disabled = false;
		document.getElementById("cuotas").disabled = false;
		//document.getElementById("tipoTerminal").disabled = false;
		document.getElementById("abonoDiferido").disabled = false;
		document.getElementById("nroSerieEquip").disabled = false;
		document.getElementById("nroSerieSim").disabled = false;
		document.getElementById("usoVentaEquip").disabled = false;
		document.getElementById("usoVentaSim").disabled = false;
		document.getElementById("central").disabled = false;
		//document.getElementById("procedNuevoEquipo").disabled = false;
		document.getElementById("btn").disabled = false;
		document.getElementById("articulos").disabled = false;
		document.getElementById("desFabricante").disabled = false;
		document.getElementById("modelo").disabled = false;
		document.getElementById("mesesProrroga").disabled=false;
		document.getElementById("tip_stock").disabled=false;
		//document.getElementById("nroSerieEquipExMec").disabled = false;
		
	} // habilitaControles
	
	// ------------------------------------------------------------------------------------------			
	
	function deshabilitaControles()	{
	
		document.getElementById("causaCambio").disabled = true;
		document.getElementById("tipoContrato").disabled = true;
		document.getElementById("modalidadPago").disabled = true;
		document.getElementById("cuotas").disabled = true;
		document.getElementById("tipoTerminal").disabled = true;
		document.getElementById("abonoDiferido").disabled = true;
		document.getElementById("nroSerieEquip").disabled = true;
		document.getElementById("nroSerieSim").disabled = true;
		document.getElementById("usoVentaSim").disabled = true;
		document.getElementById("usoVentaEquip").disabled = true;
		document.getElementById("central").disabled = true;
		//document.getElementById("procedNuevoEquipo").disabled = true;
		document.getElementById("btn").disabled = true;
		document.getElementById("articulos").disabled = true;
		document.getElementById("desFabricante").disabled = true;
		document.getElementById("modelo").disabled = true;
		document.getElementById("mesesProrroga").disabled=true;
		document.getElementById("tip_stock").disabled=true;
		//document.getElementById("nroSerieEquipExMec").disabled = true;
		
	} // deshabilitaControles
    // INI INC-70904; COL; 19-01-2009; AVC
	/**
	* Habilita los controles de la seccion "Seleccionar Equipo", permitiendo ingresar 
	* nuevamente el numero de serie.  
	*/
	function habilitaControlesExterno()	{
		document.getElementById("nroSerieEquip").disabled = false;
		document.getElementById("desFabricante").disabled = false;
		document.getElementById("modelo").disabled = false;
		document.getElementById("usoVentaEquip").disabled = false;
		document.getElementById("articulos").disabled = false;

		/* INICIO RRG 70904 03-02-2009 */
		document.getElementById("nroSerieEquip").value = "";
		document.getElementById("nroSerieEquip").focus();

		document.getElementById("desFabricante").value = "";
		document.getElementById("modelo").value = "";

		document.getElementById("usoVentaEquip").value = "";
		document.getElementById("articulos").value = "";
		/* FIN RRG 70904 03-02-2009 */ 

		// Limpia los datos de error en la cabecera.
		document.getElementById("textoerror").innerHTML = ""
	    document.getElementById("textoerror").style.display = 'none';
	    document.getElementById("mensajes").style.display = 'none';

    
    }     
    //FIN INC-70904; COL; 19-01-2009; AVC
	function deshabilitaControlesExterno()	{
	
		document.getElementById("causaCambio").disabled = true;
		document.getElementById("tipoContrato").disabled = true;
		document.getElementById("modalidadPago").disabled = true;
		document.getElementById("cuotas").disabled = true;
		document.getElementById("tipoTerminal").disabled = true;
		document.getElementById("abonoDiferido").disabled = true;
		document.getElementById("nroSerieEquip").disabled = true;
		//document.getElementById("nroSerieSim").disabled = true;
		//document.getElementById("usoVentaSim").disabled = true;
		document.getElementById("usoVentaEquip").disabled = true;
		//document.getElementById("central").disabled = true;
		//document.getElementById("procedNuevoEquipo").disabled = true;
		document.getElementById("btn").disabled = true;
		document.getElementById("articulos").disabled = true;
		document.getElementById("desFabricante").disabled = true;
		document.getElementById("modelo").disabled = true;
		//document.getElementById("nroSerieEquipExMec").disabled = true;
	} // deshabilitaControles
	function valoresDefectoCliente(){
		valoresDefectoTipoContratoCliente();
		valoresDefectoMesesProrrogaCliente(document.getElementById("codTipContrato").value);
	}
	function borrarMensaje(){
	
	}
	
	function getFabricante(codArticulo)
	{
		for (var i=0;i<listaArticulos.length;i++)
		{
			if (listaArticulos[i].cod_articulo==codArticulo)
			{
				document.getElementById("desFabricante").value=listaArticulos[i].ref_fabricante;
				document.getElementById("codArticuloTerminal").value=codArticulo;
				document.getElementById("modelo").value=listaArticulos[i].cod_modelo;
				document.getElementById("descripcionEquipo").value=listaArticulos[i].des_articulo;
				break;
			} 
		}
	}
	
	function deshabilitaSimcardEquipoBloqueo()
	{
		
		if (document.getElementById("flagBloqueoEquipo").value==1||document.getElementById("flagBloqueo").value==1)
		{
			deshabilitaControles();
		}
		if (document.getElementById("flagBloqueoEquipo").value==1)
		{
			document.getElementById("nroSerieEquip").disabled = true;
			document.getElementById("usoVentaEquip").disabled = true;	
		}
		else{
			document.getElementById("nroSerieEquip").disabled = false;
			document.getElementById("usoVentaEquip").disabled = false;	
		}
		
		if (document.getElementById("flagBloqueo").value==1)
		{
			document.getElementById("nroSerieSim").disabled = true;
			document.getElementById("usoVentaSim").disabled = true;
			document.getElementById("central").disabled = true;
		}
		else
		{
			document.getElementById("nroSerieSim").disabled = false;
			document.getElementById("usoVentaSim").disabled = false;
			document.getElementById("central").disabled = false;
		}	
	}
	
	function validaSerieElectronica(numSerie)
	{
		var procdEq=document.getElementById("procedNuevoEquipo").value;
		var parte1=0;
		var parte2=0;
		
			
	}
	
	function desReservaSerie(){
			CusIntManDWRController.desReservaSerie(callbackDesReservaSerie);
	}
	
	function desReservaSerieP(nroSerieEquip,nroSerieSim){
	   try{
			CusIntManDWRController.desReservaSerieP(nroSerieEquip,nroSerieSim,callbackDesReservaSerie);
		}
		catch(e){
			alert(""+e.message);
		}	
	}
	
	function callbackDesReservaSerie(data){
		try
			{
				window.close();
			}
		catch(e){
			alert("callbackDesReservaSerie = "+e.message);
			//alert("Ocurrió un error en callback anular reserva serie:"+e);
		}
	}
	
	function validaSerieExterna(accion, tipoSerie, tipUsoVenta, tipoAccion){
		
		var booleano = bloquearSerieExterna(accion, tipoSerie, tipUsoVenta, tipoAccion);
	    if (booleano) {
	        var tipoProcedencia =document.getElementById("procedNuevoEquipo").value;
	  	    var serie =document.getElementById("nroSerieEquip").value;	  	    
	  	    if (serie!='' && tipoProcedencia=='E') {
	  		   var SerieDTO = {
			       num_serie: serie
		       };	  	  	

	          	CusIntManDWRController.validaSerieExternaEquipo(SerieDTO,callbackValidaSerieExterna); 	  	
	  	    }	  
	    }
	}	
	             
		function callbackValidaSerieExterna(data){

				RetornoDTO = data;			
				if (RetornoDTO.descripcion!='') {			
					mostrarError(RetornoDTO.descripcion);
				}

		}
	
	// ------------------------------------------------------------------------------------------				
