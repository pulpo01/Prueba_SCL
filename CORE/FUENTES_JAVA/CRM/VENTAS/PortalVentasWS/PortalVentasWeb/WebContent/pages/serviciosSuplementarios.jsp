<jsp:include page="/nocache.jsp" flush="true"></jsp:include>

<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/WEB-INF/c.tld" prefix="c" %>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.tmmas.cl.scl.portalventas.web.helper.Utilidades" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>

<head>
<base target="_self"></base>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles</title>
<link href="<%=request.getContextPath()%>/css/mas.css" rel="stylesheet" type="text/css" />
<script type='text/javascript' src='<%=request.getContextPath()%>/js/validador.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/engine.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/util.js'></script>
<script type='text/javascript' src='<%=request.getContextPath()%>/dwr/interface/JServSuplAJAX.js'></script>

<script>
window.history.forward(1);

var icgServicioCorreoMovistar = "<%=session.getAttribute("icgServicioCorreoMovistar")%>";	
var icgServicioFax = "<%=session.getAttribute("icgServicioFax")%>";
var icgServicioAsistencia911 = "<%=session.getAttribute("icgServicioAsistencia911")%>";
var maxContactos911 = "<%=session.getAttribute("maxContactos911")%>";
var codUsoNumeracionFax = "4";
var urlComponenteSS911 = "<%=session.getAttribute("url.componente.ss911")%>";
	
var serviciosProcesadosDescontratar = new Array();
var serviciosProcesadosContratar = new Array();

var listaServiciosDisp = new Array();
var listaServiciosAct  = new Array();
var listaServiciosDef  = new Array();

var codfilaSel = "";
var traspasandoFila = false;

var oContactos = new Array(); 
var oArgumentos = new Object();
oArgumentos.contactos = new Array();


// Indices de la matriz de reglas de validacion
var indCodServicio = 0;
var indTipRelacion = 1;
var indCodServDef = 2;

// Tipos de relaciones
var tipRelIncompatible = 3;

// ------------------------------------------------------------------------------------------------		
// Donde se guardan los contactos de cada SS de asistencia 911
	var arrayContactos911 = new Array();
// ------------------------------------------------------------------------------------------------		


	function fncBuscar() {
	
		var flag = false;
		var colorResaltado = "#CCCCCC";
		var colorNormal = "#F8F8F3";
		
		var cod = document.getElementById("codBusqueda").value;
	
		// Hace la busqueda y si encuentra el codigo, resalta la fila
		for (var indice=0; indice < listaServiciosDisp.length; indice++){

			if (listaServiciosDisp[indice][0] == cod)	{
				var obj = document.getElementById("idSelDisp"+cod);
				obj.focus();
	
				// Limpio la seleccion anterior
				var selAnterior = document.getElementById("fila"+codfilaSel+"TblServDisp")
				
				if (selAnterior != null)
					document.getElementById("fila"+codfilaSel+"TblServDisp").style.backgroundColor=colorNormal;
					
				// Resalto la nueva
				document.getElementById("fila"+cod+"TblServDisp").style.backgroundColor=colorResaltado;
	
				// Guardo la fila que se resalto
				codfilaSel = cod;	
				flag = true;
				
				return;
			}	// if 
		}
		if (!flag) alert("No se ha encontrado el código solicitado.");
	}
	
	function fncValidaSSAAgregar(codigoSS){
		//obtiene grupo a traspasar
		var grupoATraspasar = "";
		for(var indice=0; indice<listaServiciosDisp.length; indice++){
			if (listaServiciosDisp[indice][0] == codigoSS)	{
				grupoATraspasar =listaServiciosDisp[indice][1];
			}
		}//fin for
	
		//(+)validacion 1, verifica que no exista grupo en servicios por defecto	
		for(var indice=0; indice<listaServiciosDef.length; indice++){
			if (listaServiciosDef[indice][1] == grupoATraspasar)	{
				alert("Ya existe el servicio asociado con distinto nivel.")
				document.getElementById("idSelDisp"+codigoSS).checked=false;
				return false;
			}
		}
		//(-)
				
		//(+)validacion 2, verifica que no exista grupo en servicios a activar
		for(var indice=0; indice<listaServiciosAct.length; indice++){
			if (listaServiciosAct[indice][1] == grupoATraspasar && listaServiciosAct[indice][1]!= icgServicioAsistencia911)	{
				if (confirm("Existe el servicio asociado con distinto nivel.\n ¿Quiere cambiar el nivel del grupo asociado?")){
					//quita el anterior, para que se pueda agregar el nuevo
					fncQuitarSS( listaServiciosAct[indice][0]);
					break;
				}else{
					document.getElementById("idSelDisp"+codigoSS).checked=false;				
					return false;
				}
			}
		}
		//(-)
		
		return true;
	}	
	
	//Busca numeracion cuando el ss corresponde a FAX
	function fncBuscarNumero(){		 	

	 	  	document.getElementById("opcion").value = "buscarNumero";
	    	document.forms[0].submit();
	}
	
	
	
	function buscaServiciosIncompatibles(codServicio)	
	{
		var servicios = new Array();		
		try	{
			for (var indice=0; indice < reglas.length; indice++)	
				if ((codServicio == reglas[indice][indCodServicio]) && (reglas[indice][indTipRelacion] == tipRelIncompatible))
					servicios.push(	[reglas[indice][indCodServicio], reglas[indice][indTipRelacion], reglas[indice][indCodServDef]]);
		}	// try
		catch (e)	{
			alert("método buscaServiciosIncompatibles [" + e.name + " - "+e.message + "]");
		}	// catch	
		return servicios;	
	} // buscaServiciosIncompatibles
	
	
	function devuelveIdServicio(codServicio)	
	{
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

	function idServicioDisp(codServicio)	
	{
	
		try	{	
			if (listaServiciosDisp.length!=0)
			{
				for (var disp=0; disp < listaServiciosDisp.length; disp++)
					if (listaServiciosDisp[disp][0] == codServicio)
						return "idSelDisp"+disp;	
			}
		} catch (e)	{
			alert("método idServicioDisp [" + e.name + " - "+e.message + "]");
		}
		return "";		
		
	} 	// idServicioDisp
	
	
	function serviciosIncompatibles(accion, codServicio, isPadre, origen)	
	{
		var servicios = new Array();	
		var idServ = "";
		var idServIncomp = "";
		
		try	{	
			//alert("inicio serviciosIncompatibles codservicio:" + codServicio);
			servicios = buscaServiciosIncompatibles(codServicio);
			if ((servicios.length != 0) && (servicios != null))
			{
				for( var indice=0; indice < servicios.length; indice++){
						if (accion == "D")	{
							idServIncomp = devuelveIdServicio(servicios[indice][indCodServDef]);
							if ((origen=="C") && (idServIncomp != "") && (idServIncomp!="idSelDef"))
							{
								idServ = devuelveIdServicio(codServicio);
								idServGrillaAct = idServicioAct(codServicio);
//								if ((idServ != "") && (idServ!="idSelDef") && (idServGrillaAct=="") && (document.getElementById(idServIncomp).checked))
								if ((idServ != "") && (idServ!="idSelDef") && (idServGrillaAct==""))
								{
									alert("No puede contratar el cod. servicio: " + codServicio + ". Existe incompatibilidad con el cod. servicio contratado: " + servicios[indice][indCodServDef]);
									return("1");//Incompatible
									///document.getElementById(idServ).checked = false;
								}else {
								    return("0"); 
								}
								break;
							}
						} // if	
				}	// for
			} //if
		}	// try
		catch (e)	{
			alert("método serviciosIncompatibles [" + e.name + " - "+e.message + "]");
		}	// catch	
	
    	 return("0"); 
	} // serviciosIncompatibles
	
	
	
	

	/*function fncShow911(codigo)  {    	  				    
  		
  		oArgumentos.cantidad = maxContactos911;     
		var temp = new Array();
		var contact = new Object();
		
        temp = window.showModalDialog(urlComponenteSS911, oArgumentos , "dialogWidth:950px,dialogHeight:500px"); 
        oArgumentos.contactos = temp;
        
        contact.codServicio = codigo
		contact.arrayContactos = temp        
        
        if(temp != null )
        {
	       for (var filaArray=0; filaArray < temp.length; filaArray++)
	       {
				var contacto = new Object();
				contacto['apellido1Contacto']= temp[filaArray].apellido;
				contacto['apellido2Contacto']= temp[filaArray].apellido2;
				contacto['nombreContacto']= temp[filaArray].nombre;
				contacto['codParentesco']= temp[filaArray].parentesco;
				contacto['placaVehicular']= temp[filaArray].placa;
				contacto['colorVehiculo']= temp[filaArray].color;
				contacto['anioVehiculo']= temp[filaArray].anio;
				contacto['codServicio']=codigo;
				contacto['telefono']=temp[filaArray].telefono;			
				
				//Datos de la direccion
				contacto['codProvincia']=temp[filaArray].codProvincia;	
				contacto['codRegion']=temp[filaArray].codRegion;			
				contacto['codCiudad']=temp[filaArray].codCiudad;			
				contacto['codComuna']=temp[filaArray].codComuna;			
				contacto['nomCalle']=temp[filaArray].nomCalle;			
				contacto['numCalle']=temp[filaArray].numCalle;			
				contacto['obsDireccion']=temp[filaArray].obsDireccion;			
				contacto['desDirec1']=temp[filaArray].desDirec1;			
				contacto['zip']=temp[filaArray].zip;				
				contacto['codTipoCalle']=temp[filaArray].codTipoCalle;			
				contacto['codDireccion']=0;
				
		        fncActualizarContactos(contacto);								
		   }
		}//if temp != null
	   				        
     }// show911 */
     
     function fncShow911(codigo)  {    	  				    
		
		var temp = new Array();
		var contact = new Object();

		eliminarContactos(codigo);					
      	temp = window.showModalDialog(urlComponenteSS911, oArgumentos , "dialogWidth:950px,dialogHeight:500px"); 
    	contact.codServicio = codigo
		contact.arrayContactos = temp
		agregarContactos(contact);       
	   				        
     }// show911 
     
     
	
//(+)-- Agrega un nuevo servicio a contratar ---------------------------
	function fncAgregarSS( codigoSS){
		if (!fncValidaSSAAgregar(codigoSS)) return false;
	
		if (traspasandoFila)	 return;
		else	traspasandoFila = true;
		
		for (var indice=0; indice < listaServiciosDisp.length; indice++){
			if (listaServiciosDisp[indice][0] == codigoSS)	{
			
				var incompatible = serviciosIncompatibles("D", codigoSS, true, "C");
				//actualiza lista de servicios a activar
				if(incompatible=="0")
				{	
					//traspasar fila de disponibles a contratados
					var codigo = listaServiciosDisp[indice][0];
					var grupo = listaServiciosDisp[indice][1];
					var nivel = listaServiciosDisp[indice][2];
					var servicio = listaServiciosDisp[indice][3];
					var tipoIP = listaServiciosDisp[indice][4];
					var tipoCobro = listaServiciosDisp[indice][5];
					var tarifaConexion = listaServiciosDisp[indice][6];
					var monedaConexion = listaServiciosDisp[indice][7];
					var tarifaMensual = listaServiciosDisp[indice][8];
					var monedaMensual = listaServiciosDisp[indice][9];																
		  	 
					var tabla = document.getElementById("tablaSSActivados").getElementsByTagName("TBODY")[0];
					var tr = document.createElement("TR"); //crea la nueva fila
					tr.style.backgroundColor="#F8F8F3";
					tr.id = "fila"+codigoSS+"TblServAct";
					tabla.appendChild(tr); //agrega fila a la tabla
	
					var totalFilas = document.getElementById("tablaSSActivados").rows.length;
					var fila = document.getElementById("tablaSSActivados").rows[totalFilas-1];
					
					var tdActivar = document.createElement("TD");//agrega td a la fila
					var elemActivar=document.createElement('input'); 
					elemActivar.type='checkbox'; 
					elemActivar.onclick = function() {fncQuitarSS(codigoSS);}; 
					elemActivar.id = "idSelAct"+codigoSS;				
					tdActivar.appendChild (elemActivar);
					tdActivar.setAttribute("align","left");
					fila.appendChild(tdActivar);
					
					var tdCodigo = document.createElement("TD");
					tdCodigo.appendChild(document.createTextNode(codigo)); 
					tdCodigo.setAttribute("align","left");
					fila.appendChild(tdCodigo);
					
					var tdGrupo = document.createElement("TD");
					tdGrupo.appendChild(document.createTextNode(grupo)); 
					tdGrupo.setAttribute("align","left");
					fila.appendChild(tdGrupo);
					
					var tdNivel = document.createElement("TD");
					tdNivel.appendChild(document.createTextNode(nivel)); 
					tdNivel.setAttribute("align","left");
					fila.appendChild(tdNivel);
					
					var tdServicio = document.createElement("TD");
				
				    // ---------------------------------------------------------------------------------------------------------------------------
				    // -- HGG --
				    if (icgServicioAsistencia911==grupo) {
					     var url=document.createElement('A'); 
					     
					     url.onclick = function show911()  { 
	   	  				    fncShow911(codigo);					   				        
					     }// show911
					     url.href = "#";
					     url.style.fontColor="#0000FF";
					     url.appendChild(document.createTextNode(servicio)); 
					     tdServicio.appendChild(url);
					     
				    } else if (icgServicioFax==grupo){ //Servicio de fax
				    
				         var url=document.createElement('A'); 				     
					     url.onclick = function showFAX()   
					     { 				     
					         fncBuscarNumero();
					         
					     }// showFAX
					     
					     url.href = "#";
					     url.style.fontColor="#0000FF";
					     url.appendChild(document.createTextNode(servicio)); 
					     tdServicio.appendChild(url);			    
				    	
				    
				    } else {
					     tdServicio.appendChild(document.createTextNode(servicio)); 
					     tdServicio.setAttribute("align","left");
				    }
				    fila.appendChild(tdServicio);
				    // ---------------------------------------------------------------------------------------------------------------------------
					
					var tdTipoIP = document.createElement("TD");
					tdTipoIP.appendChild(document.createTextNode(tipoIP));
					tdTipoIP.setAttribute("align","left");		
					fila.appendChild(tdTipoIP);	
					
					var tdTipoCobro = document.createElement("TD");
					tdTipoCobro.appendChild(document.createTextNode(tipoCobro)); 
					tdTipoCobro.setAttribute("align","left");
					fila.appendChild(tdTipoCobro);
	
					var tdTarifaConexion = document.createElement("TD");
					tdTarifaConexion.appendChild(document.createTextNode(tarifaConexion)); 
					tdTarifaConexion.setAttribute("align","left");
					fila.appendChild(tdTarifaConexion);
	
					var tdMonedaConexion = document.createElement("TD");
					tdMonedaConexion.appendChild(document.createTextNode(monedaConexion)); 
					tdMonedaConexion.setAttribute("align","left");
					fila.appendChild(tdMonedaConexion);
	
					var tdTarifaMensual = document.createElement("TD");
					tdTarifaMensual.appendChild(document.createTextNode(tarifaMensual)); 
					tdTarifaMensual.setAttribute("align","left");
					fila.appendChild(tdTarifaMensual);
					
					var tdMonedaMensual = document.createElement("TD");
					tdMonedaMensual.appendChild(document.createTextNode(monedaMensual)); 
					tdMonedaMensual.setAttribute("align","left");
					fila.appendChild(tdMonedaMensual);
	
					//eliminar la fila de lista de disponibles
					var tablaDisp = document.getElementById("tablaSSDisponibles").getElementsByTagName("TBODY")[0];
					var indiceDispSel = -1;
					for (var i=0; elemFilaDisp=tablaDisp.getElementsByTagName('tr')[i]; i++){
						var idFila = elemFilaDisp.getAttribute("id");
						if (idFila == "fila"+codigoSS+"TblServDisp"){
							indiceDispSel = i;
							break;
						}
					}//fin for
	
					if (indiceDispSel!=-1)	tablaDisp.deleteRow(indiceDispSel);
				
				
					//actualiza listas de contratados y disponibles
					fncAgregarSSAct(codigoSS);
					fncEliminarSSDisp(codigoSS);
					
					var obj = document.getElementById("idSelAct"+codigoSS);
					obj.focus();
					
					//actualiza en sesion
					fncActualizarListasSesion('ACT', codigoSS);
				}
				break;
				
			}// fin if
			 
		}//fin for
		
		traspasandoFila = false;
	}//fin fncAgregarSS
	
	function fncAgregarSSAct(codigoSS){
		var listaServiciosTemp = new Array();
		var indiceTemp = 0;
		//traspasa todos los ss a activar
		var indice;	
		//actualiza lista de servicios a activar
		for (indice=0; indice < listaServiciosAct.length; indice++){
				listaServiciosTemp[indice] = listaServiciosAct[indice];
		}
		//agrega el nuevo servicio a activar		
		indiceTemp = indice;
		for (indice=0; indice < listaServiciosDisp.length; indice++){
			if (listaServiciosDisp[indice][0] == codigoSS)	{
				listaServiciosTemp[indiceTemp] = listaServiciosDisp[indice];
				break;;
			}
		}	
		listaServiciosAct = listaServiciosTemp;
	}

	function fncEliminarSSDisp(codigoSS){
		var listaServiciosTemp = new Array();
		var indiceTemp = 0;
		//traspasa todos los servicios menos el que se traspaso
		for (var indice=0; indice < listaServiciosDisp.length; indice++){
			if (listaServiciosDisp[indice][0] != codigoSS)	{
				listaServiciosTemp[indiceTemp] = listaServiciosDisp[indice];
				indiceTemp++;
			}
		}
		//actualiza lista de servicios disponibles
		listaServiciosDisp = listaServiciosTemp;
	}

//(-)-- Agrega un nuevo servicio a contratar ---------------------------
	
//(+)-- elimina un nuevo servicio a contratar ---------------------------
	function fncQuitarSS(codigoSS) {
		if (traspasandoFila) {
			return;
		}
		else {
			traspasandoFila = true;
		}
		
		for (var indice=0; indice < listaServiciosAct.length; indice++) {
			if (listaServiciosAct[indice][0] == codigoSS) {
				//traspasar fila de disponibles a contratados
				var codigo = listaServiciosAct[indice][0];
				var grupo = listaServiciosAct[indice][1];
				var nivel = listaServiciosAct[indice][2];
				var servicio = listaServiciosAct[indice][3];
				var tipoIP = listaServiciosAct[indice][4];
				var tipoCobro = listaServiciosAct[indice][5];
				var tarifaConexion = listaServiciosAct[indice][6];
				var monedaConexion = listaServiciosAct[indice][7];
				var tarifaMensual = listaServiciosAct[indice][8];
				var monedaMensual = listaServiciosAct[indice][9];																
							
				var tabla = document.getElementById("tablaSSDisponibles").getElementsByTagName("TBODY")[0];
				var tr = document.createElement("TR"); //crea la nueva fila
				tr.style.backgroundColor="#F8F8F3";
				tr.id = "fila"+codigoSS+"TblServDisp";
				tabla.appendChild(tr); //agrega fila a la tabla

				var totalFilas = document.getElementById("tablaSSDisponibles").rows.length;
				var fila = document.getElementById("tablaSSDisponibles").rows[totalFilas-1];
				
				var tdActivar = document.createElement("TD");//agrega td a la fila
				var elemActivar=document.createElement('input'); 
				elemActivar.type='checkbox'; 
				elemActivar.onclick =function() {fncAgregarSS(codigoSS);};
				elemActivar.id = "idSelDisp"+codigoSS;
				
				tdActivar.appendChild (elemActivar);
				tdActivar.setAttribute("align","left");
				fila.appendChild(tdActivar);
					
				var tdCodigo = document.createElement("TD");
				tdCodigo.appendChild(document.createTextNode(codigo)); 
				tdCodigo.setAttribute("align","left");
				fila.appendChild(tdCodigo);
				
				var tdGrupo = document.createElement("TD");
				tdGrupo.appendChild(document.createTextNode(grupo)); 
				tdGrupo.setAttribute("align","left");
				fila.appendChild(tdGrupo);
				
				var tdNivel = document.createElement("TD");
				tdNivel.appendChild(document.createTextNode(nivel)); 
				tdNivel.setAttribute("align","left");
				fila.appendChild(tdNivel);
				
				var tdServicio = document.createElement("TD");
				tdServicio.appendChild(document.createTextNode(servicio)); 
				tdServicio.setAttribute("align","left");
				fila.appendChild(tdServicio);

				var tdTipoIP = document.createElement("TD");
				tdTipoIP.appendChild(document.createTextNode(tipoIP));
				tdTipoIP.setAttribute("align","left");		
				fila.appendChild(tdTipoIP);	
				
				var tdTipoCobro = document.createElement("TD");
				tdTipoCobro.appendChild(document.createTextNode(tipoCobro)); 
				tdTipoCobro.setAttribute("align","left");
				fila.appendChild(tdTipoCobro);

				var tdTarifaConexion = document.createElement("TD");
				tdTarifaConexion.appendChild(document.createTextNode(tarifaConexion)); 
				tdTarifaConexion.setAttribute("align","left");
				fila.appendChild(tdTarifaConexion);

				var tdMonedaConexion = document.createElement("TD");
				tdMonedaConexion.appendChild(document.createTextNode(monedaConexion)); 
				tdMonedaConexion.setAttribute("align","left");
				fila.appendChild(tdMonedaConexion);
				
				var tdTarifaMensual = document.createElement("TD");
				tdTarifaMensual.appendChild(document.createTextNode(tarifaMensual)); 
				tdTarifaMensual.setAttribute("align","left");
				fila.appendChild(tdTarifaMensual);
				
				var tdMonedaMensual = document.createElement("TD");
				tdMonedaMensual.appendChild(document.createTextNode(monedaMensual)); 
				tdMonedaMensual.setAttribute("align","left");
				fila.appendChild(tdMonedaMensual);
				
				//eliminar la fila de lista de servicios a activar
				var tablaAct = document.getElementById("tablaSSActivados").getElementsByTagName("TBODY")[0];
				var indiceActSel = -1;
				for (var i=0; elemFilaAct=tablaAct.getElementsByTagName('tr')[i]; i++) {
					var idFila = elemFilaAct.getAttribute("id");
					if (idFila == "fila"+codigoSS+"TblServAct") {
						indiceActSel = i;
						break;
					}
				}//fin for
				
				if (indiceActSel!=-1)	tablaAct.deleteRow(indiceActSel);
				
				//actualiza listas de contratados y disponibles
				fncAgregarSSDisp(codigoSS);
				fncEliminarSSAct(codigoSS);
				
				//actualiza en sesion
				fncActualizarListasSesion('DISP', codigoSS);
				break;
			}// fin if
		}//fin for
		traspasandoFila = false;
	}//fin fncQuitarSS

	function fncAgregarSSDisp(codigoSS){
		var listaServiciosTemp = new Array();
		var indiceTemp = 0;
		//traspasa todos los ss disponibles
		var indice;
		for (indice=0; indice < listaServiciosDisp.length; indice++){
				listaServiciosTemp[indice] = listaServiciosDisp[indice];
		}
		//agrega el nuevo servicio que queda disponible	
		indiceTemp = indice;
		for (indice=0; indice < listaServiciosAct.length; indice++){
			if (listaServiciosAct[indice][0] == codigoSS)	{
				listaServiciosTemp[indiceTemp] = listaServiciosAct[indice];
				break;
			}
		}
		//actualiza lista de servicios disponibles
		listaServiciosDisp = listaServiciosTemp;
	}

	function fncEliminarSSAct(codigoSS){
		var listaServiciosTemp = new Array();
		var indiceTemp = 0;
		//traspasa todos los servicios menos el que se traspaso
		for (var indice=0; indice < listaServiciosAct.length; indice++){
			if (listaServiciosAct[indice][0] != codigoSS)	{
				listaServiciosTemp[indiceTemp] = listaServiciosAct[indice];
				indiceTemp++;
			}
		}
		//actualiza lista de servicios a activar
		listaServiciosAct = listaServiciosTemp;
	}

	//(-)-- elimina un nuevo servicio a contratar ---------------------------	

	function fncActualizarListasSesion(tipoListaTraspaso, codServicio){
		JServSuplAJAX.actualizarListasSesion(tipoListaTraspaso, codServicio, fncDummy());
	}

	function fncActualizarContactos(contactos){
		JServSuplAJAX.cargaContactos(contactos, fncDummy());
	}
	
	var moduloWebOrigen = "<bean:write name='ServiciosSuplementariosForm' property='moduloWebOrigen' />";
	var moduloWebScoring = "<bean:write name='ServiciosSuplementariosForm' property='moduloWebScoring' />";
	var moduloWebSolicitudVenta = "<bean:write name='ServiciosSuplementariosForm' property='moduloWebSolicitudVenta' />";
	
	function fncAceptar(){
    	array2String();
 		if (moduloWebOrigen == moduloWebScoring) {
			document.getElementById("opcion").value = "aceptarScoring";
		}
		if (moduloWebOrigen == moduloWebSolicitudVenta) {
			document.getElementById("opcion").value = "aceptar";
		}
	   	document.forms[0].submit();
	} 	
	
	function fncCancelar() {
		if (moduloWebOrigen == moduloWebScoring) {
			document.getElementById("opcion").value = "cancelarScoring";
		}
		if (moduloWebOrigen == moduloWebSolicitudVenta) {
			document.getElementById("opcion").value = "cancelar";
		}
    	document.forms[0].submit();
	}
	
	function fncVolver(){
		if (confirm("¿Desea volver al men\u00FA?")) {
			parent.fncActDesacMenu(false);
		  	document.getElementById("opcion").value = "irAMenu";
		   	document.forms[0].submit();
		}
	}	
	
	function fncDummy(){}	
	
	//*************************** 911 ***********************/
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
				strArray = strArray + obj.apellido + separadorAtributo;
				strArray = strArray + obj.nombre + separadorAtributo;
				strArray = strArray + obj.parentesco + separadorAtributo;
				strArray = strArray + obj.telefono + separadorAtributo;
				strArray = strArray + obj.placa + separadorAtributo;
				strArray = strArray + obj.color + separadorAtributo;	
				strArray = strArray + obj.anio + separadorAtributo;
				strArray = strArray + obj.direccion + separadorAtributo;			
				strArray = strArray + contacto.codServicio + separadorAtributo;					
				strArray = strArray + correlativoContacto + separadorAtributo;					
				strArray = strArray + obj.apellido2 + separadorAtributo;
				strArray = strArray + obj.parentesco + separadorAtributo;					
				strArray = strArray + obj.codDireccion + separadorAtributo;
				strArray = strArray + obj.codProvincia + separadorAtributo;
				strArray = strArray + obj.codRegion + separadorAtributo;
				strArray = strArray + obj.codCiudad + separadorAtributo;
				strArray = strArray + obj.codComuna + separadorAtributo;
				strArray = strArray + obj.nomCalle + separadorAtributo;
				strArray = strArray + obj.numCalle + separadorAtributo;
				strArray = strArray + obj.numPiso + separadorAtributo;
				strArray = strArray + obj.numCasilla + separadorAtributo;
				strArray = strArray + obj.obsDireccion + separadorAtributo;
				strArray = strArray + obj.desDirec1 + separadorAtributo;
				strArray = strArray + obj.codPueblo + separadorAtributo;
				strArray = strArray + obj.codEstado + separadorAtributo;
				strArray = strArray + obj.zip + separadorAtributo;
				strArray = strArray + obj.codTipoCalle + separadorAtributo+separadorObjecto;
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
	
	//Inicio P-CSR-11002 JLGN 14-06-2011	
	function fncCursorEspera(){
		//document.body.style.cursor = "[b]wait[/b]";
		document.body.style.cursor='wait';
    }
    function fncCursorNormal(){
		//document.body.style.cursor = "[b]default[/b]";
		document.body.style.cursor='default';
    }
	
// -----------------------------------------------------------------------------------------------------------------

</script>
</head>

<body onload="history.go(+1);" onpaste="return false;" onkeydown="validarTeclas();">
<html:form method="POST" action="/ServiciosSuplementariosAction.do" >
<html:hidden property="opcion" value="inicio" styleId="opcion"/>
<input type=hidden id="contactosTabla" name="contactosTabla">


      <table width="80%">
        <tr>
         <td class="amarillo" >
	       <h2><IMG src="<%=request.getContextPath()%>/img/green_arrow.gif" width="15" height="15" hspace="2" align="left">Servicios Suplementarios
         </td>            
        </tr>
      </table>
	  <P>
	  <P>
	  
<table width="90%">
<tr>
	<td class="textoSubTitulo" align="left" colspan="4">Servicios por Defecto</td>
</tr>
<script>
		<%
		try	{
			String html3 = null;
	        // Genero la matriz con los datos de los cargos
	        html3 = Utilidades.generaMatricesServSup(request);
	      	out.println(html3);
		}
		catch (Exception ex)	{
			ex.printStackTrace();
		} 	
		%>
		// ------------------------------------------------------------------------------------------------------------------------
	</script>
<tr><td width="100%">
      <table width="100%" cellpadding="3" cellspacing="3">
      <tr>
	  	<td class="textoColumnaTabla" width="6%">Activar</th>
	  	<td class="textoColumnaTabla" width="6%">C&oacute;digo</th>
	  	<td class="textoColumnaTabla" width="6%">Grupo</th>
	  	<td class="textoColumnaTabla" width="6%">Nivel</th>
	  	<td class="textoColumnaTabla" width="20%">Servicio</th>
	  	<td class="textoColumnaTabla" width="6%">Tipo IP</th>
	  	<td class="textoColumnaTabla" width="10%">Tipo Cobro</th>
	  	<td class="textoColumnaTabla" width="10%">Tarifa Conexi&oacute;n</th>
	  	<td class="textoColumnaTabla" width="10%">Moneda</th>
	  	<td class="textoColumnaTabla" width="10%">Tarifa Mensual</th>
	  	<td class="textoColumnaTabla" width="10%">Moneda</th>	  		  		  		  	
	  </tr>

<logic:notEmpty name="listaServiciosDef" scope="session">
	  <bean:define id="serviciosDef" name="listaServiciosDef" scope="session"/>
	  <logic:iterate indexId="indiceFila" id="ssDef" name="serviciosDef" type="com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO">
	  	  <script>
	  	 var servicioDef = new Array(7);
	  	 servicioDef[0] = "<bean:write name="ssDef" property="codigoServicio"/>";
	  	 servicioDef[1] = "<bean:write name="ssDef" property="codigoGrupo"/>";
	  	 servicioDef[2] = "<bean:write name="ssDef" property="codigoNivel"/>";
	  	 servicioDef[3] = "<bean:write name="ssDef" property="descripServicio"/>";
	  	 servicioDef[4] = "<bean:write name="ssDef" property="indIP"/>";
	  	 servicioDef[5] = "<bean:write name="ssDef" property="tipoCobro"/>";
	  	 servicioDef[6] = "<bean:write name="ssDef" property="tarifaConexion"/>";
	  	 servicioDef[7] = "<bean:write name="ssDef" property="monedaConexion"/>";
	  	 servicioDef[8] = "<bean:write name="ssDef" property="tarifaMensual"/>";
	  	 servicioDef[9] = "<bean:write name="ssDef" property="monedaMensual"/>";  	 	  	 	  	 	  	 
	  	 listaServiciosDef[<c:out value="${indiceFila}"/>]	 =  servicioDef;	 	  	 	  	 	  	 	  	 	  	 
	  </script>
	  <tr class="textoFilasColorTabla">
	   <td><input type=checkbox  checked="checked" disabled="disabled"></td>
   	   <td><bean:write name="ssDef" property="codigoServicio"/></td>
	   <td><bean:write name="ssDef" property="codigoGrupo"/></td>
	   <td><bean:write name="ssDef" property="codigoNivel"/></td>
	   <td><bean:write name="ssDef" property="descripServicio"/></td>
	   <td><bean:write name="ssDef" property="indIP"/></td>
	   <td><bean:write name="ssDef" property="tipoCobro"/></td>
	   <td><bean:write name="ssDef" property="tarifaConexion"/></td>
	   <td><bean:write name="ssDef" property="monedaConexion"/></td>
	   <td><bean:write name="ssDef" property="tarifaMensual"/></td>
	   <td><bean:write name="ssDef" property="monedaMensual"/></td>	
	  </tr>
	  </logic:iterate>
</logic:notEmpty>

	  </table>
</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="textoSubTitulo" align="left" colspan="4">Servicios Activados</td>
</tr>
<tr>
	<td width="100%">
    	<table width="100%" cellpadding="3" cellspacing="3" id="tablaSSActivados">
      		<tr>
			  	<td class="textoColumnaTabla" width="6%">Activar</th>
			  	<td class="textoColumnaTabla" width="6%">C&oacute;digo</th>
			  	<td class="textoColumnaTabla" width="6%">Grupo</th>
			  	<td class="textoColumnaTabla" width="6%">Nivel</th>
			  	<td class="textoColumnaTabla" width="20%">Servicio</th>
			  	<td class="textoColumnaTabla" width="6%">Tipo IP</th>
			  	<td class="textoColumnaTabla" width="10%">Tipo Cobro</th>
			  	<td class="textoColumnaTabla" width="10%">Tarifa Conexi&oacute;n</th>
			  	<td class="textoColumnaTabla" width="10%">Moneda</th>
			  	<td class="textoColumnaTabla" width="10%">Tarifa Mensual</th>
			  	<td class="textoColumnaTabla" width="10%">Moneda</th>	  		  		  		  	
	  		</tr>      
	  
			<logic:notEmpty name="listaServiciosAct" scope="session">
	  			<bean:define id="serviciosAct" name="listaServiciosAct" scope="session"/>
 				<logic:iterate indexId="indiceFila" id="ssAct" name="serviciosAct" type="com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO">
					 <script>
					  	 var servicioAct = new Array(7);
					  	 servicioAct[0] = '<bean:write name="ssAct" property="codigoServicio"/>';
					  	 servicioAct[1] = '<bean:write name="ssAct" property="codigoGrupo"/>';
					  	 servicioAct[2] = '<bean:write name="ssAct" property="codigoNivel"/>';
					  	 servicioAct[3] = '<bean:write name="ssAct" property="descripServicio"/>';
					  	 servicioAct[4] = '<bean:write name="ssAct" property="indIP"/>';
					  	 servicioAct[5] = '<bean:write name="ssAct" property="tipoCobro"/>';
					  	 servicioAct[6] = '<bean:write name="ssAct" property="tarifaConexion"/>';
					  	 servicioAct[7] = '<bean:write name="ssAct" property="monedaConexion"/>';
					  	 servicioAct[8] = '<bean:write name="ssAct" property="tarifaMensual"/>';
					  	 servicioAct[9] = '<bean:write name="ssAct" property="monedaMensual"/>';  
					  	 listaServiciosAct[<c:out value="${indiceFila}"/>] = servicioAct;	 	  	 	  	 	  	 	  	 	  	 
	  				</script>
					 				
				  	<tr class="textoFilasColorTabla" id='fila<bean:write name="ssAct" property="codigoServicio" />TblServAct'>
					   	<td>
					   		<input type=checkbox onclick="fncQuitarSS('<bean:write name="ssAct" property="codigoServicio"/>');" name="idSelAct<bean:write name="ssAct" property="codigoServicio"/>">
					   	</td>
				   	   	<td><bean:write name="ssAct" property="codigoServicio"/></td>
					   	<td><bean:write name="ssAct" property="codigoGrupo"/></td>
					   	<td><bean:write name="ssAct" property="codigoNivel"/></td>
					   	<td>
					   	<script>
					   		gruSSAct = '<bean:write name="ssAct" property="codigoGrupo"/>';
					   		desSSAct = '<bean:write name="ssAct" property="descripServicio"/>';
					   		codigoSSAct = '<bean:write name="ssAct" property="codigoServicio"/>';
					   		if (icgServicioFax == gruSSAct)
					   		{
					   			desSSAct = "<a href=\"#\" onclick=\"fncBuscarNumero()\">" + desSSAct + "</a>";
					   		}
					   		if (icgServicioAsistencia911 == gruSSAct)
					   		{
					   			desSSAct = "<a href=\"#\" onclick=\"fncShow911('"+ codigoSSAct + "')\">" + desSSAct + "</a>";
					   		}
					   		document.write(desSSAct);
					   	</script>
					   	</td>
					   	<td><bean:write name="ssAct" property="indIP"/></td>
					   	<td><bean:write name="ssAct" property="tipoCobro"/></td>
					   	<td><bean:write name="ssAct" property="tarifaConexion"/></td>
					   	<td><bean:write name="ssAct" property="monedaConexion"/></td>
					   	<td><bean:write name="ssAct" property="tarifaMensual"/></td>
					   	<td><bean:write name="ssAct" property="monedaMensual"/></td>	
	  				</tr>
  			</logic:iterate>
			</logic:notEmpty>
	  </table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr>
	<td class="textoSubTitulo" align="left" colspan="4">Servicios Disponibles</td>
</tr>
<tr>
	<td colspan="4">
	 <HR noshade>
	</td>
</tr>

<tr >
	<td nowrap="nowrap">
		BUSCAR CODIGO&nbsp;
       	<input type="text" id="codBusqueda" size="5" maxlength="5" value="" onkeyup="soloCaracteresValidos();" onblur="upperCase(this);" style="text-transform: uppercase;" >
		<html:button  value="BUSCAR" style="width:120px;color:black" property="btnBuscar" styleId="btnBuscar" onclick="fncBuscar();"/>
	</td>
</tr>
<tr><td width="100%">
      <table width="100%" cellpadding="3" cellspacing="3" id="tablaSSDisponibles">
      <tr>
	  	<td class="textoColumnaTabla" width="6%">Activar</th>
	  	<td class="textoColumnaTabla" width="6%">C&oacute;digo</th>
	  	<td class="textoColumnaTabla" width="6%">Grupo</th>
	  	<td class="textoColumnaTabla" width="6%">Nivel</th>
	  	<td class="textoColumnaTabla" width="20%">Servicio</th>
	  	<td class="textoColumnaTabla" width="6%">Tipo IP</th>
	  	<td class="textoColumnaTabla" width="10%">Tipo Cobro</th>
	  	<td class="textoColumnaTabla" width="10%">Tarifa Conexi&oacute;n</th>
	  	<td class="textoColumnaTabla" width="10%">Moneda</th>
	  	<td class="textoColumnaTabla" width="10%">Tarifa Mensual</th>
	  	<td class="textoColumnaTabla" width="10%">Moneda</th>	  		  		  		  	
	  </tr>       
	  
<logic:notEmpty name="listaServiciosDisp" scope="session">	
	  <bean:define id="serviciosDisp" name="listaServiciosDisp" scope="session"/>
	  <logic:iterate indexId="indiceFila" id="ssDisp" name="serviciosDisp" type="com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO">
	  <script>
	  	 var servicioDisp = new Array(7);
	  	 servicioDisp[0] = "<bean:write name="ssDisp" property="codigoServicio"/>";
	  	 servicioDisp[1] = "<bean:write name="ssDisp" property="codigoGrupo"/>";
	  	 servicioDisp[2] = "<bean:write name="ssDisp" property="codigoNivel"/>";
	  	 servicioDisp[3] = "<bean:write name="ssDisp" property="descripServicio"/>";
	  	 servicioDisp[4] = "<bean:write name="ssDisp" property="indIP"/>";
	  	 servicioDisp[5] = "<bean:write name="ssDisp" property="tipoCobro"/>";
	  	 servicioDisp[6] = "<bean:write name="ssDisp" property="tarifaConexion"/>";
	  	 servicioDisp[7] = "<bean:write name="ssDisp" property="monedaConexion"/>";
	  	 servicioDisp[8] = "<bean:write name="ssDisp" property="tarifaMensual"/>";
	  	 servicioDisp[9] = "<bean:write name="ssDisp" property="monedaMensual"/>";  
	  	 listaServiciosDisp[<c:out value="${indiceFila}"/>]	 =  servicioDisp;	 	  	 	  	 	  	 	  	 	  	 
	  </script>
	  
	  <tr class="textoFilasColorTabla" id='fila<bean:write name="ssDisp" property="codigoServicio"/>TblServDisp'>
	   <td>
	   <input type=checkbox id="idSelDisp<bean:write name="ssDisp" property="codigoServicio"/>" onclick="fncAgregarSS('<bean:write name="ssDisp" property="codigoServicio"/>');" name="idSelDisp<bean:write name="ssDisp" property="codigoServicio"/>"  value="<bean:write name="ssDisp" property="codigoServicio"/>" />
	   </td>
   	   <td><bean:write name="ssDisp" property="codigoServicio"/></td>
	   <td><bean:write name="ssDisp" property="codigoGrupo"/></td>
	   <td><bean:write name="ssDisp" property="codigoNivel"/></td>
	   <td><bean:write name="ssDisp" property="descripServicio"/></td>
	   <td><bean:write name="ssDisp" property="indIP"/></td>
	   <td><bean:write name="ssDisp" property="tipoCobro"/></td>
	   <td><bean:write name="ssDisp" property="tarifaConexion"/></td>
	   <td><bean:write name="ssDisp" property="monedaConexion"/></td>
	   <td><bean:write name="ssDisp" property="tarifaMensual"/></td>
	   <td><bean:write name="ssDisp" property="monedaMensual"/></td>	   	   	   	   
	  </tr>
	  </logic:iterate>
</logic:notEmpty>
	  
	  </table>
</td></tr>
</table>

     <P>
     <P>
    <TABLE cellSpacing=0 cellPadding=0 width="80%" border=0 align=center>
      <tr><td>&nbsp;</td></tr>    
      <tr><td>&nbsp;</td></tr>    
      <tr>
        <td width="50%" align="left">
        </td>      
        
        <td align="right" width="25%">
        	<html:button  value="CANCELAR" style="width:120px;color:black" property="btnCancelar" styleId="btnCancelar" onclick="fncCursorEspera();fncCancelar()"/>
        </td>
        <td align="right" width="25%">
			<html:button  value="ACEPTAR" style="width:120px;color:black" property="btnAceptar" styleId="btnAceptar" onclick="fncCursorEspera();fncAceptar();"/>
        </td>
                
      </tr>
    </TABLE> 
</html:form>

</body>
</html:html>