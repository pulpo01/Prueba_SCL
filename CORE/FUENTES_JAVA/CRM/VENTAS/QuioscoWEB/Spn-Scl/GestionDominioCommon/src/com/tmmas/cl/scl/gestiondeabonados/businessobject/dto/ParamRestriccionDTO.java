package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class ParamRestriccionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String programa = new String("");
	private String version = new String("");
	private String proceso = new String("");
	private String actuacion = new String("");
	private String numAbonado = new String("");
	private String codCliente = new String("");
	private String codModGener = new String("");
	private String numVenta = new String("");
	private String codOOSS = new String("");
	private String codVendedor = new String("");
	private String desSS = new String("");
	private String codPlanTarifDes = new String("");
	private String codUso = new String("");
	private String codCuentaOrg = new String("");
	private String codCuentaDes = new String("");
	private String CodClienteDes = new String("");
	private String codTipPlanTarif = new String("");
	private String codTipPlanTarifD = new String("");
	private String codCiclo = new String("");
	private String fechaSistema = new String("");
	private String restriccionAux = new String("");
	private String codModulo = new String("");
	private String numId = new String("");
	private String codCentral = new String("");
	
	
	public String getActuacion() {
		return actuacion;
	}
	public void setActuacion(String actuacion) {
		this.actuacion = actuacion;
	}
	public String getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(String codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(String codCiclo) {
		this.codCiclo = codCiclo;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodClienteDes() {
		return CodClienteDes;
	}
	public void setCodClienteDes(String codClienteDes) {
		CodClienteDes = codClienteDes;
	}
	public String getCodCuentaDes() {
		return codCuentaDes;
	}
	public void setCodCuentaDes(String codCuentaDes) {
		this.codCuentaDes = codCuentaDes;
	}
	public String getCodCuentaOrg() {
		return codCuentaOrg;
	}
	public void setCodCuentaOrg(String codCuentaOrg) {
		this.codCuentaOrg = codCuentaOrg;
	}
	public String getCodModGener() {
		return codModGener;
	}
	public void setCodModGener(String codModGener) {
		this.codModGener = codModGener;
	}
	public String getCodModulo() {
		return codModulo;
	}
	public void setCodModulo(String codModulo) {
		this.codModulo = codModulo;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodPlanTarifDes() {
		return codPlanTarifDes;
	}
	public void setCodPlanTarifDes(String codPlanTarifDes) {
		this.codPlanTarifDes = codPlanTarifDes;
	}
	public String getCodTipPlanTarif() {
		return codTipPlanTarif;
	}
	public void setCodTipPlanTarif(String codTipPlanTarif) {
		this.codTipPlanTarif = codTipPlanTarif;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getDesSS() {
		return desSS;
	}
	public void setDesSS(String desSS) {
		this.desSS = desSS;
	}
	public String getFechaSistema() {
		return fechaSistema;
	}
	public void setFechaSistema(String fechaSistema) {
		this.fechaSistema = fechaSistema;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumId() {
		return numId;
	}
	public void setNumId(String numId) {
		this.numId = numId;
	}
	public String getProceso() {
		return proceso;
	}
	public void setProceso(String proceso) {
		this.proceso = proceso;
	}
	public String getPrograma() {
		return programa;
	}
	public void setPrograma(String programa) {
		this.programa = programa;
	}
	public String getVersion() {
		return version;
	}
	public void setVersion(String version) {
		this.version = version;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
	public String getCodTipPlanTarifD() {
		return codTipPlanTarifD;
	}
	public void setCodTipPlanTarifD(String codTipPlanTarifD) {
		this.codTipPlanTarifD = codTipPlanTarifD;
	}
	public String getRestriccionAux() {
		return restriccionAux;
	}
	public void setRestriccionAux(String restriccionAux) {
		this.restriccionAux = restriccionAux;
	}



}
