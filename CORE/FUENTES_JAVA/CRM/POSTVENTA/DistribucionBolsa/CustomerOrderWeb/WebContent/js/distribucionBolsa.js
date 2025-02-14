var msgErrorUnAbo     = "Se le asignar&aacute; el total de la bolsa al &uacute;nico abonado inscrito"
var msgErrorSinAbo    = "No existen abonados para distribuir bolsa";
var msgErrorSinDatCli = "No se pudo recuperar informaci&oacute;n del cliente";
var msgErrorFaltaDist = "Existen bolsas de planes que no se han distribuido.";
var msgDistRealizada  = "Se realizó la distribución para el plan tarifario "
var mensaje = "";
var estiloDistribuido = "border-width: 2px; border-style: solid; font-size:8pt; color: #009900;";
//"Se deben distribuir las bolsas para todos los planes"
//Antes de aceptar la distribucion completa se deben distribuir todas las bolsas
var minutesToAssignArr=new Array();
var prcToAssignArr=new Array();
var listaPlanDist=new Array();
var distribucionCompleta='false';
var freeUnits=0;
function verificarCantidadAbonados()
{
	try{
		mensajes.innerHTML="";
		if(document.getElementById("nombreCliente").value == "")
		{
			muestraError(msgErrorSinDatCli);
			bloquearControles();
			return;
		}
		recargarCantidades();
		if(cantidadElementos < 2) 
		{
			var msgerr = msgErrorSinAbo;
			if(cantidadElementos == 1){
				msgerr = msgErrorUnAbo;
				document.forms[0].minutosTotal.value = freeUnits;//freeUnits=document.forms[0].unidadesLibres.value
				RedistribucionBolsaForm.btnDistEqui.disabled = true;
			}
			muestraError(msgerr);
			bloquearControles();
			//return;
		}
		verificarDistCompleta();
		if(mensaje != 'null' && mensaje != ""){
			alert(msgDistRealizada+mensaje);//muestraError(mensaje);
			mensajes.innerHTML="";
		}
	}catch(e){
		alert(e.name + " - "+e.message+" En verificarCantidadAbonados()");
	}
}

function verificarDistCompleta()
{
	try{
		if(distribucionCompleta == 'true'){
			RedistribucionBolsaForm.btnDistCompleta.disabled = false;
		}
		else{
			RedistribucionBolsaForm.btnDistCompleta.disabled = true;
		}
	}catch(e){
		alert(e.name + " - "+e.message+" En verificarDistCompleta()");
	}
}

function validaComboPlanTarif(opcionPlanTarif)
{
	try{
		var mensajes=document.getElementById("mensajes");
		var planSeleccionado = opcionPlanTarif.value;
		if(planSeleccionado == "sel"){
			//document.getElementById("opcion").value = "inicio";
			document.forms[0].accion.value='mostrarPlanes';
			document.forms[0].submit();
			return;
		}
		var indice = planSeleccionado.substring(2,planSeleccionado.length);

	    document.forms[0].submit();

	}catch(e){
		alert(e.name + " - "+e.message+" En validaComboPlanTarif()");
	}
}

function recargarCantidades()
{
	try{
		if(minutesToAssignArr.length == 1)
		{
			RedistribucionBolsaForm.minutesToAssign.value = freeUnits;
			document.getElementById("prcToAssign0").value = 100;
		}
		else
		{
			for(i=0;i<minutesToAssignArr.length;i++)
			{
				RedistribucionBolsaForm.minutesToAssign[i].value = minutesToAssignArr[i];
				document.getElementById("prcToAssign"+i).value = prcToAssignArr[i];
			}
		}
		RedistribucionBolsaForm.btnDistCompleta.disabled = true;
		Suma();
	}catch(e){
		alert(e.name + " - "+e.message+" En recargarCantidades()");
	}
}


function muestraError(msg)
{
	var mensajes=document.getElementById("mensajes");
	mensajes.innerHTML=msg;
}

function bloquearControles(){

	try{
		document.forms[0].unidadesA[0].disabled = "disabled";
		document.forms[0].unidadesA[1].disabled = "disabled";
		document.getElementById("radios").disabled = "disabled";
	}catch(e){
		alert(e.name + " - "+e.message+" En bloquearControles()");
	}
}
		//RedistribucionBolsaForm.minutesToAssign.disabled = true;//si el largo >1 se debe usar como unidadesA
		//RedistribucionBolsaForm.unidadesA.disabled = true;
		/*document.getElementById("rdTipoDist").disabled        = "disabled";	
		document.getElementById("btnAceptar").disabled        = "disabled";
		document.getElementById("btnDistAuto").disabled       = "disabled";
		document.getElementById("unidadesDistTXT").disabled   = "disabled";
		document.getElementById("porcentajeDistTXT").disabled = "disabled";
		document.getElementById("btnLimpiar").style["display"]= "none";
		document.getElementById("actMsgChk").style["display"] = "none";
		document.getElementById("divTest").style["display"]   = "none";*/
		//RedistribucionBolsaForm.disabled="disabled"
