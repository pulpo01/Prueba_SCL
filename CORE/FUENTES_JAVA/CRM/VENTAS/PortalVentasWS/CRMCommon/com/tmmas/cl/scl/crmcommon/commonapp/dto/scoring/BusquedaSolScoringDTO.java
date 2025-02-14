
package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;


public class BusquedaSolScoringDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long codigoVendedor;
	private String fechaDesde;
	private String fechaHasta;
	private Long nroSolicitud;
	private String fechaSolicitud;
	private String codOficina;	
	private Long codCliente;	
	private String codEstadoSolicitud;
	
	
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodEstadoSolicitud() {
		return codEstadoSolicitud;
	}
	public void setCodEstadoSolicitud(String codEstadoSolicitud) {
		this.codEstadoSolicitud = codEstadoSolicitud;
	}
	public Long getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(Long codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getFechaDesde() {
		return fechaDesde;
	}
	public void setFechaDesde(String fechaDesde) {
		this.fechaDesde = fechaDesde;
	}
	public String getFechaHasta() {
		return fechaHasta;
	}
	public void setFechaHasta(String fechaHasta) {
		this.fechaHasta = fechaHasta;
	}
	public String getFechaSolicitud() {
		return fechaSolicitud;
	}
	public void setFechaSolicitud(String fechaSolicitud) {
		this.fechaSolicitud = fechaSolicitud;
	}
	public Long getNroSolicitud() {
		return nroSolicitud;
	}
	public void setNroSolicitud(Long nroSolicitud) {
		this.nroSolicitud = nroSolicitud;
	}
	
	
	
}