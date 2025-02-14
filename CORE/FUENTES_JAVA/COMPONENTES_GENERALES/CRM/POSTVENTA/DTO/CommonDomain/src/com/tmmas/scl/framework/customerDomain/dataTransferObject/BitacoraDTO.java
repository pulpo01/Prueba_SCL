
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class BitacoraDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private long numeroProcesosErrados;
	private long numeroProcesosEjecutadosExitosos;
	private ProcesoDTO[] procesos;
	public long getNumeroProcesosEjecutadosExitosos() {
		return numeroProcesosEjecutadosExitosos;
	}
	public void setNumeroProcesosEjecutadosExitosos(
			long numeroProcesosEjecutadosExitosos) {
		this.numeroProcesosEjecutadosExitosos = numeroProcesosEjecutadosExitosos;
	}
	public long getNumeroProcesosErrados() {
		return numeroProcesosErrados;
	}
	public void setNumeroProcesosErrados(long numeroProcesosErrados) {
		this.numeroProcesosErrados = numeroProcesosErrados;
	}
	public ProcesoDTO[] getProcesos() {
		return procesos;
	}
	public void setProcesos(ProcesoDTO[] procesos) {
		this.procesos = procesos;
	}
	

}
