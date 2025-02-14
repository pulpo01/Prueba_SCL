package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ArticuloAjaxDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BodegaDTO;

public class BuscaSeriesForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String codCriterioBusqueda;
	private String codBodega;
	private BodegaDTO[] arrayBodegas;
	private String codArticulo;
	//P-CSR-11002 JLGN 27-10-2011
	private String codArticuloSeleccionado;
	private ArticuloAjaxDTO[] arrayArticulos;
	private String txtFiltro;
	private String linkOrigen;
	private String codProcedencia;
	private DatosGeneralesDTO[] arrayProcedencia;
	private String numeroSerieSel;
	private String simcardAnteriorRes;
	private String equipoAnteriorRes;
	private String flgEquipoFijo = "0";
	private String codArticuloKIT;
	private String mensajeError;
	
	public String getMensajeError() {
		return mensajeError;
	}
	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}
	public String getCodArticuloKIT() {
		return codArticuloKIT;
	}
	public void setCodArticuloKIT(String codArticuloKIT) {
		this.codArticuloKIT = codArticuloKIT;
	}
	public String getFlgEquipoFijo() {
		return flgEquipoFijo;
	}
	public void setFlgEquipoFijo(String flgEquipoFijo) {
		this.flgEquipoFijo = flgEquipoFijo;
	}
	public String getNumeroSerieSel() {
		return numeroSerieSel;
	}
	public void setNumeroSerieSel(String numeroSerieSel) {
		this.numeroSerieSel = numeroSerieSel;
	}
	public String getCodProcedencia() {
		return codProcedencia;
	}
	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}
	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}
	public String getLinkOrigen() {
		return linkOrigen;
	}
	public void setLinkOrigen(String linkOrigen) {
		this.linkOrigen = linkOrigen;
	}
	public String getTxtFiltro() {
		return txtFiltro;
	}
	public void setTxtFiltro(String txtFiltro) {
		this.txtFiltro = txtFiltro;
	}
	public DatosGeneralesDTO[] getArrayProcedencia() {
		return arrayProcedencia;
	}
	public void setArrayProcedencia(DatosGeneralesDTO[] arrayProcedencia) {
		this.arrayProcedencia = arrayProcedencia;
	}

	public BodegaDTO[] getArrayBodegas() {
		return arrayBodegas;
	}
	public void setArrayBodegas(BodegaDTO[] arrayBodegas) {
		this.arrayBodegas = arrayBodegas;
	}
	public ArticuloAjaxDTO[] getArrayArticulos() {
		return arrayArticulos;
	}
	public void setArrayArticulos(ArticuloAjaxDTO[] arrayArticulos) {
		this.arrayArticulos = arrayArticulos;
	}
	public String getEquipoAnteriorRes() {
		return equipoAnteriorRes;
	}
	public void setEquipoAnteriorRes(String equipoAnteriorRes) {
		this.equipoAnteriorRes = equipoAnteriorRes;
	}
	public String getSimcardAnteriorRes() {
		return simcardAnteriorRes;
	}
	public void setSimcardAnteriorRes(String simcardAnteriorRes) {
		this.simcardAnteriorRes = simcardAnteriorRes;
	}
	public String getCodArticuloSeleccionado() {
		return codArticuloSeleccionado;
	}
	public void setCodArticuloSeleccionado(String codArticuloSeleccionado) {
		this.codArticuloSeleccionado = codArticuloSeleccionado;
	}

}
