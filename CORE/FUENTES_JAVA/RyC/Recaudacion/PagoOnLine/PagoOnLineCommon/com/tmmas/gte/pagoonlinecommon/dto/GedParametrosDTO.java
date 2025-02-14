package com.tmmas.gte.pagoonlinecommon.dto;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "parametro" package = "CO_PAGOSONLINE_PG" sp = "CO_OBTIENE_PARAMETRO_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerParametro"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "GedParametrosDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "GedParametrosDTO"
* comentario = "Obtiene Valor de un parametro en la GED_PARAMETROS"
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "GedParametrosDTO" mappingProperty = "codModulo" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "GedParametrosDTO" mappingProperty = "codProducto" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "GedParametrosDTO" mappingProperty = "nomParametro" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "GedParametrosDTO" mappingProperty = "valParametro" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "parametro" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
*
*/

public class GedParametrosDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String codModulo;
	private int codProducto;
	private String nomParametro;
	private String valParametro;
	private RespuestaDTO respuesta;
	
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
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getValParametro() {
		return valParametro;
	}
	public void setValParametro(String valParametro) {
		this.valParametro = valParametro;
	}

}
