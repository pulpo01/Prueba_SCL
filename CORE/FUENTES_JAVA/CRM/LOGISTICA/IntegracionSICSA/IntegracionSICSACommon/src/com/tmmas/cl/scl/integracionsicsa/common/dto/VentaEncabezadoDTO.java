package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class VentaEncabezadoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	 	private String numProceso;
	    private String codCliente;
	    private String nomCliente;
	    private String indAccion;
	    private String totalSeries;
	    private String fechaProceso;
	    private VentaLineaDTO[] ventaLineaDTOs;
	    
		public String getNumProceso() {
			return numProceso;
		}
		public void setNumProceso(String numProceso) {
			this.numProceso = numProceso;
		}
		public String getCodCliente() {
			return codCliente;
		}
		public void setCodCliente(String codCliente) {
			this.codCliente = codCliente;
		}
		public String getNomCliente() {
			return nomCliente;
		}
		public void setNomCliente(String nomCliente) {
			this.nomCliente = nomCliente;
		}
		public String getIndAccion() {
			return indAccion;
		}
		public void setIndAccion(String indAccion) {
			this.indAccion = indAccion;
		}
		public String getTotalSeries() {
			return totalSeries;
		}
		public void setTotalSeries(String totalSeries) {
			this.totalSeries = totalSeries;
		}
		public String getFechaProceso() {
			return fechaProceso;
		}
		public void setFechaProceso(String fechaProceso) {
			this.fechaProceso = fechaProceso;
		}
		public VentaLineaDTO[] getVentaLineaDTOs() {
			return ventaLineaDTOs;
		}
		public void setVentaLineaDTOs(VentaLineaDTO[] ventaLineaDTOs) {
			this.ventaLineaDTOs = ventaLineaDTOs;
		}
	    
}
