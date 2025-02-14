package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SegmentacionDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SegmentacionDAOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class SegmentacionBO implements SegmentacionBOIT{
private SegmentacionDAOIT segmentacionDAO  = new SegmentacionDAO();
	
	private final Logger logger = Logger.getLogger(SegmentacionBO.class);
	
	public GaSegmentacionCargosListDTO obtenerListaSegmentacionCargos (GaSegmentacionCargosDTO segCargoDTO)throws ProductException{
		GaSegmentacionCargosListDTO retValue = null;
		logger.debug("Inicio:obtenerListaSegmentacionCargosc()");
		retValue = segmentacionDAO.obtenerListaSegmentacionCargos(segCargoDTO);
		logger.debug("Fin:obtenerListaSegmentacionCargos()");
		return retValue;
	}//fin obtenerListaSegmentacionCargos

	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws ProductException {
		GedCodigosListDTO retValue = null;
		logger.debug("Inicio:obtenerListaGedCodigos()");
		retValue = segmentacionDAO.obtenerListaGedCodigos(gedCodigosDTO);
		logger.debug("Fin:obtenerListaGedCodigos()");
		return retValue;
	}
}
