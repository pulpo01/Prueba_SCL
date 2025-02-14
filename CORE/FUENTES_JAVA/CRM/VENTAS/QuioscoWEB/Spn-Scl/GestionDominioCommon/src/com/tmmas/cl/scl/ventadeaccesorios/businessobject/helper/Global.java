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
 * 16/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.ventadeaccesorios.businessobject.helper;

import java.io.Serializable;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.ArticuloDTO;

public class Global implements Serializable {
	private static final long serialVersionUID = 1L;

	private MessageResourcesConfig recurso;

	private static Global instance;

	private JndiForDataSource jndiForDataSource = null;

		private final String archivoRecurso = "com.tmmas.cl.scl.ventadeaccesorios.businessobject.properties.businessobject";

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
		return this.recurso.obtenerValorClave("GE.jndi.dataSource.DAO");
	}
	
	public JndiForDataSource getJndiForDataSource() {

		if (jndiForDataSource == null) {

			jndiForDataSource = new JndiForDataSource();

			jndiForDataSource.setJndiDataSource(this.getJndiDataSource());

		}
		return jndiForDataSource;
	}
	
	public int numUnidTotalVenta(ArticuloDTO[] articulo){
		int valor = 0;		
		for(int i = 0; i < articulo.length;i++){
			valor = valor + articulo[i].getNumUnidades();			
		}		
		return valor;
	}
	
	public String getIndVentaProceso() {
		return this.recurso.obtenerValorClave("indicador.venta.proceso");
	}
	public String getIndVenta() {
		return this.recurso.obtenerValorClave("indicador.venta");
	}
	public String getIndAceptacionVenta() {
		return this.recurso.obtenerValorClave("indicador.aceptacion.venta");
	}
	public int getCodigoProducto() {
		return Integer.parseInt(this.recurso.obtenerValorClave("tipo.producto"));
	}
	public String getKit() {
		return this.recurso.obtenerValorClave("indicador.tipo.kit");
	}
}