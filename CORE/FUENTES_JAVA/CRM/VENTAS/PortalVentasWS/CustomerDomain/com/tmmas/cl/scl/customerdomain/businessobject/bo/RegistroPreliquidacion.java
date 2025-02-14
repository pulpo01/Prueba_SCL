package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import java.util.ArrayList;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroDetPreliquidacionDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.RegistroPreliquidacionDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroDetPreliquidacionDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.RegistroPreliquidacionDTO;

public class RegistroPreliquidacion {
	RegistroPreliquidacionDAO registroPreliquidacionDAO = new RegistroPreliquidacionDAO();
	RegistroDetPreliquidacionDAO registroDetPreliquidacionDAO = new RegistroDetPreliquidacionDAO();
	
	private static Category cat = Category.getInstance(RegistroPreliquidacion.class);
	
	/**
	 * Registra Preliquidacion 
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerDomainException {
		
		cat.debug("registraPreliquidacion():start");
		registroPreliquidacionDAO.registraMaestroPreliquidacion(preliquidacion);
		cat.debug("registraPreliquidacion():end");
	}

	/**
	 * Registra Detalle de Preliquidacion 
	 * @param detpreliquidacion,cabpreliquidacion
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraDetallePreliquidacion (RegistroDetPreliquidacionDTO detpreliquidacion,RegistroPreliquidacionDTO cabpreliquidacion) throws CustomerDomainException {
		cat.debug("registraDetallePreliquidacion():start");
		registroDetPreliquidacionDAO.registraDetallePreliquidacion(detpreliquidacion,cabpreliquidacion);
		cat.debug("registraDetallePreliquidacion():end");
	}

	/**
	 * Obtiene mercaderia(Terminales y Simcards en consignacion)
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerDomainException
	 */
	public ArrayList getMercaderiaEnConsignacion(RegistroPreliquidacionDTO preliquidacion) throws CustomerDomainException {
		cat.debug("getMercaderiaEnConsignacion():start");
		ArrayList resultado;
		resultado = registroDetPreliquidacionDAO.getMercaderiaEnConsignacion(preliquidacion);
		cat.debug("getMercaderiaEnConsignacion():end");
		return resultado;
	}

	/**
	 * Actualiza el maestro de preliquidacion
	 * @param preliquidacion
	 * @return 
	 * @throws CustomerDomainException
	 */
	
	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerDomainException{
		cat.debug("actualizaMaestroPreliquidacion():start");
		registroPreliquidacionDAO.actualizaMaestroPreliquidacion(preliquidacion);
		cat.debug("actualizaMaestroPreliquidacion():end");
	}
	
	
}
