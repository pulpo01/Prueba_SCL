/**
 * LimiteConsumoXClienteAbonadoResultEvent.as
 * This file was auto-generated from WSDL
 * Any change made to this file will be overwritten when the code is re-generated.
*/
package generated.webservices.orquestador
{
	import mx.utils.ObjectProxy;
	import flash.events.Event;
	import flash.utils.ByteArray;
	import mx.rpc.soap.types.*;
	/**
	 * Typed event handler for the result of the operation
	 */
    
	public class LimiteConsumoXClienteAbonadoResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var LimiteConsumoXClienteAbonado_RESULT:String="LimiteConsumoXClienteAbonado_result";
		/**
		 * Constructor for the new event type
		 */
		public function LimiteConsumoXClienteAbonadoResultEvent()
		{
			super(LimiteConsumoXClienteAbonado_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:ListadoLimiteConsumoDTO;
		public function get result():ListadoLimiteConsumoDTO
		{
			return _result;
		}

		public function set result(value:ListadoLimiteConsumoDTO):void
		{
			_result = value;
		}

		public function get headers():Object
		{
			return _headers;
		}

		public function set headers(value:Object):void
		{
			_headers = value;
		}
	}
}