package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CiclosFacturacionIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.CiclosFacturacionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.CiclosFacturacionDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.FinCicloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;

public class CiclosFacturacion implements CiclosFacturacionIT {

	private CiclosFacturacionDAOIT ciclosDAO = new CiclosFacturacionDAO();
	
	private final Logger logger = Logger.getLogger(CiclosFacturacion.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO eliminaFinCiclo(FinCicloDTO finCiclo)
			throws CustomerBillException {
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminaFinCiclo():start");
			retorno = ciclosDAO.eliminaFinCiclo(finCiclo);
			logger.debug("eliminaFinCiclo():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return retorno;	
	}

	public CicloDTO obtenerFechaCiclo(CicloDTO ciclo) throws CustomerBillException{
		CicloDTO respuesta = null;
		try {
			logger.debug("obtenerFechaCiclo():start");
			respuesta = ciclosDAO.obtenerFechaCiclo(ciclo);
			logger.debug("obtenerFechaCiclo():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return respuesta;			
	}
	
	public RetornoDTO validarPeriodoFact(AbonadoDTO abonado) throws CustomerBillException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarPeriodoFact():start");
			respuesta = ciclosDAO.validarPeriodoFact(abonado);
			logger.debug("validarPeriodoFact():end");
		} catch (CustomerBillException e) {
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerBillException(e);
		}		
		return respuesta;	
	}
}
