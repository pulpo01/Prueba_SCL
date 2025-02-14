var defaultEmptyOK = true;

var checkNiceness = true;

// listas de caracteres
var digits = "0123456789";
var lowercaseLetters = "abcdefghijklmnopqrstuvwxyzñáéíóú";
var uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZÑÁÉÍÓÚ";
var simb = "-";

//var lowercaseLetters = "abcdefghijklmnopqrstuvwxyz???????"--> se sacaron los acentos
//var uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ??????" -->se sacaron los acentos

var whitespace = " \t\n\r";

// caracteres admitidos en nos de telefono
var phoneChars = "()-+ ";

// Caracteres de un precio
var priceChars = "$,.";

var mMessage = "Error: no puede dejar este espacio vacio"

var pPrompt = "Error: ";
var pAlphanumeric = "ingrese un texto que contenga solo letras y/o numeros";
var pAlphabetic   = "ingrese un texto que contenga solo letras";
var pInteger = "ingrese un numero entero";
var pNumber = "ingrese un numero";
var pPhoneNumber = "ingrese un número de teléfono";
var pEmail = "ingrese una dirección de correo electrónico válida";
var pName = "ingrese un texto que contenga solo letras, numeros o espacios";
var pNice = "no puede utilizar comillas aqui";


function makeArray(n) {
   for (var i = 1; i <= n; i++) {
      this[i] = 0
   } 
   return this
}

// ---------------------------------------------------------------------- //
//                  CODIGO PARA FUNCIONES BASICAS                         //
// ---------------------------------------------------------------------- //

function isEmpty(s) {   
         if((s == null) || (s.length == 0))
                 return true;
 
         var s2 = s.replace( /^ +/, "");
         s2 = s2.replace( / +$/, "");

         if(s2.length == 0)
                 return true;
 
        return false;
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

// Quita todos los caracteres que que estan en "bag" del string "s" s.
function stripCharsInBag (s, bag)
{   var i;
    var returnString = "";

    // Buscar por el string, si el caracter no esta en "bag", 
    // agregarlo a returnString
    
    for (i = 0; i < s.length; i++)
    {   var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }

    return returnString;
}

// Lo contrario, quitar todos los caracteres que no estan en "bag" de "s"
function stripCharsNotInBag (s, bag)
{   var i;
    var returnString = "";
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (bag.indexOf(c) != -1) returnString += c;
    }

    return returnString;
}

// Quitar todos los espacios en blanco de un string
function stripWhitespace (s)
{   return stripCharsInBag (s, whitespace)
}

// La rutina siguiente es para cubrir un bug en Netscape
// 2.0.2 - seria mejor usar indexOf, pero si se hace
// asi stripInitialWhitespace() no funcionaria

function charInString (c, s)
{   for (i = 0; i < s.length; i++)
    {   if (s.charAt(i) == c) return true;
    }
    return false
}

// Quita todos los espacios que antecedan al string
function stripInitialWhitespace (s)
{   var i = 0;
    while ((i < s.length) && charInString (s.charAt(i), whitespace))
       i++;
    return s.substring (i, s.length);
}

// c es una letra del alfabeto espanol
function isLetter (c)
{
    return( ( uppercaseLetters.indexOf( c ) != -1 ) ||
            ( lowercaseLetters.indexOf( c ) != -1 ) )
}

// c es un digito
function isDigit (c)
{   return ((c >= "0") && (c <= "9"))
}

// c es letra o digito
function isLetterOrDigit (c)
{   return (isLetter(c) || isDigit(c))
}

// c es un simbolo(-)
function isSimbolo (c)
{   return (simb.indexOf(c) != -1)
}



// ------------------ //
//   Fecha           //
// ----------------- //

function isDate (dia, mes, ano)
{
   if (isEmpty(dia) && isEmpty(mes) && isEmpty(ano)) // No hay fecha
   { return true; }

   if (!esnum(dia) || !esnum(mes) || !esnum(ano))
   { return false; }

   if ((dia > 31) || (mes > 12) || (ano < 0) || (dia<1) || (mes<1))
   { return false; }

   var mod;
   mod = ano % 4;

   if (mes == 4 || mes == 6 || mes == 9 || mes == 11)
   { 
	 if (dia == 31)
	 { return (false); }
   }
   if (mes == 2)
   {
	 if (mod == 0)
	 {
		 if (dia > 29)
		 {  return (false); }
         }
	 else
	 {
		 if (dia > 28)
		 {  return (false); }
	 }
   }

   return (true);

}



// ---------------------------------------------------------------------- //
//                          NUMEROS                                       //
// ---------------------------------------------------------------------- //


// s es un numero entero (sin signo, solo numeros)
function isIntegerNum (s)
{   var i;
    if (isEmpty(s)) 
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);
    
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (!isDigit(c)) return false;
    }
    return true;
}


// s es un numero entero (con o sin signo)
function isInteger (s)
{   var i;
    if (isEmpty(s)) 
       if (isInteger.arguments.length == 1) return defaultEmptyOK;
       else return (isInteger.arguments[1] == true);
    
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if( i != 0 ) {
            if (!isDigit(c)) return false;
        } else { 
            if (!isDigit(c) && (c != "-") || (c == "+")) return false;
        }
    }
    return true;
}

// s es un numero (entero o flotante, con o sin signo)
function isNumber (s)
{   var i;
    var dotAppeared;
    dotAppeared = false;
    if (isEmpty(s)) 
       if (isNumber.arguments.length == 1) return defaultEmptyOK;
       else return (isNumber.arguments[1] == true);
    
    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if( i != 0 ) {
            if ( c == "." ) {
                if( !dotAppeared )
                    dotAppeared = true;
                else
                    return false;
            } else     
                if (!isDigit(c)) return false;
        } else { 
            if ( c == "." ) {
                if( !dotAppeared )
                    dotAppeared = true;
                else
                    return false;
            } else     
                if (!isDigit(c) && (c != "-") || (c == "+")) return false;
        }
    }
    return true;
}

// ---------------------------------------------------------------------- //
//                        STRINGS SIMPLES                                 //
// ---------------------------------------------------------------------- //

// s tiene solo letras
function isAlphabetic (s)
{   var i;

    if (isEmpty(s)) 
       if (isAlphabetic.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphabetic.arguments[1] == true);
    for (i = 0; i < s.length; i++)
    {   
        // Check that current character is letter.
        var c = s.charAt(i);

        if (!isLetter(c))
        return false;
    }
    return true;
}


// s tiene solo letras y numeros
function isAlphanumeric (s)
{   var i;

    if (isEmpty(s)) 
       if (isAlphanumeric.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphanumeric.arguments[1] == true);

    for (i = 0; i < s.length; i++)
    {   
        var c = s.charAt(i);
        if (! (isLetter(c) || isDigit(c) ) )
        return false;
    }

    return true;
}



// s tiene solo letras, numeros y -
function isAlphanumeric2 (s)
{   var i;

    if (isEmpty(s)){ 
       if (isAlphanumeric2.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphanumeric2.arguments[1] == true);
      } 
     
    for (i = 0; i < s.length; i++)
    {   
     
        var c = s.charAt(i);
        if (! (isLetter(c) || isDigit(c) || isSimbolo(c)) )
        return false;
    }

    return true;
}



// s tiene solo letras, numeros o espacios en blanco y solo puede aceptar como simbolo el guion -
function isName (s)
{
    if (isEmpty(s)) 
       if (isName.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphanumeric2.arguments[1] == true);
    
    return( isAlphanumeric2( stripCharsInBag( s, whitespace ) ) );
}


// s tiene solo letras, numeros o espacios en blanco
function isName2 (s)
{
    if (isEmpty(s)) 
       if (isName2.arguments.length == 1) return defaultEmptyOK;
       else return (isAlphanumeric.arguments[1] == true);
    
    return( isAlphanumeric( stripCharsInBag( s, whitespace ) ) );
}


// ------------- //
//    RUT        //
// ------------- //

function esnum(cosa)
{
   bien=true;
   for(var i=0;i<cosa.length;i++)
   {
        var c=cosa.substring(i,i+1);
        if(c < '0' || c > '9')
        {
          if(i == 0 && c!="")
          {if(c!='-'){return(false);}
          else if(cosa.substring(i+1,i+2) ==""){return(false);}
               else{return(true);}}
          else if(c!="")
               {return(false);}
        }
   }
   return(true);
}



function verifica(val,nombre)
{

  if (val == "")
  {
     alert(nombre+" debe tener alg?n valor");
     return(false);
  }
  return(true);
}

function verifica_rut(rut,digito)
{


   if (!esnum(rut))
       {alert("Rut debe ser numerico, no ingresar letras ni puntos.");return(false);}

   if (!esnum(digito) && digito !='K' && digito != 'k')
    {alert("EL digito verificador debe ser numerico o K");return(false);}
   var m=1
   var sum=0

   for (var i=rut.length;i>=0;i--){
	        sum+=rut.charAt(i)*m;
	        m++;
	        if (m>7) { m=2 }
	}

	var dig=sum%11
	dig=11-dig
	if (dig==11) { dig=0 }
	if (dig==10) { dig="K" }
	if ((digito == 'k' || digito == 'K') && (dig=='K'))
        {return(true);}
        else if (digito == dig)
	      {return(true);}
	      else
              {
	       alert("El digito verificador no es valido.");
	       return(false);
	      }
}


function isRut(s){
    var largo = s.length;
    if(largo>3){
        var digito = s.charAt(largo-1);
        var rut = s.substring(0,largo-2);
        if(!verifica_rut(rut,digito)){
            return(false);
        }else{
            return(true);
        }
    }else{
        alert("RUT mal ingresado!!!");
        return false;
    }
}




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

// ---------------------------------------------------------------------- //
//                           FONO o EMAIL                                 //
// ---------------------------------------------------------------------- //

// s es precio valido
function isPrice (s)
{   var modString;
    if (isEmpty(s)) 
       if (isPrice.arguments.length == 1) return defaultEmptyOK;
       else return (isPrice.arguments[1] == true);
    modString = stripCharsInBag( s, priceChars );
    return (isInteger(modString))
}

// s es numero de telefono valido
function isPhoneNumber (s)
{   var modString;
    if (isEmpty(s)) 
       if (isPhoneNumber.arguments.length == 1) return defaultEmptyOK;
       else return (isPhoneNumber.arguments[1] == true);
    modString = stripCharsInBag( s, phoneChars );
    return (isInteger(modString))
}

// s es una direccion de correo valida
function isEmail (s)
{
    if (isEmpty(s)) 
       if (isEmail.arguments.length == 1) return defaultEmptyOK;
       else return (isEmail.arguments[1] == true);
    if (isWhitespace(s)) return false;
    var i = 1;
    var sLength = s.length;
    while ((i < sLength) && (s.charAt(i) != "@"))
    { i++
    }

    if ((i >= sLength) || (s.charAt(i) != "@")) return false;
    else i += 2;

    while ((i < sLength) && (s.charAt(i) != "."))
    { i++
    }

    if ((i >= sLength - 1) || (s.charAt(i) != ".")) return false;
    else return true;
}

function isNice(s)
{
        var i = 1;
        var sLength = s.length;
        var b = 1;
        while(i<sLength) {
                if( (s.charAt(i) == "\"") || (s.charAt(i) == "'" ) ) b = 0;
                i++;
        }
        return b;
}

// ---------------------------------------------------------------------- //
//                  FUNCION PARA VERIFICAR UNA URL			  //
// ---------------------------------------------------------------------- //

// ---------------------------------------------------------------------- //
//                  FUNCIONES PARA RECLAMARLE AL USUARIO                  //
// ---------------------------------------------------------------------- //

// pone el string s en la barra de estado
function statBar (s)
{   window.status = s
}

// ---------------------------------------------------------------------- //
//                        FUNCIONES VARIAS					              //
// ---------------------------------------------------------------------- //

//para restaurar la imagen anterior
function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

//para pre cargar imagenes
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

//buscar un objeto(cursor sobre una imgen recarga otra)
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

// para redireccionar una pagina
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}