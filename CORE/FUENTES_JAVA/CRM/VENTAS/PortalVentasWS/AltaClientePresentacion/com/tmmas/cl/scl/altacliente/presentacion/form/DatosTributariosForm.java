package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.ClienteComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.DatosGeneralesComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.OficinaComDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.CategoriaCambioDTO;

public class DatosTributariosForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private FormularioDireccionDTO direccionPersonalForm;
	private FormularioDireccionDTO direccionFacturacionForm;
	private FormularioDireccionDTO direccionCorrespondenciaForm;
	private String direcionPersonal;
	private String facturaTercero;
	private String direccionFacturacion;
	private String direccionCorrespondencia;
	
	private String oficina;
	private OficinaComDTO[] arrayOficina;
	
	private String tipoIdentificacionTrib;
	private String numeroIdentificacionTrib;
	private boolean restriccionIdentTrib; 
	private IdentificadorCivilComDTO[] arrayIdentificadorCliente;
	
	private String categoriaImpositiva;
	private ClienteComDTO[] arrayCategImpos;
	
	private String categoriaTributaria;
	private DatosGeneralesComDTO[] arrayCategTrib;
	private String flagFacturacionTercero="0";
	
	private String flagClientePrepago ="0"; 
	private String categoriaCambio;
	
	
	
	private CategoriaCambioDTO[] arrayCategoriaCambio;
	
	public CategoriaCambioDTO[] getArrayCategoriaCambio() {
		return arrayCategoriaCambio;
	}
	public void setArrayCategoriaCambio(CategoriaCambioDTO[] arrayCategoriaCambio) {
		this.arrayCategoriaCambio = arrayCategoriaCambio;
	}
	public String getCategoriaCambio() {
		return categoriaCambio;
	}
	public void setCategoriaCambio(String categoriaCambio) {
		this.categoriaCambio = categoriaCambio;
	}
	public String getFlagClientePrepago() {
		return flagClientePrepago;
	}
	public void setFlagClientePrepago(String flagClientePrepago) {
		this.flagClientePrepago = flagClientePrepago;
	}
	public String getFlagFacturacionTercero() {
		return flagFacturacionTercero;
	}
	public void setFlagFacturacionTercero(String flagFacturacionTercero) {
		this.flagFacturacionTercero = flagFacturacionTercero;
	}
	public ClienteComDTO[] getArrayCategImpos() {
		return arrayCategImpos;
	}
	public void setArrayCategImpos(ClienteComDTO[] arrayCategImpos) {
		this.arrayCategImpos = arrayCategImpos;
	}
	public DatosGeneralesComDTO[] getArrayCategTrib() {
		return arrayCategTrib;
	}
	public void setArrayCategTrib(DatosGeneralesComDTO[] arrayCategTrib) {
		this.arrayCategTrib = arrayCategTrib;
	}
	public OficinaComDTO[] getArrayOficina() {
		return arrayOficina;
	}
	public void setArrayOficina(OficinaComDTO[] arrayOficina) {
		this.arrayOficina = arrayOficina;
	}
	public String getCategoriaImpositiva() {
		return categoriaImpositiva;
	}
	public void setCategoriaImpositiva(String categoriaImpositiva) {
		this.categoriaImpositiva = categoriaImpositiva;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getDireccionCorrespondencia() {
		return direccionCorrespondencia;
	}
	public void setDireccionCorrespondencia(String direccionCorrespondencia) {
		this.direccionCorrespondencia = direccionCorrespondencia;
	}
	public String getDireccionFacturacion() {
		return direccionFacturacion;
	}
	public void setDireccionFacturacion(String direccionFacturacion) {
		this.direccionFacturacion = direccionFacturacion;
	}
	public String getDirecionPersonal() {
		return direcionPersonal;
	}
	public void setDirecionPersonal(String direcionPersonal) {
		this.direcionPersonal = direcionPersonal;
	}

	public String getFacturaTercero() {
		return facturaTercero;
	}
	public void setFacturaTercero(String facturaTercero) {
		this.facturaTercero = facturaTercero;
	}
	public String getNumeroIdentificacionTrib() {
		return numeroIdentificacionTrib;
	}
	public void setNumeroIdentificacionTrib(String numeroIdentificacionTrib) {
		this.numeroIdentificacionTrib = numeroIdentificacionTrib;
	}
	public String getOficina() {
		return oficina;
	}
	public void setOficina(String oficina) {
		this.oficina = oficina;
	}
	public boolean isRestriccionIdentTrib() {
		return restriccionIdentTrib;
	}
	public void setRestriccionIdentTrib(boolean restriccionIdentTrib) {
		this.restriccionIdentTrib = restriccionIdentTrib;
	}
	public String getTipoIdentificacionTrib() {
		return tipoIdentificacionTrib;
	}
	public void setTipoIdentificacionTrib(String tipoIdentificacionTrib) {
		this.tipoIdentificacionTrib = tipoIdentificacionTrib;
	}
	public IdentificadorCivilComDTO[] getArrayIdentificadorCliente() {
		return arrayIdentificadorCliente;
	}
	public void setArrayIdentificadorCliente(
			IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCliente = arrayIdentificadorCliente;
	}
	public FormularioDireccionDTO getDireccionCorrespondenciaForm() {
		return direccionCorrespondenciaForm;
	}
	public void setDireccionCorrespondenciaForm(
			FormularioDireccionDTO direccionCorrespondenciaForm) {
		this.direccionCorrespondenciaForm = direccionCorrespondenciaForm;
	}
	public FormularioDireccionDTO getDireccionFacturacionForm() {
		return direccionFacturacionForm;
	}
	public void setDireccionFacturacionForm(
			FormularioDireccionDTO direccionFacturacionForm) {
		this.direccionFacturacionForm = direccionFacturacionForm;
	}
	public FormularioDireccionDTO getDireccionPersonalForm() {
		return direccionPersonalForm;
	}
	public void setDireccionPersonalForm(
			FormularioDireccionDTO direccionPersonalForm) {
		this.direccionPersonalForm = direccionPersonalForm;
	}

	private String aplicaFacturaTercero;
	
	public final String getAplicaFacturaTercero() {
		return aplicaFacturaTercero;
	}
	
	public final void setAplicaFacturaTercero(String aplicaFacturaTercero) {
		this.aplicaFacturaTercero = aplicaFacturaTercero;
	}
	
	private String aplicaCategoriaCambio;
	


	public final String getAplicaCategoriaCambio() {
		return aplicaCategoriaCambio;
	}
	public final void setAplicaCategoriaCambio(String aplicaCategoriaCambio) {
		this.aplicaCategoriaCambio = aplicaCategoriaCambio;
	}
	
	
}
