package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
/**
 * @tmas.legacy.jdbc.storedprocedure id = "consultarTipoIdent" package = "GE_INTEGRACION_PG" sp = "GE_CONS_TIPOS_IDENT_PR"
 * jndiProperty = "IntegracionGteSclDs"
 * servicioMetodo = "consultarTipoIdent"
 * servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroEntrada = "IdentificacionDTO"
 * servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
 * servicioParametroSalida = "IdentificacionResponseDTO"
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoIdent" clase="entrada" name="" tipo=""
 * mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "IdentificacionDTO" mappingProperty = "codTipIdent" parentProperty = ""
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoIdent" clase="salida" name="" tipo="VARCHAR"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "IdentificacionResponseDTO" mappingProperty = "desIdentificacion" parentProperty = ""
 * 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoIdent" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoIdent" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
 * @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarTipoIdent" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
 * mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
 */ 

public class IdentificacionDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codTipIdent;
	private String descTipIdent;
	
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getDescTipIdent() {
		return descTipIdent;
	}
	public void setDescTipIdent(String descTipIdent) {
		this.descTipIdent = descTipIdent;
	}
	
}