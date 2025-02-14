/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 27/07/2007	     	  Raúl Lozano        				Versión Inicial
 */


package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ParametrosCargoServOcacionalesPVDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String codProducto;
	private String codActuacion;
	private String codTipoServicio;
	private String codConcepto;
	private String codPlanServicio;
	
	public String getCodConcepto() {
		return codConcepto;
	}
	public void setCodConcepto(String codConcepto) {
		this.codConcepto = codConcepto;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public String getCodPlanServicio() {
		return codPlanServicio;
	}
	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTipoServicio() {
		return codTipoServicio;
	}
	public void setCodTipoServicio(String codTipoServicio) {
		this.codTipoServicio = codTipoServicio;
	}
	
}	
	
	
	