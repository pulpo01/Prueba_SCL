package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class VentaLineaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	    private String linProceso;
	    private String canArticulo;
	    private String codArticulo;
	    private String desArticulo;
	    private String precioVenta;
	    
		public String getLinProceso() {
			return linProceso;
		}
		public void setLinProceso(String linProceso) {
			this.linProceso = linProceso;
		}
		public String getCanArticulo() {
			return canArticulo;
		}
		public void setCanArticulo(String canArticulo) {
			this.canArticulo = canArticulo;
		}
		public String getCodArticulo() {
			return codArticulo;
		}
		public void setCodArticulo(String codArticulo) {
			this.codArticulo = codArticulo;
		}
		public String getDesArticulo() {
			return desArticulo;
		}
		public void setDesArticulo(String desArticulo) {
			this.desArticulo = desArticulo;
		}
		public String getPrecioVenta() {
			return precioVenta;
		}
		public void setPrecioVenta(String precioVenta) {
			this.precioVenta = precioVenta;
		}
}
