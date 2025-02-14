package com.tmmas.cl.scl.ss911correofax.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ss911correofax.bo.helper.Global;
import com.tmmas.cl.scl.ss911correofax.bo.interfaces.ServSupl911CorreoFaxBOIT;
import com.tmmas.cl.scl.ss911correofax.dao.ServSupl911CorreoFaxDAO;
import com.tmmas.cl.scl.ss911correofax.dao.interfaces.ServSupl911CorreoFaxDAOIT;
import com.tmmas.cl.scl.ss911correofax.dto.CodigosDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ContactoAbonadoTT;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoTO;
import com.tmmas.cl.scl.ss911correofax.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.ss911correofax.dto.ParametrosGeneralesDTO;
import com.tmmas.cl.scl.ss911correofax.dto.DireccionNegocioWebDTO;

public class ServSupl911CorreoFaxBO implements ServSupl911CorreoFaxBOIT{
	protected final Logger logger = Logger.getLogger(this.getClass());
	protected Global global = Global.getInstance();
	protected ServSupl911CorreoFaxDAOIT servSupl911CorreoFaxDAO = new ServSupl911CorreoFaxDAO();
	
	public void insertUpdateDeleteGaContactoAbonadoTO(GaContactoAbonadoToDTO gaContactoAbonadoTO) 
		throws GeneralException 
	{
		logger.info("BO.::insertUpdateDeleteGaContactoAbonadoTO::.Inicio");
		try{
			logger.info("BO.::Begin Servicio::.");
			servSupl911CorreoFaxDAO.insertGaContactoAbonadoTO(gaContactoAbonadoTO);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::insertUpdateDeleteGaContactoAbonadoTO::.Fin");		
	}
	
	
	public CodigosDTO[] getListCodigos(CodigosDTO entrada) 
		throws GeneralException 
	{
		logger.info("BO.::getParentescos::.Inicio");
		CodigosDTO[] retValue= null;
		try{
			logger.info("BO.::Begin Servicio::.");
			retValue = servSupl911CorreoFaxDAO.getListCodigos(entrada);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::getParentescos::.Fin");
		return retValue;
	}


	public ContactoAbonadoTT[] obtenerListaContactos(ContactoAbonadoTT contactoAbonadoTTs) throws GeneralException {
		logger.info("BO.::obtenerListaContactos::.Inicio");
		ContactoAbonadoTT[] retValue= null;
		try{
			logger.info("BO.::Begin Servicio::.");
			retValue = servSupl911CorreoFaxDAO.obtenerListaContactos(contactoAbonadoTTs);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::obtenerListaContactos::.Fin");
		return retValue;
	}


	public void deleteInsertPvContactoAbonadoTT(ContactoAbonadoTT[] contactoAbonadoTTs) throws GeneralException {
		logger.info("BO.::deleteInsertPvContactoAbonadoTT::.Inicio");
		try{
			logger.info("BO.::Begin Servicio::.");
			servSupl911CorreoFaxDAO.deleteInsertPvContactoAbonadoTT(contactoAbonadoTTs);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::deleteInsertPvContactoAbonadoTT::.Fin");	
		
	}

	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO entrada) throws GeneralException {

		logger.info("BO.::getParametroGeneral::.Inicio");
		ParametrosGeneralesDTO retValue= null;
		try{
			logger.info("BO.::Begin Servicio::.");
			retValue= servSupl911CorreoFaxDAO.getParametroGeneral(entrada);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::getParametroGeneral::.Fin");	
		return retValue;
		
	}

	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	public void setDireccion(DireccionNegocioWebDTO entrada) throws GeneralException	{
		
		logger.info("BO.::setDireccion::.Inicio");
		try{
			logger.info("BO.::Begin Servicio::.");
			servSupl911CorreoFaxDAO.setDireccion(entrada);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::setDireccion::.Fin");
		
	} // setDireccion
	
	// ---------------------------------------------------------------------------------------------------------------------------------------
	
	public void setGaContTHDelGaContTO_DelDireccion(GaContactoAbonadoTO gaContactoAbonadoTO)throws GeneralException
	{
		logger.info("BO.::setGaContTHDelGaContTO_DelDireccion::.Inicio");
		try{
			logger.info("BO.::Begin Servicio::.");
			servSupl911CorreoFaxDAO.setGaContTHDelGaContTO_DelDireccion(gaContactoAbonadoTO);
			logger.info("BO.::End Servicio::.");
		}
		catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		logger.info("BO.::setGaContTHDelGaContTO_DelDireccion::.Fin");
		
	}
}
