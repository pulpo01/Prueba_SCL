/**
 * CambiosPlanAbonadoPrepagoResultEvent.as
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
    
	public class CambiosPlanAbonadoPrepagoResultEvent extends Event
	{
		/**
		 * The event type value
		 */
		public static var CambiosPlanAbonadoPrepago_RESULT:String="CambiosPlanAbonadoPrepago_result";
		/**
		 * Constructor for the new event type
		 */
		public function CambiosPlanAbonadoPrepagoResultEvent()
		{
			super(CambiosPlanAbonadoPrepago_RESULT,false,false);
		}
        
		private var _headers:Object;
		private var _result:ListadoCambiosPlanTarifDTO;
		public function get result():ListadoCambiosPlanTarifDTO
		{
			return _result;
		}

		public function set result(value:ListadoCambiosPlanTarifDTO):void
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