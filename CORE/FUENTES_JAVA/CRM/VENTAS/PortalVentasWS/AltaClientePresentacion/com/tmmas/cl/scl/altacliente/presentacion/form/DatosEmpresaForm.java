package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;

public class DatosEmpresaForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String nombreEmpresa;

	private String razonSocial;

	private String patenteComercio;

	private String tipoIdentificacionRepLegal;

	private IdentificadorCivilComDTO[] arrayIdentificadorCliente;

	private String numeroIdentificacionRepLegal;

	private String nombreRepLegal;

	private String datosRepLegalMandatorio;

	public String getDatosRepLegalMandatorio() {
		return datosRepLegalMandatorio;
	}

	public void setDatosRepLegalMandatorio(String nombreRepLegalMandatorio) {
		this.datosRepLegalMandatorio = nombreRepLegalMandatorio;
	}

	public String getNombreEmpresa() {
		return nombreEmpresa;
	}

	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
	}

	public String getNombreRepLegal() {
		return nombreRepLegal;
	}

	public void setNombreRepLegal(String nombreRepLegal) {
		this.nombreRepLegal = nombreRepLegal;
	}

	public String getNumeroIdentificacionRepLegal() {
		return numeroIdentificacionRepLegal;
	}

	public void setNumeroIdentificacionRepLegal(String numeroIdentificacionRepLegal) {
		this.numeroIdentificacionRepLegal = numeroIdentificacionRepLegal;
	}

	public String getPatenteComercio() {
		return patenteComercio;
	}

	public void setPatenteComercio(String patenteComercio) {
		this.patenteComercio = patenteComercio;
	}

	public String getRazonSocial() {
		return razonSocial;
	}

	public void setRazonSocial(String razonSocial) {
		this.razonSocial = razonSocial;
	}

	public String getTipoIdentificacionRepLegal() {
		return tipoIdentificacionRepLegal;
	}

	public void setTipoIdentificacionRepLegal(String tipoIdentificacionRepLegal) {
		this.tipoIdentificacionRepLegal = tipoIdentificacionRepLegal;
	}

	public IdentificadorCivilComDTO[] getArrayIdentificadorCliente() {
		return arrayIdentificadorCliente;
	}

	public void setArrayIdentificadorCliente(IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCliente = arrayIdentificadorCliente;
	}

}
