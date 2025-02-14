package com.tmmas.scl.doblecuenta.form;

import org.apache.struts.action.ActionForm;

public class DobleCuentaForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7750236374532120610L;
	
	private String codigo_Abonado;
	private String numero_Celular;
	private String desc_Abonado;
	private String cod_Clien_Asociado;
	private String desc_Clien_Asociado;
	private String codigo_Concepto;
	private String desc_Concepto;
	private String valor_1;
	private String num_Secuencia_Detalle;
	private String listaAbonado;
	private String conceptoList;

	public String getConceptoList() {
		return conceptoList;
	}
	public void setConceptoList(String conceptoList) {
		this.conceptoList = conceptoList;
	}
	public String getListaAbonado() {
		return listaAbonado;
	}
	public void setListaAbonado(String listaAbonado) {
		this.listaAbonado = listaAbonado;
	}
	public String getCod_Clien_Asociado() {
		return cod_Clien_Asociado;
	}
	public void setCod_Clien_Asociado(String cod_Clien_Asociado) {
		this.cod_Clien_Asociado = cod_Clien_Asociado;
	}
	public String getCodigo_Abonado() {
		return codigo_Abonado;
	}
	public void setCodigo_Abonado(String codigo_Abonado) {
		this.codigo_Abonado = codigo_Abonado;
	}
	public String getCodigo_Concepto() {
		return codigo_Concepto;
	}
	public void setCodigo_Concepto(String codigo_Concepto) {
		this.codigo_Concepto = codigo_Concepto;
	}
	public String getDesc_Abonado() {
		return desc_Abonado;
	}
	public void setDesc_Abonado(String desc_Abonado) {
		this.desc_Abonado = desc_Abonado;
	}
	public String getDesc_Clien_Asociado() {
		return desc_Clien_Asociado;
	}
	public void setDesc_Clien_Asociado(String desc_Clien_Asociado) {
		this.desc_Clien_Asociado = desc_Clien_Asociado;
	}
	public String getDesc_Concepto() {
		return desc_Concepto;
	}
	public void setDesc_Concepto(String desc_Concepto) {
		this.desc_Concepto = desc_Concepto;
	}
	public String getNum_Secuencia_Detalle() {
		return num_Secuencia_Detalle;
	}
	public void setNum_Secuencia_Detalle(String num_Secuencia_Detalle) {
		this.num_Secuencia_Detalle = num_Secuencia_Detalle;
	}
	public String getNumero_Celular() {
		return numero_Celular;
	}
	public void setNumero_Celular(String numero_Celular) {
		this.numero_Celular = numero_Celular;
	}
	public String getValor_1() {
		return valor_1;
	}
	public void setValor_1(String valor_1) {
		this.valor_1 = valor_1;
	}
	

}
