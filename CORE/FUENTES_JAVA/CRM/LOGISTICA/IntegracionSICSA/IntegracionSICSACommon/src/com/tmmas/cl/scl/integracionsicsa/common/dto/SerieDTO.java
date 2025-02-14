package com.tmmas.cl.scl.integracionsicsa.common.dto;

import java.io.Serializable;

public class SerieDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	    private String linPedido;
	    private String numSerie;
	    
		public String getLinPedido() {
			return linPedido;
		}
		public void setLinPedido(String linPedido) {
			this.linPedido = linPedido;
		}
		public String getNumSerie() {
			return numSerie;
		}
		public void setNumSerie(String numSerie) {
			this.numSerie = numSerie;
		}
	    
}
