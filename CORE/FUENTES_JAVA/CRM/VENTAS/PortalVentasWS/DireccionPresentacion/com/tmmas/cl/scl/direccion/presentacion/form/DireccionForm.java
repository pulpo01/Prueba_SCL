package com.tmmas.cl.scl.direccion.presentacion.form;

import org.apache.struts.action.ActionForm;

public class DireccionForm extends ActionForm {
	
	private static final long serialVersionUID = 1L;
	
	private String tipoDireccion;
	private String descripcionTipoDireccion;
	
	private String COD_REGION;
	private String COD_PROVINCIA;
	private String COD_CIUDAD;
	private String COD_COMUNA;
	private String COD_TIPOCALLE;
	private String NOM_CALLE;
	private String NUM_CALLE;
	private String OBS_DIRECCION;
	private String ZIP;
	private String DES_DIREC1;
	private String DES_DIREC2;
	private String descripcionCOD_REGION;
	private String descripcionCOD_PROVINCIA;
	private String descripcionCOD_CIUDAD;
	private String descripcionCOD_COMUNA;
	private String descripcionCOD_TIPOCALLE;
	private String descripcionZIP;
	private String moduloOrigen;
	private String codModuloSolicitudVenta;
	
	
	public String getCodModuloSolicitudVenta() {
		return codModuloSolicitudVenta;
	}
	public void setCodModuloSolicitudVenta(String codModuloSolicitudVenta) {
		this.codModuloSolicitudVenta = codModuloSolicitudVenta;
	}
	public String getModuloOrigen() {
		return moduloOrigen;
	}
	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}
	public String getDescripcionCOD_CIUDAD() {
		return descripcionCOD_CIUDAD;
	}
	public void setDescripcionCOD_CIUDAD(String descripcionCOD_CIUDAD) {
		this.descripcionCOD_CIUDAD = descripcionCOD_CIUDAD;
	}
	public String getDescripcionCOD_COMUNA() {
		return descripcionCOD_COMUNA;
	}
	public void setDescripcionCOD_COMUNA(String descripcionCOD_COMUNA) {
		this.descripcionCOD_COMUNA = descripcionCOD_COMUNA;
	}
	public String getDescripcionCOD_PROVINCIA() {
		return descripcionCOD_PROVINCIA;
	}
	public void setDescripcionCOD_PROVINCIA(String descripcionCOD_PROVINCIA) {
		this.descripcionCOD_PROVINCIA = descripcionCOD_PROVINCIA;
	}
	public String getDescripcionCOD_REGION() {
		return descripcionCOD_REGION;
	}
	public void setDescripcionCOD_REGION(String descripcionCOD_REGION) {
		this.descripcionCOD_REGION = descripcionCOD_REGION;
	}
	public String getDescripcionCOD_TIPOCALLE() {
		return descripcionCOD_TIPOCALLE;
	}
	public void setDescripcionCOD_TIPOCALLE(String descripcionCOD_TIPOCALLE) {
		this.descripcionCOD_TIPOCALLE = descripcionCOD_TIPOCALLE;
	}
	public String getDescripcionZIP() {
		return descripcionZIP;
	}
	public void setDescripcionZIP(String descripcionZIP) {
		this.descripcionZIP = descripcionZIP;
	}
	public String getCOD_CIUDAD() {
		return COD_CIUDAD;
	}
	public void setCOD_CIUDAD(String cod_ciudad) {
		COD_CIUDAD = cod_ciudad;
	}
	public String getCOD_COMUNA() {
		return COD_COMUNA;
	}
	public void setCOD_COMUNA(String cod_comuna) {
		COD_COMUNA = cod_comuna;
	}
	public String getCOD_PROVINCIA() {
		return COD_PROVINCIA;
	}
	public void setCOD_PROVINCIA(String cod_provincia) {
		COD_PROVINCIA = cod_provincia;
	}
	public String getCOD_REGION() {
		return COD_REGION;
	}
	public void setCOD_REGION(String cod_region) {
		COD_REGION = cod_region;
	}
	public String getCOD_TIPOCALLE() {
		return COD_TIPOCALLE;
	}
	public void setCOD_TIPOCALLE(String cod_tipocalle) {
		COD_TIPOCALLE = cod_tipocalle;
	}
	public String getDescripcionTipoDireccion() {
		return descripcionTipoDireccion;
	}
	public void setDescripcionTipoDireccion(String descripcionTipoDireccion) {
		this.descripcionTipoDireccion = descripcionTipoDireccion;
	}
	public String getNOM_CALLE() {
		return NOM_CALLE;
	}
	public void setNOM_CALLE(String nom_calle) {
		NOM_CALLE = nom_calle;
	}
	public String getNUM_CALLE() {
		return NUM_CALLE;
	}
	public void setNUM_CALLE(String num_calle) {
		NUM_CALLE = num_calle;
	}
	public String getOBS_DIRECCION() {
		return OBS_DIRECCION;
	}
	public void setOBS_DIRECCION(String obs_direccion) {
		OBS_DIRECCION = obs_direccion;
	}
	public String getTipoDireccion() {
		return tipoDireccion;
	}
	public void setTipoDireccion(String tipoDireccion) {
		this.tipoDireccion = tipoDireccion;
	}
	public String getZIP() {
		return ZIP;
	}
	public void setZIP(String zip) {
		ZIP = zip;
	}
	public String getDES_DIREC1() {
		return DES_DIREC1;
	}
	public void setDES_DIREC1(String des_direc1) {
		DES_DIREC1 = des_direc1;
	}
	public String getDES_DIREC2() {
		return DES_DIREC2;
	}
	public void setDES_DIREC2(String des_direc2) {
		DES_DIREC2 = des_direc2;
	}
	
	/*
	private ConceptoDireccionDTO tipoCalleDireccionDTO;
	private String tipoCalle;
	private DatosDireccionDTO[] arrayTipoCalle;
	
	private ConceptoDireccionDTO nombreCalleDireccionDTO;
	private String nombreCalle;
	
	private ConceptoDireccionDTO numeroCalleDireccionDTO;
	private String numeroCalle;
	
	private ConceptoDireccionDTO numeroPisoDireccionDTO;
	private String numeroPiso;
	
	private ConceptoDireccionDTO regionDireccionDTO;
	private String region;
	private DatosDireccionDTO[] arrayRegion;
	
	private ConceptoDireccionDTO provinciaDireccionDTO;
	private String provincia;
	private DatosDireccionDTO[] arrayProvincia;
	
	private ConceptoDireccionDTO ciudadDireccionDTO;
	private String ciudad;
	private DatosDireccionDTO[] arrayCiudad;
	
	private ConceptoDireccionDTO comunaDireccionDTO;
	private String comuna;
	private DatosDireccionDTO[] arrayComuna;
	
	private ConceptoDireccionDTO zipDireccionDTO;
	private String zip;
	private DatosDireccionDTO[] arrayZip;
	
	private ConceptoDireccionDTO casillaDireccionDTO;
	private String casilla;
	
	private ConceptoDireccionDTO observacionDireccionDTO;
	private String observacion;
	
	private String tipoCalleObligatorio;
	private String nombreCalleObligatorio;
	private String numeroCalleObligatorio;
	private String numeroPisoObligatorio;
	private String regionObligatorio;
	private String provinciaObligatorio;
	private String ciudadObligatorio;
	private String comunaObligatorio;
	private String zipObligatorio;
	private String observacionObligatorio;
	private String casillaObligatorio;
	private String tipoCalleCaption;
	private String nombreCalleCaption;
	private String numeroCalleCaption;
	private String numeroPisoCaption;
	private String regionCaption;
	private String provinciaCaption;
	private String ciudadCaption;
	private String comunaCaption;
	private String zipCaption;
	private String observacionCaption;
	private String casillaCaption;
	private String regionDescripcion;
	private String provinciaDescripcion;
	private String ciudadDescripcion;
	private String comunaDescripcion;
	private String zipDescripcion;
	private String casillaDescripcion;
	private String tipoCalleDescripcion;
	private String tablaZipCode;
	
	private String numIdentClienteDir;
	private String nombreClienteDir;
	private String primerApellidoClienteDir;
	private String segundoApellidoClienteDir;
	
	private String codigoDireccion;
	
	private ConceptoDireccionDTO estadoDireccionDTO;
	private DatosDireccionDTO[] arrayEstado;
	
	private String accion;
	private String estado;
	

	// Para saber en qué pagina de direcciones me ecuentro
	private String pagina;
	
	// Para la pagina de direccion computeq
	private List arrayDireccionComputec;
	private String direccionComputec;
	private String descripcionCiudadComputecSel;*/
	
}
