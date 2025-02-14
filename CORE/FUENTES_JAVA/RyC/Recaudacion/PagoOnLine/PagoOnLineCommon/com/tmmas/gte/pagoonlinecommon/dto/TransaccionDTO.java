package com.tmmas.gte.pagoonlinecommon.dto;
/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "transaccion" package = "CO_PAGOSONLINE_PG" sp = "CO_OBTIENETRANSACCION_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerTransaccion"
* servicioPaqueteEntrada = ""
* servicioParametroEntrada = ""
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "TransaccionDTO"
* comentario = "Obtiene Secuencia para Numero de Transaccion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "transaccion" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "TransaccionDTO" mappingProperty = "numTransaccion" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "transaccion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "transaccion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "transaccion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
*
*/
public class TransaccionDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	
	private int numTransaccion;
	private RespuestaDTO respuesta;
	
	public int getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(int numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}

}
