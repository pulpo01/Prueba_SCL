/**
 * CargaCambioDatosBancariosDTO.as
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
    
	public class CargaCambioDatosBancariosDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaCambioDatosBancariosDTO() {}
            
		[ArrayElementType("BancosVO")]
		public var arrayBancosTarjetaVO:Array;
		[ArrayElementType("BancosVO")]
		public var arrayBancosVO:Array;
		[ArrayElementType("SistemaPagoVO")]
		public var arraySistemaPagoVO:Array;
		[ArrayElementType("TiposTarjetaVO")]
		public var arrayTiposTarjetaVO:Array;
	}
}