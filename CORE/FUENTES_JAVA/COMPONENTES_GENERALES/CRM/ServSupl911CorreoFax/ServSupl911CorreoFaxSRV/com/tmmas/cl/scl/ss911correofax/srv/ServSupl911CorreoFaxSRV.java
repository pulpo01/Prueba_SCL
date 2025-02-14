package com.tmmas.cl.scl.ss911correofax.srv;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.ss911correofax.bo.ServSupl911CorreoFaxBO;
import com.tmmas.cl.scl.ss911correofax.bo.interfaces.ServSupl911CorreoFaxBOIT;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.RetornoDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;

public class ServSupl911CorreoFaxSRV {

	private final Logger logger = Logger.getLogger(this.getClass());
	private CompositeConfiguration config;
	private static ServSupl911CorreoFaxSRV instance=null;
	private ServSupl911CorreoFaxBOIT servSupl911CorreoFaxBO= new ServSupl911CorreoFaxBO(); 
	
	public static ServSupl911CorreoFaxSRV getInstance(){
		if (instance == null) {
			instance = new ServSupl911CorreoFaxSRV();
		}
		return instance;
	}
	
	public ServSupl911CorreoFaxSRV(){
		config = UtilProperty.getConfiguration("ServSupl911CorreoFax.properties",
				"com/tmmas/cl/scl/ss911correofax/propiedades/ServSupl911CorreoFaxSRV.properties");
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));	
	}
	
	public void insertUpdateDeleteGaContactoAbonadoTO(GaContactoAbonadoToDTO gaContactoAbonadoTO)
		throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		RetornoDTO retValue= null;
	
		try{
			servSupl911CorreoFaxBO.insertUpdateDeleteGaContactoAbonadoTO(gaContactoAbonadoTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			retValue.setNumEvento(e.getCodigo());
			retValue.setDescripcion(e.getDescripcionEvento());
			retValue.setOK(false);
			
			//throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}
	
	public CodigosDTO[] getListCodigos(CodigosDTO entrada) 
		throws GeneralException
	{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		CodigosDTO[] retValue= null;
	
		try{
			retValue = servSupl911CorreoFaxBO.getListCodigos(entrada);
	
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;
	}
	
	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] contactoAbonadoTTs)throws GeneralException {
		
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		
			try{
				servSupl911CorreoFaxBO.deleteInsertPvContactoAbonadoTT(contactoAbonadoTTs);

			} catch (GeneralException e) {
				UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
				logger.debug("GeneralException");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw  e;
			} catch (Exception e) {
				UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
				logger.debug("Exception");
				String log = StackTraceUtl.getStackTrace(e);
				logger.debug("log error[" + log + "]");
				throw new GeneralException(e);
			}		
	}
	
	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT contactoAbonadoTT) throws GeneralException{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		ContactoAbonadoTT[] retValue= null;
	
		try{
			retValue = servSupl911CorreoFaxBO.obtenerListaContactos(contactoAbonadoTT);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retValue;		
		
	}
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		ParametrosGeneralesDTO retorno = null;
	
		try{
			retorno = servSupl911CorreoFaxBO.getParametroGeneral(entrada);
		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			//throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}
		return retorno;		
		
	}
	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	public void setDireccion(DireccionNegocioWebDTO entrada) throws GeneralException {
		
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
	
		try{
			servSupl911CorreoFaxBO.setDireccion(entrada);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	} // setDireccion
	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	public void setGaContTHDelGaContTO_DelDireccion(GaContactoAbonadoTO gaContactoAbonadoTO)throws GeneralException{
		UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
		
		try{
			servSupl911CorreoFaxBO.setGaContTHDelGaContTO_DelDireccion(gaContactoAbonadoTO);

		} catch (GeneralException e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("GeneralException");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw  e;
		} catch (Exception e) {
			UtilLog.setLog(config.getString("ServSupl911CorreoFaxSRV.log"));
			logger.debug("Exception");
			String log = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + log + "]");
			throw new GeneralException(e);
		}		
	}
	
}
