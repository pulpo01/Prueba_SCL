package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.commonbusinessentities.commonapp.DireccionNegocioDTO;

public class UsuarioDTO implements Serializable{

	private static final long serialVersionUID = 1L;
	
	private String codigoUsuario;
	private ClienteDTO datosCliente;
	private boolean exitoCreacionUsuario;
	private DireccionNegocioDTO[] direccionNegocioDTO;
	
	 //-- Activaciones web Colombia
	 private String numeroAbonado;
	 private String nombreUsuario;
	 private String nombreApell1;
	 private String nombreApell2;
	 private String tipoIdentificador;
	 private String numeroIdentificador;
	 private String codigoProvincia;
	 private String nombreProvincia;
	 private String codigoCiudad;
	 private String nombreCiudad;
	 private String nombreCalle;
	 private String observacionDireccion;
	 private String fechaNacimiento;
	 private String codigoSexo;
	 private String codigoEstrato;
	 private String nombreMail;

	public boolean getExitoCreacionUusario() {
		return exitoCreacionUsuario;
	}

	public void setExitoCreacionUsuario(boolean exitoCreacionUsuario) {
		this.exitoCreacionUsuario = exitoCreacionUsuario;
	}

	public ClienteDTO getDatosCliente() {
		return datosCliente;
	}

	public void setDatosCliente(ClienteDTO datosCliente) {
		this.datosCliente = datosCliente;
	}

	public String getCodigoUsuario() {
		return codigoUsuario;
	}

	public void setCodigoUsuario(String codigoUsuario) {
		this.codigoUsuario = codigoUsuario;
	}

	public String getCodigoCiudad() {
		return codigoCiudad;
	}

	public void setCodigoCiudad(String codigoCiudad) {
		this.codigoCiudad = codigoCiudad;
	}

	public String getCodigoEstrato() {
		return codigoEstrato;
	}

	public void setCodigoEstrato(String codigoEstrato) {
		this.codigoEstrato = codigoEstrato;
	}

	public String getCodigoProvincia() {
		return codigoProvincia;
	}

	public void setCodigoProvincia(String codigoProvincia) {
		this.codigoProvincia = codigoProvincia;
	}

	public String getCodigoSexo() {
		return codigoSexo;
	}

	public void setCodigoSexo(String codigoSexo) {
		this.codigoSexo = codigoSexo;
	}

	public String getFechaNacimiento() {
		return fechaNacimiento;
	}

	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}

	public String getNombreApell1() {
		return nombreApell1;
	}

	public void setNombreApell1(String nombreApell1) {
		this.nombreApell1 = nombreApell1;
	}

	public String getNombreApell2() {
		return nombreApell2;
	}

	public void setNombreApell2(String nombreApell2) {
		this.nombreApell2 = nombreApell2;
	}

	public String getNombreCalle() {
		return nombreCalle;
	}

	public void setNombreCalle(String nombreCalle) {
		this.nombreCalle = nombreCalle;
	}

	public String getNombreCiudad() {
		return nombreCiudad;
	}

	public void setNombreCiudad(String nombreCiudad) {
		this.nombreCiudad = nombreCiudad;
	}

	public String getNombreMail() {
		return nombreMail;
	}

	public void setNombreMail(String nombreMail) {
		this.nombreMail = nombreMail;
	}

	public String getNombreProvincia() {
		return nombreProvincia;
	}

	public void setNombreProvincia(String nombreProvincia) {
		this.nombreProvincia = nombreProvincia;
	}

	public String getNombreUsuario() {
		return nombreUsuario;
	}

	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}

	public String getNumeroAbonado() {
		return numeroAbonado;
	}

	public void setNumeroAbonado(String numeroAbonado) {
		this.numeroAbonado = numeroAbonado;
	}

	public String getNumeroIdentificador() {
		return numeroIdentificador;
	}

	public void setNumeroIdentificador(String numeroIdentificador) {
		this.numeroIdentificador = numeroIdentificador;
	}

	public String getObservacionDireccion() {
		return observacionDireccion;
	}

	public void setObservacionDireccion(String observacionDireccion) {
		this.observacionDireccion = observacionDireccion;
	}

	public String getTipoIdentificador() {
		return tipoIdentificador;
	}

	public void setTipoIdentificador(String tipoIdentificador) {
		this.tipoIdentificador = tipoIdentificador;
	}

	public boolean isExitoCreacionUsuario() {
		return exitoCreacionUsuario;
	}

	public DireccionNegocioDTO[] getDireccionNegocioDTO() {
		return direccionNegocioDTO;
	}

	public void setDireccionNegocioDTO(DireccionNegocioDTO[] direccionNegocioDTO) {
		this.direccionNegocioDTO = direccionNegocioDTO;
	}
}
