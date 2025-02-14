package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;

/**
* 
* @tmas.legacy.jdbc.storedprocedure id = "consultarAvisoSiniestro" package = "GE_INTEGRACION_PG" sp = "GE_AVISOSIN_PR"
* jndiProperty = "IntegracionGteSclDs"
* servicioMetodo = "consultarAvisoSiniestro"
* servicioPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroEntrada = "ConsAvisoSiniestroInDTO"
* servicioPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto"
* servicioParametroSalida = "ConsAvisoSiniestroResponseDTO"
* comentario = "Entrega Datos del Aviso Siniestro"
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsAvisoSiniestroInDTO" mappingProperty = "numeroTelefono" parentProperty = ""
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="entrada" name="" tipo=""
* mappingPaqueteEntrada = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroEntrada = "ConsAvisoSiniestroInDTO" mappingProperty = "codSiniestro" parentProperty = ""
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="salida" name="CURSOROUT" tipo="CURSOR"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "AvisoSiniestroDTO" mappingProperty = "" parentProperty = "listadoSiniestros"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "numSiniestro" mappingField = "num_siniestro"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "numAbonado" mappingField = "num_abonado" 
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "codProducto" mappingField = "cod_producto"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "codCausa" mappingField = "cod_causa"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "desCausa" mappingField = "des_causa"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "codEstado" mappingField = "cod_estado"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "numSerie" mappingField = "num_serie"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "fecSiniestro" mappingField = "fec_siniestro"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "codServicio" mappingField = "cod_servicio"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "indSusp" mappingField = "ind_susp"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "tipTerminal" mappingField = "tip_terminal"
* @tmas.legacy.jdbc.storedprocedure.cursor id = "consultarAvisoSiniestro" name="CURSOROUT" mappingProperty = "desTerminal" mappingField = "des_terminal"  
* 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "codigoError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="salida" name="" tipo="VARCHAR" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "mensajeError" 
* @tmas.legacy.jdbc.storedprocedure.parametro id = "consultarAvisoSiniestro" clase="salida" name="" tipo="NUMERIC" parentProperty = "respuesta"
* mappingPaqueteSalida = "com.tmmas.gte.integraciongtecommon.dto" mappingParametroSalida = "RespuestaDTO" mappingProperty = "numeroEvento"
* 
*/

public class AvisoSiniestroDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private long numSiniestro;
	private long numAbonado;
	private long codProducto;
	private String codCausa;
	private String desCausa;
	private String codEstado;
	private String numSerie;
	private Date fecSiniestro;
	private String codServicio;
	private long indSusp;
	private String tipTerminal;
	private String desTerminal;
	
	public String getCodCausa() {
		return codCausa;
	}
	public void setCodCausa(String codCausa) {
		this.codCausa = codCausa;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getDesCausa() {
		return desCausa;
	}
	public void setDesCausa(String desCausa) {
		this.desCausa = desCausa;
	}
	public String getDesTerminal() {
		return desTerminal;
	}
	public void setDesTerminal(String desTerminal) {
		this.desTerminal = desTerminal;
	}
	public Date getFecSiniestro() {
		return fecSiniestro;
	}
	public void setFecSiniestro(Date fecSiniestro) {
		this.fecSiniestro = fecSiniestro;
	}
	public long getIndSusp() {
		return indSusp;
	}
	public void setIndSusp(long indSusp) {
		this.indSusp = indSusp;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public long getNumSiniestro() {
		return numSiniestro;
	}
	public void setNumSiniestro(long numSiniestro) {
		this.numSiniestro = numSiniestro;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}

}
