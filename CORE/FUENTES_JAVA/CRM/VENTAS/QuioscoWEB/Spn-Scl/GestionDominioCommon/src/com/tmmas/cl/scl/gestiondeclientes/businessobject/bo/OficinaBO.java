package com.tmmas.cl.scl.gestiondeclientes.businessobject.bo;


import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientes.businessobject.dao.OficinaDAO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.OficinaDTO;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.VendedorDTO;

public class OficinaBO {
	private OficinaDAO oficinaDAO = new OficinaDAO();
	private final Logger logger = Logger.getLogger(OficinaBO.class);
	

	/**
	 * Obtiene oficinas SCL 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public OficinaDTO[] getListOficinasSCL() throws GeneralException{
		logger.debug("Inicio:getListOficinasSCL()");
		OficinaDTO[] resultado = oficinaDAO.getListOficinasSCL();
		logger.debug("Fin:getListOficinasSCL()");
		return resultado;
	}//fin getListOficinasSCL
	
	/**
	 * @author Héctor Hermosilla
	 * 
	 * Obtiene datos de la oficina
	 * @param oficinaDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OficinaDTO getOficina(OficinaDTO oficinaDTO) throws GeneralException{
		logger.debug("Inicio:getOficina()");
		OficinaDTO resultado = oficinaDAO.getOficina(oficinaDTO);
		logger.debug("Fin:getOficina()");
		return resultado;
	}
	
	
	/**
	 * @author Héctor Hermosilla
	 * 
	 * Obtiene datos de la oficina
	 * @param oficinaDTO
	 * @return resultado
	 * @throws GeneralException
	 */	
	public OficinaDTO[] getOficinasPorVendedor(VendedorDTO vendedorDTO) throws GeneralException{
		OficinaDTO[] resultado;
		try{
			logger.debug("Inicio:getOficina()");
			resultado = oficinaDAO.getOficinasPorVendedor(vendedorDTO);
			logger.debug("Fin:getOficina()");
		}catch(GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new GeneralException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return resultado;
	}

}//fin class Oficina
