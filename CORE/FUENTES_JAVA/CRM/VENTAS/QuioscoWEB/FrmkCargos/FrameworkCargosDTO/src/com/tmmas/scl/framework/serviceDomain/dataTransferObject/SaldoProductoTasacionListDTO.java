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
 * 25/10/2007     			 Fernando Mateluna              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class SaldoProductoTasacionListDTO  implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codCliente;
	private SaldoProductoTasacionDTO[] saldoProducto; 
	
	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public SaldoProductoTasacionDTO[] getSaldoProducto() {
		return saldoProducto;
	}

	public void setSaldoProducto(SaldoProductoTasacionDTO[] saldoProducto) {
		this.saldoProducto = saldoProducto;
	}

	
}
