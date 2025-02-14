/**
 * CargaSuspensionSrvCelDTO.as
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
    
	public class CargaSuspensionSrvCelDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaSuspensionSrvCelDTO() {}
            
		[ArrayElementType("CausasSuspensionVO")]
		public var arrayCausasSuspensionVO:Array;
		[ArrayElementType("ServicioSuspensionVO")]
		public var arrayServicioSuspensionVO:Array;
		public var indBloqueoCausaSuspension:Number;
		public var nombreCliente:String;
		public var numAbonado:Number;
		public var numeroCelular:Number;
	}
}