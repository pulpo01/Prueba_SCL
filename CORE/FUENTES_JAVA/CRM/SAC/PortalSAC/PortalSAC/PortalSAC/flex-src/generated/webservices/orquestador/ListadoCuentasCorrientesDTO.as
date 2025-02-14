/**
 * ListadoCuentasCorrientesDTO.as
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
    
	public class ListadoCuentasCorrientesDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function ListadoCuentasCorrientesDTO() {}
            
		[ArrayElementType("CuentaCorrienteDTO")]
		public var arrayCarteras:Array;
		public var codError:String;
		public var desError:String;
	}
}