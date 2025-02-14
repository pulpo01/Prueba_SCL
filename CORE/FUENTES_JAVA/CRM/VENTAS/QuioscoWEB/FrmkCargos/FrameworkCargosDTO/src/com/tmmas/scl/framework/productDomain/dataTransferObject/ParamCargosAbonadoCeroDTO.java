package com.tmmas.scl.framework.productDomain.dataTransferObject;


import java.io.Serializable;
import java.sql.Date;

public class ParamCargosAbonadoCeroDTO  implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long codProducto;
	private String codConcepto;
	private String desConcepto;
	private String tipoCargo;
	private long cantidad;
	private String codMoneda;
	private String desMoneda; 
	private long codCliente;
	private Date fechaVigencia;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public Date getFechaVigencia() {
		return fechaVigencia;
	}
	public void setFechaVigencia(Date fechaVigencia) {
		this.fechaVigencia = fechaVigencia;
	}
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public long getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(long codProducto) {
		this.codProducto = codProducto;
	}
	public long getCantidad() {
		return cantidad;
	}
	public void setCantidad(long cantidad) {
		this.cantidad = cantidad;
	}
	public String getCodMoneda() {
		return codMoneda;
	}
	public void setCodMoneda(String codMoneda) {
		this.codMoneda = codMoneda;
	}
	public String getDesConcepto() {
		return desConcepto;
	}
	public void setDesConcepto(String desConcepto) {
		this.desConcepto = desConcepto;
	}
	public String getDesMoneda() {
		return desMoneda;
	}
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	public String getTipoCargo() {
		return tipoCargo;
	}
	public void setTipoCargo(String tipoCargo) {
		this.tipoCargo = tipoCargo;
	}
}