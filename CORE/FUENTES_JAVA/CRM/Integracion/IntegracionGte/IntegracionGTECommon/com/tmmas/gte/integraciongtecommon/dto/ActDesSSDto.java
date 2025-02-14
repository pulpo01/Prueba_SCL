package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ActDesSSDto  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long numTelefono;
	private String listaSSAct;
	private String listaSSDes;
	private long numSecuencia;
	private String codOOSS;
	private long imporTotal;
	private String usuario;
	private String Comentario;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getComentario() {
		return Comentario;
	}
	public void setComentario(String comentario) {
		Comentario = comentario;
	}
	public long getImporTotal() {
		return imporTotal;
	}
	public void setImporTotal(long imporTotal) {
		this.imporTotal = imporTotal;
	}
	public String getListaSSAct() {
		return listaSSAct;
	}
	public void setListaSSAct(String listaSSAct) {
		this.listaSSAct = listaSSAct;
	}
	public String getListaSSDes() {
		return listaSSDes;
	}
	public void setListaSSDes(String listaSSDes) {
		this.listaSSDes = listaSSDes;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumSecuencia() {
		return numSecuencia;
	}
	public void setNumSecuencia(long numSecuencia) {
		this.numSecuencia = numSecuencia;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
    
	
	
	
	
	
	
	

	
	
}
