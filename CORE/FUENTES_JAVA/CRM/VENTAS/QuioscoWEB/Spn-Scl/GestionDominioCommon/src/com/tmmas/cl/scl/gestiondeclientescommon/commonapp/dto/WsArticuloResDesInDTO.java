package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloResDesInDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String spnID;
	private long codArticulo;
	private int indInterno;//1:Int 0:Ext
	private int codUso;
	private long codBodega;
	private int indReserva;//1:Reserva, 0: des-reserva
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public int getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(int indInterno) {
		this.indInterno = indInterno;
	}
	public int getIndReserva() {
		return indReserva;
	}
	public void setIndReserva(int indReserva) {
		this.indReserva = indReserva;
	}
	public String getSpnID() {
		return spnID;
	}
	public void setSpnID(String spnID) {
		this.spnID = spnID;
	}
}