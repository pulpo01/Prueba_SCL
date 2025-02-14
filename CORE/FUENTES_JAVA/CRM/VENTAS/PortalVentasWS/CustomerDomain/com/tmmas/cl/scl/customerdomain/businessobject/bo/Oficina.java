package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.OficinaDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.OficinaDTO;

public class Oficina {
	private OficinaDAO oficinaDAO = new OficinaDAO();
	private static Category cat = Category.getInstance(Oficina.class);

	/**
	 * Obtiene oficinas SCL 
	 * @param entrada
	 * @return resultado
	 * @throws ProductDomainException
	 */
	public OficinaDTO[] getListOficinasSCL(String nombreUsuario) 
		throws CustomerDomainException
	{
		cat.debug("Inicio:getListOficinasSCL()");
		OficinaDTO[] resultado = oficinaDAO.getListOficinasSCL(nombreUsuario);
		cat.debug("Fin:getListOficinasSCL()");
		return resultado;
	}//fin getListOficinasSCL
	
	public OficinaDTO getDireccionOficina(String codOficina)
		throws CustomerDomainException
	{
		cat.debug("Inicio:getDireccionOficina()");
		OficinaDTO resultado = oficinaDAO.getDireccionOficina(codOficina);
		cat.debug("Fin:getDireccionOficina()");
		return resultado;
	}//fin getDireccionOficina

}//fin class Oficina
