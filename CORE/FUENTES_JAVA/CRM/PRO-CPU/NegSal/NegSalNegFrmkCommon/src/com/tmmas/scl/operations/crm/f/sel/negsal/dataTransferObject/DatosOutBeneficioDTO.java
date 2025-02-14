package com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject;

import java.io.Serializable;

public class DatosOutBeneficioDTO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoProductoOfertado;
	private String descripcionProductoOfertado;
//	private String precio;
//	private String DescripcionConcepto;
	
	public String getCodigoProductoOfertado() {
		return codigoProductoOfertado;
	}
	public void setCodigoProductoOfertado(String codigoProductoOfertado) {
		this.codigoProductoOfertado = codigoProductoOfertado;
	}
//	public String getDescripcionConcepto() {
//		return DescripcionConcepto;
//	}
//	public void setDescripcionConcepto(String descripcion) {
//		DescripcionConcepto = descripcion;
//	}
	public String getDescripcionProductoOfertado() {
		return descripcionProductoOfertado;
	}
	public void setDescripcionProductoOfertado(String descripcionProductoOfertado) {
		this.descripcionProductoOfertado = descripcionProductoOfertado;
	}
//	public String getPrecioConcepto() {
//		return precio;
//	}
//	public void setPrecioConcepto(String precio) {
//		this.precio = precio;
//	}
}
