package com.tmmas.scl.operations.crm.f.s.manpro.web.form;
import org.apache.struts.action.ActionForm;

public class NumerosFrecuentesForm extends ActionForm {
	
	private static final long serialVersionUID = 1L;
	private long numCelular;
	private String correlativo;
	private String numFrecArr;
	private String tiposNumArr;
	private String codTiposNumArr;
	private String codPadrePaq;
	private String identificadorProducto;
	public String getCodPadrePaq() {
		return codPadrePaq;
	}
	public void setCodPadrePaq(String codPadrePaq) {
		this.codPadrePaq = codPadrePaq;
	}
	public String getCorrelativo() {
		return correlativo;
	}
	public void setCorrelativo(String correlativo) {
		this.correlativo = correlativo;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumFrecArr() {
		return numFrecArr;
	}
	public void setNumFrecArr(String numFrecArr) {
		this.numFrecArr = numFrecArr;
	}
	public String getTiposNumArr() {
		return tiposNumArr;
	}
	public void setTiposNumArr(String tiposNumArr) {
		this.tiposNumArr = tiposNumArr;
	}
	public String getCodTiposNumArr() {
		return codTiposNumArr;
	}
	public void setCodTiposNumArr(String codTiposNumArr) {
		this.codTiposNumArr = codTiposNumArr;
	}
	public String getIdentificadorProducto() {
		return identificadorProducto;
	}
	public void setIdentificadorProducto(String identificadorProducto) {
		this.identificadorProducto = identificadorProducto;
	}


	
}
