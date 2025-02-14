function enter(form,field)
{
	var next=0, found=false
	var f=form
	if(event.keyCode!=13) return;
	for(var i=0;i<f.length;i++) {
		if(field.name==f.item(i).name){
			next=i+1;
			found=true
			break;
		}
	}
	while(found){
		if( f.item(next).disabled==false && f.item(next).type!='hidden' && f.item(next).readOnly==false){
			f.item(next).focus();
			break;
		}
		else{
			if(next<f.length-1)
				next=next+1;
			else
				break;
		}
	}
}
function CargaHora(field)
{
	if (field.value == "" || field.value == null)
	{
		momentoActual = new Date();
		ano = momentoActual.getYear() ;
		if (momentoActual.getDate() < 10)
			dia = "0".concat(momentoActual.getDate());
		else
			dia = momentoActual.getDate();

		if (momentoActual.getMonth() + 1 < 10)
			mes = "0".concat(momentoActual.getMonth()+1);
		else
			mes = momentoActual.getMonth()+1;

		field.value = dia + "/"+ mes + "/" + ano;
	}
}
function pulsar(e) {
	  tecla = (document.all) ? e.keyCode : e.which;
	  return (tecla != 13);
}

function formatoDecimales(nroDecimales){
	for (i=0; i<document.forms.length; i++){
		for (j = 0; j < document.forms[i].elements.length; j++){
			if (document.forms[i].elements[j].type == "text" 
		  		&& !isNaN(document.forms[i].elements[j].value)
	          	) { 
	           num = parseFloat(document.forms[i].elements[j].value);
	           num =Math.round(num * Math.pow(10,nroDecimales)) / Math.pow(10, nroDecimales);
	           document.forms[i].elements[j].value = num.toFixed(nroDecimales);
	        }
		}
	}
}

function desactivar(object){ 
	for(i=0;i<object.length;i++){ 
		object.elements(i).disabled = true; 
	} 
	return false; 
} 

function enviar(form,accion,envia){

	form.accion.value=accion;
	form.action=envia;
	form.submit();
}


function transformaraNumero(num1){ 
	num2=""; 
	// Por cada d?gito 
    for(i=0;i<num1.length;i++){ 
	// Comprobamos si es una coma 
        char=num1.charAt(i); 
	// Si es una coma, lo quitamos 
        if(char==",") char="";
    	num2+=char; 
    } 
	// Y retornamos el n?mero 
    return parseFloat(num2); 
}