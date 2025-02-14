/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 17/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class ComplementoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codPlanTarif;
	private String codCargoBasico;
	private String codPlanServicio;
	private short codCiclo;
	private Date fechaCumplimientoPlan;
	private String limiteConsumo;
	
	
	public ComplementoDTO()
	{
		this.fechaCumplimientoPlan=new Date();
	}
	public String getCodCargoBasico() {
		return codCargoBasico;
	}
	public void setCodCargoBasico(String codCargoBasico) {
		this.codCargoBasico = codCargoBasico;
	}
	public short getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(short codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCodPlanServicio() {
		return codPlanServicio;
	}
	public void setCodPlanServicio(String codPlanServicio) {
		this.codPlanServicio = codPlanServicio;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public Date getFechaCumplimientoPlan() {
		return fechaCumplimientoPlan;
	}
	public void setFechaCumplimientoPlan(Date fechaCumplimientoPlan) {
		this.fechaCumplimientoPlan = fechaCumplimientoPlan;
	}
	public String getLimiteConsumo() {
		return limiteConsumo;
	}
	public void setLimiteConsumo(String limiteConsumo) {
		this.limiteConsumo = limiteConsumo;
	}
}
