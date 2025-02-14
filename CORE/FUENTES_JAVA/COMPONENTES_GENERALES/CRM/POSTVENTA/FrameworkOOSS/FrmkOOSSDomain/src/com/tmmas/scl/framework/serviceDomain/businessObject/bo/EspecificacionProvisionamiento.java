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
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import java.util.ArrayList;
import java.util.Date;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.PerfilProvisionamientoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.PerfilProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.EspecificacionProvisionamientoDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionProvisionamientoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.AprovisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BajaAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPlanTarifDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.GestorCorpDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.LimiteConsumoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ListaActivaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.MovAtlantidaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.PerfilProvisionamientoDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.SaldoDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionProvisionamiento implements EspecificacionProvisionamientoIT
{
	private final Logger logger = Logger.getLogger(EspecificacionProvisionamiento.class);
	private Global global = Global.getInstance();
	
	private EspecificacionProvisionamientoDAOIT espProvDAO=new EspecificacionProvisionamientoDAO();
	
	private PerfilProvisionamientoBOFactoryIT factoryBO1 = new PerfilProvisionamientoBOFactory();	
	private PerfilProvisionamientoIT perfilProvBO = factoryBO1.getBusinessObject1();
	

	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException 
	{
		EspecProvisionamientoListDTO resultado=new EspecProvisionamientoListDTO();
		logger.debug("Inicio:obtenerEspecificacionesProvisionamiento()");
		resultado = espProvDAO.obtenerEspecificacionesProvisionamiento(espSerCliList);
		logger.debug("Fin:obtenerEspecificacionesProvisionamiento()");
		return resultado;
	}
	
	public RetornoDTO consultaPrepago(ConsultaPrepagosDTO consulta) throws ServiceSpecEntitiesException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("consultaPrepago():start");
			respuesta = espProvDAO.consultaPrepago(consulta);
			logger.debug("consultaPrepago():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return respuesta;			
	}
	
	public RetornoDTO actualizarLimiteConsumo(LimiteConsumoDTO param) throws ServiceSpecEntitiesException {
	RetornoDTO retorno = null;
	try {
		logger.debug("actualizarLimiteConsumo():start");
		retorno = espProvDAO.actualizarLimiteConsumo(param);
		logger.debug("actualizarLimiteConsumo():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return retorno;	
	
	}
	
	public RetornoDTO aprovisionamiento(AprovisionamientoDTO param) throws ServiceSpecEntitiesException {
	RetornoDTO retorno = null;
	try {
		logger.debug("aprovisionamiento():start");
		retorno = espProvDAO.aprovisionamiento(param);
		logger.debug("aprovisionamiento():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return retorno;
	}
	
	public ParametroDTO obtieneAtlantida(ClienteDTO cliente) throws ServiceSpecEntitiesException {
	ParametroDTO parametro = null;
	try {
		logger.debug("obtieneAtlantida():start");
		parametro = espProvDAO.obtieneAtlantida(cliente);
		logger.debug("obtieneAtlantida():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return parametro;
	}
	
	public RetornoDTO registraProrrateo() throws ServiceSpecEntitiesException {
	RetornoDTO retorno = null;
	try {
		logger.debug("registraProrrateo():start");
		retorno = espProvDAO.registraProrrateo();
		logger.debug("registraProrrateo():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return retorno;
	}
	
	public RetornoDTO validaBajaAtlantida(BajaAtlantidaDTO param) throws ServiceSpecEntitiesException {
	RetornoDTO retorno = null;
	try {
		logger.debug("validaBajaAtlantida():start");
		retorno = espProvDAO.validaBajaAtlantida(param);
		logger.debug("validaBajaAtlantida():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return retorno;
	}
	
	public GestorCorpDTO validaGestorCorp(GestorCorpDTO param) throws ServiceSpecEntitiesException {
	GestorCorpDTO retorno = null;
	try {
		logger.debug("validaGestorCorp():start");
		retorno = espProvDAO.validaGestorCorp(param);
		logger.debug("validaGestorCorp():end");
	} catch (ServiceSpecEntitiesException e) {
		logger.debug("ServiceSpecEntitiesException[", e);
		throw e;
	}
	catch (Exception e) {
		logger.debug("Exception[", e);
		throw new ServiceSpecEntitiesException(e);
	}		
	return retorno;
	}

	public SaldoDTO consultaSaldo(SaldoDTO consulta) throws ServiceSpecEntitiesException{
		SaldoDTO respuesta = null;
		try {
			logger.debug("consultaSaldo():start");
			respuesta = espProvDAO.consultaSaldo(consulta);
			logger.debug("consultaSaldo():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return respuesta;
	}
	
	public PlanTarifarioDTO consultaPlanActual(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException{
		PlanTarifarioDTO respuesta = null;
		try {
			logger.debug("consultaPlanActual():start");
			respuesta = espProvDAO.consultaPlanActual(consulta);
			logger.debug("consultaPlanActual():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return respuesta;		
		
	}
	
	public ListaActivaListDTO consultaListaActivas(ConsultaPlanTarifDTO consulta) throws ServiceSpecEntitiesException{
		ListaActivaListDTO respuesta = null;
		try {
			logger.debug("consultaListaActivas():start");
			respuesta = espProvDAO.consultaListaActivas(consulta);
			logger.debug("consultaListaActivas():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return respuesta;			
	}
	
	public RetornoDTO obtenerPlanAtlantida(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("obtenerPlanAtlantida():start");
			respuesta = espProvDAO.obtenerPlanAtlantida(abonado);
			logger.debug("obtenerPlanAtlantida():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return respuesta;	
	}
	
	public RetornoDTO insertaMovAtl(MovAtlantidaDTO mov) throws ServiceSpecEntitiesException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("insertaMovAtl():start");
			respuesta = espProvDAO.insertaMovAtl(mov);
			logger.debug("insertaMovAtl():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}	
		return respuesta;	
	}
	
	public AbonadoDTO obtenerServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerServContrato():start");
			respuesta = espProvDAO.obtenerServContrato(abonado);
			logger.debug("obtenerServContrato():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}	
		return respuesta;		
	}
	
	public RetornoDTO registrarServContrato(AbonadoDTO abonado) throws ServiceSpecEntitiesException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarServContrato():start");
			respuesta = espProvDAO.registrarServContrato(abonado);
			logger.debug("registrarServContrato():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}	
		return respuesta;			
	}

	public RetornoDTO generarMovimiento(ProductoContratadoListDTO listProductoContratado) throws ServiceSpecEntitiesException 
	{
		RetornoDTO respuesta = null;
		try 
		{
			ArrayList listaPerfilProv=new ArrayList();			
			for(int i=0;i<listProductoContratado.getProductosContratadosDTO().length;i++)
			{
				PerfilProvisionamientoDTO perfil=new PerfilProvisionamientoDTO();
				perfil.setCodProdContratado(String.valueOf(listProductoContratado.getProductosContratadosDTO()[i].getIdProdContratado().longValue()));
				perfil.setTipAccion("2");
				perfil.setFechaEjecucion(new Date());
				listaPerfilProv.add(perfil);
			}			
			PerfilProvisionamientoDTO[] dtoList=(PerfilProvisionamientoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaPerfilProv.toArray(), PerfilProvisionamientoDTO.class);
			PerfilProvisionamientoListDTO listPerfProv=new PerfilProvisionamientoListDTO();
			listPerfProv.setPerfilesProvisionamientos(dtoList);	
			
			logger.debug("generarMovimiento():start");
			respuesta = perfilProvBO.informar(listPerfProv);
			logger.debug("generarMovimiento():end");
		} 
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}	
		return respuesta;			
	}
	
	public BodegaListDTO obtenerListaBodegas(ConsultaBodegaDTO param) throws ServiceSpecEntitiesException 
	{
		BodegaListDTO respuesta = null;
		try {
			logger.debug("obtenerListaBodegas():start");
			respuesta = espProvDAO.obtenerListaBodegas(param);
			logger.debug("obtenerListaBodegas():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}	
		return respuesta;			
	}
	

}
