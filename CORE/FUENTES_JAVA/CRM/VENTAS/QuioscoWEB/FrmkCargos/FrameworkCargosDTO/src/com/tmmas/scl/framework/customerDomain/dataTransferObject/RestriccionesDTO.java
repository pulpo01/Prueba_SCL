package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class RestriccionesDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long idSecuencia;	
	private String codEvento;
	private String programa;
	private String codActuacion;
	private long numAbonado;
	private String proceso;
	private long codCliente;
	private String codModGener;
	private long numVenta;
	private String codOOSS;
	private String codVendedor;
	private int desactivacionSS;
	private String planDestino;
	private int codUso;
	private long codCuentaOrigen;
	private long codCuentaDestino;
	private long codClienteDestino;
	private String tipoPlan;
	private String tipoPlanDestino;
	private long numCiclo;
	private Date fechaSistema;
	private String restriccionAux;
	private String codModulo;
	private int codTarea;
	private int codCentral;
	
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
	}
	public long getCodClienteDestino() {
		return codClienteDestino;
	}
	public void setCodClienteDestino(long codClienteDestino) {
		this.codClienteDestino = codClienteDestino;
	}
	public long getCodCuentaDestino() {
		return codCuentaDestino;
	}
	public void setCodCuentaDestino(long codCuentaDestino) {
		this.codCuentaDestino = codCuentaDestino;
	}
	public long getCodCuentaOrigen() {
		return codCuentaOrigen;
	}
	public void setCodCuentaOrigen(long codCuentaOrigen) {
		this.codCuentaOrigen = codCuentaOrigen;
	}
	public String getCodEvento() {
		return codEvento;
	}
	public void setCodEvento(String codEvento) {
		this.codEvento = codEvento;
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
	public int getCodTarea() {
		return codTarea;
	}
	public void setCodTarea(int codTarea) {
		this.codTarea = codTarea;
	}
	public int getCodUso() {
		return codUso;
	}
	public void setCodUso(int codUso) {
		this.codUso = codUso;
	}

	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}
	public int getDesactivacionSS() {
		return desactivacionSS;
	}
	public void setDesactivacionSS(int desactivacionSS) {
		this.desactivacionSS = desactivacionSS;
	}
	public Date getFechaSistema() {
		return fechaSistema;
	}
	public void setFechaSistema(Date fechaSistema) {
		this.fechaSistema = fechaSistema;
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
	public long getNumCiclo() {
		return numCiclo;
	}
	public void setNumCiclo(long numCiclo) {
		this.numCiclo = numCiclo;
	}
	public String getPlanDestino() {
		return planDestino;
	}
	public void setPlanDestino(String planDestino) {
		this.planDestino = planDestino;
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

	public String getRestriccionAux() {
		return restriccionAux;
	}
	public void setRestriccionAux(String restriccionAux) {
		this.restriccionAux = restriccionAux;
	}
	public String getTipoPlan() {
		return tipoPlan;
	}
	public void setTipoPlan(String tipoPlan) {
		this.tipoPlan = tipoPlan;
	}
	public String getTipoPlanDestino() {
		return tipoPlanDestino;
	}
	public void setTipoPlanDestino(String tipoPlanDestino) {
		this.tipoPlanDestino = tipoPlanDestino;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	

}
