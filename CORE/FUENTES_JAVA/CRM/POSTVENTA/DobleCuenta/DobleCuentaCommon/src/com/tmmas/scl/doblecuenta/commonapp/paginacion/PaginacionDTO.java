package com.tmmas.scl.doblecuenta.commonapp.paginacion;

import java.io.Serializable;
import java.util.List;

public class PaginacionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String total;
	private String pageIndex;
	private String perPage;
	private String cerca;
	private String dataInici;
	private String dataFi;
	private String titol;
	private String estat;
    private String criteri1;
    private String criteri2;
    private String criteri3;
	
	private List result;

	public String getCerca() {
		return cerca;
	}

	public void setCerca(String cerca) {
		this.cerca = cerca;
	}

	public String getCriteri1() {
		return criteri1;
	}

	public void setCriteri1(String criteri1) {
		this.criteri1 = criteri1;
	}

	public String getCriteri2() {
		return criteri2;
	}

	public void setCriteri2(String criteri2) {
		this.criteri2 = criteri2;
	}

	public String getCriteri3() {
		return criteri3;
	}

	public void setCriteri3(String criteri3) {
		this.criteri3 = criteri3;
	}

	public String getDataFi() {
		return dataFi;
	}

	public void setDataFi(String dataFi) {
		this.dataFi = dataFi;
	}

	public String getDataInici() {
		return dataInici;
	}

	public void setDataInici(String dataInici) {
		this.dataInici = dataInici;
	}

	public String getEstat() {
		return estat;
	}

	public void setEstat(String estat) {
		this.estat = estat;
	}

	public String getPageIndex() {
		return pageIndex;
	}

	public void setPageIndex(String pageIndex) {
		this.pageIndex = pageIndex;
	}

	public String getPerPage() {
		return perPage;
	}

	public void setPerPage(String perPage) {
		this.perPage = perPage;
	}

	public List getResult() {
		return result;
	}

	public void setResult(List result) {
		this.result = result;
	}

	public String getTitol() {
		return titol;
	}

	public void setTitol(String titol) {
		this.titol = titol;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}
	
	
	

}
