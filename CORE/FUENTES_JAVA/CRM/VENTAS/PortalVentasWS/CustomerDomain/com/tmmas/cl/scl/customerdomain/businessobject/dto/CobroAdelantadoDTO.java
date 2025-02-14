package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class CobroAdelantadoDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private long numAbonado;
	private long numVenta;
	private long codCicloFacturacion;
	private long codConcepto;
	private long numProceso;	
	private long numCobro;
	private String usuario;
	private int tipoServicioCobroAdelantado;
	
	public int getTipoServicioCobroAdelantado() {
		return tipoServicioCobroAdelantado;
	}
	public void setTipoServicioCobroAdelantado(int tipoServicioCobroAdelantado) {
		this.tipoServicioCobroAdelantado = tipoServicioCobroAdelantado;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getCodCicloFacturacion() {
		return codCicloFacturacion;
	}
	public void setCodCicloFacturacion(long codCicloFacturacion) {
		this.codCicloFacturacion = codCicloFacturacion;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(long codConcepto) {
		this.codConcepto = codConcepto;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCobro() {
		return numCobro;
	}
	public void setNumCobro(long numCobro) {
		this.numCobro = numCobro;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}	
	
}//fin CobroAdelantadoDTO
