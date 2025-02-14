package com.tmmas.cl.scl.integracionsicsa.web.form;

import org.apache.struts.action.ActionForm;

public class BuscaDetallePedidoForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 *@author H.O.M
	 */
	
	private String codPedidoBusc;
	private String linPedidoBusc;
	private String opcion;
	private String nomArticulo;
	
	public String getNomArticulo() {
		return nomArticulo;
	}
	public void setNomArticulo(String nomArticulo) {
		this.nomArticulo = nomArticulo;
	}
	public String getLinPedidoBusc() {
		return linPedidoBusc;
	}
	public void setLinPedidoBusc(String linPedidoBusc) {
		this.linPedidoBusc = linPedidoBusc;
	}
	public String getOpcion() {
		return opcion;
	}
	public void setOpcion(String opcion) {
		this.opcion = opcion;
	}
	public String getCodPedidoBusc() {
		return codPedidoBusc;
	}
	public void setCodPedidoBusc(String codPedidoBusc) {
		this.codPedidoBusc = codPedidoBusc;
	}
	
	
}
