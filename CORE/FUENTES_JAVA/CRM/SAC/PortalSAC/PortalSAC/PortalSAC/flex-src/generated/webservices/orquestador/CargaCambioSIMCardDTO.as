/**
 * CargaCambioSIMCardDTO.as
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
    
	public class CargaCambioSIMCardDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaCambioSIMCardDTO() {}
            
		[ArrayElementType("BloqueUsosVO")]
		public var arrayBloqueUsosVO:Array;
		[ArrayElementType("CausasCambioVO")]
		public var arrayCausasCambioVO:Array;
		[ArrayElementType("TiposContratosVO")]
		public var arrayTiposContratosVO:Array;
		[ArrayElementType("TiposTerminalesVO")]
		public var arrayTiposTerminalesVO:Array;
		public var codModVenta:String;
		public var codTec:String;
		public var desEquipo:String;
		public var desIndPropiedad:String;
		public var desModVenta:String;
		public var desProcedEqui:String;
		public var desTipTerminal:String;
		public var desUso:String;
		public var indProcedencia:String;
		public var nombreUsuario:String;
		public var numAbonado:Number;
		public var numSerie:String;
	}
}