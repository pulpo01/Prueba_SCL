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
 * 25-06-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ProductoTasacionContratadoListDTO;

public class ProductoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idProductoContratado;
	private String idClienteBenef;
	private String idAbonadoBenef;
	private String idProducto;
	private String idCanal;
	private String nroOperacion;
	private String condProducto;
	private	String idClienteContra;
	private String idAbonadoContra;
	private NumeroListDTO numerosDTO;
	private PerfilProvisionamientoListDTO perfilProvisionamientoListDTO;
	private ProductoTasacionContratadoListDTO productoTasacionContratadoListDTO;
	
	public String getCondProducto() {
		return condProducto;
	}
	public void setCondProducto(String condProducto) {
		this.condProducto = condProducto;
	}
	public String getIdAbonadoBenef() {
		return idAbonadoBenef;
	}
	public void setIdAbonadoBenef(String idAbonadoBenef) {
		this.idAbonadoBenef = idAbonadoBenef;
	}
	public String getIdAbonadoContra() {
		return idAbonadoContra;
	}
	public void setIdAbonadoContra(String idAbonadoContra) {
		this.idAbonadoContra = idAbonadoContra;
	}
	public String getIdCanal() {
		return idCanal;
	}
	public void setIdCanal(String idCanal) {
		this.idCanal = idCanal;
	}
	public String getIdClienteBenef() {
		return idClienteBenef;
	}
	public void setIdClienteBenef(String idClienteBenef) {
		this.idClienteBenef = idClienteBenef;
	}
	public String getIdClienteContra() {
		return idClienteContra;
	}
	public void setIdClienteContra(String idClienteContra) {
		this.idClienteContra = idClienteContra;
	}
	public String getIdProducto() {
		return idProducto;
	}
	public void setIdProducto(String idProducto) {
		this.idProducto = idProducto;
	}
	public String getIdProductoContratado() {
		return idProductoContratado;
	}
	public void setIdProductoContratado(String idProductoContratado) {
		this.idProductoContratado = idProductoContratado;
	}
	public String getNroOperacion() {
		return nroOperacion;
	}
	public void setNroOperacion(String nroOperacion) {
		this.nroOperacion = nroOperacion;
	}
	public NumeroListDTO getNumerosDTO() {
		return numerosDTO;
	}
	public void setNumerosDTO(NumeroListDTO numerosDTO) {
		this.numerosDTO = numerosDTO;
	}
	public PerfilProvisionamientoListDTO getPerfilProvisionamientoListDTO() {
		return perfilProvisionamientoListDTO;
	}
	public void setPerfilProvisionamientoListDTO(
			PerfilProvisionamientoListDTO perfilProvisionamientoListDTO) {
		this.perfilProvisionamientoListDTO = perfilProvisionamientoListDTO;
	}
	public ProductoTasacionContratadoListDTO getProductoTasacionContratadoListDTO() {
		return productoTasacionContratadoListDTO;
	}
	public void setProductoTasacionContratadoListDTO(
			ProductoTasacionContratadoListDTO productoTasacionContratadoListDTO) {
		this.productoTasacionContratadoListDTO = productoTasacionContratadoListDTO;
	}
	
	
	
	

}
