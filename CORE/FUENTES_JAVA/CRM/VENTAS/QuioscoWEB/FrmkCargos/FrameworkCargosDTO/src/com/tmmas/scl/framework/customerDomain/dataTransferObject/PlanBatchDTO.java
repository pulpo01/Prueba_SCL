package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class PlanBatchDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private String codActAl;
	private String codActBa;
	private int tipoEstado;
	private long idSecuencia;
	private String usuario;
	private String codOOSS;
	private long numAbonado;
	private int periodoFact;
	private String codPlanTarif;
	private String fecVencimiento;
	private String codActAbo;
	private long numOSF;
	private String descripcion;
	private int tipProcesa;
	private String codModGener;
	private String desEstadoDoc;
	private long numCelular;
	private long codCliente;
	private long codCuenta;
	private int codProducto;
	private String tipoTerminal;
	private String tipoPlanTarif;
	private String codServicio;
	private int codEstado;
	private long numMovimiento;
	private int codCausaExc;
	
	public int getCodCausaExc() {
		return codCausaExc;
	}
	public void setCodCausaExc(int codCausaExc) {
		this.codCausaExc = codCausaExc;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public String getCodActAl() {
		return codActAl;
	}
	public void setCodActAl(String codActAl) {
		this.codActAl = codActAl;
	}
	public String getCodActBa() {
		return codActBa;
	}
	public void setCodActBa(String codActBa) {
		this.codActBa = codActBa;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public int getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(int codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodModGener() {
		return codModGener;
	}
	public void setCodModGener(String codModGener) {
		this.codModGener = codModGener;
	}
	public String getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(String codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public int getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(int codProducto) {
		this.codProducto = codProducto;
	}
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public String getDesEstadoDoc() {
		return desEstadoDoc;
	}
	public void setDesEstadoDoc(String desEstadoDoc) {
		this.desEstadoDoc = desEstadoDoc;
	}

	public String getFecVencimiento() {
		return fecVencimiento;
	}
	public void setFecVencimiento(String fecVencimiento) {
		this.fecVencimiento = fecVencimiento;
	}
	public long getIdSecuencia() {
		return idSecuencia;
	}
	public void setIdSecuencia(long idSecuencia) {
		this.idSecuencia = idSecuencia;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public long getNumOSF() {
		return numOSF;
	}
	public void setNumOSF(long numOSF) {
		this.numOSF = numOSF;
	}
	public int getPeriodoFact() {
		return periodoFact;
	}
	public void setPeriodoFact(int periodoFact) {
		this.periodoFact = periodoFact;
	}
	public int getTipoEstado() {
		return tipoEstado;
	}
	public void setTipoEstado(int tipoEstado) {
		this.tipoEstado = tipoEstado;
	}
	public String getTipoPlanTarif() {
		return tipoPlanTarif;
	}
	public void setTipoPlanTarif(String tipoPlanTarif) {
		this.tipoPlanTarif = tipoPlanTarif;
	}
	public String getTipoTerminal() {
		return tipoTerminal;
	}
	public void setTipoTerminal(String tipoTerminal) {
		this.tipoTerminal = tipoTerminal;
	}
	public int getTipProcesa() {
		return tipProcesa;
	}
	public void setTipProcesa(int tipProcesa) {
		this.tipProcesa = tipProcesa;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getNumMovimiento() {
		return numMovimiento;
	}
	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}
	

	
}
