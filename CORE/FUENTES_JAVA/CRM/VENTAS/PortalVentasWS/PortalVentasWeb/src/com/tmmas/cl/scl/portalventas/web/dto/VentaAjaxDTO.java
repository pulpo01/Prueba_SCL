package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class VentaAjaxDTO implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	private String nroVenta;
	private String fechaVenta;
	private String nombreCliente;
	private String nombreVendedor;
	private String nombreDealer;
	private String tipoVenta;
	private String estado;
	private String codVendedor;
	private String codOficina;
	private String codCliente;
	private String codModVenta;
	private int indTipoVenta;
	private long numTransaccionVenta;
	private String codTipoContrato;
	private int codTipoDocumento;
	private String codCuota;
	private String indOfiter;
	private String codTipoCliente;
	private String codTipoSolicitud;
	private String indEstVenta;
	
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
	public String getCodCuota() {
		return codCuota;
	}
	public void setCodCuota(String codCuota) {
		this.codCuota = codCuota;
	}
	public String getCodTipoContrato() {
		return codTipoContrato;
	}
	public void setCodTipoContrato(String codTipoContrato) {
		this.codTipoContrato = codTipoContrato;
	}
	public int getIndTipoVenta() {
		return indTipoVenta;
	}
	public void setIndTipoVenta(int indTipoVenta) {
		this.indTipoVenta = indTipoVenta;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodModVenta() {
		return codModVenta;
	}
	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}
	public String getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public String getFechaVenta() {
		return fechaVenta;
	}
	public void setFechaVenta(String fechaVenta) {
		this.fechaVenta = fechaVenta;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNombreVendedor() {
		return nombreVendedor;
	}
	public void setNombreVendedor(String nombreVendedor) {
		this.nombreVendedor = nombreVendedor;
	}
	public String getNroVenta() {
		return nroVenta;
	}
	public void setNroVenta(String nroVenta) {
		this.nroVenta = nroVenta;
	}
	public String getTipoVenta() {
		return tipoVenta;
	}
	public void setTipoVenta(String tipoVenta) {
		this.tipoVenta = tipoVenta;
	}
	
	public Object clone()
    {
        Object clone = null;
        try
        {
            clone = super.clone();
        } 
        catch(CloneNotSupportedException e)
        {    }
        return clone;
    }
	public long getNumTransaccionVenta() {
		return numTransaccionVenta;
	}
	public void setNumTransaccionVenta(long numTransaccionVenta) {
		this.numTransaccionVenta = numTransaccionVenta;
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
	public String getIndOfiter() {
		return indOfiter;
	}
	public void setIndOfiter(String indOfiter) {
		this.indOfiter = indOfiter;
	}

	
}