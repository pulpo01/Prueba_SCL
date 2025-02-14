/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 16/10/2007	     	  Raúl Lozano        				Versión Inicial
 */
package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;



import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoVetadoBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.AbonadoVetadoDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.AbonadoVetadoDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoVetadoListDTO;


public class AbonadoVetadoBO implements AbonadoVetadoBOIT
{
	private AbonadoVetadoDAOIT abonadoVetadoDAO = new AbonadoVetadoDAO();
	private final Logger logger = Logger.getLogger(Cliente.class);
	private Global global = Global.getInstance();	
	
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO) throws CustomerException{
		AbonadoVetadoListDTO respuesta = null;
		try {
			logger.debug("obtieneAbonadosVetados():start");
			respuesta = abonadoVetadoDAO.obtieneAbonadosVetados(abonadoDTO);
			logger.debug("obtieneAbonadosVetados():end");
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
	
	
}
