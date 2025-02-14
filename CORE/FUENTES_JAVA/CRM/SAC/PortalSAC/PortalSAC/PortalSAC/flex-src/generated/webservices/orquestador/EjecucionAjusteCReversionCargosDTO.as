/**
 * EjecucionAjusteCReversionCargosDTO.as
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
    
	public class EjecucionAjusteCReversionCargosDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function EjecucionAjusteCReversionCargosDTO() {}
            
		[ArrayElementType("DetalleAjusteVO")]
		public var arrayDetalleAjusteVO:Array;
		public var codCauPago:Number;
		public var codND:Number;
		public var codOriPago:Number;
		public var desND:String;
		public var fecVencimiento:String;
		public var montoTotalAjuste:Number;
		public var observacion:String;
		public var tipoAjuste:Number;
	}
}