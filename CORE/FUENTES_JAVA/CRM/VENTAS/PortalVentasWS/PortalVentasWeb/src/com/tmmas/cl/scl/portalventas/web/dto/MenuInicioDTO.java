package com.tmmas.cl.scl.portalventas.web.dto;

import java.io.Serializable;

public class MenuInicioDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int totalMenusActivosUsuario;
	private int totalAreaVentas;	
	private int totalAreaCredito;	
	private int totalAreaActivaciones;
	private int totalAreaInstalacion;
	private int totalAreaLDI;
	private String[] listaAreaVentas;
	private String[] listaAreaCredito;
	private String[] listaAreaActivaciones;
	private String[] listaAreaInstalacion;
	private String[] listaAreaLDI;
	
	public String[] getListaAreaActivaciones() {
		return listaAreaActivaciones;
	}
	public void setListaAreaActivaciones(String[] listaAreaActivaciones) {
		this.listaAreaActivaciones = listaAreaActivaciones;
	}
	public String[] getListaAreaCredito() {
		return listaAreaCredito;
	}
	public void setListaAreaCredito(String[] listaAreaCredito) {
		this.listaAreaCredito = listaAreaCredito;
	}
	public String[] getListaAreaInstalacion() {
		return listaAreaInstalacion;
	}
	public void setListaAreaInstalacion(String[] listaAreaInstalacion) {
		this.listaAreaInstalacion = listaAreaInstalacion;
	}
	public String[] getListaAreaVentas() {
		return listaAreaVentas;
	}
	public void setListaAreaVentas(String[] listaAreaVentas) {
		this.listaAreaVentas = listaAreaVentas;
	}
	public int getTotalAreaActivaciones() {
		return totalAreaActivaciones;
	}
	public void setTotalAreaActivaciones(int totalAreaActivaciones) {
		this.totalAreaActivaciones = totalAreaActivaciones;
	}
	public int getTotalAreaCredito() {
		return totalAreaCredito;
	}
	public void setTotalAreaCredito(int totalAreaCredito) {
		this.totalAreaCredito = totalAreaCredito;
	}
	public int getTotalAreaInstalacion() {
		return totalAreaInstalacion;
	}
	public void setTotalAreaInstalacion(int totalAreaInstalacion) {
		this.totalAreaInstalacion = totalAreaInstalacion;
	}
	public int getTotalAreaVentas() {
		return totalAreaVentas;
	}
	public void setTotalAreaVentas(int totalAreaVentas) {
		this.totalAreaVentas = totalAreaVentas;
	}
	public int getTotalMenusActivosUsuario() {
		return totalMenusActivosUsuario;
	}
	public void setTotalMenusActivosUsuario(int totalMenusActivosUsuario) {
		this.totalMenusActivosUsuario = totalMenusActivosUsuario;
	}
	public final String[] getListaAreaLDI() {
		return listaAreaLDI;
	}
	public final void setListaAreaLDI(String[] listaAreaLDI) {
		this.listaAreaLDI = listaAreaLDI;
	}
	public final int getTotalAreaLDI() {
		return totalAreaLDI;
	}
	public final void setTotalAreaLDI(int totalAreaLDI) {
		this.totalAreaLDI = totalAreaLDI;
	}
	
	
}
