package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;




public class FacturaNoCicloDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private long   numFolio;
	private double   totalFactura;
	private double   totalPagar;
	private double   totDescuento;
	private Date   fecEmision;
	private Date   fecVencimie;
	private Date   fecCancelacion;
	
	public Date getFecCancelacion() {
		return fecCancelacion;
	}
	public void setFecCancelacion(Date fecCancelacion) {
		this.fecCancelacion = fecCancelacion;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public Date getFecEmision() {
		return fecEmision;
	}
	public void setFecEmision(Date fecEmision) {
		this.fecEmision = fecEmision;
	}
	public Date getFecVencimie() {
		return fecVencimie;
	}
	public void setFecVencimie(Date fecVencimie) {
		this.fecVencimie = fecVencimie;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public double getTotalFactura() {
		return totalFactura;
	}
	public void setTotalFactura(double totalFactura) {
		this.totalFactura = totalFactura;
	}
	public double getTotalPagar() {
		return totalPagar;
	}
	public void setTotalPagar(double totalPagar) {
		this.totalPagar = totalPagar;
	}
	public double getTotDescuento() {
		return totDescuento;
	}
	public void setTotDescuento(double totDescuento) {
		this.totDescuento = totDescuento;
	}
	

	
	

}
