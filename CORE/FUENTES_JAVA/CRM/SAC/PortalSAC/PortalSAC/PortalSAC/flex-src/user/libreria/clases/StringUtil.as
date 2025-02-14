package user.libreria.clases
{
	import mx.collections.ArrayCollection;
	import mx.core.Application;
	
	public class StringUtil
	{
		static public function trim(str:String):String {
		    return str.replace(/^\s*(.*?)\s*$/g, "$1");
		} // trim
		
		static public function nulo2String(dato:*):String	{
			
			var cadena:String = dato;
			if ((cadena != null) && (cadena != "null")) return cadena;
			else
				return "";
			
		} // nulo2String


		// --------------------------------------------------------------------------------
		
		static public function loadProperties(file:String):ArrayCollection	{
	
			// Create an Array of name=value Strings.
			var vecPropiedades:Array = file.split("\n");
			var vecCampos:Array;
			var campos:String;
			var acProperties:ArrayCollection = new ArrayCollection();
	
			for (var i:int=0; i < vecPropiedades.length; i++)	{
				campos = vecPropiedades[i];
				vecCampos = campos.split(":=");
				if (vecCampos.length > 1)	{
					var valor:String = vecCampos[1];
					valor = valor.replace("\r", "");
					acProperties.addItem([{nombre:vecCampos[0], valor:valor}]);
				} // if
			}	// for
	
			return acProperties;
		} // loadProperties		
				
		// --------------------------------------------------------------------------------
	
		static public function getPort(url:String):String	{
		
			// posicion segundo :
			var pos1:int=url.indexOf(":", 6);
			// posicion / despues del :
			var pos2:int=url.indexOf("/", pos1);
			
			if (pos1>=0 && pos2>=0)
				var port:String = url.substring(pos1+1, pos2);
			else
				return "";
				
			return port;
			
		} // getValor
			
		// --------------------------------------------------------------------------------
		
		static public function getValor(property:String, valor:*):String	{

			var nodo:XMLList = null;

			// Busco en el config de http services
			nodo = new XMLList(Application.application.xmlConfig.PROPERTY.(CODIGO==property));
			if (nodo.toString() != "")
				return nodo[0][valor];
			
			// Busco en el config de OOSS
			nodo = new XMLList(Application.application.xmlConfigOOSS.OOSS.(CODIGO==property));
			if (nodo.toString() != "")
				return nodo[0][valor];
			
			// Busco en el config de http services
			nodo = new XMLList(Application.application.xmlConfigHttpServices.SERVICE.(CODIGO==property));
			if (nodo.toString() != "")
				return nodo[0][valor];
				
			// Busco en el config de consultas
			nodo = new XMLList(Application.application.xmlConfigConsultas.CONSULTA.(COD_PROCESO==property));
			if (nodo.toString() != "")
				return nodo[0][valor];
				
			return "";
		} // getValor
	

		// --------------------------------------------------------------------------------
		// Busca el codigo de errores y para ver si es invalidandte o no
		static public function errorWSNoInvalidante(codError:String):Boolean	{
			
			var errores:Array = new Array();
			errores = getValor("codigosErrorNoCerrarPantalla","VALOR").split(";");
			
			for (var fila:Number=0; fila < errores.length; fila++)
				if (errores[fila] == codError) return true;
			
			return false;
			
		} // errorWSNoInvalidante
	
	} // class StringUtil		
}