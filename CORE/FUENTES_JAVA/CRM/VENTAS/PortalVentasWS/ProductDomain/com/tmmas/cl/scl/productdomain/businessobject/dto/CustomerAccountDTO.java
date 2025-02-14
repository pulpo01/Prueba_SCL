package com.tmmas.cl.scl.productdomain.businessobject.dto;

import java.io.Serializable;

public class CustomerAccountDTO implements Serializable {
    private static final long serialVersionUID = 1L;
    
	private long code;
	private String names;
	private String lastName1  ;
	private String lastName2 ;
	private int freeUnits ;
	private String codePlanRate;
	private String desPlanRate;
	private String measuredUnit;
	private AbonadoDistribucionDTO abonado;
	private String codeStockMarket ;
	
	public AbonadoDistribucionDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDistribucionDTO abonado) {
		this.abonado = abonado;
	}
	public long getCode() {
		return code;
	}
	public void setCode(long code) {
		this.code = code;
	}
	public String getCodePlanRate() {
		return codePlanRate;
	}
	public void setCodePlanRate(String codePlanRate) {
		this.codePlanRate = codePlanRate;
	}
	public String getCodeStockMarket() {
		return codeStockMarket;
	}
	public void setCodeStockMarket(String codeStockMarket) {
		this.codeStockMarket = codeStockMarket;
	}
	public String getDesPlanRate() {
		return desPlanRate;
	}
	public void setDesPlanRate(String desPlanRate) {
		this.desPlanRate = desPlanRate;
	}
	public int getFreeUnits() {
		return freeUnits;
	}
	public void setFreeUnits(int freeUnits) {
		this.freeUnits = freeUnits;
	}
	public String getLastName1() {
		return lastName1;
	}
	public void setLastName1(String lastName1) {
		this.lastName1 = lastName1;
	}
	public String getLastName2() {
		return lastName2;
	}
	public void setLastName2(String lastName2) {
		this.lastName2 = lastName2;
	}
	public String getMeasuredUnit() {
		return measuredUnit;
	}
	public void setMeasuredUnit(String measuredUnit) {
		this.measuredUnit = measuredUnit;
	}
	public String getNames() {
		return names;
	}
	public void setNames(String names) {
		this.names = names;
	}


}
