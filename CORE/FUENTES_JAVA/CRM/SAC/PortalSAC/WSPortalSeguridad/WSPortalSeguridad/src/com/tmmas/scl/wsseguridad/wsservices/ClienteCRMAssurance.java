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

import org.apache.log4j.Logger;
import org.openuri.www.AbonadoDTO;
import org.openuri.www.OrdenservicioDTO;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.scl.crmassuranceproxy.CRMAssuranceWSSoap;
import com.tmmas.cl.scl.crmassuranceproxy.CRMAssuranceWS_Impl;
import com.tmmas.scl.wsportal.common.exception.PortalSACException;
import com.tmmas.scl.wsseguridad.dto.ConsultarOrdenServicioSACDTO;
import com.tmmas.scl.wsseguridad.dto.DireccionSACDTO;
import com.tmmas.scl.wsseguridad.dto.ListadoDireccionesSACDTO;
import com.tmmas.scl.wsseguridad.dto.ListadoOrdenesServicioSACDTO;
import com.tmmas.scl.wsseguridad.dto.RealizarBloqueoRoboSACINDTO;
import com.tmmas.scl.wsseguridad.dto.RealizarBloqueoRoboSACOUTDTO;

public class ClienteCRMAssurance extends OrquestadorBase
{
	private static Logger logger = Logger.getLogger(ClienteCRMAssurance.class);

	static final String CLAVE_URL_WSDL_CRM_ASSURANCE = "ws.servicios.crm.assurance.wsdl";

	static final String URL_WSDL_CRM_ASSURANCE = config.getString(CLAVE_URL_WSDL_CRM_ASSURANCE);

	static PortalSACException procesarException(Throwable e)
	{
		PortalSACException pe = null;
		if (e instanceof PortalSACException)
		{
			pe = (PortalSACException) e;
		}
		else if (e instanceof java.rmi.RemoteException && e.getCause() != null)
		{
			pe = new PortalSACException(config.getString("COD.ERR_SAC.4005"), config.getString("DES.ERR_SAC.4005")
					+ ": " + e.getCause().getMessage(), e);
		}
		else
		{
			pe = new PortalSACException(config.getString("COD.ERR_SAC.4001"), config.getString("DES.ERR_SAC.4001"), e);
		}
		return pe;
	}

	public ListadoOrdenesServicioSACDTO cambiarDireccionesCliente(ListadoDireccionesSACDTO dto)
			throws PortalSACException
	{
		ListadoOrdenesServicioSACDTO r = new ListadoOrdenesServicioSACDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			if (dto.getArrayDirecciones() != null && dto.getArrayDirecciones().length > 0)
			{
				final int numDirecciones = dto.getArrayDirecciones().length;
				ConsultarOrdenServicioSACDTO[] ooss = new ConsultarOrdenServicioSACDTO[numDirecciones];

				DireccionSACDTO[] array = dto.getArrayDirecciones();
				CRMAssuranceWS_Impl t = new CRMAssuranceWS_Impl(URL_WSDL_CRM_ASSURANCE);
				CRMAssuranceWSSoap s = t.getCRMAssuranceWSSoap();
				for (int i = 0; i < array.length; i++)
				{
					ooss[i] = new ConsultarOrdenServicioSACDTO();
					try
					{
						DireccionSACDTO d = array[i];
						logger.debug("Entrada [" + i + "]: " + d.toString());
						logger.debug("Ejecuta método cambiarDireccionCliente [" + i + "]...");
						OrdenservicioDTO os = s.cambiarDireccionCliente(d.getCodCliente(), d.getIdTipoDireccion(), d
								.getNombreCalle(), d.getNumeroCalle(), d.getNumeroPiso(), d.getIdRegion(), d
								.getIdProvincia(), d.getIdCiudad(), d.getIdComuna(), d.getCodigoPostal(), d
								.getObservacion(), d.getDescripcionDireccion1(), d.getDescripcionDireccion2());
						logger.debug("Nro. OS [" + i + "]: " + os.getOo_Ss());
						ooss[i].setNroOOSS(os.getOo_Ss());
					}
					catch (Throwable e)
					{
						PortalSACException pe = procesarException(e);
						logger.error(pe.stackTraceToString());
						ooss[i].setCodError(pe.getCodigo());
						ooss[i].setDesError(pe.getMessage());
					}
					
					//Se agrega un delay de un segundo con 2 milesimas de segundo para evitar error al insertar multiples direcciones
					Thread.sleep(1200);
					
				}
				r.setArrayOOSS(ooss);
			}
			else
			{
				r.setCodError(config.getString("COD.ERR_SAC.4004"));
				r.setDesError(config.getString("DES.ERR_SAC.4004"));
			}
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public ConsultarOrdenServicioSACDTO cambiarDireccionCliente(DireccionSACDTO dto) throws PortalSACException
	{
		ConsultarOrdenServicioSACDTO r = new ConsultarOrdenServicioSACDTO();
		OrdenservicioDTO os = null;
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			logger.debug("entrada: " + dto.toString());
			logger.debug("URL WSDL: " + URL_WSDL_CRM_ASSURANCE);
			CRMAssuranceWS_Impl t = new CRMAssuranceWS_Impl(URL_WSDL_CRM_ASSURANCE);
			CRMAssuranceWSSoap s = t.getCRMAssuranceWSSoap();
			logger.debug("Ejecuta método cambiarDireccionCliente...");
			os = s.cambiarDireccionCliente(dto.getCodCliente(), dto.getIdTipoDireccion(), dto.getNombreCalle(), dto
					.getNumeroCalle(), dto.getNumeroPiso(), dto.getIdRegion(), dto.getIdProvincia(), dto.getIdCiudad(),
					dto.getIdComuna(), dto.getCodigoPostal(), dto.getObservacion(), dto.getDescripcionDireccion1(), dto
							.getDescripcionDireccion2());
			logger.debug("Nro. OS.: " + os.getOo_Ss());
			r.setNroOOSS(os.getOo_Ss());
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}

	public RealizarBloqueoRoboSACOUTDTO realizarBloqueoRobo(RealizarBloqueoRoboSACINDTO inDTO) throws PortalSACException
	{
		AbonadoDTO outDTO = null;
		RealizarBloqueoRoboSACOUTDTO r = new RealizarBloqueoRoboSACOUTDTO();
		try
		{
			UtilLog.setLog(CONFIGURACION_LOG);
			logger.info(MENSAJE_INICIO_LOG);
			logger.debug("URL WSDL: " + URL_WSDL_CRM_ASSURANCE);
			CRMAssuranceWS_Impl t = new CRMAssuranceWS_Impl(URL_WSDL_CRM_ASSURANCE);
			CRMAssuranceWSSoap s = t.getCRMAssuranceWSSoap();
			
			logger.debug("Datos de entrada...");
			logger.debug("inDTO.getNumCelular(): " + inDTO.getNumCelular());
			logger.debug("inDTO.getTipoSiniestro(): " + inDTO.getTipoSiniestro());
			logger.debug("inDTO.getTipoSusp(): " + inDTO.getTipoSusp());
			logger.debug("inDTO.getCausaSiniestro(): " + inDTO.getCausaSiniestro());
			logger.debug("inDTO.getUsuario(): " + inDTO.getUsuario());
			
			logger.debug("Ejecuta método realizarBloqueoRobo...");

			outDTO = s.realizarBloqueoRobo(inDTO.getNumCelular(), inDTO.getTipoSiniestro(), inDTO.getTipoSusp(), inDTO
					.getCausaSiniestro(), inDTO.getUsuario());
			
			r.setNumCelular(outDTO.getNumCelular());
			r.setTipoSiniestro(outDTO.getTipoSiniestro());
			r.setCausaSiniestro(outDTO.getCausaSiniestro());
			r.setUsuario(outDTO.getUsuario());
			r.setNumSolEqu(outDTO.getNumSolEqu());
			r.setNumSolSim(outDTO.getNumSolSim());
			r.setTipoSusp(outDTO.getTipoSusp());

			logger.debug("Datos de salida...");
			logger.debug("r.getTipoSiniestro(): " + r.getTipoSiniestro());
			logger.debug("r.getNumCelular(): " + r.getNumCelular());
			logger.debug("r.getCausaSiniestro(): " + r.getCausaSiniestro());
			logger.debug("r.getUsuario(): " + r.getUsuario());
			logger.debug("r.getTipoSusp(): " + r.getTipoSusp());
			logger.debug("r.getNumSolEqu(): " + r.getNumSolEqu());
			logger.debug("r.getNumSolEqu(): " + r.getNumSolSim());
			
		}
		catch (Throwable e)
		{
			PortalSACException pe = procesarException(e);
			logger.error(pe.stackTraceToString());
			r.setCodError(pe.getCodigo());
			r.setDesError(pe.getMessage());
			return r;
		}
		logger.info(MENSAJE_FIN_LOG);
		return r;
	}
}