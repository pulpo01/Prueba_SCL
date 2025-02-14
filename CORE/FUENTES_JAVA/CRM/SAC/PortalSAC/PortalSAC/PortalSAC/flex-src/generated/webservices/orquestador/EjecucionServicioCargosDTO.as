/**
 * EjecucionServicioCargosDTO.as
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
    
	public class EjecucionServicioCargosDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function EjecucionServicioCargosDTO() {}
            
		[ArrayElementType("CargosVO")]
		public var arrayCargosVO:Array;
		public var codError:String;
		public var desError:String;
		public var factura:Boolean;
		public var indContado:Number;
		public var indCuota:Number;
		public var mesGarantia:Number;
		public var nomUsuaSupervisor:String;
		public var nomUsuarioSCL:String;
		public var numCargo:Number;
		public var numTransaccion:String;
		public var passwordSupervisor:String;
		public var tipPantalla:Number;
	}
}