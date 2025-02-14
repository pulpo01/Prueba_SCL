/**
 * GetDocsPagosClienteResultEvent.as
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
    
	public class GetDocsPagosClienteResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var GetDocsPagosCliente_RESULT:String="GetDocsPagosCliente_result";
		/**
		 * Constructor for the new event type
		 */
		public function GetDocsPagosClienteResultEvent()
		{
			super(GetDocsPagosCliente_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:ListadoDocCtaCteClienteDTO;
		public function get result():ListadoDocCtaCteClienteDTO
		{
			return _result;
		}

		public function set result(value:ListadoDocCtaCteClienteDTO):void
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