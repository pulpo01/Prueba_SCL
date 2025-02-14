/**
 * CargaAjusteCReversionCargosSACDTO.as
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
    
	public class CargaAjusteCReversionCargosSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaAjusteCReversionCargosSACDTO() {}
            
		[ArrayElementType("CausasPagoVO")]
		public var arrayCausasPagoVO:Array;
		[ArrayElementType("FoliosFacturasSACVO")]
		public var arrayFoliosFacturasVO:Array;
		[ArrayElementType("NotaDebitoVO")]
		public var arrayNotaDebitoVO:Array;
		[ArrayElementType("OrigenPagoVO")]
		public var arrayOrigenPagoVO:Array;
		public var codCliente:Number;
		public var codError:String;
		public var desError:String;
		public var nomUsuarioSCL:String;
		public var nombreCliente:String;
		public var nroOOSS:Number;
		public var numTransaccion:String;
		public var password:String;
		public var saldoCliente:Number;
	}
}