package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;

public class OrdenServicioDTO   implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String codOs;
	private long numOs;
	private long codInter;
	private Date fechaOs;
	
	public long getCodInter() {
		return codInter;
	}
	public void setCodInter(long codInter) {
		this.codInter = codInter;
	}
	public String getCodOs() {
		return codOs;
	}
	public void setCodOs(String codOs) {
		this.codOs = codOs;
	}
	public Date getFechaOs() {
		return fechaOs;
	}
	public void setFechaOs(Date fechaOs) {
		this.fechaOs = fechaOs;
	}
	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}

}
