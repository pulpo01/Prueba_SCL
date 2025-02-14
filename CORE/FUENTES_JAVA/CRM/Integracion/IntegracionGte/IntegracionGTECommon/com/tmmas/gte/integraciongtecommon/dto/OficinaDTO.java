package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarOficina" package = "GE_INTEGRACION_PG" sp = "GE_CONS_OFICINA_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarOficina"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "OficinaInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "OficinaDTO"
* comentario = "Ingresa como parametros un objeto de tipo OficinaInDTO y despues devuelve un objeto OficinaDTO, devuelve la codigo del oficina y la descipcion"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "OficinaInDTO"  mappingProperty = "numComPago" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "OficinaInDTO"  mappingProperty = "pRefPlaza" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "OficinaDTO" mappingProperty = "codOficina" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "OficinaDTO" mappingProperty = "desOficina" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarOficina" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
*/ 



public class OficinaDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private String codOficina;
	private String desOficina;
	private RespuestaDTO respuesta;

    public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getDesOficina() {
		return desOficina;
	}
	public void setDesOficina(String desOficina) {
		this.desOficina = desOficina;
	}
	
}