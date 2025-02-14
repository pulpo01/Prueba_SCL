//Validadores de Formularios
function producto(formulario,texto,codigo)
{
  if (!texto.disabled)
  {
	  ok=true;
	  for (i=0; i < formulario.elements.length; i++) {
		 if ((formulario.elements[i].className=="error") && (formulario.elements[i]==texto)) {
		 	document.getElementById("error-msg").style.display="block";
			ok=false;
			return false;
		 }
	  }
	  if (ok){
	  //  llena datos necesarios para el proximo action 	
		  document.getElementById("codigo").value=codigo;
		  formulario.submit();
	  }
  }
  else
  {
	  return false;
  }
}	

function cliente(formulario,idCliente)
{
  ok=true;
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
}

function abonado(formulario,idAbonado)
{
  ok=true;
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
}

//validacion de elementos
function maxpro(cantidad,maximo)
{
  if (cantidad.value>maximo){
  	  cantidad.className="error";
  	  document.getElementById("error-msg").style.display="block";
  }else
  {
  	  cantidad.className="none";
  	  document.getElementById("error-msg").style.display="none";
  }
  
}
