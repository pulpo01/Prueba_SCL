/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class IntarcelDTO implements Serializable {
	private static final long serialVersionUID = 1L;	
	private String codPlanTarif;
	private String codPlanTarifDestino;
	private long numAbonado;
	private long codCliente;
	
    private Date fecDesde ;
    private int codProducto;
    
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public Date getFecDesde() {
		return fecDesde;
	}
	public void setFecDesde(Date fecDesde) {
		this.fecDesde = fecDesde;
	}

	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

    
	  

}
