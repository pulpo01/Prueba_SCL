package com.tmmas.scl.operations.crm.fab.cusintman.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.ArticuloAjaxDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.SerieAjaxDTO;

public class BuscaSimcardForm extends ActionForm {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codCriterioBusqueda;
	private String codBodega;
	private BodegaDTO[] arrayBodegas;
	private String codArticulo;
	private ArticuloAjaxDTO[] arrayArticulos;
	private String txtFiltro;
	private String linkOrigen = "SIMCARD";
	private String codProcedencia = "-1";
	private DatosGeneralesDTO[] arrayProcedencia;
	private String numeroSerieSel;
	private String simcardAnteriorRes;
	private String equipoAnteriorRes;
	private String flgEquipoFijo = "0";
	private String codArticuloKIT;
	private SerieAjaxDTO[] serieAjaxDTOs;
	private String mensaje;
	
	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}
	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public BodegaDTO[] getArrayBodegas() {
		return arrayBodegas;
	}
	public void setArrayBodegas(BodegaDTO[] arrayBodegas) {
		this.arrayBodegas = arrayBodegas;
	}
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getTxtFiltro() {
		return txtFiltro;
	}
	public void setTxtFiltro(String txtFiltro) {
		this.txtFiltro = txtFiltro;
	}
	public String getLinkOrigen() {
		return linkOrigen;
	}
	public void setLinkOrigen(String linkOrigen) {
		this.linkOrigen = linkOrigen;
	}
	public String getCodProcedencia() {
		return codProcedencia;
	}
	public void setCodProcedencia(String codProcedencia) {
		this.codProcedencia = codProcedencia;
	}
	public DatosGeneralesDTO[] getArrayProcedencia() {
		return arrayProcedencia;
	}
	public void setArrayProcedencia(DatosGeneralesDTO[] arrayProcedencia) {
		this.arrayProcedencia = arrayProcedencia;
	}
	public String getNumeroSerieSel() {
		return numeroSerieSel;
	}
	public void setNumeroSerieSel(String numeroSerieSel) {
		this.numeroSerieSel = numeroSerieSel;
	}
	public String getSimcardAnteriorRes() {
		return simcardAnteriorRes;
	}
	public void setSimcardAnteriorRes(String simcardAnteriorRes) {
		this.simcardAnteriorRes = simcardAnteriorRes;
	}
	public String getEquipoAnteriorRes() {
		return equipoAnteriorRes;
	}
	public void setEquipoAnteriorRes(String equipoAnteriorRes) {
		this.equipoAnteriorRes = equipoAnteriorRes;
	}
	public String getFlgEquipoFijo() {
		return flgEquipoFijo;
	}
	public void setFlgEquipoFijo(String flgEquipoFijo) {
		this.flgEquipoFijo = flgEquipoFijo;
	}
	public String getCodArticuloKIT() {
		return codArticuloKIT;
	}
	public void setCodArticuloKIT(String codArticuloKIT) {
		this.codArticuloKIT = codArticuloKIT;
	}
	public ArticuloAjaxDTO[] getArrayArticulos() {
		return arrayArticulos;
	}
	public void setArrayArticulos(ArticuloAjaxDTO[] arrayArticulos) {
		this.arrayArticulos = arrayArticulos;
	}
	public SerieAjaxDTO[] getSerieAjaxDTOs() {
		return serieAjaxDTOs;
	}
	public void setSerieAjaxDTOs(SerieAjaxDTO[] serieAjaxDTOs) {
		this.serieAjaxDTOs = serieAjaxDTOs;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	
	
}
