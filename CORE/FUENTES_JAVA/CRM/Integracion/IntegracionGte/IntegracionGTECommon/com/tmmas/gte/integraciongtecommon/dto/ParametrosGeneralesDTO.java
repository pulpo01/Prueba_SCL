package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarParametros" package = "GE_INTEGRACION_PG" sp = "GE_CONSGEDPARAMETRO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarParametros"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ParametrosGeneralesDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ParametrosGeneralesResponseDTO"
* comentario = "Retorna el campo Valor Parámetro de la tabla GED_PARAMETROS"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ParametrosGeneralesDTO" mappingProperty = "nomParametro" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ParametrosGeneralesDTO" mappingProperty = "codModulo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ParametrosGeneralesDTO" mappingProperty = "codProducto" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ParametrosGeneralesResponseDTO" mappingProperty = "valParametro" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarParametros" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
*  
* @tmas.legacy.jdbc.storedprocedure id = "consultarSecuencia" package = "GE_INTEGRACION_PG" sp = "ge_cons_num_sec_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarSecuencia"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "SecuenciaDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "SecuenciaDTO"
* comentario = "Entrega numero Secuencia"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSecuencia"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "SecuenciaDTO" mappingProperty = "nomSecuencia" parentProperty = ""

* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSecuencia"   clase="salida" name="CURSOROUT" tipo="NUMERIC"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SecuenciaDTO" mappingProperty = "numSecuencia" parentProperty = ""
*   
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSecuencia" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSecuencia" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSecuencia" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento" 
* 
* 
*/ 


public class ParametrosGeneralesDTO  implements Serializable {

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