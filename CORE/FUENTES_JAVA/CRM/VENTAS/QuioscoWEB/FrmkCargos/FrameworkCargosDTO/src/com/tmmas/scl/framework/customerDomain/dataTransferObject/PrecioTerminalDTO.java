/**
 * 
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

/**
 * @author rlozano
 */
public class PrecioTerminalDTO  extends PrecioDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String valDescto;
	private String tipDescto;
	
	public String getTipDescto() {
		return tipDescto;
	}
	public void setTipDescto(String tipDescto) {
		this.tipDescto = tipDescto;
	}
	public String getValDescto() {
		return valDescto;
	}
	public void setValDescto(String valDescto) {
		this.valDescto = valDescto;
	}
}
