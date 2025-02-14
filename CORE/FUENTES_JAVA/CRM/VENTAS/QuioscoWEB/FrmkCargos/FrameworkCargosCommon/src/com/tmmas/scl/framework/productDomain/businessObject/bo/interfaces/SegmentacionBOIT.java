package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GaSegmentacionCargosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface SegmentacionBOIT {
	
	public GaSegmentacionCargosListDTO obtenerListaSegmentacionCargos (GaSegmentacionCargosDTO segCargoDTO)throws ProductException;
	
	public GedCodigosListDTO obtenerListaGedCodigos(GedCodigosDTO gedCodigosDTO) throws ProductException;
}
