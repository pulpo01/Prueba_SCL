package user.libreria.clases
{
	
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;
	
	public class Utilidades
	{
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 11/11/08
		// ------------------------------------------------------------------------------------------

		[Embed(source="/recursosInterfaz/imagenes/iconos/alert/warning.png")]
	    static public var iconWarning:Class; 		

		static public function buscarElementoEnXML(xmlDoc:XML, elemento:String):String	{
		
			var strBody:String = xmlDoc.toString();
            var strSearch:String = new String(elemento + ">");
                	
        	var pos:Number = strBody.search(strSearch);
        	if (pos < 0) return "";
        	var begin:Number = pos+strSearch.length;
        	var end:Number = strBody.indexOf("</",begin);
        	var resultado:String = new String(strBody.substr(begin,end-begin));
        	
        	return resultado;
                				
			
		}  // buscarElementoEnXML
		
		
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 2.0
		// Fecha : 13/04/09
		// ------------------------------------------------------------------------------------------
		
		static public function fillArrayCollection(result:*, obj:*):ArrayCollection	{
			
			var descriptionXml: XML = describeType( obj );
			var atributos:Array = new Array();
			for each (var atrib:String in descriptionXml..variable.@name)	{
				atributos.push(atrib);
			}
		
			var acTemp:ArrayCollection = new ArrayCollection();				
		
			for each( var node:XML in result.elements() )	{
				var dto:Object = new Object();
				for (var i:Number=0; i < atributos.length; i++)
			    	dto[atributos[i]] = node[atributos[i]]; 
				acTemp.addItem(dto);
			} // for each
			
			return acTemp;
				
		} // fillArrayCollection

		static public function trim(str:String):String {
		    return str.replace(/^\s*(.*?)\s*$/g, "$1");
		} // trim
		
		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 13/09/09
		// ------------------------------------------------------------------------------------------
		// Este metodo extrae de arrays complejos los datos para el dataprovider de un combobox
		// ------------------------------------------------------------------------------------------
		static public function creaOpcionesCombobox(opciones:Array, campoData:String, campoLabel:String):Array {
		    
		    var resultado:Array = new Array();
		    var obj:Object;
			for (var indice:int = 0; indice < opciones.length; indice++)       {
				obj = new Object();
				obj.label = opciones[indice][campoLabel].toString();
		        obj.data = opciones[indice][campoData].toString();
		        resultado.push(obj);
		    } // for		  
		      
		    return resultado;
		     
		} // creaOpcionesCombobox

		// ------------------------------------------------------------------------------------------
		// Autor : Gabriel Galetti
		// Version : 1.0
		// Fecha : 13/09/09
		// ------------------------------------------------------------------------------------------
		// Este metodo calcula el total de una columna de un arraycollection
		// ------------------------------------------------------------------------------------------
		static public function sumColArray(a:Array, campo:String):Number {
		    
		    var total:Number = 0;
			for (var fila:Number=0; fila < a.length; fila++) total=total+a[fila][campo];
		    return total;
		     
		} // sumColArray

	}	 // class
	
} // package