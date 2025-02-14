package com.tmmas.cl.scl.altaclientecommon.commonapp.dto;

import java.io.Serializable;

public class TarjetaDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String tipoTarjeta;

	private String numTarjeta;

	public String getNumTarjeta() {
		return numTarjeta;
	}

	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}

	public String getTipoTarjeta() {
		return tipoTarjeta;
	}

	public void setTipoTarjeta(String tipoTarjeta) {
		this.tipoTarjeta = tipoTarjeta;
	}

	
	/* (non-Javadoc)
	 * @see java.lang.Object#toString()
	 */
	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("TarjetaDTO ( ").append(super.toString()).append(nl);
		b.append("numTarjeta = ").append(this.numTarjeta).append(nl);
		b.append("tipoTarjeta = ").append(this.tipoTarjeta).append(nl);
		b.append(" )");
		return b.toString();
	}

}//fin class TarjetaDTO