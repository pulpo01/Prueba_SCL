function ltrim(s) {
	return s.replace(/^\s+/, "");
}

function rtrim(s) {
	return s.replace(/\s+$/, "");
}

function trim(s) {
	return rtrim(ltrim(s));
}

function mostrarError(mensaje)	{

	document.getElementById("textoerror").innerHTML = "<img src='img/black_arrow.gif'> " + mensaje;	
	document.getElementById("textoerror").style.display = 'inline';
	document.getElementById("mensajes").style.display = 'inline';

}

// ------------------------------------------------------------------------------------  

function borrarError()	{

	document.getElementById("textoerror").innerHTML = "";	
	document.getElementById("textoerror").style.display = 'none';
	document.getElementById("mensajes").style.display = 'none';
}

//------------------------------------------------------------------------------------  

/*
 * Función que genera el div principal de carga
 */
function generarDivPrincipalDeCarga(color, opacity,width,heigth){
    document.getElementById("capa_principal").style.width = width+'px';
    document.getElementById("capa_principal").style.height = heigth +'px';
    document.getElementById("capa_principal").style.backgroundColor=color;
    document.getElementById("capa_principal").style.position='absolute';
    document.getElementById("capa_principal").style.zIndex=100;
    document.getElementById("capa_principal").style.filter='alpha(opacity='+opacity+')';
	document.getElementById("capa_principal").style.visibility = 'visible';
 }

/*
 * Función que localiza el gif cargando
 */
function localizarImagenCargando(top, left){
	
	document.getElementById("idEspere").style.visibility = "visible";
	document.getElementById("idCargando").style.visibility = "visible";
 	document.getElementById("idCargando").style.top = top;
 	document.getElementById("idCargando").style.left = left;
 }

/*
 *	Función que oculta el div de carga
 */
function ocultarDivPrincipalDeCarga(){
 	document.getElementById("idEspere").style.visibility = "hidden";
 	document.getElementById("idCargando").style.visibility = "hidden";
 	document.getElementById("capa_principal").style.visibility = 'hidden';
 }

