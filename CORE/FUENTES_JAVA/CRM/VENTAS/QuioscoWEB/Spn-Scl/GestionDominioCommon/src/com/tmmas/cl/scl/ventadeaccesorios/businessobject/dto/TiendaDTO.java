package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class TiendaDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String codTienda; 
	private String desTienda; 
	private String nomUsuarioVendedor; 
	private String nomUsuarioCajero; 
	private String nomUsuario; 
	private String codCliente;
	private String codCaja;
	private String desCaja;
	private String indApliPago;
	
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodTienda() {
		return codTienda;
	}
	public void setCodTienda(String codTienda) {
		this.codTienda = codTienda;
	}
	public String getDesTienda() {
		return desTienda;
	}
	public void setDesTienda(String desTienda) {
		this.desTienda = desTienda;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNomUsuarioCajero() {
		return nomUsuarioCajero;
	}
	public void setNomUsuarioCajero(String nomUsuarioCajero) {
		this.nomUsuarioCajero = nomUsuarioCajero;
	}
	public String getNomUsuarioVendedor() {
		return nomUsuarioVendedor;
	}
	public void setNomUsuarioVendedor(String nomUsuarioVendedor) {
		this.nomUsuarioVendedor = nomUsuarioVendedor;
	}
	public String getCodCaja() {
		return codCaja;
	}
	public void setCodCaja(String codCaja) {
		this.codCaja = codCaja;
	}
	public String getDesCaja() {
		return desCaja;
	}
	public void setDesCaja(String desCaja) {
		this.desCaja = desCaja;
	}
	public String getIndApliPago() {
		return indApliPago;
	}
	public void setIndApliPago(String indApliPago) {
		this.indApliPago = indApliPago;
	}
}


