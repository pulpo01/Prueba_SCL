/**
 * EjecucionCambioDatosClienteSACDTO.as
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
    
	public class EjecucionCambioDatosClienteSACDTO
	{
		/**
		 * Constructor, initializes the type class
		 */
		public function EjecucionCambioDatosClienteSACDTO() {}
            
		public var codError:String;
		public var comentario:String;
		public var desError:String;
		public var ejecucionCambioDatosBancariosDTO:generated.webservices.orquestador.EjecucionCambioDatosBancariosDTO;
		public var ejecucionCambioDatosGeneralesClienteDTO:generated.webservices.orquestador.EjecucionCambioDatosGeneralesClienteDTO;
		public var ejecucionCambioDatosIdentificacionClienteDTO:generated.webservices.orquestador.EjecucionCambioDatosIdentificacionClienteDTO;
		public var ejecucionCambioDatosPersonalesClienteDTO:generated.webservices.orquestador.EjecucionCambioDatosPersonalesClienteDTO;
		public var ejecucionCambioDatosTributariosClienteDTO:generated.webservices.orquestador.EjecucionCambioDatosTributariosClienteDTO;
		public var nomUsuarioSCL:String;
		public var nroOOSS:Number;
		public var numTransaccion:String;
	}
}