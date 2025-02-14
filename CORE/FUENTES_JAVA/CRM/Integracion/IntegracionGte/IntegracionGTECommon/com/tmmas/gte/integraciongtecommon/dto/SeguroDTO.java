package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;
/**
* 
*  
* @tmas.legacy.jdbc.storedprocedure id = "consultarSeguroTelefonico" package = "GE_INTEGRACION_PG" sp = "GE_CONS_SEGURO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarSeguroTelefonico"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "SeguroInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "SeguroDTO"
* comentario = "se ingresa el numero de abonado y retorna un SeguroDTO con todos los datos del seguro."
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"  mappingParametroEntrada = "SeguroInDTO"  mappingProperty = "numeroAbonado" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "codSeguro" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "desSeguro" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "numeroEventos" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="DOUBLE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "importeEquipo" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "fecAlta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="DATE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "fecFinContrato" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "numMaxen" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "tipCobertura" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "desValor" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="DOUBLE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "deducible" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico"   clase="salida" name="" tipo="DOUBLE" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "SeguroDTO" mappingProperty = "impSegur" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarSeguroTelefonico" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
*/ 
public class SeguroDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codSeguro;  
	private String desSeguro;   
	private long  numeroEventos; 
	private double importeEquipo;   
	private Date  fecAlta;   
	private Date fecFinContrato;
	private long numMaxen;
	private long tipCobertura;        
	private String desValor;
	private double deducible;
	private double impSegur;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodSeguro() {
		return codSeguro;
	}
	public void setCodSeguro(String codSeguro) {
		this.codSeguro = codSeguro;
	}
	public double getDeducible() {
		return deducible;
	}
	public void setDeducible(double deducible) {
		this.deducible = deducible;
	}
	public String getDesSeguro() {
		return desSeguro;
	}
	public void setDesSeguro(String desSeguro) {
		this.desSeguro = desSeguro;
	}
	public String getDesValor() {
		return desValor;
	}
	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecFinContrato() {
		return fecFinContrato;
	}
	public void setFecFinContrato(Date fecFinContrato) {
		this.fecFinContrato = fecFinContrato;
	}
	public double getImporteEquipo() {
		return importeEquipo;
	}
	public void setImporteEquipo(double importeEquipo) {
		this.importeEquipo = importeEquipo;
	}
	public double getImpSegur() {
		return impSegur;
	}
	public void setImpSegur(double impSegur) {
		this.impSegur = impSegur;
	}
	public long getNumeroEventos() {
		return numeroEventos;
	}
	public void setNumeroEventos(long numeroEventos) {
		this.numeroEventos = numeroEventos;
	}
	public long getNumMaxen() {
		return numMaxen;
	}
	public void setNumMaxen(long numMaxen) {
		this.numMaxen = numMaxen;
	}
	public long getTipCobertura() {
		return tipCobertura;
	}
	public void setTipCobertura(long tipCobertura) {
		this.tipCobertura = tipCobertura;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	
}
