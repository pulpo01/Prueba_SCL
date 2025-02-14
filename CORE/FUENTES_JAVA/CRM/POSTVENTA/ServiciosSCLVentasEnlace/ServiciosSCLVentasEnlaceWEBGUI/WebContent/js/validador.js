<!-- Begin
var pPrompt = "Error: ";
var whitespace = " \t\n\r";

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

function soloCaracteresValidos()
{
	var keyASCII;
	var strNumber = new String(event.srcElement.value);
	keyASCII = window.event.keyCode;

	if((keyASCII == 22) || (keyASCII == 39) || (keyASCII == 180)) 
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


function validaFechaRehabilitacion(fechaRehabilitacion){
	if (fechaRehabilitacion !=null && fechaRehabilitacion.value!=""){
		var mydate=new Date();
		var year=mydate.getFullYear();
		var day=mydate.getDay();
		var month=mydate.getMonth()+1;
		if (month<10)
			month="0"+month;
		var daym=mydate.getDate();
		if (daym<10)
			daym="0"+daym;
		var sfechaActual  = daym + "-" + month + "-"  + year;
		var str = fechaRehabilitacion.value;
		var fechaActual=new Date();
		fechaIngresada = new Date(str.replace(/^(\d{2})-(\d{2})-(\d{4})$/, "$2/$1/$3"));
		fechaActual = new Date(sfechaActual.replace(/^(\d{2})-(\d{2})-(\d{4})$/, "$2/$1/$3"));
		if (fechaActual>fechaIngresada){
			return false;
		}else{
			return true;
		}
		
	}else return true;
}
