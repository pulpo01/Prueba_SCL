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
 * 01/05/2007     Héctor Hermosilla             			Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;


public class ListadoCargoSolicitudDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	
	private long numVenta;
	private long codCliente;
	private long numTransaccionVta;
	private String codOficina;
	private String codTipoDocumento;
	private String codModVenta;
	private CargoSolicitudDTO[] cargos;

	public CargoSolicitudDTO[] getCargos() {
		return cargos;
	}

	public void setCargos(CargoSolicitudDTO[] cargos) {
		this.cargos = cargos;
	}

	public long getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public long getNumTransaccionVta() {
		return numTransaccionVta;
	}

	public void setNumTransaccionVta(long numTransaccionVta) {
		this.numTransaccionVta = numTransaccionVta;
	}

	public String getCodModVenta() {
		return codModVenta;
	}

	public void setCodModVenta(String codModVenta) {
		this.codModVenta = codModVenta;
	}

	public String getCodOficina() {
		return codOficina;
	}

	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	public String getCodTipoDocumento() {
		return codTipoDocumento;
	}

	public void setCodTipoDocumento(String codTipoDocumento) {
		this.codTipoDocumento = codTipoDocumento;
	}

	

}
