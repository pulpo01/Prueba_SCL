
function verificacionDesvioNumero(numeroDesvio){
	
	JVerificaNumeroDesviadoDWR.verificaNumero(	numeroDesvio,
												callbackVerificacionDesvioNumero);
												
	
}

function callbackVerificacionDesvioNumero(data){
	
	if(data == "TRUE"){
		respuestaValidacionNumero = "TRUE";
	}else{
		respuestaValidacionNumero = "FALSE";
		alert("El n�mero a deviar no es valido");
	}
}