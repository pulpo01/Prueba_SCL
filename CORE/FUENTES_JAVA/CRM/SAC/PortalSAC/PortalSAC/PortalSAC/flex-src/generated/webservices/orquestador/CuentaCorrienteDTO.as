/**
 * CuentaCorrienteDTO.as
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
    
	public class CuentaCorrienteDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CuentaCorrienteDTO() {}
            
		public var acumNetoGrav:Number;
		public var codCliente:Number;
		public var codTipDocumento:Number;
		public var desTipDocumento:String;
		public var importeDebe:Number;
		public var importeHaber:Number;
		public var numAbonado:Number;
	}
}