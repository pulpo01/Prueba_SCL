package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class InWSPreActivaAbonadoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numCelular;//   IN ICC_MOVIMIENTO.NUM_CELULAR%TYPE,
	private long codUso;//IV_COD_PERFIL     IN AL_USOS.COD_USO%TYPE,
	private String identificadorTransaccion;
	public long getCodUso() {
		return codUso;
	}
	public void setCodUso(long codUso) {
		this.codUso = codUso;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getIdentificadorTransaccion() {
		return identificadorTransaccion;
	}
	public void setIdentificadorTransaccion(String identificadorTransaccion) {
		this.identificadorTransaccion = identificadorTransaccion;
	}
	



}
