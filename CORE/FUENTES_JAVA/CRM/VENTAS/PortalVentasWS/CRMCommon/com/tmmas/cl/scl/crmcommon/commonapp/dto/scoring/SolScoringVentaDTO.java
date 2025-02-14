package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class SolScoringVentaDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 7245544804324226804L;

	private long numSolScoring;

	private long numVenta;

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	
}
