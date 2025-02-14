package com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;

public class RetornoCondicionesCPUDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private long codOSAnt;
	private String codActuacion;
	private String evento;
	private String saldo;
	private String codPlanServNuevo;
	private String aplicaTraspaso;
	private String mensaje;
	private String fecDesdeLlam;
	private int periodoFact;
	private AbonadoDTO[] abonadosValidos;
	private AbonadoDTO[] abonadosInvalidos;
	private String indTraspaso;
	
	private String codMensaje;
	private long codTipMensaje;
	
	private String limConsumoEvalCred;
	private String codActAboAux;
	
	public String getCodActAboAux() {
		return codActAboAux;
	}
	public void setCodActAboAux(String codActAboAux) {
		this.codActAboAux = codActAboAux;
	}
	public String getLimConsumoEvalCred() {
		return limConsumoEvalCred;
	}
	public void setLimConsumoEvalCred(String limConsumoEvalCred) {
		this.limConsumoEvalCred = limConsumoEvalCred;
	}
	public int getPeriodoFact() {
		return periodoFact;
	}
	public void setPeriodoFact(int periodoFact) {
		this.periodoFact = periodoFact;
	}
	public String getMensaje() {
		return mensaje;
	}
	public void setMensaje(String mensaje) {
		this.mensaje = mensaje;
	}
	public String getAplicaTraspaso() {
		return aplicaTraspaso;
	}
	public void setAplicaTraspaso(String aplicaTraspaso) {
		this.aplicaTraspaso = aplicaTraspaso;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public long getCodOSAnt() {
		return codOSAnt;
	}
	public void setCodOSAnt(long codOSAnt) {
		this.codOSAnt = codOSAnt;
	}
	public String getEvento() {
		return evento;
	}
	public void setEvento(String evento) {
		this.evento = evento;
	}
	public String getSaldo() {
		return saldo;
	}
	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}
	public String getCodPlanServNuevo() {
		return codPlanServNuevo;
	}
	public void setCodPlanServNuevo(String codPlanServNuevo) {
		this.codPlanServNuevo = codPlanServNuevo;
	}
	public String getCodMensaje() {
		return codMensaje;
	}
	public void setCodMensaje(String codMensaje) {
		this.codMensaje = codMensaje;
	}
	public long getCodTipMensaje() {
		return codTipMensaje;
	}
	public void setCodTipMensaje(long codTipMensaje) {
		this.codTipMensaje = codTipMensaje;
	}
	public String getFecDesdeLlam() {
		return fecDesdeLlam;
	}
	public void setFecDesdeLlam(String fecDesdeLlam) {
		this.fecDesdeLlam = fecDesdeLlam;
	}
	public AbonadoDTO[] getAbonadosValidos() {
		return abonadosValidos;
	}
	public void setAbonadosValidos(AbonadoDTO[] abonadosValidos) {
		this.abonadosValidos = abonadosValidos;
	}
	public AbonadoDTO[] getAbonadosInvalidos() {
		return abonadosInvalidos;
	}
	public void setAbonadosInvalidos(AbonadoDTO[] abonadosInvalidos) {
		this.abonadosInvalidos = abonadosInvalidos;
	}
	public String getIndTraspaso() {
		return indTraspaso;
	}
	public void setIndTraspaso(String indTraspaso) {
		this.indTraspaso = indTraspaso;
	}

	

}
