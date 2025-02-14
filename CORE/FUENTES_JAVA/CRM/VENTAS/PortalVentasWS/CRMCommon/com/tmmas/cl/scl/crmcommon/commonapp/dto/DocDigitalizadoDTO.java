package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class DocDigitalizadoDTO implements Serializable {

	private static final long serialVersionUID = 2384741082370753254L;

	private long numCorrelativo;

	private long numVenta;

	private long codTipoDocDigitalizado;

	private String desTipoDocDigitalizado;

	private String observacion;

	private String nombreUsuarioOra;

	private String fechaCreacion;

	/**
	 * Incidencia 149265. No se ven los documentos asociados a las ventas.
	 */
	private byte[] binArchivo;

	private String nombreArchivo;

	private String valorContentType;

	public String getNombreUsuarioOra() {
		return nombreUsuarioOra;
	}

	public void setNombreUsuarioOra(String nombreUsuarioOra) {
		this.nombreUsuarioOra = nombreUsuarioOra;
	}

	public String getFechaCreacion() {
		return fechaCreacion;
	}

	public void setFechaCreacion(String fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}

	public String getDesTipoDocDigitalizado() {
		return desTipoDocDigitalizado;
	}

	public void setDesTipoDocDigitalizado(String desTipoDocumento) {
		this.desTipoDocDigitalizado = desTipoDocumento;
	}

	public long getNumCorrelativo() {
		return numCorrelativo;
	}

	public void setNumCorrelativo(long numCorrelativo) {
		this.numCorrelativo = numCorrelativo;
	}

	/**
	 * @return
	 * 
	 * Incidencia 149265. No se ven los documentos asociados a las ventas.
	 */
	public byte[] getBinArchivo() {
		return binArchivo;
	}

	/**
	 * @param binArchivo
	 * 
	 * Incidencia 149265. No se ven los documentos asociados a las ventas.
	 */
	public void setBinArchivo(byte[] binArchivo) {
		this.binArchivo = binArchivo;
	}

	public long getCodTipoDocDigitalizado() {
		return codTipoDocDigitalizado;
	}

	public void setCodTipoDocDigitalizado(long codTipoDocumento) {
		this.codTipoDocDigitalizado = codTipoDocumento;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public String getObservacion() {
		return observacion;
	}

	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}

	public String getValorContentType() {
		return valorContentType;
	}

	public void setValorContentType(String valorContentType) {
		this.valorContentType = valorContentType;
	}

	public String getNombreArchivo() {
		return nombreArchivo;
	}

	public void setNombreArchivo(String nombreArchivo) {
		this.nombreArchivo = nombreArchivo;
	}

	public String toString() {
		final String nl = "\n";
		StringBuffer b = new StringBuffer();
		b.append("DocDigitalizadoDTO ( ").append(super.toString()).append(nl);
		b.append("codTipoDocDigitalizado = ").append(this.codTipoDocDigitalizado).append(nl);
		b.append("desTipoDocDigitalizado = ").append(this.desTipoDocDigitalizado).append(nl);
		b.append("fechaCreacion = ").append(this.fechaCreacion).append(nl);
		b.append("nombreArchivo = ").append(this.nombreArchivo).append(nl);
		b.append("nombreUsuarioOra = ").append(this.nombreUsuarioOra).append(nl);
		b.append("numCorrelativo = ").append(this.numCorrelativo).append(nl);
		b.append("numVenta = ").append(this.numVenta).append(nl);
		b.append("observacion = ").append(this.observacion).append(nl);
		b.append("valorContentType = ").append(this.valorContentType).append(nl);
		b.append(" )");
		return b.toString();
	}

}
