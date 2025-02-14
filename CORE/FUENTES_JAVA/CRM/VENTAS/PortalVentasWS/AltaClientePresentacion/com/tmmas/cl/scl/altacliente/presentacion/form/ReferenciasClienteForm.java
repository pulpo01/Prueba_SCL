package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioReferenciaClienteDTO;

public class ReferenciasClienteForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String numReferencia = "0";

	private String nombreReferencia;

	private String primerApellido;

	private String segundoApellido;

	private String telefonoReferenciaFijo;

	private String telefonoReferenciaMovil;

	private String largoNumCelular;

	private String maximoReferencias;

	private String codTipoCliente;

	private String codTipoClienteEmpresa;

	private FormularioReferenciaClienteDTO[] arrayRefCliente;

	public FormularioReferenciaClienteDTO[] getArrayRefCliente() {
		return arrayRefCliente;
	}

	public void setArrayRefCliente(FormularioReferenciaClienteDTO[] arrayRefCliente) {
		this.arrayRefCliente = arrayRefCliente;
	}

	public String getNombreReferencia() {
		return nombreReferencia;
	}

	public void setNombreReferencia(String nombreReferencia) {
		this.nombreReferencia = (nombreReferencia == null) ? "" : nombreReferencia.trim();
	}

	public String getNumReferencia() {
		return numReferencia;
	}

	public void setNumReferencia(String numReferencia) {
		this.numReferencia = numReferencia;
	}

	public String getPrimerApellido() {
		return primerApellido;
	}

	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = (primerApellido == null) ? "" : primerApellido.trim();
	}

	public String getSegundoApellido() {
		return segundoApellido;
	}

	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = (segundoApellido == null) ? "" : segundoApellido.trim();
	}

	public String getTelefonoReferenciaFijo() {
		return telefonoReferenciaFijo;
	}

	public void setTelefonoReferenciaFijo(String telefonoRef) {
		this.telefonoReferenciaFijo = telefonoRef;
	}

	public String getLargoNumCelular() {
		return largoNumCelular;
	}

	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}

	public String getMaximoReferencias() {
		return maximoReferencias;
	}

	public void setMaximoReferencias(String maximoReferencias) {
		this.maximoReferencias = maximoReferencias;
	}

	public String getTelefonoReferenciaMovil() {
		return telefonoReferenciaMovil;
	}

	public void setTelefonoReferenciaMovil(String telefonoMovilRef) {
		this.telefonoReferenciaMovil = telefonoMovilRef;
	}

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public String getCodTipoClienteEmpresa() {
		return codTipoClienteEmpresa;
	}

	public void setCodTipoClienteEmpresa(String codTipoClienteEmpresa) {
		this.codTipoClienteEmpresa = codTipoClienteEmpresa;
	}

}
