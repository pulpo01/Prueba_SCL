package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarGruposPrestacion" package = "VE_PARAMETROS_COMERCIALES_PG" sp = "VE_OBTIENE_GRUPOSPREST_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarGruposPrestacion"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsultarGruposPrestacionResponseDTO"
* comentario = "Entrega datos de los grupos de prestación existentes"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarGruposPrestacion" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsultarGruposPrestacionDTO" mappingProperty = "" parentProperty = "listadoPrestaciones"
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
*/

public class ConsultarGruposPrestacionDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	
	private String codValor;
	private String desValor;
	
	public String getCodValor() {
		return codValor;
	}
	public void setCodValor(String codValor) {
		this.codValor = codValor;
	}
	public String getDesValor() {
		return desValor;
	}
	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}
	
	
	
}
