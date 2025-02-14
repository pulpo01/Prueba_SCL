<%@taglib uri="/WEB-INF/config/struts-bean.tld" prefix="bean"%>
<%@taglib uri="/WEB-INF/config/struts-html.tld" prefix="html"%>
<%@taglib uri="/WEB-INF/config/struts-logic.tld" prefix="logic"%>
<%
	String contextPath = request.getContextPath();
	org.apache.commons.configuration.CompositeConfiguration config2;
	config2 = com.tmmas.cl.framework20.util.UtilProperty
			.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
	String flgAplicaCategoriaCambio = (String)request.getAttribute("flgAplicaCategoriaCambio");
%>


<%
	//response.setHeader("Cache-Control","no-store"); //HTTP 1.1
	response.setHeader("Cache-Control", "no-cache"); //HTTP 1.1
	response.setHeader("Pragma", "no-cache"); //HTTP 1.0
	response.setDateHeader("Expires", 0); //prevents caching at the proxy server
%>


<html>
<head>
<script language='JavaScript' src='<%=contextPath%>/js/comun.js'></script>

<!-- <script language='JavaScript' src='<%=contextPath%>/js/niftycube.js'></script> -->
<link href="<%=contextPath%>/estilos/quiosco.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Ventas Prepago y Accesorios</title>
<script language="JavaScript" type="text/javascript">


//Funcion para enviar formularios 
function enviarForm(idForm){
	gifCargando('load');
	document.getElementById(idForm).submit();
}

function copiarDatos(html,idDiv){
	document.getElementById(idDiv).innerHTML=html;
}

function focoSerie(){
	document.getElementById("txtSerie").value="";
	document.getElementById("txtCantidad").value="1";
	var txtBox=document.getElementById("txtSerie");
    txtBox.focus(); 

}

function generarPDF(apliPago){
	//if("1"==apliPago){   SE SOLICITA MOSTRAR PDF APLIQUE O NO APLIQUE EL PAGO
	pantallaPDF('<%=contextPath%>/abrirPDF.jsp');
	//}
}

function pantallaPDF (pagina) 
{
var opciones=("toolbar=no, location=no,  directories=no, status=no, menubar=no ,scrollbars=yes, resizable=yes, fullscreen=no"); 
window.open(pagina,"",opciones); 
}

function mostrarPago(){
	document.getElementById("fP").style.display ="block";
	document.getElementById("fPC").style.display ="block";
}

//Funcion para enviar formulario del login
function enviarLoggeo(idForm){
	document.getElementById("usuario").value=document.getElementById("usuarioLogin").value;
	document.getElementById("password").value=document.getElementById("passwordLogin").value;
	document.getElementById("tienda").value=document.getElementById("tiendasLogin").value;
	document.getElementById("accionLogin").value="subirTienda";	
	enviarForm(idForm);    
}

//Funcion para enviar formulario del login
function salir(){
	document.getElementById("accionLogin").value="salir";
	if(confirm("Al salir de la aplicación se perderan los datos que no ha guardado, ¿Está seguro?")) {
	enviarForm("LoginForm");
	}    
}

function logout(){
	document.getElementById("accionLogin").value="logout";	
	enviarForm("LoginForm");	   
}




function llamarVenta(){
	document.getElementById("accionVenta").value="llamarVenta";
	enviarForm("VentaForm");   
}

//Funcion que se ocupa para actualizar la grilla de lineas en la venta
function agregarArticulo(serie,cantidad){
if(validacionAccion()){
	if(null==serie||trim(serie)==""){
		document.getElementById("dv-error-articulo").innerHTML="<span class='error'>No ha ingresado serie</span>";
		focoSerie();
		return false;
	}else{
	if(null==cantidad||cantidad==""||cantidad=="0"){
	   alert("La cantidad no puede ser menor a uno.");
	   return false;
	}

	document.getElementById("accionVenta").value="agregarArticulo";
	document.getElementById("serie").value=serie;
	document.getElementById("cantidad").value=cantidad;
	gifCargando('load');
	enviarForm("VentaForm");
	}
}
}

//Funcion para insertar articulo al pistolear
function pistolear(ky, serie, cantidad){
	document.getElementById("dv-error-articulo").innerHTML="";
	if(validarPistoleo(ky)=="si"){
		agregarArticulo(serie,cantidad);
	}
		
	}

function quitarAccesorio(accesorio){
	if(confirm("¿Seguro que desea quitar el accesorio?")) {
	document.getElementById("accionVenta").value="quitarAccesorio";
	document.getElementById("idAccesorio").value=accesorio;
	gifCargando('load');
	enviarForm("VentaForm");
	}
}

function llamarFormCliente(indPago){
	document.getElementById("accionVenta").value="llamarFormCliente";
	var tipoPago=document.getElementById("formasPago").value;

	if(tipoPago=="<%=config2.getString("forma.pago.cheque")%>"){
		document.getElementById("codBanco").value=document.getElementById("bancosCheque").value;
	}else if(tipoPago=="<%=config2.getString("forma.pago.debito")%>"){
		document.getElementById("codBanco").value=document.getElementById("bancosDebito").value;
	}else{
		document.getElementById("codBanco").value="0";
	}

	if(tipoPago=="<%=config2.getString("forma.pago.debito")%>"){
		document.getElementById("codBanco").value=document.getElementById("bancosDebito").value;
	}
	
	if(validarPrestacion(document.getElementById("cmbPrestaciones").value)){
		document.getElementById("codPrestacion").value=document.getElementById("cmbPrestaciones").value;
	}else{
		return false;
	}
	
	//Inicio JLGN 
	if(validarPlanTarifario(document.getElementById("cmbPlanTarifario").value)){
		document.getElementById("codPlantarif").value=document.getElementById("cmbPlanTarifario").value;
	}else{
		return false;
	}
	//Fin JLGN
	
	//document.getElementById("numCuentaCorriente").value=document.getElementById("txtNroCheque").value;
	document.getElementById("numDocumento").value=document.getElementById("txtNroCheque").value;
	document.getElementById("numCuentaCorriente").value=document.getElementById("txtCtaCorriente").value;
	document.getElementById("numTarjetaCredito").value=document.getElementById("txtNroTarjeta").value;
	document.getElementById("sistemaPago").value=document.getElementById("formasPago").value;
	
	document.getElementById("codTipTarjeta").value=document.getElementById("tarjetasCredito").value;

	if(validarPago(indPago)){
		enviarForm("VentaForm");
	}
	else{
		return false;
	}
}

function validarPrestacion(tipo){

	var tipoPrestacion=tipo;
	if("Seleccione"==tipoPrestacion){
		alert("Por favor seleccione un tipo de prestación");
		return false;
	}
	else{
		return true;
	}

}

//Inicio JLGN 
function validarPlanTarifario(tipo){
	var planTarif=tipo;
	if("Seleccione"==planTarif){
		alert("Por favor seleccione un plan Tarifario");
		return false;
	}
	else{
		return true;
	}
}

//Fin JLGN

function validarPago(indPago){
	var tipoPago=document.getElementById("formasPago").value;

     if("1"==indPago){
     
     //Seleccione

         if("seleccione"==tipoPago){
         	alert("Por Favor seleccione un tipo de pago");
	     	return false;
         }
     
     
     //Efectivo
     //	if(tipoPago=="<%=config2.getString("forma.pago.efectivo")%>"){
     	
	  //   	var oTotal = new oNumero(document.getElementById("hdnTotal").value);
		//	var oRecibido = new oNumero(document.getElementById("txtRecibido").value);
		
		//	var total = oTotal.formato(2, false);
		//	var recibido = oRecibido.formato(2, false);        
	    	
	   // 	r = parseFloat(recibido);
	  //  	t = parseFloat(total); 
	    	
	  //  	if(r<t){
	   //  		alert("Efectivo insuficiente para el monto total");
	    // 		return false;
	   //  	}
     	
    // 	}
     	
     	
     //cheque
     if(tipoPago=="<%=config2.getString("forma.pago.cheque")%>"){
     	
     	if("seleccione"==document.getElementById("bancosCheque").value){
     		alert("Por favor seleccione un banco");
	     	return false;
     	}
     	
     	if("0"==document.getElementById("txtNroCheque").value){
     		alert("Por favor ingrese un número de cheque");
	     	return false;
     	}
     	
     	//CSR-11002
     	if(document.getElementById("txtCtaCorriente").value == null ||
     	   document.getElementById("txtCtaCorriente").value == ""){
     		alert("Por favor ingrese la Cuenta Corriente");
	     	return false;
     	}
     	//FIN CSR-11002
     }
     
      //credito
     if(tipoPago=="<%=config2.getString("forma.pago.credito")%>"){
     
     	if("seleccione"==document.getElementById("tarjetasCredito").value){
     		alert("Por favor seleccione una tarjeta de credito");
	     	return false;
     	}
     	
     	if("0"==document.getElementById("txtNroTarjeta").value){
     		alert("Por favor ingrese un número de tarjeta");
	     	return false;
     	}

     	
     }
     
     
      //debito   
     if(tipoPago=="<%=config2.getString("forma.pago.debito")%>"){
     	if("seleccione"==document.getElementById("bancosDebito").value){
     		alert("Por favor seleccione un banco");
	     	return false;
     	}
     }
     
     }
     
	return true;
}

function buscarCliente(){
	document.getElementById("accionRegCliente").value="buscarCliente";
	document.getElementById("numCelular").value=document.getElementById("txtNumCelular").value;
	enviarForm("RegistroClienteForm");
}

function registroClienteFin(){
	document.getElementById("tipoIdentificacion").value=document.getElementById("cboTipoIdentificacion").value;
	document.getElementById("numeroIdentificacion").value=document.getElementById("txtNumeroIdentificacion").value;
	document.getElementById("nombreCliente").value=document.getElementById("txtNombreCliente").value;
	document.getElementById("primerApellido").value=document.getElementById("txtPrimerApellido").value;
	document.getElementById("segundoApellido").value=document.getElementById("txtSegundoApellido").value;
	document.getElementById("categoria").value=document.getElementById("cboCategoria").value;
	document.getElementById("codCliente").value=document.getElementById("codClienteHidden").value;
	document.getElementById("codCuenta").value=document.getElementById("codCuentaHidden").value;
        
	//P-CSR-11002 - INICIO - (AL) - 2011.07.28
	if (null != document.getElementById("cboCategoriaCambio")){
		document.getElementById("categoriaCambio").value=document.getElementById("cboCategoriaCambio").value;
	}
	if (null != <%=config2.getString("aplica.categoria.cambio")%>){
		document.getElementById("aplicaCategoriaCambio").value="<%=config2.getString("aplica.categoria.cambio")%>";
	}
	
	if(document.getElementById("cboCrediticia") != null){
		document.getElementById("codCrediticia").value=document.getElementById("cboCrediticia").value;
	}
	
	//P-CSR-11002 - FIN
	if(document.getElementById("control_COD_REGION") != null){
		document.getElementById("region").value=document.getElementById("control_COD_REGION").value;
	}
	if(document.getElementById("control_COD_PROVINCIA") != null){
		document.getElementById("provincia").value=document.getElementById("control_COD_PROVINCIA").value;
	}
	if(document.getElementById("control_COD_COMUNA") != null){
		document.getElementById("comuna").value=document.getElementById("control_COD_COMUNA").value;
	}
	if(document.getElementById("control_COD_CIUDAD") != null){
		document.getElementById("ciudad").value=document.getElementById("control_COD_CIUDAD").value;
	}
	if(document.getElementById("control_NOM_CALLE") != null){
		document.getElementById("nombreCalle").value=document.getElementById("control_NOM_CALLE").value;
	}
	if(document.getElementById("control_NUM_CALLE") != null){
		document.getElementById("numeroCalle").value=document.getElementById("control_NUM_CALLE").value;
	}
	if(document.getElementById("control_NUM_PISO") != null){
		document.getElementById("numPiso").value=document.getElementById("control_NUM_PISO").value;
	}
	if(document.getElementById("control_NUM_CASILLA") != null){
		document.getElementById("numCasilla").value=document.getElementById("control_NUM_CASILLA").value;
	}
	if(document.getElementById("control_OBS_DIRECCION") != null){
		document.getElementById("obsDireccion").value=document.getElementById("control_OBS_DIRECCION").value;
	}
	if(document.getElementById("control_DES_DIREC1") != null){
		document.getElementById("desDirec1").value=document.getElementById("control_DES_DIREC1").value;
	}
	if(document.getElementById("control_DES_DIREC2") != null){
		document.getElementById("desDirec2").value=document.getElementById("control_DES_DIREC2").value;
	}
	if(document.getElementById("control_COD_PUEBLO") != null){
		document.getElementById("codPueblo").value=document.getElementById("control_COD_PUEBLO").value;
	}
	if(document.getElementById("control_COD_ESTADO") != null){
		document.getElementById("codEstado").value=document.getElementById("control_COD_ESTADO").value;
	}
	if(document.getElementById("control_ZIP") != null){
		document.getElementById("zip").value=document.getElementById("control_ZIP").value;
	}
	if(document.getElementById("control_COD_TIPOCALLE") != null){
		document.getElementById("codTipoCalle").value=document.getElementById("control_COD_TIPOCALLE").value;
	}
	
	document.getElementById("accionRegCliente").value="registroFin";
	
	enviarForm("RegistroClienteForm");
}

function registrarUsuario(){
	document.getElementById("accionRegUsuario").value="registrarUsuario";
	document.getElementById("nomUsuario").value=document.getElementById("txtNombreUsuario").value
	document.getElementById("primerApellidoUsuario").value=document.getElementById("txtPrimerApellido").value
	document.getElementById("segundoApellidoUsuario").value=document.getElementById("txtSegundoApellido").value
	document.getElementById("eMailUsuario").value=document.getElementById("txtMail").value
	document.getElementById("telefonoContactoUsuario").value=document.getElementById("txtTelefonoContacto").value
	document.getElementById("simcardUsuario").value=document.getElementById("hiddenSimcard").value
	document.getElementById("imeiUsuario").value=document.getElementById("hiddenTerminal").value
	document.getElementById("celularUsuario").value=document.getElementById("hiddenCelular").value
	document.getElementById("codigoCentral").value=document.getElementById("cboCentrales").value
	enviarForm("RegistroUsuarioForm");
}

function cambiarFormaPago(tipoPago){
	
	if(tipoPago=="<%=config2.getString("forma.pago.efectivo")%>" ||
	   tipoPago=="<%=config2.getString("forma.pago.dolares")%>"){
	document.getElementById("<%=config2.getString("forma.pago.efectivo")%>").style.display ="block";
	document.getElementById("<%=config2.getString("forma.pago.cheque")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.credito")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.debito")%>").style.display ="none";	
	}

	if(tipoPago=="<%=config2.getString("forma.pago.cheque")%>"){
	document.getElementById("<%=config2.getString("forma.pago.efectivo")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.cheque")%>").style.display ="block";
	document.getElementById("<%=config2.getString("forma.pago.credito")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.debito")%>").style.display ="none";	
	}

	if(tipoPago=="<%=config2.getString("forma.pago.credito")%>"){
    document.getElementById("<%=config2.getString("forma.pago.cheque")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.efectivo")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.credito")%>").style.display ="block";
	document.getElementById("<%=config2.getString("forma.pago.debito")%>").style.display ="none";	
	}

	if(tipoPago=="<%=config2.getString("forma.pago.debito")%>"){
	document.getElementById("<%=config2.getString("forma.pago.cheque")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.efectivo")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.credito")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.debito")%>").style.display ="block";	
	}
	
	if(tipoPago=="Seleccione"){
	document.getElementById("<%=config2.getString("forma.pago.cheque")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.efectivo")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.credito")%>").style.display ="none";
	document.getElementById("<%=config2.getString("forma.pago.debito")%>").style.display ="none";	
	}
	
	
	
}

//INICIO Funciones para el mantenedor de clientizar

//Funcion para la carga del mantenedor
function cargarMantenedorClientizar(){
	document.getElementById("accionMantClient").value="preCargaIni";
	gifCargando('load');
	enviarForm("mantenedorClientizarForm");    
}

//Funcion para la agregar un articulo
function agregarArticuloClientizar(){

	if(validacionAccion()){

		if( confirm(" ¿Está seguro de que desea agregar este artículo? ") ){
		
			if( opcMantenedorClientizar("datosMin") ){
				//Set datos nuevos
				document.getElementById("codArticulo").value = document.getElementById("txtCodigoArticulo").value;
				document.getElementById("codTipificacion").value = document.getElementById("txtCodigoTipificacion").value;
				document.getElementById("descripcion").value = document.getElementById("txtDescripcion").value;

				//for (i=0; i < document.radioForm.radiobuttonTipificacion.length; ++i){

			    	//if (document.radioForm.radiobuttonTipificacion[i].checked){
			    		//document.getElementById("tipificacion").value  = document.radioForm.radiobuttonTipificacion[i].value;
			        	//break; 
			    	//}
			    //} 
		
				for (i=0; i < document.radioForm.radiobuttonClientizar.length; ++i){ 
			    	if (document.radioForm.radiobuttonClientizar[i].checked){
			    		document.getElementById("clientizable").value  = document.radioForm.radiobuttonClientizar[i].value;
			        	break; 
			    	}
			    }
				
				//document.getElementById("usuaSclClient").value = "USER";
			
				document.getElementById("accionMantClient").value = "agregarArticulo";
				gifCargando('load');
				enviarForm("mantenedorClientizarForm");
			}
		}
	}
}

//Funcion general de carga
function opcMantenedorClientizar(accion){

	if( "cargaIni" == accion ){
		document.getElementById("accionMantClient").value="cargaIni";
		gifCargando('load');
		enviarForm("mantenedorClientizarForm"); 
	
	}
	else if( "datosMin" == accion ){
	
		//Datos distitnos de vacio
		if( "" == trim(document.getElementById("txtCodigoArticulo").value) ){
			alert("Para agregar es necesario el código de articulo");
			document.getElementById("txtCodigoArticulo").focus();
			return false;
		}else if( "" == trim(document.getElementById("txtCodigoTipificacion").value) ){
			alert("Para agregar es necesario el código de tipificación");
			document.getElementById("txtCodigoTipificacion").focus();
			return false;
		}else if( "" == trim(document.getElementById("txtDescripcion").value) ){
			alert("Para agregar es necesario la descripción");
			document.getElementById("txtDescripcion").focus();
			return false;
		}
		else{
			return true;
		}
		
	}
	else if( "datosMinSinArt" == accion ){
	
		//Datos distitnos de vacio
		if( "" == trim(document.getElementById("txtCodigoTipificacion").value) ){
			alert("Para modificar es necesario el código de tipificación");
			document.getElementById("txtCodigoTipificacion").focus();
			return false;
		}//else if( "" == trim(document.getElementById("txtDescripcion").value) ){
			//alert("Para modificar es necesario la descripción");
			//document.getElementById("txtDescripcion").focus();
			//return false;
		//}
		else{
			return true;
		}
		
	}
	
}

//Funcion que quita un registro de articulo
function quitarLinea(codArt){

	if(validacionAccion()){

		if( confirm(" ¿Está seguro de que desea quitar este artículo? ") ){

			document.getElementById("accionMantClient").value="eliminarArt";
			document.getElementById("codArticulo").value = codArt;
			gifCargando('load');
			enviarForm("mantenedorClientizarForm");
		}
	}
} 

function quitarLineaVenta(linea){
if(confirm("¿Seguro que desea quitar la linea?")) {
	document.getElementById("accionVenta").value="quitarLinea";
	document.getElementById("idLinea").value=linea;
	gifCargando('load');
	enviarForm("VentaForm");
	}
} 

function quitarKitVenta(kit){
if(confirm("¿Seguro que desea quitar el quit?")) {
	document.getElementById("accionVenta").value="quitarKit";
	document.getElementById("idKit").value=kit;
	gifCargando('load');
	enviarForm("VentaForm");
}
} 



//Funcion que modifica un registro de articulo
function modificarLinea(codArt, linea){
	
	if(validacionAccion()){

		if( opcMantenedorClientizar("datosMinSinArt") ){
		
			//copyLinea(codArt, linea);
			
			if( confirm(" ¿Está seguro de que desea modificar este artículo? ") ){
		
				//Set datos a modificar
				document.getElementById("codArticulo").value = codArt;
				document.getElementById("codTipificacion").value = document.getElementById("txtCodigoTipificacion").value;
				document.getElementById("descripcion").value = document.getElementById("txtDescripcion").value;
				
				//for (i=0; i < document.radioForm.radiobuttonTipificacion.length; ++i){

			    	//if (document.radioForm.radiobuttonTipificacion[i].checked){
			    		//document.getElementById("tipificacion").value  = document.radioForm.radiobuttonTipificacion[i].value;
			        	//break; 
			    	//}
			    //} 
		
				for (i=0; i < document.radioForm.radiobuttonClientizar.length; ++i){ 
			    	if (document.radioForm.radiobuttonClientizar[i].checked){
			    		document.getElementById("clientizable").value  = document.radioForm.radiobuttonClientizar[i].value;
			        	break; 
			    	}
			    }
		
				//document.getElementById("usuaSclClient").value = "USER";
				
				document.getElementById("accionMantClient").value="modificarArt";
				gifCargando('load');
				enviarForm("mantenedorClientizarForm");
			}
		}
	}
} 

//Funcion para copiar data de un articulo
function copyLinea(codArt, fila){

	var tabla = document.getElementById("tablaArticulo");

	document.getElementById("txtCodigoArticulo").value = tabla.rows[fila].cells[0].innerText; //Codigo Articulo
	document.getElementById("txtCodigoTipificacion").value = tabla.rows[fila].cells[1].innerText; //Codigo Tipificacion
	document.getElementById("txtDescripcion").value = tabla.rows[fila].cells[2].innerText; //Descripcion
	
	for (i=0; i < document.radioForm.radiobuttonClientizar.length; ++i){ 
		if (document.radioForm.radiobuttonClientizar[i].value==tabla.rows[fila].cells[3].innerText){
			document.radioForm.radiobuttonClientizar[i].checked=true;
			break;
		}
	}	
}

//Funcion para los campos visibles
function limpiarMantClientizar(){

	document.getElementById("txtCodigoArticulo").value = "";
	document.getElementById("txtCodigoTipificacion").value = "";
	document.getElementById("txtDescripcion").value = "";
	//document.radioForm.radiobuttonTipificacion[0].checked = true;
	document.radioForm.radiobuttonClientizar[0].checked = true;
	document.getElementById("txtCodigoTipificacion").focus();

}
//FIN Funciones para el mantenedor de clientizar


//INICIO Funciones para el mantenedor de tienda
//Funcion para la carga del mantenedor
function cargarMantenedorTienda(){
	document.getElementById("accionMantTienda").value="preCargaIni";
	gifCargando('load');
	enviarForm("mantenedorTiendaForm");    
}

//Funcion para la agregar un articulo
function agregarTiendaMant(){

	if(validacionAccion()){
		if( confirm(" ¿Está seguro de que desea agregar esta tienda? ") ){
		
			if( opcMantenedorTienda("datosMin") ){
		
				//Set datos nuevos
				document.getElementById("nomTienda").value = document.getElementById("textNomTienda").value;
				document.getElementById("usuaVendedor").value = document.getElementById("textCajero").value;
				document.getElementById("usuacajero").value = document.getElementById("textCaja").value;
				document.getElementById("codClienteTien").value = document.getElementById("textCodCliente").value;
				document.getElementById("codCaja").value = document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].value;
				document.getElementById("desCaja").value = document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].text;
				document.getElementById("indApliPago").value = document.getElementById("cboApliPago").options[document.getElementById("cboApliPago").selectedIndex].value;				
				document.getElementById("accionMantTienda").value = "agregarTienda";
				gifCargando('load');
				enviarForm("mantenedorTiendaForm");
			}
		}
	}
}

//Funcion general de carga
function opcMantenedorTienda(accion){

	if( "cargaIni" == accion ){
		document.getElementById("accionMantTienda").value="cargaIni";
		gifCargando('load');
		enviarForm("mantenedorTiendaForm"); 
	}
	else if( "datosMin" == accion ){
	
		//Datos distitnos de vacio
		if( "" == trim(document.getElementById("textNomTienda").value) ){
			alert("Para agregar es necesario el nombre de la tienda");
			document.getElementById("textNomTienda").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCajero").value) ){
			alert("Para agregar es necesario el vendedor");
			document.getElementById("textCajero").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCaja").value) ){
			alert("Para agregar es necesario el cajero");
			document.getElementById("textCaja").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCodCliente").value) ){
			alert("Para agregar es necesario el codigo de cliente");
			document.getElementById("textCodCliente").focus();
			return false;
		}else if( "seleccione" == trim( document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].text)){
			alert("Para agregar tienda es necesario seleccionar Caja");
			document.getElementById("cboCaja").focus();
			return false;
		}else if( "seleccione" == trim( document.getElementById("cboApliPago").options[document.getElementById("cboApliPago").selectedIndex].text)){
			alert("Para agregar tienda es necesario seleccionar indicador de aplicación del pago");
			document.getElementById("cboApliPago").focus();
			return false;
		}else{
			return true;
		}
		
	}
	else if( "datosMinMod" == accion ){
	
		//Datos distitnos de vacio
		if( "" == trim(document.getElementById("textNomTienda").value) ){
			alert("Para modificar es necesario el nombre de la tienda");
			document.getElementById("textNomTienda").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCajero").value) ){
			alert("Para modificar es necesario el vendedor");
			document.getElementById("textCajero").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCaja").value) ){
			alert("Para modificar es necesario el cajero");
			document.getElementById("textCaja").focus();
			return false;
		}else if( "" == trim(document.getElementById("textCodCliente").value) ){
			alert("Para modificar es necesario el codigo de cliente");
			document.getElementById("textCodCliente").focus();
			return false;
		}else if( "seleccione" == trim( document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].text)){
			alert("Para modificar tienda es necesario seleccionar Caja");
			document.getElementById("cboCaja").focus();
			return false;
		}else{
			return true;
		}
		
	}
	
}

//Funcion que quita un registro de articulo
function quitarLineaTienda(codTien){

	if(validacionAccion()){

		if( confirm(" ¿Está seguro de que desea quitar esta tienda? ") ){

			document.getElementById("accionMantTienda").value="eliminarTien";
			document.getElementById("codTienda").value = codTien;
			gifCargando('load');
			enviarForm("mantenedorTiendaForm");
	
		}
	}
} 


function limpiarCliente(){
	document.getElementById("accionVenta").value="llamarFormCliente";
	enviarForm("VentaForm");
}

//Funcion que modifica un registro de articulo
function modificarLineaTienda(codTien, linea){
	
	if(validacionAccion()){

		if( opcMantenedorTienda("datosMinMod") ){
		
			//copyLineaTienda(codTien, linea);
			
			if( confirm(" ¿Está seguro de que desea modificar esta tienda? ") ){
		
				//Set datos a modificar
				document.getElementById("codTienda").value = codTien;
				document.getElementById("nomTienda").value = document.getElementById("textNomTienda").value;
				document.getElementById("usuaVendedor").value = document.getElementById("textCajero").value;
				document.getElementById("usuacajero").value = document.getElementById("textCaja").value;
				document.getElementById("codCaja").value = document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].value;
				document.getElementById("desCaja").value = document.getElementById("cboCaja").options[document.getElementById("cboCaja").selectedIndex].text;
				document.getElementById("indApliPago").value = document.getElementById("cboApliPago").options[document.getElementById("cboApliPago").selectedIndex].value;				
				document.getElementById("codClienteTien").value = document.getElementById("textCodCliente").value;
				
				document.getElementById("accionMantTienda").value="modificarTien";
				gifCargando('load');
				enviarForm("mantenedorTiendaForm");
			}
		}
	}
} 

//Funcion para copiar data de un articulo
function copyLineaTienda(codTien, fila){

	var tabla = document.getElementById("tablaTienda");

	document.getElementById("textNomTienda").value = tabla.rows[fila].cells[0].innerText; //Nombre de la tienda
	
	//if( "" == trim(document.getElementById("textCajero").value) ){
		document.getElementById("textCajero").value = tabla.rows[fila].cells[1].innerText; //Cajero
	//}
	
	//if( "" == trim(document.getElementById("textCaja").value) ){
		document.getElementById("textCaja").value = tabla.rows[fila].cells[2].innerText; //Caja
	//}
	
	//if( "" == trim(document.getElementById("textCodCliente").value) ){
		document.getElementById("textCodCliente").value = tabla.rows[fila].cells[4].innerText; //Codigo cliente
	//}
	
   var combo = document.getElementById('cboCaja');
   var cantidad = combo.length;
   for (i = 0; i < cantidad; i++) {
      if (combo[i].text == tabla.rows[fila].cells[5].innerText) {
          combo[i].selected = true;
          break;
      }   
	}

	var combo2 = document.getElementById('cboApliPago');
   var cantidad2 = combo2.length;
   for (i = 0; i < cantidad2; i++) {
      if (combo2[i].text == tabla.rows[fila].cells[6].innerText) {
          combo2[i].selected = true;
          break;
      }   
	}


}

//Funcion para los campos visibles
function limpiarMantTienda(){

	document.getElementById("textNomTienda").value = "";
	document.getElementById("textCajero").value = "";
	document.getElementById("textCaja").value = "";
	document.getElementById("textCodCliente").value = "";
	document.getElementById("textNomTienda").focus();
	//document.radioTiendaForm.radiobuttonVigente[0].checked = true;
	
   var combo = document.getElementById('cboCaja');
   var cantidad = combo.length;
   for (i = 0; i < cantidad; i++) {
      if (combo[i].value == 'seleccione') {
         combo[i].selected = true;
      }   
	}

}

//FIN Funciones para el mantenedor de tienda

//Funcion para aparecer y desaparecer GIF de carga
function gifCargando(accion) {
	if(accion == 'load') {
	    document.getElementById('disablingDiv').style.display='block';
		//document.getElementById('waitDiv').style.visibility = 'visible';
		document.getElementById('accionOnOff').value =  'ON';
		//document.getElementById('dv-datos').style.visibility = 'hidden';
	}
	else if(accion == 'unload') {
		document.getElementById('disablingDiv').style.display='none';
		//document.getElementById('waitDiv').style.visibility = 'hidden';
		document.getElementById('accionOnOff').value =  'OFF';
		//document.getElementById('dv-datos').style.visibility = 'visible';
	}
}

//Funcion para validar si se esta realizando alguna accion
function validacionAccion() {
	if( "ON" == document.getElementById('accionOnOff').value ) {
		return false;
	}
	else if( "OFF" == document.getElementById('accionOnOff').value ) {
		return true;
	}
}

function cargarDirecciones(accion){
	if(accion!=""){
	document.getElementById("accionRegCliente").value=accion;
	document.getElementById("region").value=document.getElementById("cboRegion").value;
	document.getElementById("provincia").value=document.getElementById("cboProvincia").value;
	document.getElementById("ciudad").value=document.getElementById("cboCiudad").value;
	document.getElementById("comuna").value=document.getElementById("cboComuna").value;
	
	enviarForm("RegistroClienteForm");
	}
}

function fncOnChangeCMB(campoControl){
		if (campoControl =="COD_REGION"){
			//fncObtenerProvincia();
			document.getElementById("accionRegCliente").value="cargarProvincias";
		}else if (campoControl =="COD_PROVINCIA"){
			//fncObtenerCiudad();
			document.getElementById("accionRegCliente").value="cargarCiudades";
		}else if (campoControl =="COD_CIUDAD"){
			//fncObtenerComuna();fncObtenerCodigosPostales();
			document.getElementById("accionRegCliente").value="cargarComunas";
		}else{
			return false;
		}
		
		if(document.getElementById("control_COD_REGION") != null){
			document.getElementById("region").value=document.getElementById("control_COD_REGION").value;
		}
		
		if(document.getElementById("control_COD_PROVINCIA") != null){
			document.getElementById("provincia").value=document.getElementById("control_COD_PROVINCIA").value;
		}
		
		if(document.getElementById("control_COD_CIUDAD") != null){
			document.getElementById("ciudad").value=document.getElementById("control_COD_CIUDAD").value;
		}
		
		if(document.getElementById("control_COD_COMUNA") != null){
			document.getElementById("comuna").value=document.getElementById("control_COD_COMUNA").value;
		}		
		
		enviarForm("RegistroClienteForm");
}

function roundNumber(rnum, rlength) { // Arguments: number to round, number of decimal places
  var newnumber = Math.round(rnum*Math.pow(10,rlength))/Math.pow(10,rlength);
  document.roundform.numberfield.value = newnumber; // Output the result to the form field (change for your purposes)
}


function calcularVuelto(ky){
	
	
	
	var oTotal = new oNumero(document.getElementById("hdnTotal").value);
	var oRecibido = new oNumero(document.getElementById("txtRecibido").value);
	
	var total = oTotal.formato(2, false);
	var recibido = oRecibido.formato(2, false);
    //var total    = Math.round(parseFloat(document.getElementById("hdnTotal").value)*Math.pow(10,2))/Math.pow(10,2);
    //var recibido = Math.round(parseFloat(document.getElementById("txtRecibido").value)*Math.pow(10,2))/Math.pow(10,2);
        
    var vuelto= recibido-total;
    
    if(isNaN(vuelto)){
    	vuelto=0; 
    }
    
    var oVuelto = new oNumero(vuelto);
    document.getElementById("txtVuelto").value=oVuelto.formato(2, false);
}


function formatearRecibido(){
	var oRecibido = new oNumero(document.getElementById("txtRecibido").value);
    document.getElementById("txtRecibido").value=oRecibido.formato(2, false);
}

function cerrarVentana(){
	window.close(); 
}

</script>
</head>
<script language="JavaScript" type="text/javascript">
 onload = function() {
     //Nifty("div#dv-datos","transparent"); 
    /* var html = document.getElementById('waitDiv').innerHTML; 
     copiarDatos(html,"dv-datos");*/
     enviarForm("InicioForm");
}
</script>

<body topmargin="0" leftmargin="0" bgcolor="#F2F2F2" OnContextMenu="return false" onUnload="javascript:logout()">
<div id="disablingDiv" >
<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">

			<tr>
				<td class="texto" align="center" valign="middle" width="100%" height="100%"><img src="<%=contextPath%>/imagenes/carga.gif" border="0"/></td>
			</tr>
		</table>
</div>
		<!-- <div id="waitDiv" style="position: absolute; z-index: 6; visibility: hidden; right: 50%; left: 50%;">
		<table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td class="texto" align="center" valign="baseline"><img src="<%=contextPath%>/imagenes/carga.gif" border="0"
					align="middle" /></td>
			</tr>
		</table>
		</div> -->

<center>
<table width="1024px" height="100%" align="center" border="0" bgcolor="white" id="tablaPrincipal">
	<tr>
		<td height="90px" width="100%" align="right" valign="top">
		<table width="100%" border="0" height="100%" background="<%=contextPath%>/imagenes/encabezado3.jpg"
			Style="background-repeat: no-repeat; background-position: center;">
			<tr>
				<td align="right" valign="top">
				<div id="dv-datos-link"></div>
				</td>
			</tr>
			<tr>
				<td align="center" valign="bottom">
				<div id="dv-datos-vendedor"></div>
				</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr align="center" valign="center">
		<td width="auto" height="*" colspan="2" valign="center" align="center">
		
		<div id="dv-datos"></div>

		<!-- Formulario para LOGIN-->
		<form action="j_security_check" method="POST" onkeydown="javascript:return false" name="seguridad" id="seguridad"
			target="ctrl"><input type="hidden" name="j_username" id="usuario" /> <input type="hidden" name="j_password"
			id="password" /></form>
		<form action="<%=contextPath%>/action/LoginAction.do" onkeydown="javascript:return false" method="POST"
			name="LoginForm" id="LoginForm" target="ctrl"><input type="hidden" name="accionLogin" id="accionLogin" /> <input
			type="hidden" name="tienda" id="tienda" /></form>
		<!-- Formulario para INICIO -->
		<form action="<%=contextPath%>/action/InicioAction.do" method="POST" onkeydown="javascript:return false"
			name="InicioForm" id="InicioForm" target="ctrl"><input type="hidden" name="accionInicio" id="accionInicio" /></form>
		<!-- Formulario para VENTA -->
		<form action="<%=contextPath%>/action/VentaAction.do" onkeydown="javascript:return false" id="VentaForm"
			name="VentaForm" method="post" target="ctrl"><input type="hidden" name="serie" id="serie" value=""> <input
			type="hidden" name="cantidad" id="cantidad"> <input type="hidden" name="accionVenta" id="accionVenta" /> <input
			type="hidden" name="idLinea" id="idLinea" /> <input type="hidden" name="idAccesorio" id="idAccesorio" /><input
			type="hidden" name="idKit" id="idKit" /> <input type="hidden" name="codBanco" id="codBanco" /> <input type="hidden"
			name="codCajaQuiosco" id="codCajaQuiosco" /> <input type="hidden" name="numCuentaCorriente" id="numCuentaCorriente" />
		<input type="hidden" name="numTarjetaCredito" id="numTarjetaCredito" /> <input type="hidden" name="sistemaPago"
			id="sistemaPago" /><input type="hidden" name="codTipTarjeta" id="codTipTarjeta" value=""/>
			<input type="hidden" name="codPrestacion" id="codPrestacion" value=""/>
			<input type="hidden" name="numDocumento" id="numDocumento"/>
			<input type="hidden" name="codPlantarif" id="codPlantarif" value=""/>
			</form>

		<!-- Formulario para REGISTRO CLIENTE -->
		<form action="<%=contextPath%>/action/RegistroClienteAction.do" onkeydown="javascript:return false"
			name="RegistroClienteForm" id="RegistroClienteForm" method="post" target="ctrl"><input type="hidden"
			name="numLineaActual" id="numLineaActual"> <input type="hidden" name="numCelular" id="numCelular"> <input
			type="hidden" name="tipoIdentificacion" id="tipoIdentificacion"> <input type="hidden"
			name="numeroIdentificacion" id="numeroIdentificacion"> <input type="hidden" name="nombreCliente"
			id="nombreCliente"> <input type="hidden" name="primerApellido" id="primerApellido"> <input
			type="hidden" name="segundoApellido" id="segundoApellido"> <input type="hidden" name="categoria"
			id="categoria"> <input type="hidden" name="region" id="region"> <input type="hidden" name="provincia"
			id="provincia"> <input type="hidden" name="comuna" id="comuna"> <input type="hidden" name="ciudad"
			id="ciudad"> <input type="hidden" name="nombreCalle" id="nombreCalle"> <input type="hidden" name="numeroCalle"
			id="numeroCalle"> <input type="hidden" name="numPiso" id="numPiso"> <input type="hidden" name="numCasilla"
			id="numCasilla"> <input type="hidden" name="obsDireccion" id="obsDireccion"> <input type="hidden" name="desDirec1"
			id="desDirec1"> <input type="hidden" name="desDirec2" id="desDirec2"> <input type="hidden" name="codPueblo"
			id="codPueblo"> <input type="hidden" name="codEstado" id="codEstado"> <input type="hidden" name="zip" id="zip"> <input
			type="hidden" name="codTipoCalle" id="codTipoCalle"> <input type="hidden" name="accionRegCliente"
			id="accionRegCliente"> <input type="hidden" name="codCliente" id="codCliente"> <input type="hidden" name="codCuenta"
			id="codCuenta">
			<!-- P-CSR-11002 - INICIO -->
			<input type="hidden" name="categoriaCambio" id="categoriaCambio">
			<input type="hidden" name="aplicaCategoriaCambio" id="aplicaCategoriaCambio">
			<input type="hidden" name="codCrediticia" id="codCrediticia" value=""/>
			<!-- P-CSR-11002 - FIN -->
			</form>

			

		<!-- Formulario para REGISTRO USUARIO -->
		<form action="<%=contextPath%>/action/RegistroUsuarioAction.do" onkeydown="javascript:return false"
			id="RegistroUsuarioForm" method="post" target="ctrl"><input type="hidden" name="nomUsuario" id="nomUsuario">
		<input type="hidden" name="primerApellidoUsuario" id="primerApellidoUsuario"> <input type="hidden"
			name="segundoApellidoUsuario" id="segundoApellidoUsuario"> 
			<input type="hidden" name="eMailUsuario" id="eMailUsuario"> <input type="hidden" name="telefonoContactoUsuario" id="telefonoContactoUsuario">
		<input type="hidden" name="simcardUsuario" id="simcardUsuario"> <input type="hidden" name="imeiUsuario"
			id="imeiUsuario"> <input type="hidden" name="celularUsuario" id="celularUsuario"> <input
			type="hidden" name="accionRegUsuario" id="accionRegUsuario"><input
			type="hidden" name="codigoCentral" id="codigoCentral"></form>

		<!-- Formulario para Manenedor Clientizacion -->
		<form action="<%=contextPath%>/action/MantenedorClientizarAction.do" onkeydown="javascript:return false"
			id="mantenedorClientizarForm" method="post" target="ctrl"><input type="hidden" name="accionMantClient"
			id="accionMantClient" value=""> <input type="hidden" name="cadenaArticulos" id="cadenaArticulos" value="">
		<!-- Datos del Articulo --> <input type="hidden" name="codArticulo" id="codArticulo" value=""> <input
			type="hidden" name="codTipificacion" id="codTipificacion" value=""> <input type="hidden" name="descripcion" id="descripcion" value="">
		<!-- input type="hidden" name="tipificacion" id="tipificacion" value="" --> <input type="hidden" name="clientizable"
			id="clientizable" value=""> <input type="hidden" name="usuaSclClient" id="usuaSclClient" value=""></form>
		<!-- Formulario para Manenedor Clientizacion --> <!-- Formulario para Manenedor Tienda -->
		<form action="<%=contextPath%>/action/MantenedorTiendaAction.do" onkeydown="javascript:return false"
			id="mantenedorTiendaForm" method="post" target="ctrl"><input type="hidden" name="accionMantTienda"
			id="accionMantTienda" value=""> <input type="hidden" name="cadenaTienda" id="cadenaTienda" value="">
		<!-- Datos de la tienda --> <input type="hidden" name="codTienda" id="codTienda" value=""> <input
			type="hidden" name="nomTienda" id="nomTienda" value=""> <input type="hidden" name="usuaVendedor"
			id="usuaVendedor" value=""> <input type="hidden" name="usuacajero" id="usuacajero" value=""> <input
			type="hidden" name="codCaja" id="codCaja" value=""> <input type="hidden" name="desCaja" id="desCaja" value="">
			<input type="hidden" name="indApliPago" id="indApliPago" value="">
		<input type="hidden" name="usuaTien" id="usuaTien" value=""> <input type="hidden" name="codClienteTien"
			id="codClienteTien" value=""></form>
		<!-- Formulario para Manenedor Tienda --> <!-- Formulario General -->
		<form><input type="hidden" name="accionOnOff" onkeydown="javascript:return false" id="accionOnOff" value="OFF" /></form>
		</td>
	</tr>
	<tr valign=top>
		<td height="27" align="center" valign="top" colspan="2">
		<div align="center"><img src="<%=contextPath%>/imagenes/logoChico.gif" align=middle height="20px" width="25px">
		® 2010 Movistar. Telefónica. Todos los derechos reservados. Sitio Web diseñado para resolución 1024x768</div>
		</td>
	</tr>
</table>

<iframe name="ctrl"
	style="position: absolute; width: 220px; height: 50px; z-index: 1000; border-style: solid; border-width: 1; left: 80; top: 180; display: none;"
	ID="newmenuitem" MARGINHEIGHT=0 MARGINWIDTH=0 NORESIZE FRAMEBORDER=0 SCROLLING=NO</iframe>
</body>
</html>