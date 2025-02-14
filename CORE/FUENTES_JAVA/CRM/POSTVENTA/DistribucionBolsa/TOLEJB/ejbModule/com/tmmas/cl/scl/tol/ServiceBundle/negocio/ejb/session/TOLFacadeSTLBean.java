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
 * 10/08/2006     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.cl.scl.tol.ServiceBundle.negocio.ejb.session;

import java.rmi.RemoteException;
import javax.jms.QueueSession;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.util.MessagePublisher;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework.util.ejb.SessionBase;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ParametroProcesoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.TOLException;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.cmd.DistribucionBolsaQueueCMD;
import com.tmmas.cl.scl.tol.ServiceBundle.negocio.util.Global;
import com.tmmas.cl.scl.tol.ServiceBundle.service.servicios.LogicalServiceSrv;
import com.tmmas.cl.scl.tol.ServiceBundle.service.servicios.ProcesoAsincronoSrv;



public class TOLFacadeSTLBean extends SessionBase 
{
	private LogicalServiceSrv TOLService = new LogicalServiceSrv();
	private static final long serialVersionUID = 1L;
    private ProcesoAsincronoSrv procesoAsincronoBO = new ProcesoAsincronoSrv();
	private final Category cat = Category.getInstance(TOLFacadeSTLBean.class);
	Global global = Global.getInstance();
		
	
	public void setFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException 
	{
		String sNombreMethodo = new String("setFreeUnitStock");
		cat.info("setFreeUnitStock():start");
		
		try 
		{
			TOLService.setFreeUnitStock(dto);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio setFreeUnitStock",	e);
		}
	
		cat.info("setFreeUnitStock():end");
	}	
		
	public void setServiceBundle(ProductListDTO list) throws TOLException, RemoteException 
	{
		String sNombreMethodo = new String("setServiceBundle");
		
		cat.info(sNombreMethodo+"():start");
		String sServicio = new String("installServiceBundle");
		try 
		{
			list.setAciclo(false);
			TOLService.installServiceBundle(list);
			sServicio = "uninstallServiceBundle";
			TOLService.uninstallServiceBundle(list);
			
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio " + sServicio,	e);
		}
	
		cat.info(sNombreMethodo+"():end");
	}
				
	/*servicio llamado desde el WS*/
	public void installServiceBundle(ProductListDTO list) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("installServiceBundle");
		
		cat.info(sNombreMethodo+"():start");
		try 
		{
			TOLService.installServiceBundle(list);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio " + sNombreMethodo,	e);
		}
	
		cat.info(sNombreMethodo+"():end");
	}
	
	
	
	/*servicio llamado desde el WS*/
	public void uninstallServiceBundle(ProductListDTO list) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("uninstallServiceBundle");
		
		cat.info(sNombreMethodo+"():start");
		try 
		{
			TOLService.uninstallServiceBundle(list);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio " + sNombreMethodo,	e);
		}
	
		cat.info(sNombreMethodo+"():end");
	}
			
	
	/*Segundo caso*/
	public void createStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("createStorageAndUnitStock");
		
		cat.info(sNombreMethodo+"():star");
		try
		{
			TOLService.createStorageAndFreeUnitStock(dto);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio createStorageAndUnitStock",	e);
		}
		cat.info(sNombreMethodo+"():end");
	}
	
	public void createStorageAndFreeUnitStockjms(DistribucionBolsaDTO dto) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("createStorageAndFreeUnitStockjms:");
		ParametroProcesoDTO parametro = new ParametroProcesoDTO();
		
		cat.info(sNombreMethodo+"star");
		cat.debug(sNombreMethodo+"Genero dto para registrar proceso!!");
			
		parametro.setParametro(dto);
		cat.info(sNombreMethodo+"star1");
		parametro.setGlosa_proceso (global.getCreateStorageAndFreeUnitStockCode());
		cat.info(sNombreMethodo+"star2");
		parametro.setObservacion ("Proceso [" + global.getCreateStorageAndFreeUnitStockCode() + "] inscrito, con los siguientes datos : cliente = " + dto.getCod_cliente() + ",cod_bolsa = " + dto.getCod_bolsa() + ", cod_plan = " + dto.getCod_plan()+ ", ind_unidad = " + dto.getInd_unidad() );
		cat.info(sNombreMethodo+"star3");

		parametro = inscribeProceso(parametro);
			
		try
		{
			cat.debug(sNombreMethodo+"Antes de generar mensaje");
			cat.debug(sNombreMethodo+"Genero objeto DistribucionBolsaQueueCMD");
			DistribucionBolsaQueueCMD generaQuueeCmd = new DistribucionBolsaQueueCMD(parametro);
				
			cat.debug(sNombreMethodo+"Genero objeto MessagePuSerializableblisher -> Factory :" +global.getJndiFactory()+ " Queue :" + global.getJndiQueueCreateStorageAndFreeUnitStock());
			MessagePublisher messagePublisher = new MessagePublisher(global.getJndiFactory(), global.getJndiQueueCreateStorageAndFreeUnitStock());
				
			cat.debug(sNombreMethodo+"Envio mensaje");
			messagePublisher.sendObjectToQueue(false,QueueSession.AUTO_ACKNOWLEDGE, generaQuueeCmd);
			cat.debug(sNombreMethodo+"Mensaje fue generado satisfactoriamente");
		}
		catch(Exception e)
		{
			cat.debug(sNombreMethodo+"Error al crear menasje, se procede a modificar estado del proceso a error", e);
			parametro.setEstado(4);
			parametro.setObservacion("Error en la inscripción");
			parametro.setError_tecnico(e.getMessage());
			actualizaProceso(parametro);
		}
	
		cat.info(sNombreMethodo+"():end");
	}	

	
	public void deleteStorageAndFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("deleteStorageAndFreeUnitStock");
		
		cat.info(sNombreMethodo+"():star");
		
		try
		{
			TOLService.deleteStorageAndFreeUnitStock(dto);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio deleteStorageAndFreeUnitStock",	e);
		}
		cat.info(sNombreMethodo+"():end");
	}
	
	
	public void deleteFreeUnitStock(DistribucionBolsaDTO dto) throws TOLException, RemoteException
	{
		String sNombreMethodo = new String("deleteFreeUnitStock");
		
		cat.info(sNombreMethodo+"():star");
		
		try
		{
			TOLService.deleteFreeUnitStock(dto);
		} 
		catch (TOLException e) {
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [TOLException e]", e);
			throw e;
		} 
		catch (Exception e) 
		{
			context.setRollbackOnly();
			cat.debug(sNombreMethodo+"():Error [Exception e]", e);
			throw new TOLException(	"Error al ejecutar la el servicio deleteFreeUnitStock",	e);
		}
		cat.info(sNombreMethodo+"():end");	
	}
	
	/**
	 * Obtiene la lista de perfiles dado un servicio suplementario
	 * @param prod
	 * @return
	 * @throws CustomerOrderException
	 */	
	public LimiteConsumoDTO[] getServiceLimitProfiles(ProductDTO prod) throws TOLException, RemoteException {
		cat.debug("getServiceLimitProfiles():start");
		LimiteConsumoDTO[] resultado;
		try {
			resultado = TOLService.getServiceLimitProfiles(prod);
		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new TOLException(e);
		}		
		cat.debug("getServiceLimitProfiles():end");
		return resultado;
	}	
	
	public BolsaAbonadoDTO[] getFreeUnitStock(CustomerAccountDTO dto) 
			throws TOLException, RemoteException{
		cat.debug("getFreeUnitStock():start");
		BolsaAbonadoDTO[] resultado;
		try {
			resultado = TOLService.getFreeUnitStock(dto);
		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new TOLException(e);
		}		
		cat.debug("getFreeUnitStock():end");
		return resultado;
	}	

	/**
	 * Actualiza los atributos de los servicios suplementarios, luego elimina
	 * los limites de consumo en Tol y despues los crea
	 * 
	 * @param dto
	 * @return
	 * @throws TOLException
	 */
	public void setServiceBundleAttributes(ProductListDTO prodList) throws TOLException, RemoteException{
		cat.debug("setServiceBundleAttributes():start");
		try {
			prodList.setAciclo(true);					
			TOLService.setServiceBundleAttributes(prodList);
		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new TOLException(e);
		}		
		cat.debug("setServiceBundleAttributes():end");
	}
	
	public void validServiceBundleAttributes(ProductListDTO prodList) throws TOLException, RemoteException{
		cat.debug("validServiceBundleAttributes():start");
		try {
			prodList.setAciclo(true);					
			TOLService.validServiceBundleAttributes(prodList);
		}
		catch (Exception e) {
			cat.debug("Exception", e);
			throw new TOLException(e);
		}		
		cat.debug("validServiceBundleAttributes():end");
	}
	
	
	public CustomerAccountDTO getFreeUnitBagId(CustomerAccountDTO dto) throws TOLException, RemoteException{
		cat.debug("getFreeUnitBagId():start");
		CustomerAccountDTO cus;
		try {
			cus = TOLService.getFreeUnitBagId(dto);
		} catch (TOLException e) {
			cat.debug("TOLException");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			cat.debug("log error[" + log + "]");
			throw new TOLException(e);
		}		
		cat.debug("getFreeUnitBagId():end");
		return cus;
	}
	
	
	
	public LimiteClienteDTO getServiceLimitProfileValue(LimiteClienteDTO dto) throws TOLException,  RemoteException
	{
		cat.debug("getServiceLimitProfileValue():start");
		LimiteClienteDTO respuesta;
		try {
			respuesta = TOLService.getServiceLimitProfileValue(dto);
		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception", e);
			throw new TOLException(e);
		}
		cat.debug("getServiceLimitProfileValue():end");
		return respuesta;
	}
	
	/**
	 * Obtiene los limites de consumo dado un codigo de plan
	 * @param prodList
	 * @return
	 * @throws TOLException
	 */
	public ProductListDTO getDefaultServiceLimitProfile(ProductListDTO prodList) throws TOLException, RemoteException
	{
		cat.info("getDefaultServiceLimitProfile:start");
		ProductListDTO respuesta;
		try {
			respuesta = TOLService.getDefaultServiceLimitProfile(prodList);
		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception", e);
			throw new TOLException(e);
		}
		cat.info("getDefaultServiceLimitProfile:end");
		return respuesta;
	}
	
	public void setServiceLimitTemporally(LimiteClienteDTO dto) throws TOLException, RemoteException
	{
		cat.info("setServiceLimitTemporally:star");
		try
		{
			TOLService.setServiceLimitTemporally(dto);
		} catch (TOLException e) {
			cat.debug("TOLException", e);
			throw e;
		}
		catch (Exception e) {
			cat.debug("Exception", e);
			throw new TOLException(e);
		}
		cat.info("setServiceLimitTemporally:end");
	}
	
	public ParametroProcesoDTO inscribeProceso(ParametroProcesoDTO dto) throws TOLException, RemoteException
	{
		ParametroProcesoDTO respuesta;
		cat.debug("inscribeProceso tar");
		respuesta = procesoAsincronoBO.inscribeProceso(dto);
		cat.debug("inscribeProceso:end");
		return respuesta;
		
	}
	
	public ParametroProcesoDTO actualizaProceso(ParametroProcesoDTO dto) throws TOLException, RemoteException
	{
		ParametroProcesoDTO respuesta;
		cat.debug("actualizaProceso tar");
		respuesta = procesoAsincronoBO.actualizaProceso(dto);
		cat.debug("actualizaProceso:end");
		return respuesta;
		
	}	

	
}
