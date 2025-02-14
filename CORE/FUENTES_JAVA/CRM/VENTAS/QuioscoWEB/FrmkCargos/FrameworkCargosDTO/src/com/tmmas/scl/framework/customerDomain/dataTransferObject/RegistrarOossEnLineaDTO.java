package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class RegistrarOossEnLineaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codOS;
	  private int codProducto;
	  private int tipInter;
	  private long codInter;
	  private String usuario;
	  private Date fecha;
	  private String comentario;
	  private long numMovimiento;
	  private int codEstado;
	  private String codModulo;
	  private int indGestor;
	  private long numOs;
	  
	
	  
	  
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}

	public long getCodInter() {
		return codInter;
	}
	public void setCodInter(long codInter) {
		this.codInter = codInter;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getComentario() {
		return comentario;
	}
	public void setComentario(String comentario) {
		this.comentario = comentario;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public int getIndGestor() {
		return indGestor;
	}
	public void setIndGestor(int indGestor) {
		this.indGestor = indGestor;
	}

	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}
	public int getTipInter() {
		return tipInter;
	}
	public void setTipInter(int tipInter) {
		this.tipInter = tipInter;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
}
