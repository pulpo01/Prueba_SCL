/**
 * CargaServicioCargosDTO.as
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
    
	public class CargaServicioCargosDTO extends generated.webservices.orquestador.OOSSDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function CargaServicioCargosDTO() {}
            
		[ArrayElementType("CargosVO")]
		public var arrayCargosVO:Array;
		public var codAntiSerie:Number;
		public var codArticulo:Number;
		public var codArticuloSim:Number;
		public var codEstadoSim:Number;
		public var codModVenta:Number;
		public var codStockSim:Number;
		public var codUsoLineaSim:Number;
		public var indCreaDto:Number;
		public var indFacturaCiclo:String;
		public var indModCargos:Number;
		public var indModDtos:Number;
		public var numAbonado:Number;
		public var pntDtoInf:Number;
		public var pntDtoSup:Number;
		public var prcCargInf:Number;
		public var prcDtoInf:Number;
		public var prcDtoSup:Number;
		public var prcNewDtoSup:Number;
		public var prcNewDtoinf:Number;
		public var prccargSup:Number;
		public var ventaSimCard:Boolean;
	}
}