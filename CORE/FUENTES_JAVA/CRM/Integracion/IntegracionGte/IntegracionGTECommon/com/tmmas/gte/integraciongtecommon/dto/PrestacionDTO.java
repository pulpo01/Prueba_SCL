package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarGruposPrestacion" package = "VE_PARAMETROS_COMERCIALES_PG" sp = "VE_OBTIENE_GRUPOSPREST_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarGruposPrestacion"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "PrestacionResponseDTO"
* comentario = "Entrega datos de los grupos de prestaci�n existentes"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarGruposPrestacion" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "PrestacionInDTO" mappingProperty = "" parentProperty = "listadoPrestaciones"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarGruposPrestacion" name="CURSOROUT" mappingProperty = "codValor" mappingField = "cod_valor"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarGruposPrestacion" name="CURSOROUT" mappingProperty = "desValor" mappingField = "des_valor" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarGruposPrestacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarGruposPrestacion" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarGruposPrestacion" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarTipoServicio" package = "GE_INTEGRACION_PG" sp = "GE_CONSTIPSERV_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarTipoServicio"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "CodPrestacionDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "TipoServicioResponseDTO"
* comentario = "Servicio que permite consultar la descripci�n de la prestaci�n asociada a un n�mero de tel�fono"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoServicio" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "CodPrestacionDTO" mappingProperty = "codPrestacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoServicio" clase="salida" name="" tipo="VARCHAR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "TipoServicioResponseDTO" mappingProperty = "desPrestacion" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoServicio" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoServicio" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoServicio" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/

public class PrestacionDTO implements Serializable {
	/**
	 * Autor : Leonardo Mu�oz R.
	 */
	private static final long serialVersionUID = 1L;
}
