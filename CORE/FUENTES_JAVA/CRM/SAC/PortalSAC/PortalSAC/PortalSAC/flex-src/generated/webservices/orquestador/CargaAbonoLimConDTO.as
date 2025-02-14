/**
 * CargaAbonoLimConDTO.as
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
    
	public class CargaAbonoLimConDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaAbonoLimConDTO() {}
            
		public var codLimCon:String;
		public var codSujeto:Number;
		public var codUmbral:String;
		public var desLimCon:String;
		public var desUmbral:String;
		public var montoLimCon:Number;
		public var nivelConsumo:String;
		public var nombreCliente:String;
		public var numTerminal:String;
		public var tipoAbono:String;
	}
}