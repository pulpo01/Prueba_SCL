package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class CargoServSuplementarioDTO  implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long codClienteServ;//    	NUMBER(8)
	private long numAbonadoServ; //    	NUMBER(8)
	private long codClientePago; //    	NUMBER(8)
	private long numAbonadoPago;  //   	NUMBER(8)
	//private Date fecAlta;           	//	DATE
	//private Date fecAltaCobro;     	//	DATE
	private int codConcepto;   //    	NUMBER(4)
	private int codServicio;   //  		NUMBER(2)
	
	public long getCodClientePago() {
		return codClientePago;
	}
	public void setCodClientePago(long codClientePago) {
		this.codClientePago = codClientePago;
	}
	public long getCodClienteServ() {
		return codClienteServ;
	}
	public void setCodClienteServ(long codClienteServ) {
		this.codClienteServ = codClienteServ;
	}
	public int getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(int codConcepto) {
		this.codConcepto = codConcepto;
	}
	public int getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(int codServicio) {
		this.codServicio = codServicio;
	}
	/*public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecAltaCobro() {
		return fecAltaCobro;
	}
	public void setFecAltaCobro(Date fecAltaCobro) {
		this.fecAltaCobro = fecAltaCobro;
	}*/
	public long getNumAbonadoServ() {
		return numAbonadoServ;
	}
	public void setNumAbonadoServ(long longnumAbonadoServ) {
		this.numAbonadoServ = longnumAbonadoServ;
	}
	public long getNumAbonadoPago() {
		return numAbonadoPago;
	}
	public void setNumAbonadoPago(long numAbonadoPago) {
		this.numAbonadoPago = numAbonadoPago;
	}
  


}
