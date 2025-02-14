/**
 * CargaCambioNumFrecuentesSACDTO.as
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
    
	public class CargaCambioNumFrecuentesSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaCambioNumFrecuentesSACDTO() {}
            
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var arrayNumFrecuentesPlan:Array;
		[ArrayElementType("NumFrecuentesFirmaVO")]
		public var arrayNumFrecuentesSS:Array;
		[ArrayElementType("TipoNumFrecuenteFirmaVO")]
		public var arrayTipoNumFrecuentes:Array;
		public var cantRedFija:Number;
		public var cantRedFijaSS:Number;
		public var cantRedMovil:Number;
		public var cantRedMovilSS:Number;
		public var cantidadMaximoTotal:Number;
		public var cantidadMaximoTotalSS:Number;
		public var codCliente:Number;
		public var codError:String;
		public var codPlantarif:String;
		public var desError:String;
		public var desPlantarif:String;
		public var mensajeNumFrec:String;
		public var nomUsuarioSCL:String;
		public var nroOOSS:Number;
		public var numAbonado:Number;
		public var numCelular:Number;
		public var numTransaccion:String;
	}
}