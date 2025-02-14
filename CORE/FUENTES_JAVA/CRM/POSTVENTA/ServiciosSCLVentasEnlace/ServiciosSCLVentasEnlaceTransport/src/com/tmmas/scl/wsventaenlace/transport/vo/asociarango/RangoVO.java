/**
 * 
 */
package com.tmmas.scl.wsventaenlace.transport.vo.asociarango;

import java.sql.Date;

/**
 * @author mwn40032
 * 
 */
public class RangoVO {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numDesde;
	private long numHasta;
	private Date fechaAlta;
	private Date fechaBaja;
	private Date fechaSuspension;
	private Date fechaRehabilitacion;
	private Date fechaModificacion;
	private String estado;
	private String nomUsuarOra;

	public Date getFechaModificacion() {
		return fechaModificacion;
	}

	public void setFechaModificacion(Date fechaModificacion) {
		this.fechaModificacion = fechaModificacion;
	}

	public String toString() {
		StringBuffer buffer = new StringBuffer("RangoVO: ");

		buffer.append("numDesde=[").append(numDesde).append("]");
		buffer.append(", numHasta=[").append(numHasta).append("]");
		buffer.append(", fechaAlta=[").append(fechaAlta).append("]");
		buffer.append(", fechaBaja=[").append(fechaBaja).append("]");
		buffer.append(", fechaSuspension=[").append(fechaSuspension).append("]");
		buffer.append(", fechaRehabilitacion=[").append(fechaRehabilitacion).append("]");
		buffer.append(", fechaModificacion=[").append(fechaModificacion).append("]");
		buffer.append(", estado=[").append(estado).append("]");
		buffer.append(", nomUsuarOra=[").append(nomUsuarOra).append("]");

		return buffer.toString();
	}

	public String getEstado() {
		return estado;
	}

	public void setEstado(String estado) {
		this.estado = estado;
	}

	public Date getFechaAlta() {
		return fechaAlta;
	}

	public void setFechaAlta(Date fechaAlta) {
		this.fechaAlta = fechaAlta;
	}

	public Date getFechaBaja() {
		return fechaBaja;
	}

	public void setFechaBaja(Date fechaBaja) {
		this.fechaBaja = fechaBaja;
	}

	public Date getFechaRehabilitacion() {
		return fechaRehabilitacion;
	}

	public void setFechaRehabilitacion(Date fechaRehabilitacion) {
		this.fechaRehabilitacion = fechaRehabilitacion;
	}

	public Date getFechaSuspension() {
		return fechaSuspension;
	}

	public void setFechaSuspension(Date fechaSuspension) {
		this.fechaSuspension = fechaSuspension;
	}

	public String getNomUsuarOra() {
		return nomUsuarOra;
	}

	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}

	public long getNumDesde() {
		return numDesde;
	}

	public void setNumDesde(long numDesde) {
		this.numDesde = numDesde;
	}

	public long getNumHasta() {
		return numHasta;
	}

	public void setNumHasta(long numHasta) {
		this.numHasta = numHasta;
	}
}
