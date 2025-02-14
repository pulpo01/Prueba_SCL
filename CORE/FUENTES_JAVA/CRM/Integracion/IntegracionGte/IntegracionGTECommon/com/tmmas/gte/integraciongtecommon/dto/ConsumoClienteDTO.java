package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
/*
 * Autor: Daniel Jara
 */

public class ConsumoClienteDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long codCliente;
	private long fecTasa;
	private long codCiclo;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getFecTasa() {
		return fecTasa;
	}
	public void setFecTasa(long fecTasa) {
		this.fecTasa = fecTasa;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	
	
	
	
	
}