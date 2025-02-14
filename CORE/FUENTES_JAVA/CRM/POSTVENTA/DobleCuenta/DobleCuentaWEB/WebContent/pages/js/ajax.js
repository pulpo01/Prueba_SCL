//*****************************************************************
//
// Clase que encapsula toda la funcionalidad de Ajax.
//
// hay que setear la url ("setUrl") y la funcion ("setPostFunction")
// que seria llamada cuando despierte el evento "handleHttpResponse"
// y despues llamar al metodo sendData.
// Para obtener los datos hay que llamar a la funcion "getData"
// dentro de la funcion seteada con el metodo "setFunction".
//
// Pendiente:
// Algo que no esta implementado es recivir un objeto un objeto
// "XMLDocumentthis" con la funcion "http.responseXML", este
// regresara la respuesta del servidor como un objeto XMLDocument
// que se puede recorrer usando las funciones de JavaScript DOM
//
//*****************************************************************

//Definicion de la clase Ajax
function Ajax() { 

	//Publico
	this.setUrl = setUrl	
    this.sendData = sendData
	this.getData = getData
	this.setPostFunction = setPostFunction
	this.setPreFunction = setPreFunction
	this.getHTTPObject = getHTTPObject
	this.handleHttpResponse = handleHttpResponse
	this.setAsincrono = setAsincrono
	this.AnalizaCodigoHTTP = AnalizaCodigoHTTP
	this.setMetodo = setMetodo
	this.esAsincrona = true //Cambiar a false si no se quiere usar la funcion asincrona con el metodo setAsincrono
	this.metodo = "GET" //por defecto se ocupara el metodo GET
	this.toQueryString = toQueryString
	this.getSelectedOptions = getSelectedOptions
	this.addFormElements = addFormElements
    //Privado
	var boundaryString = ""
	var postFnc = ""
    var preFnc = ""
	var url = ""
	var result = ""
	var http = null
	var queryString = ""
} 

//setea el metodo de envio de datos
function setMetodo(m) {
	
	this.metodo = m
}

//metodo que setea la url
function setAsincrono(a) {
  
 	this.esAsincrona = a
}

//metodo que setea la url
function setUrl(u) {
  
 	url = u
}

//metodo que setea la funcion que sera llamada al despertar el
//evento handleHttpResponse y se finaliza correctamente
function setPostFunction(f) {
	
	postFnc = f
}

//metodo que setea la funcion que sera llamada al despertar el
//evento handleHttpResponse antes de ser finalizada la peticion
function setPreFunction(fnc) {
	
	preFnc = fnc
}

//Obtiene el objeto HTML dependiendo del navegador
function getHTTPObject() {
  var xmlhttp;
  /*@cc_on
  @if (@_jscript_version >= 5)
    try {
      xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    } catch (e) {
      try {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
      } catch (E) {
        xmlhttp = false;
      }
    }
  @else
  xmlhttp = false;
  @end @*/
  if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
    try {
      xmlhttp = new XMLHttpRequest();
    } catch (e) {
      xmlhttp = false;
    }
  }
  return xmlhttp;
}

function sendData() {

	http = this.getHTTPObject() //Creamos el objeto HTTP

	//Metodos HTTP request:
	// GET
	// POST
	// HEAD 
	// OPTIONS
	// PUT
	// DELETE
	// TRACE
	// CONNECT
	
	http.open(this.metodo, url, this.esAsincrona);
	http.onreadystatechange = this.handleHttpResponse;

	if(this.metodo == "GET") {
  		http.send(null);
	}
	else {
	    //Fix a bug in Firefox when posting
        if (http.overrideMimeType) {
        	http.setRequestHeader("Connection", "close");
        }
        
        //finaliza los datos para ser enviados por post
        queryString = queryString + "--"
        
        //setea datos de cabecera
		http.setRequestHeader("Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, application/x-shockwave-flash, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, text/plain, */*")
		http.setRequestHeader("Accept-Language", "es-cl")
		http.setRequestHeader("Content-Type", "multipart/form-data; boundary=" + boundaryString + "");
		http.setRequestHeader("Accept-Encoding", "gzip,deflate")
		http.setRequestHeader("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)")
		http.setRequestHeader("Content-length", queryString.length);
		http.setRequestHeader("Connection", "Keep-Alive")
        http.setRequestHeader("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.7")
        
        //envia
	    http.send(queryString)
	}
}

function getData() {

	return result
}

//Evalua el codigo de la respuesta HTTP
function AnalizaCodigoHTTP() {

	//Revisa los errores mas comunes
	switch(http.status) {
		case 200:  //OK! La url es valida
		
            try {
              this.result = http.responseText; //regresara la respuesta del servidor como una cadena de texto.
            }
            catch(ex){
              this.result = "" 
			  alert("Error de Ajax: \n"+ex+"\n\n"+ex.description+"\n"+(ex.number & 0xFFFF))

			  //Si el mensaje dice que es un error del sistema -1072896748
			  //puede deberse a que esta trallendo caracteres con una codificacion
			  //sin identificar.
            }		
			break;
		case 401:  //Sin autorizacion
	  	  	alert("ERROR: El acceso al recurso requiere identificacion por parte del usuario")
		  	this.result = ""
		  	break;
		case 403:  //Acceso prohibido
	  	  	alert("ERROR: No se puede tener acceso al recurso solicitado")
		  	this.result = ""
		  	break;		  	
		case 404:  //url invalida
	  	  	alert("ERROR: La url no es valida")
		  	this.result = ""
		  	break;		  	
		case 407:  //Se requiere autenficacion del proxi
	  	  	alert("ERROR: Se requiere autenficacion del servidor proxi")
		  	this.result = ""
		  	break;
		case 415:  //Tipo de medio no soportado
	  	  	alert("ERROR: Tipo de medio no soportado por el cliente")
		  	this.result = ""
		  	break;
	  	case 500:  //Error del servidor interno
	    		
	    	new_window = open("","hoverwindow","width=700,height=500,scrollbars=YES,toolbar=no,directories=no,menubar=no,status=no");
			new_window.document.open();
			new_window.document.write(http.responseText)
			new_window.document.close()

	    	this.result = ""
			break;
	  	case 501:  //No implementado
	    	alert("ERROR: El servidor no entiende la peticion o la instruccion del cliente")
	    	this.result = ""
			break;
	  	case 502:  //Gateway incorrecto
	    	alert("ERROR: Gateway incorrecto")
	    	this.result = ""
			break;
	  	case 503:  //Servicio no disponible
	    	alert("ERROR: Servicio no disponible, probablemente el servidor no soporte metodo POST")
	    	this.result = ""
			break;
		default:
	    	alert("ERROR: Error no especificado")
	    	this.result = ""
			break;		
    }
}

//Verifica el estado de la peticion
// 0 (no inicializada) 
// 1 (leyendo) 
// 2 (leido) 
// 3 (interactiva) 
// 4 (completo) 
function handleHttpResponse() {

	switch(http.readyState) {
    
	  case 4:  //completo
	  	AnalizaCodigoHTTP()
		eval(postFnc) //Ejecuta la funcion cargada
		break;
      case 3:  //Interactiva
        //
        break;
	  case 2:  //leido
        //
        break;
	  case 1:  //leyendo
	    //si no ha setiado una funcion para ser ejecutada antes de ser exitosa
	    //la peticion, entonces no ejecuta nada
	    if(this.preFnc != null) {
          eval(preFnc)
        }
	    break;
      case 0:  //no inicializada
        //
        break;
	}	
}

//Recorre todos los elementos del formulario
function addFormElements(formID) {

	var formElements = document.getElementById(formID).elements
    var values = toQueryString(formElements)
    
    queryString = values 
}

//Funcion que recoje todos los elementos de un formulario y los combierte a un string
function toQueryString(elements) {
        
	var node = null
  	var qs = ""
  	var name = ""
    var tempString = ""
    
    for(var i = 0; i < elements.length; i++) {
		    
	    tempString = ""
        node = elements[i]
        name = node.getAttribute("name")

        //use id if name is null
        if (!name) {
        	name = node.getAttribute("id")
        }

        if(node.tagName.toLowerCase() == "input") {
        	if(node.type.toLowerCase() == "radio" || node.type.toLowerCase() == "checkbox") {
            	if(node.checked) {
                	tempString = name + "=" + node.value
                }
            }

            if(node.type.toLowerCase() == "text" || node.type.toLowerCase() == "hidden") {
            	tempString = name + "=" + encodeURIComponent(node.value)
            }
            if(node.type.toLowerCase() == "file") {
	
	            this.boundaryString = "AaB03x"
	            
				tempString = "--"+this.boundaryString + '\r\n' 
				+ 'Content-Disposition: form-data; name="archivo"; filename="' 
				+ node.value + '"' + '\r\n' 
				+ 'Content-Type: text/plain'
				+'\r\n'
				+'\r\n'
				+ "Hola como estas"
				+ '\r\n'
				+ "--"+this.boundaryString;
            }
       	}
        else
        	if(node.tagName.toLowerCase() == "select") {
                tempString = getSelectedOptions(node)
            }
            else
            	if(node.tagName.toLowerCase() == "textarea") {
                	tempString = name + "=" + node.value
            	}

        if(tempString != "") {
        	if(qs == "") {
            	qs = tempString
            }
            else {
            	qs = qs + "&" + tempString
            }
        }
    }

    return qs
}

//recorre los elementos de un select
function getSelectedOptions(select) {

	var options = select.options
    var option = null
    var qs = ""
    var tempString = ""

    for(var x = 0; x < options.length; x++) {
    
	    tempString = ""
        option = options[x]

        if(option.selected) {
        	tempString = select.name + "=" + option.value
        }

        if(tempString != "") {
	        if(qs == "") {
            	qs = tempString
            }
            else {
            	qs = qs + "&" + tempString
            }
        }
    }

    return qs
}