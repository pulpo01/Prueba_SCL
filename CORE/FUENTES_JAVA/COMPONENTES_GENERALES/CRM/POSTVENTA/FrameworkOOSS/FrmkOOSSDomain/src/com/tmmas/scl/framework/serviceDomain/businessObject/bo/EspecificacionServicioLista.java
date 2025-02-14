package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.base.ConnectionDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioListaIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.EspecificacionServicioListaDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioListaDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.ReglasListaNumerosListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioLista extends ConnectionDAO implements EspecificacionServicioListaIT 
{
	
	private final Logger logger = Logger.getLogger(CategoriasNumeroDestino.class);
	private Global global = Global.getInstance();
	
	EspecificacionServicioListaDAOIT espServListaDAO=new EspecificacionServicioListaDAO();
	
	
	public ReglasListaNumerosListDTO obtenerReglasValidacion(EspecServicioListaDTO especServicioLista) throws ServiceSpecEntitiesException 
	{
		ReglasListaNumerosListDTO resultado=null;
		logger.debug("Inicio:obtenerEspecificacionServicioCliente()");
		resultado = espServListaDAO.obtenerReglasValidacion(especServicioLista);
		logger.debug("Fin:obtenerEspecificacionServicioCliente()");
		return resultado;
	}


	public EspecServicioListaListDTO obtenerEspecServicioLista(EspecServicioClienteListDTO especServClieList) throws ServiceSpecEntitiesException 
	{
		EspecServicioListaListDTO resultado=null;
		logger.debug("Inicio:obtenerEspecServicioLista()");
		resultado = espServListaDAO.obtenerEspecServicioLista(especServClieList);
		logger.debug("Fin:obtenerEspecServicioLista()");
		return resultado;
	}

}
