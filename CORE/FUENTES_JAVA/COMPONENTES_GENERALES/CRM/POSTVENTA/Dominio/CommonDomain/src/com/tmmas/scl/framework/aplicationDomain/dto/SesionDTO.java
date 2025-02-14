package com.tmmas.scl.framework.aplicationDomain.dto;

import java.io.Serializable;

public class SesionDTO implements Serializable{


	private static final long serialVersionUID = 1L;
	private long codCliente;
	private long numAbonado;
	private long codOrdenServicio;
	private long numOrdenServicio;	
	private UsuarioSistemaDTO usuario;
	private String clave;
	private String forward;
	private String cod_programa; 
	private long num_version;
	private boolean req_vendedor;
	private long numTarea;

	private String strOrigenSerie;
	

	
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodOrdenServicio() {
		return codOrdenServicio;
	}
	public void setCodOrdenServicio(long codOrdenServicio) {
		this.codOrdenServicio = codOrdenServicio;
	}
	public String getForward() {
		return forward;
	}
	public void setForward(String forward) {
		this.forward = forward;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumOrdenServicio() {
		return numOrdenServicio;
	}
	public void setNumOrdenServicio(long numOrdenServicio) {
		this.numOrdenServicio = numOrdenServicio;
	}
	public UsuarioSistemaDTO getUsuario() {
		return usuario;
	}
	public void setUsuario(UsuarioSistemaDTO usuario) {
		this.usuario = usuario;
	}
	public String getCod_programa() {
		return cod_programa;
	}
	public void setCod_programa(String cod_programa) {
		this.cod_programa = cod_programa;
	}
	public long getNum_version() {
		return num_version;
	}
	public void setNum_version(long num_version) {
		this.num_version = num_version;
	}
	public boolean isReq_vendedor() {
		return req_vendedor;
	}
	public void setReq_vendedor(boolean req_vendedor) {
		this.req_vendedor = req_vendedor;
	}

	public long getNumTarea() {
		return numTarea;
	}
	public void setNumTarea(long numTarea) {
		this.numTarea = numTarea;
	}

	// inicio rrg 78629 col 07-03-2009
	public String getOrigenSerie() {
		return strOrigenSerie;
	}

	public void setOrigenSerie(String strOrigenSerie) {
		this.strOrigenSerie = strOrigenSerie;
	}
	// inicio rrg 78629 col 07-03-2009
	
}
