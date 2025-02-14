package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "validarSoporteGPRS" package = "GE_INTEGRACION_PG" sp = "ge_val_soporte_gprs_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarSoporteGPRS"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ArticuloDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespBooleanDTO"
* comentario = "Valida si el equipo asociado al número de teléfono consultado tiene soporte GPRS"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ArticuloDTO" mappingProperty = "numAbonado" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ArticuloDTO" mappingProperty = "codTecnologia" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ArticuloDTO" mappingProperty = "numSerie" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ArticuloDTO" mappingProperty = "numImei" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ArticuloDTO" mappingProperty = "codServicio" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarSoporteGPRS" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarPuk" package = "GE_INTEGRACION_PG" sp = "GE_CONSPUK_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarPuk"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "NumeroTelefonoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsultaPukResponseDTO"
* comentario = "Servicio que permite consultar el PUK de una Serie Simcard"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuk" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "NumeroTelefonoDTO" mappingProperty = "numeroTelefono" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuk" clase="salida" name="" tipo="NUMERIC"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsultaPukResponseDTO" mappingProperty = "numeroPuk" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuk" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuk" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarPuk" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/ 

/**
 * @author implantacion
 *
 */
public class ArticuloDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private long numAbonado;
	private String codTecnologia;
	private String numImei;
	private String numSerie;
	private String codServicio;
		
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	

}