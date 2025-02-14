/**
 * ProductoDTO.as
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
    
	public class ProductoDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function ProductoDTO() {}
            
		public var codConcepto:String;
		public var codProducto:String;
		public var desProducto:String;
		public var estadoAltBaj:String;
		public var fecBajaBD:String;
		public var fecBajaCentral:String;
		public var fechAltaBD:String;
		public var fechAltaCentral:String;
		public var importeCargoBasico:String;
		public var textoDetalle:String;
	}
}