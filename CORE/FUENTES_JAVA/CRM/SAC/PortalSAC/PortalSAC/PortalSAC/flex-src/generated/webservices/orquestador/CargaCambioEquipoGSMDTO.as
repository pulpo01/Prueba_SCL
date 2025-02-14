/**
 * CargaCambioEquipoGSMDTO.as
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
    
	public class CargaCambioEquipoGSMDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaCambioEquipoGSMDTO() {}
            
		[ArrayElementType("BloqueArticulosVO")]
		public var arrayBloqueArticulosVO:Array;
		[ArrayElementType("BloqueUsosVO")]
		public var arrayBloqueUsosVO:Array;
		[ArrayElementType("CausasCambioVO")]
		public var arrayCausasCambioVO:Array;
		public var codModVenta:String;
		public var desEquipo:String;
		public var desIndPropiedad:String;
		public var desModVenta:String;
		public var desProcedEqui:String;
		public var desTipContrato:String;
		public var desTipTerminal:String;
		public var desUso:String;
		public var nombreUsuario:String;
		public var numAbonado:Number;
		public var numCelular:Number;
		public var numSerie:String;
		public var numSerieMec:String;
	}
}