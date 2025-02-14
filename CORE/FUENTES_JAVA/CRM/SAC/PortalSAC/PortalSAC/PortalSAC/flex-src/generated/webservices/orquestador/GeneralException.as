/**
 * GeneralException.as
 * This file was auto-generated from WSDL by the Apache Axis2 generator modified by Adobe
 * Any change made to this file will be overwritten when the code is re-generated.
 */

package generated.webservices.orquestador
{
	import mx.utils.ObjectProxy;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
	/**
	 * Wrapper class for a operation required type
	 */
    
	public class GeneralException extends generated.webservices.orquestador.Exception
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function GeneralException() {}
            
		public var cause:Object;
		public var codigo:String;
		public var codigoEvento:Number;
		public var descripcionEvento:String;
		public var message:String;
		public var messageUser:String;
		public var trace:String;
		[ArrayElementType("Object")]
		public var traces:Array;
	}
}