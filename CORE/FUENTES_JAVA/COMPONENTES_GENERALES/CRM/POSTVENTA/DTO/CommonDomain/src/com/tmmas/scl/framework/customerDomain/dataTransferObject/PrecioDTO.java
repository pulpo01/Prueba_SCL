package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.AtributosMigracionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.MonedaDTO;

public class PrecioDTO implements Serializable {

	
	private static final long serialVersionUID = 1L;
	private float monto;
	private String codigoConcepto;
	private String descripcionConcepto;
	private String fechaAplicacion;
	private String valorMaximo;
	private String valorMinimo;
	private String indicadorAutMan;
	
	private MonedaDTO unidad;
	private AtributosMigracionDTO datosAnexos;
	
	public String getCodigoConcepto() {
		return codigoConcepto;
	}
	public void setCodigoConcepto(String codigoConcepto) {
		this.codigoConcepto = codigoConcepto;
	}
	public AtributosMigracionDTO getDatosAnexos() {
		return datosAnexos;
	}
	public void setDatosAnexos(AtributosMigracionDTO datosAnexos) {
		this.datosAnexos = datosAnexos;
	}
	public String getDescripcionConcepto() {
		return descripcionConcepto;
	}
	public void setDescripcionConcepto(String descripcionConcepto) {
		this.descripcionConcepto = descripcionConcepto;
	}
	public String getFechaAplicacion() {
		return fechaAplicacion;
	}
	public void setFechaAplicacion(String fechaAplicacion) {
		this.fechaAplicacion = fechaAplicacion;
	}
	public float getMonto() {
		return monto;
	}
	public void setMonto(float monto) {
		this.monto = monto;
	}
	public MonedaDTO getUnidad() {
		return unidad;
	}
	public void setUnidad(MonedaDTO unidad) {
		this.unidad = unidad;
	}
	public String getValorMaximo() {
		return valorMaximo;
	}
	public void setValorMaximo(String valorMaximo) {
		this.valorMaximo = valorMaximo;
	}
	public String getValorMinimo() {
		return valorMinimo;
	}
	public void setValorMinimo(String valorMinimo) {
		this.valorMinimo = valorMinimo;
	}
	public String getIndicadorAutMan() {
		return indicadorAutMan;
	}
	public void setIndicadorAutMan(String indicadorAutMan) {
		this.indicadorAutMan = indicadorAutMan;
	}
	
	
	
}

