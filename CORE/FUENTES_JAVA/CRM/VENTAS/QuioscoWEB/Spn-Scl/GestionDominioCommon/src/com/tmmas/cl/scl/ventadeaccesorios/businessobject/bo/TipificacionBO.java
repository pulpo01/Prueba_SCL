package com.tmmas.cl.scl.ventadeaccesorios.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dao.TipificacionDAO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificaClientizaDTO;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.TipificacionDTO;

public class TipificacionBO {
	TipificacionDAO tipificacionDAO = new TipificacionDAO();
	private static Category cat = Category.getInstance(TipificacionBO.class);
	
	public TipificacionDTO recuperaDatoTipificacion (String datoTipificacion,String codVendedor)throws GeneralException{
		TipificacionDTO tipificacionDTO = new TipificacionDTO();
		cat.debug("Inicio:recuperaDatoTipificacion()");
		tipificacionDTO = tipificacionDAO.recuperaDatoTipificacion(datoTipificacion,codVendedor);
		cat.debug("Fin:recuperaDatoTipificacion()");
		return tipificacionDTO;		
	}
	
	public String consultaKit (String datoTipificacion)throws GeneralException{
		String consulta = null;
		cat.debug("Inicio:consultaKit()");
		consulta = tipificacionDAO.consultaKit(datoTipificacion);
		cat.debug("Fin:consultaKit()");
		return consulta;		
	}
	
	public TipificacionDTO[] recuperaKit (String datoTipificacion, String codVendedor) throws GeneralException {
		TipificacionDTO[] tipificacionDTO = null;
		cat.debug("Inicio:recuperaKit()");
		tipificacionDTO = tipificacionDAO.recuperaKit(datoTipificacion,codVendedor);
		cat.debug("Fin:recuperaKit()");
		return tipificacionDTO;		
	}
	
	public void insertTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {	
		cat.debug("Inicio:insertTipificacion()");
		tipificacionDAO.insertTipificacion(tipificaClientizaDTO);
		cat.debug("Fin:insertTipificacion()");				
	}
	
	public TipificaClientizaDTO[] recuperaArrayTipificacion () throws GeneralException {
		TipificaClientizaDTO[] tipificaClientizaDTOs = null;
		cat.debug("Inicio:recuperaArrayTipificacion()");
		tipificaClientizaDTOs = tipificacionDAO.recuperaArrayTipificacion();
		cat.debug("Fin:recuperaArrayTipificacion()");
		return tipificaClientizaDTOs;		
	}
	
	public TipificaClientizaDTO recuperaTipificacion (int codArticulo) throws GeneralException {
		TipificaClientizaDTO tipificaClientizaDTO = new TipificaClientizaDTO();
		cat.debug("Inicio:recuperaTipificacion()");
		tipificaClientizaDTO = tipificacionDAO.recuperaTipificacion(codArticulo);
		cat.debug("Fin:recuperaTipificacion()");
		return tipificaClientizaDTO;		
	}
	
	public void updateTipificacion (TipificaClientizaDTO tipificaClientizaDTO) throws GeneralException {	
		cat.debug("Inicio:updateTipificacion()");
		tipificacionDAO.updateTipificacion(tipificaClientizaDTO);
		cat.debug("Fin:updateTipificacion()");				
	}
	
	public void deleteTipificacion (Long codArticulo) throws GeneralException {	
		cat.debug("Inicio:deleteTipificacion()");
		tipificacionDAO.deleteTipificacion(codArticulo);
		cat.debug("Fin:deleteTipificacion()");				
	}
	
}
