package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

public class ParametrosCondicionesCPUDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private long codOOSS;
	private long numCelular;
	private String codTecnologia;
	private long numAbonado;
	private long numAbonados;
	private String codPlanTarifActual;
	private String codPlanServ;
	private String combinatoriaGenerada;
	private String usuario;
	private long codCliente;
	private long numVenta;
	private String codPlanTarifSelec;
	private String codClienteDestino;
	private String tipoPlanTarifDestino;
	private String codCausaBajaSel;
	private String codTipoPlanTarif;
	private String codCausaExcepcion;
	
	
	public String getCodCausaBajaSel() {
		return codCausaBajaSel;
	}
	public void setCodCausaBajaSel(String codCausaBajaSel) {
		this.codCausaBajaSel = codCausaBajaSel;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodPlanServ() {
		return codPlanServ;
	}
	public void setCodPlanServ(String codPlanServ) {
		this.codPlanServ = codPlanServ;
	}
	public String getCodPlanTarifActual() {
		return codPlanTarifActual;
	}
	public void setCodPlanTarifActual(String codPlanTarifActual) {
		this.codPlanTarifActual = codPlanTarifActual;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	
	public String getCombinatoriaGenerada() {
		return combinatoriaGenerada;
	}
	public void setCombinatoriaGenerada(String combinatoriaGenerada) {
		this.combinatoriaGenerada = combinatoriaGenerada;
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
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodPlanTarifSelec() {
		return codPlanTarifSelec;
	}
	public void setCodPlanTarifSelec(String codPlanTarifSelec) {
		this.codPlanTarifSelec = codPlanTarifSelec;
	}
	public String getCodClienteDestino() {
		return codClienteDestino;
	}
	public void setCodClienteDestino(String codClienteDestino) {
		this.codClienteDestino = codClienteDestino;
	}
	public String getTipoPlanTarifDestino() {
		return tipoPlanTarifDestino;
	}
	public void setTipoPlanTarifDestino(String tipoPlanTarifDestino) {
		this.tipoPlanTarifDestino = tipoPlanTarifDestino;
	}
	public String getCodTipoPlanTarif() {
		return codTipoPlanTarif;
	}
	public void setCodTipoPlanTarif(String codTipoPlanTarif) {
		this.codTipoPlanTarif = codTipoPlanTarif;
	}
	public String getCodCausaExcepcion() {
		return codCausaExcepcion;
	}
	public void setCodCausaExcepcion(String codCausaExcepcion) {
		this.codCausaExcepcion = codCausaExcepcion;
	}
	public long getNumAbonados() {
		return numAbonados;
	}
	public void setNumAbonados(long numAbonados) {
		this.numAbonados = numAbonados;
	}
	
	

}
