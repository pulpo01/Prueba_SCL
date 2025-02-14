package com.tmmas.gte.pagoonlinecommon.dto;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "validacionPagoaReversar" package = "CO_PAGOSONLINE_PG" sp = "CO_VALIDA_DATOSPAGO_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "validaReversa"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "InterfazReversaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Valida que el Pago a reversar exista (CO_INTERFAZ_PAGOS)"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "numTransaccion" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "codCliente" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "codBanco" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "fecPago" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "horPago" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "mtoPago" parentProperty = ""
*
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validacionPagoaReversar" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "aplicarReversa" package = "CO_PAGOSONLINE_PG" sp = "CO_DESAPLICA_PAGO_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "aplicaReversa"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "InterfazReversaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Inserta Reversa en la Interfaz de Pago (CO_INTERFAZ_PAGOS)"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "aplicarReversa" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "InterfazReversaDTO" mappingProperty = "numTransaccion" parentProperty = ""
*
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "aplicarReversa" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "aplicarReversa" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "aplicarReversa" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
*
*/

public class InterfazReversaDTO implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private int numTransaccion;
	private long codCliente;
	private String codBanco;
	private String fecPago;
	private String horPago;
	private double mtoPago;
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getFecPago() {
		return fecPago;
	}
	public void setFecPago(String fecPago) {
		this.fecPago = fecPago;
	}
	public String getHorPago() {
		return horPago;
	}
	public void setHorPago(String horPago) {
		this.horPago = horPago;
	}
	public double getMtoPago() {
		return mtoPago;
	}
	public void setMtoPago(double mtoPago) {
		this.mtoPago = mtoPago;
	}
	public int getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(int numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	
}
