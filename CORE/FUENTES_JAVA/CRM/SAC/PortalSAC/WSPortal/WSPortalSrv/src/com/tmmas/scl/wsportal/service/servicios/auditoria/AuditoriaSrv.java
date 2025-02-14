/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */
package com.tmmas.scl.wsportal.service.servicios.auditoria;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.businessobject.bo.AuditoriaBO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;

/**
 * La Class AuditoriaSrv.
 */
public class AuditoriaSrv
{
	
	/** La constante PROPERTIES_INTERNO. */
	public static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalSrv.properties";

	/** La constante PROPERTIES_EXTERNO. */
	public static final String PROPERTIES_EXTERNO = "WSPortalSrv.properties";

	/** La constante CLAVE_CONFIGURACION_LOG. */
	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalSrv.archivo.config.log4j";

	/** El atributo logger. */
	private static Logger logger = Logger.getLogger(AuditoriaSrv.class);

	/** El atributo auditoria bo. */
	private AuditoriaBO auditoriaBO = new AuditoriaBO();

	/** El atributo config. */
	private static CompositeConfiguration config = UtilProperty
			.getConfiguration(PROPERTIES_EXTERNO, PROPERTIES_INTERNO);

	/** La constante CONFIGURACION_LOG. */
	private static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	/** La constante INICIO_LOG. */
	private static final String INICIO_LOG = "Inicio";

	/** La constante FIN_LOG. */
	private static final String FIN_LOG = "Fin";

	/**
	 * Auditar.
	 * 
	 * @param codEvento el parametro codEvento
	 * @param nomUsuarioSCL el parametro nomUsuarioSCL
	 * @param numCelular el parametro numCelular
	 * @param numAbonado el parametro numAbonado
	 * @param codCliente el parametro codCliente
	 * @param codCuenta el parametro codCuenta
	 * 
	 * @throws PortalSACException the portal sac exception
	 */
	public void auditar(String codEvento, String nomUsuarioSCL, Long numCelular, Long numAbonado, Long codCliente,
			Long codCuenta) throws PortalSACException
	{
		UtilLog.setLog(CONFIGURACION_LOG);
		logger.info(INICIO_LOG);
		auditoriaBO.auditar(codEvento, nomUsuarioSCL, numCelular, numAbonado, codCliente, codCuenta);
		logger.info(FIN_LOG);
	}

}
