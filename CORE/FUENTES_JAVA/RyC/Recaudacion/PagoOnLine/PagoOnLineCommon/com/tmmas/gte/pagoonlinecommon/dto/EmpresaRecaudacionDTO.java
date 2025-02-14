package com.tmmas.gte.pagoonlinecommon.dto;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "caja" package = "CO_PAGOSONLINE_PG" sp = "CO_OBTIENECAJA_PR"
* jndiProperty = "scl.pagos.online"
* servicioMetodo = "obtenerCaja"
* servicioPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroEntrada = "EmpresaRecaudacionDTO"
* servicioPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto"
* servicioParametroSalida = "EmpresaRecaudacionDTO"
* comentario = "Obtiene Caja asignada a una Empresa de Recaudación Externa" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "caja" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroEntrada = "EmpresaRecaudacionDTO" mappingProperty = "empRecaudadora" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "caja" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "EmpresaRecaudacionDTO" mappingProperty = "codCaja" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "caja" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "caja" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "caja" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.pagoonlinecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* 
* 
*
*/

public class EmpresaRecaudacionDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String empRecaudadora;
	private int codCaja;
	private RespuestaDTO respuesta;
	
	public int getCodCaja() {
		return codCaja;
	}
	public void setCodCaja(int codCaja) {
		this.codCaja = codCaja;
	}
	public String getEmpRecaudadora() {
		return empRecaudadora;
	}
	public void setEmpRecaudadora(String empRecaudadora) {
		this.empRecaudadora = empRecaudadora;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}	

}