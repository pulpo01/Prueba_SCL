/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 18/05/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class OOSSDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long numOs;
	private String codPrograma;
	private short numVersion;
	private String codProceso;
	private String codActuacion;
	private long codAbonado;
	private long codCliente;
	private String codModGener;
	private long codVenta;
	private long codOOSS;
	private long codVendedor;
	private boolean flgDesactivaSS;
	private String codPlanTarifDestino;
	private short codUso;
	private long codCuenta;
	private long codCuentaDestino;
	private short codCiclo;
	private Date fechaSistema;
	private String codRestriccionAuxiliar;
	private String codModulo;
	private long codTarea;
	private short codCentral;
	
	public long getCodAbonado() {
		return codAbonado;
	}
	public void setCodAbonado(long codAbonado) {
		this.codAbonado = codAbonado;
	}
	public String getCodActuacion() {
		return codActuacion;
	}
	public void setCodActuacion(String codActuacion) {
		this.codActuacion = codActuacion;
	}
	public short getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(short codCentral) {
		this.codCentral = codCentral;
	}
	public short getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(short codCiclo) {
		this.codCiclo = codCiclo;
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
	public long getCodCuentaDestino() {
		return codCuentaDestino;
	}
	public void setCodCuentaDestino(long codCuentaDestino) {
		this.codCuentaDestino = codCuentaDestino;
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
	public long getCodOOSS() {
		return codOOSS;
	}
	public void setCodOOSS(long codOOSS) {
		this.codOOSS = codOOSS;
	}
	public String getCodPlanTarifDestino() {
		return codPlanTarifDestino;
	}
	public void setCodPlanTarifDestino(String codPlanTarifDestino) {
		this.codPlanTarifDestino = codPlanTarifDestino;
	}
	public String getCodProceso() {
		return codProceso;
	}
	public void setCodProceso(String codProceso) {
		this.codProceso = codProceso;
	}
	public String getCodPrograma() {
		return codPrograma;
	}
	public void setCodPrograma(String codPrograma) {
		this.codPrograma = codPrograma;
	}
	public String getCodRestriccionAuxiliar() {
		return codRestriccionAuxiliar;
	}
	public void setCodRestriccionAuxiliar(String codRestriccionAuxiliar) {
		this.codRestriccionAuxiliar = codRestriccionAuxiliar;
	}
	public long getCodTarea() {
		return codTarea;
	}
	public void setCodTarea(long codTarea) {
		this.codTarea = codTarea;
	}
	public short getCodUso() {
		return codUso;
	}
	public void setCodUso(short codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getCodVenta() {
		return codVenta;
	}
	public void setCodVenta(long codVenta) {
		this.codVenta = codVenta;
	}
	public Date getFechaSistema() {
		return fechaSistema;
	}
	public void setFechaSistema(Date fechaSistema) {
		this.fechaSistema = fechaSistema;
	}
	public boolean isFlgDesactivaSS() {
		return flgDesactivaSS;
	}
	public void setFlgDesactivaSS(boolean flgDesactivaSS) {
		this.flgDesactivaSS = flgDesactivaSS;
	}
	public short getNumVersion() {
		return numVersion;
	}
	public void setNumVersion(short numVersion) {
		this.numVersion = numVersion;
	}
	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}

}
