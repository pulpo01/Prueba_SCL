package com.tmmas.scl.gestionlc.bo;

import com.tmmas.scl.gestionlc.bo.common.GestionLimiteConsumoAbstractBO;
import com.tmmas.scl.gestionlc.common.dto.ws.FooOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.dao.FooDAO;



public class FooBO extends GestionLimiteConsumoAbstractBO{

	FooDAO fooDAO = new FooDAO();
	
	
	public FooOutDTO foo(String p_inDTO) throws GestionLimiteConsumoException {
		
		FooOutDTO result = fooDAO.foo(p_inDTO);
		
		return result;
	}
}
