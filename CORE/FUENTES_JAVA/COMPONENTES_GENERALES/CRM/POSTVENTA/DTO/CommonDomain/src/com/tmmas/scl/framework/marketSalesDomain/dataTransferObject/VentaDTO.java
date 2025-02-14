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
 * 29-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.marketSalesDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;

public class VentaDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String idVenta;
	private Date fecVenta;
	private String origenProceso;
	private ClienteDTO cliente;
	
	/**
	 * Codigo de vendedor
	 */
	private String codVendedor;
	
	/**
	 * Numero de transaccion para facturacion.
	 */
	private String numTransaccion;
	
	/**
	 * Numero de proceso para la actualizacion
	 */
	private String numEvento;
	
	private String flagCiclo;
	
	public VentaDTO()
	{
		this.fecVenta=new Date();		
	}
	
	
	
	public String getCodVendedor() {
		return codVendedor;
	}



	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}



	public String getNumEvento() {
		return numEvento;
	}



	public void setNumEvento(String numEvento) {
		this.numEvento = numEvento;
	}



	public String getNumTransaccion() {
		return numTransaccion;
	}



	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}



	public String getIdVenta() {
		return idVenta;
	}
	public void setIdVenta(String idVenta) {
		this.idVenta = idVenta;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public Date getFecVenta() {
		return fecVenta;
	}
	public void setFecVenta(Date fecVenta) {
		this.fecVenta = fecVenta;
	}
	
	public Object[] toStruct_GA_VENTA_QT()
	{
		Object[] objetos= {idVenta,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						   null,
						};
		return objetos;
	}
	
	public Object[] toStruct_PR_VENTA_QT()
	{
		Object[] objetos= {idVenta};
		return objetos;
	}



	public String getFlagCiclo() {
		return flagCiclo;
	}



	public void setFlagCiclo(String flagCiclo) {
		this.flagCiclo = flagCiclo;
	}
	public String getOrigenProceso() {
		return origenProceso;
	}

	public void setOrigenProceso(String origenProceso) {
		this.origenProceso = origenProceso;
	}	
	
	
}
