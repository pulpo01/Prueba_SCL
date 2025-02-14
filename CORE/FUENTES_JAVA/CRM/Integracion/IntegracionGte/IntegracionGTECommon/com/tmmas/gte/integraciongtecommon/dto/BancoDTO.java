package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarBanco" package = "GE_INTEGRACION_PG" sp = "GE_CONS_BANCO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarBanco"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "BancoInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "BancoDTO"
* comentario = "Ingresa como parametros un objeto de tipo BancoInDTO y despues devuelve un objeto BancoDTO, devuelve la codigo del banco y la descipcion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "BancoInDTO"  mappingProperty = "codBanco" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BancoDTO" mappingProperty = "codBanco" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BancoDTO" mappingProperty = "descripcion" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBanco" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarBancosDisponibles" package = "VE_ALTA_CLIENTE_PG" sp = "VE_GETLISTBANCOSPAC_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarBancosDisponibles"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "BancoDispInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "BancoResponseDTO"
* comentario = "Entrega datos de los bancos disponibles para la contratación de PAC"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBancosDisponibles" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "BancoDispInDTO"  mappingProperty = "indPac" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBancosDisponibles" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "BancoOutDTO" mappingProperty = "" parentProperty = "listadoBancos"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarBancosDisponibles" name="CURSOROUT" mappingProperty = "codBanco" mappingField = "cod_banco"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarBancosDisponibles" name="CURSOROUT" mappingProperty = "descripcion" mappingField = "des_banco"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBancosDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBancosDisponibles" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarBancosDisponibles" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

public class BancoDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private String codBanco;
	private String descripcion;
	private RespuestaDTO respuesta;

    public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getCodBanco() {
		return codBanco;
	}

	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}

	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}