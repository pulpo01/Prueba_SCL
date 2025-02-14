/**
 * EjecucionAjusteCReversionCargosSACDTO.as
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
    
	public class EjecucionAjusteCReversionCargosSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function EjecucionAjusteCReversionCargosSACDTO() {}
            
		[ArrayElementType("DetalleAjusteSACVO")]
		public var arrayDetalleAjusteSACVO:Array;
		public var codCauPago:Number;
		public var codError:String;
		public var codND:Number;
		public var codOriPago:Number;
		public var desError:String;
		public var desND:String;
		public var fecVencimiento:String;
		public var montoTotalAjuste:Number;
		public var nomUsuarioSCL:String;
		public var nroOOSS:Number;
		public var numTransaccion:String;
		public var observacion:String;
		public var tipoAjuste:Number;
	}
}