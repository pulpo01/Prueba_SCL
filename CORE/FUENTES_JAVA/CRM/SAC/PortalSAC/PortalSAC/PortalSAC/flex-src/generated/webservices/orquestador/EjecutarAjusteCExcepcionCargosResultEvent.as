/**
 * EjecutarAjusteCExcepcionCargosResultEvent.as
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
    
	public class EjecutarAjusteCExcepcionCargosResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var EjecutarAjusteCExcepcionCargos_RESULT:String="EjecutarAjusteCExcepcionCargos_result";
		/**
		 * Constructor for the new event type
		 */
		public function EjecutarAjusteCExcepcionCargosResultEvent()
		{
			super(EjecutarAjusteCExcepcionCargos_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:EjecucionAjusteCExcepcionCargosDTO;
		public function get result():EjecucionAjusteCExcepcionCargosDTO
		{
			return _result;
		}

		public function set result(value:EjecucionAjusteCExcepcionCargosDTO):void
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