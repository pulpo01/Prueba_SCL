/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/03/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class RegistroVentaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numeroVenta;
	private long numeroTransaccionVenta;
	private String prefijoMin;
	private long numeroCelular;
	private String codigoSecuencia;
	private String numeroPaquete;
	private boolean existePlanFreedom;
	private String minMDN;

	public String getMinMDN() {
		return minMDN;
	}

	public void setMinMDN(String minMDN) {
		this.minMDN = minMDN;
	}

	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}

	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}

	public long getNumeroCelular() {
		return numeroCelular;
	}

	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}

	public long getNumeroVenta() {
		return numeroVenta;
	}

	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}

	public String getPrefijoMin() {
		return prefijoMin;
	}

	public void setPrefijoMin(String prefijoMin) {
		this.prefijoMin = prefijoMin;
	}

	public long getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}

	public void setNumeroTransaccionVenta(long numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	
	public void setExistePlanFreedom(boolean existePlanFreedom) {
		this.existePlanFreedom = existePlanFreedom;
	}
	
	public boolean existePlanFreedom() {
		return existePlanFreedom;
	}

	public String getNumeroPaquete() {
		return numeroPaquete;
	}

	public void setNumeroPaquete(String numeroPaquete) {
		this.numeroPaquete = numeroPaquete;
	}
	
	
}
