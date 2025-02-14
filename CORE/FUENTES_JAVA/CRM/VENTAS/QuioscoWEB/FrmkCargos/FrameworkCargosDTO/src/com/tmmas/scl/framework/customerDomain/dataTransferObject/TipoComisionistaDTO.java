package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;

public class TipoComisionistaDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	private String codigoTipoComisionista;
	private String descripcionTipoComisionista;
	private String indExterno;
	private Timestamp fec_ultmod; 
	private long ind_cliente; 
	private long ind_bodega; 
	private long ind_riesgo; 
	private long ind_privilegio; 
	private String nom_usuario;
	
	public String getCodigoTipoComisionista() {
		return codigoTipoComisionista;
	}
	public void setCodigoTipoComisionista(String codigoTipoComisionista) {
		this.codigoTipoComisionista = codigoTipoComisionista;
	}
	public String getDescripcionTipoComisionista() {
		return descripcionTipoComisionista;
	}
	public void setDescripcionTipoComisionista(String descripcionTipoComisionista) {
		this.descripcionTipoComisionista = descripcionTipoComisionista;
	}
	public String getIndExterno() {
		return indExterno;
	}
	public void setIndExterno(String indExterno) {
		this.indExterno = indExterno;
	}
	public Timestamp getFec_ultmod() {
		return fec_ultmod;
	}
	public void setFec_ultmod(Timestamp fec_ultmod) {
		this.fec_ultmod = fec_ultmod;
	}
	public long getInd_bodega() {
		return ind_bodega;
	}
	public void setInd_bodega(long ind_bodega) {
		this.ind_bodega = ind_bodega;
	}
	public long getInd_cliente() {
		return ind_cliente;
	}
	public void setInd_cliente(long ind_cliente) {
		this.ind_cliente = ind_cliente;
	}
	public long getInd_privilegio() {
		return ind_privilegio;
	}
	public void setInd_privilegio(long ind_privilegio) {
		this.ind_privilegio = ind_privilegio;
	}
	public long getInd_riesgo() {
		return ind_riesgo;
	}
	public void setInd_riesgo(long ind_riesgo) {
		this.ind_riesgo = ind_riesgo;
	}
	public String getNom_usuario() {
		return nom_usuario;
	}
	public void setNom_usuario(String nom_usuario) {
		this.nom_usuario = nom_usuario;
	}
	
	

}
