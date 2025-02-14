package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsStructuraComercialOutDTO implements Serializable{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private WsLineaOutDTO[] lineaOut;
	private RetornoDTO[] errores;
	private String resultadoTransaccion="0";
	private String procesoFacturacion;
	private String numVenta;
	private byte[] pdfAsBytes;
	private String codigoCliente;
	
	
	public byte[] getPdfAsBytes() {
		return pdfAsBytes;
	}
	public void setPdfAsBytes(byte[] pdfAsBytes) {
		this.pdfAsBytes = pdfAsBytes;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public String getProcesoFacturacion() {
		return procesoFacturacion;
	}
	public void setProcesoFacturacion(String procesoFacturacion) {
		this.procesoFacturacion = procesoFacturacion;
	}
	public RetornoDTO[] getErrores() {
		return errores;
	}
	public void setErrores(RetornoDTO[] errores) {
		this.errores = errores;
	}
	public WsLineaOutDTO[] getLineaOut() {
		return lineaOut;
	}
	public void setLineaOut(WsLineaOutDTO[] lineaOut) {
		this.lineaOut = lineaOut;
	}
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}

	
	
	
}
