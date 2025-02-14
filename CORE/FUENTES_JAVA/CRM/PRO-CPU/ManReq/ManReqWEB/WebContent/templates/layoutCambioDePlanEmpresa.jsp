<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .:  <c:out value="${clienteOS.nombOss}"/> :.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>


<script type='text/javascript' src='/ManReqWEB/dwr/interface/JCondicionesOOSSEmpresa.js'></script>
<script type='text/javascript' src='/ManReqWEB/dwr/interface/BusquedaAbonadosDWR.js'></script> 
<script type='text/javascript' src='/ManReqWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManReqWEB/dwr/util.js'></script>
<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>

<script language="javascript">
var codPlanTarifOrigen="<c:out value="${clienteOS.cliente.codPlanTarif}"/>";
var codTipoPlanTarif="<c:out value="${clienteOS.cliente.codTipoPlanTarif}"/>";
var flujoIndividualEmpresa="<c:out value="${clienteOS.flujoIndividualEmpresa}"/>";
var usuario="<c:out value="${clienteOS.usuario}"/>";
var codigoCliente="<c:out value="${clienteOS.cliente.codCliente}"/>";
var codOrdenServicio="<c:out value="${clienteOS.codOrdenServicio}"/>";
var numeroAbonado="<c:out value="${clienteOS.numAbonado}"/>";
var modalidad="<c:out value="${clienteOS.modalidad}"/>";
var numAbonados="<c:out value="${clienteOS.cliente.numAbonados}"/>";

var impCargoBasicoCliente="<c:out value="${clienteOS.cliente.impCargoBasico}"/>";
var numIdentCliOrigen = "<c:out value="${clienteOS.cliente.numeroIdentificacion}"/>";
var tipIdentCliOrigen = "<c:out value="${clienteOS.cliente.codigoTipoIdentificacion}"/>";
var controlesId=new Array();
var controlesHab=new Array();
var controlesVis=new Array();
var listaCodPlanTarif=new Array();
var listaDesPlanTarif=new Array();
var listaCodLimiteConsumo=new Array();
var listaDesLimiteConsumo=new Array();
var listaCargoBasico=new Array();
var listaTipoPlanDestino=new Array();
var listaImpFinal = new Array();
var listaCodCargoBasico=new Array();
var listaNumDias=new Array();

var listaCodPlanTarifRango=new Array();
var listaDesPlanTarifRango=new Array();
var listaCodLimiteConsumoRango=new Array();
var listaDesLimiteConsumoRango=new Array();
var listaCargoBasicoRango=new Array();
var listaTipoPlanDestinoRango=new Array();
var listaImpFinalRango = new Array();
var listaCodCargoBasicoRango=new Array();
var listaNumDiasRango=new Array();
var abonados=new Array();


//(+) evera 13/nov, agrega listas para guardar informacion clientes destino pospago
/*var listaCliDestinoCodCliente = new Array();
var listaCliDestinoNombres    = new Array();
var listaCliDestinoApellido1  = new Array();
var listaCliDestinoApellido2  = new Array();
var listaCliDestinoTipIdent	  = new Array();
var listaCliDestinoNumIdent   = new Array();
var listaCliDestinoCicloFacturacion = new Array();

var objCheckAboando; // RRG 19-02-2009 COL 78551
*/
//(-)  evera 13/nov

var origenTipoPlan;
var indice=0;
var indice2=0;
var combinatoriaGenerada="PREPAGOPREPAGO";
var aplicaTraspaso
var numCelular;
var codTecnologia;
var saldo;
var numAbonado;
var codTipoPlanTarifOrigen;
var codPlanServ;
var numVenta;
var indEqPrestado = "";
var error=false;
var numRangos = 0;
var msgErrRango = "Planes tarifarios por rango no se encuentran configurados ";

//evera
var CODIGOMSGCONFIRMAR = 500;
var CODIGOMSGACEPTAR = 600;

 <logic:iterate id="control" name="controlesList" type="com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO">
	controlesId[indice]="<bean:write name='control' property='id'/>";
	controlesHab[indice]="<bean:write name='control' property='habilitado'/>";
	controlesVis[indice]="<bean:write name='control' property='visible'/>";
	indice++;
 </logic:iterate>
 
 

 
 <bean:define id="cliente" name="ClienteOOSS" scope="session"/>
 <c:if test="${clienteOS.cliente.numAbonados >0}">
  <logic:notEmpty name="cliente" property="abonados">
	 <bean:define id="abonados" name="cliente" type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO[]" property="abonados"/>
     <logic:iterate id="abonado" name="abonados"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       numCelular="<bean:write name='abonado' property='numCelular'/>";
       codTecnologia="<bean:write name='abonado' property='codTecnologia'/>";
       numAbonado="<bean:write name='abonado' property='numAbonado'/>";
       codTipoPlanTarifOrigen="<bean:write name='abonado' property='codPlanTarif'/>";
       codPlanServ="<bean:write name='abonado' property='codPlanServ'/>";
       numVenta="<bean:write name='abonado' property='numVenta'/>";
       origenTipoPlan="<bean:write name='abonado' property='desTipPlan'/>";
       indEqPrestado="<bean:write name='abonado' property='indEqPrestado'/>";
     </logic:iterate>
  </logic:notEmpty>
 </c:if>
    
    
function desactivarTodosControles(valor){
	var totalElems = document.forms[0].elements.length;
	for(var i=0;i<totalElems; i++){
		document.forms[0].elements[i].disabled = valor;
	}
	//desactivaBotonSiguiente(); 
}  


function cargaInicial(){
     
	desactivarTodosControles(true);
	document.getElementById("Anterior1").disabled=true;
    document.getElementById("Anterior2").disabled=true;
    
	if (codTipoPlanTarif == "I"){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Cliente no es empresa, no est\u00E1 permitida esta operaci\u00F3n";
		desactivarTodosControles(true);
		desactivaBotonSiguiente(); 
		return false;
	}else if(numAbonados == 0){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Cliente no posee Abonados";
		desactivarTodosControles(true);
		desactivaBotonSiguiente(); 
		return false;
	}
	
	var codVendedor = document.getElementById("codVendedor").value; 
	if (codVendedor == 0){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Usuario ingresado no es valido";
	   	desactivaBotonSiguiente(); 
		desactivaBotonAnterior();
		return false;
	}
	
	JCondicionesOOSSEmpresa.cargaInicial(retornoCargaInicial);
}

function retornoCargaInicial(prd){
    desactivarTodosControles(false);
    
    valoresDefaultCarga();
     
	var tipoPlan = eval('document.CambiarPlanForm.tipoPlanRB');
    if (tipoPlan !=null ){
			for(i=0;i<=tipoPlan.length-1;i++)	{
			  if (tipoPlan[i].value == 'combopre' || tipoPlan[i].value == 'combohib' ){
			    tipoPlan[i].disabled = true;
			  }
			}
    }  	
	var combinatoria = document.getElementById("combinatoria").value;
}

function dumy2(prd){
	//alert("termina evaluarCondiciones!");
}

// mtigua 06-06-2008
function enviarFormulario()  {
  	var codPlanSelec = $("codPlanTarifSelec").value;
  	var rango = document.getElementById("opcionPlanORango").value;
	//alert("rango "+rango);
	if ((codPlanSelec==null || codPlanSelec == '') && rango=="PLAN"){
		mostrarMensajeError ("Debe seleccionar un plan tarifario");
  	   return;
  	}
  	
  	  	
  	var flgAplicaEvaluacion = $("flgAplicaEvaluacion").value;
  	var cargoBasicoPlanSel = $("cargoBasicoSelec").value;
  	var cargoBasicoCliente = impCargoBasicoCliente;//variable global  
    var combinatoria = $("combinatoria").value;
	
	
	if (rango=="RANGO")
	{
		cargoBasicoPlanSel = document.getElementById("montoCargo").value;
		//alert("listaCodPlanTarifRango numRangos "+numRangos);
		if(numRangos<1)
		{
			//alert("numrangos "+document.getElementById("rangoPlanCB").length);
			mostrarMensajeError (msgErrRango);
			return;
		}
	}
  	if (
  	      flgAplicaEvaluacion == "TRUE" &&
  	      (parseInt(cargoBasicoPlanSel) > parseInt(cargoBasicoCliente)) && 
  	      combinatoria!='PREPAGOPREPAGO' && 
  	      combinatoria!='POSPAGOPREPAGO' && 
  	      combinatoria!='HIBRIDOPREPAGO' 
  	   ) 
  	{
		obtenerPlanesEvaluacionRiesgo();
	}
	else {
		
		continuarEnvioFormulario();		
	}	
} 

function obtenerPlanesEvaluacionRiesgo()  {
	var rango = document.getElementById("opcionPlanORango").value;
	var tipoListaPlan = 'planTarifPospago';
	
	if (rango == 'RANGO') tipoListaPlan='rango';
	
    JCondicionesOOSSEmpresa.obtenerPlanesEvaluacion(tipoListaPlan,numIdentCliOrigen,tipIdentCliOrigen,retornoObtenerPlanesEvaluacion);  
}

// inicio RRG 17-02-2009 col  78551
function fncValidaBajaPendiente(prmObjeto) {
	objCheckAboando = prmObjeto;
	BusquedaAbonadosDWR.validaAbonadoBajaProgramada(prmObjeto.value,fncEvaluaRetorno);
}
function fncEvaluaRetorno(data) {
	if (data ==1) {
			alert("Abonado :"+ objCheckAboando.value +" con Orden de Servicio de Baja Programada, no puede realizar cambio de Plan");
			objCheckAboando.checked = false;
			return false;
	} else {
		return true;
	}
}
// fin  RRG 17-02-2009 col 

function retornoObtenerPlanesEvaluacion(data){
    
    if (data!=null){
        var codError = data['codError']; 
	    var mensajeError =  data['msgError']; 
        if (codError != null &&  mensajeError!=null ){
        	mostrarMensajeError("Error al consultar evaluacion de riesgo:"+mensajeError);
        	return;
        }

	 	var numSol = data['numSol'];
		var listaActualizada = data['allLstPTaPlanTarifarioOutDTO'];
		
		var tipoComboPlan ="combopos";
        var rango = document.getElementById("opcionPlanORango").value;		
		if (rango == 'PLAN')    tipoComboPlan = $("radioTipoPlan").value; // combopre,combopos,combohib    
		else					tipoComboPlan = "rangoPlanCB"; // rangoPlanCB
		
	    DWRUtil.removeAllOptions(tipoComboPlan);
	    DWRUtil.addOptions(tipoComboPlan,listaActualizada,"codigoPlanTarifario","descripcionPlanTarifario");
			
		// Seleccionar el plan si antes de dar clic en boton siguiente ya se lo habia seleccionado
		var codPlanSeleccionado = document.getElementById("codPlanTarifSelec").value
		var comboPlan = $(tipoComboPlan);
		var planSeleccionado = null;
	        
		if (codPlanSeleccionado !=null ){ 
			for (index = 0; index< comboPlan.length; index++) {
	       	  if (comboPlan[index].value == codPlanSeleccionado){
	        	comboPlan.selectedIndex = index;
	        	planSeleccionado = listaActualizada[index];
	        	break;
	       	  }  
		    }
	    }
		    
	    if (planSeleccionado == null) {
	       mostrarMensajeError("Debe seleccionar un plan de la lista correspondiente a la evaluación de riesgo");   
	       if (rango=="RANGO"){
	          document.getElementById("montoCargo").value = "";
	          comboPlan.selectedIndex = comboPlan.length;
	       }
	       return;
	    }
	    // Validación de numero abonados seleccionados y lineas del plan
		var cantLineasPlanSel = planSeleccionado.canLineas;
		if (numSol != 0 && cantLineasPlanSel!= 0 ) {    
		    if (parseInt(numAbonados) > parseInt(cantLineasPlanSel) ){
		       mostrarMensajeError("Debe realizar una evaluación de riesgo para el cliente con identificación "+numIdentCliOrigen+" considerando a los"+numAbonados+" abonados");   
		       return;
		    }
		} 

    }//fin if (data!=null)
    
    continuarEnvioFormulario();
}





function continuarEnvioFormulario(){
    // Continua enviando el formulario 
  	if (modalidad==null || modalidad==""){
	  	var mensajes=document.getElementById("mensajes");
      	mensajes.innerHTML="No existe modalidad de pago configurada";
      	desactivaBotonSiguiente(); 
  		return false;
  	}
  	
   	habilitarTodos();
    
    var retornoValidaCampos = validacionCampos();
    if (!retornoValidaCampos){
        var retornoExistenAbonados = existenAbonados();
        if(!retornoExistenAbonados){
            generarCombinatoria();
            var res = esCombinatoriaparaVendedor();
            if (!res) {
            	//alert('Vendedor invalido')
            	return false;
            }
            else {
            	//alert('Vendedor valido')
            }
           	desactivaBotonSiguiente(); 
			evaluarCondicionesCuentaPersonalAjaxOOSS();
		}
    }
}    


//*************Configuracion para vendedor inicio
function esCombinatoriaparaVendedor() 
{
   	DWREngine.setAsync(false);
	var mensajes=document.getElementById("mensajes");
 	//alert('Combinatoria[' + document.getElementById("combinatoria").value + ']');
 	//alert('CodOOSS[' + codOrdenServicio + "]");
	//alert('Usuario[' + usuario + "]");
 	
 	var configuracionVendedorCPU = new Object();
 	configuracionVendedorCPU.cod_ooss = codOrdenServicio;
 	configuracionVendedorCPU.combinatoria = document.getElementById("combinatoria").value;
 	
 	//Verifico  si esta configurado en el xml el vendedor comisionable
	estaVendedorComisionableConfigurado()
	var xmlVendedorComisionable = document.getElementById("xmlVendedorComisionable").value;
	//alert('xmlVendedorComisionable[' + xmlVendedorComisionable + ']')
	
	//Busco la configuracion de la combinatoria para la orden de servicio
 	JCondicionesOOSSEmpresa.recuperarConfiguracionVendedorCPU(configuracionVendedorCPU, {callback:callbackRecuperarConfiguracionVendedorCPU, errorHandler:errorRecuperarConfiguracionVendedorCPU})
	var CombinatoriaConfigurable = document.getElementById("CombinatoriaConfigurable").value;
	//alert('CombinatoriaConfigurable[' + CombinatoriaConfigurable + ']') 	

	//Si el vendedor es comisionable, osea, esta configurado en el xml
	//Si la combinatoria generada para la orden de servicio es comisionable	
	if (xmlVendedorComisionable == "SI" && CombinatoriaConfigurable == 1) {
		var usuarioSistema = new Object();
		usuarioSistema.nom_usuario = usuario;
		
		//Seteo la informacion del usuario y el vendedor
		JCondicionesOOSSEmpresa.obtenerInformacionUsuarioVendedor(usuarioSistema, {callback:callbackObtenerInformacionUsuarioVendedor, errorHandler:errorInformacionUsuarioVendedor});
		var usuarioVendedor = document.getElementById("usuarioVendedor").value;
		if (usuarioVendedor == -1) {
			alert('No se pudo recuperar la informacion del vendedor asociado al usuario. No se puede continuar la orden de servicio')
			return false
		}
		else {
			var msgUsuarioVendedor = document.getElementById("msgUsuarioVendedor").value;
			if (usuarioVendedor == 203) {
				alert(msgUsuarioVendedor)
				return false
			}
		}		

		//Averiguo si el usuario pertenece al grupo comisionable o no		
		JCondicionesOOSSEmpresa.usuarioesdeGrupoComisionable(usuario, {callback:callbackUsuarioesdeGrupoComisionable, errorHandler:errorUsuarioesdeGrupoComisionable} )
		var grupoVendedorComisionable = document.getElementById("grupoVendedorComisionable").value;
		//alert('grupoVendedorComisionable[' + grupoVendedorComisionable + "]");
		
		if (grupoVendedorComisionable == "S") {
			//Hay que ingresar la informacion del vendedor
			//alert('Grupo comisionable');
			return abrirVentanaVendedor();
		}
		else {
			JCondicionesOOSSEmpresa.setUsuarioVendedorenSesion();
			//La informacion deberia tomarse del usuario de sesion
			//alert('Grupo no comisionable')
		}
	}
	else{ // Para el caso de combinatorias no configurables
		JCondicionesOOSSEmpresa.removerUsuarioVendedordeSesion();
	}
   	DWREngine.setAsync(true);
	return true;
} 

function errorRecuperarConfiguracionVendedorCPU() {
	//alert('errorRecuperarConfiguracionVendedorCPU')
}

function errorInformacionUsuarioVendedor() {
	//alert('errorInformacionUsuarioVendedor')
	DWRUtil.setValue("usuarioVendedor", -1);
}

function errorUsuarioesdeGrupoComisionable() {
	//alert('errorUsuarioesdeGrupoComisionable')
}
function estaVendedorComisionableConfigurado() {
	return JCondicionesOOSSEmpresa.estaVendedorComisionableConfigurado(callbackEstaVendedorComisionableConfigurado);
}

function callbackEstaVendedorComisionableConfigurado(data){
	//alert('Configuracion XML VendedorComisionable[' + data + "]");
	DWRUtil.setValue("xmlVendedorComisionable", data);
	return data;
}

function callbackObtenerInformacionUsuarioVendedor(data) {
	//alert('CodMensaje[' + data.codMensaje + "]");
	DWRUtil.setValue("usuarioVendedor", data.codMensaje);
	DWRUtil.setValue("msgUsuarioVendedor", data.mensaje);
	//alert('CodTipMensaje[' + data.codTipMensaje + "]");
	//alert('Mensaje[' + data.mensaje + "]");
}

function callbackRecuperarConfiguracionVendedorCPU(data){
	//alert('Flag configuracion[' + data.flag_estado + "]");
	DWRUtil.setValue("CombinatoriaConfigurable", data.flag_estado);
}


function callbackUsuarioesdeGrupoComisionable(data){
	//alert('grupoVendedorComisionable[' + data + "]");
	DWRUtil.setValue("grupoVendedorComisionable", data);
}

function abrirVentanaVendedor() {
			var urlPath=document.getElementById("contextpathCPU");
			var url = urlPath.value;//"${pageContext.request.contextPath}";
			url = url+"/switch.do?page=/pages/vendedor.jsp&prefix=/cpu";
			var ReturnedValue = window.showModalDialog(url, "winVendedor", "dialogHeight:400px; dialogWidth:650px; center:yes; help:no; status:no; resizable:no");
			//alert("ReturnedValue=["+ReturnedValue+"]");
			if (ReturnedValue == "SI") return true;
			else {
				alert("No ha seleccionado un vendedor se cancelará \nla ejecución de la Orden de Servicio.\nSi continúa la información podría quedar inconsistente.");
				window.close();
			};
}
//*************Configuracion para vendedor fin


 
function validacionCampos()
  {
    error=false; ;
    var opcion = document.getElementById("radioTipoPlan").value;
    var opcionComboPlanTarif = 0;
    var opcionComboClienteDest = 0;
    var mensajes=document.getElementById("mensajes");
    mensajes.innerHTML="";
    activaBotonSiguiente();
    
    if (opcion == "combopre"){
         opcionComboPlanTarif = document.getElementById("combopre").value;
         opcionComboClienteDest = document.getElementById("clienteDestPre").value;
    }
    else if (opcion == "combopos"){
         opcionComboPlanTarif = document.getElementById("combopos").value;
         opcionComboClienteDest = document.getElementById("clienteDestPos").value;
    }
    else if (opcion == "combohib"){
         opcionComboPlanTarif = document.getElementById("combohib").value;
         opcionComboClienteDest = document.getElementById("clienteDestHib").value;
    }  

	var rango = "";
	if (document.getElementById("opcionPlanORango") != null) rango = document.getElementById("opcionPlanORango").value;
	
	if ( (flujoIndividualEmpresa=="I") || (flujoIndividualEmpresa!="I" && rango=="PLAN") ) {
	  if (opcionComboPlanTarif ==""){
         desactivaBotonSiguiente(); 
         mensajes.innerHTML="Debe seleccionar un Plan Tarifario";
         error=true;
         return error;
       }
	}
	
	if (rango=="RANGO"){
		if (document.getElementById("montoCargo").value==""){
         desactivaBotonSiguiente(); 
         mensajes.innerHTML="Debe ingresar Monto Cargo Basico";
         error=true;
         return error;
		}
	}
	
	var listaAbonados = eval('document.CambiarPlanForm.listaAbonados');
    if (listaAbonados !=null ){
         // Verifica que al menos un item haya sido seleccionado
         var isAnyItemSel = false;
         if (listaAbonados.length == undefined){  //Solo hay un registro  
         	isAnyItemSel = listaAbonados.checked; 
         } 
         else {
			for(i=0;i<=listaAbonados.length-1;i++)	{
			  if (listaAbonados[i].checked){
			    isAnyItemSel =  listaAbonados[i].checked;
			    break;
			  }
			}
         }
         
         if (!isAnyItemSel) {
         	desactivaBotonSiguiente(); 
         	mensajes.innerHTML="Debe seleccionar un abonado a procesar";
         	error=true;
         	return error;
         }
    }
	
    if(opcionComboClienteDest ==""){
         desactivaBotonSiguiente(); 
         mensajes.innerHTML="Debe seleccionar un Cliente Destino";
         error=true;
         return error;
    }
    
    var montoCargo = document.getElementById("montoCargo").value;
    var impInicial = document.getElementById("cargoBasicoSelec").value;
    var impFinal   = document.getElementById("impFinalSelec").value;
       
    return error;
  } 
  
function validaMontoCargo(ctrl){
	var monto = eval(ctrl.value);//numRangos
	if (monto!="" && monto!=undefined){
		var mensajes=document.getElementById("mensajes");
	    mensajes.innerHTML="";
        activaBotonSiguiente();
        
		var rangoIni = eval(document.getElementById("cargoBasicoSelec").value);
		var rangoFin = eval(document.getElementById("impFinalSelec").value);	
		if (rangoIni !=undefined && rangoFin !=undefined && 
			!(monto>=rangoIni && monto<=rangoFin) ){
		    desactivaBotonSiguiente(); 
     		mensajes.innerHTML="Monto ingresado no corresponde al rango seleccionado";
			ctrl.value = "";
		}
	}
	if(numRangos<1)
	{
		//alert("numrangos "+document.getElementById("rangoPlanCB").length);
		mostrarMensajeError (msgErrRango);
		return;
	}
}

var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}
 
function valoresDefaultCarga()
{
    var radioCargado="<c:out value="${CambiarPlanForm.tipoPlanRB}"/>";
    activarCombosDependDelPlanEmpresa(radioCargado); 
    
    var combinatoria = document.getElementById("combinatoria").value ;
    var condiciones=document.getElementById("condicionesCK");
    var valorCondicion=document.getElementById("condicH").value;
    
    if (valorCondicion=="SI"){
        condiciones.checked=true;
    }else{
        condiciones.checked=false;
        document.getElementById("condicH").value="NO";
    }
 
    //habilitar combo de RANGO e input de MONTO de cargo
    document.getElementById("montoCargo").disabled=true;
	document.getElementById("rangoPlanCB").disabled=true;
	chequearTodos();
	desHabilitarTodos();

	for(i=0;i<controlesId.length;i++)
	{
	   	seteaControl(controlesId[i], controlesHab[i], controlesVis[i]);
	}
	
	// Ocultar la grilla de abonados
	
	document.getElementById("encabezadoGrilla").style["display"]="none" ;
	document.getElementById("dataGrilla").style["display"]="none";
	
}


function seteaControl(control, habilitado, visible)
{ 
    if (visible=="NO"){
		document.getElementById(control).style["display"]="none";
	}else{
	    if(habilitado=="NO"){
	        document.getElementById(control).disabled=true;
	    }else{
	    	document.getElementById(control).disabled=false;
	    }
	}
	 
}
  
  
function chequearTodos()
{
  	var abonadosCheck = eval("document.CambiarPlanForm.listaAbonados");
 	
	if (abonadosCheck != undefined){
	  	if (abonadosCheck.value != null){
	  		abonadosCheck.checked = true;
	  	}else{
	  		for(var i=0; i<abonadosCheck.length; i++){
	  			abonadosCheck[i].checked = true;
	  		}
	  	}
  	}
}

function desChequearTodos()
{
 	
  	var abonadosCheck = eval("document.CambiarPlanForm.listaAbonados");
  	if (abonadosCheck != undefined){
	  	if (abonadosCheck.value != null){
	  		abonadosCheck.checked = false;
	  	}else{
	  		for(var i=0; i<abonadosCheck.length; i++){
	  			abonadosCheck[i].checked = false;
	  		}
	  	}
	}  	
} 
  
function desHabilitarTodos()
{
    var abonados = eval("document.CambiarPlanForm.listaAbonados");
  	if (abonados.value != null){
  		abonados.disabled = true;
  	}else{
  		for(var i=0; i<abonados.length; i++){
  			abonados[i].disabled = true;
  		}
  	}
  
}   

function habilitarTodos()
{
    var abonados = eval("document.CambiarPlanForm.listaAbonados");
  	if (abonados.value != null){
  		abonados.disabled = false;
  	}else{
  		for(var i=0; i<abonados.length; i++){
  			abonados[i].disabled = false;
  		}
  	}
}  
 
function activarCombosDependDelPlanEmpresa(radio){
      var comboAPrender=radio;
      document.getElementById("radioTipoPlan").value=comboAPrender;
   	  var mensajes=document.getElementById("mensajes");
	  mensajes.innerHTML="";
   	  llenaListaPlanTarifario();
	  generarCombinatoria();
      document.getElementById("codClienteDestSelec").value = document.getElementById("clienteDestPos").value;
      document.getElementById("cargoBasicoSelec").value = "";
      //(+)evera, 19/07/08
      //llenaClienteDestino();//carga informacion de clientes destino
      // Se desactiva cliente destino 
      //document.getElementById("clienteDestPos").disabled=true;     
      //(+)evera, 19/07/08
   	  JCondicionesOOSSEmpresa.buscaClienteSeleccionado(retornoClienteActivarCombosDependDelPlan);
   	  //(-)
}

function retornoClienteActivarCombosDependDelPlan(dataCliente){
    var comboTipoPlan=document.getElementById("radioTipoPlan").value;
    
	if(dataCliente != null){
			//Cargar cliente
			var codigo = dataCliente['codCliente'];
			var nombres = dataCliente['nombres'];		
			var ciclo  = dataCliente['codCiclo'];		
		    var optCliente = document.createElement('option');

			//remover todos los clientes
			DWRUtil.removeAllOptions("clienteDestPos");
			
	        optCliente.text = codigo+"-"+nombres;
	        optCliente.value = codigo;
			        
	        $("clienteDestPos").add(optCliente);
   			$("clienteDestPos").selectedIndex = $("clienteDestPos").length-1;   
	
			 //se actualiza el ciclo destino
			 var codCicloCliente=document.getElementById("codCicloCliente");
			 codCicloCliente.innerHTML = ciclo;
			 document.getElementById("codCicloClienteDestino").value = ciclo;
					 
			 //actualiza cliente seleccionado
			 document.getElementById("codClienteDestSelec").value = codigo;
					 
		 	// Busca y muestra datos del plan tarifario seleccionado
			var indicePlanSel = 0;
			var tipoPlan = 0;
			indicePlanSel = $("clienteDestPos").selectedIndex;
			if (indicePlanSel!=-1 ){
				  var codPlanTarif =  $("clienteDestPos")[indicePlanSel].value;
			 	  document.getElementById("codPlanTarifSelec").value = codPlanTarif;
			
				if(comboTipoPlan=="combopre")	tipoPlan = 1;
				else if(comboTipoPlan=="combopos")	tipoPlan = 2;
				else if(comboTipoPlan=="combohib")	tipoPlan = 3;
							  
				buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
			} 

    		activaBotonSiguiente();
	}// fin if(dataCliente != null)

}

//(+) evera 19/07/08, esta funcion no se usa para empresa
/*
//Funcion que activa o desactiva combos (plan tarifario, cliente destino) y todos los objetos dependientes del radio seleccionado
function activarCombosDependDelPlan(radio)
{	
      var comboAPrender=radio;
      document.getElementById("radioTipoPlan").value=comboAPrender;
      
      var mensajes=document.getElementById("mensajes");
	  mensajes.innerHTML="";

	  llenaListaPlanTarifario();
	  generarCombinatoria();
	   
	  var combinatoria = document.getElementById("combinatoria").value;
	  document.getElementById("linkCliente").style["display"]="";
	  //deshabiltia todos los combos de plan tarifario y habilita el que corresponde de acuerdo al plan tarifario seleccionado (radio)
	  document.getElementById("combopre").style["display"]="none";
	  document.getElementById("combopos").style["display"]="none";
	  document.getElementById("combohib").style["display"]="none";
	  document.getElementById(comboAPrender).style["display"]="";
	  
	  //deshabilita todos los combos de cliente destino
	  document.getElementById("clienteDestPre").style["display"]="none";
	  document.getElementById("clienteDestPos").style["display"]="none";
	  document.getElementById("clienteDestHib").style["display"]="none";
	  
      //dependiendo del plan tarifario seleccionado habilita el combo del cliente destino	
     
	  if(comboAPrender=="combopos"){
	  	document.getElementById("clienteDestPos").style["display"]="";
	  	document.getElementById("codClienteDestSelec").value = document.getElementById("clienteDestPos").value;
	  	document.getElementById("cargoBasicoSelec").value = "";
  		//llenaClienteDestino();//carga informacion de clientes destino, evera 19/07/08
	  }
	  
	 // Actualiza datos del cliente y plan tarifario seleccionado en pantalla
	 
      var codCliente = 0;
      var tipoPlan = 0;
	  if(comboAPrender=="combopre"){
		codCliente = document.getElementById("clienteDestPre").value;
		tipoPlan = 1;
	  }
	  else if(comboAPrender=="combopos"){
	  	codCliente = document.getElementById("clienteDestPos").value;
	  	tipoPlan = 2;
	  }
	  else if(comboAPrender=="combohib"){
	  	codCliente = document.getElementById("clienteDestHib").value;
	  	tipoPlan = 3;
	  }
	  buscaClienteSeleccionado(codCliente,tipoPlan);
	
	  // Busca y muestra datos del plan tarifario seleccionado
	  var comboPlanTarif = document.getElementById(comboAPrender);
      var indicePlanSel = $(comboAPrender).selectedIndex;
	  if (indicePlanSel!=-1 ) 	{
	 	 var codPlanTarif =  $(comboAPrender)[indicePlanSel].value;
	  	 buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
	  }
	  //(-)
} 
*/
//(-)
 

function activarPlanORango(radio)
{
	 var mensajes=document.getElementById("mensajes");
     mensajes.innerHTML="";
     activaBotonSiguiente();
     
    var radioAPrender=radio.value;
  	if(radioAPrender=="radioPlan"){
  	    document.getElementById("opcionPlanORango").value="PLAN";
  		document.getElementById("montoCargo").disabled=true;
  		document.getElementById("rangoPlanCB").disabled=true;
  		
  		document.getElementById("combopos").disabled=false;
  	}else{
  	    document.getElementById("opcionPlanORango").value="RANGO";
  		llenaListaPlanTarifario();
		document.getElementById("combopos").disabled=true;
		if(numRangos<1)
		{
			mostrarMensajeError (msgErrRango);
			return;
		}
		document.getElementById("montoCargo").disabled=false;
  		document.getElementById("rangoPlanCB").disabled=false;
  		
  		
  		
  		var codRangoSelec = document.getElementById("rangoPlanCB").value;
  		
	    //atributosPlanTarifarioEmpresa(codRangoSelec);
  	}
  	
}


function asignaValorAControl()
{
      var condiciones = document.getElementById("condicionesCK");
      document.getElementById("condicH").value=condiciones.checked?"SI":"NO";
       
}  

function validaComboPlanTarif(opcionPlanTarif)
{
     var mensajes=document.getElementById("mensajes");
     document.getElementById("codPlanTarifSelec").value = opcionPlanTarif.value;
     atributosPlanTarifario(opcionPlanTarif.value);
     mensajes.innerHTML="";
     activaBotonSiguiente();
     
     var tipoPlan = 0;
	 var radio=document.getElementById("radioTipoPlan").value;
     if (radio=="combopre"){
    	tipoPlan = 1;
     }
     else if (radio=="combopos"){
     	tipoPlan = 2;
     } 
     else if (radio=="combohib"){
     	tipoPlan = 3;
	 }
     
     buscaPlanTarifSeleccionado(opcionPlanTarif.value,tipoPlan); 

     if(codPlanTarifOrigen == opcionPlanTarif.value)
     {
        desactivaBotonSiguiente(); 
     	mensajes.innerHTML="Imposible ejecutar Orden de Servicio para el mismo Plan Tarifario";
     }
} 
  
function validaComboPlanTarifRango(opcionPlanTarif)
{
     
     var mensajes=document.getElementById("mensajes");
     document.getElementById("codPlanTarifSelec").value = opcionPlanTarif.value;
     activaBotonSiguiente();
	 atributosPlanTarifarioEmpresa(opcionPlanTarif.value);
	 mensajes.innerHTML="";
	 if(codPlanTarifOrigen == opcionPlanTarif.value){
	    desactivaBotonSiguiente(); 
	    mensajes.innerHTML="Imposible ejecutar Orden de Servicio para el mismo Plan Tarifario";
	 }
	 
     document.getElementById("montoCargo").value = "";
} 

//(+) evera, 19/07/08
/* 
function validaComboClienteDestino(opcionClienteDestino)
  {
    
    var mensajes=document.getElementById("mensajes");
    document.getElementById("codClienteDestSelec").value = opcionClienteDestino.value;
    //$("primerApellido").value = primerApellido;
    //$("segundoApellido").value = segundoApellido;
    //$("tipoIdentificacionCliente").value = codigoTipoIdentificacion;
    //$("numeroIdentificacionCliente").value = numeroIdentificacion;

    mensajes.innerHTML="";
    activaBotonSiguiente();
	var tipoPlan = 0;
	var radio=document.getElementById("radioTipoPlan").value;
    if (radio=="combopre"){
    	tipoPlan = 1;
    } else if (radio=="combopos"){
     	tipoPlan = 2;
    } else if (radio=="combohib"){
     	tipoPlan = 3;
	}
	
	buscaClienteSeleccionado(opcionClienteDestino.value,tipoPlan);
  }
 */ 
//(-)

//(+) evera 13/nov, funciones para evaluacion crediticia -----------------------------------------  

//(+) evera, 19/07/08
//funcion que obtiene los atributos del cliente destino 
/*function llenaClienteDestino(){
 	var radio=document.getElementById("radioTipoPlan").value;
    i=0;
    if (radio=="combopos"){
 	       	<logic:iterate id="listaClientesDestino" name="clientesPospago" scope="session" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO">
	       	    listaCliDestinoCodCliente[i]= "<bean:write name='listaClientesDestino' property='codCliente'/>";
		        listaCliDestinoNombres[i]   = "<bean:write name='listaClientesDestino' property='nombres'/>";
		        listaCliDestinoApellido1[i] = "<bean:write name='listaClientesDestino' property='apellido1'/>";
		        listaCliDestinoApellido2[i] = "<bean:write name='listaClientesDestino' property='apellido2'/>";
		        listaCliDestinoTipIdent[i]  = "<bean:write name='listaClientesDestino' property='codigoTipoIdentificacion'/>";
		        listaCliDestinoNumIdent[i]  = "<bean:write name='listaClientesDestino' property='numeroIdentificacion'/>";
		        i++;
	        </logic:iterate>
    } 	
}
*/
//(-)


//(-) evera 13/nov, funciones para evaluacion crediticia-----------------------------------------------

function validaCheck(opcion)
{
    var mensajes=document.getElementById("mensajes");
    var opcionChekeada=opcion.value;
    mensajes.innerHTML="";
    activaBotonSiguiente();
}  
   
 
function activaBotonSiguiente()
  {
     document.getElementById("Siguiente1").disabled=false;
     document.getElementById("Siguiente2").disabled=false;
  }  
  
function desactivaBotonSiguiente()
  {
     document.getElementById("Siguiente1").disabled=true;
     document.getElementById("Siguiente2").disabled=true;
  }  
  
function generarCombinatoria() 
  {
	  var destinoTipoPlan;
	  var opcionPlanSelec=document.getElementById("radioTipoPlan").value;
	  
	  if (opcionPlanSelec=="combopre"){
	  	  destinoTipoPlan="PREPAGO";
	  }
	  else if (opcionPlanSelec=="combopos"){
	  	  destinoTipoPlan="POSPAGO";
	  }
	  else if (opcionPlanSelec=="combohib"){
	  	  destinoTipoPlan="HIBRIDO";
	  }
	  combinatoriaGenerada = origenTipoPlan + destinoTipoPlan; 
	  
	  document.getElementById("combinatoria").value=combinatoriaGenerada;
  }  

  
function existenAbonados()
  {

     error=false;
     var sel  = 0;
     var totalAbo = 0;
        
     //var check = document.getElementById("listaAbonados");
     var check = eval("document.CambiarPlanForm.listaAbonados");
     
     if(check.value != null){
        totalAbo = 1 ;
        if (check.checked){
           sel = 1;
        }
     }else{
             totalAbo = check.length;
             for(var i=0; i<totalAbo; i++){
	             if(check[i].checked){
	                sel = 1;
	                break
	             }
             }
     }
     
     if (sel == 0){
          desactivaBotonSiguiente(); 
          mensajes.innerHTML="Debe seleccionar al menos un Abonado de la lista";
          error=true;
          return error;
     }
    
   return error; 
   
  }  

function evaluarCondicionesAjaxOOSS()
  {
      
  	  var parametrosCondicionesOS=new Object();
  	  parametrosCondicionesOS['codOOSS']=codOrdenServicio;
  	  parametrosCondicionesOS['numCelular']=numCelular;
  	  parametrosCondicionesOS['codTecnologia']=codTecnologia;
  	  parametrosCondicionesOS['numAbonado']=numeroAbonado;
  	  parametrosCondicionesOS['codPlanTarifActual']=codTipoPlanTarifOrigen;
  	  parametrosCondicionesOS['codPlanServ']=codPlanServ;
  	  parametrosCondicionesOS['combinatoriaGenerada']=combinatoriaGenerada;  //evera 28/08/07
  	  parametrosCondicionesOS['usuario']=usuario;
  	  parametrosCondicionesOS['codCliente']=codigoCliente;
  	  parametrosCondicionesOS['numVenta']=numVenta;
  	  parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	  parametrosCondicionesOS['codClienteDestino']=document.getElementById("codClienteDestSelec").value;
  	  parametrosCondicionesOS['tipoPlanTarifDestino']=document.getElementById("tipoPlanTarifDestino").value;
  	  if (document.getElementById("opcionPlanORango").value == "RANGO"){  //gsaavedra 04/03/08
  	     parametrosCondicionesOS['codPlanTarifSelec']= document.getElementById("rangoPlanCB").value;
  	  }
  	  
  	//obtener abonados seleccionados  	
  	var totalAboSel = 0;
    //var check = document.getElementById("listaAbonados");
    var check = eval("document.CambiarPlanForm.listaAbonados");
    if(check.value != null){
     	if (check.checked) totalAboSel = 1 ;
    }else{
	     for(var i=0; i<check.length; i++){
		      if(check[i].checked) totalAboSel = totalAboSel + 1;
	     }
    }
     
	if (totalAboSel > 0){
	  	var arrAbonados = new Array(totalAboSel);
  	 	
  	 	if(check.value != null){//1 abonado
  	 		arrAbonados[0] = check.value;
  	 	}else{
		     for(var i=0; i<check.length; i++){
			      if(check[i].checked)	arrAbonados[i] = check[i].value;
		     }
  	 	}
 	    
 	   //validaCondicionesInicio
 	  //JCondicionesOOSSEmpresa.validaCondiciones(parametrosCondicionesOS,retornoConsideracionesAjaxReturn);  	   	 
 	  JCondicionesOOSSEmpresa.validaCondicionesInicio(parametrosCondicionesOS, arrAbonados, retornoConsideracionesAjaxReturn);//evera 27/08/07 
 	}
 	
  }

function actualizarPlanTarifario(codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias){
     
     if (codigoPlanTarifario!='') {        
  	  		var radio=document.getElementById("radioTipoPlan");       
  	  	    
  	  	    var comboPlan;
  	  	    var tipoPlan;
	        if (radio.value == "combopre"){
	        	comboPlan = $("combopre");
	        	tipoPlan = 1; 
	        } 
	        else if (radio.value == "combopos"){
				comboPlan = $("combopos");
				tipoPlan = 2;
	        }
	        else if (radio.value == "combohib"){
	        	comboPlan = $("combohib");
	        	tipoPlan = 3;
	        }

			// Si encuentra el item en la lista lo selecciona
  	  	    var itemEncontrado = false; 
	  		for (index = 0; index< comboPlan.length; index++) {
           	  if (comboPlan[index].value == codigoPlanTarifario){
            	comboPlan.selectedIndex = index;
            	itemEncontrado = true;
            	break;
           	  }  
            }
			// Sino encuentra el item en la lista lo agrega
			if (!itemEncontrado){
			  	var optPlanTarif = document.createElement('option');
	            optPlanTarif.value = codigoPlanTarifario;
	            optPlanTarif.text = codigoPlanTarifario+"-"+descripcionPlanTarifario;
				comboPlan.add(optPlanTarif);
		   		comboPlan.selectedIndex = comboPlan.length-1;
		   		actualizaListaPlanTarifario(tipoPlan,codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias);
			}
			
			// Muestra atributos del plan en pantalla
			$("codLimiteConsumo").innerHTML =  codigoLimiteConsumo;
			$("desLimiteConsumo").innerHTML = descripcionLimiteConsumo;
			$("cargoBasico").innerHTML = importeCargoBasico
		
			$("desPlanTarifSelec").value = descripcionPlanTarifario;
			$("cargoBasicoSelec").value = importeCargoBasico;
			$("tipoPlanTarifDestino").value = tipoPlanTarifario;
			$("codLimiteConsumoSelec").value = codigoLimiteConsumo ;
			$("codCargoBasicoDestino").value = codigoCargoBasico;
			$("numDiasDestino").value = numDias;	
	        
     }     
}


// funcion que obtiene los restantes atributos del plan tarifario de acuerdo al plan seleccionado por el usuario

function llenaListaPlanTarifario() {
    
       var i=0;
       var radio=document.getElementById("radioTipoPlan").value;
       listaCodPlanTarif=new Array();
       listaDesPlanTarif=new Array();
       listaCodLimiteConsumo=new Array();
       listaDesLimiteConsumo=new Array();
       listaCargoBasico=new Array();
       listaTipoPlanDestino=new Array();
       listaCodCargoBasico=new Array();
       listaNumDias=new Array();
       listaImpFinal=new Array();
		
       if (radio=="combopre"){
        
	       	<logic:iterate id="lista" name="planTarifPrepago" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
	       	    listaCodPlanTarif[i]= "<bean:write name='lista' property='codPlanTarif'/>";
		        listaDesPlanTarif[i]= "<bean:write name='lista' property='desPlanTarif'/>";
		        listaCodLimiteConsumo[i]= "<bean:write name='lista' property='limiteConsumo'/>";
		        listaDesLimiteConsumo[i]= "<bean:write name='lista' property='descripcionLimiteConsumo'/>";
		        listaCargoBasico[i] = "<bean:write name='lista' property='impCargoBasico'/>";
		        listaTipoPlanDestino[i] = "<bean:write name='lista' property='tipoPlanTarifario'/>";
			    listaCodCargoBasico[i] = "<bean:write name='lista' property='codCargoBasico'/>";   
   			    listaNumDias[i] = "<bean:write name='lista' property='numDias'/>";   
   			    listaImpFinal[i] = "<bean:write name='lista' property='impFinal'/>";   
		        i++;
	        </logic:iterate>
       }
       i=0;
       if (radio=="combopos"){
       
	       	<logic:iterate id="lista" name="planTarifPospago" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
	       	    listaCodPlanTarif[i]= "<bean:write name='lista' property='codPlanTarif'/>";
		        listaDesPlanTarif[i]= "<bean:write name='lista' property='desPlanTarif'/>";
		        listaCodLimiteConsumo[i]= "<bean:write name='lista' property='limiteConsumo'/>";
		        listaDesLimiteConsumo[i]= "<bean:write name='lista' property='descripcionLimiteConsumo'/>";
		        listaCargoBasico[i] = "<bean:write name='lista' property='impCargoBasico'/>";
		        listaTipoPlanDestino[i] = "<bean:write name='lista' property='tipoPlanTarifario'/>";
		        listaCodCargoBasico[i] = "<bean:write name='lista' property='codCargoBasico'/>";   
   			    listaNumDias[i] = "<bean:write name='lista' property='numDias'/>";  
   			    listaImpFinal[i] = "<bean:write name='lista' property='impFinal'/>";      			    
		        i++;
	        </logic:iterate>
       }
       i=0;
       if (radio=="combohib"){
       
	       	<logic:iterate id="lista" name="planTarifHibrido" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
	       	    listaCodPlanTarif[i]= "<bean:write name='lista' property='codPlanTarif'/>";
		        listaDesPlanTarif[i]= "<bean:write name='lista' property='desPlanTarif'/>";
		        listaCodLimiteConsumo[i]= "<bean:write name='lista' property='limiteConsumo'/>";
		        listaDesLimiteConsumo[i]= "<bean:write name='lista' property='descripcionLimiteConsumo'/>";
		        listaCargoBasico[i] = "<bean:write name='lista' property='impCargoBasico'/>";
			    listaTipoPlanDestino[i] = "<bean:write name='lista' property='tipoPlanTarifario'/>";    
			    listaCodCargoBasico[i] = "<bean:write name='lista' property='codCargoBasico'/>";   
   			    listaNumDias[i] = "<bean:write name='lista' property='numDias'/>";  	
   			    listaImpFinal[i] = "<bean:write name='lista' property='impFinal'/>";      			    		    
		        i++;
	        </logic:iterate>
       }
       
       var rango =  document.getElementById("opcionPlanORango");
       
       if (rango != null && rango.value == "RANGO"){
       
           	listaCodPlanTarifRango=new Array();
			listaDesPlanTarifRango=new Array();
			listaCodLimiteConsumoRango=new Array();
			listaDesLimiteConsumoRango=new Array();
			listaCargoBasicoRango=new Array();
			listaTipoPlanDestinoRango=new Array();
			listaImpFinalRango = new Array();
			listaCodCargoBasicoRango = new Array();
			listaNumDiasRango=new Array();
	
   	       	<logic:iterate id="lista" name="rango" scope="session" type="com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO">
	       	    listaCodPlanTarifRango[i]= "<bean:write name='lista' property='codPlanTarif'/>";
		        listaDesPlanTarifRango[i]= "<bean:write name='lista' property='desPlanTarif'/>";
		        listaCodLimiteConsumoRango[i]= "<bean:write name='lista' property='limiteConsumo'/>";
		        listaDesLimiteConsumoRango[i]= "<bean:write name='lista' property='descripcionLimiteConsumo'/>";
		        listaCargoBasicoRango[i] = "<bean:write name='lista' property='impCargoBasico'/>";
			    listaTipoPlanDestinoRango[i] = "<bean:write name='lista' property='tipoPlanTarifario'/>";    
			    listaCodCargoBasicoRango[i] = "<bean:write name='lista' property='codCargoBasico'/>";   
   			    listaNumDiasRango[i] = "<bean:write name='lista' property='numDias'/>";  			    
   			    listaImpFinalRango[i] = "<bean:write name='lista' property='impFinal'/>";      			    
		        i++;
	        </logic:iterate>
			numRangos = listaCodPlanTarifRango.length;
       }
       
    
}

function atributosPlanTarifario(codPlanSelec){

    var j=0;
       
   	for(j=0;j<listaCodPlanTarif.length;j++) {
   	    if(listaCodPlanTarif[j]==codPlanSelec){
    	        
   	        //guarda en variables hidden los atributos seleccionados dependiendo del plan tarifario seleccionado
   	        if(listaDesPlanTarif[j]!=null){
   	        	document.getElementById("desPlanTarifSelec").value=listaDesPlanTarif[j];
   	        }
   	        if(listaCargoBasico[j] !=null){
   	        	document.getElementById("cargoBasicoSelec").value=listaCargoBasico[j];
   	        }
   	        if(listaTipoPlanDestino[j] !=null){
   	        	document.getElementById("tipoPlanTarifDestino").value=listaTipoPlanDestino[j];
   	        }
   	        if(listaCodLimiteConsumo[j] !=null){
   	        	document.getElementById("codLimiteConsumoSelec").value=listaCodLimiteConsumo[j];
   	        }
   	        if(listaCodCargoBasico[j]!= null){
   	        	document.getElementById("codCargoBasicoDestino").value=listaCodCargoBasico[j];
   	        }
   	        if(listaNumDias[j]!= null){
   	        	document.getElementById("numDiasDestino").value=listaNumDias[j];
   	        }    	        
   	    }
   	}
        
}
    
function atributosPlanTarifarioEmpresa(codPlanSelec){

   var j=0;
    var codLimiteConsumo=document.getElementById("codLimiteConsumo");
    var desLimiteConsumo=document.getElementById("desLimiteConsumo");
    var cargoBasico=document.getElementById("cargoBasico");
    var numDias=document.getElementById("numDias");
       
    	for(j=0;j<listaCodPlanTarifRango.length;j++) {
    	    if(listaCodPlanTarifRango[j]==codPlanSelec){
    	        //guarda en variables hidden los atributos seleccionados dependiendo del plan tarifario seleccionado
    	        if(listaDesPlanTarifRango[j]!=null){
    	        	document.getElementById("desPlanTarifSelec").value=listaDesPlanTarifRango[j];
    	        }
    	        if(listaCargoBasicoRango[j] !=null){
    	        	document.getElementById("cargoBasicoSelec").value=listaCargoBasicoRango[j];
    	        }
    	        if(listaTipoPlanDestinoRango[j] !=null){
    	        	document.getElementById("tipoPlanTarifDestino").value=listaTipoPlanDestinoRango[j];
    	        }
    	        if(listaCodLimiteConsumoRango[j] !=null){
    	        	document.getElementById("codLimiteConsumoSelec").value=listaCodLimiteConsumoRango[j];
    	        }
    	        if(listaCodCargoBasicoRango[j]!= null){
    	        	document.getElementById("codCargoBasicoDestino").value=listaCodCargoBasicoRango[j];
    	        }
    	        if(listaNumDiasRango[j]!= null){
    	        	document.getElementById("numDiasDestino").value=listaNumDiasRango[j];
    	        }    	        
    	        if(listaImpFinalRango[j]!= null){
    	        	document.getElementById("impFinalSelec").value=listaImpFinalRango[j];
    	        }    	        
    	       	        
    	    }
    	}
        
}
    
function limpiarAtributosPlanTarifario(){
	var codLimiteConsumo=document.getElementById("codLimiteConsumo");
	var desLimiteConsumo=document.getElementById("desLimiteConsumo");
    var cargoBasico=document.getElementById("cargoBasico");
    codLimiteConsumo.innerHTML="";
    desLimiteConsumo.innerHTML="";
    cargoBasico.innerHTML="";
    
}

//---------------------------------------------------------------------------------------------------
/*function evaluarCondicionesAjaxOOSS()
  {
      
  	  var parametrosCondicionesOS=new Object();
  	  parametrosCondicionesOS['codOOSS']=codOrdenServicio;
  	  parametrosCondicionesOS['numCelular']=numCelular;
  	  parametrosCondicionesOS['codTecnologia']=codTecnologia;
  	  parametrosCondicionesOS['numAbonado']=numeroAbonado;
  	  parametrosCondicionesOS['codPlanTarifActual']=codTipoPlanTarifOrigen;
  	  parametrosCondicionesOS['codPlanServ']=codPlanServ;
  	  parametrosCondicionesOS['combinatoriaGenerada']=combinatoriaGenerada;  //evera 28/08/07
  	  parametrosCondicionesOS['usuario']=usuario;
  	  parametrosCondicionesOS['codCliente']=codigoCliente;
  	  parametrosCondicionesOS['numVenta']=numVenta;
  	  parametrosCondicionesOS['codTipoPlanTarif']=codTipoPlanTarif; // gs
  	  parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	  parametrosCondicionesOS['codClienteDestino']=document.getElementById("codClienteDestSelec").value;
  	  parametrosCondicionesOS['tipoPlanTarifDestino']=document.getElementById("tipoPlanTarifDestino").value;
  	  if(flujoIndividualEmpresa=="I"){
	  	  parametrosCondicionesOS['codCausaBajaSel']=document.getElementById("causaBajaCB").value;
	  }

  	  
  	//obtener abonados seleccionados  	
  	var totalAboSel = 0;
    //var check = document.getElementById("listaAbonados");
    var check = eval("document.CambiarPlanForm.listaAbonados");

    if(check.value != null){
     	if (check.checked) totalAboSel = 1 ;
    }else{
	     for(var i=0; i<check.length; i++){
		      if(check[i].checked) totalAboSel = totalAboSel + 1;
	     }
    }
     
	if (totalAboSel > 0){
	  	var arrAbonados = new Array(totalAboSel);
  	 	
  	 	if(check.value != null){//1 abonado
  	 		arrAbonados[0] = check.value;
  	 	}else{
  	 		var indiceSel = 0;
		     for(var i=0; i<check.length; i++){
		     
			      if(check[i].checked){
			      	arrAbonados[indiceSel] = check[i].value;
			      	indiceSel++;
			      }
			      
		     }
  	 	}
 	    
  	  //validaCondicionesInicio 	   	 
 	  JCondicionesOOSSEmpresa.validaCondicionesInicio(parametrosCondicionesOS, arrAbonados, retornoConsideracionesAjaxReturn);//evera 27/08/07 
 	}
 	
  }*/
  
//(+) evera 28/08/07  
function evaluarCondicionesAjaxOOSScontinuar(codigoMsg, respuestaMsg)
  {
      
      var parametrosCondicionesOS=new Object();
  	  parametrosCondicionesOS['codOOSS']=codOrdenServicio;
  	  parametrosCondicionesOS['numCelular']=numCelular;
  	  parametrosCondicionesOS['codTecnologia']=codTecnologia;
  	  parametrosCondicionesOS['numAbonado']=numeroAbonado;
  	  parametrosCondicionesOS['codPlanTarifActual']=codTipoPlanTarifOrigen;
  	  parametrosCondicionesOS['codPlanServ']=codPlanServ;
  	  parametrosCondicionesOS['combinatoriaGenerada']=combinatoriaGenerada;  //evera 28/08/07
  	  parametrosCondicionesOS['usuario']=usuario;
  	  parametrosCondicionesOS['codCliente']=codigoCliente;
  	  parametrosCondicionesOS['numVenta']=numVenta;
  	  parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	  parametrosCondicionesOS['codClienteDestino']=document.getElementById("codClienteDestSelec").value;
  	  parametrosCondicionesOS['tipoPlanTarifDestino']=document.getElementById("tipoPlanTarifDestino").value;
  	  if (document.getElementById("opcionPlanORango").value == "RANGO"){  //gsaavedra 04/03/08
  	     parametrosCondicionesOS['codPlanTarifSelec']= document.getElementById("rangoPlanCB").value;
  	  }
  	  

	  JCondicionesOOSSEmpresa.validaCondicionesContinuar(parametrosCondicionesOS, codigoMsg, respuestaMsg, retornoConsideracionesAjaxReturn);
  }  
//(-) evera 28/08/07  

function activaAceptar()
{
	document.getElementById("Aceptar").disabled=false; //habilita
}


//------------------Funciones de respuesta-------------------------------------

function retornoConsideracionesAjaxReturn(data)
  {
      if(data != null){
          
	      var valoresRetorno=data;
	      msg=valoresRetorno['mensaje'];
	      
	  	  if (msg == null){
	  	       
     	 	   document.getElementById("codActuacion").value = valoresRetorno['codActuacion'];
       	       document.getElementById("codOSAnt").value = valoresRetorno['codOSAnt'];
			   document.getElementById("codPlanServNuevo").value = valoresRetorno['codPlanServNuevo']; 
   			   document.getElementById("fecDesdeLlam").value = valoresRetorno['fecDesdeLlam']; 
   			   document.getElementById("periodoFact").value = valoresRetorno['periodoFact']; 
   			   document.getElementById("aplicaTraspaso").value = valoresRetorno['aplicaTraspaso'];  
   			   document.getElementById("saldo").value = valoresRetorno['saldo'];  
   			   			   			   
		 	   //alert("Condiciones para esta Orden de Servicio Fueron Evaluadas Correctamente");
			       document.forms[0].submit();
		  }else{
		  
		  		//(+)evera 28/08      
	    		var codMensaje = valoresRetorno['codMensaje'] ;
				var codTipMensaje = valoresRetorno['codTipMensaje'];
				
				if (codTipMensaje == CODIGOMSGCONFIRMAR){
					var respConfirm = confirm(msg);
					var respuesta = ' ';
					if (respConfirm){
					    respuesta = 'S';
					}else{
					    respuesta = 'N';
					} 
					
					evaluarCondicionesAjaxOOSScontinuar(codMensaje, respuesta);						 
					
				}
				else if(codTipMensaje == CODIGOMSGACEPTAR){
					var abonadosValidos = valoresRetorno['abonadosValidos'];
					var abonadosLista = eval("document.CambiarPlanForm.listaAbonados");
					
					//borra los abonados seleccionados por el usuario y marca solo los validos
					if (abonadosValidos!=null){
						var numAboValidos = abonadosValidos.length;
						
						if (numAboValidos >0 && abonadosLista.length>1){
							//deschequea todos los abonados de la lista
							for(var j=0; j<abonadosLista.length; j++) abonadosLista[j].checked = false;
							
							//chequea solo los validos
							for(var i=0; i<numAboValidos; i++){ //abonados validos
								for(var j=0; j<abonadosLista.length; j++){ //abonados listados
									if (abonadosValidos[i].numAbonado == abonadosLista[j].value){
										abonadosLista[j].checked = true;
									}
								}
							}//fin chequea solo los validos
						}
					}//fin abonadosValidos!=null
 	    
					alert(msg);
					evaluarCondicionesAjaxOOSScontinuar(codMensaje, ' ');
				}else{ //mensaje de error
				  	var mensajes=document.getElementById("mensajes");
	   		      	mensajes.innerHTML=msg;
	   		      	desactivaBotonSiguiente();
	   		      	if (msg == " ") activaBotonSiguiente();
		  		}
		  		//(-)evera 28/08
		  						
	   		     /* var mensajes=document.getElementById("mensajes");
	   		      mensajes.innerHTML=msg;
	   		      desactivaBotonSiguiente();*/
				  
		  }
		 		  
      }else{
      	  alert("No es posible continuar con la orden de servicio");
      }
  
  } 
  
  function actualizaListaCliente(tipoCliente) {
     JCondicionesOOSSEmpresa.actualizaListaCliente(tipoCliente);
  }  
  

  function buscaClienteSeleccionado(codCliente,tipoPlan) {
  	 JCondicionesOOSSEmpresa.buscaClienteSeleccionado(codCliente,tipoPlan,actualizaDatosCliente);
  }
  
  function actualizaDatosCliente(cliente){
     if (cliente != null){
	    var codCicloCliente=document.getElementById("codCicloCliente");
		codCicloCliente.innerHTML = cliente.codCiclo;
     }
  }
  
  function actualizaListaPlanTarifario(tipoPlan,codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias) {
    JCondicionesOOSSEmpresa.actualizaListaPlanTarifario(tipoPlan,codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias);
  }  
  
  function buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan){
	JCondicionesOOSSEmpresa.buscaPlanTarifSeleccionado(codPlanTarif,tipoPlan,actualizaAtributosPlan);	
  }
  
  
  function actualizaAtributosPlan(planTarif) {
  	if (planTarif!=null){
		var codLimiteConsumo = $("codLimiteConsumo");
		if (codLimiteConsumo!=null) codLimiteConsumo.innerHTML = planTarif.limiteConsumo;
		var desLimiteConsumo = $("desLimiteConsumo");
		if (desLimiteConsumo!=null ) desLimiteConsumo.innerHTML = planTarif.descripcionLimiteConsumo;
		var cargoBasico =  $("cargoBasico");
		if (cargoBasico!=null ) cargoBasico.innerHTML = planTarif.impCargoBasico;
		$("desPlanTarifSelec").value = planTarif.desPlanTarif;
		$("cargoBasicoSelec").value = planTarif.impCargoBasico;
		$("tipoPlanTarifDestino").value = planTarif.tipoPlanTarifario;
		$("codLimiteConsumoSelec").value = planTarif.limiteConsumo;
		$("codCargoBasicoDestino").value = planTarif.codCargoBasico;
		$("numDiasDestino").value = planTarif.numDias;	
		
		//Ingreso de Numeros Frecuentes CPU santiago
		$("numFrecFijos").value = planTarif.numFrecFijos;
		$("numFrecMovil").value = planTarif.numFrecMovil;
		$("indFf").value = planTarif.indFf;
		
		validaActivaNumFrecuentes();
	}	
  }
  
//[+]-------------------Funciones cuenta Personal--------------------------------------------------- yosses 14/01/08

function evaluarCondicionesCuentaPersonalAjaxOOSS()
  {
      
  	  var parametrosCondicionesOS=new Object();
  	  parametrosCondicionesOS['codOOSS']=codOrdenServicio;
  	  parametrosCondicionesOS['numCelular']=numCelular;
  	  parametrosCondicionesOS['codTecnologia']=codTecnologia;
  	  parametrosCondicionesOS['numAbonado']=numeroAbonado;
  	  parametrosCondicionesOS['numAbonados']=numAbonados;
  	  parametrosCondicionesOS['codPlanTarifActual']=codTipoPlanTarifOrigen;
  	  parametrosCondicionesOS['codPlanServ']=codPlanServ;
  	  parametrosCondicionesOS['combinatoriaGenerada']=combinatoriaGenerada;  //evera 28/08/07
  	  parametrosCondicionesOS['usuario']=usuario;
  	  parametrosCondicionesOS['codCliente']=codigoCliente;
  	  parametrosCondicionesOS['numVenta']=numVenta;
  	  parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	  parametrosCondicionesOS['codClienteDestino']=document.getElementById("codClienteDestSelec").value;
  	  parametrosCondicionesOS['tipoPlanTarifDestino']=document.getElementById("tipoPlanTarifDestino").value;
 	   
  	//obtener abonados seleccionados  	
  	var totalAboSel = 0;
    //var check = document.getElementById("listaAbonados");
    var check = eval("document.CambiarPlanForm.listaAbonados");
    if(check.value != null){
     	if (check.checked) totalAboSel = 1 ;
    }else{
	     for(var i=0; i<check.length; i++){
		      if(check[i].checked) totalAboSel = totalAboSel + 1;
	     }
    }
     
	if (totalAboSel > 0){
	  	var arrAbonados = new Array(totalAboSel);
  	 	
  	 	if(check.value != null){//1 abonado
  	 		arrAbonados[0] = check.value;
  	 	}else{
		     for(var i=0; i<check.length; i++){
			      if(check[i].checked)	arrAbonados[i] = check[i].value;
		     }
  	 	}
  	   
  	  //validaCuentaPersonal yosses 14/01/08	
 	   JCondicionesOOSSEmpresa.ValidaCuentaPersonal(parametrosCondicionesOS, arrAbonados, retornoConsideracionesAjaxReturn2); 
 	}
 	 	   
 	
  }
  
function retornoConsideracionesAjaxReturn2(data){//inicio

      if(data != null){          
	      var valoresRetorno=data;
	      var mensajeRetorno =  valoresRetorno ['mensaje'];

	      msg=valoresRetorno['codActuacion'];
	      
	      var abonadosValidos = valoresRetorno['abonadosValidos'];
		      if(msg != null){

			      if((msg == 'ESPERSONAL') || (msg == 'TIENEPERSONAL') || (msg == 'BAJA')){	      
				      	if(confirm(mensajeRetorno)){
				      		evaluarCondicionesAjaxOOSS();
				      	}else{
				      		alert('No se puede continuar con esta solicitud');
				      		desactivaBotonSiguiente();
				      	} 	
			      }				      
			     
				  evaluarCondicionesAjaxOOSS(); // RRG
			     
			      /*if(msg == 'ALTA'){	   // Se comenta a solicitud de la operadora RRG    
				      	if(confirm('¿Desea realizar asociación de Número Personal?')){
				      		document.getElementById("numeroAbo").innerHTML = abonadosValidos[0].numAbonado;
				      		document.getElementById("numeroCel").innerHTML = abonadosValidos[0].numCelular;
				      		levantarVentanaCuentaPersonal();
				      	}else{
					      	evaluarCondicionesAjaxOOSS();	
				      	} 				      	
			      }	
			      
                  if(msg == 'BAJAALTA'){
                  		if(confirm(mensajeRetorno)){
                        	if(confirm('¿Desea realizar asociación de Número Personal?')){
                                 document.getElementById("numeroAbo").innerHTML = abonadosValidos[0].numAbonado;
                                 document.getElementById("numeroCel").innerHTML = abonadosValidos[0].numCelular;
                                 levantarVentanaCuentaPersonal();
                            }
                            else {
                                evaluarCondicionesAjaxOOSS(); 
                            }
                        }         
                        else{
                            alert('No se puede continuar con esta solicitud');
                            desactivaBotonSiguiente();
                        }
                  }*/

		      }else{
		      	evaluarCondicionesAjaxOOSS();	
		      }       
  	  }
}
function ocultarVentana2(objetoId){
	// Habilitar radio
	var radioPlanORango = eval('document.CambiarPlanForm.radioPlanORango');
	radioPlanORango[0].disabled = false;
	radioPlanORango[1].disabled = false;
    $("combopos").disabled = false;
	
	document.getElementById(objetoId).style["display"]="none";
	document.getElementById("celularPers").value = "0";
	var mensajes=document.getElementById("mensajes");
    mensajes.innerHTML="";
	
}

function ocultarVentana3(objetoId){

	document.getElementById(objetoId).style["display"]="none";
	var mensajes=document.getElementById("mensajes");
    mensajes.innerHTML="";
	
}

function levantarVentanaCuentaPersonal(){
    // Deshabilita el tipo de plan y la lista de planes
    var radioPlanORango = eval('document.CambiarPlanForm.radioPlanORango');
    radioPlanORango[0].disabled = true;
    radioPlanORango[1].disabled = true;
    $("combopos").disabled = true;
    
    var ventana=document.getElementById("divCuentaPersonal");
    ventana.style["display"]="";
    ventana.style["top"]=378;
    ventana.style["left"]=860;
}

function validarOpcionesCuentaPersonal(){
	// Habilita radio y combo pospago
	var radioPlanORango = eval('document.CambiarPlanForm.radioPlanORango');
	radioPlanORango[0].disabled = false;
	radioPlanORango[1].disabled = false;
    $("combopos").disabled = false;
	
	var celPers =  document.getElementById("celularPers");
	if (celPers.value  == numCelular){
		alert("Debe ingresar celular distinto al actual");
		return false;
	}
	
	if(celPers.length == 0 ){
		return false;
	}
	if(!IsNumeric(celPers))	{
			alert("Debe ingresar un numero");
			return false;
	}
	
	JCondicionesOOSSEmpresa.ValidaAltaCuentaPersonal(celPers.value , retornoValidaciones);
	
}

function IsNumeric(input){

	var passedVal = input.value;
	var ValidChars = "0123456789";
	var IsNumber=true;
	var Char;
	
	if(passedVal == ""){
		IsNumber = false;
	}
	for (i = 0; i < passedVal.length; i++){
	
		Char = passedVal.charAt(i);
		if (ValidChars.indexOf(Char) == -1)
		{
			IsNumber = false;
			input.value = '';
			return false;
		}
	}
	return true;
}
function retornoValidaciones(data){
	if(data != null){         
		 	 
	      var valoresRetorno=data;
	      msg=valoresRetorno['codActuacion'];
	      msgError=valoresRetorno['mensaje'];
		      if(msg != null){
		      
			      	var mensajes = document.getElementById("mensajes");
		   		    mensajes.innerHTML = "";
			      	if(msg == 'CA')	{ //cliente atlantida	  
			      		var mensajes = document.getElementById("mensajes");
		   		      	mensajes.innerHTML = "Número de celular elegido pertenece a un cliente atlantida o es invalido.";
		   		      	document.getElementById("celularPers").value = ""; 
		   		      	desactivaBotonSiguiente();
		   		      	levantarVentanaCuentaPersonal();
		   		     }
		   		     if(msg == 'OK'){
		   		     	ocultarVentana3('divCuentaPersonal');
		   		     	evaluarCondicionesAjaxOOSS();
		   		     }
		   		     if(msg == 'CP'){ //cuenta Personal
		   		     	var mensajes = document.getElementById("mensajes");
		   		      	mensajes.innerHTML = "El número personal seleccionado ya existe como cuenta personal.";
		   		      	document.getElementById("celularPers").value = "";
		   		      	desactivaBotonSiguiente();
		   		      	levantarVentanaCuentaPersonal();
		   		     }	 
		      }
		      else{ //mensaje de error
						  	var mensajes=document.getElementById("mensajes");
			   		      	mensajes.innerHTML=msgError;
			   		      	document.getElementById("celularPers").value = "";
			   		      	desactivaBotonSiguiente();
				  	 }
	}	  
   	     
}

//Ingreso de numeros frecuentes 
function ingresarNumFrecCPU() {  		
    document.getElementById("botonNumerosFrecuentesCPU").value = "numfreccpu";   
    document.getElementById("paginaRegreso").value = "cambiodeplanempresa";
 	document.forms[0].submit();  		
}

// Validación de números frecuentes
function validaActivaNumFrecuentes(){
	document.getElementById("numfreccpu").style["display"]="none";

	var radio = document.getElementById("radioTipoPlan").value;
	var numFrecFijos = $("numFrecFijos").value!=''?parseInt($("numFrecFijos").value):0;
	var numFrecMovil = $("numFrecMovil").value!=''?parseInt($("numFrecMovil").value):0;
	var indFf		 = $("indFf").value!=''?parseInt($("indFf").value):0;
	var numFrecIng   = $("numFrecIng").value!=''?parseInt($("numFrecIng").value):0;
	
	//var codigoClienteDest = document.getElementById("codClienteDestSelec").value;
	
	var destinoPospagoPermiteFrecuentes = 0;
	var clienteOrigenDiferenteClienteDestino = 0;
	
    if ( (numFrecFijos>0 || numFrecMovil>0) && (numFrecIng == 0 ) ){
		document.getElementById("numfreccpu").style["display"]="";
    }
	
}


var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}

function salir(){
	window.close();
}



// Muestra mensajes de error
function mostrarMensajeError(mensaje){
	desactivaBotonSiguiente(); 
    $("mensajes").innerHTML = mensaje; 
}


  	
</script>
</head>

<body onload="cargaInicial();">

<html:form  method="POST" action="/ControlFlujoCPUAction.do">
<html:hidden property="estadoPagina" />

<html:hidden property="xmlVendedorComisionable" value=""/>
<html:hidden property="CombinatoriaConfigurable" value=""/>
<html:hidden property="grupoVendedorComisionable" value=""/>
<html:hidden property="usuarioVendedor" value=""/>
<html:hidden property="msgUsuarioVendedor" value=""/>
<table width="100%">
  <tr>
    <td colspan="2"><tiles:insert attribute="title" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="header" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="body" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footerOS" /></td></tr>
  <tr>
    <td colspan="2"><tiles:insert attribute="footer" /></td></tr>  
</table>

</html:form>
</body>
</html:html>

