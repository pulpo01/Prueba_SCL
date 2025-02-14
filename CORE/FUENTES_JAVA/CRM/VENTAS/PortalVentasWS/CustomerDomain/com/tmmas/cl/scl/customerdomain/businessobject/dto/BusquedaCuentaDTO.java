package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class BusquedaCuentaDTO implements Serializable {

	private static final long serialVersionUID = -6457499818915053464L;

	private String codCuenta;

	private String codTipoIdentificacion;

	private String numIdentificacion;

	private String codTipoCuenta;

	private String telefonoContacto;

	private String nombreCuenta;

	private String nombreResponsable;

	public String getCodCuenta() {
		return codCuenta;
	}

	public void setCodCuenta(String codCuenta) {
		this.codCuenta = codCuenta;
	}

	public String getCodTipoCuenta() {
		return codTipoCuenta;
	}

	public void setCodTipoCuenta(String codTipoCuenta) {
		this.codTipoCuenta = codTipoCuenta;
	}

	public String getCodTipoIdentificacion() {
		return codTipoIdentificacion;
	}

	public void setCodTipoIdentificacion(String codTipoIdentificacion) {
		this.codTipoIdentificacion = codTipoIdentificacion;
	}

	public String getNombreCuenta() {
		return nombreCuenta;
	}

	public void setNombreCuenta(String nombreCuenta) {
		this.nombreCuenta = nombreCuenta;
	}

	public String getNumIdentificacion() {
		return numIdentificacion;
	}

	public void setNumIdentificacion(String numIdentificacion) {
		this.numIdentificacion = numIdentificacion;
	}

	public String getTelefonoContacto() {
		return telefonoContacto;
	}

	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}

	public String getNombreResponsable() {
		return nombreResponsable;
	}

	public void setNombreResponsable(String nombreResponsable) {
		this.nombreResponsable = nombreResponsable;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";

		StringBuffer b = new StringBuffer();

		b.append("BusquedaCuentaDTO ( ").append(super.toString()).append(newLine);
		b.append("codCuenta = ").append(this.codCuenta).append(newLine);
		b.append("codTipoCuenta = ").append(this.codTipoCuenta).append(newLine);
		b.append("codTipoIdentificacion = ").append(this.codTipoIdentificacion).append(newLine);
		b.append("nombreCuenta = ").append(this.nombreCuenta).append(newLine);
		b.append("nombreResponsable = ").append(this.nombreResponsable).append(newLine);
		b.append("numIdentificacion = ").append(this.numIdentificacion).append(newLine);
		b.append("telefonoContacto = ").append(this.telefonoContacto).append(newLine);
		b.append(" )");

		return b.toString();
	}

}
