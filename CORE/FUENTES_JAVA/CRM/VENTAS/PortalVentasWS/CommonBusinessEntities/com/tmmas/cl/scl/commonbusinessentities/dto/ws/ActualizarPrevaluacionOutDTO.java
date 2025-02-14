/**
 * 
 */
package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

/**
 * @author mwn90113
 *
 */
public class ActualizarPrevaluacionOutDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 2680847164986928565L;
	private Long codError;
	private String msgError;
	private Long codEvento;
	
	
	public Long getCodError() {
		return codError;
	}
	public void setCodError(Long codError) {
		this.codError = codError;
	}
	public Long getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}
	public String getMsgError() {
		return msgError;
	}
	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}
}
