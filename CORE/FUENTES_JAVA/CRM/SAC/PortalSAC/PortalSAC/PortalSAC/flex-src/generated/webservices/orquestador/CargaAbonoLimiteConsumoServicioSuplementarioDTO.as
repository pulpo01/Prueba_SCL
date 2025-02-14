/**
 * CargaAbonoLimiteConsumoServicioSuplementarioDTO.as
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
    
	public class CargaAbonoLimiteConsumoServicioSuplementarioDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaAbonoLimiteConsumoServicioSuplementarioDTO() {}
            
		[ArrayElementType("AbonoLimiteConsumoServicioSuplementarioVO")]
		public var arrayAbonoLimiteConsumoServicioSuplementarioVOs:Array;
		public var codCliente:Number;
		public var codPlanTarif:String;
		public var codSujeto:Number;
		public var desCodPlanTarif:String;
		public var key:Number;
		public var nombreCliente:String;
		public var numCelular:Number;
		public var tipoOOSS:String;
	}
}