package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosLineaContratoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String 	numCelular;
	private String  tipTerminal; //indica si es Aportado, subsidio, financiado, gratis
	private String  precioTerminal; //P-CSR-11002 JLGN 26-07-2011
	private String 	numImei;
	private String 	desTerminal;
	private String 	numSerie;
	private String 	planTarif;
	private String  codPT;
	private String  cargoPT;
	private String 	numAbonado;	
	private String  tipRed;
	//P-CSR-11002 JLGN 20-10-2011
	private String  limiteConsumoLinea;
	//P-CSR11002 JLGN 25-10-2011
	private String  ldiSI; //larga distancia internacional SI 
	private String  ldiNO; //larga distancia internacional NO
	
	private DatosServSupLineaDTO servSupl[];
	private DatosPlanAdicionalLineaDTO planesAdicionales[];
	
	public String getCargoPT() {
		return cargoPT;
	}
	public void setCargoPT(String cargoPT) {
		this.cargoPT = cargoPT;
	}
	public String getDesTerminal() {
		return desTerminal;
	}
	public void setDesTerminal(String desTerminal) {
		this.desTerminal = desTerminal;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public DatosPlanAdicionalLineaDTO[] getPlanesAdicionales() {
		return planesAdicionales;
	}
	public void setPlanesAdicionales(DatosPlanAdicionalLineaDTO[] planesAdicionales) {
		this.planesAdicionales = planesAdicionales;
	}
	public String getPlanTarif() {
		return planTarif;
	}
	public void setPlanTarif(String planTarif) {
		this.planTarif = planTarif;
	}
	public DatosServSupLineaDTO[] getServSupl() {
		return servSupl;
	}
	public void setServSupl(DatosServSupLineaDTO[] servSupl) {
		this.servSupl = servSupl;
	}
	public String getTipTerminal() {
		return tipTerminal;
	}
	public void setTipTerminal(String tipTerminal) {
		this.tipTerminal = tipTerminal;
	}
	public String getCodPT() {
		return codPT;
	}
	public void setCodPT(String codPT) {
		this.codPT = codPT;
	}
	public String getPrecioTerminal() {
		return precioTerminal;
	}
	public void setPrecioTerminal(String precioTerminal) {
		this.precioTerminal = precioTerminal;
	}
	public String getTipRed() {
		return tipRed;
	}
	public void setTipRed(String tipRed) {
		this.tipRed = tipRed;
	}
	//Inicio P-CSR-11002 JLGN 20-10-2011
	public String getLimiteConsumoLinea() {
		return limiteConsumoLinea;
	}
	public void setLimiteConsumoLinea(String limiteConsumoLinea) {
		this.limiteConsumoLinea = limiteConsumoLinea;
	}	
	//Fin P-CSR-11002 JLGN 20-10-2011
	//Inicio P-CSR-11002 JLGN 25-10-2011
	public String getLdiNO() {
		return ldiNO;
	}
	public void setLdiNO(String ldiNO) {
		this.ldiNO = ldiNO;
	}
	public String getLdiSI() {
		return ldiSI;
	}
	public void setLdiSI(String ldiSI) {
		this.ldiSI = ldiSI;
	}
	//Fin P-CSR-11002 JLGN 25-10-2011
}