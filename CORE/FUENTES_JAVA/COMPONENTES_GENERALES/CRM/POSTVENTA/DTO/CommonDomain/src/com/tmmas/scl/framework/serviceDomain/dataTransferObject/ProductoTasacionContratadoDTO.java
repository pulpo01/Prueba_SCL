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
package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;

public class ProductoTasacionContratadoDTO implements Serializable
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String idPlan;
	private String idCliente;
	private String idAbonado;	
	private NumeroListDTO listaNumeros;
	private String codProductoContratado;
	private String tipoComp;
	private String canalDistro;
	private Date fecInicioVigencia;
	private Date fecTerminoVigencia;
	private String codProdBase;
	private String indPrioridad;

	
	public Object[] toStruct_TOL_ALTA_PRODUCTO_QT()
	{
		Object[] obj={	idAbonado,
						fecInicioVigencia!=null?new Timestamp(fecInicioVigencia.getTime()):null,
						fecTerminoVigencia!=null?new Timestamp(fecTerminoVigencia.getTime()):null,
						codProdBase,
						codProductoContratado,
						indPrioridad
					 };		
		return obj;
	}
	
	public ProductoTasacionContratadoDTO()
	{
		Calendar cal=Calendar.getInstance();
		cal.set(3000, 11, 31);
		this.fecInicioVigencia=new Date();
		this.fecTerminoVigencia=new Date(cal.getTimeInMillis());
	}	

	public String getCanalDistro() {
		return canalDistro;
	}
	public void setCanalDistro(String canalDistro) {
		this.canalDistro = canalDistro;
	}
	public String getCodProdBase() {
		return codProdBase;
	}
	public void setCodProdBase(String codProdBase) {
		this.codProdBase = codProdBase;
	}
	
	public String getCodProductoContratado() {
		return codProductoContratado;
	}

	public void setCodProductoContratado(String codProductoContratado) {
		this.codProductoContratado = codProductoContratado;
	}

	public Date getFecInicioVigencia() {
		return fecInicioVigencia;
	}
	public void setFecInicioVigencia(Date fecInicioVigencia) {
		this.fecInicioVigencia = fecInicioVigencia;
	}
	public Date getFecTerminoVigencia() {
		return fecTerminoVigencia;
	}
	public void setFecTerminoVigencia(Date fecTerminoVigencia) {
		this.fecTerminoVigencia = fecTerminoVigencia;
	}
	public String getIndPrioridad() {
		return indPrioridad;
	}
	public void setIndPrioridad(String indPrioridad) {
		this.indPrioridad = indPrioridad;
	}
	public NumeroListDTO getListaNumeros() {
		return listaNumeros;
	}
	public void setListaNumeros(NumeroListDTO listaNumeros) {
		this.listaNumeros = listaNumeros;
	}
	public String getTipoComp() {
		return tipoComp;
	}
	public void setTipoComp(String tipoComp) {
		this.tipoComp = tipoComp;
	}
	public String getIdAbonado() {
		return idAbonado;
	}
	public void setIdAbonado(String idAbonado) {
		this.idAbonado = idAbonado;
	}
	public String getIdCliente() {
		return idCliente;
	}
	public void setIdCliente(String idCliente) {
		this.idCliente = idCliente;
	}
	public String getIdPlan() {
		return idPlan;
	}
	public void setIdPlan(String idPlan) {
		this.idPlan = idPlan;
	}
}
