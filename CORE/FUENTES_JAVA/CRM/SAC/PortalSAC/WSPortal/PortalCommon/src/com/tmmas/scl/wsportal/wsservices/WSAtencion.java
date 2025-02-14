/**
 * Copyright © 2009 Telefonica Moviles, Soluciones y Aplicaciones, S.A.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informacion propietaria y confidencial de T-mAs S.A.
 * Usted no debe develar tal informacion y solo debe usarla en concordancia
 * con los terminos de derechos de licencias que sean adquiridos con T-mAs S.A.
 */

package com.tmmas.scl.wsportal.wsservices;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.wsportal.common.dto.AbonadoDTO;
import com.tmmas.scl.wsportal.common.dto.ListaAtencionClienteDTO;
import com.tmmas.scl.wsportal.common.dto.ListadoAbonadosDTO;
import com.tmmas.scl.wsportal.common.dto.ResgistroAtencionDTO;
import com.tmmas.scl.wsportal.common.dto.ResulTransaccionDTO;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsportal.locator.ServiceLocator;
import com.tmmas.scl.wsportal.negocio.ejb.session.LlenadoFacade;

public class WSAtencion
{
	private static final String INICIO_LOG = "Inicio";

	private static final String FIN_LOG = "Fin";

	private static final String CLAVE_CONFIGURACION_LOG = "WSPortalWS.archivo.config.log4j";

	public static final String PROPERTIES_INTERNO = "com/tmmas/scl/wsportal/properties/WSPortalWS.properties";

	public static final String PROPERTIES_EXTERNO = "WSPortalWS.properties";

	private static CompositeConfiguration config = UtilProperty.getConfiguration(PROPERTIES_EXTERNO, PROPERTIES_INTERNO);

	private static final String CONFIGURACION_LOG = config.getString(CLAVE_CONFIGURACION_LOG);

	private static Logger logger = Logger.getLogger(WSLlenado.class);

	private static String COD_ERROR = config.getString("COD.ERR_SAC.3000");

	private static String DES_ERROR = config.getString("DES.ERR_SAC.3000");

	public WSAtencion(){

	}

	private PortalSACException procesarException(java.lang.Exception e) throws PortalSACException{
		PortalSACException pe = e instanceof PortalSACException ? (PortalSACException) e : new PortalSACException(COD_ERROR, DES_ERROR, e);
		return pe;
	}
	
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerDatosAbonado
	 * Return: AbonadoDTO
	 * Descripcion: Obtiene los datos de un abonado
	 * throws: PortalSACException
	 * 
	 */
	
	public AbonadoDTO obtenerDatosAbonado(Long numAbonado) throws PortalSACException{

		AbonadoDTO r = new AbonadoDTO();
		
		try{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (AbonadoDTO) facade.obtenerDatosAbonado(numAbonado);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(FIN_LOG);
		return r;
	}
		
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaAtencion
	 * Return: ListaAtencionClienteDTO
	 * Descripcion: Obtiene las atenciones de los clientes
	 * throws: PortalSACException
	 * 
	 */
	
	public ListaAtencionClienteDTO consultaAtencion() throws PortalSACException{

		ListaAtencionClienteDTO r = new ListaAtencionClienteDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListaAtencionClienteDTO) facade.consultaAtencion();
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(FIN_LOG);
		return r;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: IngresoAtencion
	 * Return: ResulTransaccionDTO
	 * Descripcion: Inserta una gestion de atencion
	 * throws: PortalSACException
	 * 
	 */

	public ResulTransaccionDTO ingresoAtencion(ResgistroAtencionDTO resgistroAtencionDTO) throws PortalSACException{

		ResulTransaccionDTO r = new ResulTransaccionDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ResulTransaccionDTO) facade.ingresoAtencion(resgistroAtencionDTO);
			//logger.debug("codError [" + r.getCodError() + "]");
			//logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			//r.setCodError(pe.getCodigo());
			//r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(FIN_LOG);
		return r;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario 
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: ObtenerListDatosAbonados
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los datos de de los abonados asociados a un cliente
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO obtenerListDatosAbonados(Long codCliente) throws PortalSACException{

		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoAbonadosDTO) facade.obtenerListDatosAbonados(codCliente);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(FIN_LOG);
		return r;
	}
	
	/*
	 * Proyecto: P-MIX-10008 Mejoras al Portal SAC y Evolución Gestor Posventa MIX-10008
	 * Requisito: RSis_010
	 * Caso de uso: CU-017 Registrar consulta de cliente/cuenta/abonado realizado por el usuario
	 * Developer: Gabriel Moraga L.
	 * Fecha: 13/07/2010
	 * Metodo: consultaCuenta
	 * Return: ListadoAbonadosDTO
	 * Descripcion: Obtiene los abonados asociados a una cuenta
	 * throws: PortalSACException
	 * 
	 */
	
	public ListadoAbonadosDTO consultaCuenta(Long codCuenta) throws PortalSACException{

		ListadoAbonadosDTO r = new ListadoAbonadosDTO();
		
		try{
			
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(INICIO_LOG);
			LlenadoFacade facade = ServiceLocator.obtenerFacade();
			
			/*if (tipoDato == 1){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, numDato, null);
			}else if (tipoDato == 2){
				facade.auditar(codEvento, nomUsuarioSCL, null, numDato, null, null);
			}else if (tipoDato == 3){
				facade.auditar(codEvento, nomUsuarioSCL, null, null, null, numDato);
			}*/
			
			r = (ListadoAbonadosDTO) facade.consultaCuenta(codCuenta);
			logger.debug("codError [" + r.getCodError() + "]");
			logger.debug("desError [" + r.getDesError() + "]");
			
		}catch (java.lang.Exception e){
			
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		
		logger.info(FIN_LOG);
		return r;
	}
	
}