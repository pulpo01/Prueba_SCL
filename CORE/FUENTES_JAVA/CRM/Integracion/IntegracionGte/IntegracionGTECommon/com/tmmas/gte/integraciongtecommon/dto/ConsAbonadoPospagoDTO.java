package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;



public class ConsAbonadoPospagoDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private long codCliente;
	private int codCiclo;
	private long codCicloFact;
	private RespuestaDTO respuesta;
	
	public int getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(int codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(long codCicloFact) {
		this.codCicloFact = codCicloFact;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}


}
