// Se guardan los flags de indicadores de cuotas;
var indicadorCuotasArray = new Array();

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

function cargaComboModalidadPago(valorModalilidadPago, pagina)  {

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
	
}  // cargaComboTipoTerminal

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

function callbackCentralHlr(data) {

	DWRUtil.removeAllOptions("centralHlr");
	DWRUtil.addOptions("centralHlr", data, "cod_central", "nom_central");
		
	if (sePuedeBorrarMensaje()) borrarMensaje();
	
} // callbackCentralHlr

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

	DWRUtil.removeAllOptions("tipoTerminal");
	DWRUtil.addOptions("tipoTerminal", data, "tip_terminal", "des_terminal");

	if (sePuedeBorrarMensaje()) borrarMensaje();
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function callbackTiposContrato(data)	{

	DWRUtil.removeAllOptions("tipoContrato");
	DWRUtil.addOptions("tipoContrato", data, "cod_tipcontrato", "des_tipcontrato");

	if (sePuedeBorrarMensaje()) borrarMensaje();
	
} // callbackTiposContrato

// ------------------------------------------------------------------------------------  

function callbackModalidadPago(data)	{

	if (data != null)	{
		// Tomo el primero elemento y verifico errores
		DWRUtil.removeAllOptions("modalidadPago");
		DWRUtil.addOptions("modalidadPago", data, "cod_modventa", "des_modventa");
	
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
			
			cont++;
		} // for


		document.getElementById("comboCuotas").style.display = 'none';
		document.getElementById("radioabonoDiferido").style.display = 'none';
		
		if (!flag) borrarError();
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

function bloquearSerie(accion)	{

	var num_abonado = document.getElementById("num_abonado").value;
	var cod_cliente = document.getElementById("cod_cliente").value;
	var cod_ooss 	= document.getElementById("cod_ooss").value;
	var cod_vendedor = document.getElementById("cod_vendedor").value;
	var nom_usuario	= document.getElementById("nom_usuario").value;
	var cod_tipcomis = document.getElementById("cod_tipcomis").value;
	var num_serie = document.getElementById("nroSerie").value;
	var cod_uso = document.getElementById("usoVenta").value;
	var ind_causa = document.getElementById("causaCambio").options[document.getElementById("tipoTerminal").selectedIndex].value;
	var tip_terminal = document.getElementById("tipoTerminal").options[document.getElementById("tipoTerminal").selectedIndex].value;
	var mod_pago = document.getElementById("modalidadPago").options[document.getElementById("modalidadPago").selectedIndex].value;
	var cod_tecnologia = document.getElementById("cod_tecnologia").value;
	var flagT = document.getElementById("flagT").value;
	var flagValidacion = false;
	
	// ----------------------------------------------------------------------------------------
	// Efectuamos las validaciones basicas
	// ----------------------------------------------------------------------------------------	
	if (num_serie == "")	{
		alert("Debe ingresar un número de serie.");
		flagValidacion = true;
	}
	else
		if (isNaN(num_serie)) 	{
				alert("El número de serie debe ser númerico.");
				flagValidacion = true;
			}
		else	
			if (cod_uso == "")			{
				alert("Debe seleccionar un uso.");
				flagValidacion = true;
			}
				
	// ----------------------------------------------------------------------------------------
	
	if (flagValidacion == false)	{
		// No se encuentra bloqueada la serie
		if (document.getElementById("flagBloqueo").value != 1 && accion == "desbloquear")	{
			alert("Debe bloquear un número de serie antes de intentar el desbloqueo.");
			return;
		}
			
		if (flagT == 1) 
			alert("Hay una operación en proceso, espere por favor antes de ejecutar otra solicitud. ");
		else	{
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
													 callbackBloquearSerie);
			} // if
			else	{
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
														 callbackDesbloquearSerie);	
				} // else
	
		} // if flagT
	} // if validacion
			
} // bloquearSerie

// ------------------------------------------------------------------------------------  

function callbackDesbloquearSerie(data)	{
	
	// Muestro mensaje de error
	MensajeRetornoDTO = data;
	mostrarError(MensajeRetornoDTO.mensaje);
	
	// No hubo error
	if (MensajeRetornoDTO.codigo != 1)	{
		// Hay que desbloquear todos los controles
		document.getElementById("causaCambio").disabled = false;
		document.getElementById("tipoContrato").disabled = false;
		document.getElementById("modalidadPago").disabled = false;
		document.getElementById("cuotas").disabled = false;
		document.getElementById("tipoTerminal").disabled = false;
		document.getElementById("abonoDiferido").disabled = false;
		document.getElementById("nroSerie").disabled = false;
		document.getElementById("usoVenta").disabled = false;
		document.getElementById("flagBloqueo").value = 0;		
	}
	
	document.getElementById("flagT").value = 0;
	document.body.style.cursor="default";
	
}	// callbackBloquearSerie

// ------------------------------------------------------------------------------------  

function callbackBloquearSerie(data)	{
	
	// Muestro mensaje de error
	MensajeRetornoDTO = data;
	mostrarError(MensajeRetornoDTO.mensaje);
	
	// No hubo error
	if (MensajeRetornoDTO.codigo != 1)	{
		// Hay que bloquear todos los controles
		document.getElementById("causaCambio").disabled = true;
		document.getElementById("tipoContrato").disabled = true;
		document.getElementById("modalidadPago").disabled = true;
		document.getElementById("cuotas").disabled = true;
		document.getElementById("tipoTerminal").disabled = true;
		document.getElementById("abonoDiferido").disabled = true;
		document.getElementById("nroSerie").disabled = true;
		document.getElementById("usoVenta").disabled = true;		
		document.getElementById("flagBloqueo").value = 1;		
	}

	document.getElementById("flagT").value = 0;
	document.body.style.cursor="default";
	
}	// callbackBloquearSerie

// ------------------------------------------------------------------------------------  

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

	if (document.getElementById("textoerror").innerHTML != "")
		return true;
	
	return false;
	
}	// sePuedeBorrarMensaje
// ------------------------------------------------------------------------------------  

// Validacion para cuando la fecha de inicio no puede ser superior a la fecha de finalizacion
function validaFechas(fechaInicio, fechaFin)	{


}	// validaFechas

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
	
	function closeWindow() {
		var ventana = window.self;
		ventana.opener = window.self;
		ventana.close();
	}	
	
	// ------------------------------------------------------------------------------------------	
	
		