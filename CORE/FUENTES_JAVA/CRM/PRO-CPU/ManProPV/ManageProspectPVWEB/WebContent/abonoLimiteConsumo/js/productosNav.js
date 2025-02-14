//Validadores de Formularios
var codigoproductosel;
var descripcionproductosel;
var numeroMaximosel;
//validacion de elementos
var error=0;
var valorActual='';
var enviado=false;
var registroDeCambios = false;
var mensajeErrValExclusionCnte = 'Existen planes que no cumplen la validación de exclusión, \n';
    mensajeErrValExclusionCnte+= 'éstos no podrán ser contratados, Detalle:\n\n';
function abonado(formulario,idAbonado)
{
  ok=true;
  	try{
	  for (i=0; i < formulario.elements.length; i++) {
		 if (formulario.elements[i].className=="error"){
		 	alert("Existe un error la solicitud del Abonado, revise el formulario de la peticion");
			ok=false;
		 }
	  }
	  if (ok){
		  document.getElementById("idAbonado").value=idAbonado;
		  document.formulario.submit();
	  }
	}catch(e){
		impAlert(e.name + " - "+e.message+" En abonado() idAbonado "+idAbonado);
	}
}

function registroCambio(Id,valorOriginal,Actual)
{
	
	if(valorOriginal == Actual.value )
	{
		document.getElementById('RegistraCambio_'+Id).value = "0";
	}
	else
	{
		document.getElementById('RegistraCambio_'+Id).value = "1";
	}
	
} 

function cargarRestricciones(){
	try{
		noAtras();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En cargarRestricciones()");
	}
}

function cliente(formulario,idCliente)
{
  ok=true;
  	try{
		  for (i=0; i < formulario.elements.length; i++) {
			 if (formulario.elements[i].className=="error"){
			 	alert("Existe un error la solicitud del cliente, revise el formulario de la peticion");
				ok=false;
			 }
		  }
		  if (ok){
			  document.getElementById("idCliente").value=idCliente;
			  document.formulario.submit();
		  }
	}catch(e){
		impAlert(e.name + " - "+e.message+" En cliente() idCliente "+idCliente);
	}
}

function contratados(codigoElejido)
{
	/**
	document.getElementById("d_codigo").value = document.getElementById("codigo_" + codigoElejido).value;
	document.getElementById("d_comportamiento").value = document.getElementById("comportamiento_" + codigoElejido).value;
	document.getElementById("d_codPadrePaq").value = document.getElementById("codPadrePaq_" + codigoElejido).value;
	document.getElementById("d_idProducto").value = 
	**/
	try{
		ProductoForm.codigo.value=document.getElementById("codigo_" + codigoElejido).value;
		ProductoForm.comportamiento.value=document.getElementById("comportamiento_" + codigoElejido).value;
		ProductoForm.codPadrePaq.value=document.getElementById("codPadrePaq_" + codigoElejido).value;
		ProductoForm.idProducto.value="D." + document.getElementById("codPadrePaq_" + codigoElejido).value + "." + document.getElementById("codigo_" + codigoElejido).value;	
		ProductoForm.submit();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En contratados() codigoElejido "+codigoElejido);
	}
}

function esNumerico(input){

	var passedVal = input.value;
	var ValidChars = "0123456789"; 
	var IsNumber=true;
	var Char;
	
	try{
		if(passedVal == ""){
			IsNumber = false;
			input.value = '';
			return false;
		}
		for (i = 0; i < passedVal.length; i++){
		
			Char = passedVal.charAt(i);
			if (ValidChars.indexOf(Char) == -1)
			{
				IsNumber = false;
				return false;
			}
		}
		return true;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En esNumerico()");
	}
}

function forwardAction(form,accion){
	try{
		form.action=accion;
		form.submit();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En forwardAction() accion "+accion);
	}
}

function guardarCabecera(formulario,codigoSel,DescripSel,numMaximoListaSel)
{
	try{
		descripcionproductosel = DescripSel;
		codigoproductosel = codigoSel;
		numeroMaximosel = numMaximoListaSel;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En guardarCabecera() codigoSel "+codigoSel+"|DescripSel "+DescripSel+"|numMaximoListaSel "+numMaximoListaSel);
	}
}

function guardarProductosPorAbonado(form,accion,envia){
    try{
	    if (error>0)
	    {
		   document.getElementById("alerta").height=50;
		   return;
	    }
		if(!verificaCantidades())
		{
			muestraErrorCant();
			return;
	    }
		form.accion.value=accion;
		form.action=envia;
		form.submit();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En guardarProductosPorAbonado() accion "+accion);
	}
}
var prodOfSel;
function validarExclusion()
{
	var prodCont;
	var prodDisp;
	try{

		prodCont = getProductosCont();
		prodDisp = getProductos();
		prodOfSel = prodDisp;
		JValidacionesExclusion.obtenerValidacionExcluyentes(prodCont,prodDisp,validarExclusionReturn);
	}catch(e){
		impAlert(e.name + " - "+e.message+" En validarExclusion()");
	}
}
/*var where_is_mytool="home/mytool/mytool.cgi";
var mytool_array=where_is_mytool.split("/");
alert(mytool_array[0]+" "+mytool_array[1]+" "+mytool_array[2]);*/

function validarExclusionReturn(data)
{
	  if(data != null)
	  {
	    //alert(data.length);
		if(data == "" || data.length < 1)
		{
			enviarFormularioValCant();
			return;
		}
		var valoresRetorno=data;// [O.0.46,SS10,PROD9&O.0.47,SS11,PROD10]
		var idCheck;
		var idCombo;
		var checkOfertado;
		var comboOfertado;
		var idProSelArr;
		var prodOferDetArr;
		var prodOferNoValido;
		var prodOferNoValidoArr = valoresRetorno.split("&");
		var msgProdOferConErrorExcl = "";
		var mensajeErrValExclusion = mensajeErrValExclusionCnte;
		//alert(prodOferNoValidoArr.length);
		try{
		
			for(var i=0;i<prodOferNoValidoArr.length;i++)
			{

				prodOferNoValido = prodOferNoValidoArr[i];     //O.0.46,SS10,PROD9
				prodOferDetArr   = prodOferNoValido.split(",");//prodOferDetArr[0] = O.0.46,prodOferDetArr[1] = PROD9, prodOferDetArr[2] = SS10
				//alert("prodOferNoValidoArr["+i+"] ["+prodOferNoValido+"]");
				if(prodOferNoValido == "" || prodOferNoValido == "undefined"){
					continue;
				}
				msgProdOferConErrorExcl = prodOferDetArr[1] +" excluyente con "+prodOferDetArr[2]+"\n";
				//msgProdOferConErrorExcl+=msgProdOferConErrorExcl;
				mensajeErrValExclusion+=msgProdOferConErrorExcl;
				var idProSelArr = prodOferDetArr[0];//O.0.46//alert("idProSelArr "+idProSelArr);
				var k;
				for(k=0;k<listProductos.length;k++)
				{
					if(listProductos[k] == idProSelArr){
						idCheck = "check_"+listIdProductosSel[k];
						idCombo = "combo_lc_"+listIdProductosSel[k];
						break;
					}
				}//alert("idCheck "+idCheck);
				checkOfertado = document.getElementById(idCheck);//funciona 
				comboOfertado = document.getElementById(idCombo);
				//checkOfertado = document.getElementsByName(idCheck);
				//var checkOf = document.getElementsByName(nameCheck);  0.21717752.136 no funciona

				//alert(listProductos+"  "+listIdProductosSel);
				quitarPro(idProSelArr);
				quitarProSecId(listIdProductosSel[k]);
				//alert(listProductos+"  "+listIdProductosSel);
				checkOfertado.checked = false;
				comboOfertado.selectedIndex = 0;
				comboOfertado.disabled = true;
				
			}

		}
		catch(e){
				impAlert(e.name + " - "+e.message+" En validarExclusionReturn()");
		}
		//mensajeErrValExclusion+msgProdOferConErrorExcl;
		alert(mensajeErrValExclusion);
		//muestraMensajeErrorAfin(mensajeErrValExclusion);

      }
   	 else
   	 {
   	 	alert("validarExclusionReturn exception data NULL");
   	 }
	 return;
	//enviarFormulario();
}

function enviarFormulario()
{
	validarExclusion();
}

function existenCambios()
{

	var x = document.getElementsByName("abono_lc");
	var checkAbo;		 
	if(x.length > 0)
	{    
		var campos = document.ProductoForm.abono_lc;
		
		if(x.length == 1)
		{
			if(parseFloat(campos.value) >= 1)
			{
				registroDeCambios = true;
			}
		}
		else
		{	
			for(i=0; i<campos.length; i++)
			{
				var id = i+1;
								
				
				checkAbo = document.getElementById(id+'_check');
																
				if(checkAbo.checked)
				{
					if(parseFloat(campos[i].value) >= 1)
					{
						registroDeCambios =  true;
					}
					else
					{
						registroDeCambios =  false;
						break;
						
					}
				
				
				}
					
				
			}
		}	
		
	}

}


function enviarFormularioABO()
{
	if(enviado)
	{
		return;
	}
	alert('x');
	var formulario;
	var prodCont;
	var prodDisp;
	var visible;
	var disabled;
	var checkeado;
	var cant = '';
	try{
	    if (error>0)
	    {
		   //document.getElementById("alerta").height=50;
		  // return;
	    }
		
		existenCambios();
		
		if(!registroDeCambios)
		{
			muestraMensajeErrorAfin('Existen abonos sin completar.');
			return;
		}
	
		
		for(i=0;i<document.forms.length;i++)
		{
			formu = document.forms[i];
			if(formu.name == "ProductoForm")
			{
				break;
			}
		}
		
		seteaAction(formu);
		enviado=true;
		formu.submit();

	}catch(e){
		impAlert(e.name + " - "+e.message+" En enviarFormularioABO()");
	}
}


function enviarFormularioLC()
{
	if(enviado)
	{
		return;
	}
	
	var formulario;
	var prodCont;
	var prodDisp;
	var visible;
	var disabled;
	var checkeado;
	var cant = '';
	try{
	    if (error>0)
	    {
		   //document.getElementById("alerta").height=50;
		  // return;
	    }
		if(!verificaCantidades())
		{
			muestraErrorCant();//ya se debería estar mostrando
			return;
	    }
		prodCont = getProductosCont();
		prodDisp = getProductos();

		existenCambios();
		
		if(!registroDeCambios)
		{
			muestraMensajeErrorAfin('Existen abonos sin completar.');
			return;
		}
		//(+) evera 02/01/09
		else{
			document.getElementById('listaProductosContrados').value = prodCont;
		}
		//(-) evera 02/01/09

		//listProductos[listProductos.length] = idpro;
		//alert("prodDisp "+prodDisp);
		//alert("prodCont "+prodCont);
		document.getElementById('bitac').value = prodCont;
		document.getElementById('bita').value = prodDisp;
		document.getElementById('cantidadesP').value = cant;
		//document.getElementById('cantidadesP').value = document.getElementsByName('cantidades').value;
		//alert("prodCont "+prodCont);
		for(i=0;i<document.forms.length;i++)
		{
			formu = document.forms[i];
			if(formu.name == "ProductoForm")
			{
				break;
			}
		}
		
		document.getElementById('bitacorac').value = prodCont;
		disabled = document.getElementById("idControlCh").disabled;
		checkeado = document.getElementById(controlesId[0]).checked;
		document.getElementById("idControlCh").value = controlesId[0]+"|"+esvisible+"|"+disabled+"|"+checkeado;
		seteaAction(formu);
		enviado=true;
		formu.submit();

	}catch(e){
		impAlert(e.name + " - "+e.message+" En enviarFormularioLC()");
	}
}

function enviarFormularioValCant()//enviarFormulario old
{
	if(enviado)
	{
		return;
	}
	
	var formulario;
	var prodCont;
	var prodDisp;
	var visible;
	var disabled;
	var checkeado;
	var cant = '';
	try{
	    if (error>0)
	    {
		   //document.getElementById("alerta").height=50;
		  // return;
	    }
		if(!verificaCantidades())
		{
			muestraErrorCant();//ya se debería estar mostrando
			return;
	    }
		prodCont = getProductosCont();
		prodDisp = getProductos();

		if(prodCont.length == 0 && prodDisp.length == 0)
		{
			muestraMensajeErrorAfin('No se han seleccionado productos para contratar ni descontratar');
			return;
		}
		//(+) evera 02/01/09
		else{
			document.getElementById('listaProductosContrados').value = prodCont;
		}
		//(-) evera 02/01/09

		//listProductos[listProductos.length] = idpro;
		//alert("prodDisp "+prodDisp);
		//alert("prodCont "+prodCont);
		document.getElementById('bitac').value = prodCont;
		document.getElementById('bita').value = prodDisp;
		try{
			var hd = '';
			for(i=0;i<document.getElementsByName('cantidades').length;i++)
			{
				if(document.getElementsByName('cantidades')[i].disabled == false){
					cant+=document.getElementsByName('cantidades')[i].value+"|";
				}
			}
			//alert(cant);
		}
		catch(e)
		{
			cant+=document.getElementsByName('cantidades').value+"|";
			//alert("Un text cantidades "+document.getElementsByName('cantidades').value.length);
			//impAlert(e.name + " - "+e.message+" En enviarFormulario()");
		}
		document.getElementById('cantidadesP').value = cant;
		//document.getElementById('cantidadesP').value = document.getElementsByName('cantidades').value;
		//alert("prodCont "+prodCont);
		for(i=0;i<document.forms.length;i++)
		{
			formu = document.forms[i];
			if(formu.name == "ProductoForm")
			{
				break;
			}
		}
		document.getElementById('bitacorac').value = prodCont;
		document.getElementById('bitacorad').value = prodDisp;//visible = esvisible;//document.getElementById("idControlCh").style["display"];
		
		disabled = document.getElementById("idControlCh").disabled;
		checkeado = document.getElementById(controlesId[0]).checked;
		document.getElementById("idControlCh").value = controlesId[0]+"|"+esvisible+"|"+disabled+"|"+checkeado;
		seteaAction(formu);
		enviado=true;
		formu.submit();

	}catch(e){
		impAlert(e.name + " - "+e.message+" En enviarFormulario()");
	}
}

function maxpro(cantidad,maximo,idProducto,codProducto,indGestProd,valorInicial,esAutoAfin)
{
	//alert("cantidad "+cantidad+" maximo "+maximo +" idProducto "+idProducto+" codProducto "+codProducto+
		//" indGestProd "+indGestProd+ " valorInicial "+valorInicial+" esAutoAfin "+esAutoAfin)
	var cantidadProd = 0;
	var cantp =' ';
	var prodConErr =' ';
	var totalCantProd = 0;
	var indpos = -1;
	try{
		//muestraCodProducto();
		if(maximo != "0")
		{
			cantidadProd = obtieneCantidadProd(codProducto);
			if(esAutoAfin == 1)
			{
				cantidadProd = 0;
				maximo = 1;
			}
			totalCantProd = parseInt(cantidad.value,10)+  parseInt(cantidadProd,10);
			if (!esNumerico(cantidad)){
				cantidad.value =  valorInicial;	  
			}
			//alert("maxpro totalCantProd "+totalCantProd+"  maximo "+maximo+"    codProducto "+codProducto+" esAutoAfin "+esAutoAfin);
			if (totalCantProd >maximo && indGestProd){
				
				prodConErr = obtieneProdErr();
				indpos = prodConErr.indexOf(codProducto);
				//alert("indpos "+indpos);
				if(indpos == -1)
				{
					agregaCodProductoErr(codProducto);
					prodConErr = obtieneProdErr();
					if(prodConErr.indexOf(',')>-1){cantp='s ';}
					muestraMensajeError("Cantidad máxima excedida para producto"+cantp+prodConErr,cantidad);
				}
			}
			else
			{
				if (totalCantProd >maximo)
				{
					cantidad.value = valorInicial;//validaMaximo(cantidad.value,valorInicial,maximo);
					actualizarError(codProducto,cantidad);
				}
				else
				{
					prodConErr = obtieneProdErr();
					if(prodConErr.indexOf(codProducto)>-1)
					{
						actualizarError(codProducto,cantidad);				
					}
				}
				cantidad.className="none";
			}
		}
		if (!esNumerico(cantidad)){
			cantidad.value =  valorInicial;	  
		}

	}
	catch(e){
		impAlert(e.name + " - "+e.message+" En maxpro() cantidad "+cantidad+"|maximo "+maximo+"|idProducto "+idProducto);
	}
}

function actualizarError(codProducto,cantidad)
{
  	var cantp =' ';
	var prodConErrA =' ';
	try
	{
		quitarCodProductoErr(codProducto);
		prodConErrA = obtieneProdErr();
		if(prodConErrA.length >0)
		{
			if(prodConErrA.indexOf(',')>-1){cantp='s ';}
			muestraMensajeError("Cantidad máxima excedida para producto"+cantp+prodConErrA,cantidad); 
			
		}else
		{
			ocultaMensajeError(cantidad);  
		}	  
	}catch(e){
		impAlert(e.name + " - "+e.message+" En actualizaError()");
	}			
}

function muestraErrorCant()
{
  	  //cantidad.className="error";
  	  //error=error+1;
  	try{
  	  document.getElementById("error-msg").style.display="block";
  	  //document.getElementById("boton_" + idProducto).style.display="none";  	  
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraErrorCant()");
	}
 	
}

function muestraMensajeError(msgErr,cantidad)
{
	try{
		cantidad.className="error";
		//error=error+1;
		document.getElementById("mensajes").style.display="block";
		document.getElementById("mensajes").innerHTML=msgErr;
		
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraMensajeError()");
	}
}

function muestraMensajeErrorAfin(msgErr)
{
	try{
		document.getElementById("mensajes").style.display="block";
		document.getElementById("mensajes").innerHTML=msgErr;
		
	}catch(e){
		impAlert(e.name + " - "+e.message+" En muestraMensajeErrorAfin()");
	}
}

function ocultaMensajeError(cantidad)
{
	//alert("ocultaMensajeError");
	try{
		cantidad.className="none";
		//error=error-1;
		//if (error<=0)//por si otro error hizo desplegarse el mensaje de error
		//{
			document.getElementById("mensajes").style.display="none";
		//} 
	}catch(e){
		impAlert(e.name + " - "+e.message+" En ocultaMensajeError()");
	}
}

function ocultaMensajeErrorAfin()
{
	try{
		document.getElementById("mensajes").style.display="none";
	}catch(e){
		impAlert(e.name + " - "+e.message+" En ocultaMensajeErrorAfin()");
	}
}

function muestraMensajeErr1(msgErr)
{
	//var celda = document.getElementById('tdErr');
	//celda.innerHTML = msgErr;//"El número ingresado "+numero+" para este producto ya existe";

	try
	{
		document.getElementById("mensajes").innerHTML = msgErr;
		document.getElementById('mensajes').style.display="block";
	}
	catch(e)
	{
		impAlert(e.name + " - "+e.message+" En muestraMensajeErr()");
	}
}

function navegacion(form,accion){
	try{
		form.accion.value=accion;
		form.submit();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En navegacion() accion "+accion);
	}
}

function navegaction(guarda,pagina){
	try{
		document.getElementById("grabar").value=guarda;
		document.getElementById("pagina").value=pagina;
		document.formulario.submit();
	}catch(e){
		impAlert(e.name + " - "+e.message+" En navegaction() guarda "+guarda+" pagina "+pagina);
	}

}

function noAtras()
{
	try{
		history.go(1);
	}catch(e){
		impAlert(e.name + " - "+e.message+" En noAtras()");
	}	
}

function producto(formulario,texto,comportamiento,codigo,codigoPadre)
{
	try{
		 if (!texto.disabled)
		  {
			  var ok=true;
			  for (i=0; i < formulario.elements.length; i++) 
			  {         
				 if (formulario.elements[i].className=="error") 
				 {
				 	document.getElementById("error-msg").style.display="block";
					ok=false;
					return false;
				 }
			  }
			  if(ok)
			  {
			  //  llena datos necesarios para el proximo action 	
				for (i=0; i < formulario.elements.length; i++) 
				{
					if(formulario.elements[i].id=='comportamiento')
					{
						formulario.elements[i].value=comportamiento
					}
					if(formulario.elements[i].id=='codigo')
					{
						formulario.elements[i].value=codigo
					}
					if(formulario.elements[i].id=='codPadrePaq')
					{
						formulario.elements[i].value=codigoPadre
					}
					if(formulario.elements[i].id=='idProducto')
					{
						formulario.elements[i].value='O.'+ codigoPadre + '.' +codigo
					}
				}
				
			    formulario.codigoProducto.value= codigoproductosel;
			    formulario.productoDescripcion.value=descripcionproductosel;
			    formulario.numeroMaximo.value=numeroMaximosel;
				formulario.submit();
			  }
		  }
		  else
		  {
			  return false;
		  }
	}catch(e){
		impAlert(e.name + " - "+e.message+" En producto() comportamiento "+comportamiento+"|codigo "+codigo+"|codigoPadre "+codigoPadre);
	}
}

function setValorActual(cantidad)
{
	try{
		document.getElementById("alerta").height=16;
		valorActual = cantidad.value;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En setValorActual() cantidad "+cantidad);
	}
}

function validaNumero(){
	try{
	  if(event.keyCode<47 || event.keyCode>57)
		event.keyCode=0;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En validaNumero()");
	}
}

function verificaCantidades()
{
  var cant = '';
  var retorno = true;
  var textBoxCantidad;
  	try{
		 if(listCodProductosErr.length>0)
		 {
			 return false;
		  }
		 return retorno;
		 /*
		  for(i=1;i<totalProd;i++)
		  {
			try{
			  textBoxCantidad = document.getElementById("maximo_"+i);
			  cant = textBoxCantidad.value;
			}catch(e){
			  textBoxCantidad = document.getElementById("maximoPaq_"+i);
			  cant = textBoxCantidad.value;
			}
			if(cant == '')
			{
				try{
				  textBoxCantidad.focus();
				  retorno = false;
				  break;
				}catch(e){//si el texto está deshabilitado no puedo setear el foco
					textBoxCantidad.value="0";
					//alert(e.name + " - "+e.message+" En verificaCantidades()");
				}
				
			}
		  }
		  return retorno;*/
	}catch(e){
		impAlert(e.name + " - "+e.message+" En verificaCantidades()");
	}
}

function verificaCantidadesOri()
{
  var cant = '';
  var retorno = true;
  var textBoxCantidad;
  	try{
		  for(i=1;i<totalProd;i++)
		  {
			try{
			  textBoxCantidad = document.getElementById("maximo_"+i);
			  cant = textBoxCantidad.value;
			}catch(e){
			  textBoxCantidad = document.getElementById("maximoPaq_"+i);
			  cant = textBoxCantidad.value;
			}
			if(cant == '')
			{
				
				try{
				  textBoxCantidad.focus();
				  retorno = false;
				  break;
				}catch(e){//si el texto está deshabilitado no puedo setear el foco
					textBoxCantidad.value="0";
					//alert(e.name + " - "+e.message+" En verificaCantidades()");
				}
				
			}
		  }
		  return retorno;
	}catch(e){
		impAlert(e.name + " - "+e.message+" En verificaCantidades()");
	}
}
