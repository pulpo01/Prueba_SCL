package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarParametros" package = "GE_INT_LEO_PG" sp = "GE_CONSGEDPARAMETRO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarParametros"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsParametrosDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsParametrosResponseDTO"
* comentario = "Retorna el campo Valor Parámetro de la tabla GED_PARAMETROS"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsParametrosDTO" mappingProperty = "nomParametro" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsParametrosDTO" mappingProperty = "codModulo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsParametrosDTO" mappingProperty = "codProducto" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsParametrosResponseDTO" mappingProperty = "valParametro" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*/ 


public class ConsParametrosDTO  implements Serializable {

	private static final long serialVersionUID = 1L;

	private String nomParametro;
	private String codModulo;
	private int codProducto;
	
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getNomParametro() {
		return nomParametro;
	}
	public void setNomParametro(String nomParametro) {
		this.nomParametro = nomParametro;
	}


}