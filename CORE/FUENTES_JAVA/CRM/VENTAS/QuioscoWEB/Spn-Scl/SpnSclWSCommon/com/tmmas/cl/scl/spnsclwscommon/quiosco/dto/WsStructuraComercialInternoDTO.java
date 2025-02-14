package com.tmmas.cl.scl.spnsclwscommon.quiosco.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonapp.dto.WsLineaOutDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.CargosDescuentosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.DescuentosManualesDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class WsStructuraComercialInternoDTO implements Serializable{
	

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoDireccion;
	private String cdogioCuenta;
	private String codigoCliente;
	private String procesoFacturacion;
	private WsLineaOutDTO[] lineaOut;
	private String numVenta;
	private RetornoDTO[] errores;
	private String resultadoTransaccion="0";
	private CargosDescuentosManualesDTO[] carDesManualesArray;
	
	
	public String getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(String codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
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
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
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
	public String getCdogioCuenta() {
		return cdogioCuenta;
	}
	public void setCdogioCuenta(String cdogioCuenta) {
		this.cdogioCuenta = cdogioCuenta;
	}
	public String getProcesoFacturacion() {
		return procesoFacturacion;
	}
	public void setProcesoFacturacion(String procesoFacturacion) {
		this.procesoFacturacion = procesoFacturacion;
	}
	public CargosDescuentosManualesDTO[] getCarDesManualesArray() {
		return carDesManualesArray;
	}
	public void setCarDesManualesArray(
			CargosDescuentosManualesDTO[] carDesManualesArray) {
		this.carDesManualesArray = carDesManualesArray;
	}

}
