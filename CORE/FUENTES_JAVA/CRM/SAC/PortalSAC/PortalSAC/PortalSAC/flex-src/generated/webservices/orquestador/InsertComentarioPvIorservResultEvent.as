/**
 * InsertComentarioPvIorservResultEvent.as
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
    
	public class InsertComentarioPvIorservResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var InsertComentarioPvIorserv_RESULT:String="InsertComentarioPvIorserv_result";
		/**
		 * Constructor for the new event type
		 */
		public function InsertComentarioPvIorservResultEvent()
		{
			super(InsertComentarioPvIorserv_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:ResulTransaccionDTO;
		public function get result():ResulTransaccionDTO
		{
			return _result;
		}

		public function set result(value:ResulTransaccionDTO):void
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