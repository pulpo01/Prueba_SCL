package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarFechaAlta" package = "GE_INTEGRACION_PG" sp = "GE_CONS_FECALTA_PREPAGO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarFechaAlta"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "AltaPrepagoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "AltaPrepagoResponseDTO"
* comentario = "Consulta la fecha de Alta de un numero ingresado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechaAlta"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "AltaPrepagoDTO"  mappingProperty = "numTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechaAlta" clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AltaPrepagoResponseDTO" mappingProperty = "fechaAlta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechaAlta" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechaAlta" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarFechaAlta" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 


public class AltaPrepagoResponseDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private Date fechaAlta;
	private RespuestaDTO respuesta;

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public Date getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}


}
