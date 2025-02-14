/**
 * MenuDTO.as
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
    
	public class MenuDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function MenuDTO() {}
            
		[ArrayElementType("OOSSXAbonadoDTO")]
		public var arrayOOSSXAbonado:Array;
		[ArrayElementType("OOSSXClienteDTO")]
		public var arrayOOSSXCliente:Array;
		[ArrayElementType("OOSSXCuentaDTO")]
		public var arrayOOSSXCuenta:Array;
		[ArrayElementType("OOSSXUsuarioDTO")]
		public var arrayOOSSXUsuario:Array;
		public var codError:String;
		public var codUsuario:String;
		public var desError:String;
		public var nombreOperador:String;
		public var oficina:String;
	}
}