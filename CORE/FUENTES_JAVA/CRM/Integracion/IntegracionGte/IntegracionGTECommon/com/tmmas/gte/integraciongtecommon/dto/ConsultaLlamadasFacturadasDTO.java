package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarLlamadasFacturadas" package = "PV_CONSLLAMADA_PG" sp = "PV_DETALLE_FACTURADO_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarLlamadasFacturadas"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsultaLlamadasFacturadasInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsultaLlamadasFacturadasResponseDTO"
* comentario = "Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "numTelefono" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "codCicloFact" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "numFolio" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "fecIni" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "fecTerm" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "usuario" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "campoOrden" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsultaLlamadasFacturadasInDTO" mappingProperty = "tipoOrden" parentProperty = ""
*  
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "ConsultaLlamadasFacturadasDTO" mappingProperty = "" parentProperty = "lstLlamadasFact"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "numFolio" mappingField = "num_Folio"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "fecLlamada" mappingField = "fec_Llamada" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "horaLlamada" mappingField = "hora_Llamada"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "numDestino" mappingField = "num_Destino"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamSinImp" mappingField = "mto_Llam_Sin_Imp"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "mtoLlamConImp" mappingField = "mto_Llam_Con_Imp"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarLlamadasFacturadas" name="CURSOROUT" mappingProperty = "desLlamada" mappingField = "des_Llamada"
*    
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarLlamadasFacturadas" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/

public class ConsultaLlamadasFacturadasDTO implements Serializable {
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	
	private long numFolio;
	private Date fecLlamada;
	private String horaLlamada;
	private long numDestino;
	private long mtoLlamSinImp;
	private long mtoLlamConImp;
	private String desLlamada;
	//private long numAbonado;
	
	/*public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}*/
	public String getDesLlamada() {
		return desLlamada;
	}
	public void setDesLlamada(String desLlamada) {
		this.desLlamada = desLlamada;
	}
	public Date getFecLlamada() {
		return fecLlamada;
	}
	public void setFecLlamada(Date fecLlamada) {
		this.fecLlamada = fecLlamada;
	}
	public String getHoraLlamada() {
		return horaLlamada;
	}
	public void setHoraLlamada(String horaLlamada) {
		this.horaLlamada = horaLlamada;
	}
	public long getMtoLlamConImp() {
		return mtoLlamConImp;
	}
	public void setMtoLlamConImp(long mtoLlamConImp) {
		this.mtoLlamConImp = mtoLlamConImp;
	}
	public long getMtoLlamSinImp() {
		return mtoLlamSinImp;
	}
	public void setMtoLlamSinImp(long mtoLlamSinImp) {
		this.mtoLlamSinImp = mtoLlamSinImp;
	}
	public long getNumDestino() {
		return numDestino;
	}
	public void setNumDestino(long numDestino) {
		this.numDestino = numDestino;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	
	
	
}
