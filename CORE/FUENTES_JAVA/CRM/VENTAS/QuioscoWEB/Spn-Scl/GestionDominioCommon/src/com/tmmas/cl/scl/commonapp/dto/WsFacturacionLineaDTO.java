package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsFacturacionLineaDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numCelular;
	private float mntoDscSimcard;
	private float mntoDscTerminal;
	
	
	public float getMntoDscSimcard() {
		return mntoDscSimcard;
	}
	public void setMntoDscSimcard(float mntoDscSimcard) {
		this.mntoDscSimcard = mntoDscSimcard;
	}
	public float getMntoDscTerminal() {
		return mntoDscTerminal;
	}
	public void setMntoDscTerminal(float mntoDscTerminal) {
		this.mntoDscTerminal = mntoDscTerminal;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	
	

	
	
}
