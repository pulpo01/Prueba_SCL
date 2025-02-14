package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CodigoPostalDAO;


public class CodigoPostal{
	
	private CodigoPostalDAO codigoPostalDAO  = new CodigoPostalDAO();
	
	private static Category cat = Category.getInstance(Comuna.class);
	
	/**
	 * Obtiene listado de códigos postales (ZIP). No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de códigos postales
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public CodigoPostalDireccionDTO getListadoCodigosPostales(CodigoPostalDireccionDTO codigoPostalDireccionDTO) throws CustomerDomainException {
		cat.debug("getListadoCodigosPostales():start");
		CodigoPostalDireccionDTO resultado = codigoPostalDAO.getListadoCodigosPostales(codigoPostalDireccionDTO);
		cat.debug("getListadoCodigosPostales():end");
		return resultado;
	}

}
