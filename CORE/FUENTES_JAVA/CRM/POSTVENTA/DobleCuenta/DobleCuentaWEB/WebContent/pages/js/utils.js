function makeRequest(url) {
	var httpRequest;  //El objeto que hará la petición por nosotros
	var isIExplorer;  //Un flag que nos dira si estamos usando IE o un navegador decente ;-)
	
	// Lo primero es lo primero :-P Validemos que esta cosa funcione con Firefox, Safari, Konqueror, etc
    if (window.XMLHttpRequest) {
    	isIExplorer = false;
    	httpRequest = new XMLHttpRequest();
        if (httpRequest.overrideMimeType) {
        	//Definimos que el MIME Type sea XML. De esta forma, nos aseguramos compatibilidad con versiones más antiguas.
        	httpRequest.overrideMimeType('text/xml'); 
        }
	} 
	// Entonces, quiere decir que estamos usando IE
	else if (window.ActiveXObject) {
		isIExplorer = true;
    	try {
       		httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
        } catch (e) {
           	try {
            	httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
        	} catch (e) {
            	//Si llegamos a este punto, es porque ya no pudimos crear el objeto HttpRequest, no hay mucho mas que hacer =(
        	}
    	}
    }
    if (!httpRequest) {
    	return false;
   	}
    httpRequest.onreadystatechange = function() { alertContents(httpRequest,url, isIExplorer); };
    if (isIExplorer) {
    	/* Aqui la primera de las mañas del Explorer... la llamada no puede ser asíncrona. Abusrdo, siendo la primera A
    	 * de Ajax es precisamente de Asíncrono 
    	 */
    	httpRequest.open('GET', url, false);
    } else {
    	httpRequest.open('GET', url, true);
    }
   	httpRequest.send(null);
}

function alertContents(httpRequest,url,isIExplorer) {
	//Estado 4, la petición volvió a nosotros :-)
	if (httpRequest.readyState == 4) {
	   //Si el status es 200, quiere decir que el servidor nos respondió con un OK. Malo sería un 404 (Not Found) o un 500 (error interno)
    	if (httpRequest.status == 200) {
    		var xmldoc = httpRequest.responseXML;
    		if(isIExplorer) {
    			//Recargamos el XML... maldito Explorer >:|
    			xmldoc.load(url);
    		}
    		var root_node = xmldoc.getElementsByTagName('abonados').item(0);
			var html = document.getElementById('listaClientesRelacionados');
			if(html != null){
				html.innerHTML = root_node.firstChild.data;
			}
   		}
	}
 }