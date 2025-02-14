/**
 * CargaCambioPlanPostPagoIndividualDTO.as
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
    
	public class CargaCambioPlanPostPagoIndividualDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaCambioPlanPostPagoIndividualDTO() {}
            
		public var aplicaNumeroFrecuente:Number;
		[ArrayElementType("PlanTarifarioVO")]
		public var arrayPlanTarifarioVO:Array;
		public var desCargoBasico:String;
		public var desCargoBasicoProxCiclo:String;
		public var desLimConActual:String;
		public var desLimConProximo:String;
		public var desPlanTarif:String;
		public var desPlanTarifProxCiclo:String;
		public var numAbonado:Number;
		public var numeroCelular:Number;
	}
}