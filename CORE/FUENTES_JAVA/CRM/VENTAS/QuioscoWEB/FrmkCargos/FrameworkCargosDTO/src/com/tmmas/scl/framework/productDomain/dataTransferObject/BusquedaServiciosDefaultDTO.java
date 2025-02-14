package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class BusquedaServiciosDefaultDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private int codCentral;
	private int codProducto;
	private String codTipoTerminal;
	private String codTecnologia;
	private String codPlanTarif;
	private String codPlanTarifDestino;
	private long numAbonado;
	
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
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
	public void setCodProducto(short codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	
	
}
