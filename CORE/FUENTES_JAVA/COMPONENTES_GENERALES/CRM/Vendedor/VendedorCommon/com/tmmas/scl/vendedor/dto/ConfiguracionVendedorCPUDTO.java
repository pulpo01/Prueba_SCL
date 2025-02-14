package com.tmmas.scl.vendedor.dto;

import java.io.Serializable;

public class ConfiguracionVendedorCPUDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String cod_ooss;
	private String combinatoria;
	private int flag_estado;
	private String mensaje;
	private String codMensaje;
	private long codTipMensaje;		
	
	
	public String getCod_ooss() {
		return cod_ooss;
	}
	public void setCod_ooss(String cod_ooss) {
		this.cod_ooss = cod_ooss;
	}
	public String getCombinatoria() {
		return combinatoria;
	}
	public void setCombinatoria(String combinatoria) {
		this.combinatoria = combinatoria;
	}
	public int getFlag_estado() {
		return flag_estado;
	}
	public void setFlag_estado(int flag_estado) {
		this.flag_estado = flag_estado;
	}
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public long getCodTipMensaje() {
		return codTipMensaje;
	}
	public void setCodTipMensaje(long codTipMensaje) {
		this.codTipMensaje = codTipMensaje;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	

}
