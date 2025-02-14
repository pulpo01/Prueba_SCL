package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Alejandro Lorca
 */

/** 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "obtenerSaldoCliente" package = "GE_INTEGRACION_PG" sp = "ge_obtener_saldo_clie_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "obtenerSaldoCliente"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "CodClienteDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "CarteraResponseDTO"
* comentario = "Retorna saldo total de un Cliente a partir del codigo_cliente"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSaldoCliente"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "CodClienteDTO" mappingProperty = "codCliente" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSaldoCliente"   clase="salida" name="" tipo="NUMERIC" parentProperty = "carteraCliente"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "CarteraDTO" mappingProperty = "saldoCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSaldoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSaldoCliente" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "obtenerSaldoCliente" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*
*@tmas.legacy.jdbc.storedprocedure id = "consSaldoClieBloqueado" package = "GE_INTEGRACION_PG" sp = "ge_obtener_saldo_moroso_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consSaldoClieBloqueado"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "CodClienteDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "SaldoMorosidadDTO"
* comentario = "Retorna deuda vencida y deuda por vencer de un Cliente a partir del codigo_cliente"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "CodClienteDTO" mappingProperty = "codCliente" 
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SaldoMorosidadDTO" mappingProperty = "saldoVenc" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SaldoMorosidadDTO" mappingProperty = "saldoNoVenc" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consSaldoClieBloqueado" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*
*
*/

public class CarteraDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private double saldoCliente;

	public double getSaldoCliente() {
		return saldoCliente;
	}

	public void setSaldoCliente(double saldoCliente) {
		this.saldoCliente = saldoCliente;
	}
	

}