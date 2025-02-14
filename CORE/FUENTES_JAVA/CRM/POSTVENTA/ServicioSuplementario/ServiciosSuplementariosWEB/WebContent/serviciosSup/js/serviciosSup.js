// Indices de la matriz de reglas de validacion
var indCodServicio = 0;
var indTipRelacion = 1;
var indCodServDef = 2;

// Tipos de relaciones
var tipRelLigados = 1;
var tipRelTransferencia = 2;
var tipRelIncompatible = 3;
var tipRelTransfAutomatica = 4;
var tipRelBlackBerry = 5;  // HGG 20/06/208

var serviciosProcesadosDescontratar = new Array();
var serviciosProcesadosContratar = new Array();

var semaforoDWRRetorno=0;
var semaforoRespAplica=0;
var idServWeb=0;

// --------------------------------------------------------------------------------------------------------------------------------------------   

function clickServicio(tipoServicio, radioButton)	{

	try	{
			serviciosProcesadosDescontratar = new Array();
			serviciosProcesadosContratar = new Array();		
	//		var servicios = new Array();
			// Hay que ver si se contrata o descontrata el servicio 
			if (!radioButton.checked)	{
				// Descontratar servicio de lista de disponibles y despliega la transferencia
				if (semaforoDWRRetorno == 0) 	{
					descontrataServicios(radioButton.value);
					//semaforoDWRRetorno=0;
					}
				else{
					radioButton.checked=!radioButton.checked;
					alert("Esta ejecutandose un proceso de validación. favor esperar.");
					}
			} // if
			else{
				contrataServicios(radioButton.value);
			}
		
	}	// try
	catch (e)	{
		alert("método clickServicio [" + e.name + " - "+e.message + "]");
	}
		
} // clickServicio

// -------------------------------------------------------------------------------------------------------------------------------------------   

function descontrataServicios(codServicio)	{

	var idServ = "";
	
	try	{
		// HGG 20/06/08
		/*if ((flagBlackBerryActivado) && (!validaServiciosBBCompatibles(codServicio)))	{
			idServ = devuelveIdServicio(codServicio);
			document.getElementById(idServ).checked = !document.getElementById(idServ).checked;
			alert("No se puede descontratar el servicio [" +codServicio+ "].");
			return;
		} */// if
		
		if (!verificaServicioComoProcesadoDescontratar(codServicio))	{
			idServ = devuelveIdServicio(codServicio);
			//document.getElementById(idServ).checked = true;
			if ((idServ != "") && (idServ!="idSelDef"))	{
			
				/** author rlozano
					date 	08-01-2009
					description Se verifica si el servicio a descontratar corresponde a un servicio de datos,
								a través de la query de obtencion de servicios por defecto.Si es DISTINTO DE NULL , 
								corresponde a un servicio de datos, Luego verificamos si el abonado posee servicio de 
								correo contratado si es DISTINTO DE NULL, aplica mensaje.
				**/
				
				obtListaServSupDef(codServicio);
				//delay(500);
				if (semaforoDWRRetorno==0){
					if (semaforoRespAplica==1){
						
							semaforoRespAplica=0;
							semaforoDWRRetorno=0;
							//document.getElementById(idServ).checked = true;	
							return;
					}
					semaforoRespAplica=0;
					semaforoDWRRetorno=0;	
					marcarServicioComoProcesadoDescontratar(codServicio);
					document.getElementById(idServ).checked = false;
					
								
					if (serviciosAnidadosSelec("D", codServicio)!="")
					{
					//alert("sd");
						serviciosAnidadosHijos("D", codServicio);
					}
					else
						document.getElementById(idServ).checked = true;
					}
					
			} // if
			else{
			document.getElementById(idServ).checked = true;
			}
		
	    }
		//obtListaServSupDef(codServicio);
	} // try
	catch (e)	{
		alert("método descontrataServicios [" + e.name + " - "+e.message + "]");
	}	// catch	
		
} // desContrataServicios

// -------------------------------------------------------------------------------------------------------------------------------------------   

function contrataServicios(codServicio)	{
	
	var arregloGrupo = new Array();
	var arregloGrupo1 = new Array();
	var grupo = '';
	var nivel = '';
	var flag = true;
	var idServ = "";
	
	try	{
	
		if (!verificaServicioComoProcesadoContratar(codServicio))	{
			idServ = devuelveIdServicio(codServicio);
			if ((idServ != "") && (idServ!="idSelDef"))	{
				marcarServicioComoProcesadoContratar(codServicio);
				document.getElementById(idServ).checked = true;

				arregloGrupo = grupoListaTodosServicios(codServicio);			
				if (arregloGrupo.length!=0)
				{
					//--- HGG 
					//--- Variables globales para la integracion de los componentes de asistencia 911 y fax
					var grpServicio = arregloGrupo[0][0];
					var desServicio = arregloGrupo[0][2];

					//--- ini -----------------------------------------
					// HGG 
					var is911enDisponibles=false;
					try{
						document.getElementById(idFilaServicioDisp(codServicio)).getElementsByTagName('td')[4];
						is911enDisponibles=true;
					}
					catch(e)
					{
					is911enDisponibles=false;
					}
					if ((icgServicioAsistencia911==grpServicio)&& is911enDisponibles) {
						// Se activa el enlace al componente
						var tdFilaServicio = document.getElementById(idFilaServicioDisp(codServicio)).getElementsByTagName('td')[4];
						tdFilaServicio.innerHTML = " &nbsp;&nbsp;&nbsp;";
						tdFilaServicio.style.backgroundColor = colorResaltado;
						
						

				     	var url=document.createElement('A'); 
				     	url.onclick = function show911()  { 
							oArgumentos.cantidad = maxContactos911;
						
							var temp = new Array();
							var contact = new Object();

							eliminarContactos(codServicio);
						
				        	temp = window.showModalDialog(urlContactos911, oArgumentos , "dialogWidth:950px,dialogHeight:500px"); 
							contact.codServicio = codServicio
							contact.arrayContactos = temp
						
							agregarContactos(contact);
							
				     	}// show911

				     	url.href = "#";
				     	url.style.fontColor="#0000FF";
				     	url.appendChild(document.createTextNode(desServicio)); 
				     	tdFilaServicio.appendChild(url);
						return;
					 } 
					 else 	
						 //--- ini -----------------------------------------
						if ((icgServicioFax==grpServicio)&& is911enDisponibles) {
							// Se activa el enlace al componente
							var tdFilaServicio = document.getElementById(idFilaServicioDisp(codServicio)).getElementsByTagName('td')[4];
							tdFilaServicio.innerHTML = " &nbsp;&nbsp;&nbsp;";
							tdFilaServicio.style.backgroundColor = colorResaltado;
	
					     	var url=document.createElement('A'); 
					     	url.onclick = function show911()  { 
								oArgumentos.cantidad = maxContactos911;
	
								var temp = new Array();
					        	temp = window.showModalDialog("/ServiciosSuplementariosWEB/serviciosSup/BuscaNumeroAction.do?opcion=inicio", null , "dialogWidth:800px,dialogHeight:700px"); 
					        	oArgumentos.contactos = temp;
					        	oArgumentos.codServicio = codServicio;
					        
					     	}// show911
					     	url.href = "#";
					     	url.style.fontColor="#0000FF";
					     	url.appendChild(document.createTextNode(desServicio)); 
					     	tdFilaServicio.appendChild(url);
	
							return;
						 } 
						else
					 	if ((icgServicioFax==grpServicio)&& is911enDisponibles)	{ //Servicio de fax
							// Se activa el enlace a la pagina
							var tdFilaServicio = document.getElementById(idFilaServicioDisp(codServicio)).getElementsByTagName('td')[4];
							tdFilaServicio.innerHTML = " &nbsp;&nbsp;&nbsp;";
							tdFilaServicio.style.backgroundColor = colorResaltado;
	
					     	var url=document.createElement('A'); 
					     	url.onclick = function showNumeracion()  { 
					     	/*
							 -------------------------------------------------------					     		
					     		FALTA HACER LA LLAMADA A LA PAGINA
							 -------------------------------------------------------					     		
					     	*/
					     	} // showNumeracion
					     	url.href = "#";
					     	url.style.fontColor="#0000FF";
					     	url.appendChild(document.createTextNode(desServicio)); 
					     	tdFilaServicio.appendChild(url);
	
							return;
						 } // if
					
					//--- end -----------------------------------------
					
					
					for (var fila=0; fila < arregloGrupo.length; fila++)
					{	
						grupo = arregloGrupo[fila][0];
						nivel = arregloGrupo[fila][1];
			            
/*			            If (Trim(tAbonado.sCodEstado) != "CO" && sAuxCodGrupo == "14")
			            {
			                        sMsg = "No se puede seleccionar servicio, Abonado en Proceso de Cobranza"
			                        //retorna sMsg en un alert y sale de esta funcion
			            }				*/

						arregloGrupo1 = grupoEnGrillaDefecto(grupo, codServicio);

						if (arregloGrupo1.length!=0)
						{
	                        sCadena = "No es posible activar otro servicio suplementario del mismo grupo, ya existe el servicio " + arregloGrupo1[0][0] + " activado perteneciente al grupo " + arregloGrupo1[0][1] + ".";
							document.getElementById(idServ).checked = false;
							alert(sCadena);
							return "";
						} // if default al plan

						arregloGrupo1 = grupoEnGrillaDisponibles(grupo, codServicio);

						if (arregloGrupo1.length!=0)
						{
	                        sCadena = "Advertencia: Servicio(s) relacionado(s) ya marcado(s) para Activar \n";
	                        sCadena = sCadena + "¿Quiere cambiarlo(s) por el seleccionado?";

							if (confirm(sCadena))	
							{
								for (var fila1=0; fila1 < arregloGrupo1.length; fila1++)
								{	
									if ((grupo==arregloGrupo1[fila1][1]) && (nivel!=arregloGrupo1[fila1][2]))
									{
											descontrataServicios(arregloGrupo1[fila1][0]);
									} // if
								} // for
								flag = false;
								if (serviciosAnidadosSelec("A", codServicio)!="")
								{
									ServiciosAnidados(codServicio);
									serviciosIncompatibles("D", codServicio, true, "D");
								}
							} // if
							else
							{
								document.getElementById(idServ).checked = false;
								return "";
							}
						} // if disponibles

						arregloGrupo1 = grupoEnGrillaContratados(grupo, codServicio);
											
						if (arregloGrupo1.length!=0)
						{
	                        sCadena = "Advertencia: La activación de este servicio implica la desactivación automática de otro servicio \n";
	                        sCadena = sCadena + "¿Desea seguir?";
							
							if (confirm(sCadena))	
							{
								for (var fila1=0; fila1 < arregloGrupo1.length; fila1++)
								{	
									if ((grupo==arregloGrupo1[fila1][1]))
									{
										descontrataServicios(arregloGrupo1[fila1][0]);
										idServOrg=idServ;
									} // if
								} //for
								flag = false;
								if (serviciosAnidadosSelec("A", codServicio)!="")
								{
									ServiciosAnidados(codServicio);
									serviciosIncompatibles("D", codServicio, true, "D");
								}
							}
							else
							{
								document.getElementById(idServ).checked = false;
								return "";
							}
						} //if contratados
						if (flag)
						{
							if (serviciosAnidadosSelec("A", codServicio)!="")
							{
								ServiciosAnidados(codServicio);
								serviciosIncompatibles("D", codServicio, true, "C");
							}
						}
					} // for
				} // if
			} // if		
		} // if
	} // try
	catch (e)	{
		alert("método contrataServicios [" + e.name + " - "+e.message + "]");
	}	// catch	
		
} // contrataServicios

// -------------------------------------------------------------------------------------------------------------------------------------------   
function ServiciosAnidados (codServicio) {
	var servicios =new Array();
	var arregloGrupo = new Array();
	var arregloGrupo1 = new Array();
	var grupo = '';
	var nivel = '';
	servicios = buscaServiciosHijos(codServicio);
	var idServ = "";	
	
	if ((servicios.length != 0))
	{
		for( var indice1=0; indice1 < servicios.length; indice1++)		
		{
			idServ = idServicioAct(servicios[indice1][indCodServDef]);
			//alert("in " + servicios[indice1][indCodServDef])
			if ((buscaServicioDisponible(servicios[indice1][indCodServDef])) || ((idServ!="") && (!buscaServicioContratado(servicios[indice1][indCodServDef]))))
			{//alert("en " + servicios[indice1][indCodServDef]);
				if (!verificaServicioComoProcesadoContratar(servicios[indice1][indCodServDef]))	
				{
					idServ = devuelveIdServicio(servicios[indice1][indCodServDef]);
					if ((idServ != "") && (idServ!="idSelDef"))	
					{
						marcarServicioComoProcesadoContratar(servicios[indice1][indCodServDef]);
						document.getElementById(idServ).checked = true;

						// Primero buscamos el grupo y nivel que tiene el servicio a verificar	
						arregloGrupo = grupoListaTodosServicios(servicios[indice1][indCodServDef]);			
						
						if (arregloGrupo.length!=0)
						{
							for (var fila=0; fila < arregloGrupo.length; fila++)
							{	
								grupo = arregloGrupo[fila][0];
								nivel = arregloGrupo[fila][1];
								
								arregloGrupo1 = grupoEnGrillaContratados(grupo, servicios[indice1][indCodServDef]);

								if (arregloGrupo1.length!=0)
								{
									for (var fila1=0; fila1 < arregloGrupo1.length; fila1++)
									{	
										if ((grupo==arregloGrupo1[fila1][1]) && (nivel!=arregloGrupo1[fila1][2]))
										{
											descontrataServicios(arregloGrupo1[fila1][0]);
										}
									} //for
								} //if contratados
								
								arregloGrupo1 = grupoEnGrillaDisponibles(grupo, servicios[indice1][indCodServDef]);

								if (arregloGrupo1.length!=0)
								{
									for (var fila1=0; fila1 < arregloGrupo1.length; fila1++)
									{
										idServ = idServicioDisp(arregloGrupo1[fila1][0]);
										if ((grupo==arregloGrupo1[fila1][1]) && (nivel!=arregloGrupo1[fila1][2]) && document.getElementById(idServ).checked)
										{
											descontrataServicios(arregloGrupo1[fila1][0]);
										}
									} //for
								} //if disponibles
								serviciosAnidadosHijos("A", servicios[indice1][indCodServDef]);
								serviciosIncompatibles("D", servicios[indice1][indCodServDef], false, "D");
							}
						}
					} // if
				} // if
			} // if
		} // for
	} // if 
} //fin anidados

// -------------------------------------------------------------------------------------------------------------------------------------------   

function serviciosAnidadosSelec(accion, codServicio)	{

	var servicios1 = new Array();	
	var idServ = "";
	var idServPadre = "";
	var idServPadreDef = "";
	var existeEnLista = false;
	var retValueA = "";
	var retValueD = "";
	var cont = 0;
	try	{
		//alert("inicio serviciosAnidadosSelec codservicio:" + codServicio);
		// Traigo los servicios definidos para el servicios que se descontrata
		servicios1 = buscaServiciosAnidadosSelec(codServicio);
		var text = "";
		if (servicios1.length != 0)
		{
			for( var indice1=0; indice1 < servicios1.length; indice1++)	{
				if (accion=="D")
				{
					//alert(servicios1[indice1][indCodServicio]);
					// Si el servicio esta contratado y ademas esta chequeado
					if (buscaServicioContratado(servicios1[indice1][indCodServicio]))	
					{
						if ((!verificaServicioComoProcesadoDescontratar(servicios1[indice1][indCodServicio])) && (servicios1[indice1][tipRelLigados]==tipRelLigados))	
						{
							text = "La desactivación del servicio " + codServicio + ", provocará la desactivación de otros servicios, pues es pre-requisito del servicio " + servicios1[indice1][indCodServicio];
							idServ = devuelveIdServicio(servicios1[indice1][indCodServicio]);
							if (confirm(text))	{
								if ((idServ != "") && (idServ!="idSelDef"))	{
									// HGG 23/06/08
									if ((flagBlackBerryActivado) && (!validaServiciosBBCompatibles(codServicio)))	{
										alert("No se puede descontratar el servicio [" +codServicio+ "].");
										return;
									} // if

									marcarServicioComoProcesadoDescontratar(servicios1[indice1][indCodServicio]);
									document.getElementById(idServ).checked = false;
								} // if
								
								// Se invoca con "D" para desactivar				
								serviciosAnidadosHijos("D", servicios1[indice1][indCodServicio]);
								serviciosTransferencia("A", servicios1[indice1][indCodServicio]);
								retValueD = "OK";
								cont++;
							} // if
							else
							{
								if (cont>0)
									return "OK";
								else
									return "";
							}
						} // if
						else
						{
							retValueD = "OK";
						}
					} // if
					else
					{
						retValueD = "OK";
					}
				} // if
				if (accion=="A")
				{
					idServPadreDef = idServicioDef(servicios1[indice1][indCodServicio]);
					if (idServPadreDef=="")
					{
						idServPadre = idServicioAct(servicios1[indice1][indCodServicio]);
	
						//alert("sdsda" + servicios1[indice1][indCodServicio]);
						if ((idServPadre != "") && (servicios1[indice1][indTipRelacion]==tipRelLigados) && (!buscaServicioContratado(servicios1[indice1][indCodServicio])))
						{
							text = "No se puede activar SS " + codServicio + " por ser desactivado por SS Anidado";
							alert(text);
							idServ = devuelveIdServicio(codServicio);
				
							// HGG 20/06/08
							if ((flagBlackBerryActivado) && (!validaServiciosBBCompatibles(codServicio)))	{
								alert("No se puede descontratar el servicio [" +codServicio+ "].");
								return;
							} // if
							
							if (idServ != "")
								document.getElementById(idServ).checked = false;
							return "";
						} // if
						else
						{
							//alert("fdsfs");
							retValueA = "OK";
						}
					}
					else
					{
						//alert("fdsfs");
						retValueA = "OK";
					}
				} // if
			} // for
			if (accion=="A")
			{
				return retValueA;
			}
			if (accion=="D")
			{
				return retValueD;
			}
		} //if
		else
		{
			return "OK";
		}
	} // try
	catch (e)	{
		alert("método serviciosAnidadosSelec [" + e.name + " - "+e.message + "]");
	}	// catch	
		
} // serviciosAnidadosSelec

// -------------------------------------------------------------------------------------------------------------------------------------------   
// Devuelvo todas las reglas de validacion en las cuales intervenga el servicio a desactivar
// -------------------------------------------------------------------------------------------------------------------------------------------   

function buscaServiciosAnidadosSelec(codServicio)	{

	var servicios = new Array();	
	
	try	{
		for (var indice=0; indice < reglas.length; indice++)	
			if (codServicio == reglas[indice][indCodServDef])	{
				servicios.push(	[reglas[indice][indCodServicio], reglas[indice][indTipRelacion], reglas[indice][indCodServDef]]);
			}
	}	// try
	catch (e)	{
		alert("método buscaServiciosAnidadosSelec [" + e.name + " - "+e.message + "]");
	}	// catch	

	//alert("buscaServiciosAnidadosSelec="+servicios);
	return servicios;	
	
} // buscaServiciosAnidadosSelec

// -------------------------------------------------------------------------------------------------------------------------------------------   	
function serviciosAnidadosHijos(accion, codServicio)	{

	var servicios2 = new Array();	
	var idServ = "";
	var idServDisp = "";
	try	{	
		//alert("inicio serviciosAnidadosHijos codservicio:" + codServicio);
		servicios2 = buscaServiciosHijos(codServicio);
		//alert(servicios2.length);
		if ((servicios2.length != 0))
		{
			for( var indice2=0; indice2 < servicios2.length; indice2++)		{
				if (accion == "D")	{
					idServ = idServicioAct(servicios2[indice2][indCodServDef]);
					idServDisp = idServicioDisp(servicios2[indice2][indCodServDef]);
					
					if ((buscaServicioDisponible(servicios2[indice2][indCodServDef]) && (document.getElementById(idServDisp).checked)) || ((idServ!="") && (buscaServicioContratado(servicios2[indice2][indCodServDef]))))
						{//alert("ededed" + servicios2[indice2][indCodServDef])
						if (!verificaServicioComoProcesadoDescontratar(servicios2[indice2][indCodServDef]))	{
							idServ = devuelveIdServicio(servicios2[indice2][indCodServDef]);
							if ((idServ != "") && (idServ!="idSelDef"))
							{
								// HGG 23/06/08
								if ((flagBlackBerryActivado) && (!validaServiciosBBCompatibles(servicios2[indice2][indCodServDef])))	{
									alert("No se puede descontratar el servicio [" +servicios2[indice2][indCodServDef]+ "].");
									return;
								} // if
								
								marcarServicioComoProcesadoDescontratar(servicios2[indice2][indCodServDef]);
								document.getElementById(idServ).checked = false;
							} // if
							//alert("serviciosAnidadosHijos encontrados:" + servicios2[indice2][indCodServDef]);
							serviciosAnidadosHijos("D", servicios2[indice2][indCodServDef]);
							//alert("serviciosAnidadosHijos (serviciosTransferencia) encontrados:" + servicios2[indice2][indCodServDef]);
							serviciosTransferencia("A", servicios2[indice2][indCodServDef]);
						} // if						
					}
				} // if
	
				if (accion == "A")	{
					if (!verificaServicioComoProcesadoContratar(servicios2[indice2][indCodServDef]))	{					
						idServ = devuelveIdServicio(servicios2[indice2][indCodServDef]);
						if ((idServ != "") && (idServ!="idSelDef"))	{
							marcarServicioComoProcesadoContratar(servicios2[indice2][indCodServDef]);
							document.getElementById(idServ).checked = true;
						} // if
						
						serviciosAnidadosHijos("A", servicios2[indice2][indCodServDef]);
						serviciosIncompatibles("D", servicios2[indice2][indCodServDef],false, "D");
						var mensaje = validaPerteneceGrupo(servicios2[indice2][indCodServDef]);
						if (mensaje != "")	{
							//alert(respuesta);
							return;
						} // if
					} // if						
				} // if
			} // for
		}	// if
	}	// try
	catch (e)	{
		alert("método serviciosAnidadosHijos [" + e.name + " - "+e.message + "]");
	}	// catch	

} // serviciosAnidadosHijos
		
// -------------------------------------------------------------------------------------------------------------------------------------------   
// Devuelvo todas las reglas de validacion en las cuales participen los hijos
// -------------------------------------------------------------------------------------------------------------------------------------------   
function buscaServiciosHijos(codServicio)	{

	var servicios = new Array();	
	
	try	{
		for (var indice=0; indice < reglas.length; indice++)	
			if ((codServicio == reglas[indice][indCodServicio]) && (reglas[indice][indTipRelacion] == tipRelLigados))
				servicios.push(	[reglas[indice][indCodServicio], reglas[indice][indTipRelacion], reglas[indice][indCodServDef]]);
	}	// try
	catch (e)	{
		alert("método buscaServiciosHijos [" + e.name + " - "+e.message + "]");
	}	// catch	

	//alert("buscaServiciosHijos="+servicios);
	return servicios;	
	
} // buscaServiciosHijos

// -------------------------------------------------------------------------------------------------------------------------------------------   
	
function serviciosTransferencia(accion, codServicio)	{

	var servicios = new Array();	
	var idServ = "";	
	try	{	
		//alert("inicio serviciosTransferencia codservicio:" + codServicio);
		servicios = buscaServiciosTransferencia(codServicio);
		if ((servicios.length != 0) && (servicios != null))
		{
			for( var indice=0; indice < servicios.length; indice++)		{
				if (!verificaServicioComoProcesadoContratar(servicios[indice][indCodServDef]))	{			
					if (accion == "A")	{
						idServ = devuelveIdServicio(servicios[indice][indCodServDef]);
						if ((idServ != "") && (idServ!="idSelDef"))	{
							marcarServicioComoProcesadoContratar(servicios[indice][indCodServDef]);
							document.getElementById(idServ).checked = true;
						} // if					
						serviciosAnidadosHijos("A", servicios[indice][indCodServDef]);
						serviciosIncompatibles("D", servicios[indice][indCodServDef],false, "D");
					} // if
				} // if			
			}	// for
		} //if
	}	// try
	catch (e)	{
		alert("método serviciosTransferencia [" + e.name + " - "+e.message + "]");
	}	// catch	

} // serviciosTransferencia
		
// -------------------------------------------------------------------------------------------------------------------------------------------   
		
function serviciosIncompatibles(accion, codServicio, isPadre, origen)	{

	var servicios = new Array();	
	var idServ = "";
	var idServIncomp = "";
	
	try	{	
		//alert("inicio serviciosIncompatibles codservicio:" + codServicio);
		servicios = buscaServiciosIncompatibles(codServicio);
		if ((servicios.length != 0) && (servicios != null))
		{
			for( var indice=0; indice < servicios.length; indice++)		{
				if (!verificaServicioComoProcesadoDescontratar(servicios[indice][indCodServDef]))	{
					if (accion == "D")	{
						idServIncomp = devuelveIdServicio(servicios[indice][indCodServDef]);
						if ((origen=="C") && (idServIncomp != "") && (idServIncomp!="idSelDef"))
						{
							idServ = devuelveIdServicio(codServicio);
							idServGrillaAct = idServicioAct(codServicio);
							if ((idServ != "") && (idServ!="idSelDef") && (idServGrillaAct=="") && (document.getElementById(idServIncomp).checked))
							{
								alert("No puede contratar el cod. servicio: " + codServicio + ". Existe incompatibilidad con el cod. servicio contratado: " + servicios[indice][indCodServDef]);
								document.getElementById(idServ).checked = false;
							}
							break;
						}
						else
						{
							if ((idServIncomp != "") && (idServIncomp!="idSelDef"))	{	
								marcarServicioComoProcesadoDescontratar(servicios[indice][indCodServDef]);
								document.getElementById(idServIncomp).checked = false;
							} // if
							if (!isPadre){				
								serviciosAnidadosHijos("D", servicios[indice][indCodServDef]);
								serviciosTransferencia("A", servicios[indice][indCodServDef]);
							} // if
						} //if
					} // if
				} // if				
			}	// for
		} //if
	}	// try
	catch (e)	{
		alert("método serviciosIncompatibles [" + e.name + " - "+e.message + "]");
	}	// catch	

} // serviciosIncompatibles

// -------------------------------------------------------------------------------------------------------------------------------------------   

function validaPerteneceGrupo(codServicio) {
	var idServ = "";
	try {
		//alert("validaPerteneceGrupo codservicio:" + codServicio);
		var grupo = '';
		var respuesta = '';
		var arregloGrupo = new Array();
		var arregloGrupoDef = new Array();
		// Primero buscamos el grupo que tiene el servicio a verificar	
		arregloGrupo = grupoListaTodosServicios(codServicio);			
		
/*		for (var fila=0; fila < listaTodosServicios.length; fila++)
			if (listaTodosServicios[fila][0] == codServicio)	{
				grupo = listaTodosServicios[fila][1];
				fila = listaTodosServicios.length;
			} // if*/
		if (arregloGrupo.length!=0)
		{
			for (var fila=0; fila < arregloGrupo.length; fila++)
			{	
				grupo = arregloGrupo[fila][0];
				
				// Si encontro el grupo del servicio hay que empezar a comparar
				if (grupo != '')	{
					var nombre = "";
					if (listaTodosServicios.length!=0)
					{
						for (var fila=0; fila < listaTodosServicios.length; fila++)	{
							// Si el servicio que verificamos de la lista tiene el mismo grupo que el seleccionado en la pagina
			
							//si el grupo pertenece a la grilla de servicios por defecto
							//-------------- 	

							arregloGrupoDef = grupoEnGrillaDefecto(grupo, codServicio);
								
							if ((listaTodosServicios[fila][1] == grupo) && (listaTodosServicios[fila][0] != codServicio)&& (arregloGrupoDef.length!=0))	{
								var idServ = "";
								idServ = devuelveIdServicio(listaTodosServicios[fila][0]);
								// Si esta chequeado y ademas pertenece al mismo grupo, hay una incompatibilidad
								
								if ((idServ != "") && (idServ!="idSelDef"))	
								{	
									if (document.getElementById(idServ).checked)	{
										marcarServicioComoProcesadoContratar(listaTodosServicios[fila][0]);
										respuesta = "No es posible activar otro servicio suplementario del mismo grupo, ya existe el servicio " + listaTodosServicios[fila][0] + " activado perteneciente al grupo " + listaTodosServicios[fila][1] + ".";
										document.getElementById(idServ).checked = false;
									} // if				
								} // if
							} // if
							//-----------------------
							//sino
							if ((listaTodosServicios[fila][1] == grupo) && (listaTodosServicios[fila][0] != codServicio)&& (arregloGrupoDef.length==0))
							{
								idServ = devuelveIdServicio(listaTodosServicios[fila][0]);
								if ((idServ != "") && (idServ!="idSelDef"))	{	
									// HGG 23/06/08
									if ((flagBlackBerryActivado) && (!validaServiciosBBCompatibles(listaTodosServicios[fila][0])))	{
										alert("No se puede descontratar el servicio [" +listaTodosServicios[fila][0]+ "].");
										return;
									} // if								
								
									marcarServicioComoProcesadoContratar(listaTodosServicios[fila][0]);
									document.getElementById(idServ).checked = false;
									break;//cortamos el for ;
								}				
							} //if
						} // for
					} //if
				} // if
			} // for
		} // if
	}
	catch (e)	{
		alert("método validaPerteneceGrupo [" + e.name + " - "+e.message + "]");
	}
	return respuesta;
		
} // validaPerteneceGrupo
   
// --------------------------------------------------------------------------------------------------------------------------------------------	

function buscaServiciosTransferencia(codServicio)	{

	var servicios = new Array();	
	try	{
		for (var indice=0; indice < reglas.length; indice++)	
			if ((codServicio == reglas[indice][indCodServicio]) && (reglas[indice][indTipRelacion] == tipRelTransfAutomatica))
				servicios.push(	[reglas[indice][indCodServicio], reglas[indice][indTipRelacion], reglas[indice][indCodServDef]]);
	}	// try
	catch (e)	{
		alert("método buscaServiciosTransferencia [" + e.name + " - "+e.message + "]");
	}	// catch	

	//alert("buscaServiciosTransferencia="+servicios);
	return servicios;	
	
} // buscaServiciosTransferencia

// -------------------------------------------------------------------------------------------------------------------------------------------   

function buscaServiciosIncompatibles(codServicio)	{

	var servicios = new Array();	
	
	try	{
		for (var indice=0; indice < reglas.length; indice++)	
			if ((codServicio == reglas[indice][indCodServicio]) && (reglas[indice][indTipRelacion] == tipRelIncompatible))
				servicios.push(	[reglas[indice][indCodServicio], reglas[indice][indTipRelacion], reglas[indice][indCodServDef]]);
	}	// try
	catch (e)	{
		alert("método buscaServiciosIncompatibles [" + e.name + " - "+e.message + "]");
	}	// catch	

	//alert("buscaServiciosIncompatibles="+servicios);
	return servicios;	
	
} // buscaServiciosIncompatibles

// --------------------------------------------------------------------------------------------------------------------------------------------	

function devuelveIdServicio(codServicio)	{
	var idServ = "";
	var retValue = "";
	try	{	
		retValue = idServicioDef(codServicio);
		if (retValue == "")
			retValue = idServicioAct(codServicio);

			if (retValue == "")
				retValue = idServicioDisp(codServicio);
		
		return retValue;
	}
	catch (e)	{
		alert("método devuelveIdServicio [" + e.name + " - "+e.message + "]");
	}
		
} 	// devuelveIdServicio

// -----------------------------------------------------------------------------------------------------------------

function marcarServicioComoProcesadoDescontratar(codServicio)	{

	try	{	
		serviciosProcesadosDescontratar.push(codServicio);
		serviciosProcesadosContratar.pop(codServicio);
	}	// try
	catch (e)	{
		alert("método marcarServicioComoProcesadoDescontratar [" + e.name + " - "+e.message + "]");
	}	// catch	
		
} 	// marcarServicioComoProcesadoDescontratar

// -----------------------------------------------------------------------------------------------------------------

function marcarServicioComoProcesadoContratar(codServicio)	{

	try	{	
		serviciosProcesadosContratar.push(codServicio);
		serviciosProcesadosDescontratar.pop(codServicio);
	}	// try
	catch (e)	{
		alert("método marcarServicioComoProcesadoContratar [" + e.name + " - "+e.message + "]");
	}	// catch	
		
} 	// marcarServicioComoProcesadoContratar

// -----------------------------------------------------------------------------------------------------------------

function verificaServicioComoProcesadoDescontratar(codServicio)	{
	
	try	{	
		if (serviciosProcesadosDescontratar.length!=0)
		{		
			for( var indice=0; indice < serviciosProcesadosDescontratar.length; indice++)
				if (serviciosProcesadosDescontratar[indice] == codServicio)
					return true;
		}
		return false;		
	}	// try
	catch (e)	{
		alert("método verificaServicioComoProcesadoDescontratar [" + e.name + " - "+e.message + "]");
	}	// catch	
	
} 	// verificaServicioComoProcesadoDescontratar

// -----------------------------------------------------------------------------------------------------------------

function verificaServicioComoProcesadoContratar(codServicio)	{
	
	try	{	
		if (serviciosProcesadosContratar.length!=0)
		{		
			for( var indice=0; indice < serviciosProcesadosContratar.length; indice++)
				if (serviciosProcesadosContratar[indice] == codServicio)
					return true;
		}
		return false;		
	}	// try
	catch (e)	{
		alert("método verificaServicioComoProcesadoContratar [" + e.name + " - "+e.message + "]");
	}	// catch	
	
} 	// verificaServicioComoProcesadoContratar

// -----------------------------------------------------------------------------------------------------------------

function buscaServicioContratado(codServicio)	{
	var idServ = "";
	try	{
		idServ = idServicioAct(codServicio);
		if (idServ != "")
		{
			if (document.getElementById(idServ).checked)	return true;
			else
				return false;
		}
	}	// try
	catch (e)	{
		alert("método buscaServicioContratado [" + e.name + " - "+e.message + "]");
	}	// catch	

} // buscaServicioContratado

// -------------------------------------------------------------------------------------------------------------------------------------------   

function buscaServicioDisponible(codServicio)	{
	var idServ = "";
	try	{
		idServ = idServicioDisp(codServicio);
		//alert(codServicio);
		//alert(idServ);
		if (idServ != "")
			if (!document.getElementById(idServ).checked)	return true;
			else
				return false;
	}	// try
	catch (e)	{
		alert("método buscaServicioDisponible [" + e.name + " - "+e.message + "]");
	}	// catch	

} // buscaServicioDisponible

// -------------------------------------------------------------------------------------------------------------------------------------------   
	
function idServicioDef(codServicio)	{

	try	{
		if (listaServiciosDef.length!=0)
		{
			for (var def=0; def < listaServiciosDef.length; def++)
			{
				if (listaServiciosDef[def][0] == codServicio)
					return "idSelDef";
			}
		}
	}
	catch (e)	{
		alert("método idServicioDef [" + e.name + " - "+e.message + "]");
	}

	return "";		
	
} 	// idServicioDef

// -----------------------------------------------------------------------------------------------------------------
	
function idServicioAct(codServicio)	{

	try	{
		if (listaServiciosAct.length!=0)
		{
			for (var act=0; act < listaServiciosAct.length; act++)
			{
				if (listaServiciosAct[act][0] == codServicio)
					return "idSelAct"+act;
			}
		}
	}
	catch (e)	{
		alert("método idServicioAct [" + e.name + " - "+e.message + "]");
	}

	return "";		
	
} 	// idServicioAct

// -----------------------------------------------------------------------------------------------------------------

function idServicioDisp(codServicio)	{

	try	{	
		if (listaServiciosDisp.length!=0)
		{
			for (var disp=0; disp < listaServiciosDisp.length; disp++)
				if (listaServiciosDisp[disp][0] == codServicio)
					return "idSelDisp"+disp;	}
		}
	catch (e)	{
		alert("método idServicioDisp [" + e.name + " - "+e.message + "]");
	}

	return "";		
	
} 	// idServicioDisp

// -----------------------------------------------------------------------------------------------------------------
//--- HGG : 22/02/10
//--- Devuelve el id de una fila dentro de la tabla de servicios disponibles

function idFilaServicioDisp(codServicio)	{

	try	{	
		if (listaServiciosDisp.length!=0)
		{
			for (var disp=0; disp < listaServiciosDisp.length; disp++)
				if (listaServiciosDisp[disp][0] == codServicio)
					return "fila"+disp+"TblServDisp";	}
		}
	catch (e)	{
		alert("método idServicioDisp [" + e.name + " - "+e.message + "]");
	}

	return "";		
	
} 	// idServicioDisp

// -----------------------------------------------------------------------------------------------------------------
	
function grupoEnGrillaDefecto(grupo, codServicio){
	var arregloGrupo = new Array;

	try	{
		if (listaServiciosDef.length!=0)
		{
			for (var fila=0;fila<listaServiciosDef.length;fila++)
			{
				if (listaServiciosDef[fila][1] == grupo)	{
					arregloGrupo.push([listaServiciosDef[fila][0], listaServiciosDef[fila][1]]);
				} // if
			}//fin for
		}
	}
	catch (e)	{
		alert("método grupoEnGrillaDefecto [" + e.name + " - "+e.message + "]");
		}
	return arregloGrupo;
} // grupoEnGrillaDefecto

// -----------------------------------------------------------------------------------------------------------------
	
function grupoEnGrillaContratados(grupo, codServicio){

	var arregloGrupo = new Array;
	var idServ = "";
	try	{
		if (listaServiciosAct.length!=0)
		{
			for (var fila=0; fila < listaServiciosAct.length; fila++)
			{
				if (listaServiciosAct[fila][1] == grupo)	{
					idServ = devuelveIdServicio(listaServiciosAct[fila][0]);
					if ((idServ != "") && (idServ!="idSelDef"))
						if ((document.getElementById(idServ).checked) && (listaServiciosAct[fila][0] != codServicio)) 
							arregloGrupo.push([listaServiciosAct[fila][0], listaServiciosAct[fila][1]]);
				} // if
			}
		}
	}
	catch (e)	{
		alert("método grupoEnGrillaContratados [" + e.name + " - "+e.message + "]");
		}
	return arregloGrupo;
} // grupoEnGrillaContratados

// -----------------------------------------------------------------------------------------------------------------
	
function grupoEnGrillaDisponibles(grupo, codServicio){

	var arregloGrupo = new Array;
	var idServ = "";
	try	{
		if (listaServiciosDisp.length!=0)
		{
			for (var fila=0; fila < listaServiciosDisp.length; fila++)
			{
				if (listaServiciosDisp[fila][1] == grupo)	{
					idServ = devuelveIdServicio(listaServiciosDisp[fila][0]);
					if ((idServ != "") && (idServ!="idSelDef"))
						if ((document.getElementById(idServ).checked) && (listaServiciosDisp[fila][0] != codServicio)) 
							arregloGrupo.push([listaServiciosDisp[fila][0], listaServiciosDisp[fila][1], listaServiciosDisp[fila][2]]);
				} // if
			}
		}
	}
	catch (e)	{
		alert("método grupoEnGrillaDisponibles [" + e.name + " - "+e.message + "]");
		}
	return arregloGrupo;
} // grupoEnGrillaDisponibles

// -----------------------------------------------------------------------------------------------------------------
	
function grupoListaTodosServicios(codServicio){

	var grupo = new Array;
	try	{
		if (listaTodosServicios.length!=0)
		{
			for (var fila=0; fila < listaTodosServicios.length; fila++)
				if (listaTodosServicios[fila][0] == codServicio)	{
					// -- anterior
					//grupo.push([listaTodosServicios[fila][1], listaTodosServicios[fila][4]]);
					
					// -----------------------------------------------------------------------------
					// HGG 22/02/10
					// Se agrega la descripcion del servicio al objecto que se devuelve					
					grupo.push([listaTodosServicios[fila][1], listaTodosServicios[fila][4], listaTodosServicios[fila][3]]);
				} // if
		}
	}
	catch (e)	{
		alert("método grupoListaTodosServicios [" + e.name + " - "+e.message + "]");
		}
	return grupo;
	
} // grupoListaTodosServicios

// -----------------------------------------------------------------------------------------------------------------
// valida si existe incompatibilidad entre servicios BB
// HGG 20/06/2008
function validaServiciosBBCompatibles(codServicio)	{
		
	try	{
		for (var indice=0; indice < arrayOptimizadoServBB.length; indice++)	
			if (codServicio == arrayOptimizadoServBB[indice][indCodServDef])	return false;

		return true;
	}	// try
	catch (e)	{
		alert("método validaServiciosBBCompatibles [" + e.name + " - "+e.message + "]");
	}	// catch	

	
} // validaServiciosBBCompatibles

// -----------------------------------------------------------------------------------------------------------------
// Serealizacion del array de contactos
// HGG 22/02/2010

function array2String()	{
	
	var strArray = "";
	var separadorAtributo =  "|";
	var separadorObjecto =  "###";


	var correlativoContacto = 1;
	for(var fila=0; fila < arrayContactos911.length; fila++)	{
		var contacto = new Object();		
		contacto = arrayContactos911[fila];

		var filaArray = new Array();		
		filaArray = contacto.arrayContactos;

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

					
				strArray = strArray + contacto.codServicio + separadorAtributo;					
				strArray = strArray + correlativoContacto + separadorAtributo;					
				
				if (obj.apellido2 && obj.apellido2!="")
					strArray = strArray + obj.apellido2 + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;								
				
				if (obj.parentesco && obj.parentesco!="")
					strArray = strArray + obj.parentesco + separadorAtributo;					
				else				
					strArray = strArray + " "+ separadorAtributo;				
					
				if (obj.codDireccion && obj.codDireccion!="")
					strArray = strArray + obj.codDireccion + separadorAtributo;
				else				
					strArray = strArray + " "+ separadorAtributo;				

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
					strArray = strArray + obj.codTipoCalle + separadorAtributo + separadorObjecto;
				else
					strArray = strArray + " "+ separadorAtributo + separadorObjecto;				

					
				correlativoContacto++;
			} // for
		} // if
	} // for
	
	document.getElementById("contactosTabla").value = strArray;

} // str2Array

// -----------------------------------------------------------------------------------------------------------------

	function agregarContactos(obj)	{
		arrayContactos911.push(obj);
	} // agregarContactos

// -----------------------------------------------------------------------------------------------------------------

	function eliminarContactos(codServicio)	{

		for(var fila=0; fila < arrayContactos911.length; fila++)	{
			var contacto = new Object();		
			contacto = arrayContactos911[fila];
			if (contacto.codServicio == codServicio)	
				arrayContactos911.splice(fila, 1, 1);
		} // for
	
	} // eliminarContactos
	
// -----------------------------------------------------------------------------------------------------------------
	