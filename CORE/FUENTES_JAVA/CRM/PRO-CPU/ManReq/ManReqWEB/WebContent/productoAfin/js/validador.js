<!-- Begin
var pPrompt = "Error: ";
var whitespace = " \t\n\r";

function check_date(field){
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
      DateField.value = day + seperator + month + seperator + year;
   }
   /* Error-message if err != 0 */
   else {
      alert("Fecha invalida!");
      DateField.select();
	  DateField.focus();
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
//  End -->


function onlyFloat(valorCampoTexto,numDecimales) {
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;
	
	if (keyASCII == 47) {
	  window.event.keyCode = '';	 
	  return;
	}
	
	if( keyASCII != 13 && keyASCII != 75 && (keyASCII < 46 || keyASCII > 57) ) //  And Not IsNumeric(Chr(CodAsc)) )
	{
	   window.event.keyCode = '';
	} else {
		if (valorCampoTexto.indexOf('.') != -1){
			dectext = valorCampoTexto.substring(valorCampoTexto.indexOf('.')+1, valorCampoTexto.length);
			if (dectext.length >= numDecimales) {
		   		window.event.keyCode = '';
			}
		}
	}
}

function onlyIntegerLetters()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;

	if( (keyASCII > 47 && keyASCII < 58) || (keyASCII > 64 && keyASCII < 91) || (keyASCII > 96 && keyASCII < 123)  ) 
	{
	}else {
	   window.event.keyCode = '';
	}
}

function upperCase(text){
   var y = text.value;
   text.value = y.toUpperCase();
}


function formatCurrency(value,decimal) {
		  alert("Valor:"+value);
		  alert("Decimal:"+decimal);
		  	
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

function validDate(obj){
 date=obj.value
 if (/[^\d/]|(\/\/)/g.test(date))  {obj.value=obj.value.replace(/[^\d/]/g,'');obj.value=obj.value.replace(/\/{2}/g,'/'); return }
 if (/^\d{2}$/.test(date)){obj.value=obj.value+'/'; return }
 if (/^\d{2}\/\d{2}$/.test(date)){obj.value=obj.value+'/'; return }
 if (!/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(date)) return

 test1=(/^\d{1,2}\/?\d{1,2}\/\d{4}$/.test(date))
 date=date.split('/')
 d=new Date(date[2],date[1]-1,date[0])
 test2=(1*date[0]==d.getDate() && 1*date[1]==(d.getMonth()+1) && 1*date[2]==d.getFullYear())
 if (test1 && test2) return true
 alert("Fecha invalida, ingrese de nuevo.")
 obj.select();
 obj.focus()
 return false
}


