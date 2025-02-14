package com.tmmas.scl.vendedor.dto;

import java.io.Serializable;

public class UsuarioVendedorDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	VendedorDTO vendedor;
	UsuarioSistemaDTO usuario;
	private String mensaje;
	private String codMensaje;
	private long codTipMensaje;	
	private boolean vendedorenSesion;
	private String[] numOOSS;
	
	public boolean isVendedorenSesion() {
		return vendedorenSesion;
	}
	public void setVendedorenSesion(boolean vendedorenSesion) {
		this.vendedorenSesion = vendedorenSesion;
	}
	public UsuarioSistemaDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioSistemaDTO usuario) {
		this.usuario = usuario;
	}
	public VendedorDTO getVendedor() {
		return vendedor;
	}
	public void setVendedor(VendedorDTO vendedor) {
		this.vendedor = vendedor;
	}
	
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public long getCodTipMensaje() {
		return codTipMensaje;
	}
	public void setCodTipMensaje(long codTipMensaje) {
		this.codTipMensaje = codTipMensaje;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String[] getNumOOSS() {
		return numOOSS;
	}
	public void setNumOOSS(String[] numOOSS) {
		this.numOOSS = numOOSS;
	}


	
	

}
