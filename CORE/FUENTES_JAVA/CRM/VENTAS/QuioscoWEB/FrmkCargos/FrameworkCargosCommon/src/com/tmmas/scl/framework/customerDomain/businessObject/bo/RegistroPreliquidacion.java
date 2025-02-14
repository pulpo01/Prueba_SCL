package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroPreLiquidacionIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroDetPreliquidacionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroPreliquidacionDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroPreLiquidacionDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroDetPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;




public class RegistroPreliquidacion implements RegistroPreLiquidacionIT{
	private RegistroPreLiquidacionDAOIT registroPreliquidacionDAO=new RegistroPreliquidacionDAO();
	RegistroDetPreliquidacionDAO registroDetPreliquidacionDAO = new RegistroDetPreliquidacionDAO();
	
	private final Logger logger = Logger.getLogger(RegistroPreliquidacion.class);
	
	/**
	 * Registra Preliquidacion 
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerBillException {
		
		logger.debug("registraPreliquidacion():start");
		registroPreliquidacionDAO.registraMaestroPreliquidacion(preliquidacion);
		logger.debug("registraPreliquidacion():end");
	}

	/**
	 * Registra Detalle de Preliquidacion 
	 * @param detpreliquidacion,cabpreliquidacion
	 * @return 
	 * @throws CustomerBillException
	 */
	public void registraDetallePreliquidacion (RegistroDetPreliquidacionDTO detpreliquidacion,RegistroPreliquidacionDTO cabpreliquidacion) throws CustomerBillException {
		logger.debug("registraDetallePreliquidacion():start");
		registroDetPreliquidacionDAO.registraDetallePreliquidacion(detpreliquidacion,cabpreliquidacion);
		logger.debug("registraDetallePreliquidacion():end");
	}

	/**
	 * Obtiene mercaderia(Terminales y Simcards en consignacion)
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerBillException
	 */
	public ArrayList getMercaderiaEnConsignacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerBillException {
		logger.debug("getMercaderiaEnConsignacion():start");
		ArrayList resultado;
		resultado = registroDetPreliquidacionDAO.getMercaderiaEnConsignacion(preliquidacion);
		logger.debug("getMercaderiaEnConsignacion():end");
		return resultado;
	}

	/**
	 * Actualiza el maestro de preliquidacion
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerBillException
	 */
	
	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException{
		logger.debug("actualizaMaestroPreliquidacion():start");
		registroPreliquidacionDAO.actualizaMaestroPreliquidacion(preliquidacion);
		logger.debug("actualizaMaestroPreliquidacion():end");
	}
	
	
}
