package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class DatosGeneralesDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	//-- PARAMETROS
	private String codigoParametro;
	private String valorParametro;
	private String codigoModulo;
	private String codigoProducto;
	private String descripcionProducto;
	//-- TRANSACCIONES
	private String numTransaccion;
	private int codError;
	private String mnsError;
	
	//--Obtención Secuencia
	private String codigoSecuencia;
	private long secuencia;
	
	/*-- Otros --*/
	private String codigoTecnologia;
	private String codigoActuacionAbonado;
	private String codigoActuacionCentral;
	
	/*-- Ged Codigos --*/
	private String tabla;
	private String columna;
	private String codigoValor;
	private String descripcionValor;
	
	public int getCodError() {
		return codError;
	}
	public void setCodError(int codError) {
		this.codError = codError;
	}
	public String getCodigoActuacionAbonado() {
		return codigoActuacionAbonado;
	}
	public void setCodigoActuacionAbonado(String codigoActuacionAbonado) {
		this.codigoActuacionAbonado = codigoActuacionAbonado;
	}
	public String getCodigoActuacionCentral() {
		return codigoActuacionCentral;
	}
	public void setCodigoActuacionCentral(String codigoActuacionCentral) {
		this.codigoActuacionCentral = codigoActuacionCentral;
	}
	public String getCodigoModulo() {
		return codigoModulo;
	}
	public void setCodigoModulo(String codigoModulo) {
		this.codigoModulo = codigoModulo;
	}
	public String getCodigoParametro() {
		return codigoParametro;
	}
	public void setCodigoParametro(String codigoParametro) {
		this.codigoParametro = codigoParametro;
	}
	public String getCodigoProducto() {
		return codigoProducto;
	}
	public void setCodigoProducto(String codigoProducto) {
		this.codigoProducto = codigoProducto;
	}
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public String getCodigoTecnologia() {
		return codigoTecnologia;
	}
	public void setCodigoTecnologia(String codigoTecnologia) {
		this.codigoTecnologia = codigoTecnologia;
	}
	public String getCodigoValor() {
		return codigoValor;
	}
	public void setCodigoValor(String codigoValor) {
		this.codigoValor = codigoValor;
	}
	public String getColumna() {
		return columna;
	}
	public void setColumna(String columna) {
		this.columna = columna;
	}
	public String getDescripcionProducto() {
		return descripcionProducto;
	}
	public void setDescripcionProducto(String descripcionProducto) {
		this.descripcionProducto = descripcionProducto;
	}
	public String getDescripcionValor() {
		return descripcionValor;
	}
	public void setDescripcionValor(String descripcionValor) {
		this.descripcionValor = descripcionValor;
	}
	public String getMnsError() {
		return mnsError;
	}
	public void setMnsError(String mnsError) {
		this.mnsError = mnsError;
	}
	public String getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public long getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(long secuencia) {
		this.secuencia = secuencia;
	}
	public String getTabla() {
		return tabla;
	}
	public void setTabla(String tabla) {
		this.tabla = tabla;
	}
	public String getValorParametro() {
		return valorParametro;
	}
	public void setValorParametro(String valorParametro) {
		this.valorParametro = valorParametro;
	}
	
	

}
