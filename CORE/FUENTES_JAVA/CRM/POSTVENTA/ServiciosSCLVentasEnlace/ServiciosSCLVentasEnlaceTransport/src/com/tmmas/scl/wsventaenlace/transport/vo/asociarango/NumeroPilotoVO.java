package com.tmmas.scl.wsventaenlace.transport.vo.asociarango;

public class NumeroPilotoVO {
	private static final long serialVersionUID = 1L;
	private long numPiloto;
	private long numDesde;
	private String nomUsuarOra;

	public String toString() {
		StringBuffer buffer = new StringBuffer("NumeroPilotoVO: ");

		buffer.append("numPiloto = ").append(numPiloto);
		buffer.append(", numDesde = ").append(numDesde);
		buffer.append(", nomUsuarOra = [").append(nomUsuarOra).append("]");

		return buffer.toString();
	}

	public NumeroPilotoVO() {
	}

	public NumeroPilotoVO(long numPiloto, long numDesde, String nomUsuarOra) {
		this.numPiloto = numPiloto;
		this.numDesde = numDesde;
		this.nomUsuarOra = nomUsuarOra;
	}

	public String getNomUsuarOra() {
		return nomUsuarOra;
	}

	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}

	public long getNumDesde() {
		return numDesde;
	}

	public void setNumDesde(long numDesde) {
		this.numDesde = numDesde;
	}

	public long getNumPiloto() {
		return numPiloto;
	}

	public void setNumPiloto(long numPiloto) {
		this.numPiloto = numPiloto;
	}
}
