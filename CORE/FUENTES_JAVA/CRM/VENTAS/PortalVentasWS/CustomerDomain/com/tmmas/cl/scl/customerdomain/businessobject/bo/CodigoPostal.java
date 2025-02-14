package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.commonbusinessentities.dto.CodigoPostalDireccionDTO;
import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.CodigoPostalDAO;


public class CodigoPostal{
	
	private CodigoPostalDAO codigoPostalDAO  = new CodigoPostalDAO();
	
	private static Category cat = Category.getInstance(Comuna.class);
	
	/**
	 * Obtiene listado de c�digos postales (ZIP). No se define c�digo y descripci�n 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de c�digos postales
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
