package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable; 
public class ClienteInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String indTipoCliente; 
	private String nombreCliente;
	private String codigoTipoIdentificacion;
	private String numeroIdentificacion;
	private String usuario;
	private String indicadirTipPersona;// F,J
	private String codigoPlanTarifario;
	
	private String codProvincia; 
	private String codRegion;
	private String codCiudad;
	private String codComuna;
	private String nomCalle;
	private String numCalle; 
	private String zip;
	private String desDirec1; 
	private String desDirec2;
	private String tipoCalle;	
	
	//campo nuevos solicitados en MA
	private String observacionDireccion;
	private String apellido1Cliente;
	private String apellido2Cliente;
	private String telefono_1;
	private String fechaNacimiento;
	private String nombreResponsable;
	private String telefonoContacto;
	private String codCalidadCliente;
	private String indSexo;
	
	// campos nuevos COL08009 
	private String codEstCivil;
	private String codSubcategoria;
	private String codTipIdentResp;
	private String numIdentResp;
	private String nomEmail;
	
	private String codigoCuenta;
	
	public String getCodigoCuenta() {
		return codigoCuenta;
	}
	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}
	public String getCodCiudad() {
		return codCiudad;
	}
	public void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}
	public String getCodComuna() {
		return codComuna;
	}
	public void setCodComuna(String codComuna) {
		this.codComuna = codComuna;
	}
	public String getCodProvincia() {
		return codProvincia;
	}
	public void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}
	public String getCodRegion() {
		return codRegion;
	}
	public void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}
	public String getDesDirec1() {
		return desDirec1;
	}
	public void setDesDirec1(String desDirec1) {
		this.desDirec1 = desDirec1;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
	public String getNomCalle() {
		return nomCalle;
	}
	public void setNomCalle(String nomCalle) {
		this.nomCalle = nomCalle;
	}
	public String getNumCalle() {
		return numCalle;
	}
	public void setNumCalle(String numCalle) {
		this.numCalle = numCalle;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	public String getIndicadirTipPersona() {
		return indicadirTipPersona;
	}
	public void setIndicadirTipPersona(String indicadirTipPersona) {
		this.indicadirTipPersona = indicadirTipPersona;
	}
	public String getIndTipoCliente() {
		return indTipoCliente;
	}
	public void setIndTipoCliente(String indTipoCliente) {
		this.indTipoCliente = indTipoCliente;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getTipoCalle() {
		return tipoCalle;
	}
	public void setTipoCalle(String tipoCalle) {
		this.tipoCalle = tipoCalle;
	}
	public String getObservacionDireccion() {
		return observacionDireccion;
	}
	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}
	public String getApellido1Cliente() {
		return apellido1Cliente;
	}
	public void setApellido1Cliente(String apellido1Cliente) {
		this.apellido1Cliente = apellido1Cliente;
	}
	public String getApellido2Cliente() {
		return apellido2Cliente;
	}
	public void setApellido2Cliente(String apellido2Cliente) {
		this.apellido2Cliente = apellido2Cliente;
	}
	public String getCodCalidadCliente() {
		return codCalidadCliente;
	}
	public void setCodCalidadCliente(String codCalidadCliente) {
		this.codCalidadCliente = codCalidadCliente;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getIndSexo() {
		return indSexo;
	}
	public void setIndSexo(String indSexo) {
		this.indSexo = indSexo;
	}
	public String getNombreResponsable() {
		return nombreResponsable;
	}
	public void setNombreResponsable(String nombreResponsable) {
		this.nombreResponsable = nombreResponsable;
	}
	public String getTelefono_1() {
		return telefono_1;
	}
	public void setTelefono_1(String telefono_1) {
		this.telefono_1 = telefono_1;
	}
	public String getTelefonoContacto() {
		return telefonoContacto;
	}
	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}
	public String getCodSubcategoria() {
		return codSubcategoria;
	}
	public void setCodSubcategoria(String codSubcategoria) {
		this.codSubcategoria = codSubcategoria;
	}
	public String getCodTipIdentResp() {
		return codTipIdentResp;
	}
	
	public void setCodTipIdentResp(String codTipIdentResp) {
		this.codTipIdentResp = codTipIdentResp;
	}
	public String getCodEstCivil() {
		return codEstCivil;
	}
	public void setCodEstCivil(String codEstCivil) {
		this.codEstCivil = codEstCivil;
	}
	
	public String getNomEmail() {
		return nomEmail;
	}
	public void setNomEmail(String nomEmail) {
		this.nomEmail = nomEmail;
	}
	public String getNumIdentResp() {
		return numIdentResp;
	}
	public void setNumIdentResp(String numIdentResp) {
		this.numIdentResp = numIdentResp;
	}
	
	
}
