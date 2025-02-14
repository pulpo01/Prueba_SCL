//Validadores de Formularios
 var arrError=new Array;

function navegacion(){
	document.forms[0].submit();
}


var descripcionproductosel;
var codigoproductosel;
var numeroMaximosel;

function guardarProductosPorAbonado(form,accion,envia){
	
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

function verificaCantidades()
{
  var cant = '';
  var retorno = true;
  var textBoxCantidad;
  
  for(i=1;i<totalProd;i++)
  {
	try{
	var check=document.getElementById("check_"+i);
	  textBoxCantidad = document.getElementById("maximo_"+i);
	  cant = textBoxCantidad.value;
	 
	 
	}catch(e){
	  textBoxCantidad = document.getElementById("maximoPaq_"+i);
	  cant = textBoxCantidad.value;
	  
	  
	  
	}
	 //alert("check:::"+check.checked+" "+i);
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
		}catch(e){//si el texto est? deshabilitado no puedo setear el foco
			//textBoxCantidad.value="0";
			//alert(e.name + " - "+e.message+" En verificaCantidades()");
		}
		
	}
  }
  return retorno;
}

function forwardAction(form,accion){
	form.action=accion;
	form.submit();
}

function navegaction(guarda,pagina){
	document.getElementById("grabar").value=guarda;
	document.getElementById("pagina").value=pagina;
	document.formulario.submit();
}

function contratados(codigoElejido)
{
	/**
	document.getElementById("d_codigo").value = document.getElementById("codigo_" + codigoElejido).value;
	document.getElementById("d_comportamiento").value = document.getElementById("comportamiento_" + codigoElejido).value;
	document.getElementById("d_codPadrePaq").value = document.getElementById("codPadrePaq_" + codigoElejido).value;
	document.getElementById("d_idProducto").value = 
	**/
	ProductoForm.codigo.value=document.getElementById("codigo_" + codigoElejido).value;
	ProductoForm.comportamiento.value=document.getElementById("comportamiento_" + codigoElejido).value;
	ProductoForm.codPadrePaq.value=document.getElementById("codPadrePaq_" + codigoElejido).value;
	ProductoForm.idProducto.value="D." + document.getElementById("codPadrePaq_" + codigoElejido).value + "." + document.getElementById("codigo_" + codigoElejido).value;	
	//ProductoForm.submit();
	productoDef(ProductoForm);
}

function productoDef(form)
{

	//alert("productoDef codigoproductosel    "+codigoproductosel+"\ndescripcionproductosel "+descripcionproductosel+"\nnumeroMaximosel       "+numeroMaximosel);
	form.codigoProducto.value= codigoproductosel;
	form.productoDescripcion.value=descripcionproductosel;
	form.numeroMaximo.value=numeroMaximosel;
	form.submit();

}	

function producto(form,texto,comportamiento,codigo,codigoPadre)
{

 verificaCantidades();
 
 if (!texto.disabled)
  {
	  var ok=true;
	  for (i=0; i < form.elements.length; i++) 
	  {         
		 if (form.elements[i].className=="error") 
		 {
		    document.getElementById("mensajes").innerHTML="Error inesperado, intente nuevamente";
		 	document.getElementById("mensajes").style.display="block";
			ok=false;
			return false;
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
		}
		//alert("codigoproductosel    "+codigoproductosel+"\ndescripcionproductosel "+descripcionproductosel+"\nnumeroMaximosel       "+numeroMaximosel);
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

function abonado(form,idAbonado)
{
  ok=true;
  for (i=0; i < form.elements.length; i++) {
	 if (form.elements[i].className=="error"){
	 	alert("Existe un error la solicitud del Abonado, revise el formulario de la peticion");
		ok=false;
	 }
  }
  if (ok){
	  document.getElementById("idAbonado").value=idAbonado;
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

function maxpro(cantidad,maximo,idProducto)
{ 
   var isMaxPermitido=true;
  
   validaNumero();
   
   if(document.getElementById("boton_inicial_" + idProducto))
	   document.getElementById("boton_inicial_" + idProducto).style["display"]="none";  
        
   if (!esNumerico(cantidad)){     
  	  cantidad.value =  valorActual;	  
  }
  if (cantidad.value>maximo)
  {
  	  cantidad.className="error";
	  isMaxPermitido=false;
  	  document.getElementById("mensajes").innerHTML="La cantidad ingresada es mayor a la permitida";
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

  	  if (error<=0)//por si otro error hizo desplegarse el mensaje de error
  	  {
	  	  document.getElementById("mensajes").style["display"]="none";
  	  }
  	  document.getElementById("boton_" + idProducto).style["display"]="block";  	  
  	  document.getElementById("boton_error_" + idProducto).style["display"]="none";	  
  }
  
  if (isMaxPermitido)
  {	
    verificaPersonalizable(cantidad,idProducto);
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
	var minimo = document.getElementById("rangoInfPorcDescuento").value;
	var maximo = document.getElementById("rangoSupPorcDescuento").value;
		
}

