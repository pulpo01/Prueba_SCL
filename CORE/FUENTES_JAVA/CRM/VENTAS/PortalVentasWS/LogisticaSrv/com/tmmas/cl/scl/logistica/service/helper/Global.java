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
 * 23/02/2007     Roberto P&eacute;rez Varas      					Versión Inicial
 */
package com.tmmas.cl.scl.logistica.service.helper;

import java.io.Serializable;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private JndiForDataSource jndiForDataSource = null;

	
	private final String archivoRecurso = "com.tmmas.cl.scl.logistica.service.properties.logistica";

	// --------------------------------------------------------------------------
	private Global() {
		this.recurso = new MessageResourcesConfig(archivoRecurso);
	}

	// --------------------------------------------------------------------------
	public static synchronized Global getInstance() {
		if (instance == null) {
			instance = new Global();
		}
		return instance;
	}

	public MessageResourcesConfig getMessageResourcesConfig() {
		return this.recurso;
	}

	public String getValor(String valorClave) {
		String valor = this.recurso.obtenerValorClave(valorClave);
		return valor;
	}

	public String getJndiDataSource() {
		return this.recurso.obtenerValorClave("jndi.dataSource");
	}
	
	public JndiForDataSource getJndiForDataSource() {

		if (jndiForDataSource == null) {

			jndiForDataSource = new JndiForDataSource();

			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());

		}
		return jndiForDataSource;
	}
	
	public String errorgetListado()
	{
		return this.recurso.obtenerValorClave("error.getListado.procesaRespuesta");
	}
	
	
	public String ModoEjecucion()
	{
		return this.recurso.obtenerValorClave("modo.ejecucion");
	}
		
	public String getEstadoNuevo(){
		return this.recurso.obtenerValorClave("parametro.estadoNuevo");
	}
	
	public String getCodigoModuloGA(){
		return this.recurso.obtenerValorClave("codigo.modulo.GA");
	}//fin getCodigoModuloGA

	public String getCodigoModuloAL(){
		return this.recurso.obtenerValorClave("codigo.modulo.AL");
	}//fin getCodigoModuloAL
	
	public String getCodigoProducto(){
		return this.recurso.obtenerValorClave("codigo.producto");
	}
	
	public String getUsoVentaPospago(){
		return this.recurso.obtenerValorClave("parametro.usoVentaPospago");
	}
	
	public String getUsoVentaHibrido(){
		return this.recurso.obtenerValorClave("parametro.usoVentaHibrido");
	}

	public String getLargoSerieSimcard(){
		return this.recurso.obtenerValorClave("parametro.largoSerieSimcard");
	}//fin getLargoSerieSimcard

	public String getLargoSerieTerminal(){
		return this.recurso.obtenerValorClave("parametro.largoSerieTerminal");
	}//fin getLargoSerieTerminal
	
	public String getStockConsignacion(){
		return this.recurso.obtenerValorClave("parametro.stockConsignacion");
	}//fin getLargoSerieTerminal

}
	
