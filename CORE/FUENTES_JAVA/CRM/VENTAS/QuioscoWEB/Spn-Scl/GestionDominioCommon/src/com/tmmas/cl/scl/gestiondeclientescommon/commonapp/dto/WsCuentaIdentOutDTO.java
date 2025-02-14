package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

public class WsCuentaIdentOutDTO  extends RetornoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codigoCuenta;                         
	private String descripcionCuenta;       	       
	private String tipoCuenta;       	               
	private String nombreResponsable;  	               
	private String codigoTipoIdentificacion;     	       
	private String numeroIdentifiacion;        	       
	private long codigoDireccion;   	               
	private Date fechaAlta;         	               
	private String indicadorEstado;       	       
	private String telefonoContacto;     	               
	private String indicadorSector;       	       
	private String codigoClasificacionCuenta;      	
	private String codigoCategoriaTributaria;     	
	private String descripcionCategoriaTributaria;       
	private long codigoCategoria;    	               
	private long codigoSector;       	               
	private String codigoSubCategori;  	               
	private String indicadorMultiUso;                    
	private String indicadorClientePotencial;            
	private String descripcionRazonSocial;               
	private Date fechaInicioVentaPac;                  
	private String codigotipcomis;                       
	private String nombreUsuarioAsesor;                  
	private Date fechaNacimiento;
	
	
	
	public long getCodigoCategoria() {
		return codigoCategoria;
	}
	public void setCodigoCategoria(long codigoCategoria) {
		this.codigoCategoria = codigoCategoria;
	}
	public String getCodigoCategoriaTributaria() {
		return codigoCategoriaTributaria;
	}
	public void setCodigoCategoriaTributaria(String codigoCategoriaTributaria) {
		this.codigoCategoriaTributaria = codigoCategoriaTributaria;
	}
	public String getCodigoClasificacionCuenta() {
		return codigoClasificacionCuenta;
	}
	public void setCodigoClasificacionCuenta(String codigoClasificacionCuenta) {
		this.codigoClasificacionCuenta = codigoClasificacionCuenta;
	}
	public long getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(long codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public long getCodigoDireccion() {
		return codigoDireccion;
	}
	public void setCodigoDireccion(long codigoDireccion) {
		this.codigoDireccion = codigoDireccion;
	}
	public long getCodigoSector() {
		return codigoSector;
	}
	public void setCodigoSector(long codigoSector) {
		this.codigoSector = codigoSector;
	}
	public String getCodigoSubCategori() {
		return codigoSubCategori;
	}
	public void setCodigoSubCategori(String codigoSubCategori) {
		this.codigoSubCategori = codigoSubCategori;
	}
	public String getCodigotipcomis() {
		return codigotipcomis;
	}
	public void setCodigotipcomis(String codigotipcomis) {
		this.codigotipcomis = codigotipcomis;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getDescripcionCategoriaTributaria() {
		return descripcionCategoriaTributaria;
	}
	public void setDescripcionCategoriaTributaria(
			String descripcionCategoriaTributaria) {
		this.descripcionCategoriaTributaria = descripcionCategoriaTributaria;
	}
	public String getDescripcionCuenta() {
		return descripcionCuenta;
	}
	public void setDescripcionCuenta(String descripcionCuenta) {
		this.descripcionCuenta = descripcionCuenta;
	}
	public String getDescripcionRazonSocial() {
		return descripcionRazonSocial;
	}
	public void setDescripcionRazonSocial(String descripcionRazonSocial) {
		this.descripcionRazonSocial = descripcionRazonSocial;
	}
	public Date getFechaAlta() {
		return fechaAlta;
	}
	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}
	public Date getFechaInicioVentaPac() {
		return fechaInicioVentaPac;
	}
	public void setFechaInicioVentaPac(Date fechaInicioVentaPac) {
		this.fechaInicioVentaPac = fechaInicioVentaPac;
	}
	public Date getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(Date fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIndicadorClientePotencial() {
		return indicadorClientePotencial;
	}
	public void setIndicadorClientePotencial(String indicadorClientePotencial) {
		this.indicadorClientePotencial = indicadorClientePotencial;
	}
	public String getIndicadorEstado() {
		return indicadorEstado;
	}
	public void setIndicadorEstado(String indicadorEstado) {
		this.indicadorEstado = indicadorEstado;
	}
	public String getIndicadorMultiUso() {
		return indicadorMultiUso;
	}
	public void setIndicadorMultiUso(String indicadorMultiUso) {
		this.indicadorMultiUso = indicadorMultiUso;
	}
	public String getIndicadorSector() {
		return indicadorSector;
	}
	public void setIndicadorSector(String indicadorSector) {
		this.indicadorSector = indicadorSector;
	}
	public String getNombreResponsable() {
		return nombreResponsable;
	}
	public void setNombreResponsable(String nombreResponsable) {
		this.nombreResponsable = nombreResponsable;
	}
	public String getNombreUsuarioAsesor() {
		return nombreUsuarioAsesor;
	}
	public void setNombreUsuarioAsesor(String nombreUsuarioAsesor) {
		this.nombreUsuarioAsesor = nombreUsuarioAsesor;
	}
	public String getNumeroIdentifiacion() {
		return numeroIdentifiacion;
	}
	public void setNumeroIdentifiacion(String numeroIdentifiacion) {
		this.numeroIdentifiacion = numeroIdentifiacion;
	}
	public String getTelefonoContacto() {
		return telefonoContacto;
	}
	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}
	public String getTipoCuenta() {
		return tipoCuenta;
	}
	public void setTipoCuenta(String tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}                      
	
}
