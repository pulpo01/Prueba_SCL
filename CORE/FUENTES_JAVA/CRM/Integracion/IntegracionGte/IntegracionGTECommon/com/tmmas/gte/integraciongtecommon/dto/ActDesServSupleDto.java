package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;



public class ActDesServSupleDto implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private AuditoriaDTO auditoria;
	private long numTelefono;
	private boolean actDes;
	private EntServSupleDTO[] listaActDesSS;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public boolean isActDes() {
		return actDes;
	}
	public void setActDes(boolean actDes) {
		this.actDes = actDes;
	}
	public AuditoriaDTO getAuditoria() {
		return auditoria;
	}
	public void setAuditoria(AuditoriaDTO auditoria) {
		this.auditoria = auditoria;
	}
	public EntServSupleDTO[] getListaActDesSS() {
		return listaActDesSS;
	}
	public void setListaActDesSS(EntServSupleDTO[] listaActDesSS) {
		this.listaActDesSS = listaActDesSS;
	}
	public long getNumTelefono() {
		return numTelefono;
	}
	public void setNumTelefono(long numTelefono) {
		this.numTelefono = numTelefono;
	}
	
	
	
}
