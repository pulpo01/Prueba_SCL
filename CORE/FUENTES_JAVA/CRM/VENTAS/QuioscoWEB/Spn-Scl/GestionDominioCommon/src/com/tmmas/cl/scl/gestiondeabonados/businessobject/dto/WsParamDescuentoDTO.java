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
 * 11/04/2007     Héctor Hermosilla             			Versión Inicial
 */

package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class WsParamDescuentoDTO implements Serializable{
		
	private static final long serialVersionUID = 1L;
	
	private String codigoCliente;
	private String codigoVendedor;
	private String codigoContratoNuevo;
	private String codigoModalidadVenta;
	private String codigoCausaDescuento;
	private String codPlanTarifario;

	public String getCodigoCausaDescuento() {
		return codigoCausaDescuento;
	}
	public void setCodigoCausaDescuento(String codigoCausaDescuento) {
		this.codigoCausaDescuento = codigoCausaDescuento;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoContratoNuevo() {
		return codigoContratoNuevo;
	}
	public void setCodigoContratoNuevo(String codigoContratoNuevo) {
		this.codigoContratoNuevo = codigoContratoNuevo;
	}
	public String getCodigoModalidadVenta() {
		return codigoModalidadVenta;
	}
	public void setCodigoModalidadVenta(String codigoModalidadVenta) {
		this.codigoModalidadVenta = codigoModalidadVenta;
	}
	public String getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(String codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodPlanTarifario() {
		return codPlanTarifario;
	}
	public void setCodPlanTarifario(String codPlanTarifario) {
		this.codPlanTarifario = codPlanTarifario;
	}
	
	
	
	

}
