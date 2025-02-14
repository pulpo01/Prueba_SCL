package com.tmmas.scl.operations.crm.f.s.manpro.web.form;

import java.io.Serializable;
import java.util.ArrayList;

public class ListAfinesDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String codigo_cliente;
	private String nombre_cliente;
	private ArrayList listaAfines;
	
	public ArrayList getListaAfines() {
		return listaAfines;
	}
	public void setListaAfines(ArrayList listaAfines) {
		this.listaAfines = listaAfines;
	}
	public String getCodigo_cliente() {
		return codigo_cliente;
	}
	public void setCodigo_cliente(String codigo_cliente) {
		this.codigo_cliente = codigo_cliente;
	}
	public String getNombre_cliente() {
		return nombre_cliente;
	}
	public void setNombre_cliente(String nombre_cliente) {
		this.nombre_cliente = nombre_cliente;
	}
	
	
	
	

}
