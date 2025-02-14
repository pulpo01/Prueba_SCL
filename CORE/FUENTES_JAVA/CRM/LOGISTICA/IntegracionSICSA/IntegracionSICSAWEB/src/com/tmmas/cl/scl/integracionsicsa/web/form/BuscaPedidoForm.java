package com.tmmas.cl.scl.integracionsicsa.web.form;

import org.apache.struts.action.ActionForm;

public class BuscaPedidoForm extends ActionForm {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 *@author H.O.M
	 */
	
	private String txtPedido;
	private String fec_desde;
	private String fec_hasta;

	public String getTxtPedido() {
		return txtPedido;
	}
	public void setTxtPedido(String txtPedido) {
		this.txtPedido = txtPedido;
	}
	public String getFec_desde() {
		return fec_desde;
	}
	public void setFec_desde(String fecDesde) {
		fec_desde = fecDesde;
	}
	public String getFec_hasta() {
		return fec_hasta;
	}
	public void setFec_hasta(String fecHasta) {
		fec_hasta = fecHasta;
	}	
}
