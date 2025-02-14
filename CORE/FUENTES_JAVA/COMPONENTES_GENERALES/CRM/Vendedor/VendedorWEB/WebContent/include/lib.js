//Elimina caracteres  al comienzo y al final
function trim(inputString) {
   var retValue = inputString;
   var ch = retValue.substring(0, 1);
   while (ch == " ") { // chequea por espacios al comienzo del string
      retValue = retValue.substring(1, retValue.length);
      ch = retValue.substring(0, 1);
   }
   ch = retValue.substring(retValue.length-1, retValue.length);
   while (ch == " ") { // chequea por espacios al final del string
      retValue = retValue.substring(0, retValue.length-1);
      ch = retValue.substring(retValue.length-1, retValue.length);
   }
   while (retValue.indexOf("  ") != -1) { // Hay 2 espacios en el string - mira para multipes espacios dentro del string
      retValue = retValue.substring(0, retValue.indexOf("  ")) + retValue.substring(retValue.indexOf("  ")+1, retValue.length); // De nuevo, hay 2 espacios en el string
   }
   return retValue; 
}



// Valida que el campo tiene uno o mas caracteres
function isNotEmpty(elem) {
	alert('jimmy')
    var str = elem.value;
    str = trim(str)
    alert(str)
    if(str == null || str.length == 0) {
        return false;
    } else {
        return true;
    }
}
   
// valida que la entrada es un numero positivo o negativo
function isNumber(elem) {
    var str = elem.value;
    var oneDecimal = false;
    var oneChar = 0;
    // Se asegura que el valor no se ha casteado a tipo de dato numero
    str = str.toString( );
    for (var i = 0; i < str.length; i++) {
        oneChar = str.charAt(i).charCodeAt(0);
        // OK para signo menos, solo la primera vez
        if (oneChar == 45) {
            if (i == 0) {
                continue;
            } else {
                //S?lo el primer car?cter puede ser signo menos.
                return 1;
            }
        }
        // OK para un punto decimal
        if (oneChar == 46) {
            if (!oneDecimal) {
                oneDecimal = true;
                continue;
            } else {
                //S?lo un decimal es permitido en un n?mero
                return 2;
            }
        }
        // Caracteres de 0 a 9 OK
        if (oneChar < 48 || oneChar > 57) {
            //Introduzca solo n?meros en el campo
            return 3;
        }
    }
    return 0;
}


  function IsNumeric(sText)      {
     var ValidChars = "0123456789";
     var IsNumber=true;
     var Char; 
     for (i = 0; i < sText.length && IsNumber == true; i++){ 
        Char = sText.charAt(i); 
        if (ValidChars.indexOf(Char) == -1){
           IsNumber = false;
        }
     }         
     if(sText==""){
        IsNumber = false;
     }                  
     return IsNumber;
  } 

