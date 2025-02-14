/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 04/09/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class DescuentoVendedorDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private int codVendedor;
	private int indCreaDescuento;
	private int rangoInfPorcDescuento;
	private int rangoSupPorcDescuento;
	
	public int getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}
	public int getIndCreaDescuento() {
		return indCreaDescuento;
	}
	public void setIndCreaDescuento(int indCreaDescuento) {
		this.indCreaDescuento = indCreaDescuento;
	}
	public int getRangoInfPorcDescuento() {
		return rangoInfPorcDescuento;
	}
	public void setRangoInfPorcDescuento(int rangoInfPorcDescuento) {
		this.rangoInfPorcDescuento = rangoInfPorcDescuento;
	}
	public int getRangoSupPorcDescuento() {
		return rangoSupPorcDescuento;
	}
	public void setRangoSupPorcDescuento(int rangoSupPorcDescuento) {
		this.rangoSupPorcDescuento = rangoSupPorcDescuento;
	}
	
}
