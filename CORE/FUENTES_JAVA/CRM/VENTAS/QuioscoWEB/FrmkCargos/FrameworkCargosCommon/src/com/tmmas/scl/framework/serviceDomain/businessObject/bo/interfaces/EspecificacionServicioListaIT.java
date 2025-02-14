package com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public interface EspecificacionServicioListaIT {

	public ReglasListaNumerosListDTO obtenerReglasValidacion (EspecServicioListaDTO especServicioLista) throws ServiceSpecEntitiesException;
	
	public EspecServicioListaListDTO obtenerEspecServicioLista (EspecServicioClienteListDTO especServClieList) throws ServiceSpecEntitiesException;
	
}
