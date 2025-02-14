package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class SuspensionAbonadoDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private CausasSuspensionDTO causaSuspension;
	private long num_abonado;
	private Date fechaSolicitud;
	private Date fechaSuspension;
	private Date fechaRehabilitacion;
	private Date fechaActualizacion;
	private long numPeriodoSus1;
	private long numPeriodoSus2;
	private String estado;
	private String usuario;
	private long diasSus1;
	private long diasSus2;
	private long numOsSus;
	private long numOsReh;
	private long num_det_sus_vol_prg;
	private Date fechaInicioPeriodo1;
	private Date fechaFinPeriodo1;
	private Date fechaInicioPeriodo2;
	private Date fechaFinPeriodo2;
	
	public long getNumOsReh() {
		return numOsReh;
	}
	public void setNumOsReh(long numOsReh) {
		this.numOsReh = numOsReh;
	}
	public long getNumOsSus() {
		return numOsSus;
	}
	public void setNumOsSus(long numOsSus) {
		this.numOsSus = numOsSus;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public CausasSuspensionDTO getCausaSuspension() {
		return causaSuspension;
	}
	public void setCausaSuspension(CausasSuspensionDTO causaSuspension) {
		this.causaSuspension = causaSuspension;
	}
	public Date getFechaRehabilitacion() {
		return fechaRehabilitacion;
	}
	public void setFechaRehabilitacion(Date fechaRehabilitacion) {
		this.fechaRehabilitacion = fechaRehabilitacion;
	}
	public Date getFechaSolicitud() {
		return fechaSolicitud;
	}
	public void setFechaSolicitud(Date fechaSolicitud) {
		this.fechaSolicitud = fechaSolicitud;
	}
	public Date getFechaSuspension() {
		return fechaSuspension;
	}
	public void setFechaSuspension(Date fechaSuspension) {
		this.fechaSuspension = fechaSuspension;
	}
	public long getDiasSus1() {
		return diasSus1;
	}
	public void setDiasSus1(long diasSus1) {
		this.diasSus1 = diasSus1;
	}
	public long getDiasSus2() {
		return diasSus2;
	}
	public void setDiasSus2(long diasSus2) {
		this.diasSus2 = diasSus2;
	}
	
	public Date getFechaActualizacion() {
		return fechaActualizacion;
	}
	public void setFechaActualizacion(Date fechaActualizacion) {
		this.fechaActualizacion = fechaActualizacion;
	}
	public long getNumPeriodoSus1() {
		return numPeriodoSus1;
	}
	public void setNumPeriodoSus1(long numPeriodoSus1) {
		this.numPeriodoSus1 = numPeriodoSus1;
	}
	public long getNumPeriodoSus2() {
		return numPeriodoSus2;
	}
	public void setNumPeriodoSus2(long numPeriodoSus2) {
		this.numPeriodoSus2 = numPeriodoSus2;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado(String estado) {
		this.estado = estado;
	}
	public long getNum_det_sus_vol_prg() {
		return num_det_sus_vol_prg;
	}
	public void setNum_det_sus_vol_prg(long num_det_sus_vol_prg) {
		this.num_det_sus_vol_prg = num_det_sus_vol_prg;
	}
	public Date getFechaFinPeriodo1() {
		return fechaFinPeriodo1;
	}
	public void setFechaFinPeriodo1(Date fechaFinPeriodo1) {
		this.fechaFinPeriodo1 = fechaFinPeriodo1;
	}
	public Date getFechaFinPeriodo2() {
		return fechaFinPeriodo2;
	}
	public void setFechaFinPeriodo2(Date fechaFinPeriodo2) {
		this.fechaFinPeriodo2 = fechaFinPeriodo2;
	}
	public Date getFechaInicioPeriodo1() {
		return fechaInicioPeriodo1;
	}
	public void setFechaInicioPeriodo1(Date fechaInicioPeriodo1) {
		this.fechaInicioPeriodo1 = fechaInicioPeriodo1;
	}
	public Date getFechaInicioPeriodo2() {
		return fechaInicioPeriodo2;
	}
	public void setFechaInicioPeriodo2(Date fechaInicioPeriodo2) {
		this.fechaInicioPeriodo2 = fechaInicioPeriodo2;
	}
	
} // SuspensionAbonadoDTO
