package com.tmmas.scl.wsventaenlace.transport.vo.asociarango;

import java.sql.Timestamp;

public class NumeroPilotoHVO extends NumeroPilotoVO {
	private Timestamp fechaHistorico;

	public NumeroPilotoHVO() {
	}

	public NumeroPilotoHVO(NumeroPilotoVO numeroPilotoVO, Timestamp fechaHistorico) {
		setNumPiloto(numeroPilotoVO.getNumPiloto());
		setNumDesde(numeroPilotoVO.getNumDesde());
		setNomUsuarOra(numeroPilotoVO.getNomUsuarOra());
		setFechaHistorico(fechaHistorico);
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer("NumeroPilotoHVO: ");

		buffer.append("numPiloto = ").append(getNumPiloto());
		buffer.append(", numDesde = ").append(getNumDesde());
		buffer.append(", fechaHistorico = [").append(fechaHistorico).append("]");
		buffer.append(", nomUsuarOra = [").append(getNomUsuarOra()).append("]");

		return buffer.toString();
	}

	public Timestamp getFechaHistorico() {
		return fechaHistorico;
	}

	public void setFechaHistorico(Timestamp fechaHistorico) {
		this.fechaHistorico = fechaHistorico;
	}
}
