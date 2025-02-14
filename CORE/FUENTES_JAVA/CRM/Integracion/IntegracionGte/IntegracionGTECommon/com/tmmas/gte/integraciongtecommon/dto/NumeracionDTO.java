package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultaNumeracion" package = "GE_INTEGRACION_PG" sp = "GE_VALNUMTELEFONICA_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultaNumeracion"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "NumeroTelefonoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespBooleanDTO"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaNumeracion" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "NumeroTelefonoDTO" mappingProperty = "numeroTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaNumeracion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaNumeracion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultaNumeracion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

public class NumeracionDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
    private RespuestaDTO respuesta;
	
    public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
