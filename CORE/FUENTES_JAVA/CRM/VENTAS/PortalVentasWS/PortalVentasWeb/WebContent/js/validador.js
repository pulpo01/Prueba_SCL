<!-- Begin
var pPrompt = "Error: ";
var whitespace = " \t\n\r";

function check_date(field,tipo){
//0 solo valida formato 1 valida formato y mayoria de edad
var checkstr = "0123456789";
var DateField = field;
var Datevalue = "";
var DateTemp = "";
var seperator = "/";
var day;
var month;
var year;
var leap = 0;
var err = 0;
var i;
   err = 0;
   DateValue = DateField.value;
   if (DateValue !=""){
	   /* Delete all chars except 0..9 */
	   for (i = 0; i < DateValue.length; i++) {
		  if (checkstr.indexOf(DateValue.substr(i,1)) >= 0) {
		     DateTemp = DateTemp + DateValue.substr(i,1);
		  }
	   }
	   DateValue = DateTemp;
	   /* Always change date to 8 digits - string*/
	   /* if year is entered as 2-digit / always assume 20xx */
	   if (DateValue.length == 6) {
	      DateValue = DateValue.substr(0,4) + '20' + DateValue.substr(4,2); }
	   if (DateValue.length != 8) {
	      err = 19;}
	   /* year is wrong if year = 0000 */
	   year = DateValue.substr(4,4);
	   if (year == 0) {
	      err = 20;
	   }
	   /* Validation of month*/
	   month = DateValue.substr(2,2);
	   if ((month < 1) || (month > 12)) {
	      err = 21;
	   }
	   /* Validation of day*/
	   day = DateValue.substr(0,2);
	   if (day < 1) {
	     err = 22;
	   }
	   /* Validation leap-year / february / day */
	   if ((year % 4 == 0) || (year % 100 == 0) || (year % 400 == 0)) {
	      leap = 1;
	   }
	   if ((month == 2) && (leap == 1) && (day > 29)) {
	      err = 23;
	   }
	   if ((month == 2) && (leap != 1) && (day > 28)) {
	      err = 24;
	   }
	   /* Validation of other months */
	   if ((day > 31) && ((month == "01") || (month == "03") || (month == "05") || (month == "07") || (month == "08") || (month == "10") || (month == "12"))) {
	      err = 25;
	   }
	   if ((day > 30) && ((month == "04") || (month == "06") || (month == "09") || (month == "11"))) {
	      err = 26;
	   }
	   /* if 00 ist entered, no error, deleting the entry */
	   if ((day == 0) && (month == 0) && (year == 00)) {
	      err = 0; day = ""; month = ""; year = ""; seperator = "";
	   }
	   /* if no error, write the completed date to Input-Field (e.g. 13.12.2001) */
	   if (err == 0) {
	      //DateField.value = day + seperator + month + seperator + year;
	      if (tipo == '1'){
		      edad = calcular_edad(field.value);
		      if (edad == false){
		      	alert("Fecha invalida!");
			   	DateField.select();
			  	DateField.focus();
		      }
		      else{
		      	if (edad < 18){
		      		alert("El titular de la cuenta debe ser mayor de edad!");
		      		DateField.select();
					DateField.focus();
		      	}
		      }
		  }
	   }
	   /* Error-message if err != 0 */
	   else {
	      alert("Fecha invalida!");
	      DateField.select();
		  DateField.focus();
	   }
	}
}
//  End -->

//<!-- Begin
function onlyInteger()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	if( keyASCII != 13 && keyASCII != 75 && keyASCII < 48 || keyASCII > 57 ) //  And Not IsNumeric(Chr(CodAsc)) )
	{
	   window.event.keyCode = '';
	}
}

function onlyUpperCase() {
	var key = window.event.keyCode;
	if ((key > 0x60) && (key < 0x7B)) {
		window.event.keyCode = key - 0x20;
	}
	if ((224 <= key) && (key <= 253)) {
		window.event.keyCode = key - 32;
	}
}
//  End -->


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
}

	function onlyIntegerLetters() {
		var strNumber = new String(event.srcElement.value);
		var keyASCII = window.event.keyCode;
		if ((keyASCII > 47 && keyASCII < 58) || (keyASCII > 64 && keyASCII < 91) || (keyASCII > 96 && keyASCII < 123)) {
			//do nothing
		}
		else {
		   window.event.keyCode = '';
		}
	}

	function soloMayusculas() {
		var key = window.event.keyCode;
		if ((key > 0x60) && (key < 0x7B)) {
			window.event.keyCode = key-0x20;
		}
	}

	function permitirNumerosMayusculas() {
		var keyASCII = window.event.keyCode;
		if (keyASCII >= 97 && keyASCII < 122) { //a-z
			window.event.keyCode = keyASCII - 32;
		}
		else if (keyASCII > 47 && keyASCII < 58) { } //0-9
		else if (keyASCII > 64 && keyASCII < 91) { } //A-Z
		//else if (keyASCII == 32) { } // Espacio
		//else if (keyASCII == 45) { } // Guion
		else {
		   window.event.keyCode = '';
		}
	}

	function upperCase(text){
	   var y = text.value;
	   text.value = y.toUpperCase();
	}


function formatCurrency(value,decimal) {
		  //alert("Valor:"+value);
		  //alert("Decimal:"+decimal);
		  	
 	      anynum=eval(value);

 	      divider =10;
 	       switch(decimal){
 	       		case 0:
 	       			divider =1;
 	       			break;
 	       		case 1:
 	       			divider =10;
 	       			break;
 	       		case 2:
 	       			divider =100;
 	       			break;
 	       		default:
 	       			divider =1000;
 	       	}

 	       workNum=Math.abs((Math.round(anynum*divider)/divider));

 	       workStr=""+workNum;

 		   if (workStr.indexOf(".")==-1){workStr+="."}

 	       dStr=workStr.substr(0,workStr.indexOf("."));dNum=dStr-0
 	       pStr=workStr.substr(workStr.indexOf("."))

 	       while (pStr.length-1< decimal){pStr+="0"}

 		   if(pStr =='.') pStr ='';

 	       if (dNum>=1000) {
 	          dLen=dStr.length
 	          dStr=parseInt(""+(dNum/1000))+","+dStr.substring(dLen-3,dLen)
 	       }

 	       if (dNum>=1000000) {
 	          dLen=dStr.length
 	          dStr=parseInt(""+(dNum/1000000))+","+dStr.substring(dLen-7,dLen)
 	       }
 	       retval = dStr + pStr

 	       if (anynum<0) {retval="("+retval+")";}

 	       	return retval;
 	       	//obj.value = retval;
     }

  function ponerFocoBoton(boton){
  	boton.focus();
  }

function checkField (theField, theFunction, emptyOK,s)
{   
    var msg;
    if (checkField.arguments.length < 3) emptyOK = defaultEmptyOK;
    if (checkField.arguments.length == 4) {
        msg = s;
    } 
    if ((emptyOK == true) && (isEmpty(theField.value))) return true;

    if ((emptyOK == false) && (isEmpty(theField.value))){ 
    	if (checkField.arguments.length == 4){
           return warnEmpty(theField, msg);
        }else{
          return false;
        }
	}
	
    if (theFunction(theField.value) == true) {
        return true;
    }
    else {
    	if (checkField.arguments.length == 4){
          return warnInvalid(theField,msg,true);
        }else{
          return false;
        }
    }    
}


function checkSelect (theField,msg)
{
   if (theField.selectedIndex != 0) return true;
   else return warnInvalid(theField,msg,false);
}

function warnEmpty (theField, mMessage)
{   
	theField.focus()
    alert(mMessage)
    statBar(mMessage)
    return false
}

function warnInvalid (theField, s, Select)
{
    if (warnInvalid.arguments.length < 3) Select = true;
    theField.focus();
    if (Select) theField.select();
    alert(s);
    statBar(pPrompt + s);
    return false;
}

function statBar (s)
{   window.status = s
}

function isWhitespace (s)
{   var i;
    if (isEmpty(s)) return true;
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        // si el caracter en que estoy no aparece en whitespace,
        // entonces retornar falso
        if (whitespace.indexOf(c) == -1) return false;
    }
    return true;
}

function isNotWhitespace (s)
{
   return (!isWhitespace(s));
}


function isEmpty(s)
{   return ((s == null) || (s.length == 0))
}

/*
function validDate(obj) {
 	date=obj.value
 	if (/[^\d/]|(\/\/)/g.test(date))  {
 		obj.value=obj.value.replace(/[^\d/]/g,'');obj.value=obj.value.replace(/\/{2}/g,'/'); return }
 if (/^\d{2}$/.test(date)){obj.value=obj.value+'/'; return }
 if (/^\d{2}\/\d{2}$/.test(date)){obj.value=obj.value+'/'; return }
 if (!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(date)) return

 test1=(/^\d{1,2}\/?\d{1,2}\/\d{4}$/.test(date))
 date=date.split('/')
 d=new Date(date[2],date[1]-1,date[0])
 test2=(1*date[0]==d.getDate() && 1*date[1]==(d.getMonth()+1) && 1*date[2]==d.getFullYear())
 if (test1 && test2) return true;
 alert("Fecha invalida, ingrese de nuevo.")
 obj.select();
 obj.focus()
 return false;
}*/

function soloCaracteresValidos()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;

	if((keyASCII == 22) || (keyASCII == 39) || (keyASCII == 180) || (keyASCII == 13)) 
	{
	   window.event.keyCode = '';
	}
}
function mascaraFecha(obj){
maskFecha= /^((((0[13578])|([13578])|(1[02]))[\/](([1-9])|([0-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\/](([1-9])|([0-2][0-9])|(30)))|((2|02)[\/](([1-9])|([0-2][0-9]))))[\/]\d{4}$|^\d{4}$/;
try{
obj.value = obj.value.match(maskFecha)[0];
} catch(e){
obj.value = '';
}
}


//calcular la edad de una persona 
//recibe la fecha como un string en formato espa?ol 
//devuelve un entero con la edad. Devuelve false en caso de que la fecha sea incorrecta o mayor que el dia actual 
function calcular_edad(fecha){ 

    //calculo la fecha de hoy 
    hoy=new Date() 
    //alert(hoy) 

    //calculo la fecha que recibo 
    //La descompongo en un array 
    var array_fecha = fecha.split("/") 
    //si el array no tiene tres partes, la fecha es incorrecta 
    if (array_fecha.length!=3) 
       return false 

    //compruebo que los ano, mes, dia son correctos 
    var ano 
    ano = parseInt(array_fecha[2]); 
    if (isNaN(ano)) 
       return false 

    var mes 
    mes = parseInt(array_fecha[1]); 
    if (isNaN(mes)) 
       return false 

    var dia 
    dia = parseInt(array_fecha[0]); 
    if (isNaN(dia)) 
       return false 


    //si el a?o de la fecha que recibo solo tiene 2 cifras hay que cambiarlo a 4 
    if (ano<=99) 
       ano +=1900 

    //resto los a?os de las dos fechas 
    edad=hoy.getYear()- ano - 1; //-1 porque no se si ha cumplido a?os ya este a?o 

    //si resto los meses y me da menor que 0 entonces no ha cumplido a?os. Si da mayor si ha cumplido 
    if (hoy.getMonth() + 1 - mes < 0) //+ 1 porque los meses empiezan en 0 
       return edad 
    if (hoy.getMonth() + 1 - mes > 0) 
       return edad+1 

    //entonces es que eran iguales. miro los dias 
    //si resto los dias y me da menor que 0 entonces no ha cumplido a?os. Si da mayor o igual si ha cumplido 
    if (hoy.getUTCDate() - dia >= 0) 
       return edad + 1 

    return edad 
} 

function validarTeclas(){
	desactivarBackspace();
}

function desactivarBackspace(){
	var keyASCII;
	
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	if( keyASCII == 8 )
	{
	   window.event.keyCode = '';
	}
}

//se usa en evento onpaste para validar pegado de valores numericos
function fncOnPasteValidaNumero(){
		var txt = clipboardData.getData("Text");
		var numPaste = parseInt(txt);
		
		if (isNaN(numPaste)) { 
			return false; 
	        }
	        else{
			clipboardData.setData("Text", numPaste+"");
			return true;
		}
}

    function soloNumeros(evt) {
    	var charCode = (evt.which) ? evt.which : event.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57))
        {
			return false;
		}
		return true;
	}
	
	// Ejemplo: validarNumero(100044, 10, 4). Valida y formatea "100044" con
	// 10 enteros y 4 decimales 
	function validarNumero(nStr, ent, dec) {
		return formatearNumero(truncarNumero(soloNumerosPositivos(nStr), ent, dec));
	}
	
	//Formatea un string como numero. Ej: 1444500.990 -> 1,444,500.990
	function formatearNumero(nStr) {
		if (nStr == "" || nStr == "") {
			return nStr;
		}
		nStr += '';
	  	x = nStr.split('.');
	  	x1 = x[0];
	  	x2 = x.length > 1 ? '.' + x[1] : '';
	  	var rgx = /(\d+)(\d{3})/;
	  	while (rgx.test(x1)) {
			x1 = x1.replace(rgx, '$1' + ',' + '$2');
		}
	  	return x1 + x2;
	}
	
	//Trunca la parte entera y decimal seg�n un m�ximo de caracteres
	//Ej: (maxInteger=6, 4): 2233445.990 -> 223344.990 -- 223344.99997 -> 223344.9999
	function truncarNumero(nStr, maxInteger, maxDecimal) {
		var nn = nStr.split('.');
		var r = nn[0].substr(0, maxInteger);
		var d = '';
		if (nn.length > 1) {
			d = ("." + nn[1]).substr(0, maxDecimal + 1);
		}
		return r + d;
	}
	
	//Acepta numeros positivos
	function soloNumerosPositivos(str) {
		str += '';
		var rgx = /^\d|\./;
	  	var out = '';
	  	for (var i = 0; i < str.length; i++) {
	    	if (rgx.test( str.charAt(i))) {
	      		if (!((str.charAt(i) == '.' && out.indexOf('.') != -1 ))) {
	        		out += str.charAt(i);
	      		}
	    	}
	  	}
	  	return out;
	}
	
	function nullOrEmpty(text) {
		var regex = /^\s{1,}$/g;
		if (text == null || text.length == 0 || text.search(regex) > -1) {
			return true;
		}
		return false;
	}
	
	function cambiaAMayuscula() {
		var c = String.fromCharCode(window.event.keyCode).toUpperCase();
		window.event.keyCode = c.charCodeAt(0);
	}
			
	function esA_Z() {
		return (window.event.keyCode > 64 && window.event.keyCode < 91);
	}
	
	function esDigito() {
		return (window.event.keyCode > 47 && window.event.keyCode < 58);
	}
			
	function esGuion() {
		return window.event.keyCode == 45;
	}
			
	function esEspacio() {
		return window.event.keyCode == 32;
	}