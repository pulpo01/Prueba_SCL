/**
 * FiltroDetDocAjusteCCargosSACDTO.as
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
    
	public class FiltroDetDocAjusteCCargosSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function FiltroDetDocAjusteCCargosSACDTO() {}
            
		[ArrayElementType("DetalleDocumentoSACVO")]
		public var arrayDetalleDocumentoVO:Array;
		public var codCentrEmi:Number;
		public var codError:String;
		public var codTipDocum:Number;
		public var codVendedor:Number;
		public var desError:String;
		public var letra:String;
		public var nomUsuarioSCL:String;
		public var nroOOSS:Number;
		public var nroSecuencia:Number;
		public var numTransaccion:String;
	}
}