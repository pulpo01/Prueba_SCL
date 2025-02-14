package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ArticuloResDesInDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private long codArticulo;
	private int tipStock;////2:Int 4:Ext
	private int codUso;
	private int codEstado;
	private long codBodega;
	private long cantidad;
	private int indReserva;//1:Reserva, 2: des-reserva
	private String modulo;
	private String SpnID;
	
	public String getSpnID() {
		return SpnID;
	}
	public void setSpnID(String spnID) {
		SpnID = spnID;
	}
	public long getCantidad() {
		return cantidad;
	}
	public void setCantidad(long cantidad) {
		this.cantidad = cantidad;
	}
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
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}
	public int getIndReserva() {
		return indReserva;
	}
	public void setIndReserva(int indReserva) {
		this.indReserva = indReserva;
	}
	public String getModulo() {
		return modulo;
	}
	public void setModulo(String modulo) {
		this.modulo = modulo;
	}
	public int getTipStock() {
		return tipStock;
	}
	public void setTipStock(int tipStock) {
		this.tipStock = tipStock;
	}
}