/**
 * FacturaDTO.as
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
    
	public class FacturaDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function FacturaDTO() {}
            
		public var acumIva:Number;
		public var codCiclo:Number;
		public var desTipDocumento:String;
		public var fecEmision:String;
		public var fecEmisionOrd:String;
		public var fecVencimiento:String;
		public var fecVencimientoOrd:String;
		public var numFolio:Number;
		public var totFactura:Number;
	}
}