package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;
import java.util.Date;

public class SolicitudScoringAjaxDTO implements Serializable, Cloneable {
	private static final long serialVersionUID = 1L;

	private String nroSolScoring;
	private Date fechaCreacion;
	private String nombreCliente;
	private String nombreVendedor;
	private String nombreDealer;
	private String codDistribuidor;
	private String codVendedor;
	private String codOficina;
	private String codCliente;
	private String codModVenta;
	private String codTipoContrato;	
	private String codCuota;
	private String indEstSolScoring;
	private String nit;	
	private String codTipoComisionista;
	private String codEstado;
	private String desEstado;
	
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getDesEstado() {
		return desEstado;
	}
	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}
	public String getCodTipoComisionista() {
		return codTipoComisionista;
	}
	public void setCodTipoComisionista(String codTipoComisionista) {
		this.codTipoComisionista = codTipoComisionista;
	}
	public String getNit() {
		return nit;
	}
	public void setNit(String nit) {
		this.nit = nit;
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
	public String getNombreDealer() {
		return nombreDealer;
	}
	public void setNombreDealer(String nombreDealer) {
		this.nombreDealer = nombreDealer;
	}
	public Date getFechaCreacion() {
		return fechaCreacion;
	}
	public void setFechaCreacion( Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}
	public String getIndEstSolScoring() {
		return indEstSolScoring;
	}
	public void setIndEstSolScoring(String indEstSolScoring) {
		this.indEstSolScoring = indEstSolScoring;
	}
	public String getNroSolScoring() {
		return nroSolScoring;
	}
	public void setNroSolScoring(String nroSolScoring) {
		this.nroSolScoring = nroSolScoring;
	}
	public String getCodDistribuidor() {
		return codDistribuidor;
	}
	public void setCodDistribuidor(String codDistribuidor) {
		this.codDistribuidor = codDistribuidor;
	}
	
}