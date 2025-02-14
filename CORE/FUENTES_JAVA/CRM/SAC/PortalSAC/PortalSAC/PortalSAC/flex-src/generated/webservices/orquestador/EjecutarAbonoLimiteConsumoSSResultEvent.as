/**
 * EjecutarAbonoLimiteConsumoSSResultEvent.as
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
    
	public class EjecutarAbonoLimiteConsumoSSResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var EjecutarAbonoLimiteConsumoSS_RESULT:String="EjecutarAbonoLimiteConsumoSS_result";
		/**
		 * Constructor for the new event type
		 */
		public function EjecutarAbonoLimiteConsumoSSResultEvent()
		{
			super(EjecutarAbonoLimiteConsumoSS_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO;
		public function get result():EjecucionAbonoLimiteConsumoServicioSuplementarioDTO
		{
			return _result;
		}

		public function set result(value:EjecucionAbonoLimiteConsumoServicioSuplementarioDTO):void
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