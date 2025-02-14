package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;

public class CargosObtenidosDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private ObtencionCargosDTO ocacionales;
	private ObtencionCargosDTO recurrentes;
	private boolean aCiclo;
	
	public boolean isACiclo() {
		return aCiclo;
	}
	public void setACiclo(boolean ciclo) {
		aCiclo = ciclo;
	}
	public ObtencionCargosDTO getOcacionales() {
		return ocacionales;
	}
	public void setOcacionales(ObtencionCargosDTO ocacionales) {
		this.ocacionales = ocacionales;
	}
	public ObtencionCargosDTO getRecurrentes() {
		return recurrentes;
	}
	public void setRecurrentes(ObtencionCargosDTO recurrentes) {
		this.recurrentes = recurrentes;
	}
	

}