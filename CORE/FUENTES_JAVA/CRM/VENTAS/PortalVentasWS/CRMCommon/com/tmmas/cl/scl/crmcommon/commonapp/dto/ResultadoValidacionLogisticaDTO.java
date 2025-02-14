package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ResultadoValidacionLogisticaDTO extends ResultadoValidacionDTO{

	private static final long serialVersionUID = 1L;
	
	private int largoSerie;
	private boolean esMayoristaSimcard;
	private boolean esMayoristaTerminal;
    
	public int getLargoSerie() {
		return largoSerie;
	}
	public void setLargoSerie(int largoSerie) {
		this.largoSerie = largoSerie;
	}
	public boolean isEsMayoristaSimcard() {
		return esMayoristaSimcard;
	}
	public void setEsMayoristaSimcard(boolean esMayoristaSimcard) {
		this.esMayoristaSimcard = esMayoristaSimcard;
	}
	public boolean isEsMayoristaTerminal() {
		return esMayoristaTerminal;
	}
	public void setEsMayoristaTerminal(boolean esMayoristaTerminal) {
		this.esMayoristaTerminal = esMayoristaTerminal;
	}
}
