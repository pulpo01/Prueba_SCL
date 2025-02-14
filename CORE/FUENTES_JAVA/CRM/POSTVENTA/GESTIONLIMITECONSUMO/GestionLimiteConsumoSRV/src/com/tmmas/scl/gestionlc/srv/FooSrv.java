package com.tmmas.scl.gestionlc.srv;

import com.tmmas.scl.gestionlc.bo.FooBO;
import com.tmmas.scl.gestionlc.common.dto.ws.FooOutDTO;
import com.tmmas.scl.gestionlc.common.exception.GestionLimiteConsumoException;
import com.tmmas.scl.gestionlc.srv.common.GestionLimiteConsumoAbstractSRV;



public class FooSrv extends GestionLimiteConsumoAbstractSRV{

	FooBO fooBO = new FooBO(); 
	
	public FooOutDTO foo(String p_inDTO) throws GestionLimiteConsumoException {
		
		FooOutDTO result = fooBO.foo(p_inDTO);
		
		return result;
	}
}
