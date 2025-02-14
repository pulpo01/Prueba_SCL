/**
 * EjecutarCambioEquipoGSMResultEvent.as
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
    
	public class EjecutarCambioEquipoGSMResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var EjecutarCambioEquipoGSM_RESULT:String="EjecutarCambioEquipoGSM_result";
		/**
		 * Constructor for the new event type
		 */
		public function EjecutarCambioEquipoGSMResultEvent()
		{
			super(EjecutarCambioEquipoGSM_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:EjecucionCambioEquipoGSMDTO;
		public function get result():EjecucionCambioEquipoGSMDTO
		{
			return _result;
		}

		public function set result(value:EjecucionCambioEquipoGSMDTO):void
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