package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingInDTO;
import com.tmmas.cl.scl.gestiondeabonados.businessobject.dto.RoamingOUTDTO;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.TasacionDAO;

public class TasacionBO {
	private TasacionDAO tasacionDAO  = new TasacionDAO();
	private Logger  logger= Logger.getLogger(RegistroFacturacionBO.class);
	
	public RoamingOUTDTO getDetalleUltimaLlamadasRomingTOL(RoamingInDTO rommingDTO) throws GeneralException{
		RoamingOUTDTO retValue=null;
		try{
			logger.debug("Inicio:getDetalleUltimaLlamadasRomingTOL()");
			retValue=tasacionDAO.getDetalleUltimaLlamadasRomingTOL(rommingDTO);
			logger.debug("Fin:getDetalleUltimaLlamadasRomingTOL()");
		}catch(GeneralException e){
			logger.debug("Error: General Exception");
			throw(e);
		}
		return retValue;
	}
}
