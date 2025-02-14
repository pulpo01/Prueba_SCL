package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class GrpCodPrestacionListDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;

	private GrupoPrestacionDTO[] grpPrestacionList;
    private CodPrestacionDTO[] codPrestacionList;
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

	public CodPrestacionDTO[] getCodPrestacionList() {
		return codPrestacionList;
	}

	public void setCodPrestacionList(CodPrestacionDTO[] codPrestacionList) {
		this.codPrestacionList = codPrestacionList;
	}


}