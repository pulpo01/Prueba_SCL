package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
/**
 * @tmas.legacy.jdbc.storedprocedure id = "consultarActividad" package = "GE_INTEGRACION_PG" sp = "GE_CONS_PROFESION_PR"
 * jndiProperty = "IntegracionGteSclDs"
 * servicioMetodo = "consultarActividad"
 * servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroEntrada = "ActividadDTO"
 * servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroSalida = "ActividadResponseDTO"
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarActividad" clase="entrada" name="" tipo=""
 * mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActividadDTO" mappingProperty = "codActividad" parentProperty = ""
 *  
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarActividad" clase="salida" name="" tipo="VARCHAR"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ActividadResponseDTO" mappingProperty = "desActividad" parentProperty = ""
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarActividad" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarActividad" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarActividad" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
 *
 * 
 * @tmas.legacy.jdbc.storedprocedure id = "consultarOcupacion" package = "GE_INTEGRACION_PG" sp = "GE_CONS_OCUPACION_PR"
 * jndiProperty = "IntegracionGteSclDs"
 * servicioMetodo = "consultarOcupacion"
 * servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroEntrada = "ActividadDTO"
 * servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroSalida = "ActividadResponseDTO"
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOcupacion" clase="entrada" name="" tipo=""
 * mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ActividadDTO" mappingProperty = "codOcupacion" parentProperty = ""
 *  
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOcupacion" clase="salida" name="" tipo="VARCHAR"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ActividadResponseDTO" mappingProperty = "desActividad" parentProperty = ""
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOcupacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOcupacion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOcupacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"

 */ 

public class ActividadDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codActividad;
	private String codOcupacion;
	private String desActividad;
	
	public long getCodActividad() {
		return codActividad;
	}
	public void setCodActividad(long codActividad) {
		this.codActividad = codActividad;
	}
	public String getDesActividad() {
		return desActividad;
	}
	public void setDesActividad(String desActividad) {
		this.desActividad = desActividad;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodOcupacion() {
		return codOcupacion;
	}
	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}

}