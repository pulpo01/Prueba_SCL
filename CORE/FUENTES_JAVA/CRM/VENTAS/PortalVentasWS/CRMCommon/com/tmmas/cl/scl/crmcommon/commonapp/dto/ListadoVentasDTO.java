/* Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 06/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;


public class ListadoVentasDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Long codigoVendedor;
	private String descVendedor;
	private String nombreVendedor;
	private String nombreDealer;
	private String fechaDesde;
	private String fechaHasta;
	private Long nroVenta;
	private String fechaVenta;
	private String codOficina;
	private String descOficina;
	private Long cantidadVendida;
	private Long monto;
	private Long codCliente;
	private String nombreCliente;
	private String codEstadoVenta;
	private String tipoVenta;
	private String origen;
	private String codModVenta;
	private int indTipoVenta;
	private long numTransaccionVenta;
	private String codTipoContrato;
	private int codTipoDocumento;
	private String codCuota;
	private String indOfiter;
	private String codTipoCliente; //prepago -contrato
	private String codTipoSolicitud;
	private String indEstVenta;
	//private String numCelular;
	
//	public String getNumCelular() {
//		return numCelular;
//	}
//	public void setNumCelular(String numCelular) {
//		this.numCelular = numCelular;
//	}
	public String getIndEstVenta() {
		return indEstVenta;
	}
	public void setIndEstVenta(String indEstVenta) {
		this.indEstVenta = indEstVenta;
	}
	public String getCodTipoSolicitud() {
		return codTipoSolicitud;
	}
	public void setCodTipoSolicitud(String codTipoSolicitud) {
		this.codTipoSolicitud = codTipoSolicitud;
	}
	public String getCodTipoCliente() {
		return codTipoCliente;
	}
	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public long getNumTransaccionVenta() {
		return numTransaccionVenta;
	}
	public void setNumTransaccionVenta(long numTransaccionVenta) {
		this.numTransaccionVenta = numTransaccionVenta;
	}
	public String getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getOrigen() {
		return origen;
	}
	public void setOrigen(String origen) {
		this.origen = origen;
	}
	public String getTipoVenta() {
		return tipoVenta;
	}
	public void setTipoVenta(String tipoVenta) {
		this.tipoVenta = tipoVenta;
	}
	public String getCodEstadoVenta() {
		return codEstadoVenta;
	}
	public void setCodEstadoVenta(String codEstadoVenta) {
		this.codEstadoVenta = codEstadoVenta;
	}
	public Long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(Long codCliente) {
		this.codCliente = codCliente;
	}
	public Long getCantidadVendida() {
		return cantidadVendida;
	}
	public void setCantidadVendida(Long cantidadVendida) {
		this.cantidadVendida = cantidadVendida;
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
	public String getFechaVenta() {
		return fechaVenta;
	}
	public void setFechaVenta(String fechaVenta) {
		this.fechaVenta = fechaVenta;
	}
	public Long getMonto() {
		return monto;
	}
	public void setMonto(Long monto) {
		this.monto = monto;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public Long getNroVenta() {
		return nroVenta;
	}
	public void setNroVenta(Long nroVenta) {
		this.nroVenta = nroVenta;
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
	public String getDescOficina() {
		return descOficina;
	}
	public void setDescOficina(String descOficina) {
		this.descOficina = descOficina;
	}
	public String getDescVendedor() {
		return descVendedor;
	}
	public void setDescVendedor(String descVendedor) {
		this.descVendedor = descVendedor;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public int getIndTipoVenta() {
		return indTipoVenta;
	}
	public void setIndTipoVenta(int indTipoVenta) {
		this.indTipoVenta = indTipoVenta;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public String getNombreDealer() {
		return nombreDealer;
	}
	public void setNombreDealer(String nombreDealer) {
		this.nombreDealer = nombreDealer;
	}
	public int getCodTipoDocumento() {
		return codTipoDocumento;
	}
	public void setCodTipoDocumento(int codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}

	
	
}