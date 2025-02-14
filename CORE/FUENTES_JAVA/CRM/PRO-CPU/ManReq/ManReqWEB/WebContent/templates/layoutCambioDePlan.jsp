<%@ taglib uri="/tags/struts-bean" prefix="bean"%>
<%@ taglib uri="/tags/struts-html" prefix="html"%>
<%@ taglib uri="/tags/struts-logic" prefix="logic"%>
<%@ taglib uri="/tags/struts-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="clienteOS" value="${sessionScope.ClienteOOSS}"></c:set> 
<c:set var="consultaER" value="${sessionScope.consultaEvalRiesgo}"></c:set>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Telefónica Móviles .:<c:out value="${clienteOS.nombOss}"/>:.</title>
<link href="css/mas.css" rel="stylesheet" type="text/css" />
<script language="JavaScript" src="botones/presiona.js" type="text/javascript"></script>


<script type='text/javascript' src='/ManReqWEB/dwr/interface/JCondicionesOOSSCPU.js'></script>
<script type='text/javascript' src='/ManReqWEB/dwr/interface/BusquedaAbonadosDWR.js'></script>
<script type='text/javascript' src='/ManReqWEB/dwr/engine.js'></script>    
<script type='text/javascript' src='/ManReqWEB/dwr/util.js'></script>
<script type='text/javascript' src='js/controlTimeOut.js' language='JavaScript'></script>

<script language="javascript">
var codPlanTarifOrigen="<c:out value="${clienteOS.cliente.codPlanTarif}"/>";
var codTipoPlanTarif="<c:out value="${clienteOS.cliente.codTipoPlanTarif}"/>";
var usuario="<c:out value="${clienteOS.usuario}"/>";
var codigoCliente="<c:out value="${clienteOS.cliente.codCliente}"/>";
var codOrdenServicio="<c:out value="${clienteOS.codOrdenServicio}"/>";
var numeroAbonado="<c:out value="${clienteOS.numAbonado}"/>";
var modalidad="<c:out value="${clienteOS.modalidad}"/>";
var numAbonados="<c:out value="${clienteOS.cliente.numAbonados}"/>";
var impCargoBasicoCliente="<c:out value="${clienteOS.cliente.impCargoBasico}"/>";

var numIdentCliOrigen = "<c:out value="${clienteOS.cliente.numeroIdentificacion}"/>";
var tipIdentCliOrigen = "<c:out value="${clienteOS.cliente.codigoTipoIdentificacion}"/>";
var aplicaPrecalificacion = "<c:out value="${clienteOS.aplicaPrecalificacion}"/>";
var cantidadPlanes = 0;
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
var abonados=new Array();
var arrayNumeroAbonados=new Array(); 
var arrayCargoBasicoPlanAbonados = new Array();

var listaLimiteConsumo = new Array();//EV 07/12/09

//(+) evera 13/nov, agrega listas para guardar informacion clientes destino pospago
/*var listaCliDestinoCodCliente = new Array();
var listaCliDestinoNombres    = new Array();
var listaCliDestinoApellido1  = new Array();
var listaCliDestinoApellido2  = new Array();
var listaCliDestinoTipIdent	  = new Array();
var listaCliDestinoNumIdent   = new Array();
var listaCliDestinoCicloFacturacion = new Array();
var listaCliDestinoTipPlanTarif	= new Array();
var listaCliDestinoCodPlanTarif = new Array();
var listaCliDestinoCodEmpresa = new Array();
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
var codCalificacion = "";
var error=false;
var msgErrorCalifica = "No existe configuraci&oacute;n de planes tarifarios para abonado precalificado";
var existeErrorCalifica = false;
var objCheckAboando; // RRG 19-02-2009 COL 78551

var consultaEvalRiesgo = false;

<c:if test="${!empty consultaER}">
  <c:if test="${consultaER == true}"> 
  	consultaEvalRiesgo =  true;
  </c:if>
</c:if>




 
 
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
      var d=0;
     <logic:iterate id="abonado" name="abonados"  type="com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO">
       numCelular="<bean:write name='abonado' property='numCelular'/>";
       codTecnologia="<bean:write name='abonado' property='codTecnologia'/>";
       numAbonado="<bean:write name='abonado' property='numAbonado'/>";
       codTipoPlanTarifOrigen="<bean:write name='abonado' property='codPlanTarif'/>";
       codPlanServ="<bean:write name='abonado' property='codPlanServ'/>";
       numVenta="<bean:write name='abonado' property='numVenta'/>";
       origenTipoPlan="<bean:write name='abonado' property='desTipPlan'/>";
       indEqPrestado="<bean:write name='abonado' property='indEqPrestado'/>";
       arrayNumeroAbonados[d] = "<bean:write name='abonado' property='numAbonado'/>";
       arrayCargoBasicoPlanAbonados[d] = "<bean:write name='abonado' property='impCargoBasico'/>";
       codCalificacion = "<bean:write name='abonado' property='codCalificacion'/>";
       d++; 
     </logic:iterate>
  </logic:notEmpty>
 </c:if>
    
    
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
function desactivarTodosControles(valor){
	var totalElems = document.forms[0].elements.length;
	for(var i=0;i<totalElems; i++){
		document.forms[0].elements[i].disabled = valor;
	}
}  


//(+) evera 27/08/07
function cargaInicial(){
	desactivarTodosControles(true);
	
	if(numAbonados == 0){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Cliente no posee Abonados";
	   	desactivaBotonSiguiente(); 
		desactivaBotonAnterior();
		//document.getElementById("linkCliente").style["display"]="none";
		
		return false;
	}
	var codVendedor = document.getElementById("codVendedor").value; 
	if (codVendedor == 0){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Usuario ingresado no es valido";
	   	desactivaBotonSiguiente(); 
		desactivaBotonAnterior();
		//document.getElementById("linkCliente").style["display"]="none";
		
		return false;
	}
	
	if (codTipoPlanTarif == "E"){
	  	var mensajes=document.getElementById("mensajes");
	   	mensajes.innerHTML="Orden de Servicio no valida para cliente empresa";
	   	desactivaBotonSiguiente(); 
		desactivaBotonAnterior();
		//document.getElementById("linkCliente").style["display"]="none";
		
		return false;
	}
	
	
	JCondicionesOOSSCPU.cargaInicial(retornoCargaInicial);
}

function retornoCargaInicial(prd){
    desactivarTodosControles(false);
	
	valoresDefaultCarga();
	var flgPaginaFiltro = document.getElementById("flgPaginaFiltro").value;
	
	if (flgPaginaFiltro == "S"){
		activaBotonAnterior();
	}else{
		desactivaBotonAnterior();
	}
	
	//(+) evera 16/07/08, se comenta, ya no necesio desactivar los combos de clientes
	/*
	var combinatoria = document.getElementById("combinatoria").value;
	if (combinatoria=="POSPAGOPOSPAGO" || combinatoria=="HIBRIDOPOSPAGO" ) {
		document.getElementById("clienteDestPos").disabled = true;	
	} 
	else if (combinatoria=="POSPAGOHIBRIDO" || combinatoria=="HIBRIDOHIBRIDO") {
		document.getElementById("clienteDestHib").disabled = true;	
	} 
	else if (combinatoria=="PREPAGOPREPAGO" ){
		document.getElementById("clienteDestPre").disabled = true;	
	}
	*/

	
}

function dumy2(prd){
	//alert("termina evaluarCondiciones!");
}

//valida seleccion de opcion
function validarOpcion(){

  	var parametrosCondicionesOS=new Object();
  	parametrosCondicionesOS['combinatoriaGenerada']=combinatoriaGenerada;
	parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	//obtener abonados seleccionados  	
  	var totalAboSel = 0;
    var check = document.getElementById("listaAbonados");
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
	}else{
		if (numeroAbonado>0){
			var arrAbonados = new Array(1);
			arrAbonados[0] = numeroAbonado;
		}else{
			alert("Debe seleccionar abonados");
			return false;
		}
	}    
		 
	 //validaOpcion
	 JCondicionesOOSSCPU.validaOpcion(parametrosCondicionesOS, arrAbonados, retornoValidaOpcion);

}

//retorno de funcion JCondicionesOOSSCPU.validaOpcion()
function retornoValidaOpcion(data)
{
      if(data != null){
 	      var valoresRetorno=data;
	      msg=valoresRetorno['mensaje'];
	  	  if (msg == null){
	  	  	   var codActAboHom = valoresRetorno['codActAboAux'];
	  	       document.getElementById("codActAboAux").value = codActAboHom;
		  }else{
		  		//carga mensaje de error en validacion
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msg;
   		      	desactivaBotonSiguiente(); 
		  }
      }
}
 
//valida plan tarifario seleccionado  
 function validarPlanTarif(){
  	var parametrosCondicionesOS=new Object();
  	parametrosCondicionesOS['combinatoriaGenerada']= combinatoriaGenerada;
	parametrosCondicionesOS['codPlanTarifSelec']   = document.getElementById("codPlanTarifSelec").value;
	parametrosCondicionesOS['codTipoPlanTarif']    = document.getElementById("tipoPlanTarifDestino").value;
  	  
  	//obtener abonados seleccionados  	
  	var totalAboSel = 0;
    var check = document.getElementById("listaAbonados");
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
  	}else{
		if (numeroAbonado>0){
			var arrAbonados = new Array(1);
			arrAbonados[0] = numeroAbonado;
		}else{
			alert("Debe seleccionar abonados");
			return false;
		}
	}    

  	 //validaPlanTarif
 	 JCondicionesOOSSCPU.validaPlanTarif(parametrosCondicionesOS, arrAbonados, retornoValidaPlanTarif);
} 

//retorno de funcion JCondicionesOOSSCPU.validaPlanTarif()
function retornoValidaPlanTarif(data)
{
      if(data != null){
	      var valoresRetorno=data;
	      msg=valoresRetorno['mensaje'];
	  	  if (msg != null){
		  		//carga mensaje de error en validacion
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msg;
      	        desactivaBotonSiguiente(); 
		  }
      }
} 
  
function enviarFormulario()  {
  	if(existeErrorCalifica)
  	{
  		mostrarMensajeError(msgErrorCalifica); 
  		return;
  	}
  	var codPlanSelec = $("codPlanTarifSelec").value;
  	
  	if (codPlanSelec==null || codPlanSelec == '' ){
  	   mostrarMensajeError ("Debe seleccionar un plan tarifario"); 
  	   return;
  	}
  	
  	if (obtenerCantAboSel()==0){
  	   mostrarMensajeError ("Debe seleccionar un abonado"); 
  	   return;
  	}   
  	  	
  	var flgAplicaEvaluacion = $("flgAplicaEvaluacion").value;
  	var cargoBasicoPlanSel = $("cargoBasicoSelec").value;
    var combinatoria = $("combinatoria").value;
    
  	if( 
		(  flgAplicaEvaluacion == "TRUE" && combinatoria=='PREPAGOPOSPAGO') ||
		(  flgAplicaEvaluacion == "TRUE" && combinatoria=='PREPAGOHIBRIDO') ||
		(  flgAplicaEvaluacion == "TRUE" &&
	  	   validaCargoBasicoAbonados(cargoBasicoPlanSel) &&
  		   combinatoria!='PREPAGOPREPAGO' && 
		   combinatoria!='POSPAGOPREPAGO' &&
		   combinatoria!='HIBRIDOPREPAGO' &&
		   combinatoria!='PREPAGOPOSPAGO' &&
	       combinatoria!='PREPAGOHIBRIDO'
		) 
	)
  	{
		obtenerPlanesEvaluacionRiesgo();
	}
	else {
		continuarEnvioFormulario();		
	}	
} 


function obtenerPlanesEvaluacionRiesgo()  {
	var tipoComboPlan = $("radioTipoPlan").value; // combopre,combopos,combohib      
  	var tipoListaPlan;
  	
    if (tipoComboPlan == "combopre"){
    	tipoListaPlan = "planTarifPrepago";
    } 
    else if (tipoComboPlan == "combopos"){
		tipoListaPlan = "planTarifPospago";
    }
    else if (tipoComboPlan== "combohib"){ 
      	tipoListaPlan = "planTarifHibrido";
    }
    
    var cliDestinoTipPlanTarif;
    var flgClienteDestinoEmpresa = $("flgClienteDestinoEmpresa").value;
    var cliDestinoTipPlanTarif  =  flgClienteDestinoEmpresa!='' && flgClienteDestinoEmpresa=='S'?'E':'I';
    
    JCondicionesOOSSCPU.obtenerPlanesEvaluacion(tipoListaPlan,cliDestinoTipPlanTarif,numIdentCliOrigen,tipIdentCliOrigen,retornoObtenerPlanesEvaluacion);  
}

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
	    var tipoComboPlan = $("radioTipoPlan").value; // combopre,combopos,combohib      
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
	       return;
	    }
	    // Validación de numero abonados seleccionados y lineas del plan
		var cantLineasPlanSel = planSeleccionado.canLineas;
		
		if (numSol != 0 && cantLineasPlanSel!= 0 ) {    
		    var numAboSel = obtenerCantAboSel();
		    if ( parseInt(numAboSel) >  parseInt(cantLineasPlanSel) ){
		       mostrarMensajeError("Sólo se pueden seleccionar "+cantLineasPlanSel+" abonados para cambiar al plan "+planSeleccionado.descripcionPlanTarifario);   
		       return;
		    }
		} 
    	
    	
    }
    
    continuarEnvioFormulario();
}

function continuarEnvioFormulario(){
    // Continua enviando el formulario 
    if (modalidad == null || modalidad == ""){
	  	var mensajes = document.getElementById("mensajes");
      	mensajes.innerHTML = "No existe modalidad de pago configurada";
      	desactivaBotonSiguiente(); 
  		return false;
  	}
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
		 	//evaluarCondicionesAjaxOOSS();
		    
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
 	JCondicionesOOSSCPU.recuperarConfiguracionVendedorCPU(configuracionVendedorCPU, {callback:callbackRecuperarConfiguracionVendedorCPU, errorHandler:errorRecuperarConfiguracionVendedorCPU})
	var CombinatoriaConfigurable = document.getElementById("CombinatoriaConfigurable").value;
	//alert('CombinatoriaConfigurable[' + CombinatoriaConfigurable + ']') 	

	//Si el vendedor es comisionable, osea, esta configurado en el xml
	//Si la combinatoria generada para la orden de servicio es comisionable	
	if (xmlVendedorComisionable == "SI" && CombinatoriaConfigurable == 1) {
		var usuarioSistema = new Object();
		usuarioSistema.nom_usuario = usuario;
		
		//Seteo la informacion del usuario y el vendedor
		JCondicionesOOSSCPU.obtenerInformacionUsuarioVendedor(usuarioSistema, {callback:callbackObtenerInformacionUsuarioVendedor, errorHandler:errorInformacionUsuarioVendedor});
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
		JCondicionesOOSSCPU.usuarioesdeGrupoComisionable(usuario, {callback:callbackUsuarioesdeGrupoComisionable, errorHandler:errorUsuarioesdeGrupoComisionable} )
		var grupoVendedorComisionable = document.getElementById("grupoVendedorComisionable").value;
		//alert('grupoVendedorComisionable[' + grupoVendedorComisionable + "]");
		
		if (grupoVendedorComisionable == "S") {
			//Hay que ingresar la informacion del vendedor
			//alert('Grupo comisionable');
			return abrirVentanaVendedor();
		}
		else {
		JCondicionesOOSSCPU.setUsuarioVendedorenSesion();
			//La informacion deberia tomarse del usuario de sesion
			//alert('Grupo no comisionable')
		}
	}
	else{ // Para el caso de combinatorias no configurables
		JCondicionesOOSSCPU.removerUsuarioVendedordeSesion();
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
	return JCondicionesOOSSCPU.estaVendedorComisionableConfigurado(callbackEstaVendedorComisionableConfigurado);
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


function formularioAnterior()
{
  	document.getElementById("botonSeleccionadoCambioPlan").value = "anterior";
    document.forms[0].submit();
}

//Ingreso de Numeros Frecuentes CPU santiago 
function ingresarNumFrecCPU() {  		
    document.getElementById("botonNumerosFrecuentesCPU").value = "numfreccpu";   
	document.getElementById("paginaRegreso").value = "cambiodeplan";
	document.forms[0].submit();  		
}

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

	var totalAbonadosSel = 0;
	var listaAbonados = eval('document.CambiarPlanForm.listaAbonados');
    if (listaAbonados !=null ){
         // Verifica que al menos un item haya sido seleccionado
         var isAnyItemSel = false;
         if (listaAbonados.length == undefined){  //Solo hay un registro  
         	isAnyItemSel = listaAbonados.checked; 
         	
         	if (isAnyItemSel)  	totalAbonadosSel =1;
         	
         } 
         else {
			for(i=0;i<=listaAbonados.length-1;i++)	{
			  if (listaAbonados[i].checked){
			    isAnyItemSel =  listaAbonados[i].checked;
			    //break;
             	if (isAnyItemSel)  	totalAbonadosSel++;
			  }
			}
         }
         
         if (totalAbonadosSel == 0) {
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
    
    if (opcionComboPlanTarif ==""){
       desactivaBotonSiguiente(); 
       mensajes.innerHTML="Debe seleccionar un Plan Tarifario";
       error=true;
       return error;
    }
     
    if(document.getElementById("combinatoria").value == "POSPAGOPREPAGO"){
	    if(document.getElementById("causaBajaCB").value ==""){
	         desactivaBotonSiguiente(); 
	         mensajes.innerHTML="Debe seleccionar una Causa de Baja";
	         error=true;
	         return error;
	    }
	}   
		   
	if( (document.getElementById("combinatoria").value == "POSPAGOPOSPAGO")||
		(document.getElementById("combinatoria").value == "HIBRIDOHIBRIDO")||
		(document.getElementById("combinatoria").value == "POSPAGOHIBRIDO")||
		(document.getElementById("combinatoria").value == "HIBRIDOPOSPAGO")	){
	
		var rb = eval ('document.CambiarPlanForm.cambioDePlanRB');
	    var inmed  = rb[0].checked;
	    var aciclo = rb[1].checked;
		var selCambioDePlan = false;
		if (inmed || aciclo) selCambioDePlan = true;
		
		if(!selCambioDePlan){
	         desactivaBotonSiguiente(); 
	         mensajes.innerHTML="Debe seleccionar cambio de plan Inmediato o A Ciclo";
	         error=true;
	         return error;
	    }
	}  

    //validar cliente destino empresa
    var flgClienteDestinoEmpresa = document.getElementById("flgClienteDestinoEmpresa").value;
    var numAbonadosPermitidosPlan = parseInt(document.getElementById("numAbonadosPermitidosPlan").value);
    var numAbonadosClienteDestino = parseInt(document.getElementById("numAbonadosClienteDestino").value);        	
	if (flgClienteDestinoEmpresa == "S" && (numAbonadosPermitidosPlan >0)){
		var totalAboCliente = numAbonadosClienteDestino + totalAbonadosSel;
		if (totalAboCliente>numAbonadosPermitidosPlan){
		  	desactivaBotonSiguiente(); 
	      	mensajes.innerHTML="Ha superado el total de abonados permitido por el plan tarifario del cliente destino";
	      	error=true;
	  		return error;
		}
		
	}
    //fin validacion cliente
       
    //(+) EV 09/12/09   
    //validacion de limite de consumo
	if (opcion != "combopre" && opcion != "combohib"){
	    var montoLimiteConsumo = document.getElementById("montoLimiteConsumo").value;
	    if (montoLimiteConsumo==0)
		{
				desactivaBotonSiguiente(); 
		      	mensajes.innerHTML="Debe ingresar L&iacute;mite de Consumo";
		      	error=true;
		  		return error;
		}  	
	}
    //(-) EV 09/12/09		
    
    return error;
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
    
   	// Si el origen es POSPAGO deshabilita PREPAGO	
	if (origenTipoPlan=="POSPAGO" || origenTipoPlan=="HIBRIDO") {
		var radioTipoPlan = eval ('document.CambiarPlanForm.tipoPlanRB');
		radioTipoPlan[0].disabled = true;
		radioTipoPlan[1].checked = true;
		radioCargado = "combopos";
	}
    
    activarCombosDependDelPlan(radioCargado); 
    
    var combinatoria = document.getElementById("combinatoria").value ;
    var condiciones=document.getElementById("condicionesCK");
    var valorCondicion=document.getElementById("condicH").value;
    
    if (valorCondicion=="SI"){
        condiciones.checked=true;
    }else{
        condiciones.checked=false;
        document.getElementById("condicH").value="NO";
    }
   
	for(i=0;i<controlesId.length;i++)
	{
	   	seteaControl(controlesId[i], controlesHab[i], controlesVis[i]);
	} 

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
			fncValidaBajaPendiente(abonadosCheck); // RRG 19-02-2009 COL 78551
	  	}else{
	  		for(var i=0; i<abonadosCheck.length; i++){
	  			abonadosCheck[i].checked = true;
				fncValidaBajaPendiente(abonadosCheck[i]); // RRG 19-02-2008 COL 78551
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
 
//Funcion que activa o desactiva combos (plan tarifario, cliente destino) y todos los objetos dependientes del radio seleccionado
function activarCombosDependDelPlan(radio)
{	  
      var comboAPrender=radio;
      document.getElementById("radioTipoPlan").value=comboAPrender;
      ocultarVentana('devEquipoComodato');
      activaBotonSiguiente();
      var mensajes=document.getElementById("mensajes");
	  mensajes.innerHTML="";
	  
      limpiarEstadoAbonados(); 
	  limpiarAtributosPlanTarifario();
	  llenaListaPlanTarifario();
 
	  //llenaClienteDestino();//carga informacion de clientes destino, evera 16/07/08, se comenta llamada
	  generarCombinatoria();
	  var combinatoria = document.getElementById("combinatoria").value;
	  /* evera 05 julio 08
	  if((combinatoria=="POSPAGOHIBRIDO" || combinatoria=="HIBRIDOPOSPAGO") && (codOrdenServicio == "40006")){
	  	activaOpcionCambioPlan(); //yosses 29/02/2008
	  }else{
  	   	document.getElementById("opcionCambioPlanTr").style["display"]="none" ;
	  }
	 */
	  //document.getElementById("linkCliente").style["display"]="";
	  //deshabilita todos los combos de plan tarifario y habilita el que corresponde de acuerdo al plan tarifario seleccionado (radio)
	  document.getElementById("combopre").style["display"]="none";
	  document.getElementById("combopos").style["display"]="none";
	  document.getElementById("combohib").style["display"]="none";
	  document.getElementById(comboAPrender).style["display"]="";
	  
	  //deshabilita todos los combos de cliente destino
	  document.getElementById("clienteDestPre").style["display"]="none";
	  document.getElementById("clienteDestPos").style["display"]="none";
	  document.getElementById("clienteDestHib").style["display"]="none";
	  
	  //deshabilita combo de causa de baja
	  document.getElementById("causaBajaCB").style["display"]="none";
	  document.getElementById("causaBajaLB").style["display"]="none";
	  document.getElementById("punto").style["display"]="none";

	  //deshabilita buscador de clientes
  	  document.getElementById("buscadorClientesTr").style["display"]="none";
  	  
      //dependiendo del plan tarifario seleccionado habilita el combo del cliente destino	
	  if(comboAPrender=="combopre"  ){
		document.getElementById("clienteDestPre").style["display"]="";
		document.getElementById("codClienteDestSelec").value = document.getElementById("clienteDestPre").value;
		document.getElementById("divComboLimiteConsumo").style["display"]="none";
		document.getElementById("divMontoLimiteConsumo").style["display"]="none";
		document.getElementById("divLimiteConsumoDefecto").style["display"]="none";				
	  }
	  else if(comboAPrender=="combopos"){
	  	document.getElementById("clienteDestPos").style["display"]="";
	  	document.getElementById("codClienteDestSelec").value = document.getElementById("clienteDestPos").value;
	  	document.getElementById("cargoBasicoSelec").value = "";
		document.getElementById("divLimiteConsumoDefecto").style["display"]="none";				  	
		document.getElementById("divComboLimiteConsumo").style["display"]="";
		document.getElementById("divMontoLimiteConsumo").style["display"]="";
	  }
	  else if(comboAPrender=="combohib"){
	  	document.getElementById("clienteDestHib").style["display"]="";
	  	document.getElementById("codClienteDestSelec").value = document.getElementById("clienteDestHib").value;
		document.getElementById("divComboLimiteConsumo").style["display"]="none";
		document.getElementById("divMontoLimiteConsumo").style["display"]="none";
		document.getElementById("divLimiteConsumoDefecto").style["display"]="none";				
	  }
	  
	  //si la combinatoria generada es PREPAGOPREPAGO desactiva el combo de cliente destino prepago	y el link de alta de cliente  
	  if( (combinatoria=="PREPAGOPREPAGO") && (codOrdenServicio == "40006")){
	  	 document.getElementById("clienteDestPre").value = codigoCliente;
	     //document.getElementById("clienteDestPre").disabled = true; //EV 16/7/08
   	     document.getElementById("causaBajaCB").disabled = true;
	     //document.getElementById("linkCliente").style["display"]="none";
	     document.getElementById("condicionesActuales").innerHTML = "DESCUENTO DE SALDO EN FORMA INMEDIATA";
	  }
	  else {
	  	 document.getElementById("condicionesActuales").innerHTML = '<bean:write name="CambiarPlanForm" property="detalleControles"/>'
	  }
	  
	  //si la combinatoria generada es HIBRIDOHIBRIDO desactiva el combo de cliente destino hibrido y el link de alta de cliente
	  if((combinatoria=="HIBRIDOHIBRIDO" || combinatoria=="POSPAGOHIBRIDO") && (codOrdenServicio == "40006")){
  	  	 document.getElementById("clienteDestHib").value = codigoCliente;
	  	 //document.getElementById("clienteDestHib").disabled = true; //EV 16/7/08
  	     document.getElementById("causaBajaCB").disabled = true;
		 //document.getElementById("linkCliente").style["display"]="none";
	  }
	  
	  if((combinatoria=="POSPAGOHIBRIDO" ||combinatoria=="HIBRIDOPOSPAGO" ||combinatoria=="POSPAGOPOSPAGO") && (codOrdenServicio == "40006")){
	     document.getElementById("clienteDestPos").value = codigoCliente;
	  	 //document.getElementById("clienteDestPos").disabled = true; //EV 16/7/08
  	     document.getElementById("causaBajaCB").disabled = true;
		 //document.getElementById("linkCliente").style["display"]="none";
	  }
	  
	  //si la combinatoria generada es POSPAGOPREPAGO activa el combo de causa de baja
	  if(combinatoria=="POSPAGOPREPAGO" || combinatoria=="HIBRIDOPREPAGO") {
		     document.getElementById("causaBajaCB").style["display"]="";
		     document.getElementById("causaBajaLB").style["display"]="";	
	  }
 	  //------------------------------------------------------------------------------------------------
 	  existeErrorCalifica = false;
 	  if(aplicaPrecalificacion == "S")
	  {
		if(origenTipoPlan == "PREPAGO" && codCalificacion != '')
		{
			var radio=document.getElementById("radioTipoPlan").value;
			if ((radio=="combohib" || radio=="combopos") && cantidadPlanes == 0)
			{
				var mensajes=document.getElementById("mensajes");
	   		    mensajes.innerHTML=msgErrorCalifica;
	   		    desactivaBotonSiguiente();
	   		    existeErrorCalifica = true;
	   		    return;
			}
		}
	  }
 	  //------------------------------------------------------------------------------------------------
	   //activa ventana popup
	  if (indEqPrestado != null && indEqPrestado!="" ){                             
	  		if ( (combinatoria=="POSPAGOPREPAGO" && codOrdenServicio==40006 && indEqPrestado=="1" ) ||
	        (combinatoria=="HIBRIDOPREPAGO" && codOrdenServicio==40006 && indEqPrestado=="1" )
	     															){
	  			levantarVentanaDevEquipo();
	  		}
	  }

	 // Actualiza datos del cliente y plan tarifario seleccionado en pantalla
      var tipoPlan = 0;
	  if(comboAPrender=="combopre")			tipoPlan = 1;
	  else if(comboAPrender=="combopos")	tipoPlan = 2;
	  else if(comboAPrender=="combohib")  	tipoPlan = 3;
	  
	  //(+) evera 16/07/08, se obtiene info desde lista de sesion, se pasa codigo a retornoClienteActivarCombosDependDelPlan
	  var codClienteOrigenDestino=0;
	  if(combinatoria!="PREPAGOPOSPAGO" && combinatoria!="PREPAGOHIBRIDO"){
		  codClienteOrigenDestino = codigoCliente;
	  }
	  
	  if (codClienteOrigenDestino > 0){ // origen=destino= cliente individual
	  	var tipoFiltro = 1;
	  	JCondicionesOOSSCPU.buscarClientes(0, tipoPlan, codClienteOrigenDestino, tipoFiltro, retornoClienteActivarCombosDependDelPlan);
	  	
	  }else{//debe cargar lista, o habilitar buscador de clientes
	    var tipoFiltro = 2;
	    var maxClientesPermitidos = document.getElementById("numMaxClientesLista").value;
	    desactivarTodosControles(true);
	    JCondicionesOOSSCPU.buscarClientes(maxClientesPermitidos, tipoPlan, 0, tipoFiltro, retornoClienteListaActivarCombosDependDelPlan);
	    
	  }
	  
	  /*
	  //revisar si el cliente seleccionado es empresa	  
	  var  cliDestinoTipPlanTarif = "I";
	  var  cliDestinoCodPlanTarif = "";
	  if(comboAPrender=="combopos"){
		//obtener info de cliente
		var  cliDestinoCodCliente = listaCliDestinoCodCliente;
		
		if (cliDestinoCodCliente != null){
			for(var i=0; i<cliDestinoCodCliente.length; i++){
					var cliDestinoCodClienteAux = cliDestinoCodCliente[i];
					if (codCliente == cliDestinoCodClienteAux){
						cliDestinoTipPlanTarif = listaCliDestinoTipPlanTarif[i];
						cliDestinoCodPlanTarif = listaCliDestinoCodPlanTarif[i];						
						break;
					}
			}//fin for
		}//fin if (cliDestinoCodCliente != null)
		
	  }// Fin if(comboAPrender=="combopos")

	  if (cliDestinoTipPlanTarif == 'E'){ //Cliente destino es empresa	  
		  //Obtener plan tarifario
		  //document.getElementById("flgClienteDestinoEmpresa").value ="S";
		  //JCondicionesOOSSCPU.cargarPlanTarifarioEmpresa(cliDestinoCodPlanTarif, codCliente,retornoCargarPlanTarifarioEmpresa);
	      //document.getElementById("codPlanTarifSelec").value = cliDestinoCodPlanTarif;
	  }//fin if (cliDestinoTipPlanTarif == 'E')
	  else{
		  // Busca y muestra datos del plan tarifario seleccionado
		  var comboPlanTarif = document.getElementById(comboAPrender);
	      var indicePlanSel = $(comboAPrender).selectedIndex;
		  if (indicePlanSel!=-1 ) 	{
		 	 var codPlanTarif =  $(comboAPrender)[indicePlanSel].value;
		 	 document.getElementById("codPlanTarifSelec").value = codPlanTarif;
		  	 buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
		  }
	   }

	*/
	if (combinatoria !="POSPAGOPOSPAGO" &&   combinatoria!="PREPAGOPOSPAGO" ){
	  document.getElementById("numfreccpu").style["display"]="none";
	}
	//(-)
	
	  
} 

//(+) evera 16/07/08
// solo se llama para clientes individuales por lo que no se utiliza la validacion empresa
function retornoClienteActivarCombosDependDelPlan(dataCliente){ 
    var comboTipoPlan=document.getElementById("radioTipoPlan").value;
    

    var flgPaginaFiltro = document.getElementById("flgPaginaFiltro").value;
	if (flgPaginaFiltro == "S")	activaBotonAnterior();
	else						desactivaBotonAnterior();

	if(dataCliente != null){
		 var valoresRetorno=dataCliente;
	     codMsgError=valoresRetorno['codMensaje'];
	     msgError=valoresRetorno['mensaje'];
		 if(codMsgError =="0"){
		      	var mensajes = document.getElementById("mensajes");
	   		    mensajes.innerHTML = "";
	   		    document.getElementById("buscadorClientesTr").style["display"]="none";
				
				var clientesFiltrados = valoresRetorno['clientesFiltrados'];
				var largo = clientesFiltrados.length;
			
				if (largo > 0){

					//Cargar lista, debiera retornar 1
					var codigo = clientesFiltrados[0].codCliente;
					var nombres = clientesFiltrados[0].nombres;				
				    var optCliente = document.createElement('option');
				    var ciclo  = clientesFiltrados[0].codCiclo;
					var strComboCliente   = valoresRetorno['strComboCliente'];
					var cliDestino = codigo;
	
					//remover todos los clientes
					DWRUtil.removeAllOptions(strComboCliente);
					
			        optCliente.text = codigo+"-"+nombres;
			        optCliente.value = codigo;
			        
			        $(strComboCliente).add(optCliente);
		   			$(strComboCliente).selectedIndex = $(strComboCliente).length-1;   
	
					 //se actualiza el ciclo destino
					 var codCicloCliente=document.getElementById("codCicloCliente");
					 codCicloCliente.innerHTML = ciclo;
					 document.getElementById("codCicloClienteDestino").value = ciclo;
					 
					 //actualiza cliente seleccionado
					 document.getElementById("codClienteDestSelec").value = codigo;
					 
				 	// Busca y muestra datos del plan tarifario seleccionado
					var indicePlanSel = 0;
					var tipoPlan = 0;
					indicePlanSel = $(comboTipoPlan).selectedIndex;
					if (indicePlanSel!=-1 ){
						  var codPlanTarif =  $(comboTipoPlan)[indicePlanSel].value;
					 	  document.getElementById("codPlanTarifSelec").value = codPlanTarif;
					
						if(comboTipoPlan=="combopre")	tipoPlan = 1;
						else if(comboTipoPlan=="combopos")	tipoPlan = 2;
						else if(comboTipoPlan=="combohib")	tipoPlan = 3;
									  
						buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
					} 

    				activaBotonSiguiente();
					
				   }//fin if (largo > 0){
				
		}else{ //mensaje de error
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msgError;
   		      	desactivaBotonSiguiente();
		}//fin if(codMsgError =="0")
	   
	}// fin if(dataCliente != null)

}
//(-)

//(+) evera 17/07/08
function retornoClienteListaActivarCombosDependDelPlan(dataCliente){
    //alert ("mtigua en retornoClienteListaActivarCombosDependDelPlan");
    
    var comboTipoPlan=document.getElementById("radioTipoPlan").value;

    desactivarTodosControles(false);
	if(dataCliente != null){
		 var valoresRetorno=dataCliente;
	     var codMsgError=valoresRetorno['codMensaje'];
	     var msgError=valoresRetorno['mensaje'];
	     var muestraBuscador=valoresRetorno['muestraBuscador'];
	     
		 if(codMsgError =="0"){
		      	var mensajes = document.getElementById("mensajes");
	   		    mensajes.innerHTML = "";
	   		    if (muestraBuscador=="S"){
	   		    	var maxClientesPermitidos = document.getElementById("numMaxClientesLista").value;
	   		    	var msgUsuario = "Cuenta destino con mas de "+maxClientesPermitidos+" clientes, ingresar por el buscador con c\u00F3digo de cliente";
	   		    	alert(msgUsuario);
					document.getElementById("buscadorClientesTr").style["display"]="";
				}else{
					document.getElementById("buscadorClientesTr").style["display"]="none";				
				}
				
				var clientesFiltrados = valoresRetorno['clientesFiltrados'];
				var largo = clientesFiltrados.length;
			
				if (largo > 0){
					var strComboCliente   = valoresRetorno['strComboCliente'];
					//remover todos los clientes
					DWRUtil.removeAllOptions(strComboCliente);
					
					// Inicicializacion 
					var codCliente1 = 0;
					var codCiclo1 =0;
					var tipPlanTarif1 = "";
				  	var codPlanTarif1= "";
					
					// Recupera cliente seleccioando
					var codClienteSel =  document.getElementById("codClienteDestSelec").value;
					var indiceSel = 0; 
					
					//Cargar lista				
					for(var i=0;i <largo;i++){
						var codigo = clientesFiltrados[i].codCliente;
						var nombres = clientesFiltrados[i].nombreCompleto;				
					    var ciclo  = clientesFiltrados[i].codCiclo;
					    var optCliente = document.createElement('option');
				        optCliente.text = codigo+"-"+nombres;
				        optCliente.value = codigo;
				        $(strComboCliente).add(optCliente);	
				        
				        // Si ya se ha seleccionado un cliente destino anteriormente 
				        if (codClienteSel!='' && codClienteSel == codigo) {
				            indiceSel = i;
				            codCliente1=codigo;
							codCiclo1=ciclo;
							tipPlanTarif1 = clientesFiltrados[i].tipPlanTarif;
							codPlanTarif1 = clientesFiltrados[i].codPlanTarif;
				        }
				        else {
				           // Se hace el llenado con los datos del primer elemento 
				           if (i==0){
							codCliente1=codigo;
							codCiclo1=ciclo;
							tipPlanTarif1 = clientesFiltrados[0].tipPlanTarif;
							codPlanTarif1 = clientesFiltrados[0].codPlanTarif;
						   }
				        }
					}
					
		   			$(strComboCliente).selectedIndex = indiceSel;
	
					 //se actualiza el ciclo destino
					 var codCicloCliente=document.getElementById("codCicloCliente");
					 codCicloCliente.innerHTML = codCiclo1;
					 document.getElementById("codCicloClienteDestino").value = codCiclo1;
					 
					 //actualiza cliente seleccionado
					 document.getElementById("codClienteDestSelec").value = codCliente1;

				  	// Verifico si se ha consultado a la evaluacion de riesgo
				  	// Borro el combo anterior pongo el de la evaluacion  
				  	// Selecciono el plan seleccionado 
					if (consultaEvalRiesgo){
					    //alert ("mtigua en consultaEvalRiesgo");
					    DWREngine.setAsync(false);
					    JCondicionesOOSSCPU.obtenerPlanesEvalSesion(retornoObtenerPlanesEvalSesion);
					    DWREngine.setAsync(true);
					}
				  	
				  	
		  			if(comboTipoPlan=="combopos" && (tipPlanTarif1 == 'E')){//Cliente destino es empresa	  
						  //Obtener plan tarifario
						  //document.getElementById("flgClienteDestinoEmpresa").value ="S";
						  //JCondicionesOOSSCPU.cargarPlanTarifarioEmpresa(codPlanTarif1, codCliente1,retornoCargarPlanTarifarioEmpresa);
					      //document.getElementById("codPlanTarifSelec").value = codPlanTarif1;
					}
					else{
						// Busca y muestra datos del plan tarifario seleccionado
						var indicePlanSel = 0;
						var tipoPlan = 0;
						indicePlanSel = $(comboTipoPlan).selectedIndex;
						if (indicePlanSel!=-1 ){
							var codPlanTarif =  $(comboTipoPlan)[indicePlanSel].value;
							
					 		document.getElementById("codPlanTarifSelec").value = codPlanTarif;
							if(comboTipoPlan=="combopre")	tipoPlan = 1;
							else if(comboTipoPlan=="combopos")	tipoPlan = 2;
							else if(comboTipoPlan=="combohib")	tipoPlan = 3;
									  
							buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
						} 
					} //fin if(comboTipoPlan=="combopos" && (tipPlanTarif1 == 'E'))




	   				activaBotonSiguiente();
				
				   }else{
				   		// Busca y muestra datos del plan tarifario seleccionado
						var indicePlanSel = 0;
						var tipoPlan = 0;
						indicePlanSel = $(comboTipoPlan).selectedIndex;
						if (indicePlanSel!=-1 ){
							var codPlanTarif =  $(comboTipoPlan)[indicePlanSel].value;
					 		document.getElementById("codPlanTarifSelec").value = codPlanTarif;
					
							if(comboTipoPlan=="combopre")	tipoPlan = 1;
							else if(comboTipoPlan=="combopos")	tipoPlan = 2;
							else if(comboTipoPlan=="combohib")	tipoPlan = 3;
									  
							buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan);	
						} 
				   }//fin if (largo > 0){
				
		}else{ //mensaje de error
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msgError;
   		      	desactivaBotonSiguiente();
		}//fin if(codMsgError =="0")
	   
	}// fin if(dataCliente != null)	

}
//(-)

//(+)yosses 29/02/2008
function activaOpcionCambioPlan(){

    generarCombinatoria();
	var combinatoria=document.getElementById("combinatoria").value;
	if( combinatoria=="POSPAGOPOSPAGO" || combinatoria=="HIBRIDOHIBRIDO" ||
		combinatoria=="POSPAGOHIBRIDO" || combinatoria=="HIBRIDOPOSPAGO"){
	    document.getElementById("opcionCambioPlanTr").style["display"]="" ;
	}else{
	    document.getElementById("opcionCambioPlanTr").style["display"]="none" ;
	}
}

function muestraFecha(valRadio){
  
  if(valRadio=="aciclo"){
       document.getElementById("fechaDesdeLlam").style["display"]="" ;
  }else{
       document.getElementById("fechaDesdeLlam").style["display"]="none" ;
  }
  
  activaBotonSiguiente();
  var mensajes=document.getElementById("mensajes");
  mensajes.innerHTML="";
} 

//(-)

function retornoCargarPlanTarifarioEmpresa(data){
	if(data != null){
	      var valoresRetorno=data;
	      msg=valoresRetorno['mensaje'];
	  	  if (msg == null){
   		        document.getElementById("combopos").disabled=false;

				var codPlanTarifE     = valoresRetorno['codPlanTarif'];
				var desPlanTarifE     = valoresRetorno['desPlanTarif'];
				var codLimiteConsumoE = valoresRetorno['codLimiteConsumo'];
				var desLimiteConsumoE = valoresRetorno['desLimiteConsumo'];
				var codCargoBasicoE   = valoresRetorno['codCargoBasico'];
				var desCargoBasicoE   = valoresRetorno['desCargoBasico'];
				var impCargoBasicoE   = valoresRetorno['impCargoBasico'];
				var numDiasE          = valoresRetorno['numDias'];
				var tipPlanTarifE     = valoresRetorno['tipPlanTarif'];
				var impLimiteConsumoE = valoresRetorno['impLimiteConsumo'];
				var cantidadAbonadosPermitidosE = valoresRetorno['cantidadAbonadosPermitidos'];
				var numFrecFijos = valoresRetorno['numFrecFijos'];
				var numFrecMovil = valoresRetorno['numFrecMovil'];
				//alert ("En retornoCargarPlanTarifarioEmpresa "+"numFrecFijos:"+numFrecFijos+"numFrecMovil:"+numFrecMovil);
				
				
				var indFf = valoresRetorno['indFf'];
				var numFrecIng = valoresRetorno['numFrecIng'];
				
				document.getElementById("numAbonadosPermitidosPlan").value = cantidadAbonadosPermitidosE;
				document.getElementById("numFrecFijos").value = numFrecFijos;
				document.getElementById("numFrecMovil").value = numFrecMovil;
				document.getElementById("indFf").value = indFf;
				document.getElementById("numFrecIng").value = numFrecIng;
				
				actualizarPlanTarifario(codPlanTarifE,desPlanTarifE,tipPlanTarifE,
				codCargoBasicoE,desCargoBasicoE,impCargoBasicoE,impLimiteConsumoE,
				0,codLimiteConsumoE,desLimiteConsumoE,numDiasE)

				validaActivaNumFrecuentes();
				document.getElementById("combopos").disabled=true;
	  	  }/*
	  	  else{
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msg;
				document.getElementById("combopos").disabled=true;
      	        desactivaBotonSiguiente(); 
		  }*/
      }//fin data != null
}


function retornoQuitarPlanTarifarioEmpresa(listaActualizada){
     var comboPlan = $("radioTipoPlan").value;
     DWRUtil.removeAllOptions(comboPlan);
     DWRUtil.addOptions(comboPlan,listaActualizada,"codPlanTarif","desPlanTarif");
}

function retornoObtenerNumAbonadosCliente(data){
	if(data != null){
	      var valoresRetorno=data;
	      msg=valoresRetorno['mensaje'];
	  	  if (msg == null){
				var numeroAbonadosClienteDestino = valoresRetorno['numAbonados'];
				document.getElementById("numAbonadosClienteDestino").value = numeroAbonadosClienteDestino;
	  	  }else{
			  	var mensajes=document.getElementById("mensajes");
   		      	mensajes.innerHTML=msg;
		  }
      }//fin data != null
}

function limpiarEstadoAbonados(){
  $("cellEstadoAbonado").style.visibility = "hidden"; 

  if (arrayNumeroAbonados!=null && arrayNumeroAbonados.length > 0 ){
	  for(var i=0;i<arrayNumeroAbonados.length;i++){
      	var estadoAbonado = document.getElementById(arrayNumeroAbonados[i]);
	  	estadoAbonado.innerHTML="";
	  	estadoAbonado.title = "";
	  }
  }	
   
}
 

function activarPlanORango(radio)
{
  	    document.getElementById("opcionPlanORango").value="PLAN";
  		document.getElementById("montoCargo").disabled=true;
  		document.getElementById("rangoPlanCB").disabled=true;
  		document.getElementById("combopos").disabled=false;
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
  
//(+) EV 07/12/09 limites de consumo por plan
function fncResultadoObtenerLimitesConsumo(data){
		 if (data!=null){
	        var codError = data['codError']; 
	        var mensajeError =  data['msgError']; 
	        if (codError != "" ){
	        	mostrarMensajeError(mensajeError);
	        	return;
	        }
	        
			var listaActualizada = data["lista"];
			//(+)carga lista de limites de consumo con informacion de rangos
			listaLimiteConsumo = new Array();
			for (var indice=0; indice < listaActualizada.length; indice++){
				  	 var limiteConsumo = new Array(5);
				  	 limiteConsumo[0] = listaActualizada[indice]["codigoLimiteConsumo"];
				  	 limiteConsumo[1] = listaActualizada[indice]["montoMinimo"];
				  	 limiteConsumo[2] = listaActualizada[indice]["montoMaximo"];
				  	 limiteConsumo[3] = listaActualizada[indice]["flgCorte"];
				  	 limiteConsumo[4] = listaActualizada[indice]["montoCons"];
				  	 listaLimiteConsumo[indice] = limiteConsumo;
			}
			//(-)
			
			var codLimiteConsumoSeleccionado = document.getElementById("codLimiteConsumoSeleccionado").value;

		    DWRUtil.removeAllOptions("codLimiteConsumo");
		   	DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});
		    DWRUtil.addOptions("codLimiteConsumo",listaActualizada,"codigoLimiteConsumo","descripcionLimiteConsumo");
		    
		    var codLimiteConsumo = document.getElementById("codLimiteConsumo");
		    if (codLimiteConsumoSeleccionado !=""){
			    var encontrado = false;
			    for (index = 0; index< codLimiteConsumo.length; index++) {
			       	  if (codLimiteConsumo[index].value == codLimiteConsumoSeleccionado){
			        	codLimiteConsumo.selectedIndex = index;
			        	encontrado = true;
			        	
			        	//(+) obtiene informacion de rangos
						for (var indice=0; indice < listaLimiteConsumo.length; indice++){
							if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value){
								document.getElementById("montoMinimo").value = listaLimiteConsumo[indice][1];
								document.getElementById("montoMaximo").value = listaLimiteConsumo[indice][2];
								document.getElementById("flgCorte").value = listaLimiteConsumo[indice][3];
								document.getElementById("montoCons").value = listaLimiteConsumo[indice][4];	
								break;
							}
						}
						
						document.getElementById("montoLimiteConsumo").value = document.getElementById("montoLimiteIngresado").value;
						//(-)
						
			        	break;
			       	  } 
			    }
			    if (!encontrado) document.getElementById("codLimiteConsumoSeleccionado").value = ""
		    }
		    
		    if (codLimiteConsumo.length == 1){//No hay registros
				document.getElementById("montoMinimo").value = 0;
				document.getElementById("montoMaximo").value = 0;
				document.getElementById("flgCorte").value = "";
				document.getElementById("montoCons").value = 0;	
				document.getElementById("montoLimiteConsumo").value = 0;  
				document.getElementById("lbMontoLimiteConsumo").innerHTML="";  	 
		    }
			
			//Para prepagos se carga un valor por defecto
		   	if (document.getElementById("radioTipoPlan").value == "combopre"){
			   	codLimiteConsumo.selectedIndex = 1;
			}
			
	    }//fin if (data!=null)
}			

function fncSeleccionaLimiteConsumo(codLimiteConsumo){
		document.getElementById("codLimiteConsumoSeleccionado").value = codLimiteConsumo.value;
		
		if (codLimiteConsumo.value != "") {
			//(+)obtener rangos
			for (var indice=0; indice < listaLimiteConsumo.length; indice++){
				if (listaLimiteConsumo[indice][0] == codLimiteConsumo.value){
					document.getElementById("montoMinimo").value = listaLimiteConsumo[indice][1];
					document.getElementById("montoMaximo").value = listaLimiteConsumo[indice][2];
					document.getElementById("flgCorte").value = listaLimiteConsumo[indice][3];
					document.getElementById("montoCons").value = listaLimiteConsumo[indice][4];
					document.getElementById("montoLimiteConsumo").value = listaLimiteConsumo[indice][4];
					var lbCorte = "";
					if (document.getElementById("flgCorte").value == 1){
						lbCorte = "Con Corte";
					}else if (document.getElementById("flgCorte").value == 0){
						lbCorte = "Sin Corte";
					}
					
					document.getElementById("lbMontoLimiteConsumo").innerHTML = lbCorte;
					break;
				}
			}
			//(-)
			var min=document.getElementById("montoMinimo").value;
			var max=document.getElementById("montoMaximo").value;			
		}else{
			document.getElementById("montoMinimo").value = 0;
			document.getElementById("montoMaximo").value = 0;
			document.getElementById("flgCorte").value = "";
			document.getElementById("montoCons").value = 0;
			document.getElementById("montoLimiteConsumo").value = 0;
			document.getElementById("lbMontoLimiteConsumo").innerHTML="";
		}
		
}			
//(-) EV 07/12/09 limites de consumo por plan

function validaActivaNumFrecuentes(){
	
	var tipoPlan = 0;
	var radio=document.getElementById("radioTipoPlan").value;
	if (radio!="combopos") return;
	
	document.getElementById("numfreccpu").style["display"]="none";
	
	//(+) evera 16/07/08, se obtiene informacion desde la lista de sesion, se traspasa codigo a retornoClienteValidaActivaNumFrecuentes     	
	tipoPlan = 1; // es valido solo para pospagos
	var codigoClienteDest = document.getElementById("codClienteDestSelec").value;
	
   	JCondicionesOOSSCPU.buscaClienteSeleccionado (codigoClienteDest, tipoPlan, retornoClienteValidaActivaNumFrecuentes);
 
 
	/*
	var numFrecFijos = $("numFrecFijos").value!=''?parseInt($("numFrecFijos").value):0;
	var numFrecMovil = $("numFrecMovil").value!=''?parseInt($("numFrecMovil").value):0;
	var indFf		 = $("indFf").value!=''?parseInt($("indFf").value):0;
	var numFrecIng   = $("numFrecIng").value!=''?parseInt($("numFrecIng").value):0;
	
	var codigoClienteDest = document.getElementById("codClienteDestSelec").value;
	
	var destinoPospagoPermiteFrecuentes = 0;
	var clienteOrigenDiferenteClienteDestino = 0;
	
    if ( (numFrecFijos>0 || numFrecMovil>0) && (numFrecIng == 0 ) ){
    	destinoPospagoPermiteFrecuentes = 1;
    }
    else{
       return; 
    }
    
    if (codigoCliente != codigoClienteDest) clienteOrigenDiferenteClienteDestino = 1;
	
	//revisar si cliente destino es empresa
	

	var  cliDestinoCodCliente = listaCliDestinoCodCliente;
	var  cliDestinoTipPlanTarif = "I";
	if (cliDestinoCodCliente != null){
			for(var i=0; i<cliDestinoCodCliente.length; i++){
					var cliDestinoCodClienteAux = cliDestinoCodCliente[i];
					if (codigoClienteDest == cliDestinoCodClienteAux){
						cliDestinoTipPlanTarif = listaCliDestinoTipPlanTarif[i];					
						break;
					}
			}//fin for
	}//fin if (cliDestinoCodCliente != null)
	
	if  (  ( destinoPospagoPermiteFrecuentes == 1 )  &&
	  	   ( (cliDestinoTipPlanTarif = "I"  ) || 
	  	   ( (cliDestinoTipPlanTarif = "E") && (clienteOrigenDiferenteClienteDestino == 1) && (numFrecIng == 0) )) 
		)
	{
		document.getElementById("numfreccpu").style["display"]="";
	}*/
	
	//(-)
	
}

//(+) evera 16/07/08
function retornoClienteValidaActivaNumFrecuentes(dataCliente){


	var numFrecFijos = $("numFrecFijos").value!=''?parseInt($("numFrecFijos").value):0;
	var numFrecMovil = $("numFrecMovil").value!=''?parseInt($("numFrecMovil").value):0;
	var indFf		 = $("indFf").value!=''?parseInt($("indFf").value):0;
	var numFrecIng   = $("numFrecIng").value!=''?parseInt($("numFrecIng").value):0;
	
	var codigoClienteDest = document.getElementById("codClienteDestSelec").value;
	
	var destinoPospagoPermiteFrecuentes = 0;
	var clienteOrigenDiferenteClienteDestino = 0;
	
    if ( (numFrecFijos>0 || numFrecMovil>0) && (numFrecIng == 0 ) ){
    	destinoPospagoPermiteFrecuentes = 1;
    }
    else{
       return; 
    }
    
    if (codigoCliente != codigoClienteDest) clienteOrigenDiferenteClienteDestino = 1;
	
	//revisar si cliente destino es empresa
	var  cliDestinoTipPlanTarif = "I";
	if(dataCliente != null){
		 cliDestinoTipPlanTarif = dataCliente['tipPlanTarif'];
		 if (cliDestinoTipPlanTarif!="E") cliDestinoTipPlanTarif = "I";
    }
	
	if  (  ( destinoPospagoPermiteFrecuentes == 1 )  &&
	  	   ( (cliDestinoTipPlanTarif = "I"  ) || 
	  	   ( (cliDestinoTipPlanTarif = "E") && (clienteOrigenDiferenteClienteDestino == 1) && (numFrecIng == 0) )) 
		)
	{
		document.getElementById("numfreccpu").style["display"]="";
	}

}
//(-)

function validaComboClienteDestino(opcionClienteDestino)
  {
 	if (consultaEvalRiesgo) consultaEvalRiesgo = false; 
 	
 	document.getElementById("codClienteDestSelec").value = opcionClienteDestino.value;
    var mensajes=document.getElementById("mensajes");
    mensajes.innerHTML="";
    activaBotonSiguiente();
 	
 	var tipoPlan = 0;
	var radio=document.getElementById("radioTipoPlan").value;
	if (radio=="combopre")	tipoPlan = 1;
	else if (radio=="combopos")	tipoPlan = 2;
	else if (radio=="combohib")	tipoPlan = 3;
	
	//(+) evera 16/07/08, se obtiene info de la lista de sesion, y se traspasa codigo a retornoClienteValidaComboClienteDestino
   	JCondicionesOOSSCPU.buscaClienteSeleccionado (opcionClienteDestino.value, tipoPlan, retornoClienteValidaComboClienteDestino);
 
 
/*
	//validaciones cliente destino empresa
	//si cliente destino es empresa, se carga el plan asociado
	var  cliDestinoCodCliente = listaCliDestinoCodCliente;
	var  cliDestinoTipPlanTarif = "I";
	var  cliDestinoCodPlanTarif = "";
	if (cliDestinoCodCliente != null){
			for(var i=0; i<cliDestinoCodCliente.length; i++){
					var cliDestinoCodClienteAux = cliDestinoCodCliente[i];
					if (opcionClienteDestino.value == cliDestinoCodClienteAux){
						cliDestinoTipPlanTarif = listaCliDestinoTipPlanTarif[i];
						cliDestinoCodPlanTarif = listaCliDestinoCodPlanTarif[i];						
						break;
					}
			}//fin for
	}//fin if (cliDestinoCodCliente != null)
	
	if (cliDestinoTipPlanTarif == 'E'){ //Cliente destino es empresa	 
			document.getElementById("flgClienteDestinoEmpresa").value ="S";
			//obtener plan tarifario
			//JCondicionesOOSSCPU.cargarPlanTarifarioEmpresa(cliDestinoCodPlanTarif, opcionClienteDestino.value, retornoCargarPlanTarifarioEmpresa);
		    //document.getElementById("codPlanTarifSelec").value = cliDestinoCodPlanTarif;
		    //carga numero de abonados del cliente
		    JCondicionesOOSSCPU.obtenerNumAbonadosCliente(opcionClienteDestino.value, 0, retornoObtenerNumAbonadosCliente);
		  
	}//fin if (cliDestinoTipPlanTarif == 'E')
	else{ 
		// Cliente destino es individual (cliDestinoTipPlanTarif = I)
		//$("numFrecFijos").value = '';
		//$("numFrecMovil").value = '';
		//$("indFf").value = '';
		//$("codPlanTarifSelec").value = '';
				
		var flgClienteDestinoEmpresa = document.getElementById("flgClienteDestinoEmpresa").value;
		if (flgClienteDestinoEmpresa == "S"){ //Como el anterior cliente seleccionado era empresa, y ahora se selecciona 
										      //uno individual, se debe eliminar el plan empresa de la lista.
	        document.getElementById("flgClienteDestinoEmpresa").value = "N";
			document.getElementById("combopos").disabled=false;
			JCondicionesOOSSCPU.quitarPlanTarifarioEmpresa(retornoQuitarPlanTarifarioEmpresa);
			// limpia atributos del plan en pantalla
   	        document.getElementById("codPlanTarifSelec").value = "";
  	        document.getElementById("cargoBasicoSelec").value = "";
  	        document.getElementById("codLimiteConsumo").value = "";
  	        document.getElementById("desLimiteConsumo").value = "";  
   	        document.getElementById("cargoBasico").value = "";  
   	        document.getElementById("desPlanTarifSelec").value = "";  
  	        document.getElementById("tipoPlanTarifDestino").value = "";  
   	        document.getElementById("codLimiteConsumoSelec").value = "";  
   	        document.getElementById("codCargoBasicoDestino").value = "";  
   	        document.getElementById("numDiasDestino").value = "";  
			document.getElementById("combopos").selectedIndex = -1;
		}
		validaActivaNumFrecuentes();
	}  
	//fin validaciones de cliente destino empresa	
	
	atributosClienteDestino(opcionClienteDestino.value);
  */
  	
  }// fin function validaComboClienteDestino
  
 //(+) evera 16/07/08
 function retornoClienteValidaComboClienteDestino(dataCliente){
 	//validaciones cliente destino empresa
	//si cliente destino es empresa, se carga el plan asociado
	
	var  cliDestinoTipPlanTarif = "I";
	var  cliDestinoCodPlanTarif = "";
	var  codClienteDestino;
	
	if(dataCliente != null){
		 cliDestinoTipPlanTarif = dataCliente['tipPlanTarif'];
		 //cliDestinoCodPlanTarif = dataCliente['codPlanTarif'];
		 codClienteDestino      = dataCliente['codCliente'];
		 
		 if (cliDestinoTipPlanTarif!="E") cliDestinoTipPlanTarif = "I";
		 
		 //se actualiza el ciclo destino
		 var codCicloCliente=document.getElementById("codCicloCliente");
	     codCicloCliente.innerHTML = dataCliente['codCiclo'];
		 document.getElementById("codCicloClienteDestino").value = dataCliente['codCiclo'];
		 
    }
    
	if (cliDestinoTipPlanTarif == 'E'){ //Cliente destino es empresa
		document.getElementById("flgClienteDestinoEmpresa").value ="S";
		//obtener plan tarifario
		
		//JCondicionesOOSSCPU.cargarPlanTarifarioEmpresa(cliDestinoCodPlanTarif, codClienteDestino, retornoCargarPlanTarifarioEmpresa);
	    //document.getElementById("codPlanTarifSelec").value = cliDestinoCodPlanTarif;
	    //carga numero de abonados del cliente
	    JCondicionesOOSSCPU.obtenerNumAbonadosCliente(codClienteDestino, 0, retornoObtenerNumAbonadosCliente);
		  
	}//fin if (cliDestinoTipPlanTarif == 'E')
	else{ 
		var flgClienteDestinoEmpresa = document.getElementById("flgClienteDestinoEmpresa").value;
		if (flgClienteDestinoEmpresa == "S"){ //Como el anterior cliente seleccionado era empresa, y ahora se selecciona 
										      //uno individual, se debe eliminar el plan empresa de la lista.
	        document.getElementById("flgClienteDestinoEmpresa").value = "N";
			document.getElementById("combopos").disabled=false;
			
			JCondicionesOOSSCPU.quitarPlanTarifarioEmpresa(retornoQuitarPlanTarifarioEmpresa);
			// limpia atributos del plan en pantalla
   	        document.getElementById("codPlanTarifSelec").value = "";
  	        document.getElementById("cargoBasicoSelec").value = "";
  	        document.getElementById("codLimiteConsumo").value = "";
  	        //document.getElementById("desLimiteConsumo").value = "";  
   	        document.getElementById("cargoBasico").value = "";  
   	        document.getElementById("desPlanTarifSelec").value = "";  
  	        document.getElementById("tipoPlanTarifDestino").value = "";  
   	        document.getElementById("codLimiteConsumoSelec").value = "";  
   	        document.getElementById("codCargoBasicoDestino").value = "";  
   	        document.getElementById("numDiasDestino").value = "";  
			document.getElementById("combopos").selectedIndex = -1;
		}
		validaActivaNumFrecuentes();
	}  
	//fin validaciones de cliente destino empresa	
     
 }
 //(-)
  
// (+)evera 16/07/08, se comenta ya que las listas se manejaran en sesion
/*
//(+) evera 13/nov, funciones para evaluacion crediticia -----------------------------------------  
//funcion que obtiene los atributos del cliente destino 
function llenaClienteDestino(){
 	var radio=document.getElementById("radioTipoPlan").value;
    i=0;
    if (radio=="combopre"){
 	       	<logic:iterate id="listaClientesDestino" name="clientesPrepago" scope="session" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO">
	       	    listaCliDestinoCodCliente[i]= "<bean:write name='listaClientesDestino' property='codCliente'/>";
		        listaCliDestinoNombres[i]   = "<bean:write name='listaClientesDestino' property='nombres'/>";
		        listaCliDestinoApellido1[i] = "<bean:write name='listaClientesDestino' property='apellido1'/>";
		        listaCliDestinoApellido2[i] = "<bean:write name='listaClientesDestino' property='apellido2'/>";
		        listaCliDestinoTipIdent[i]  = "<bean:write name='listaClientesDestino' property='codigoTipoIdentificacion'/>";
		        listaCliDestinoNumIdent[i]  = "<bean:write name='listaClientesDestino' property='numeroIdentificacion'/>";
		        listaCliDestinoCicloFacturacion[i] = "<bean:write name='listaClientesDestino' property='codCiclo'/>";
   		        listaCliDestinoTipPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='tipPlanTarif'/>";
   		        listaCliDestinoCodPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='codPlanTarif'/>";
		        i++;
	        </logic:iterate>
    }
    else if(radio=="combopos"){
 	       	<logic:iterate id="listaClientesDestino" name="clientesPospago" scope="session" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO">
	       	    listaCliDestinoCodCliente[i]= "<bean:write name='listaClientesDestino' property='codCliente'/>";
		        listaCliDestinoNombres[i]   = "<bean:write name='listaClientesDestino' property='nombres'/>";
		        listaCliDestinoApellido1[i] = "<bean:write name='listaClientesDestino' property='apellido1'/>";
		        listaCliDestinoApellido2[i] = "<bean:write name='listaClientesDestino' property='apellido2'/>";
		        listaCliDestinoTipIdent[i]  = "<bean:write name='listaClientesDestino' property='codigoTipoIdentificacion'/>";
		        listaCliDestinoNumIdent[i]  = "<bean:write name='listaClientesDestino' property='numeroIdentificacion'/>";
		        listaCliDestinoCicloFacturacion[i] = "<bean:write name='listaClientesDestino' property='codCiclo'/>";
   		        listaCliDestinoTipPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='tipPlanTarif'/>";
   		        listaCliDestinoCodPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='codPlanTarif'/>";
		        i++;
	        </logic:iterate>
    }else if(radio=="combohib"){
 	       	<logic:iterate id="listaClientesDestino" name="clientesHibrido" scope="session" type="com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO">
	       	    listaCliDestinoCodCliente[i]= "<bean:write name='listaClientesDestino' property='codCliente'/>";
		        listaCliDestinoNombres[i]   = "<bean:write name='listaClientesDestino' property='nombres'/>";
		        listaCliDestinoApellido1[i] = "<bean:write name='listaClientesDestino' property='apellido1'/>";
		        listaCliDestinoApellido2[i] = "<bean:write name='listaClientesDestino' property='apellido2'/>";
		        listaCliDestinoTipIdent[i]  = "<bean:write name='listaClientesDestino' property='codigoTipoIdentificacion'/>";
		        listaCliDestinoNumIdent[i]  = "<bean:write name='listaClientesDestino' property='numeroIdentificacion'/>";
		        listaCliDestinoCicloFacturacion[i] = "<bean:write name='listaClientesDestino' property='codCiclo'/>";
   		        listaCliDestinoTipPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='tipPlanTarif'/>";
   		        listaCliDestinoCodPlanTarif[i]  = "<bean:write name='listaClientesDestino' property='codPlanTarif'/>";
		        i++;
	        </logic:iterate>
    } 	
}
*/
//(-)

function atributosClienteDestino(codCliente){
    //(+) evera 16/07/08, se obtiene ciclo desde lista en sesion    
    /*
    var codCicloCliente=document.getElementById("codCicloCliente");
    
   	for(var j=0;j<listaCliDestinoCodCliente.length;j++) {
   	    if(listaCliDestinoCodCliente[j]==codCliente){
	   	    codCicloCliente.innerHTML = listaCliDestinoCicloFacturacion[j];
			document.getElementById("codCicloClienteDestino").value = listaCliDestinoCicloFacturacion[j];
   	    }
   	}
   	*/
   	var radio=document.getElementById("radioTipoPlan"); 
   	var tipoPlan;
	if (radio.value == "combopre")	tipoPlan = 1; 
    else if (radio.value == "combopos")	tipoPlan = 2;
    else if (radio.value == "combohib")	tipoPlan = 3;

   	JCondicionesOOSSCPU.buscaClienteSeleccionado (codCliente,tipoPlan, retornoAtributosClienteDestino);
   	//(-)
}

//(+) evera 16/07/08
function retornoAtributosClienteDestino(dataCliente){

     if(dataCliente != null){
	     var codCicloCliente=document.getElementById("codCicloCliente");
	     codCicloCliente.innerHTML = dataCliente['codCiclo'];
		 document.getElementById("codCicloClienteDestino").value = dataCliente['codCiclo'];
	     
     }
}
//(-)


//(-) evera 13/nov, funciones para evaluacion crediticia-----------------------------------------------

function validaCheck(opcion)
{
    var mensajes=document.getElementById("mensajes");
    var opcionChekeada=opcion.value;
    mensajes.innerHTML="";
	activaBotonSiguiente();
	
   	if (!opcion.checked) document.getElementById("checkTodos").checked = false;
	
	validaActivaNumFrecuentes();
	
    /*var mensajes=document.getElementById("mensajes");
    var opcionChekeada=opcion.value;
    mensajes.innerHTML="";
    activaBotonSiguiente();
    if (opcion.checked){
    	activarBotonFrecuentes();
    } else {
        desactivarBotonFrecuentes();
    }*/
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
  
function activaBotonAnterior()
  {
     document.getElementById("Anterior1").disabled=false;
     document.getElementById("Anterior2").disabled=false;
  }  
  
function desactivaBotonAnterior()
  {
     document.getElementById("Anterior1").disabled=true;
     document.getElementById("Anterior2").disabled=true;
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

 function checkearDescheckear(valorCheck)
   {
	   	if (valorCheck.checked){
	   	   chequearTodos();
	   	   validaActivaNumFrecuentes();
	   	}else{
	   	   desChequearTodos();
	   	}
   
   }

 function activarBotonFrecuentes()  {
	//alert('activar');
 	document.getElementById("numfreccpu").disabled=false;	
 }
 
 function desactivarBotonFrecuentes()  {
	 //alert('desactivar');
 	document.getElementById("numfreccpu").disabled=true;
 }

function actualizarPlanTarifario(codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias){
     
     if (codigoPlanTarifario!='') {        
			 var comboPlan = $( $("radioTipoPlan").value);
			
			if (!consultaEvalRiesgo){ 
				//Elimina de la lista el ultimo elemento (si este corresponde a cliente empresa)
				if (comboPlan.options[comboPlan.length-1].label == 'E' ) { 
		    		comboPlan.remove(comboPlan.length-1);
		 		}
		 		// Añade el nuevo plan de cliente empresa
	 	     	var optPlanTarif = document.createElement('option');
	            optPlanTarif.value = codigoPlanTarifario;
	            optPlanTarif.text = descripcionPlanTarifario;
	            optPlanTarif.label = 'E';
	     		comboPlan.add(optPlanTarif);
	     		comboPlan.selectedIndex = comboPlan.length-1;
			} 			
			
			// Muestra atributos del plan en pantalla
			$("codLimiteConsumo").value =  codigoLimiteConsumo; 
			//$("desLimiteConsumo").innerHTML = descripcionLimiteConsumo;
			$("cargoBasico").innerHTML = importeCargoBasico
			$("desPlanTarifSelec").value = descripcionPlanTarifario;
			$("cargoBasicoSelec").value = importeCargoBasico;
			$("tipoPlanTarifDestino").value = tipoPlanTarifario;
			$("codLimiteConsumoSelec").value = codigoLimiteConsumo ; 
			$("codCargoBasicoDestino").value = codigoCargoBasico;
			$("numDiasDestino").value = numDias;	
     }     

}


function retornoObtenerPlanesEvalSesion (data){
	var listaActualizada = data['allLstPTaPlanTarifarioOutDTO'];
    var tipoComboPlan = $("radioTipoPlan").value; // combopre,combopos,combohib      
    DWRUtil.removeAllOptions(tipoComboPlan);
    DWRUtil.addOptions(tipoComboPlan,listaActualizada,"codigoPlanTarifario","descripcionPlanTarifario");
    
	var codPlanSeleccionado = document.getElementById("codPlanTarifSelec").value
    
    var comboPlan = $(tipoComboPlan);
      
    if (codPlanSeleccionado !=null ){ 
	  for (index = 0; index< comboPlan.length; index++) {
   	     if (comboPlan[index].value == codPlanSeleccionado){
       	   comboPlan.selectedIndex = index;
       	   break;
         }  
      }
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
	   cantidadPlanes = 0;
	   
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
	        cantidadPlanes = i;
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
	        cantidadPlanes = i;
       }
       
}

function atributosPlanTarifario(codPlanSelec){
    var j=0;
    var codLimiteConsumo=document.getElementById("codLimiteConsumo");
   // var desLimiteConsumo=document.getElementById("desLimiteConsumo");
    var cargoBasico=document.getElementById("cargoBasico");
    var numDias=document.getElementById("numDias");
       
   	for(j=0;j<listaCodPlanTarif.length;j++) {
   	    if(listaCodPlanTarif[j]==codPlanSelec){
   	        //codLimiteConsumo.innerHTML=listaCodLimiteConsumo[j];
   	        //desLimiteConsumo.innerHTML=listaDesLimiteConsumo[j];
   	        cargoBasico.innerHTML=listaCargoBasico[j];

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
    
function limpiarAtributosPlanTarifario(){
	var codLimiteConsumo=document.getElementById("codLimiteConsumo");
	//var desLimiteConsumo=document.getElementById("desLimiteConsumo");
    var cargoBasico=document.getElementById("cargoBasico");
    codLimiteConsumo.value="";
   //desLimiteConsumo.innerHTML="";
    cargoBasico.innerHTML="";

    //(+) EV 09/12/09 limpia datos de limites de consumo
  	DWRUtil.removeAllOptions("codLimiteConsumo");
    DWRUtil.addOptions("codLimiteConsumo",{'':'- Seleccione -'});		 
	document.getElementById("montoMinimo").value = 0;
	document.getElementById("montoMaximo").value = 0;
	document.getElementById("flgCorte").value = "";
	document.getElementById("montoCons").value = 0;	
	document.getElementById("montoLimiteConsumo").value = 0;  
	document.getElementById("lbMontoLimiteConsumo").innerHTML="";  	   	    	
    //(-) EV 09/12/09 limpia datos de limites de consumo	
}

//---------------------------------------------------------------------------------------------------
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
  	  parametrosCondicionesOS['codTipoPlanTarif']=codTipoPlanTarif; // gs
  	  parametrosCondicionesOS['codPlanTarifSelec']=document.getElementById("codPlanTarifSelec").value;
  	  parametrosCondicionesOS['codClienteDestino']=document.getElementById("codClienteDestSelec").value;
  	  parametrosCondicionesOS['tipoPlanTarifDestino']=document.getElementById("tipoPlanTarifDestino").value;
  	  parametrosCondicionesOS['codCausaBajaSel']=document.getElementById("causaBajaCB").value;

  	  
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
 	  JCondicionesOOSSCPU.validaCondicionesInicio(parametrosCondicionesOS, arrAbonados, retornoConsideracionesAjaxReturn);//evera 27/08/07 
 	}
 	
  }
  
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
   	  parametrosCondicionesOS['codCausaBajaSel']=document.getElementById("causaBajaCB").value;     
	  JCondicionesOOSSCPU.validaCondicionesContinuar(parametrosCondicionesOS, codigoMsg, respuestaMsg, retornoConsideracionesAjaxReturn);
  }  
//(-) evera 28/08/07  

//[+]-------------------Funciones ventana emergente---------------------------------------------------

function ocultarVentana(objetoId)
{
    limpiarOpcionesDevEquipo();
	limpiarEstadoEquipo();
	document.getElementById(objetoId).style["display"]="none";
}

function levantarVentanaDevEquipo()
{
    var estadoActiv = null;
    var ventana=document.getElementById("devEquipoComodato");
    ventana.style["display"]="";
    ventana.style["top"]=200;
    ventana.style["left"]=800;

    //limpiar todos los objetos checkeados
	limpiarOpcionesDevEquipo();
	document.getElementById("sscAmistarCK").checked = false;
	limpiarEstadoEquipo();
	document.getElementById("bodegaCB").value=-1;
	
    // habilitacion de los componentes por default al levantar la ventana
    document.getElementById("sscAmistarCK").disabled=false; //habilita
    estadoActiv = true;
    deshabilitaOHabilitaEstadoEquipo(estadoActiv); //deshabilita
    document.getElementById("bodegaCB").disabled=true; //deshabilita
    document.getElementById("Aceptar").disabled=true; //deshabilita
}


function deshabilitaOHabilitaEstadoEquipo(estado)
{
	var cargador = eval("document.CambiarPlanForm.optCargadorRB");
	for(var i=0; i<cargador.length; i++){
  		cargador[i].disabled = estado;
  	}
  	var estadoEq = eval("document.CambiarPlanForm.optEstadoRB");
    for(var i=0; i<estadoEq.length; i++){
  		estadoEq[i].disabled = estado;
  	}
}

function limpiarEstadoEquipo()
{
	var cargador = eval("document.CambiarPlanForm.optCargadorRB");
	for(var i=0; i<cargador.length; i++){
 		cargador[i].checked = false;
	}
	var estadoEq = eval("document.CambiarPlanForm.optEstadoRB");
	for(var i=0; i<estadoEq.length; i++){
  		estadoEq[i].checked = false;
  	}
}

function limpiarOpcionesDevEquipo()
{
	var devEqui = eval("document.CambiarPlanForm.optDevEquiRB");
	for(var i=0; i<devEqui.length; i++){
		devEqui[i].checked = false;
  	}	
}

function activarAreasVentana(valorDevolucion)
{
    var estadoActiv = null;
	if (valorDevolucion=="devEqui"){
		limpiarEstadoEquipo();
		document.getElementById("sscAmistarCK").disabled=true; //deshabilita
		estadoActiv = false;
	    deshabilitaOHabilitaEstadoEquipo(estadoActiv); //habilita
	    document.getElementById("bodegaCB").disabled=false; //habilita
	    document.getElementById("Aceptar").disabled=true; //deshabilita
	    	    
	}else if (valorDevolucion=="nodevEqui" || valorDevolucion=="devEquiDif"){
		limpiarEstadoEquipo();
		document.getElementById("sscAmistarCK").disabled=true; //deshabilita
		estadoActiv = true;
	    deshabilitaOHabilitaEstadoEquipo(estadoActiv); //deshabilita
	    document.getElementById("bodegaCB").disabled=true; //deshabilita
	    document.getElementById("Aceptar").disabled=false; //habilita
	    
	}else if (valorDevolucion=="compEqui"){
		limpiarEstadoEquipo();
		document.getElementById("sscAmistarCK").disabled=false; //habilita
		estadoActiv = true;
	    deshabilitaOHabilitaEstadoEquipo(estadoActiv); //deshabilita
	    document.getElementById("bodegaCB").disabled=true; //deshabilita
	    document.getElementById("Aceptar").disabled=false; //habilita
	}

}

function activaAceptar()
{
	document.getElementById("Aceptar").disabled=false; //habilita
}

function validaOpcionesVentana()
{
	var opDevuelveEq =  eval("document.CambiarPlanForm.optDevEquiRB");
	if(opDevuelveEq[0].checked == true){
	    var aceptarBT = document.getElementById("Aceptar");
		if(aceptarBT.disabled == false){
			var opcionBodega = document.getElementById("bodegaCB").value;
			if (opcionBodega == null || opcionBodega == "-1" ){
				alert("Debe escoger una Bodega Receptora");
			}else{
				document.getElementById("devEquipoComodato").style["display"]="none"; //cerrar la ventana			
			}
		}
	}else if (opDevuelveEq[1].checked == true || opDevuelveEq[2].checked == true || opDevuelveEq[3].checked == true ){
		document.getElementById("devEquipoComodato").style["display"]="none"; //cerrar la ventana			
	}
}    

//[-]-------------------------------------------------------------------------------------

    

    

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
   			   document.getElementById("indTraspaso").value = valoresRetorno['indTraspaso'];  
   			   
		 	   //alert("Condiciones para esta Orden de Servicio Fueron Evaluadas Correctamente");
		       document.forms[0].submit();
		  }
		  else {
	    		//Llena la columna estado de abonado
	    		var abonados = data['abonadosInvalidos'];
	    		var abonadosLista = eval("document.CambiarPlanForm.listaAbonados");
	    		
	      		if (abonados!=null){
					$("cellEstadoAbonado").style.visibility = "visible";
					
					if (abonadosLista!=null){
				      		for(var j=0; j<abonadosLista.length; j++){
						 var estadoAbonado=document.getElementById(abonadosLista[j].value);
						 estadoAbonado.innerHTML="";							 
						}
					}
				
					for(var i=0;i<abonados.length;i++){
						var estadoAbonado=document.getElementById(abonados[i].numAbonado);
						estadoAbonado.innerHTML="INVALIDO";
						estadoAbonado.title = abonados[i].desSituacion;
					}

					//var numAbonados = ${clienteOS.cliente.numAbonados};
					var numAbonados = "<c:out value="${clienteOS.cliente.numAbonados}"/>";
					if (abonados.length == 1 && numAbonados == 1) {
						var mensajes=document.getElementById("mensajes");
						mensajes.innerHTML=abonados[0].desSituacion;
						desactivaBotonSiguiente();
					}	
					else {
						alert ("Existen abonados que no cumplen con las condiciones comerciales\nRevisar los estados de los abonados invalidos");      		
						activaBotonSiguiente();
					}
					return false;
	      		}
	    		
	    		
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
  
  /* comentado, evera 15/07/08
  function actualizaListaCliente(tipoCliente) {
     JCondicionesOOSSCPU.actualizaListaCliente(tipoCliente);
  }*/  
  

 /* function buscaClienteSeleccionado(codCliente,tipoPlan) {
  	 JCondicionesOOSSCPU.buscaClienteSeleccionado(codCliente,tipoPlan,actualizaDatosCliente);
  }*/
  
  function actualizaDatosCliente(cliente){
     if (cliente != null){
	    var codCicloCliente=document.getElementById("codCicloCliente");
		codCicloCliente.innerHTML = cliente.codCiclo;
     }
  }
  
  function actualizaListaPlanTarifario(tipoPlan,codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias) {
    JCondicionesOOSSCPU.actualizaListaPlanTarifario(tipoPlan,codigoPlanTarifario,descripcionPlanTarifario,tipoPlanTarifario,codigoCargoBasico,descripcionCargoBasico,importeCargoBasico,importeLimite,importeFinal,codigoLimiteConsumo,descripcionLimiteConsumo,numDias);
  }  
  
  function buscaPlanTarifSeleccionado (codPlanTarif,tipoPlan){
	
	JCondicionesOOSSCPU.buscaPlanTarifSeleccionado(codPlanTarif,tipoPlan,actualizaAtributosPlan);	

  }
    
  function actualizaAtributosPlan(planTarif) {
  	if (planTarif!=null){
		//var codLimiteConsumo = $("codLimiteConsumo");
		//if (codLimiteConsumo!=null) codLimiteConsumo.innerHTML = planTarif.limiteConsumo;
		//var desLimiteConsumo = $("desLimiteConsumo");
		//if (desLimiteConsumo!=null ) desLimiteConsumo.innerHTML = planTarif.descripcionLimiteConsumo;
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
		
		//alert ("En retornoCargarPlanTarifarioIndivual "+"numFrecFijos:"+$("numFrecFijos").value+" numFrecMovil:"+$("numFrecMovil").value);
			
		validaActivaNumFrecuentes();	
		
		//(+) EV 07/12/09 carga combo de limites de consumo
		var radio=document.getElementById("radioTipoPlan").value;
		if (radio=="combopre" || radio=="combohib"){
			document.getElementById("divLimiteConsumoDefecto").style["display"]="";	
		}
		
		var codPlanTarif = planTarif.codPlanTarif;
		var clienteDestino = document.getElementById("codClienteDestSelec").value;
     	JCondicionesOOSSCPU.obtenerLimitesConsumo(codPlanTarif,clienteDestino, fncResultadoObtenerLimitesConsumo);
	    //(-) EV 07/12/09 carga combo de limites de consumo
		
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
  	  parametrosCondicionesOS['codCausaBajaSel']=document.getElementById("causaBajaCB").value;

  	  
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
  	 	var indiceSel = 0;
  	 	
  	 	if(check.value != null){//1 abonado
  	 		arrAbonados[0] = check.value;
  	 		indiceSel = 1;
  	 	}else{
  	 		var indiceSel = 0;
		     for(var i=0; i<check.length; i++){
		     
			      if(check[i].checked){
			      	arrAbonados[indiceSel] = check[i].value;
			      	indiceSel++;
			      }
			      
		     }
  	 	}
  	   
  	  //validaCuentaPersonal yosses 14/01/08	
 	  JCondicionesOOSSCPU.ValidaCuentaPersonal(parametrosCondicionesOS, arrAbonados, retornoConsideracionesAjaxReturn2); 

 	}
 	
  }
  
function retornoConsideracionesAjaxReturn2(data){//inicio

      if(data != null){          
	      var valoresRetorno=data;
	      var mensajeRetorno =  valoresRetorno ['mensaje'];// Este serviria para mostrar mensajes de cuenta personal
	      
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

			      /*if(msg == 'ALTA' ){	       // Se comenta a solicitud de la operadora RRG
				      	if(confirm('¿Desea realizar asociación de Número Personal?')){
				      		document.getElementById("numeroAbo").innerHTML = abonadosValidos[0].numAbonado
				      		document.getElementById("numeroCel").innerHTML = abonadosValidos[0].numCelular
				      		levantarVentanaCuentaPersonal();
				      	}else{
					      	evaluarCondicionesAjaxOOSS();	
				      	} 	
			      }
                  if(msg == 'BAJAALTA'){
                  		if(confirm(mensajeRetorno)){
                        	if(confirm('¿Desea realizar asociación de Número Personal?')){
                                 document.getElementById("numeroAbo").innerHTML = abonadosValidos[0].numAbonado
                                 document.getElementById("numeroCel").innerHTML = abonadosValidos[0].numCelular
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
		      } // if(msg != null)
		      else{
		      	evaluarCondicionesAjaxOOSS();	
		      }       
  	  }//if(data != null)
}



function ocultarVentana2(objetoId){

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
    var ventana=document.getElementById("divCuentaPersonal");
    ventana.style["display"]="";
    ventana.style["top"]=400;
    ventana.style["left"]=800;
}

function validarOpcionesCuentaPersonal(){
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
	
	JCondicionesOOSSCPU.ValidaAltaCuentaPersonal(celPers.value , retornoValidaciones);
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
		   		      	mensajes.innerHTML = "El Abonado NO puede asociarse como Número Personal por estar en un plan NO autorizado.";
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
		   		      	mensajes.innerHTML = msgError;
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

var nav4 = window.Event ? true : false;
function acceptNum(evt){	
// NOTA: Backspace = 8, Enter = 13, '0' = 48, '9' = 57	
	var tecla = nav4 ? evt.which : evt.keyCode;	
	return (tecla <= 13 || (tecla >= 48 && tecla <= 57));
}

function salir(){
	window.close();
}


// Devuelve la cantidad de abonados seleccionados
function obtenerCantAboSel() {
  	var totalAboSel = 0;
    var check = eval('document.forms[0].listaAbonados'); 
    
    if(check.length == undefined){
     	if (check.checked) totalAboSel = 1 ;
    }
    else{
	    for(var i=0; i<check.length;i++){
			if(check[i].checked){
			  totalAboSel = totalAboSel + 1;
			} 
	    }
    }
    return totalAboSel;
}


// Muestra mensajes de error
function mostrarMensajeError(mensaje){
	desactivaBotonSiguiente(); 
    $("mensajes").innerHTML = mensaje; 
}

function ocultarMensajeError(){
	$("mensajes").innerHTML = ""; 
	activaBotonSiguiente();
}

// Retorna true si al menos un cargo basico de los abonados seleccionados 
// es menor al cargo basico  del plan tarifario seleccionado   
function validaCargoBasicoAbonados(cargoBasicoPlanSel) {
	var retorno = false;
    var check =  eval('document.forms[0].listaAbonados');
   
    if(check.length == undefined){
     	if (check.checked && (parseInt(arrayCargoBasicoPlanAbonados[0]) <  parseInt(cargoBasicoPlanSel))   ){
     	 retorno = true ;
     	} 
    }
    else {

	    for(var i=0; i<check.length; i++){
			if(check[i].checked) {
				if ( parseInt(arrayCargoBasicoPlanAbonados[i]) <  parseInt(cargoBasicoPlanSel) )   {
					retorno = true;
					break;	 
				}			
			}
	    }
    }
	
	return retorno;
}

// busca clientes
// Este metodo se invoca desde el boton buscar cliente
function f_buscarClientes(tipoFiltro){
	var maxClientesPermitidos = document.getElementById("numMaxClientesLista").value;
	var codClienteFiltrado = document.getElementById("codClienteFiltro").value;
    var radio=document.getElementById("radioTipoPlan").value;
    var tipoCliente = 0;
  
  	if (codClienteFiltrado > 0){
 	    if (radio=="combopre") 	tipoCliente = 1;
	    if (radio=="combopos")	tipoCliente = 2;
	    if (radio=="combohib") 	tipoCliente = 3;
	
		activaBotonSiguiente();
	
	    JCondicionesOOSSCPU.buscarClientes(maxClientesPermitidos, tipoCliente, codClienteFiltrado, tipoFiltro, retornoBuscarClientes);
	}else{
		alert("Debe ingresar un c\u00F3digo de cliente.")
	}
}

function retornoBuscarClientes(data){
	if(data != null){         
		 	 
	      var valoresRetorno=data;
	      codMsgError=valoresRetorno['codMensaje'];
	      msgError=valoresRetorno['mensaje'];
		  if(codMsgError =="0"){
		      	var mensajes = document.getElementById("mensajes");
	   		    mensajes.innerHTML = "";
				
				var clientesFiltrados = valoresRetorno['clientesFiltrados'];
				var strComboCliente   = valoresRetorno['strComboCliente'];
				var largo = clientesFiltrados.length;
		
				//remover todos los clientes
				DWRUtil.removeAllOptions(strComboCliente);
				//Cargar lista, debe retornar 1
			    if (largo>0){
						var codigo = clientesFiltrados[0].codCliente;
						var nombre = clientesFiltrados[0].nombreCompleto;	
						var ciclo  = clientesFiltrados[0].codCiclo;
						var tipPlanTarif = clientesFiltrados[0].tipPlanTarif;						
									
					    var optCliente = document.createElement('option');
				        optCliente.text = codigo+"-"+nombre;
				        optCliente.value = codigo;
				        
				        $(strComboCliente).add(optCliente);
			   			$(strComboCliente).selectedIndex = $(strComboCliente).length-1;   
			   			
			   			$(strComboCliente).selectedIndex = 0; //selecciona el primero
	
						 //se actualiza el ciclo destino
						 var codCicloCliente=document.getElementById("codCicloCliente");
						 codCicloCliente.innerHTML = ciclo;
						 document.getElementById("codCicloClienteDestino").value = ciclo;
						 
						 //actualiza cliente seleccionado
						 document.getElementById("codClienteDestSelec").value = codigo;
						 
						 //validaciones cliente empresa
						 if (tipPlanTarif == "E"){//Cliente destino es empresa
						 	//var codPlanTarif = clientesFiltrados[0].codPlanTarif;	
							//document.getElementById("flgClienteDestinoEmpresa").value ="S";
							//obtener plan tarifario
							//JCondicionesOOSSCPU.cargarPlanTarifarioEmpresa(codPlanTarif, codigo, retornoCargarPlanTarifarioEmpresa);
						    //document.getElementById("codPlanTarifSelec").value = codPlanTarif;
						    //carga numero de abonados del cliente
						    JCondicionesOOSSCPU.obtenerNumAbonadosCliente(codigo, 0, retornoObtenerNumAbonadosCliente);
						 }
						 else{ 
							var flgClienteDestinoEmpresa = document.getElementById("flgClienteDestinoEmpresa").value;
							if (flgClienteDestinoEmpresa == "S"){ //Como el anterior cliente seleccionado era empresa, y ahora se selecciona 
															      //uno individual, se debe eliminar el plan empresa de la lista.
						        document.getElementById("flgClienteDestinoEmpresa").value = "N";
								document.getElementById("combopos").disabled=false;
								JCondicionesOOSSCPU.quitarPlanTarifarioEmpresa(retornoQuitarPlanTarifarioEmpresa);
								// limpia atributos del plan en pantalla
					   	        document.getElementById("codPlanTarifSelec").value = "";
					  	        document.getElementById("cargoBasicoSelec").value = "";
					  	        document.getElementById("codLimiteConsumo").value = "";
					  	        //document.getElementById("desLimiteConsumo").value = "";  
					   	        document.getElementById("cargoBasico").value = "";  
					   	        document.getElementById("desPlanTarifSelec").value = "";  
					  	        document.getElementById("tipoPlanTarifDestino").value = "";  
					   	        document.getElementById("codLimiteConsumoSelec").value = "";  
					   	        document.getElementById("codCargoBasicoDestino").value = "";  
					   	        document.getElementById("numDiasDestino").value = "";  
								document.getElementById("combopos").selectedIndex = -1;
							}
							validaActivaNumFrecuentes();
						 }
						 ////fin validaciones de cliente destino empresa	
			    }// fin if (largo>0)
	 
		   }else{ //mensaje de error
				  	var mensajes=document.getElementById("mensajes");
	   		      	mensajes.innerHTML=msgError;
	   		      	desactivaBotonSiguiente();
		   }
   		   document.getElementById("codClienteFiltro").value = "";
		   
	}//fin if(data != null)
}

	function fncValidaMontoDecimal(campoTexto){
  		if (campoTexto.value!=""){
	  	  	var re=/^\d{1,10}(\.\d{1,4})?$/;
	  	  	if (!re.test(campoTexto.value)){
	  	  		alert("Monto inv\u00E1lido");
	  	  		campoTexto.value="";
	  	  		campoTexto.focus();
	  	  	}
		}
	}
	
	function fncValidaRangoLimite(campoMontoLimiteConsumo){
		var montoMinimo = parseFloat(document.getElementById("montoMinimo").value);
		var montoMaximo = parseFloat(document.getElementById("montoMaximo").value);
		var montoLimiteIngresado = parseFloat(campoMontoLimiteConsumo.value);
		
		if (montoLimiteIngresado < montoMinimo || montoLimiteIngresado > montoMaximo){
			alert("L\u00EDmite de Consumo fuera de rango");
			campoMontoLimiteConsumo.value = 0;
			document.getElementById("montoLimiteIngresado").value = 0;
			return;
		}
		
		//guarda el limite por defecto
		document.getElementById("montoLimiteIngresado").value = montoLimiteIngresado;
		
	}
	
	function onlyFloat(valorCampoTexto,numDecimales) {
		var keyASCII;
		var txt;
		var strNumber = new String(event.srcElement.value);
		keyASCII = window.event.keyCode;
		
		if (keyASCII == 47) {
		  window.event.keyCode = '';	 
		  return;
		}
		
		if(keyASCII != 13 && keyASCII != 75 && keyASCII != 8 && keyASCII != 46
		   && (keyASCII < 46 || keyASCII > 57)) 
		{
		   window.event.keyCode = '';
		} else {
			
			if (window.getSelection)
	    	{
	        	txt = window.getSelection();
	        }
	    	else if (document.getSelection)
	    	{
	        	txt = document.getSelection();
	        }
	    	else if (document.selection)
	    	{
	        	txt = document.selection.createRange().text;
	        }
			if (txt != valorCampoTexto){
				if (valorCampoTexto.indexOf('.') != -1){
					dectext = valorCampoTexto.substring(valorCampoTexto.indexOf('.')+1, valorCampoTexto.length);
					if (dectext.length >= numDecimales) {
				   		window.event.keyCode = '';
					}
				}
			}
		}
	}//fin onlyFloat
	

//[-]-------------------------------------------------------------------------------------

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

