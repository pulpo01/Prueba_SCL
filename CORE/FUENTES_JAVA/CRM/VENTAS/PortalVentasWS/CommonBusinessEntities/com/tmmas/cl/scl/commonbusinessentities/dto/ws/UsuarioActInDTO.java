package com.tmmas.cl.scl.commonbusinessentities.dto.ws; 

import java.io.Serializable;

public class UsuarioActInDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String tipIdent;
	private String numIdent;
	private String nomUsuario;
	private String nomApell1;
	private String nomApell2;
    private String codEstCivil;
    private String fechaNacimiento;  
    private String indSexo;
    private String codEstrato;
    private String email;
	private String tipoCalle;
    private String nomCalle;     
    private String observacionDireccion;
	private String codRegion;
 	private String codProvincia; 
	private String codCiudad;
	private String codComuna;
	private String desDirec2;
	 
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
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
	public String getCodEstCivil() {
		return codEstCivil;
	}
	public void setCodEstCivil(String codEstCivil) {
		this.codEstCivil = codEstCivil;
	}
	public String getCodEstrato() {
		return codEstrato;
	}
	public void setCodEstrato(String codEstrato) {
		this.codEstrato = codEstrato;
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
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getNomApell1() {
		return nomApell1;
	}
	public void setNomApell1(String nomApell1) {
		this.nomApell1 = nomApell1;
	}
	public String getNomApell2() {
		return nomApell2;
	}
	public void setNomApell2(String nomApell2) {
		this.nomApell2 = nomApell2;
	}
	public String getNomCalle() {
		return nomCalle;
	}
	public void setNomCalle(String nomCalle) {
		this.nomCalle = nomCalle;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getObservacionDireccion() {
		return observacionDireccion;
	}
	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}
	public String getTipIdent() {
		return tipIdent;
	}
	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}
	public String getTipoCalle() {
		return tipoCalle;
	}
	public void setTipoCalle(String tipoCalle) {
		this.tipoCalle = tipoCalle;
	}
	 
	 

}
