
package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;


public class ReporteScoringDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numSolScoring;
	private String clasificacionCliente;
	private String resultadoScoring;
	private int cantidadLineas;
	private int cantidadPlanes;
	private String desPlanes;
	private int cantidadServSup;
	ScoreClienteDTO scoreClienteDTO;
	DocDigitalizadoScoringDTO[] docsDigScoringDTO;
	public int getCantidadLineas() {
		return cantidadLineas;
	}
	public void setCantidadLineas(int cantidadLineas) {
		this.cantidadLineas = cantidadLineas;
	}
	public int getCantidadPlanes() {
		return cantidadPlanes;
	}
	public void setCantidadPlanes(int cantidadPlanes) {
		this.cantidadPlanes = cantidadPlanes;
	}
	public int getCantidadServSup() {
		return cantidadServSup;
	}
	public void setCantidadServSup(int cantidadServSup) {
		this.cantidadServSup = cantidadServSup;
	}
	public String getClasificacionCliente() {
		return clasificacionCliente;
	}
	public void setClasificacionCliente(String clasificacionCliente) {
		this.clasificacionCliente = clasificacionCliente;
	}
	public DocDigitalizadoScoringDTO[] getDocsDigScoringDTO() {
		return docsDigScoringDTO;
	}
	public void setDocsDigScoringDTO(DocDigitalizadoScoringDTO[] docsDigScoringDTO) {
		this.docsDigScoringDTO = docsDigScoringDTO;
	}
	public long getNumSolScoring() {
		return numSolScoring;
	}
	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}
	public String getResultadoScoring() {
		return resultadoScoring;
	}
	public void setResultadoScoring(String resultadoScoring) {
		this.resultadoScoring = resultadoScoring;
	}
	public ScoreClienteDTO getScoreClienteDTO() {
		return scoreClienteDTO;
	}
	public void setScoreClienteDTO(ScoreClienteDTO scoreClienteDTO) {
		this.scoreClienteDTO = scoreClienteDTO;
	}
	public String getDesPlanes() {
		return desPlanes;
	}
	public void setDesPlanes(String desPlanes) {
		this.desPlanes = desPlanes;
	}
	
}