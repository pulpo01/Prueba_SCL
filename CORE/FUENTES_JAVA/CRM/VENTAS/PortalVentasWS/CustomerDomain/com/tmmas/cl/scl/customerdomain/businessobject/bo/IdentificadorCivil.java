package com.tmmas.cl.scl.customerdomain.businessobject.bo;

import org.apache.log4j.Category;

import com.tmmas.cl.scl.crmcommon.commonapp.exception.CustomerDomainException;
import com.tmmas.cl.scl.customerdomain.businessobject.dao.IdentificadorCivilDAO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.IdentificadorCivilDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.helper.Global;

public class IdentificadorCivil {
	private IdentificadorCivilDAO identificadorDAO  = new IdentificadorCivilDAO();
	private static Category cat = Category.getInstance(IdentificadorCivil.class);
	Global global = Global.getInstance();
	
	
	/**
	 * Obtiene listado tipos de identificadores
	 * @param N/A
	 * @return IdentificadorCivilDTO[]
	 * @throws CustomerDomainException
	 */
	public IdentificadorCivilDTO[] getListTiposIdentif() 
	throws CustomerDomainException{
		cat.debug("Inicio:getListTiposIdentif()");
		IdentificadorCivilDTO[] resultado = identificadorDAO.getListTiposIdentif();
		cat.debug("Fin:getListTiposIdentif()");
		return resultado;		
	}//fin getListTiposIdentif
	
}//fin class IdentificadorCivil
