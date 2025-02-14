package com.tmmas.cl.scl.commonbusinessentities.dto.ws; 

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioWebDTO;

public class UsuarioWebDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	private String codigoUsuario;
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
    
    private DireccionNegocioWebDTO[] direcciones;
    private boolean exitoCreacionUsuario;
    
    //-- DATOS DEL CLIENTE
    private String codigoEstrato;
	private String codigoCuenta;
	private String codigoSubCuenta;
	private String codTipoCliente;
	
	//-- DATOS DEL ABONADO
	
	private long numAbonado;
	private String numTelefono;
	

	public String getNumTelefono() {
		return numTelefono;
	}

	public void setNumTelefono(String numTelefono) {
		this.numTelefono = numTelefono;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public boolean isExitoCreacionUsuario() {
		return exitoCreacionUsuario;
	}

	public void setExitoCreacionUsuario(boolean exitoCreacionUsuario) {
		this.exitoCreacionUsuario = exitoCreacionUsuario;
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

	public DireccionNegocioWebDTO[] getDirecciones() {
		return direcciones;
	}

	public void setDirecciones(DireccionNegocioWebDTO[] direcciones) {
		this.direcciones = direcciones;
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

	public String getTipIdent() {
		return tipIdent;
	}

	public void setTipIdent(String tipIdent) {
		this.tipIdent = tipIdent;
	}

	public String getCodigoUsuario() {
		return codigoUsuario;
	}

	public void setCodigoUsuario(String codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}

	public String getCodigoCuenta() {
		return codigoCuenta;
	}

	public void setCodigoCuenta(String codigoCuenta) {
		this.codigoCuenta = codigoCuenta;
	}

	public String getCodigoSubCuenta() {
		return codigoSubCuenta;
	}

	public void setCodigoSubCuenta(String codigoSubCuenta) {
		this.codigoSubCuenta = codigoSubCuenta;
	}

	public String getCodigoEstrato() {
		return codigoEstrato;
	}

	public void setCodigoEstrato(String codigoEstrato) {
		this.codigoEstrato = codigoEstrato;
	}

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

}
