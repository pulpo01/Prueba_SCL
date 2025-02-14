/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/10/2007	     	  Raúl Lozano        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoBeneficiarioBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.AbonadoBeneficiarioDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.AbonadoBeneficiarioDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;


public class AbonadoBeneficiarioBO implements AbonadoBeneficiarioBOIT
{
	private AbonadoBeneficiarioDAOIT abonadoBeneficiarioDAO = new AbonadoBeneficiarioDAO();
	private final Logger logger = Logger.getLogger(Cliente.class);
	private Global global = Global.getInstance();	
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiarios(AbonadoDTO abonadoDTO) throws CustomerException{
		AbonadoBeneficiarioListDTO respuesta = null;
		try {
			logger.debug("obtieneAbonadosBeneficiarios():start");
			respuesta = abonadoBeneficiarioDAO.obtieneAbonadosBeneficiarios(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiarios():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;	
	}
	
	public AbonadoBeneficiarioListDTO obtieneAbonadosBeneficiariosPorNumCelular(AbonadoDTO abonadoDTO) throws CustomerException {
		AbonadoBeneficiarioListDTO respuesta = null;
		try {
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
			respuesta = abonadoBeneficiarioDAO.obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);
			logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return respuesta;	
	}
	
	public RetornoDTO insertAbonadosBeneficiarios(AbonadoBeneficiarioListDTO abonadoBeneficiarioListDTO) throws CustomerException{
		RetornoDTO retValue = null;
		try {
			logger.debug("oinsertAbonadosBeneficiarios():start");
			retValue = abonadoBeneficiarioDAO.insertAbonadosBeneficiarios(abonadoBeneficiarioListDTO);
			logger.debug("insertAbonadosBeneficiarios():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retValue;
		
	}
	
	public RetornoDTO deleteAbonadoBeneficiario(AbonadoBeneficiarioDTO abonadoBeneficiarioDTO) throws CustomerException {
		RetornoDTO retValue = null;
		try {
			logger.debug("deleteAbonadoBeneficiario():start");
			retValue = abonadoBeneficiarioDAO.deleteAbonadoBeneficiario(abonadoBeneficiarioDTO);
			logger.debug("deleteAbonadoBeneficiario():end");
		} catch (CustomerException e) {
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retValue;
	}

	public RetornoDTO caducaEliminaAbonadoBeneficiario(AbonadoBeneficiarioListDTO abonadoBeneficiarioList) throws CustomerException 
	{
		RetornoDTO retValue = new RetornoDTO();
		try 
		{
			logger.debug("caducaEliminaAbonadoBeneficiario():start");
			for(int i=0;i<abonadoBeneficiarioList.getAbonadoBeneficiarioList().length;i++)
			{
				if(abonadoBeneficiarioList.getAbonadoBeneficiarioList()[i].getEjecutarBenef()>0)
					abonadoBeneficiarioDAO.eliminaAbonadoBeneficiario(abonadoBeneficiarioList.getAbonadoBeneficiarioList()[i]);
				if(abonadoBeneficiarioList.getAbonadoBeneficiarioList()[i].getEjecutarBenef()>1)				
					abonadoBeneficiarioDAO.caducaAbonadoBeneficiario(abonadoBeneficiarioList.getAbonadoBeneficiarioList()[i]);
			}			
			logger.debug("caducaEliminaAbonadoBeneficiario():end");
		}
		catch (CustomerException e) 
		{
			logger.debug("CustomerException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}		
		return retValue;
	}	
}
