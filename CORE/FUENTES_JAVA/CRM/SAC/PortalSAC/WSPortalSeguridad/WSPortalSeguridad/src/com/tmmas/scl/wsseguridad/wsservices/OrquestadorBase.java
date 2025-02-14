/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsseguridad.wsservices;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.xml.namespace.QName;

import org.apache.axis2.AxisFault;
import org.apache.axis2.addressing.EndpointReference;
import org.apache.axis2.client.Options;
import org.apache.axis2.rpc.client.RPCServiceClient;
import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import weblogic.jndi.Environment;

import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.CargaCambioDatosClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambiodatoscliente.EjecucionCambioDatosClienteDTO;
import com.tmmas.scl.wsfranquicias.common.dto.cambionumerosfrecuentes.CargaCambioNumFrecuentesDTO;
import com.tmmas.scl.wsportal.common.dto.AuditoriaDTO;
import com.tmmas.scl.wsportal.common.dto.GetDocsClienteINDTO;

public class OrquestadorBase
{
	static Logger logger = Logger.getLogger(OrquestadorBase.class);

	final static String ESPACIO_NOMBRES_PORTAL = "http://wsservices.wsportal.scl.tmmas.com";

	final static String ESPACIO_NOMBRES_FRANQUICIAS = "http://webservices.wsfranquicias.scl.tmmas.com";

	private static final String CLAVE_URL_SERVICIOS_PORTAL = "ws.servicios.adicionales";

	private static final String CLAVE_URL_SERVICIOS_PORTAL_MEJORA = "ws.servicios.adicionalesMejoras";

	static final String PROPIEDADES_INTERNO = "com/tmmas/scl/wsseguridad/properties/WSPortalSeguridadWS.properties";

	static final String PROPIEDADES_EXTERNO = "WSPortalSeguridadWS.properties";

	static CompositeConfiguration config = UtilProperty.getConfiguration(PROPIEDADES_EXTERNO, PROPIEDADES_INTERNO);

	static final String URL = config.getString("GE.url.PortalEAR.GE");

	static final String INITIAL_CONTEXT_FACTORY = config.getString("GE.initial.context.factory.GE");

	static final String SECURITY_PRINCIPAL = config.getString("GE.security.principal.GE");

	static final String SECURITY_CREDENTIALS = config.getString("GE.security.credentials.GE");

	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalSeguridadWS.archivo.config.log4j";

	static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	static final String URL_SERVICIOS_PORTAL = config.getString(CLAVE_URL_SERVICIOS_PORTAL);
	
	static final String URL_SERVICIOS_PORTAL_MEJORA = config.getString(CLAVE_URL_SERVICIOS_PORTAL_MEJORA);

	static final String MENSAJE_INICIO_LOG = "Inicio";

	static final String MENSAJE_FIN_LOG = "Fin";

	static final void invocarMetodoWebAuditoria(String codEvento, String nomUsuarioSCL, Long numCelular,
			Long numAbonado, Long codCliente, Long codCuenta, String espacioNombres, String url) throws AxisFault
	{
		logger.info(MENSAJE_INICIO_LOG);
		logger.debug("codEvento [" + codEvento + "]");
		logger.debug("nomUsuarioSCL [" + nomUsuarioSCL + "]");
		logger.debug("numCelular [" + numCelular + "]");
		logger.debug("numAbonado [" + numAbonado + "]");
		logger.debug("codCliente [" + codCliente + "]");
		logger.debug("codCuenta [" + codCuenta + "]");
		AuditoriaDTO dto = new AuditoriaDTO();
		dto.setNomUsuarioSCL(nomUsuarioSCL);
		dto.setCodEvento(codEvento);
		dto.setCodCliente(codCliente);
		dto.setCodCuenta(codCuenta);
		dto.setNumAbonado(numAbonado);
		dto.setNumCelular(numCelular);
		RPCServiceClient rpcServiceClient = new RPCServiceClient();
		Options options = rpcServiceClient.getOptions();
		options.setAction("urn:registraAuditoria");
		options.setTimeOutInMilliSeconds(600000);
		EndpointReference targetEPR = new EndpointReference(url);
		options.setTo(targetEPR);
		QName qName = new QName(espacioNombres, "registraAuditoria");
		Object[] argumentos = new Object[] { dto };
		logger.debug("Invoca Servicio Web Auditoria...");
		// Aquí no se solicita valor de retorno
		rpcServiceClient.invokeRobust(qName, argumentos);
		logger.info(MENSAJE_FIN_LOG);
	}

	static final Object invocarMetodoWeb(Object[] argumentos, String metodo, String url, String accion,
			Class tipoRetorno, String espacioNombres) throws AxisFault
	{
		Object[] r = null;
		logger.info(MENSAJE_INICIO_LOG);

		for (int i = 0; i < argumentos.length; i++)
		{
			Object object = argumentos[i];
			logger.debug("Argumento [" + i + "]");

			if (object instanceof CargaCambioDatosClienteDTO)
			{
				logger.debug("nomUsuarioSCL: " + ((CargaCambioDatosClienteDTO) object).getNomUsuarioSCL());
				logger.debug("codCliente: " + ((CargaCambioDatosClienteDTO) object).getCodCliente());
			}
			else if (object instanceof CargaCambioNumFrecuentesDTO)
			{
				logger.debug("nomUsuarioSCL: " + ((CargaCambioNumFrecuentesDTO) object).getNomUsuarioSCL());
				logger.debug("numAbonado: " + ((CargaCambioNumFrecuentesDTO) object).getNumAbonado());
			}
			else if (object instanceof GetDocsClienteINDTO)
			{
				logger.debug("codCliente: " + ((GetDocsClienteINDTO) object).getCodCliente());
				logger.debug("fecInicio: " + ((GetDocsClienteINDTO) object).getFecInicio());
				logger.debug("fecFin: " + ((GetDocsClienteINDTO) object).getFecFin());
			}
			else if (object instanceof EjecucionCambioDatosClienteDTO)
			{
				logger.debug("getNomUsuarioSCL: " + ((EjecucionCambioDatosClienteDTO) object).getNomUsuarioSCL());
				logger.debug("getComentario: " + ((EjecucionCambioDatosClienteDTO) object).getComentario());
				logger.debug("getNumTransaccion(): " + ((EjecucionCambioDatosClienteDTO) object).getNumTransaccion());
			}
			else
			{
				if (object != null)
				{
					logger.debug("Valor: " + object.toString());
				}
				else
				{
					logger.debug("Valor: null");
				}
			}
		}

		logger.debug("metodo [" + metodo + "]");
		logger.debug("url [" + url + "]");
		logger.debug("accion [" + accion + "]");
		logger.debug("tipoRetorno [" + tipoRetorno.getName() + "]");
		logger.debug("espacioNombres [" + espacioNombres + "]");
		RPCServiceClient rpcServiceClient = new RPCServiceClient();
		Options options = rpcServiceClient.getOptions();
		options.setAction(accion);
		options.setTimeOutInMilliSeconds(600000);
		EndpointReference targetEPR = new EndpointReference(url);
		options.setTo(targetEPR);
		QName qName = new QName(espacioNombres, metodo);
		Class[] tiposRetorno = new Class[] { tipoRetorno };
		logger.debug("Invoca Servicio Web...");
		r = rpcServiceClient.invokeBlocking(qName, argumentos, tiposRetorno);
		logger.info(MENSAJE_FIN_LOG);
		return r[0];
	}

	static final Context obtenerContexto() throws NamingException
	{
		logger.info(MENSAJE_INICIO_LOG);
		Environment env = new Environment();
		env.setProviderUrl(URL);
		env.setSecurityPrincipal(SECURITY_PRINCIPAL);
		env.setSecurityCredentials(SECURITY_CREDENTIALS);
		env.setInitialContextFactory(INITIAL_CONTEXT_FACTORY);
		Context ctx = env.getInitialContext();
		logger.info(MENSAJE_FIN_LOG);
		return ctx;
	}

}
