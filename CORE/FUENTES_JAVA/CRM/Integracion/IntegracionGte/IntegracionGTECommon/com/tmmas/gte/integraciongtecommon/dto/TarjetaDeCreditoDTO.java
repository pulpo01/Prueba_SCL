package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "validarNumTarjCredito" package = "CO_SERVICIOS_COBRANZA_PG" sp = "CO_ValidaTarjeta_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "validarNumTarjCredito"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "TarjetaDeCreditoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Valida que el número de tarjeta de crédito que se ha ingresado sea un número válido"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNumTarjCredito"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codTipTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNumTarjCredito"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "numeroTarjeta" 
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNumTarjCredito" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNumTarjCredito" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "validarNumTarjCredito" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "actualizarDatosClieTarjeta" package = "GE_INTEGRACION_PG" sp = "ge_update_cliente_pr"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "actualizarDatosClieTarjeta"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "TarjetaDeCreditoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Actualiza el registro de la tabla de clientes asociado al código de cliente del número ingresado"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "numeroTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "indicDebito" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codTipTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "fechaVencTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codBancoTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "nombreTitular" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "observaciones" 
*
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "actualizarDatosClieTarjeta" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
* 
* @tmas.legacy.jdbc.storedprocedure id = "insertarPagoAutomatico" package = "CO_SERVICIOS_COBRANZA_PG" sp = "CO_insPagoAutomatico_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "insertarPagoAutomatico"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "TarjetaDeCreditoDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "RespuestaDTO"
* comentario = "Actualiza la información de la tarjeta de crédito en el módulo de cobranza"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codCliente" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codBancoTarjeta" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "numTelefono" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codZona" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codCentral" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico"   clase="entrada" name="" tipo="" parentProperty = ""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "TarjetaDeCreditoDTO" mappingProperty = "codBcoi" 
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico" clase="salida" name="" tipo="VARCHAR" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "insertarPagoAutomatico" clase="salida" name="" tipo="NUMERIC" parentProperty = ""
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*
*
* @tmas.legacy.jdbc.storedprocedure id = "listarTarjetasDeCredito" package = "Ve_Alta_Cliente_Pg" sp = "VE_getListTarjetas_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "listarTarjetasDeCredito"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "TarjetaCreditoResponseDTO"
* comentario = "Entrega Listado de Tarjetas de Credito"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listarTarjetasDeCredito"   clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "TarjetaCreditoPacDTO" mappingProperty = "" parentProperty = "tarjetasDeCreditoDTO"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listarTarjetasDeCredito" name="CURSOROUT" mappingProperty = "codTipTarjeta" mappingField = "cod_tiptarjeta" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "listarTarjetasDeCredito" name="CURSOROUT" mappingProperty = "desTipTarjeta" mappingField = "des_tiptarjeta" 
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listarTarjetasDeCredito" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listarTarjetasDeCredito" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "listarTarjetasDeCredito" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
* 
* 
*/ 

public class TarjetaDeCreditoDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	
	private String codTipTarjeta;
	private String desTipTarjeta;
	private String numeroTarjeta;
	private String indicDebito;
	private String fechaVencTarjeta;
	private String codBancoTarjeta;
	private String nombreTitular;
	private String observaciones;
	private long codCliente;
	private long numTelefono;
	private String codZona;
	private String codCentral;
	private long codBcoi;
	


	public String getFechaVencTarjeta() {
		return fechaVencTarjeta;
	}
	public void setFechaVencTarjeta(String fechaVencTarjeta) {
		this.fechaVencTarjeta = fechaVencTarjeta;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodBancoTarjeta() {
		return codBancoTarjeta;
	}
	public void setCodBancoTarjeta(String codBancoTarjeta) {
		this.codBancoTarjeta = codBancoTarjeta;
	}
	public String getCodTipTarjeta() {
		return codTipTarjeta;
	}
	public void setCodTipTarjeta(String codTipTarjeta) {
		this.codTipTarjeta = codTipTarjeta;
	}
	public String getDesTipTarjeta() {
		return desTipTarjeta;
	}
	public void setDesTipTarjeta(String desTipTarjeta) {
		this.desTipTarjeta = desTipTarjeta;
	}
	public String getNombreTitular() {
		return nombreTitular;
	}
	public void setNombreTitular(String nombreTitular) {
		this.nombreTitular = nombreTitular;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public String getObservaciones() {
		return observaciones;
	}
	public void setObservaciones(String observaciones) {
		this.observaciones = observaciones;
	}
	public String getIndicDebito() {
		return indicDebito;
	}
	public void setIndicDebito(String indicDebito) {
		this.indicDebito = indicDebito;
	}
	public long getCodBcoi() {
		return codBcoi;
	}
	public void setCodBcoi(long codBcoi) {
		this.codBcoi = codBcoi;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodZona() {
		return codZona;
	}
	public void setCodZona(String codZona) {
		this.codZona = codZona;
	} 
	
	

}