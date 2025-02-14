package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

/**
 * @tmas.legacy.jdbc.storedprocedure id = "consultarTerminal" package = "GE_INTEGRACION_PG" sp = "GE_CONS_EQUIPO_PR"
 * jndiProperty = "IntegracionGteSclDs"
 * servicioMetodo = "consultarTerminal"
 * servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroEntrada = "EquipoDTO"
 * servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroSalida = "EquipoResponseDTO"
 * comentario = "Permite obtener características y datos de un equipo."
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="entrada" name="" tipo=""
 * mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "EquipoDTO" mappingProperty = "numSerie" parentProperty = ""
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="salida" name="" tipo="VARCHAR"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "EquipoDTO" mappingProperty = "descEquipo" parentProperty = "equipo"
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="salida" name="" tipo="NUMERIC"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "EquipoDTO" mappingProperty = "codArticulo" parentProperty = "equipo"
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTerminal" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
 */ 

public class EquipoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String numSerie;
	private String descEquipo;
	private long codArticulo;
	
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getDescEquipo() {
		return descEquipo;
	}
	public void setDescEquipo(String descEquipo) {
		this.descEquipo = descEquipo;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}

	
}