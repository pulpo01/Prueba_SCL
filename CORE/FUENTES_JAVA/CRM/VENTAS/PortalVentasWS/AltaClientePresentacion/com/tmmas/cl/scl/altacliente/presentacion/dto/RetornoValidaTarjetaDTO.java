/**
 * 
 */
package com.tmmas.cl.scl.altacliente.presentacion.dto;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class RetornoValidaTarjetaDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 5687091042230800149L;

	private boolean valido;

	private String codError;

	private String msgError;

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getMsgError() {
		return msgError;
	}

	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

	public boolean isValido() {
		return valido;
	}

	public void setValido(boolean valido) {
		this.valido = valido;
	}

	public RetornoValidaTarjetaDTO() {
		super();
	}

	public RetornoValidaTarjetaDTO(boolean valido, String codError, String msgError) {
		super();
		this.valido = valido;
		this.codError = codError;
		this.msgError = msgError;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		final String newLine = "\n";
		StringBuffer b = new StringBuffer();
		b.append("RetornoValidaTarjetaDTO ( ").append(super.toString()).append(newLine);
		b.append("codError = ").append(this.codError).append(newLine);
		b.append("msgError = ").append(this.msgError).append(newLine);
		b.append("valido = ").append(this.valido).append(newLine);
		b.append(" )");
		return b.toString();
	}
}
