/**
 * EjecucionCambioNumFrecuentesSACDTO.as
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
    
	public class EjecucionCambioNumFrecuentesSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function EjecucionCambioNumFrecuentesSACDTO() {}
            
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var bloqueNumFrecuentePlanTarifarioEliminar:Array;
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var bloqueNumFrecuentePlanTarifarioInsertar:Array;
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var bloqueNumFrecuenteServicioSuplementarioEliminar:Array;
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var bloqueNumFrecuenteServicioSuplementarioInsertar:Array;
		public var codError:String;
		public var comentario:String;
		public var desError:String;
		public var nomUsuarioSCL:String;
		public var nroOOSS:Number;
		public var numAbonado:Number;
		public var numTransaccion:String;
	}
}