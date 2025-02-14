package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.TipoCalleDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.TipoCalleDAO;

public class TipoCalle {
	private TipoCalleDAO tipoCalleDAO = new TipoCalleDAO(); 
	
	private static Category cat = Category.getInstance(Comuna.class);
	
	/**
	 * Obtiene listado de tipos de calles. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de tipos de calles
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public TipoCalleDireccionDTO getListadoTiposCalles() throws CustomerDomainException {
		cat.debug("getListadoTiposCalles():start");
		TipoCalleDireccionDTO resultado = tipoCalleDAO.getListadoTiposCalles();
		cat.debug("getListadoTiposCalles():end");
		return resultado;
	}
	
	
}
