// Libreria con funciones comunes en javascript
//
// Contiene las siguientes funciones:
//
// - getEventValue
// - onlyNumericAndK
// - onlyNumeric
// - replaceAll
// - ifAlfaNumeric
// - trim
// - checkMail
// - validaRut
// - Lpadding
// - Rpadding
//
// Nota: Algunas de las funciones usan "expresiones regulares".
//
// Expresiones regulares
// ---------------------
// Las expresiones regulares permiten la búsqueda de patrones 
// complejos dentro de una cadena. Existen diversas maneras de
// definirlos en distintos lenguajes pero las bases son las mismas
// en todos. Tanto Mozilla como Microsoft incorporaron lo mismo en
// sus navegadores desde la version 4, basandose en la implementación
// de Perl.
//
// Ultima fecha de modificacion: 11-04-2006 Rodrigo Diaz.
// 
//*****************************************************************



//Funcion padding, permite completar con caracteres a la izquierda, para dar un largo fijo requerido por un string
function Lpadding(str, largo, caracter){
	
str = "" + str
	
    for(;parseInt(str.length) < parseInt(largo);)
        str = caracter + str
   return str
}

//Funcion padding, permite completar con caracteres a la derecha, para dar un largo fijo requerido por un string
function Rpadding(str, largo, caracter){
	
str = "" + str
	
   for(;parseInt(str.length) < parseInt(largo);)
       str = str + caracter
   return str
}

//Funcion que permite ejecutar un metodo enviando el objeto event, 
// como por ejemplo para velidar vaores ingresados a una caja de texto.
function getEventValue(ev){

	var agt=navigator.userAgent.toLowerCase();
		
	if (agt.indexOf("firefox") != -1)
		return ev.which
	else if (agt.indexOf("msie") != -1) 
		return ev.keyCode

}

 function soloNumeros(objeto) {

	valor = objeto.value

	var filter  = /^([0-9])+$/;

	if (!filter.test(valor)) {
	   objeto.value = valor.substring(0, valor.length-1)
	}
  }

//Funcion que se utiliza en el campo del digito verificador para el rut.
//permite el ingreso de numeros y la "k".
//para usarla se debe colocar el siguiente evento en el input
//onkeydown="return onlyNumericAndK(event)"
//este metodo se debe ejecutar en conjunto con el metodo getEventValue(event) ejemplo: onlyNumericAndK(getEventValue(event), event)

function onlyNumericAndK(ev){
var teclasContol =  new Array(8,9,13,37,39,36,35,46,75,107)  ;
    alt = (ev.altKey) ? true : false;
    ctrl = (ev.ctrlKey) ? true : false;
    shift = (ev.shiftKey) ? true : false;
if ((((ev.which >=48 && ev.which <=57 && !shift) || (ev.which == 75))|| (ev.which >= 96 && ev.which <=105 && !shift) || inArray(ev.which,teclasContol)) )
      return true;
  else { 
      return false;
  }
}

//Funcion que permite solo el ingreso de numeros.
//para usarla se debe colocar el siguiente evento en el input
//onkeydown="return onlyNumeric(ev, evento)"
function onlyNumeric(ev, evento) {
	var teclasContol =  new Array(8,9,37,39,36,35,46);
  
  	alt = (evento.altKey) ? true : false;
  	ctrl = (evento.ctrlKey) ? true : false;
  	shift = (evento.shiftKey) ? true : false;
 	
 	if (((ev >=48 && ev <=57 && !shift) || (ev >= 96 && ev <=105 && !shift) || inArray(ev,teclasContol)))
 		return true;
  	else
    		return false;
}

//Reemplaza un caracter por otro en un string
function replaceAll( str, from, to ) {
	
	var idx = str.indexOf( from );

    strTmp = str.substr(idx)

    while ( idx > -1 ) {
        str = str.replace( from, to );
        idx = str.indexOf( from );
    }

    return str;	
}

//Retorna true si la cadena es alfanumerica
function ifAlfaNumeric(str) {
	
	var x = str;
	var filter  = /^([a-zA-Z0-9])+$/;
	
	if (filter.test(x))
		return true;
	else
		return false;
}

//Retorna el string sin espacios
function trim(str) {
   return str.replace(/^\s*|\s*$/g,"");
}

//Chequea si un mail es correcto o no.
function checkMail(str) {
	var x = str;
	var filter  = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;
	
	if (filter.test(x))
		return true;
	else
		return false;
}

//funcion que valida el rut
//retorna true o false.
function validaRut(rut, dv) {
	
	var M=0,S=1;
	for(;rut;rut=Math.floor(rut/10))
	    S=(S+rut%10*(9-M++%6))%11;
	
	dvTmp = S?S-1:'k';
	
	return (dvTmp == dv.toLowerCase()) ? true:false;
}

function inArray(value,array){
var i=0;
  for (i=0;i<array.length;i++){
      if (value== array[i])
	     return true;
  }
  return false;
 }
 
// valida rut reclamo
 function validaRut_(text){
		 
				if(text.value == ""){ 
					document.getElementById("rutMsg").innerHTML = "Rut requerido"
					return false
				}
				  var solonumero = text.value;
				  solonumero = replaceAll(solonumero,".","")
				  solonumero = replaceAll(solonumero,"-","")
				  var dv = solonumero.substring(solonumero.length-1, solonumero.length)
				  var rut = solonumero.substring(0, solonumero.length-1)
				 
				 if(validaRut(rut, dv)){
					document.getElementById("rutMsg").innerHTML = ""
					return true
				 }else{
					document.getElementById("rutMsg").innerHTML = "Rut invalido"
					text.value = ""
					text.focus()
				
				 }
				 return false
		
}
// valida que el campo ontenga solo letras
function letras (campo) {
	var charpos = campo.value.search("[^A-Za-z ]"); 
	if(campo.value.length > 0 &&  charpos >= 0) { 
		document.getElementById("nombreMsg").innerHTML = "Nombre invalido"
		campo.value = ""
		campo.focus();
		return false; 
	} else {
		document.getElementById("nombreMsg").innerHTML = ""
		return true;
		}
}

//cuenta caracteres en un campo
function textCounter(field, countfield, maxlimit) {
	if (field.value.length > maxlimit) 
		field.value = field.value.substring(0, maxlimit);

	else
	countfield.value = maxlimit - field.value.length;
}

//valida que el campo tenga una cierta cantidad de caracteres
function validarReclamo() {
	var reclamo = document.getElementById("reclamo").value
		if (reclamo.length < 10) {
			document.getElementById("reclamoMsg").innerHTML = "Escriba más de 10 caracteres"
			reclamo.value = ""
			return false
		}
		else {
			document.getElementById("reclamoMsg").innerHTML = ""
			return true;
		}
}
