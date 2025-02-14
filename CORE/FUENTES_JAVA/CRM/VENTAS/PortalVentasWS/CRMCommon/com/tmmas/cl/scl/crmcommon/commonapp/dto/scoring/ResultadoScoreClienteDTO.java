package com.tmmas.cl.scl.crmcommon.commonapp.dto.scoring;

import java.io.Serializable;

public class ResultadoScoreClienteDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = -1934102432954086269L;

	private String mensaje;

	private String referencia;

	private String clasificacion;

	private String punteo;

	private long numSolScoring;

	private String documentosRequeridos;

	private String documentosOpcionales;

	public final String getDocumentosOpcionales() {
		return documentosOpcionales;
	}

	public final void setDocumentosOpcionales(String documentosOpcionales) {
		this.documentosOpcionales = documentosOpcionales;
	}

	public final String getDocumentosRequeridos() {
		return documentosRequeridos;
	}

	public final void setDocumentosRequeridos(String documentosRequeridos) {
		this.documentosRequeridos = documentosRequeridos;
	}

	public ResultadoScoreClienteDTO() {

	}

	public ResultadoScoreClienteDTO(String mensaje, String referencia, String clasificacion, String punteo,
			String documentosRequeridos, String documentosOpcionales) {
		super();
		this.mensaje = mensaje;
		this.referencia = referencia;
		this.clasificacion = clasificacion;
		this.punteo = punteo;
		this.documentosRequeridos = documentosRequeridos;
		this.documentosOpcionales = documentosOpcionales;
	}

	private DocDigitalizadoScoringDTO[] getArrayDocumentos(boolean requerido) {
		DocDigitalizadoScoringDTO[] toReturn = null;
		String documentos = requerido ? this.getDocumentosRequeridos() : getDocumentosOpcionales();
		toReturn = (DocDigitalizadoScoringDTO[]) obtenerArrayDocumentosDesdeString(documentos);
		for (int i = 0; i < toReturn.length; i++) {
			toReturn[i].requeridoScoring = requerido;
			toReturn[i].setNumSolScoring(numSolScoring);
		}
		return toReturn;
	}

	private static DocDigitalizadoScoringDTO[] obtenerArrayDocumentosDesdeString(String s) {
		DocDigitalizadoScoringDTO[] toReturn = null;
		if (s == null || s.equals("")) {
			toReturn = new DocDigitalizadoScoringDTO[0]; // 0 items
		}
		else {
			String[] a = s.split(",");
			final int c = a.length / 2;
			toReturn = new DocDigitalizadoScoringDTO[c];
			for (int i = 0; i < c; i++) {
				toReturn[i] = new DocDigitalizadoScoringDTO();
				toReturn[i].setCodScoring(a[i * 2].trim());
				toReturn[i].setDesScoring(a[i * 2 + 1].trim());
			}
		}
		return toReturn;
	}

	public DocDigitalizadoScoringDTO[] getArrayDocumentosRequeridos() {
		return getArrayDocumentos(true);
	}

	public DocDigitalizadoScoringDTO[] getArrayDocumentosOpcionales() {
		return getArrayDocumentos(false);
	}

	public String getClasificacion() {
		return clasificacion;
	}

	public void setClasificacion(String clasificacion) {
		this.clasificacion = clasificacion;
	}

	public String getMensaje() {
		return mensaje;
	}

	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}

	public String getPunteo() {
		return punteo;
	}

	public void setPunteo(String punteo) {
		this.punteo = punteo;
	}

	public String getReferencia() {
		return referencia;
	}

	public void setReferencia(String referencia) {
		this.referencia = referencia;
	}

	public long getNumSolScoring() {
		return numSolScoring;
	}

	public void setNumSolScoring(long numSolScoring) {
		this.numSolScoring = numSolScoring;
	}

	public String toString() {
		final String newLine = "\n";
		StringBuffer b = new StringBuffer();
		b.append("ResultadoScoreClienteDTO ( ").append(super.toString()).append(newLine);
		b.append("clasificacion = ").append(this.clasificacion).append(newLine);
		b.append("documentosOpcionales = ").append(this.documentosOpcionales).append(newLine);
		b.append("documentosRequeridos = ").append(this.documentosRequeridos).append(newLine);
		b.append("mensaje = ").append(this.mensaje).append(newLine);
		b.append("numSolScoring = ").append(this.numSolScoring).append(newLine);
		b.append("punteo = ").append(this.punteo).append(newLine);
		b.append("referencia = ").append(this.referencia).append(newLine);
		b.append(" )");
		return b.toString();
	}

}
