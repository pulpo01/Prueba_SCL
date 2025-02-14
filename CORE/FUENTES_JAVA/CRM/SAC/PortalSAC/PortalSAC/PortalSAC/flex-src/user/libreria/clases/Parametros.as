package user.libreria.clases
{
	import flash.utils.Dictionary;
		
	public class Parametros
	{
		// ------------------------------------------------------------------------------------------		
		public static function cargaParametros(s:String):Dictionary	{
			
			var aParams:Dictionary = new Dictionary();
	
			// Remove everything before the question mark, including
			// the question mark.
	        var myPattern:RegExp = /.*\?/;  
	        s = s.replace(myPattern, "")			
	   
			// Create an Array of name=value Strings.
			var params:Array;
			params = s.split("&");			
		   
		   var clave:Object = new Object();
		   for (var fila:int = 0; fila<params.length; fila++)	{
		   		var tempA:Array = params[fila].split("="); 
		   		aParams[tempA[0]] = tempA[1];
		   } // for
			
		   return aParams;
			
		} // cargaParametros
		
	} // cargaParametros
	
	// ------------------------------------------------------------------------------------------
}