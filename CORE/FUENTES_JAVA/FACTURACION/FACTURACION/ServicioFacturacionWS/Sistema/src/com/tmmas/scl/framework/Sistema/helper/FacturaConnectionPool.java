package com.tmmas.scl.framework.Sistema.helper;


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
 * 09/09/2008     Hernán Segura Muñoz      					Versión Inicial
 */

import java.io.Serializable;

import org.apache.commons.configuration.CompositeConfiguration;

import com.tmmas.cl.framework.base.JndiForDataSource;
import com.tmmas.cl.framework.util.MessageResourcesConfig;
import com.tmmas.cl.framework20.util.UtilProperty;

public class FacturaConnectionPool {
	private static final long serialVersionUID = 1L;


	private static FacturaConnectionPool instance;

	private static JndiForDataSource jndiForDataSource = null;

	
	private CompositeConfiguration config;

	public FacturaConnectionPool() {
		super();
		config = UtilProperty
				.getConfiguration("ServicioFacturacionWS.properties",
						"com/tmmas/scl/framework/properties/archivorecursos.properties");
	}
	// 
	public static synchronized FacturaConnectionPool getInstance() {
		if (instance == null) {
			instance = new FacturaConnectionPool();
		}
		return instance;
	}
	public JndiForDataSource getJndiForDataSource() {
		if (jndiForDataSource == null) {
			jndiForDataSource = new JndiForDataSource();
			jndiForDataSource.setJndiDataSource(config
					.getString("jndi.dataSource"));

		}
		return jndiForDataSource;
	}
	
}