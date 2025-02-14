package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class SerieKitDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String numSerieSimcard;
	private String numSerieTerminal;
	private String numSerieKit = new String();
	
	
	public String getNumSerieKit() {
		return numSerieKit;
	}
	public void setNumSerieKit(String numSerieKit) {
		this.numSerieKit = numSerieKit;
	}
	public String getNumSerieSimcard() {
		return numSerieSimcard;
	}
	public void setNumSerieSimcard(String numSerieSimcard) {
		this.numSerieSimcard = numSerieSimcard;
	}
	public String getNumSerieTerminal() {
		return numSerieTerminal;
	}
	public void setNumSerieTerminal(String numSerieTerminal) {
		this.numSerieTerminal = numSerieTerminal;
	}

}
