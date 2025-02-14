//Validadores de Formularios
 var arrError=new Array;
function navegacion(form,accion){
	form.accion.value=accion;
	form.submit();
}
var descripcionproductosel;
var codigoproductosel;
var numeroMaximosel;
var flagBloqueo=0;
var limConsuPorDefecto=new Array;
var totalProd = 0;

function guardarLcPorDefecto(codLimConsu)
{

	limConsuPorDefecto.add(codLimConsu);

}

function guardarProductosPorAbonado(form,accion,envia){
	
	totalProd = form.cantidades.length;
	
    if (error>0 || flagBloqueo==1)
    {
	   //document.getElementById("alerta").height=50;
	   return;
    }
    if(!verificarErrorLC())
	{
		return;
    }
	if(!verificaCantidades())
	{
		muestraErrorCant();
		return;
    }

    
  /*(+)EV 26/03/09*/
  var prodInv = false;
  for(i=1;i<totalProd;i++)
  {
  	var boton = "boton_error_"+i;
  	var valorDisplay = document.getElementById(boton).style.display;
  	if (valorDisplay == "block"){
  		prodInv = true;
  		break
  	}
  }

  if (prodInv){
 		muestraError();
    	return false;
  }
  
  /*(+)EV 26/03/09*/
	flagBloqueo=1;
	form.accion.value=accion;
	form.action=envia;
	form.submit();
}

function muestraErrorCant()
{
  	  //cantidad.className="error";
  	  //error=error+1;
  	  //document.getElementById("error-msg").style.display="block";
  	  //document.getElementById("boton_" + idProducto).style.display="none";  	  
  	  //document.getElementById("boton_error_" + idProducto).style.display="block";  	
}

function muestraError()
{
  	try{
  	  document.getElementById("error-msg").style.display="block";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraError()");
	}
 	
}

function quitaError()
{
  	try{
  	  document.getElementById("error-msg").style.display="none";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En quitaError()");
	}
 	
}

function verificaCantidades()
{
  var cant = '';
  var retorno = true;
  var textBoxCantidad;
  var mto = '';
  var textBoxMto;
  
  for(i=1;i<totalProd;i++)
  {
	try{
	var check=document.getElementById("check_"+i);
	  textBoxCantidad = document.getElementById("maximo_"+i);
	  cant = textBoxCantidad.value;
	  textBoxMto = document.getElementById("txtmtolc_"+i);
	  mto=textBoxMto.value;
	}catch(e){
	  textBoxCantidad = document.getElementById("maximoPaq_"+i);
	  cant = textBoxCantidad.value;
	  //textBoxMto = document.getElementById("txtmtolc_"+i);
	  //mto=textBoxMto.value;
	}
	 //alert("check:::"+check.checked+" "+i);
	try{
		 if (check.checked)
		  {	
			  textBoxCantidad.disabled=false;
		  }
		if(cant == '')
		{
			try{
			  textBoxCantidad.focus();
			  retorno = false;
			  break;
			}catch(e){//si el texto está deshabilitado no puedo setear el foco
				//textBoxCantidad.value="0";
				//alert(e.name + " - "+e.message+" En verificaCantidades()");
			}
		}
		if(mto == ''){
			try{
			  textBoxMto.focus();
			  retorno = false;
			  break;
			}catch(e){
			}
			
		}
	}catch(e){
		impAlert(e.name + " - "+e.message+" En verificaCantidades() ");
	}	 

  }
  return retorno;
}

function forwardAction(form,accion){
    	if (flagBloqueo==0){
			flagBloqueo=1;
			form.action=accion;
			form.submit();
		}
		else{
			
			return;
		}	
	
}

function navegaction(guarda,pagina){
	document.getElementById("grabar").value=guarda;
	document.getElementById("pagina").value=pagina;
	document.formulario.submit();
}

function contratados(codigoElejido)
{
	setValorSeleccionados();
	/**
	document.getElementById("d_codigo").value = document.getElementById("codigo_" + codigoElejido).value;
	document.getElementById("d_comportamiento").value = document.getElementById("comportamiento_" + codigoElejido).value;
	document.getElementById("d_codPadrePaq").value = document.getElementById("codPadrePaq_" + codigoElejido).value;
	document.getElementById("d_idProducto").value = 
	**/
	if (flagBloqueo==0){
		flagBloqueo=1;
		ProductoForm.codigo.value=document.getElementById("codigo_" + codigoElejido).value;
		ProductoForm.comportamiento.value=document.getElementById("comportamiento_" + codigoElejido).value;
		ProductoForm.codPadrePaq.value=document.getElementById("codPadrePaq_" + codigoElejido).value;
		ProductoForm.idProducto.value="D." + document.getElementById("codPadrePaq_" + codigoElejido).value + "." + document.getElementById("codigo_" + codigoElejido).value;	
		//ProductoForm.codigoLC.value=document.getElementById('codLimConsuSeleccionado').value; //para que se usa?
		//ProductoForm.submit();
		productoDef(ProductoForm);
	}
	else{
		return;
	}	

}

function productoDef(form)
{

	//alert("productoDef codigoproductosel    "+codigoproductosel+"\ndescripcionproductosel "+descripcionproductosel+"\nnumeroMaximosel       "+numeroMaximosel);
	form.codigoProducto.value= codigoproductosel;
	form.productoDescripcion.value=descripcionproductosel;
	form.numeroMaximo.value=numeroMaximosel;
	form.submit();

}	

function producto(form,texto,comportamiento,codigo,codigoPadre,idEspecProvision)
{

	setValorSeleccionados();
	totalProd = form.cantidades.length;

	if (flagBloqueo==1){ 
		return;
	}
 verificaCantidades();
 
if (!texto.disabled)
  {
	  var ok=true;
	  for (i=0; i < form.elements.length; i++) 
	  {         
		 if (form.elements[i].className=="error") 
		 {
		 	if (form.elements[i].id.substring(0,8)!= "txtmtolc")
		 	{
			    document.getElementById("mensajes").innerHTML="Error inesperado, intente nuevamente";
			 	document.getElementById("mensajes").style.display="block";
				ok=false;
				return false;
			}
		 }
	  }
	  if(ok)
	  {
	  //  llena datos necesarios para el proximo action 	
		for (i=0; i < form.elements.length; i++) 
		{
			if(form.elements[i].id=='comportamiento')
			{
				form.elements[i].value=comportamiento
			}
			if(form.elements[i].id=='codigo')
			{
				form.elements[i].value=codigo
			}
			if(form.elements[i].id=='codPadrePaq')
			{
				form.elements[i].value=codigoPadre
			}
			if(form.elements[i].id=='idProducto')
			{
				form.elements[i].value='O.'+ codigoPadre + '.' +codigo
			}
			if (form.elements[i].id=='idEspecProvision')
			{
				form.elements[i].value=idEspecProvision
			}
		}
		//alert("codigoproductosel    "+codigoproductosel+"\ndescripcionproductosel "+descripcionproductosel+"\nnumeroMaximosel       "+numeroMaximosel);
	    flagBloqueo=1;
	    form.codigoProducto.value= codigoproductosel;
	    form.productoDescripcion.value=descripcionproductosel;
	    form.numeroMaximo.value=numeroMaximosel;
		form.submit();
	  }
  }
  else
  {
	  return false;
  }
}	

function cliente(form,idCliente)
{
  ok=true;
  for (i=0; i < form.elements.length; i++) {
	 if (form.elements[i].className=="error"){
	 	alert("Existe un error la solicitud del cliente, revise el formulario de la peticion");
		ok=false;
	 }
  }
  if (ok){
	  document.getElementById("idCliente").value=idCliente;
	  form.submit();
  }
}

function abonado(form,idAbonado, cadenaProductos)
{
  if (flagBloqueo==1){
  	return;
  }
 	ok=true;
  
  for (i=0; i < form.elements.length; i++) {
	 if (form.elements[i].className=="error"){
	 	alert("Existe un error la solicitud del Abonado, revise el formulario de la peticion");
		ok=false;
	 }
  }
  if (ok){
	  document.getElementById("idAbonado").value=idAbonado;
	  document.getElementById("cadenaProductosSeleccionados").value = cadenaProductos;
	  form.submit();
  }
}

//validacion de elementos
var error=0;
var valorActual='';
function setValorActual(cantidad)
{
	//document.getElementById("alerta").height=16;
	valorActual = cantidad.value;
}

function maxpro(cantidad,maximo,idProducto,isPaquete)
{ 
   var isMaxPermitido=true;
  
   validaNumero();
   
   if(document.getElementById("boton_inicial_" + idProducto))
	   document.getElementById("boton_inicial_" + idProducto).style["display"]="none";  
        
   if (!esNumerico(cantidad)){     
  	  cantidad.value =  valorActual;	  
  }

//(+) EV 20/03/09  
  //buscar si existe el producto seleccionado en lista de productos por defecto
  var cantidadContratados = 0;
  var totalProductos = 0
   for(j=0;j<listaCodigosProdPorDefecto.length;j++) {
   	var codigoSel = document.getElementById("codigo_" + idProducto).value;
   	if (listaCodigosProdPorDefecto[j]==codigoSel){
	   	var cantProdj = listaCantidadProdPorDefecto[j];
	    cantidadContratados = cantidadContratados + parseInt(cantProdj);
   	}
   }
  totalProductos = cantidadContratados + parseInt(cantidad.value);

  if ( (maximo > 0) && (totalProductos > maximo)) //EV 25/03/09
//(-) EV 20/03/09
  {
  	  cantidad.className="error";
	  isMaxPermitido=false;
  	  document.getElementById("mensajes").innerHTML="Cantidad máxima excedida para producto seleccionado";
  	  document.getElementById("mensajes").style["display"]="block";
  	  document.getElementById("boton_" + idProducto).style["display"]="none";  	  
  	  document.getElementById("boton_error_" + idProducto).style["display"]="block"; 
	  impIdProdError();
	  addIdProdError(idProducto);
	  impIdProdError();
	 
  }
  else
  {
	  document.getElementById("mensajes").style["display"]="none";
  	  cantidad.className="none";
	    impIdProdError();
		eliminaProdArrError(idProducto);
		impIdProdError();
		quitaError(); //EV 26/03/09		

  	  if (error<=0)//por si otro error hizo desplegarse el mensaje de error
  	  {
	  	  document.getElementById("mensajes").style["display"]="none";
   		  quitaError(); //EV 26/03/09
  	  }
  	  document.getElementById("boton_" + idProducto).style["display"]="block";  	  
  	  document.getElementById("boton_error_" + idProducto).style["display"]="none";	  
  }
  
  if (isMaxPermitido)
  {	
    verificaPersonalizable(cantidad,idProducto,isPaquete);
  }
  calculaDescuentosManuales();
  //alert("MP "+error);
}




function guardarCabecera(formulario,codigoSel,DescripSel,numMaximoListaSel)
{
	descripcionproductosel = DescripSel;
	codigoproductosel = codigoSel;
	numeroMaximosel = numMaximoListaSel;
}

function noAtras()
{
	history.go(1);
}

function cargarRestricciones(){
	noAtras();
}

function validaNumero(){
  if(event.keyCode<47 || event.keyCode>57)
	event.keyCode=0;
}

function esNumerico(input){

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

function calculaDescuentosManuales(){
	if (document.getElementById("rangoInfPorcDescuento") != null){
		var minimo = document.getElementById("rangoInfPorcDescuento").value;
		var maximo = document.getElementById("rangoSupPorcDescuento").value;
	}
		
}


	//INI 155400 18112010
	function descripcionTipoProducto(codTipoProducto){
	
		if (codTipoProducto=='2'){
			document.write('Opcional Obligatorio');
		} 

    	  if (codTipoProducto=='3'){
			document.write('Opcional');
		}
	}
	
	function agregaPlanOpcOblDefecto(total){
		var identificador;
		var nombre_objeto;
		var checkbox;
		for(identificador=1;identificador<total;identificador++){
			nombre_objeto = 'check_' + identificador;
			checkbox = document.getElementById(nombre_objeto);
			if(checkbox.checked&&checkbox.disabled){
				nombre_objeto = 'ind_paquete_' + identificador;
				ind_paquete = document.getElementById(nombre_objeto);
				
				nombre_objeto = 'codProducto_' + identificador;
				codProducto = document.getElementById(nombre_objeto);
				
				
				nombre_objeto = 'max_disponible_' + identificador;
				max_disponible = document.getElementById(nombre_objeto);
				//maximoPaq = 'maximoPaq_' + identificador;
				maximo = document.getElementById('maximo_' + identificador);
				nombre_objeto =  'tipoPlanAdic_' + identificador; 
				tipoPlanAdic = document.getElementById(nombre_objeto); 
				txtmtolc = document.getElementById('txtmtolc_' + identificador);				
				combo = document.getElementById('combo_lc_' + identificador);								
				//gestionProducto(maximo,checkbox,identificador,ind_paquete.value,codProducto.value,max_disponible.value, combo, txtmtolc, tipoPlanAdic.value);
			}
		}
	}
	//FIN INC 155400 18112010

