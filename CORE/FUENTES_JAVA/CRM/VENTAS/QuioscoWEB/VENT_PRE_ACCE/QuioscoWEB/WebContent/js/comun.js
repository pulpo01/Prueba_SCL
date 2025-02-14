/* 
	Fecha: 07/06/2010
	Descripción: Uso Comun
	Developer: Gabriel Moraga L.

*/

//Quita los espacios de la izquierda y derecha
function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
//Quita los espacios de la izquierda
function ltrim(stringToTrim) {
	return stringToTrim.replace(/^\s+/,"");
}
//Quita los espacios de la derecha
function rtrim(stringToTrim) {
	return stringToTrim.replace(/\s+$/,"");
}

//Valida que solo se contegan letras
function soloLetras(ky){

	if(ky == 32 || ky == 13 || ky == 209 || ky == 241 || (ky >= 65 && ky <= 90) || (ky >= 97 && ky <= 122)  )
		return;
	else
		event.returnValue = false;

}
//Valida que se contengan letras y numeros
function soloLetras2(ky){
	//48 -57
	if(ky == 32 || ky == 13 || ky == 209 || ky == 241 || (ky >= 65 && ky <= 90) || (ky >= 97 && ky <= 122) ||(ky >= 48 && ky <= 57) )
		return;
	else
		event.returnValue = false;

}

//Enter al pistolear
function validarPistoleo(ky){
	if(ky == 13)
		return "si";
	else
		return "no";
}

//valida que solo se contengan numeros
function soloNumeros(ky){
	//48 -57
   if(ky >= 48 && ky <= 57){      
		return;
	}else if(ky==46){
		return;
	}else{
    	event.returnValue = false;		
    }
}
//Por verificar
function blockNonNumbers(obj, e, allowDecimal, allowNegative){

	var key;
	var isCtrl = false;
	var keychar;
	var reg;
			
	if(window.event) {
		key = e.keyCode;
		isCtrl = window.event.ctrlKey
	}
	else if(e.which) {
		key = e.which;
		isCtrl = e.ctrlKey;
	}
		
	if (isNaN(key)) return true;
		
		keychar = String.fromCharCode(key);	
	
		if (key == 8 || isCtrl)
		{
			return true;
		}
	
		reg = /\d/;
		var isFirstN = allowNegative ? keychar == '-' && obj.value.indexOf('-') == -1 : false;
		var isFirstD = allowDecimal ? keychar == '.' && obj.value.indexOf('.') == -1 : false;
			
		return isFirstN || isFirstD || reg.test(keychar);

}
//Por verificar
function extractNonNumbers(obj, decimalPlaces, allowNegative){

	var temp = obj.value;
		
	// avoid changing things if already formatted correctly
	var reg0Str = '[0-9]*';
	if (decimalPlaces > 0) {
		reg0Str += '\\.?[0-9]{0,' + decimalPlaces + '}';
	} else if (decimalPlaces < 0) {
		reg0Str += '\\.?[0-9]*';
	}
	reg0Str = allowNegative ? '^-?' + reg0Str : '^' + reg0Str;
	reg0Str = reg0Str + '$';
	var reg0 = new RegExp(reg0Str);
	if (reg0.test(temp)) return true;
	
	// first replace all non numbers
	var reg1Str = '[^0-9' + (decimalPlaces != 0 ? '.' : '') + (allowNegative ? '-' : '') + ']';
	var reg1 = new RegExp(reg1Str, 'g');
	temp = temp.replace(reg1, '');
	if (allowNegative){
		// replace extra negative
		var hasNegative = temp.length > 0 && temp.charAt(0) == '-';
		var reg2 = /-/g;
		temp = temp.replace(reg2, '');
		if (hasNegative) temp = '-' + temp;
	}
	if (decimalPlaces != 0) {
		var reg3 = /\./g;
		var reg3Array = reg3.exec(temp);
		if (reg3Array != null) {
			// keep only first occurrence of .
			//  and the number of places specified by decimalPlaces or the entire string if decimalPlaces < 0
			var reg3Right = temp.substring(reg3Array.index + reg3Array[0].length);
			reg3Right = reg3Right.replace(reg3, '');
			reg3Right = decimalPlaces > 0 ? reg3Right.substring(0, decimalPlaces) : reg3Right;
			temp = temp.substring(0,reg3Array.index) + '.' + reg3Right;
		}
	}
	obj.value = temp;
}


      //Objeto oNumero

      function oNumero(numero)

      {

//Propiedades 

this.valor = numero || 0

this.dec = -1;

//Métodos 

this.formato = numFormat;

this.ponValor = ponValor;

//Definición de los métodos


function ponValor(cad)

{

if (cad =='-' || cad=='+') return

if (cad.length ==0) return

if (cad.indexOf('.') >=0)

    this.valor = parseFloat(cad);

else 

    this.valor = parseInt(cad);

} 

function numFormat(dec, miles)

{

var num = this.valor, signo=3, expr;

var cad = ""+this.valor;

var ceros = "", pos, pdec, i;

for (i=0; i < dec; i++)

ceros += '0';

pos = cad.indexOf('.')

if (pos < 0)

    cad = cad+"."+ceros;

else

    {

    pdec = cad.length - pos -1;

    if (pdec <= dec)

        {

        for (i=0; i< (dec-pdec); i++)

            cad += '0';

        }

    else

        {

        num = num*Math.pow(10, dec);

        num = Math.round(num);

        num = num/Math.pow(10, dec);

        cad = new String(num);

        }

    }

pos = cad.indexOf('.')

if (pos < 0) pos = cad.lentgh

if (cad.substr(0,1)=='-' || cad.substr(0,1) == '+') 

       signo = 4;

if (miles && pos > signo)

    do{

        expr = /([+-]?\d)(\d{3}[\.\,]\d*)/

        cad.match(expr)

        cad=cad.replace(expr, RegExp.$1+','+RegExp.$2)

        }

while (cad.indexOf(',') > signo)

    if (dec<0) cad = cad.replace(/\./,'')

        return cad;

}

}//Fin del objeto oNumero: