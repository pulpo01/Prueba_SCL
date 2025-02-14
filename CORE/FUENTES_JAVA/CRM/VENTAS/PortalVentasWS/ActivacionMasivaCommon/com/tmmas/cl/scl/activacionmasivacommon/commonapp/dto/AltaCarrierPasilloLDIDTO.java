/**
 * DTO para la funcionalidad de Alta Carrier Pasillo LDI
 */
package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

/**
 * @author mwn40031
 */
public class AltaCarrierPasilloLDIDTO implements Serializable {

	private static final long serialVersionUID = -8930594242762209499L;

	private String apellido1;

	private String apellido2;

	private String codOperadora;

	private String codTipoCliente;

	private String nombreEmpresa;

	private String nombres;

	private String nomUsuarioOra;

	private String numCelularExterno;

	private String razonSocial;

	private String codRegion; // Depto.

	private String codZIP;

	private String codProvincia; // Municipio

	private String codTipoCalle;

	private String codCiudad; // Zona

	private String desDireccion1;

	private String nomCalle;

	private String numCalle;

	private String obsDireccion;

	private String codOficina;

	private String codVendedor;

	private String codTipComis;

	private String codigoPlanTarifario;

	private String codComuna;

	private String desDireccion2;

	public String getDesDireccion2() {
		return desDireccion2;
	}

	public void setDesDireccion2(String desDireccion2) {
		this.desDireccion2 = desDireccion2;
	}

	public String getCodComuna() {
		return codComuna;
	}

	public void setCodComuna(String codComuna) {
		this.codComuna = codComuna;
	}

	public final String getApellido1() {
		return apellido1;
	}

	public final String getApellido2() {
		return apellido2;
	}

	public final String getCodOperadora() {
		return codOperadora;
	}

	public final void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public final String getCodTipoCliente() {
		return codTipoCliente;
	}

	public final String getNombreEmpresa() {
		return nombreEmpresa;
	}

	public final String getNombres() {
		return nombres;
	}

	public final String getNomUsuarioOra() {
		return nomUsuarioOra;
	}

	public final String getNumCelularExterno() {
		return numCelularExterno;
	}

	public final String getRazonSocial() {
		return razonSocial;
	}

	public final void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}

	public final void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}

	public final void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public final void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}

	public final void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public final void setNomUsuarioOra(String nomUsuarioOra) {
		this.nomUsuarioOra = nomUsuarioOra;
	}

	public final void setNumCelularExterno(String numCelularExterno) {
		this.numCelularExterno = numCelularExterno;
	}

	public final void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public final String getCodCiudad() {
		return codCiudad;
	}

	public final void setCodCiudad(String codCiudad) {
		this.codCiudad = codCiudad;
	}

	public final String getCodProvincia() {
		return codProvincia;
	}

	public final void setCodProvincia(String codProvincia) {
		this.codProvincia = codProvincia;
	}

	public final String getCodRegion() {
		return codRegion;
	}

	public final void setCodRegion(String codRegion) {
		this.codRegion = codRegion;
	}

	public final String getCodTipoCalle() {
		return codTipoCalle;
	}

	public final void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}

	public final String getCodZIP() {
		return codZIP;
	}

	public final void setCodZIP(String codZIP) {
		this.codZIP = codZIP;
	}

	public final String getDesDireccion1() {
		return desDireccion1;
	}

	public final void setDesDireccion1(String desDireccion1) {
		this.desDireccion1 = desDireccion1;
	}

	public final String getNomCalle() {
		return nomCalle;
	}

	public final void setNomCalle(String nomCalle) {
		this.nomCalle = nomCalle;
	}

	public final String getNumCalle() {
		return numCalle;
	}

	public final void setNumCalle(String numCalle) {
		this.numCalle = numCalle;
	}

	public final String getObsDireccion() {
		return obsDireccion;
	}

	public final void setObsDireccion(String obsDireccion) {
		this.obsDireccion = obsDireccion;
	}

	public final String getCodOficina() {
		return codOficina;
	}

	public final void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	public final String getCodTipComis() {
		return codTipComis;
	}

	public final void setCodTipComis(String codTipComis) {
		this.codTipComis = codTipComis;
	}

	public final String getCodVendedor() {
		return codVendedor;
	}

	public final void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}

	private String codCelda;

	private String codCentral;

	public final String getCodCelda() {
		return codCelda;
	}

	public final void setCodCelda(String codCelda) {
		this.codCelda = codCelda;
	}

	public final String getCodCentral() {
		return codCentral;
	}

	public final void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}

	public final String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}

	public final void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("AltaCarrierPasilloLDIDTO ( ").append(super.toString()).append(nl);
		b.append("apellido1 = ").append(this.apellido1).append(nl);
		b.append("apellido2 = ").append(this.apellido2).append(nl);
		b.append("codCelda = ").append(this.codCelda).append(nl);
		b.append("codCentral = ").append(this.codCentral).append(nl);
		b.append("codCiudad = ").append(this.codCiudad).append(nl);
		b.append("codComuna = ").append(this.codComuna).append(nl);
		b.append("codOficina = ").append(this.codOficina).append(nl);
		b.append("codOperadora = ").append(this.codOperadora).append(nl);
		b.append("codProvincia = ").append(this.codProvincia).append(nl);
		b.append("codRegion = ").append(this.codRegion).append(nl);
		b.append("codTipComis = ").append(this.codTipComis).append(nl);
		b.append("codTipoCalle = ").append(this.codTipoCalle).append(nl);
		b.append("codTipoCliente = ").append(this.codTipoCliente).append(nl);
		b.append("codVendedor = ").append(this.codVendedor).append(nl);
		b.append("codZIP = ").append(this.codZIP).append(nl);
		b.append("codigoPlanTarifario = ").append(this.codigoPlanTarifario).append(nl);
		b.append("desDireccion1 = ").append(this.desDireccion1).append(nl);
		b.append("desDireccion2 = ").append(this.desDireccion2).append(nl);
		b.append("nomCalle = ").append(this.nomCalle).append(nl);
		b.append("nomUsuarioOra = ").append(this.nomUsuarioOra).append(nl);
		b.append("nombreEmpresa = ").append(this.nombreEmpresa).append(nl);
		b.append("nombres = ").append(this.nombres).append(nl);
		b.append("numCalle = ").append(this.numCalle).append(nl);
		b.append("numCelularExterno = ").append(this.numCelularExterno).append(nl);
		b.append("obsDireccion = ").append(this.obsDireccion).append(nl);
		b.append("razonSocial = ").append(this.razonSocial).append(nl);
		b.append(" )");
		return b.toString();
	}

}
