package com.tmmas.cl.scl.customerdomain.businessobject.dto;

import java.io.Serializable;

public class DatosAnexoContratoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	//Linea 1 del Anexo
	private String  numeroLinea1;
	private String 	numCeluLinea1;
	private String  tipTerminalLinea1; //indica si es Aportado, subsidio, financiado, gratis
	private String 	numImeiLinea1;
	private String 	modTerLinea1;
	private String 	simcardLinea1;
	private String 	planTarifLinea1;
	private String  cargoPT1;
	private String 	numAbonado1;		
	private DatosPlanAdicionalLineaDTO planesAdicionales1[];
	private DatosServSupLineaDTO servSupl1[];
	
	//Linea 2 del Anexo
	private String  numeroLinea2;
	private String 	numCeluLinea2;
	private String  tipTerminalLinea2; //indica si es Aportado, subsidio, financiado, gratis
	private String 	numImeiLinea2;
	private String 	modTerLinea2;
	private String 	simcardLinea2;
	private String 	planTarifLinea2;
	private String  cargoPT2;
	private String 	numAbonado2;		
	private DatosPlanAdicionalLineaDTO planesAdicionales2[];
	private DatosServSupLineaDTO servSupl2[];
	
	//Linea 1 del Anexo
	private String  numeroLinea3;
	private String 	numCeluLinea3;
	private String  tipTerminalLinea3; //indica si es Aportado, subsidio, financiado, gratis
	private String 	numImeiLinea3;
	private String 	modTerLinea3;
	private String 	simcardLinea3;
	private String 	planTarifLinea3;
	private String  cargoPT3;
	private String 	numAbonado3;		
	private DatosPlanAdicionalLineaDTO planesAdicionales3[];
	private DatosServSupLineaDTO servSupl3[];
	
	//Linea 1 del Anexo
	private String  numeroLinea4;
	private String 	numCeluLinea4;
	private String  tipTerminalLinea4; //indica si es Aportado, subsidio, financiado, gratis
	private String 	numImeiLinea4;
	private String 	modTerLinea4;
	private String 	simcardLinea4;
	private String 	planTarifLinea4;
	private String  cargoPT4;
	private String 	numAbonado4;		
	private DatosPlanAdicionalLineaDTO planesAdicionales4[];
	private DatosServSupLineaDTO servSupl4[];
	
	public String getCargoPT1() {
		return cargoPT1;
	}
	public void setCargoPT1(String cargoPT1) {
		this.cargoPT1 = cargoPT1;
	}
	public String getCargoPT2() {
		return cargoPT2;
	}
	public void setCargoPT2(String cargoPT2) {
		this.cargoPT2 = cargoPT2;
	}
	public String getCargoPT3() {
		return cargoPT3;
	}
	public void setCargoPT3(String cargoPT3) {
		this.cargoPT3 = cargoPT3;
	}
	public String getCargoPT4() {
		return cargoPT4;
	}
	public void setCargoPT4(String cargoPT4) {
		this.cargoPT4 = cargoPT4;
	}
	public String getModTerLinea1() {
		return modTerLinea1;
	}
	public void setModTerLinea1(String modTerLinea1) {
		this.modTerLinea1 = modTerLinea1;
	}
	public String getModTerLinea2() {
		return modTerLinea2;
	}
	public void setModTerLinea2(String modTerLinea2) {
		this.modTerLinea2 = modTerLinea2;
	}
	public String getModTerLinea3() {
		return modTerLinea3;
	}
	public void setModTerLinea3(String modTerLinea3) {
		this.modTerLinea3 = modTerLinea3;
	}
	public String getModTerLinea4() {
		return modTerLinea4;
	}
	public void setModTerLinea4(String modTerLinea4) {
		this.modTerLinea4 = modTerLinea4;
	}
	public String getNumAbonado1() {
		return numAbonado1;
	}
	public void setNumAbonado1(String numAbonado1) {
		this.numAbonado1 = numAbonado1;
	}
	public String getNumAbonado2() {
		return numAbonado2;
	}
	public void setNumAbonado2(String numAbonado2) {
		this.numAbonado2 = numAbonado2;
	}
	public String getNumAbonado3() {
		return numAbonado3;
	}
	public void setNumAbonado3(String numAbonado3) {
		this.numAbonado3 = numAbonado3;
	}
	public String getNumAbonado4() {
		return numAbonado4;
	}
	public void setNumAbonado4(String numAbonado4) {
		this.numAbonado4 = numAbonado4;
	}
	public String getNumCeluLinea1() {
		return numCeluLinea1;
	}
	public void setNumCeluLinea1(String numCeluLinea1) {
		this.numCeluLinea1 = numCeluLinea1;
	}
	public String getNumCeluLinea2() {
		return numCeluLinea2;
	}
	public void setNumCeluLinea2(String numCeluLinea2) {
		this.numCeluLinea2 = numCeluLinea2;
	}
	public String getNumCeluLinea3() {
		return numCeluLinea3;
	}
	public void setNumCeluLinea3(String numCeluLinea3) {
		this.numCeluLinea3 = numCeluLinea3;
	}
	public String getNumCeluLinea4() {
		return numCeluLinea4;
	}
	public void setNumCeluLinea4(String numCeluLinea4) {
		this.numCeluLinea4 = numCeluLinea4;
	}
	public String getNumeroLinea1() {
		return numeroLinea1;
	}
	public void setNumeroLinea1(String numeroLinea1) {
		this.numeroLinea1 = numeroLinea1;
	}
	public String getNumeroLinea2() {
		return numeroLinea2;
	}
	public void setNumeroLinea2(String numeroLinea2) {
		this.numeroLinea2 = numeroLinea2;
	}
	public String getNumeroLinea3() {
		return numeroLinea3;
	}
	public void setNumeroLinea3(String numeroLinea3) {
		this.numeroLinea3 = numeroLinea3;
	}
	public String getNumeroLinea4() {
		return numeroLinea4;
	}
	public void setNumeroLinea4(String numeroLinea4) {
		this.numeroLinea4 = numeroLinea4;
	}
	public String getNumImeiLinea1() {
		return numImeiLinea1;
	}
	public void setNumImeiLinea1(String numImeiLinea1) {
		this.numImeiLinea1 = numImeiLinea1;
	}
	public String getNumImeiLinea2() {
		return numImeiLinea2;
	}
	public void setNumImeiLinea2(String numImeiLinea2) {
		this.numImeiLinea2 = numImeiLinea2;
	}
	public String getNumImeiLinea3() {
		return numImeiLinea3;
	}
	public void setNumImeiLinea3(String numImeiLinea3) {
		this.numImeiLinea3 = numImeiLinea3;
	}
	public String getNumImeiLinea4() {
		return numImeiLinea4;
	}
	public void setNumImeiLinea4(String numImeiLinea4) {
		this.numImeiLinea4 = numImeiLinea4;
	}
	public DatosPlanAdicionalLineaDTO[] getPlanesAdicionales1() {
		return planesAdicionales1;
	}
	public void setPlanesAdicionales1(
			DatosPlanAdicionalLineaDTO[] planesAdicionales1) {
		this.planesAdicionales1 = planesAdicionales1;
	}
	public DatosPlanAdicionalLineaDTO[] getPlanesAdicionales2() {
		return planesAdicionales2;
	}
	public void setPlanesAdicionales2(
			DatosPlanAdicionalLineaDTO[] planesAdicionales2) {
		this.planesAdicionales2 = planesAdicionales2;
	}
	public DatosPlanAdicionalLineaDTO[] getPlanesAdicionales3() {
		return planesAdicionales3;
	}
	public void setPlanesAdicionales3(
			DatosPlanAdicionalLineaDTO[] planesAdicionales3) {
		this.planesAdicionales3 = planesAdicionales3;
	}
	public DatosPlanAdicionalLineaDTO[] getPlanesAdicionales4() {
		return planesAdicionales4;
	}
	public void setPlanesAdicionales4(
			DatosPlanAdicionalLineaDTO[] planesAdicionales4) {
		this.planesAdicionales4 = planesAdicionales4;
	}
	public String getPlanTarifLinea1() {
		return planTarifLinea1;
	}
	public void setPlanTarifLinea1(String planTarifLinea1) {
		this.planTarifLinea1 = planTarifLinea1;
	}
	public String getPlanTarifLinea2() {
		return planTarifLinea2;
	}
	public void setPlanTarifLinea2(String planTarifLinea2) {
		this.planTarifLinea2 = planTarifLinea2;
	}
	public String getPlanTarifLinea3() {
		return planTarifLinea3;
	}
	public void setPlanTarifLinea3(String planTarifLinea3) {
		this.planTarifLinea3 = planTarifLinea3;
	}
	public String getPlanTarifLinea4() {
		return planTarifLinea4;
	}
	public void setPlanTarifLinea4(String planTarifLinea4) {
		this.planTarifLinea4 = planTarifLinea4;
	}
	public DatosServSupLineaDTO[] getServSupl1() {
		return servSupl1;
	}
	public void setServSupl1(DatosServSupLineaDTO[] servSupl1) {
		this.servSupl1 = servSupl1;
	}
	public DatosServSupLineaDTO[] getServSupl2() {
		return servSupl2;
	}
	public void setServSupl2(DatosServSupLineaDTO[] servSupl2) {
		this.servSupl2 = servSupl2;
	}
	public DatosServSupLineaDTO[] getServSupl3() {
		return servSupl3;
	}
	public void setServSupl3(DatosServSupLineaDTO[] servSupl3) {
		this.servSupl3 = servSupl3;
	}
	public DatosServSupLineaDTO[] getServSupl4() {
		return servSupl4;
	}
	public void setServSupl4(DatosServSupLineaDTO[] servSupl4) {
		this.servSupl4 = servSupl4;
	}
	public String getSimcardLinea1() {
		return simcardLinea1;
	}
	public void setSimcardLinea1(String simcardLinea1) {
		this.simcardLinea1 = simcardLinea1;
	}
	public String getSimcardLinea2() {
		return simcardLinea2;
	}
	public void setSimcardLinea2(String simcardLinea2) {
		this.simcardLinea2 = simcardLinea2;
	}
	public String getSimcardLinea3() {
		return simcardLinea3;
	}
	public void setSimcardLinea3(String simcardLinea3) {
		this.simcardLinea3 = simcardLinea3;
	}
	public String getSimcardLinea4() {
		return simcardLinea4;
	}
	public void setSimcardLinea4(String simcardLinea4) {
		this.simcardLinea4 = simcardLinea4;
	}
	public String getTipTerminalLinea1() {
		return tipTerminalLinea1;
	}
	public void setTipTerminalLinea1(String tipTerminalLinea1) {
		this.tipTerminalLinea1 = tipTerminalLinea1;
	}
	public String getTipTerminalLinea2() {
		return tipTerminalLinea2;
	}
	public void setTipTerminalLinea2(String tipTerminalLinea2) {
		this.tipTerminalLinea2 = tipTerminalLinea2;
	}
	public String getTipTerminalLinea3() {
		return tipTerminalLinea3;
	}
	public void setTipTerminalLinea3(String tipTerminalLinea3) {
		this.tipTerminalLinea3 = tipTerminalLinea3;
	}
	public String getTipTerminalLinea4() {
		return tipTerminalLinea4;
	}
	public void setTipTerminalLinea4(String tipTerminalLinea4) {
		this.tipTerminalLinea4 = tipTerminalLinea4;
	}	
}
