package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class IdTipoPrestacionDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

    private String idTipoPrestacion;
    private GrupoPrestacionDTO[] grpPrestacionList;
    private AuditoriaDTO auditoria;

	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}

	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}

	public GrupoPrestacionDTO[] getGrpPrestacionList() {
		return grpPrestacionList;
	}

	public void setGrpPrestacionList(GrupoPrestacionDTO[] grpPrestacionList) {
		this.grpPrestacionList = grpPrestacionList;
	}

	public String getIdTipoPrestacion() {
		return idTipoPrestacion;
	}

	public void setIdTipoPrestacion(String idTipoPrestacion) {
		this.idTipoPrestacion = idTipoPrestacion;
	}


}