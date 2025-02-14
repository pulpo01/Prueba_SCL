package com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao.PagoDAO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.PagoDTO;

public class PagoBO {
	
	PagoDAO pagoDAO = new PagoDAO();
	private static Category cat = Category.getInstance(ClienteBO.class);
	
	public PagoDTO AplicaPago (PagoDTO pagoDTO) throws GeneralException {
		PagoDTO pagoDTO2 = new PagoDTO();
		cat.debug("Inicio:AplicaPago()");		
		pagoDTO = pagoDAO.getEmpRecaudadora(pagoDTO);		
		pagoDTO2 = pagoDAO.AplicaPago(pagoDTO);
		cat.debug("Fin:AplicaPago()");
		return pagoDTO2;
	}

}
