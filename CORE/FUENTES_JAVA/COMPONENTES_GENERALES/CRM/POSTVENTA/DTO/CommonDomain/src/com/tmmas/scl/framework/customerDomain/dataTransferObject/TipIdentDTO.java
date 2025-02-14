/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Esteban Conejeros       				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
public class TipIdentDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codTipIdent;
	private String descTipIdent;
	
	
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
	}
	public String getDescTipIdent() {
		return descTipIdent;
	}
	public void setDescTipIdent(String descTipIdent) {
		this.descTipIdent = descTipIdent;
	}
	
	
	
}
